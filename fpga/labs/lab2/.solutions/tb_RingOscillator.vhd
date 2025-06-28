--
-- Example testbench module for ring-oscillator circuit.
--
-- Luca Pacher - pacher@to.infn.it
-- Spring 2020


library IEEE ;
use IEEE.std_logic_1164.all ;       -- include extended logic values (by default VHDL only provides 0/1 with the 'bit' data type)
use IEEE.std_logic_unsigned.all ;   -- to use + operator between std_logic_vector data types

library std ;
use std.env.all ;                   -- the VHDL2008 revision provides stop/finish functions similar to Verilog to end the simulation

-- WORK library (this two lines of code are always assumed also if not explicitely written)
--library work ;
--use work.all ;


entity tb_RingOscillator is 
   -- empty entity declaration for a testbench
end entity tb_RingOscillator ;


architecture testbench of tb_RingOscillator is


   signal start : std_logic := '0' ;
   signal clk : std_logic ;

   --------------------------------
   --   components declaration   --
   --------------------------------

   component RingOscillator
      port (
         start : in   std_logic ;
         clk   : out  std_logic
      ) ;
   end component ;



begin

   ---------------------------------
   --   device under test (DUT)   --
   ---------------------------------

   DUT : RingOscillator port map (start => start, clk => clk) ;

   -- another possibility is to use a more compact ENTITY INSTANTIATION (pick the compiled entity from the default WORK library)
   --DUT : entity work.RingOscillator(rtl) port map (start => start, clk => clk) ;


   -----------------------
   --   main stimulus   --
   -----------------------

   stimulus : process
   begin

      wait for  500ns ; start <= '1' ;      -- enable the circuit to oscillate
      wait for 2500ns ; start <= '0' ;      -- disable the circuit
      wait for  200ns ; finish ;

   end process ;

end architecture testbench ;

