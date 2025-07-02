--
-- Describe basic logic gates in VHDL using signal assignments and logic operators.
--
-- Luca Pacher - pacher@to.infn.it
-- Fall 2020
--


library IEEE ;
use IEEE.std_logic_1164.all ;   -- include extended logic values (by default VHDL only provides 0/1 with the 'bit' data type)

--library UNISIM ;              -- library required to instantiate and simulate Xilinx FPGA device primitives
--use UNISIM.vcomponents.all ;

entity Gates is

   port (
      A : in  std_logic ;
      B : in  std_logic ;
      Z : out std_logic_vector(5 downto 0)   -- note that Z is declared as a 6-bit width output BUS
   ) ;

end entity Gates ;


architecture rtl of Gates is

--   signal A_int : std_logic ;
--   signal B_int : std_logic ;

--   component IBUF is
--      port (
--         I : in  std_logic ;
--         O : out std_logic
--      ) ;
--   end component ;


begin

   Z(0) <= A and  B ;
   Z(1) <= A nand B ;
   Z(2) <= A or   B ;
   Z(3) <= A nor  B ;
   Z(4) <= A xor  B ;
   Z(5) <= A xnor B ;


--   IBUF_A : IBUF port map( I => A, O => A_int ) ;
--   IBUF_B : IBUF port map( I => B, O => B_int ) ;
--
--   Z(0) <= A_int and  B_int ;
--   Z(1) <= A_int nand B_int ;
--   Z(2) <= A_int or   B_int ;
--   Z(3) <= A_int nor  B_int ;
--   Z(4) <= A_int xor  B_int ;
--   Z(5) <= A_int xnor B_int ;

end architecture rtl ;

