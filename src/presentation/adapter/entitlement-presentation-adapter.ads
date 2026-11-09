pragma Ada_2022;
--  =========================================================================
--  Entitlement.Presentation.Adapter - Parent package for presentation adapters
--  =========================================================================
--  Copyright (c) 2025 Michael Gardner, A Bit of Help, Inc.
--  SPDX-License-Identifier: BSD-3-Clause
--
--  Purpose:
--    Parent package for presentation layer adapters (driving adapters).
--    Contains UI-specific implementations that drive the application.
--
--  Architecture Notes:
--    - Part of the PRESENTATION layer (driving/inbound adapters)
--    - Adapters translate user interactions to application calls
--    - Examples: CLI, REST API, GUI, gRPC handlers
--    - Depends on: Entitlement.Application layer ONLY (not Entitlement.Domain directly)
--
--  Design Pattern:
--    Driving Adapter pattern (Hexagonal Architecture):
--    - User interactions enter through presentation adapters
--    - Adapters call application use cases
--    - Results formatted for specific UI needs
--
--  See Also:
--    Entitlement.Presentation.Adapter.CLI - Command-line interface adapter
--  =========================================================================

package Entitlement.Presentation.Adapter
  with Preelaborate
is

end Entitlement.Presentation.Adapter;
