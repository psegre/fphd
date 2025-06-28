--
-- Synthesizable Verilog implementation of a parameterized ring-oscillator
-- using STRUCTURAL CODE and gate-primitives.
--
--
-- Luca Pacher - pacher@to.infn.it
-- Spring 2024
--
--
-- **IMPORTANT NOTES
--
-- The circuit uses an AND-gate into the feedback loop to enable/disable the
-- output toggle, thus requiring an **ODD** number of inverters in the chain.
--
-- Additional 'dont_touch' synthesis directives are mandatory in order to infer
-- the desired hardware, otherwise the synthesis engine would delete all inverters
-- into the chain. 
--


library IEEE ;
use IEEE.std_logic_1164.all ;


----------------------------
--   entity declaration   --
----------------------------
entity RingOscillator is

   generic (

      -- **IMPORTANT: the chosen number of inverters MUST be an **ODD** number (AND-gate used in the feedback loop to enable/disable the toggle)
      NUM_INVERTERS : positive := 283
    ) ;

   port (
      start : in  std_logic ;
      clk   : out std_logic ;
      -- **DEBUG
      led : out std_logic ;
      start_probe : out std_logic
   ) ;

end entity RingOscillator ;


-------------------------------------
--   architecture implementation   --
-------------------------------------
architecture rtl of RingOscillator is

   -- wires for internal connections
   signal w : std_logic_vector(NUM_INVERTERS downto 0) ;

   attribute dont_touch : string ;
   attribute dont_touch of w : signal is "true" ;

begin

   -- start/stop AND gate
   w(0) <= w(NUM_INVERTERS) and start ;

   -- inverters chain
   for k in 0 to NUM_INVERTERS generate 

      w(k+1) <= not w(k) ;

   end generate ;



   clk <= w(NUM_INVERTERS) ;

   -- **DEBUG: drive a status LED with 'start'
   led <= start ;

   -- **DEBUG: probe 'start' at the oscilloscope
   start_probe <= start ;

end architecture rtl ;

