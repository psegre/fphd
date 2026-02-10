--
-- A simple MUX_Inverter (NOT gate) in VHDL
-- 


library IEEE ;
use IEEE.std_logic_1164.all ;   -- include extended logic values (by default VHDL only provides 0/1 with the 'bit' data type)


-- entity declaration
entity MUX_Inverter is

   port (
      X  : in  std_logic ;
      ZN : out std_logic
   ) ;

end entity MUX_Inverter ;


-- architecture implementation
architecture rtl of MUX_Inverter is

begin

   -- signal assignment
   ZN <= '0' when X = '1' else '1' ;

end architecture rtl ;
