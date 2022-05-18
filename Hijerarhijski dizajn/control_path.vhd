----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2021 09:07:01 AM
-- Design Name: 
-- Module Name: control_path - Behavioral
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

entity control_path is
    Port (        
           start : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           count_0 : in STD_LOGIC;
           b_in : in STD_LOGIC;
           sel : out STD_LOGIC_VECTOR(1 downto 0);
           ready : out STD_LOGIC);
end control_path;

architecture Behavioral of control_path is

type state is (idle, shift, add);
signal state_next, state_reg : state;

begin

-- sequencial logic

    process (clk) is 
    begin  
        if(rising_edge(clk)) then
            if(reset = '1') then
                state_reg <= idle;
            else      
                state_reg <= state_next;
            end if;
        end if; 
    end process;
    
-- combinational logic

   process (start, count_0, state_reg, b_in) is 
   begin
   
       state_next <= state_reg;
       sel <= "00";
       ready <= '0';
       
       case state_reg is 
       
       when idle =>
       
           sel <= "00";
           ready <= '1';
           if (start = '1') then
            if(b_in = '0') then
                state_next <= shift;
            else
                state_next <= add;
            end if;
           end if;
       when shift =>
       sel <= "10";
        if(count_0 = '0') then
            if (b_in = '1') then        
                state_next <= add;
            else           
                state_next <= idle;
            end if;
        end if;
       
       when add => 
       sel <= "01";
       state_next <= shift;
       end case;
   
   end process; 


end Behavioral;
