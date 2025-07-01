
library IEEE ;
use IEEE.std_logic_1164.all ;

entity MUX2 is

   port(

      A : in  std_logic ;
      B : in  std_logic ;
      S : in  std_logic ;
      Z : out std_logic
   ) ;

end entity MUX2 ;

architecture rtl of MUX2 is

begin

   Z <= A when S = '0' else
        B when S = '1' else
        'X' ;

end architecture rtl ;

