----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2021 09:07:01 AM
-- Design Name: 
-- Module Name: top_design - Behavioral
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

entity top_design is
    generic(width : positive := 5);
    Port ( 
            
           a_in : in STD_LOGIC_VECTOR (width-1 downto 0);
           b_in : in STD_LOGIC_VECTOR (width-1 downto 0);
           r_out : out STD_LOGIC_VECTOR (2*width-1 downto 0);
           start : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           ready : out STD_LOGIC);
end top_design;

architecture Behavioral of top_design is

signal count_0, b_next_0 : std_logic;
signal sel_top : std_logic_vector(1 downto 0);
begin

   dp: entity work. data_path
    generic map (width => 5)
    port map( 
        a_in => a_in,
        b_in => b_in,
        r_out => r_out,
        clk => clk,
        count_0 => count_0,
        sel => sel_top,
        b_next_0 => b_next_0);
        
    cp: entity work. control_path
    port map (
        start => start,
        clk => clk,
        reset => reset,
        count_0 => count_0,
        b_in => b_next_0,
        sel => sel_top,
        ready =>ready
        );


end Behavioral;
