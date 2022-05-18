----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2021 09:07:01 AM
-- Design Name: 
-- Module Name: mux - Behavioral
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

entity mux is
    generic(width : positive := 5);
    Port ( 
           m0 : in STD_LOGIC_VECTOR (width-1 downto 0);
           m1 : in STD_LOGIC_VECTOR (width-1 downto 0);
           m2 : in STD_LOGIC_VECTOR (width-1 downto 0);
           m3 : in STD_LOGIC_VECTOR (width-1 downto 0);
           sel : in STD_LOGIC_VECTOR(1 downto 0);
           m_out : out STD_LOGIC_VECTOR(width-1 downto 0));
end mux;

architecture Behavioral of mux is

begin

    process (m0, m1, m2, m3, sel) is 
    begin
    
        case sel is 
            when "00" =>
                m_out <= m0;
            when "01" =>
                m_out <= m1;
            when "10" =>
                m_out <= m2;
            when others =>
                m_out <= m3;
        end case;     

    end process;
end Behavioral;
