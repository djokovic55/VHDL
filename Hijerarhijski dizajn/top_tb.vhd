----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2021 04:39:45 PM
-- Design Name: 
-- Module Name: top_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_tb is
generic (width : positive := 5); 
--  Port ( );
end top_tb;

architecture Behavioral of top_tb is

signal a_in_s, b_in_s : STD_LOGIC_VECTOR (width-1 downto 0);
signal r_out_s : STD_LOGIC_VECTOR (2*width-1 downto 0);
signal start_s : std_logic;
signal clk_s, reset_s, ready_s : std_logic;

begin

    tb: entity work. top_design
    generic map (width => width)
    port map (
           a_in => a_in_s,
           b_in => b_in_s,
           r_out => r_out_s, 
           start  => start_s,
           clk  => clk_s,
           reset => reset_s, 
           ready => ready_s);
           
   a_in_s <= x"05";
   b_in_s <= x"06";
   start_s <= '1', '0' after 400ns;
   reset_s <= '1', '0' after 200ns;
   
   clk:process is
   begin
        clk_s <= '1' , '0' after 50ns;
        wait for 100ns;
   end process;

end Behavioral;
