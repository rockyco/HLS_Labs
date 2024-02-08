-------------------------------------------------------------------------------- 
-- Copyright (c) 1996-2003 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Company: Xilinx 
-- \   \   \/    Version: 1.0 
--  \   \        Filename: ployIntroFilterPkg.vhd 
--  /   /        Date Last Modified:  Aug 18, 2005 
-- /___/   /\    Date Created: Aug 2, 2005 
-- \   \  /  \ 
--  \___\/\___\ 
-- 
--Device: Xilinx Virtex-4 (4vsx35-FF668-10) 
--Library: IEEE 
--Purpose: Polyphase Interperplation Filter Example
--         Design package file.  Compile into work library.
--Reference: http://www.xilinx.com
--Tools: Synplicity Synplify 8.1, Xilinx ISE 7.1i, MTI ModelSim-SE 6.0
--Revision History: 
--    Rev 1.0 - First release, brianp, Aug 18, 2005 
-------------------------------------------------------------------------------- 

library ieee;
use ieee.std_logic_1164.all;

package PolyIntrpFilterPkg is

type CoefArray is array (0 to 44) of integer;

constant Coefficients :  CoefArray := (
     1883, 1700, 1518, 1338, 1163,  994,  833,  680,  537,
     3244, 3140, 3021, 2887, 2740, 2583, 2417, 2243, 2064,
     3331, 3400, 3449, 3479, 3489, 3479, 3449, 3400, 3331,
     2064, 2243, 2417, 2583, 2740, 2887, 3021, 3140, 3244,
     537,  680,  833,  994, 1163, 1338, 1518, 1700, 1883
);


end PolyIntrpFilterPkg;

package body PolyIntrpFilterPkg is
end PolyIntrpFilterPkg;
