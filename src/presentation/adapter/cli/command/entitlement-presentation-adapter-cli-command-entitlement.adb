pragma Ada_2022;
--  =========================================================================
--  Entitlement.Presentation.Adapter.CLI.Command.Entitlement - Implementation of entitlement command
--  =========================================================================
--  Copyright (c) 2025 Michael Gardner, A Bit of Help, Inc.
--  SPDX-License-Identifier: BSD-3-Clause
--
--  Purpose:
--    Implements Run function: parses CLI arguments, creates command DTO,
--    invokes use case via injected Execute function, and returns exit code.
--  =========================================================================

with Ada.Command_Line;
with Ada.Text_IO;
with Entitlement.Application.Error;
with Entitlement.Version;

package body Entitlement.Presentation.Adapter.CLI.Command.Entitlement is

   use Ada.Command_Line;
   use Ada.Text_IO;

   ---------
   -- Run --
   ---------

   function Run return Integer is
      Arg_Count : constant Natural := Ada.Command_Line.Argument_Count;
   begin
      --  Check if user provided exactly one argument (the name)
      if Arg_Count /= 1 then
         Put_Line
           (Command_Name & " v"
            & Standard.Entitlement.Version.Version);
         Put_Line ("Usage: " & Command_Name & " <name>");
         Put_Line ("Example: " & Command_Name & " Alice");
         return 1;  --  Exit code 1 indicates error

      end if;

      --  Extract the name from command-line arguments
      declare
         Name : constant String := Argument (1);

         --  Create DTO for crossing presentation -> application
         --  boundary
         Cmd : constant Entitlement.Application.Command.Entitlement.Entitlement_Command :=
           Entitlement.Application.Command.Entitlement.Create (Name);

         --  Call the use case (injected via generic parameter)
         --  This is the key architectural boundary:
         --  Entitlement.Presentation -> Entitlement.Application (through input port)
         Result :
           constant Entitlement.Application.Port.Outbound.Writer.Unit_Result.Result :=
             Execute_Entitlement_UseCase (Cmd);
      begin
         --  Handle the result from the use case
         if Entitlement.Application.Port.Outbound.Writer.Unit_Result.Is_Ok (Result) then
            --  Success! Entitlementing was displayed via console port
            --  Use case already wrote to console, just exit cleanly
            return 0;  --  Exit code 0 indicates success

         else
            --  Use case failed - display error to user
            declare
               Error_Info    : constant Entitlement.Application.Error.Error_Type :=
                 Entitlement.Application.Port.Outbound.Writer.Unit_Result.Error_Info
                   (Result);
               Error_Message : constant String :=
                 Entitlement.Application.Error.Error_Strings.To_String
                   (Error_Info.Message);
            begin
               --  Display user-friendly error message
               Put_Line ("Error: " & Error_Message);

               --  Add detailed error handling based on Error_Kind
               case Error_Info.Kind is
                  when Entitlement.Application.Error.Validation_Error =>
                     Put_Line ("Please provide a valid name.");

                  when Entitlement.Application.Error.Parse_Error =>
                     Put_Line ("Input could not be parsed.");

                  when Entitlement.Application.Error.Not_Found_Error =>
                     Put_Line ("The requested resource was not found.");

                  when Entitlement.Application.Error.IO_Error =>
                     Put_Line ("An I/O error occurred.");

                  when Entitlement.Application.Error.Internal_Error =>
                     Put_Line ("An internal error occurred.");
               end case;

               return 1;  --  Exit code 1 indicates error
            end;
         end if;
      end;
   end Run;

end Entitlement.Presentation.Adapter.CLI.Command.Entitlement;
