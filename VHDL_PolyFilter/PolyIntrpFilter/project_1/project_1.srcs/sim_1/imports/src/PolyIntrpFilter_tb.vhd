-------------------------------------------------------------------------------- 
-- Copyright (c) 1996-2003 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Company: Xilinx 
-- \   \   \/    Version: 1.0 
--  \   \        Filename: PolyIntrpFilter_tb.vhd 
--  /   /        Date Last Modified:  Aug 18, 2005 
-- /___/   /\    Date Created: Aug 2, 2005 
-- \   \  /  \ 
--  \___\/\___\ 
-- 
--Device: Xilinx Virtex-4 (4vsx35-FF668-10) 
--Library: IEEE 
--Purpose: Polyphase Interperplation Filter Example
--         Testbench file
--Reference: http://www.xilinx.com
--Tools: Synplicity Synplify 8.1, Xilinx ISE 7.1i, MTI ModelSim-SE 6.0
--Revision History: 
--    Rev 1.0 - First release, brianp, Aug 18, 2005 
-------------------------------------------------------------------------------- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--use ieee.numeric_std.all;
use work.PolyIntrpFilterPkg.all;
use work.TestPkg.all;

entity PolyIntrpFilter_tb is
end PolyIntrpFilter_tb;


architecture testbench of PolyIntrpFilter_tb is

  component PolyIntrpFilter
    generic (
      DataWidth   : integer;
      CoefWidth   : integer;
      IntrpFactor : integer;
      AddrWidth   : integer;
      NumStages   : integer
      );
    port (
      din   : in  signed(DataWidth-1 downto 0);
      clk   : in  std_logic;
      ce    : in  std_logic;
      reset : in  std_logic;
      dout  : out signed(47 downto 0)
      );
  end component;

  constant DataWidth   : integer := 16;
  constant CoefWidth   : integer := 16;
  constant IntrpFactor : integer := 9; --8;
  constant AddrWidth   : integer := 4; --3;
  constant NumStages   : integer := 5; --16;

  signal din       : signed(datawidth-1 downto 0);
  signal clk       : std_logic := '1';
  signal ce        : std_logic := '0';
  signal reset     : std_logic := '1';
  signal dout      : signed(47 downto 0);

  constant Tck  : time := 10 ns;        -- clock period
  constant Tpw  : time := Tck/2;        -- clock pulse width
  constant Tcko : time := 100 ps;       -- clock to out

begin
  
  clk <= not clk after Tpw;
  
  reset <= '0' after (10*Tck + Tcko);

  dut: PolyIntrpFilter
    generic map (
      DataWidth => DataWidth,
      CoefWidth => CoefWidth,
      IntrpFactor => IntrpFactor,
      AddrWidth => AddrWidth,
      NumStages => NumStages
      )
    port map (
        din   => din,
        clk   => clk,
        ce    => ce,
        reset => reset,
        dout  => dout
        );
  
  stimulus : process (clk)
    
    variable count              : integer := 0;
    variable NumClocksPerEnable : integer := IntrpFactor;
    variable state_cnt          : integer := 0;
    variable delay_cnt          : integer := 0;
    
  begin
    if (clk'event and clk = '1') then
      if (reset = '1') then
        din <= (others => '0');
        count := 0;
        delay_cnt := 0;
        state_cnt := 0;
      else
        if (state_cnt = 0) then
           ce <= '0' after Tcko;
           delay_cnt := delay_cnt + 1;
           if (delay_cnt > 20) then
              state_cnt := 1;
           else
              state_cnt := 0;
           end if;
        elsif (state_cnt = 1) then
           ce <= '1' after Tcko;
           if (count mod NumClocksPerEnable) = 0 then
              din <= conv_signed(TestData(count/NumClocksPerEnable), DataWidth) after Tcko;
           end if;
           count := (count + 1) mod (1024 * NumClocksPerEnable);
           if (count > 10 * NumClocksPerEnable) then
              state_cnt := 2;
           else
              state_cnt := 1;
           end if;
        else
           ce <= '0' after Tcko;
           state_cnt := 2;
        end if;
      end if;
    end if;
  end process stimulus;

  
end testbench;
