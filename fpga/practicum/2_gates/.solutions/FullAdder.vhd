--
-- Example different implementations using VHDL for a Full-Adder (FA) circuit.
--
-- Luca Pacher - pacher@to.infn.it
-- Spring 2025
--


library IEEE ;
use IEEE.std_logic_1164.all ;   -- include extended logic values (by default VHDL only provides 0/1 with the 'bit' data type)


----------------------------
--   entity declaration   --
----------------------------
entity FullAdder is

   port (

      A    : in std_logic ;
      B    : in std_logic ;
      Cin  : in std_logic ;    -- input carry
      Sum  : out std_logic ;
      Cout : out std_logic    -- output carry
   ) ;

end entity FullAdder ;


-------------------------------------
--   architecture implementation   --
-------------------------------------
architecture rtl of FullAdder is

   -- 
   -- **IMPORTANT
   --
   -- The binary addition can be implemented using the standard sum operaror `+` as in any other
   -- programming language. The synthesis tool will be then responsible to infer necessary logic
   -- gates to implement the circuit in real hardware. Alternatively since the circuit is a pure
   -- combinational block you can use a truth-table or derive logic equations from K-maps.
   --

   signal result : std_logic_vector(1 downto 0) ;

begin

   -- split sum bit and output-carry bit
   Sum  <= result(0) ;
   Cout <= result(1) ;

   ------------------------------------------------------------- 
   --   signal assignment using the standard sum + operator   --
   ------------------------------------------------------------- 

   result <= A + B + Cin ;


   -- 
   -- **NOTE
   --
   -- You can also assign the {Cout,Sum} concatenation using an always block!
   --
   --process (all)
   --begin
   --   result <= A + B + Cin ;
   --
   --end process ;


   -------------------------------------------------
   --   truth-table implementation (behavioral)   --
   -------------------------------------------------

   process (all)
   begin

      case ( Cin & A & B ) is

          when "000" => result <= "00" ;
          when "001" => result <= "01" ;
          when "010" => result <= "01" ;
          when "011" => result <= "10" ;    -- **NOTE: 1+1 = 2 that is... 0 with the CARRY of 1 !
          when "100" => result <= "01" ;
          when "101" => result <= "10" ;
          when "110" => result <= "10" ;
          when "111" => result <= "11" ;    -- 1+1+1 = 3

      end case ;
   end process ;


   -------------------------
   --   logic equations   --
   -------------------------

   -- sum
   Sum  <= A xor B xor Cin ;   -- XOR between A, B and Cin inputs

   -- output carry
   Cout <= (A and B) or (Cin and (A xor B)) ;


end architecture rtl ;

