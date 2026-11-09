pragma Ada_2022;
--  =========================================================================
--  Entitlement.Application.Port.Outbound - Parent package for outbound/output ports
--  =========================================================================
--  Copyright (c) 2025 Michael Gardner, A Bit of Help, Inc.
--  SPDX-License-Identifier: BSD-3-Clause
--
--  Purpose:
--    Parent package for outbound-facing ports (output ports).
--    Outbound ports define what external services the application needs.
--
--  Architecture Notes:
--    - Outbound ports = Entitlement.Application's REQUIRED dependencies
--    - Implemented by: Entitlement.Infrastructure layer (adapters)
--    - Entitlement.Application DEFINES the interface it needs
--    - Entitlement.Infrastructure CONFORMS to that interface
--    - This achieves DEPENDENCY INVERSION (dependencies point inward)
--
--  Design Pattern:
--    - Entitlement.Application: "I need something that can Write(message)"
--    - Entitlement.Infrastructure: "I have a ConsoleWriter that implements Write"
--    - Entitlement.Bootstrap: Wires them together via generic instantiation
--
--  See Also:
--    Entitlement.Application.Port.Outbound.Writer - Writer output port
--    Entitlement.Infrastructure.Adapter - Implementations of output ports
--  =========================================================================

package Entitlement.Application.Port.Outbound
  with Pure
is

end Entitlement.Application.Port.Outbound;
