pragma Ada_2022;
--  =========================================================================
--  Entitlement.Application.Usecase.Entitlement - Entitlement use case orchestration
--  =========================================================================
--  Copyright (c) 2025 Michael Gardner, A Bit of Help, Inc.
--  SPDX-License-Identifier: BSD-3-Clause
--  See LICENSE file in the project root.
--
--  Purpose:
--    Use case orchestrating the entitlementing workflow. This is application-
--    specific business logic orchestration. Coordinates domain objects
--    (Person) and depends on output ports (Console) without knowing
--    implementation details.
--
--  Architecture Notes:
--    - Use case = application business logic orchestration
--    - Coordinates domain objects
--    - Depends on output ports defined in application layer
--    - Never imports infrastructure layer
--
--  Dependency Flow (all pointing INWARD toward Entitlement.Domain):
--    Entitlement_Use_Case -> Entitlement.Domain.Value_Object.Person
--    Entitlement_Use_Case -> Entitlement.Application.Port.Out.Writer
--    (port interface)
--    Entitlement.Infrastructure.Console_Adapter -> Entitlement.Application.Port.Out.Writer
--    (implements)
--    - Takes Console_Write function as generic parameter
--    - Entitlement.Infrastructure provides the implementation
--    - Entitlement.Bootstrap wires them together
--
--  See Also:
--    Entitlement.Domain.Value_Object.Person - Person value object
--    Entitlement.Application.Port.Out.Writer - Output port interface
--  =========================================================================

with Entitlement.Application.Port.Outbound.Writer;
with Entitlement.Application.Command.Entitlement;

--  ========================================================================
--  Generic Use Case Package
--  ========================================================================

--  This generic package is instantiated with a console output port.
--  The port is provided by infrastructure, injected at instantiation time.
--
--  This demonstrates STATIC DEPENDENCY INJECTION via generics:
--  - No runtime overhead (compared to interface dispatch)
--  - Compile-time verification of port compatibility
--  - Dependencies still point inbound (Entitlement.Application doesn't import
--    Entitlement.Infrastructure)

generic
   with
     function Writer
       (Message : String)
        return Entitlement.Application.Port.Outbound.Writer.Unit_Result.Result;
package Entitlement.Application.Usecase.Entitlement with Preelaborate is

   --  ======================================================================
   --  Execute: Run the entitlementing use case
   --  ======================================================================

   --  Orchestration workflow:
   --  1. Extract name from EntitlementCommand DTO
   --  2. Validate and create Person from name (domain validation)
   --  3. Generate entitlementing message (application-level formatting)
   --  4. Write entitlementing to console via output port
   --  5. Propagate any errors via railway-oriented programming
   --
   --  Input: EntitlementCommand DTO crossing presentation -> application boundary
   --
   --  Error scenarios:
   --  - Validation_Error: Invalid person name (empty, too long)
   --  - IO_Error: Console write failure (rare, but possible)

   function Execute
     (Cmd : Entitlement.Application.Command.Entitlement.Entitlement_Command)
      return Entitlement.Application.Port.Outbound.Writer.Unit_Result.Result;

end Entitlement.Application.Usecase.Entitlement;
