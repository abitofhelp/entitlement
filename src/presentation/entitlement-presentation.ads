pragma Ada_2022;
--  =========================================================================
--  Entitlement.Presentation - Root package for presentation layer
--  =========================================================================
--  Copyright (c) 2025 Michael Gardner, A Bit of Help, Inc.
--  SPDX-License-Identifier: BSD-3-Clause
--
--  Purpose:
--    Root package for the presentation layer containing user interfaces
--    (CLI, Web, API, etc.). This is the OUTERMOST layer users interact with.
--
--  Architecture Notes:
--    - Part of the PRESENTATION layer (outermost)
--    - Handles UI concerns: argument parsing, formatting, error display
--    - Calls application layer use cases (through inbound ports)
--    - Does NOT contain business logic (delegates to application)
--    - Does NOT depend on Entitlement.Infrastructure (only Entitlement.Application)
--
--  Design Pattern:
--    Entitlement.Presentation layer in Clean Architecture / Hexagonal Architecture.
--    Thin layer that translates user actions into use case calls.
--
--  See Also:
--    Entitlement.Presentation.Adapter - Driving adapters (CLI, REST, etc.)
--    Entitlement.Presentation.Adapter.CLI - Command-line interface implementation
--    Entitlement.Application.Usecase - Use cases called by presentation
--  =========================================================================

package Entitlement.Presentation
  with Preelaborate
is

end Entitlement.Presentation;
