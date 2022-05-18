----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2021 10:16:32 AM
-- Design Name: 
-- Module Name: koren - Behavioral
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

entity koren is
    generic(WIDTH : positive := 32);
    Port ( 
           x_in : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           clk : in STD_LOGIC;
           start : in STD_LOGIC;
           ready : out STD_LOGIC;
           r_out : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           reset : in STD_LOGIC);
end koren;

architecture Behavioral of koren is

type state is(idle, one_shift, calculate, res_shift);
signal state_reg, state_next : state;
signal op_reg, op_next, res_reg, res_next, one_reg, one_next : std_logic_vector(width-1 downto 0);

begin
 -- state and data registers
 process (clk, reset) 
 begin 
	 if reset = '1' then 
		 state_reg <= idle; 
		 op_reg <= (others => '0'); 
		 res_reg <= (others => '0'); 
		 one_reg <= (others => '0'); 
		
	 elsif (clk'event and clk = '1') then 
		 state_reg <= state_next; 
		 op_reg <= op_next; 
		 res_reg <= res_next; 
		 one_reg <= one_next; 
	 end if; 
 end process;
 
 -- combinatorial circuits
 
 process (state_reg, start, x_in, op_reg, res_reg, one_reg, op_next, one_next) is 
 begin
 
    -- defaulth assignments
    op_next <= op_reg; 
    res_next <= res_reg; 
    one_next <= one_reg; 
    state_next<= state_reg;
 
    ready <= '0';
    
 case state_reg is 
    when idle =>
        ready <= '1';
        if start = '1' then
            op_next <= x_in;
            res_next<= std_logic_vector(to_unsigned(0, WIDTH));
            one_next<= ("01" & std_logic_vector(to_unsigned(0, 30)));
            
            state_next <= one_shift;
        else
            state_next <= idle;
        end if;
    when one_shift =>
        one_next<= ("00" & one_reg(width-1 downto 2));
        
        if(unsigned(one_next) > unsigned(op_reg)) then
            state_next <= one_shift; 
        else 
            state_next <= calculate;
        
        end if;
    
    when calculate =>
    
    if(unsigned(op_reg) >= (unsigned(res_reg) + unsigned(one_reg))) then
    
        op_next<= std_logic_vector(unsigned(op_reg) - (unsigned(res_reg) + unsigned(one_reg)));
        res_next<= std_logic_vector(to_unsigned((to_integer(unsigned(res_reg)) + 2*to_integer(unsigned(one_reg))), width));
    
        state_next<= res_shift;
    else
        state_next <= res_shift;
    end if;

    when res_shift =>
    
        res_next <= ('0' & res_reg(width-1 downto 1));
        one_next <= ("00" & one_reg(width-1 downto 2));
        
        if(unsigned(one_next) /= 0) then
            state_next<= calculate;
            
        else
            state_next<= idle;
        end if;
   
 end case;
 
    r_out<= std_logic_vector(res_reg);
    
    
 
 end process;


end Behavioral;
