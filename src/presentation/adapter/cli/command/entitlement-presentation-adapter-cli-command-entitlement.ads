pragma Ada_2022;
--  =========================================================================
--  Entitlement.Presentation.Adapter.CLI.Command.Entitlement - CLI command for entitlement use case
--  =========================================================================
--  Copyright (c) 2025 Michael Gardner, A Bit of Help, Inc.
--  SPDX-License-Identifier: BSD-3-Clause
--  See LICENSE file in the project root.
--
--  Purpose:
--    Entitlement.Presentation layer command handler for entitlement use case.
--    This is the PRESENTATION layer - the outer shell handling UI concerns.
--
--  Architecture Notes:
--    - Handles user interface concerns (CLI args, output formatting)
--    - Calls APPLICATION layer use cases (through input ports)
--    - Does NOT depend on Entitlement.Infrastructure or Entitlement.Domain directly
--    - Does NOT contain business logic (delegates to use case)
--
--  Dependency Flow:
--    Entitlement_Command -> Entitlement.Application.Entitlement_UseCase
--    (calls use case)
--
--  Generic Parameter for Dependency Inversion:
--    - Takes Execute function from use case as parameter
--    - Entitlement.Bootstrap wires concrete use case instance to this command
--    - Command doesn't know about Entitlement.Infrastructure
--
--  Mapping to Go:
--    Go: presentation/adapter/cli/entitlement_command.go (EntitlementCommand struct)
--    Ada: presentation/adapter/cli/command/presentation-adapter-cli-command-entitlement.ads
--
--  Why Generic?
--    - Allows static dispatch (zero runtime overhead)
--    - Maintains dependency direction (Entitlement.Presentation ->
--      Entitlement.Application)
--
--  See Also:
--    Entitlement.Application.Usecase.Entitlement - Use case this command calls
--  =========================================================================

with Entitlement.Application.Port.Outbound.Writer;
with Entitlement.Application.Command.Entitlement;

--  ========================================================================
--  Generic Entitlement Command Package
--  ========================================================================

--  Takes the use case Execute function as a generic parameter.
--  This is the APPLICATION INPUT PORT pattern:
--  - Entitlement.Presentation calls Entitlement.Application through the input port (Execute)
--  - Entitlement.Application doesn't know about Entitlement.Presentation

generic
   with
     function Execute_Entitlement_UseCase
       (Cmd : Entitlement.Application.Command.Entitlement.Entitlement_Command)
        return Entitlement.Application.Port.Outbound.Writer.Unit_Result.Result;
package Entitlement.Presentation.Adapter.CLI.Command.Entitlement is

   --  ======================================================================
   --  Run: Execute the CLI controller logic
   --  ======================================================================

   --  Responsibilities:
   --  1. Parse command-line arguments
   --  2. Extract the name parameter
   --  3. Create EntitlementCommand DTO
   --  4. Call the use case with the DTO
   --  5. Handle the result and display appropriate messages
   --  6. Return exit code (0 = success, non-zero = error)
   --
   --  CLI Usage: entitlement <name>
   --  Example: ./entitlement Alice
   --
   --  This is where presentation concerns live:
   --  - CLI argument parsing
   --  - User-facing error messages
   --  - Exit code mapping

   function Run return Integer;

end Entitlement.Presentation.Adapter.CLI.Command.Entitlement;
