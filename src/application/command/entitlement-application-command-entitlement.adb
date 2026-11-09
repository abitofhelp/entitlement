pragma Ada_2022;
--  =========================================================================
--  Entitlement.Application.Command.Entitlement - Implementation of DTO helpers
--  =========================================================================
--  Copyright (c) 2025 Michael Gardner, A Bit of Help, Inc.
--  SPDX-License-Identifier: BSD-3-Clause
--
--  Purpose:
--    Implements factory function Create and accessor Get_Name for the
--    Entitlement_Command DTO used to pass data between presentation and use case.
--  =========================================================================

package body Entitlement.Application.Command.Entitlement is

   use Entitlement_Strings;

   ------------
   -- Create --
   ------------

   function Create (Name : String) return Entitlement_Command is
   begin
      return (Name => To_Bounded_String (Name));
   end Create;

   --------------
   -- Get_Name --
   --------------

   function Get_Name (Cmd : Entitlement_Command) return String is
   begin
      return To_String (Cmd.Name);
   end Get_Name;

end Entitlement.Application.Command.Entitlement;
