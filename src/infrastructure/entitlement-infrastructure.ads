pragma Ada_2022;
--  =========================================================================
--  Entitlement.Infrastructure - Root package for infrastructure layer
--  =========================================================================
--  Copyright (c) 2025 Michael Gardner, A Bit of Help, Inc.
--  SPDX-License-Identifier: BSD-3-Clause
--
--  Purpose:
--    Root package for the infrastructure layer containing concrete
--    implementations of application output ports (adapters pattern).
--
--  Architecture Notes:
--    - Part of the INFRASTRUCTURE layer (outermost with Entitlement.Application)
--    - Contains ADAPTERS that implement output ports
--    - Depends on: Entitlement.Domain, Entitlement.Application (to implement their interfaces)
--    - Examples: Console writer, file I/O, database access, HTTP clients
--
--  Design Pattern:
--    ADAPTER pattern - wraps external dependencies and conforms to
--    application-defined port interfaces. Converts exceptions to Results.
--
--  See Also:
--    Entitlement.Infrastructure.Adapter - Adapter implementations
--    Entitlement.Application.Port.Outbound - Port interfaces that adapters implement
--  =========================================================================

package Entitlement.Infrastructure
  with Pure
is

end Entitlement.Infrastructure;
