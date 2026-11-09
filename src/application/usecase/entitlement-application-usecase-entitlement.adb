pragma Ada_2022;
--  =========================================================================
--  Entitlement.Application.Usecase.Entitlement - Implementation of entitlementing use case
--  =========================================================================
--  Copyright (c) 2025 Michael Gardner, A Bit of Help, Inc.
--  SPDX-License-Identifier: BSD-3-Clause
--
--  Purpose:
--    Implements Execute function: validates Person, formats entitlementing message,
--    and writes output via injected Writer port using railway-oriented flow.
--  =========================================================================

with Entitlement.Domain.Error;
with Entitlement.Domain.Value_Object.Person;

package body Entitlement.Application.Usecase.Entitlement is

   use Entitlement.Application.Port.Outbound.Writer;

   ---------------------
   -- Format_Entitlementing --
   ---------------------

   --  Application-level entitlementing format (orchestration, not domain logic)
   --  The format "Hello, <name>!" is an application decision
   function Format_Entitlementing (Name : String) return String is
   begin
      return "Hello, " & Name & "!";
   end Format_Entitlementing;

   -------------
   -- Execute --
   -------------

   function Execute
     (Cmd : Entitlement.Application.Command.Entitlement.Entitlement_Command)
      return Entitlement.Application.Port.Outbound.Writer.Unit_Result.Result
   is
      --  Step 1: Extract name from DTO
      Name : constant String := Entitlement.Application.Command.Entitlement.Get_Name (Cmd);

      --  Step 2: Validate and create Person from name (domain validation)
      Person_Result :
        constant Entitlement.Domain.Value_Object.Person.Person_Result.Result :=
          Entitlement.Domain.Value_Object.Person.Create (Name);
   begin
      --  Check if person creation failed (railway-oriented programming)
      if Entitlement.Domain.Value_Object.Person.Person_Result.Is_Error (Person_Result) then
         --  Propagate validation error to caller
         declare
            Error_Info : constant Entitlement.Domain.Error.Error_Type :=
              Entitlement.Domain.Value_Object.Person.Person_Result.Error_Info
                (Person_Result);
         begin
            return
              Unit_Result.Error
                (Kind    => Error_Info.Kind,
                 Message =>
                   Entitlement.Domain.Error.Error_Strings.To_String (Error_Info.Message));
         end;
      end if;

      --  Extract validated Person
      declare
         Person : constant Entitlement.Domain.Value_Object.Person.Person :=
           Entitlement.Domain.Value_Object.Person.Person_Result.Value (Person_Result);

         --  Step 3: Generate entitlementing message (application-level formatting)
         Message : constant String :=
           Format_Entitlementing (Entitlement.Domain.Value_Object.Person.Get_Name (Person));

         --  Step 4: Write to console via output port (injected dependency)
         Write_Result : constant Unit_Result.Result := Writer (Message);
      begin
         --  Propagate result (success or failure) to caller
         return Write_Result;
      end;
   end Execute;

end Entitlement.Application.Usecase.Entitlement;
