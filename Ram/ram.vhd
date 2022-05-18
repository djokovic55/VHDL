----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2021 01:35:08 PM
-- Design Name: 
-- Module Name: ram - Behavioral
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

entity ram is
    Port ( 
           r_data : out STD_LOGIC_VECTOR (31 downto 0);
           w_data : in STD_LOGIC_VECTOR (31 downto 0);
           clk : in STD_LOGIC;
           address : in STD_LOGIC_VECTOR (9 downto 0);
           write : in STD_LOGIC);
end ram;

architecture Behavioral of ram is

type ram_type_t is array ( 0 to 1023) of std_logic_vector(31 downto 0);

signal ram_s: ram_type_t;

begin

    process(clk) is 
    begin
        if(rising_edge(clk)) then
            if (write = '1') then
               ram_s(to_integer(unsigned(address))) <= w_data;
           end if;
               r_data <=  ram_s(to_integer(unsigned(address)));

        end if;
    end process;
    


end Behavioral;
