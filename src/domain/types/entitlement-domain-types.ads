pragma Ada_2022;
--  =========================================================================
--  Entitlement.Domain.Types - Parent package for domain utility types
--  =========================================================================
--  Copyright (c) 2025 Michael Gardner, A Bit of Help, Inc.
--  SPDX-License-Identifier: BSD-3-Clause
--
--  Purpose:
--    Parent package for generic utility types used within the domain layer.
--    These are computational patterns (monads, containers) that support
--    domain logic but are not themselves domain concepts.
--
--  Architecture Notes:
--    - Part of the DOMAIN layer
--    - Contains generic utility types (Option, etc.)
--    - Distinguished from value_object which contains domain concepts
--    - Pure implementation with no external dependencies
--
--  Contents:
--    Entitlement.Domain.Types.Option - Option/Maybe monad for optional values
--
--  See Also:
--    Entitlement.Domain.Value_Object - Domain-specific value objects
--    Entitlement.Domain.Error.Result - Result monad for error handling
--  =========================================================================

package Entitlement.Domain.Types
  with Pure
is

end Entitlement.Domain.Types;
