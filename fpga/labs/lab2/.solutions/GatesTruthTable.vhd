--
-- Implement basic logic gates in terms of truth tables using 'when/else' statements
--
-- Luca Pacher - pacher@to.infn.it
-- Fall 2020
--


library IEEE ;
use IEEE.std_logic_1164.all ;   -- include extended logic values (by default VHDL only provides 0/1 with the 'bit' data type)


----------------------------
--   entity declaration   --
----------------------------
entity Gates is

   port (
      A : in  std_logic ;
      B : in  std_logic ;
      Z : out std_logic_vector(5 downto 0)   -- note that Z is declared as a 6-bit width output BUS
   ) ;

end entity Gates ;


-------------------------------------
--   architecture implementation   --
-------------------------------------
architecture rtl of Gates is

   --signal AB : std_logic_vector(1 downto 0) ;

begin

   Z <= "101010" when A = '0' and B = '0' else
        "010110" when A = '0' and B = '1' else
        "010110" when A = '1' and B = '0' else
        "100101" when A = '1' and B = '1' else 
        "XXXXXX" ;   -- catch-all


   -- alternatively a software-like 'case' statement can be used within a 'process' sequential block

   --AB <= A & B ;   -- concatenation

   --process (all)   -- **NOTE: this is a VHDL-2008 only syntax (needs 'xvhdl -2008' switch)
   --process (A,B)
   --begin
   --
   --   case ( AB ) is
   --
   --      when "00"   => Z <= "101010" ;
   --      when "01"   => Z <= "010110" ;
   --      when "10"   => Z <= "010110" ;
   --      when "11"   => Z <= "100101" ;
   --      when others => Z <= "XXXXXX" ;
   --
   --   end case;
   --end process ;

end architecture rtl ;
