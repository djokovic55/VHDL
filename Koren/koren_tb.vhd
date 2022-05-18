----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2021 04:35:49 PM
-- Design Name: 
-- Module Name: koren_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity koren_tb is
generic(WIDTH : positive := 32);
--  Port ( );
end koren_tb;

architecture Behavioral of koren_tb is

signal x_in_s : STD_LOGIC_VECTOR (WIDTH-1 downto 0);
signal clk_s : STD_LOGIC;
signal start_s : STD_LOGIC;
signal ready_s : STD_LOGIC;
signal r_out_s : STD_LOGIC_VECTOR (WIDTH-1 downto 0);
signal reset_s : STD_LOGIC;

begin

	koren: entity work.koren
		generic map (WIDTH=>WIDTH)
		port map (
			x_in=>x_in_s,
			clk=>clk_s,
			ready=>ready_s,
			start=>start_s,
			r_out=>r_out_s,
			reset=>reset_s);
			
			
	x_in_s<= std_logic_vector(to_unsigned(49, WIDTH));
	
	start_s<= '1', '0' after 210ns;
	reset_s<= '1', '0' after 110ns;
	
	clk_gen: process 
	begin
	
	clk_s<= '1', '0' after 50ns;
	wait for 100ns;
	
	end process;
			


end Behavioral;
