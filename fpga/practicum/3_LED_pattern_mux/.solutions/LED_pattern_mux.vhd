----------------------------------------------------------------------------------
--
-- **EXTRA: Example VHDL implementation of a 2:1 MUX using when/else statements.
--          Required for the STRUCTURAL code (schematic) implementation.
--
-- Luca Pacher - pacher@to.infn.it
-- Spring 2025
--
----------------------------------------------------------------------------------

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


----------------------------------------------------------------------------------
--
-- Simple MUX-design to selectively turn-on LD7-LD5 and LD6-LD4 available
-- on the Digilent Arty board.
--
-- Luca Pacher - pacher@to.infn.it
-- Spring 2025
--
----------------------------------------------------------------------------------


library IEEE ;
use IEEE.std_logic_1164.all ;   -- include extended logic values (by default VHDL only provides 0/1 with the 'bit' data type)


----------------------------
--   entity declaration   --
----------------------------
entity LED_pattern_mux is

   port (
      sel : in  std_logic ;                       -- control switch (e.g. slide-switch SW0)
      LED : out std_logic_vector(3 downto 0)      -- output LEDs
   ) ;

end entity LED_pattern_mux ;


-------------------------------------
--   architecture implementation   --
-------------------------------------
architecture rtl of LED_pattern_mux is

begin


   -----------------------------------------------------------------------
   --   MUX-like behavioral implementation using when/else statements   --
   -----------------------------------------------------------------------

--   LED <= "1010" when sel = '0' else
--          "0101" when sel = '1' else
--          "XXXX" ;
--

   -----------------------------------------------------
   --   logic equations as derived from truth-table   --
   -----------------------------------------------------

--   LED(3) <= not sel ;
--   LED(2) <=     sel ;
--   LED(1) <= not sel ;
--   LED(0) <=     sel ;


   --------------------------------------------------------------
   --   STRUCTURAL code (schematic) using 2:1 MUX components   --
   --------------------------------------------------------------

   MUX_3 : entity work.MUX2(rtl) port map(A => '1' , B => '0' , S => sel, Z => LED(3)) ; 
   MUX_2 : entity work.MUX2(rtl) port map(A => '0' , B => '1' , S => sel, Z => LED(2)) ; 
   MUX_1 : entity work.MUX2(rtl) port map(A => '1' , B => '0' , S => sel, Z => LED(1)) ; 
   MUX_0 : entity work.MUX2(rtl) port map(A => '0' , B => '1' , S => sel, Z => LED(0)) ; 

end architecture rtl ;

