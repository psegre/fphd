--
-- A simple BufferTri (NOT gate) in VHDL
-- 


library IEEE ;
use IEEE.std_logic_1164.all ;   -- include extended logic values (by default VHDL only provides 0/1 with the 'bit' data type)


-- entity declaration
entity BufferTri is

   port (
      X  : in  std_logic ;
      ZN : out std_logic
   ) ;

end entity BufferTri ;


-- architecture implementation
architecture rtl of BufferTri is

begin

   -- signal assignment
   ZT <= X when OE = '1' else 'z' ;

end architecture rtl ;
