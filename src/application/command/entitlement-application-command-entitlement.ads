pragma Ada_2022;
--  =========================================================================
--  Entitlement.Application.Command.Entitlement - DTO for entitlement use case
--  =========================================================================
--  Copyright (c) 2025 Michael Gardner, A Bit of Help, Inc.
--  SPDX-License-Identifier: BSD-3-Clause
--  See LICENSE file in the project root.
--
--  Purpose:
--    Data Transfer Object (DTO) for the entitlement use case. DTOs cross
--    architectural boundaries and should be simple, serializable data
--    structures with no business logic.
--
--  Educational Notes:
--    - No business logic in DTOs
--    - DTOs are different from domain entities
--    - This separates external API from internal domain model
--    - Crosses boundary: Entitlement.Presentation -> Entitlement.Application
--
--  Mapping to Go:
--    Go: application/port/entitlement_command.go
--    type EntitlementCommand struct { Name string }
--
--  See Also:
--    Entitlement.Domain.Value_Object.Person - Entitlement.Domain entity (different from DTO)
--  =========================================================================

with Ada.Strings.Bounded;

package Entitlement.Application.Command.Entitlement
  with Preelaborate
is

   --  Maximum name length for DTO boundary (larger than domain constraint).
   --  DTO accepts up to 256 chars; Entitlement.Domain validates and rejects > 100 chars.
   --  This intentional boundary isolation:
   --    1. Allows Entitlement.Domain to shrink constraints without breaking Command
   --    2. Defense in depth (two validation points)
   --    3. SPARK-compatible (bounded strings throughout)
   Max_DTO_Name_Length : constant := 256;

   --  Bounded string for name in DTO. The DTO itself does not enforce
   --  validity rules; domain logic is responsible for validation.
   --  Named after parent package per Ada agent naming convention
   package Entitlement_Strings is new
     Ada.Strings.Bounded.Generic_Bounded_Length (Max => Max_DTO_Name_Length);

   --  ========================================================================
   --  Entitlement_Command DTO
   --  ========================================================================

   --  Data Transfer Object for entitlement use case.
   --  Simple data structure that crosses presentation -> application
   --  boundary. It may carry invalid data; the domain layer is responsible
   --  for validating the name and returning appropriate Result errors.

   type Entitlement_Command is record
      Name : Entitlement_Strings.Bounded_String;
   end record;

   --  Helper function to create DTO from String. This function does not
   --  perform validation; it simply packages the raw input. Validation is
   --  performed in Entitlement.Domain.Value_Object.Person.Create via Result.
   function Create (Name : String) return Entitlement_Command;

   --  Helper function to extract name as String
   function Get_Name (Cmd : Entitlement_Command) return String;

end Entitlement.Application.Command.Entitlement;
