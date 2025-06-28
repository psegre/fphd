--
-- Simple testbench for the Inverter module
--
-- Luca Pacher - pacher@to.infn.it
-- Fall 2020
--

library IEEE ;
use IEEE.std_logic_1164.all ;   -- include extended logic values (by default VHDL only provides 0/1 with the 'bit' data type)

library std ;
use std.env.all ;               -- the VHDL2008 revision provides stop/finish functions similar to Verilog to end the simulation

-- WORK library (this two lines of code are always assumed also if not explicitely written)
--library work ;
--use work.all ;


entity tb_Inverter is   -- empty entity declaration for a testbench
end entity tb_Inverter ;


architecture testbench of tb_Inverter is

   --------------------------------
   --   components declaration   --
   --------------------------------

   component Inverter
      port (
         X  : in  std_logic ;
         ZN : out std_logic
      ) ;
   end component ;


   --------------------------
   --   internal signals   --
   --------------------------

   signal X  : std_logic ;
   signal ZN : std_logic ;

   -- **EXTRA: instantiate and simulate a 3-state buffer
   --signal enable : std_logic := '0' ;
   --signal triOut :std_logic ;

begin


   ---------------------------------
   --   device under test (DUT)   --
   ---------------------------------

   -- COMPONENT INSTANTIATION (needs component declaration beffore the begin)

   --DUT : Inverter port map (X, ZN) ;            -- ORDERED (positional) port mapping
   DUT : Inverter port map (X => X, ZN => ZN) ;   -- BY-NAME port mapping

   -- another possibility is to use the sa called ENTITY INSTANTIATION (pick the compiled entity from the default work library)
   --DUT : entity work.Inverter(rtl)  port map (X => X, ZN => ZN) ;

   -----------------------
   --   main stimulus   --
   -----------------------

   stimulus : process
   begin
   
      wait for 500 ns ; X <= '0' ;
      wait for 200 ns ; X <= '1' ;
      wait for 750 ns ; X <= '0' ;

      wait for 500 ns ; finish ;     -- stop the simulation (this is a VHDL2008-only feature)

      -- **IMPORTANT: the original VHDL93 standard does not provide a routine to easily stop the simulation ! You must use a failing "assertion" for this purpose
      --wait for 500 ns ; assert FALSE report "Simulation Finished" severity FAILURE ;

   end process ;

   --
   -- **EXTRA: instantiate and simulate a 3-state buffer
   --
   --
   --DUT_2 : entity work.BufferTri port map (X => ZN, OE => enable, ZT => triOut ) ;
   --
   -- **IMPORTANT: this initial block runs IN PARALLEL with the previous block  => HDL coding is intrinsically PARALLEL PROGRAMMING
   --stimulus2 : process
   --begin
   --   wait for  750ns ; enable <= '1' ;
   --   wait for 1200ns ; enable <= '0' ;
   --end process ;
   --

end architecture testbench ;

