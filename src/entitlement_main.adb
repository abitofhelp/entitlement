pragma Ada_2022;
--  =========================================================================
--  Entitlement_Main - Main Program Entry Point
--  =========================================================================
--  Copyright (c) 2025 Michael Gardner, A Bit of Help, Inc.
--  SPDX-License-Identifier: BSD-3-Clause
--
--  Purpose:
--    Main program entry point for the entitlement CLI application.
--    Delegates all work to Entitlement.Bootstrap.CLI composition root.
--
--  Architecture:
--    Hybrid DDD/Clean/Hexagonal Architecture with 5 layers:
--    1. Entitlement.Domain - Pure business logic (innermost, zero dependencies)
--    2. Entitlement.Application - Use cases and ports (depends on Entitlement.Domain only)
--    3. Entitlement.Infrastructure - Adapters implementing output ports
--    4. Entitlement.Presentation - User interfaces (CLI, Web, etc.)
--    5. Entitlement.Bootstrap - Composition root wiring all layers together
--
--  Design Principles:
--    - Dependency Inversion: Dependencies point inbound toward Entitlement.Domain
--    - Static DI: Generic instantiation for zero-runtime-cost injection
--    - Railway-Oriented Programming: Result monad for error handling
--    - Ports & Adapters: Entitlement.Application defines interfaces,Entitlement.Infrastructure conform
--
--  Main Responsibilities:
--    - Entry point (kept minimal)
--    - Delegates to Entitlement.Bootstrap.CLI.Run
--    - Sets OS exit code
--
--  See Also:
--    Entitlement.Bootstrap.CLI - Composition root that wires all layers
--  =========================================================================

with Ada.Command_Line;
with Entitlement.Bootstrap.CLI;

procedure Entitlement_Main is

   --  Exit code to return to OS (0 = success, non-zero = error)
   Exit_Code : Integer;

begin
   --  ======================================================================
   --  Entitlement.Bootstrap and run the CLI application
   --  ======================================================================

   --  Call Entitlement.Bootstrap.CLI to:
   --  1. Instantiate all generic packages (dependency injection)
   --  2. Wire all layers together
   --  3. Execute the application
   --  4. Return exit code

   Exit_Code := Entitlement.Bootstrap.CLI.Run;

   --  ======================================================================
   --  Set the OS exit code and return
   --  ======================================================================

   Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Exit_Status (Exit_Code));

end Entitlement_Main;
