pragma Ada_2022;
--  =========================================================================
--  Entitlement.Application.Usecase - Parent package for use cases
--  =========================================================================
--  Copyright (c) 2025 Michael Gardner, A Bit of Help, Inc.
--  SPDX-License-Identifier: BSD-3-Clause
--
--  Purpose:
--    Parent package for application use cases (application services).
--    Use cases orchestrate domain logic and coordinate infrastructure.
--
--  Architecture Notes:
--    - Part of the APPLICATION layer
--    - Use cases = Entitlement.Application business logic orchestration
--    - Depends on: Entitlement.Domain (for entities/logic), Ports (for I/O)
--    - Does NOT depend on: Entitlement.Infrastructure or Entitlement.Presentation
--    - Use cases ARE the inbound ports (application's public API)
--
--  Design Pattern:
--    Use case pattern from Clean Architecture:
--    1. Accept command DTO from presentation
--    2. Orchestrate domain objects
--    3. Call output ports for side effects
--    4. Return Result to presentation
--
--  See Also:
--    Entitlement.Application.Usecase.Entitlement - Example use case
--    Entitlement.Application.Command - DTOs passed to use cases
--  =========================================================================

package Entitlement.Application.Usecase
  with Pure
is

end Entitlement.Application.Usecase;
