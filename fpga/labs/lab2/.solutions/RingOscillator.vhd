--
-- Example VHDL implementation of a ring-oscillator using signal assignments
-- with propagation delays.
--
-- Luca Pacher - pacher@to.infn.it
-- Fall 2020
--


library IEEE ;
use IEEE.std_logic_1164.all ;   -- include extended logic values (by default VHDL only provides 0/1 with the 'bit' data type)


----------------------------
--   entity declaration   --
----------------------------
entity RingOscillator is

   port (
      start : in std_logic;
      clk   : out std_logic
   ) ;

end entity RingOscillator ;


-------------------------------------
--   architecture implementation   --
-------------------------------------
architecture rtl of RingOscillator is

   -- wires for internal connections
   signal w : std_logic_vector(4 downto 0) ;

begin

   -- implementation using signal assignments and propagation delays

   w(0) <= not (w(4) and start) after 3ns ;

   w(1) <= not w(0) after 3ns ;
   w(2) <= not w(1) after 3ns ;
   w(3) <= not w(2) after 3ns ;
   w(4) <= not w(3) after 3ns ;

   clk <= w(4) ;

end architecture rtl ;

