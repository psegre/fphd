--
-- Turn on/off an on-board LED using a free-running counter as clock divider.
-- Optionally, drive a 7-segment display module as discussed in practicum #3.
--
-- Luca Pacher - pacher@to.infn.it
-- Spring 2021
--

library IEEE ;
use IEEE.std_logic_1164.all ;       -- include extended logic values (by default VHDL only provides 0/1 with the 'bit' data type)
use IEEE.std_logic_unsigned.all ;   -- to use + operator between std_logic_vector data types

library work ;
use work.all ;


entity LED_blink is

   port (

      -- assume 100 MHz external clock from on-board oscillator
      clk : in std_logic ;

      LED       : out std_logic ;
      LED_probe : out std_logic      -- probe at the oscilloscope the LED control signal

      -- **EXERCISE: add an external count-enable control (e.g. slide-switch)
      --enable : in std_logic ;

      -- **EXERCISE: drive a 7-segment display module with a suitable 4-bit slice of the counter
      --DP   : out std_logic ;
      --segA : out std_logic ;
      --segB : out std_logic ;
      --segC : out std_logic ;
      --segD : out std_logic ;
      --segE : out std_logic ;
      --segF : out std_logic ;
      --segG : out std_logic

   ) ;

end entity LED_blink ;



architecture rtl of LED_blink is

   signal count : std_logic_vector(27 downto 0) := (others => '0') ;   -- **QUESTION: what happens if 'count' is not initialized into RTL code ?
   --signal count : std_logic_vector(27 downto 0) ;

   --BCD : std_logic_vector(3 downto 0) ;


begin

   ------------------------------
   --   free-running counter   --
   ------------------------------

   process (clk)
   begin

      if ( rising_edge(clk) ) then
         --if ( enable = '1' ) then

         count <= count + '1' ;

         --end if ;
      end if ;
   end process ;


   ------------------------------
   --   drive the LED output   --
   ------------------------------

   -- simply turn on/off the LED with one bit of the output count

   LED <= count(24) ;        -- **QUESTION: which is the blink frequency of the LED ?
   --LED <= count(25) ;
   --LED <= count(26) ;
   --LED <= count(27) ;

   -- **DEBUG: probe at the oscilloscope the LED control signal on some general-purpose I/O
   LED_probe <= LED ;


   ----------------------------------------------------------------------------------------------------------------
   --   optionally, drive a 7-segment display (simply re-use the module already implemented into practicum #3)   --
   ----------------------------------------------------------------------------------------------------------------

--
--   BCD <= count(27 downto 24) ;
--
--   -- ENTITY INSTANTIATION (pick the compiled entity from the default WORK library)
--   SevenSegmentDecoderInst : entity work.SevenSegmentDecoder(rtl) port map (
--
--       BCD  => BCD,
--       DP   => DP,
--       segA => segA,
--       segB => segB,
--       segC => segC,
--       segD => segD,
--       segE => segE,
--       segF => segF,
--       segG => segG,
--       LED  => open      -- leave **UNCONNECTED**
--   ) ;
--

end architecture rtl ;

