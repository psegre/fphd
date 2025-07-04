--
-- Example VHDL code for a BCD to 7-segments display decoder. Either define
-- COMMON_ANODE or COMMON_CATHODE macros to switch between CA or CC modules.
-- Available 7-segments display modules in the lab for this practicum (FYS-5613AX)
-- are COMMON CATHODE devices.
--
-- Luca Pacher - pacher@to.infn.it
-- Spring 2021
--


library IEEE ;
use IEEE.std_logic_1164.all ;


entity SevenSegmentDecoder is

   port (

      -- BCD input code
      BCD  : in std_logic_vector(3 downto 0) ;

      -- **DEBUG: display the BCD binary value on general-purpose standard LEDs
      LED  : out std_logic_vector(3 downto 0) ;

      -- 7-segment display control pins
      DP   : out std_logic ;
      segA : out std_logic ;
      segB : out std_logic ;
      segC : out std_logic ;
      segD : out std_logic ;
      segE : out std_logic ;
      segF : out std_logic ;
      segG : out std_logic
   ) ;

end entity SevenSegmentDecoder ;


architecture rtl of SevenSegmentDecoder is

   signal seg : std_logic_vector(6 downto 0) ;

--   signal A : std_logic ;
--   signal B : std_logic ; 
--   signal C : std_logic ;
--   signal D : std_logic ;


begin

   -- **DEBUG: display the BCD binary value on general-purpose standard LEDs
   LED <= BCD ;

   -- you can decide to tie-high or tie-down the unused decimal point (DP)
   DP <= '0' ;


   ---------------------------------------------------------
   --   logic equations implementation (COMMON CATHODE)   --
   ---------------------------------------------------------

   -- Ref. also to: https://www.electronicshub.org/bcd-7-segment-led-display-decoder-circuit

--
--   A <= BCD(3) ;
--   B <= BCD(2) ;
--   C <= BCD(1) ;
--   D <= BCD(0) ;
--
--   segA <= A or C or (B and D) or ((not B) and (not D)) ;
--   segB <= (not B) or ((not C) and (not D)) or (C and D) ;
--   segC <= B or (not C) or D ;
--   segD <= ((not B) and (not D)) or (C and (not D)) or (B and (not C) and D) or ((not B) and C) or A ;
--   segE <= ((not B) and not D) or (C and (not D)) ;
--   segF <= A or ((not C) and (not D)) or (B and (not C)) or (B and (not D)) ;
--   segG <= A or (B and (not C)) or ((not B) and C) or (C and (not D)) ;


   ------------------------------------------
   --   behavioral implementation (case)   --
   ------------------------------------------

   --process(all)    -- VHDL-2008 only feature
   process (BCD)
   begin

      case ( BCD ) is

         -- COMMON CATHODE
         when "0000" =>  seg <= "1111110" ;  --  0
         when "0001" =>  seg <= "0110000" ;  --  1
         when "0010" =>  seg <= "1101101" ;  --  2
         when "0011" =>  seg <= "1111001" ;  --  3
         when "0100" =>  seg <= "0110011" ;  --  4
         when "0101" =>  seg <= "1011011" ;  --  5
         when "0110" =>  seg <= "1011111" ;  --  6
         when "0111" =>  seg <= "1110000" ;  --  7
         when "1000" =>  seg <= "1111111" ;  --  8
         when "1001" =>  seg <= "1111011" ;  --  9

         -- catch-all condition (mandatory in VHDL)
         when others =>  seg <= "0000001" ;  -- minus sign otherwise

         -- COMMON ANODE (just for reference)
         --when "0000" =>  seg <= "0000001" ;  --  0
         --when "0001" =>  seg <= "1001111" ;  --  1
         --when "0010" =>  seg <= "0010010" ;  --  2
         --when "0011" =>  seg <= "0000110" ;  --  3
         --when "0100" =>  seg <= "1001100" ;  --  4
         --when "0101" =>  seg <= "0100100" ;  --  5
         --when "0110" =>  seg <= "0100000" ;  --  6
         --when "0111" =>  seg <= "0001111" ;  --  7
         --when "1000" =>  seg <= "0000000" ;  --  8
         --when "1001" =>  seg <= "0000100" ;  --  9

      end case ;
   end process ;

   -----------------------------------------------
   --   behavioral implementation (when/else)   --
   -----------------------------------------------

   -- COMMON CATHODE
   --seg <= "1111110" when BCD = "0000" else   --  0
   --seg <= "0110000" when BCD = "0001" else   --  1
   --seg <= "1101101" when BCD = "0010" else   --  2
   --seg <= "1111001" when BCD = "0011" else   --  3
   --seg <= "0001100" when BCD = "0100" else   --  4
   --seg <= "1011011" when BCD = "0101" else   --  5
   --seg <= "1011111" when BCD = "0110" else   --  6
   --seg <= "1110000" when BCD = "0111" else   --  7
   --seg <= "1111111" when BCD = "1000" else   --  8
   --seg <= "1111011" when BCD = "1001" else   --  9
   --       "0000001" ;


   segA <= seg(6) ;
   segB <= seg(5) ;
   segC <= seg(4) ;
   segD <= seg(3) ;
   segE <= seg(2) ;
   segF <= seg(1) ;
   segG <= seg(0) ;

end architecture rtl ;

