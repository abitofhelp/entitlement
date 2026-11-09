pragma Ada_2022;
--  =========================================================================
--  Entitlement.Application.Error - Error type facade for outer layers
--  =========================================================================
--  Copyright (c) 2025 Michael Gardner, A Bit of Help, Inc.
--  SPDX-License-Identifier: BSD-3-Clause
--
--  Purpose:
--    Re-exports Entitlement.Domain.Error types for use by Entitlement.Presentation layer.
--    Maintains architectural boundary: Entitlement.Presentation -> Entitlement.Application
--    -> Entitlement.Domain
--  Architecture Notes:
--    - Part of the APPLICATION layer (orchestration/contract layer)
--    - Re-exports Entitlement.Domain error types without wrapping (zero overhead)
--    - Allows Entitlement.Presentation to access error types without depending on Entitlement.Domain
--    - Entitlement.Infrastructure may use Entitlement.Domain.Error directly (it's allowed)
--
--  Why This Exists:
--    In our hybrid architecture:
--    - Entitlement.Domain is the only shareable layer across applications
--    - Entitlement.Application/Entitlement.Infrastructure/Entitlement.Presentation/Entitlement.Bootstrap are app-specific
--    - Entitlement.Presentation must NOT depend on Entitlement.Domain directly (to prevent coupling)
--    - Entitlement.Application acts as the contract/facade layer for Entitlement.Presentation
--
--  Usage (Entitlement.Presentation layer):
--    with Entitlement.Application.Error;  -- NOT with Entitlement.Domain.Error
--
--    use Entitlement.Application.Error;
--
--    Error : constant Error_Type := ...
--    case Error.Kind is
--       when Validation_Error => ...
--       when Parse_Error => ...
--       when Not_Found_Error => ...
--       when IO_Error => ...
--       when Internal_Error => ...
--    end case;
--
--  See Also:
--    Entitlement.Domain.Error - The canonical error type definitions
--    Entitlement.Application.Port.Outbound.Writer - Uses Result[Unit] with these errors
--  =========================================================================

with Entitlement.Domain.Error;

package Entitlement.Application.Error
  with Preelaborate
is

   --  =======================================================================
   --  Re-exported Types from Entitlement.Domain.Error
   --  =======================================================================

   --  Bounded string package for error messages
   package Error_Strings renames Entitlement.Domain.Error.Error_Strings;

   --  Error categories
   subtype Error_Kind is Entitlement.Domain.Error.Error_Kind;

   --  Bring Error_Kind values into scope for convenience
   Validation_Error : constant Error_Kind := Entitlement.Domain.Error.Validation_Error;
   Parse_Error      : constant Error_Kind := Entitlement.Domain.Error.Parse_Error;
   Not_Found_Error  : constant Error_Kind := Entitlement.Domain.Error.Not_Found_Error;
   IO_Error         : constant Error_Kind := Entitlement.Domain.Error.IO_Error;
   Internal_Error   : constant Error_Kind := Entitlement.Domain.Error.Internal_Error;

   --  Concrete error record (kind + message)
   subtype Error_Type is Entitlement.Domain.Error.Error_Type;

end Entitlement.Application.Error;
