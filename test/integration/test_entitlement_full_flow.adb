pragma Ada_2022;
--  ======================================================================
--  Test_Entitlement_Full_Flow
--  ======================================================================
--  Copyright (c) 2025 Michael Gardner, A Bit of Help, Inc.
--  SPDX-License-Identifier: BSD-3-Clause
--
--  Purpose:
--    Integration test for complete entitlementing flow across all layers.
--    Tests Entitlement.Infrastructure → Entitlement.Application → Entitlement.Domain integration.
--  ======================================================================

with Ada.Text_IO;
with Entitlement.Application.Command.Entitlement;
with Entitlement.Application.Port.Outbound.Writer;
with Entitlement.Application.Usecase.Entitlement;
with Entitlement.Domain.Value_Object.Person;
with Entitlement.Infrastructure.Adapter.Console_Writer;
with Test_Framework;

procedure Test_Entitlement_Full_Flow is

   use Ada.Text_IO;
   use Entitlement.Application.Command.Entitlement;
   use Entitlement.Application.Port.Outbound.Writer;
   use Entitlement.Domain.Value_Object.Person;

   --  Test statistics
   Total_Tests  : Natural := 0;
   Passed_Tests : Natural := 0;

   --  Helper procedure to run a test
   pragma Style_Checks (Off);
   procedure Run_Test (Name : String; Passed : Boolean) is
   begin
      Total_Tests := Total_Tests + 1;
      if Passed then
         Passed_Tests := Passed_Tests + 1;
         Test_Framework.Print_Pass (Name);
      else
         Test_Framework.Print_Fail (Name);
      end if;
   end Run_Test;
   pragma Style_Checks (On);

   --  ========================================================================
   --  Wire Entitlement.Infrastructure adapter to Entitlement.Application port (DI via generics)
   --  ========================================================================

   package Writer_Port_Instance is new
     Entitlement.Application.Port.Outbound.Writer.Generic_Writer
       (Write => Entitlement.Infrastructure.Adapter.Console_Writer.Write);

   --  Instantiate use case with real console writer
   package Entitlement_UseCase_Instance is new Entitlement.Application.Usecase.Entitlement
     (Writer => Writer_Port_Instance.Write_Message);

begin
   Put_Line ("========================================");
   Put_Line ("Testing: Full Entitlement Flow (Integration)");
   Put_Line ("========================================");
   New_Line;

   --  ========================================================================
   --  Test: Execute with valid name (full stack)
   --  ========================================================================

   declare
      Cmd    : constant Entitlement_Command := Create ("Alice");
      Result : constant Unit_Result.Result :=
        Entitlement_UseCase_Instance.Execute (Cmd);
   begin
      Run_Test
        ("Full flow - valid name returns Ok",
         Unit_Result.Is_Ok (Result));
      --  Output "Hello, Alice!" should be printed to console
   end;

   --  ========================================================================
   --  Test: Execute with name containing spaces
   --  ========================================================================

   declare
      Cmd    : constant Entitlement_Command := Create ("Bob Smith");
      Result : constant Unit_Result.Result :=
        Entitlement_UseCase_Instance.Execute (Cmd);
   begin
      Run_Test
        ("Full flow - name with spaces returns Ok",
         Unit_Result.Is_Ok (Result));
      --  Output "Hello, Bob Smith!" should be printed
   end;

   --  ========================================================================
   --  Test: Execute with special characters
   --  ========================================================================

   declare
      Cmd    : constant Entitlement_Command := Create ("Anne-Marie O'Brien");
      Result : constant Unit_Result.Result :=
        Entitlement_UseCase_Instance.Execute (Cmd);
   begin
      Run_Test
        ("Full flow - special chars returns Ok",
         Unit_Result.Is_Ok (Result));
      --  Output "Hello, Anne-Marie O'Brien!" should be printed
   end;

   --  ========================================================================
   --  Test: Execute with Unicode characters
   --  ========================================================================

   declare
      Cmd    : constant Entitlement_Command := Create ("José María");
      Result : constant Unit_Result.Result :=
        Entitlement_UseCase_Instance.Execute (Cmd);
   begin
      Run_Test
        ("Full flow - Unicode returns Ok",
         Unit_Result.Is_Ok (Result));
      --  Output "Hello, José María!" should be printed
   end;

   --  ========================================================================
   --  Test: Multiple executions (stateless behavior)
   --  ========================================================================

   declare
      Cmd1    : constant Entitlement_Command := Create ("First");
      Result1 : constant Unit_Result.Result :=
        Entitlement_UseCase_Instance.Execute (Cmd1);

      Cmd2    : constant Entitlement_Command := Create ("Second");
      Result2 : constant Unit_Result.Result :=
        Entitlement_UseCase_Instance.Execute (Cmd2);

      Cmd3    : constant Entitlement_Command := Create ("Third");
      Result3 : constant Unit_Result.Result :=
        Entitlement_UseCase_Instance.Execute (Cmd3);
   begin
      Run_Test
        ("Multiple executions - first Ok",
         Unit_Result.Is_Ok (Result1));
      Run_Test
        ("Multiple executions - second Ok",
         Unit_Result.Is_Ok (Result2));
      Run_Test
        ("Multiple executions - third Ok",
         Unit_Result.Is_Ok (Result3));
   end;

   --  ========================================================================
   --  Test: Max length name
   --  ========================================================================

   declare
      Max_Name : constant String (1 .. Max_Name_Length) := [others => 'X'];
      Cmd      : constant Entitlement_Command := Create (Max_Name);
      Result   : constant Unit_Result.Result :=
        Entitlement_UseCase_Instance.Execute (Cmd);
   begin
      Run_Test
        ("Full flow - max length name returns Ok",
         Unit_Result.Is_Ok (Result));
   end;

   --  Print summary
   New_Line;
   Put_Line ("========================================");
   Put_Line ("Test Summary: Full Entitlement Flow");
   Put_Line ("========================================");
   Put_Line ("Total tests: " & Total_Tests'Image);
   Put_Line ("Passed:      " & Passed_Tests'Image);
   Put_Line ("Failed:      " & Natural'Image (Total_Tests - Passed_Tests));
   New_Line;

   --  Register results with test framework
   Test_Framework.Register_Results (Total_Tests, Passed_Tests);

end Test_Entitlement_Full_Flow;
