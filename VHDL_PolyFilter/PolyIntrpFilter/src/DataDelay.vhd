-------------------------------------------------------------------------------- 
-- Copyright (c) 1996-2003 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Company: Xilinx 
-- \   \   \/    Version: 1.0 
--  \   \        Filename: DataDelay.vhd 
--  /   /        Date Last Modified:  Aug 18, 2005 
-- /___/   /\    Date Created: July 14, 2005 
-- \   \  /  \ 
--  \___\/\___\ 
-- 
--Device: Xilinx Virtex-4 (4vsx35-FF668-10) 
--Library: IEEE 
--Purpose: Polyphase Interperplation Filter Example
--         Sub-level design file
--Reference: http://www.xilinx.com
--Tools: Synplicity Synplify 8.1, Xilinx ISE 7.1i, MTI ModelSim-SE 6.0
--Revision History: 
--    Rev 1.0 - First release, brianp, Aug 18, 2005 
-------------------------------------------------------------------------------- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataDelay is
  generic (
    Width : natural := 16
    );
  
  port(
    din   : in  signed(Width-1 downto 0);
    clk   : in  std_logic;
    ce    : in  std_logic;
    reset : in  std_logic;
    dout  : out signed(Width-1 downto 0)
    );
end DataDelay;

architecture behavioral of DataDelay is

  attribute syn_useioff               : boolean;
  attribute syn_useioff of behavioral : architecture is false;

begin
  
  process (clk)
  begin
    if rising_edge(clk) then
      if (reset = '1') then
        dout <= (others => '0');
      elsif (ce = '1') then
        dout <= din;
      end if;
    end if;
  end process;

end behavioral;
