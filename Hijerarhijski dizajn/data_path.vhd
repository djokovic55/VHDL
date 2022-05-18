----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2021 09:07:01 AM
-- Design Name: 
-- Module Name: data_path - Behavioral
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

entity data_path is
    generic(width : positive := 5);
    Port ( 
           a_in : in STD_LOGIC_VECTOR (width-1 downto 0);
           b_in : in STD_LOGIC_VECTOR (width-1 downto 0);
           r_out : out STD_LOGIC_VECTOR (2*width-1 downto 0);
           clk: in std_logic;
           count_0 : out STD_LOGIC;
           sel : in STD_LOGIC_VECTOR(1 downto 0);
           b_next_0 : out std_logic);
           
end data_path;

architecture Behavioral of data_path is
-- signals of the structural part    
signal p_next, p_reg : std_logic_vector(2*width-1 downto 0);
signal adder_out: std_logic_vector(2*width-1 downto 0);

-- signals of the bihevioral part

signal a_next, a_reg : std_logic_vector(2*width-1 downto 0);
signal b_next, b_reg : std_logic_vector(width-1 downto 0);
signal n_next, n_reg : std_logic_vector(width-1 downto 0);




begin

    reg4: entity work. pipo
    generic map(width => 2*width)
    port map (
              d => p_next,
              q => p_reg,
              clk => clk);
              
    mux4: entity work. mux
    generic map(width => 2*width)
    port map (
              m0 => std_logic_vector(to_unsigned(0, 2*width)),
              m1 => adder_out,
              m2 => p_reg,
              m3 => std_logic_vector(to_unsigned(0, 2*width)),
              sel=> sel,
              m_out => p_next);   
              
   adder: entity work. adder
   
    generic map(width => 2*width)
    port map (
             a => p_reg,
             b => a_reg,
             c => adder_out);
             
 -- sekvencial part            
 registri: process(clk) is 
 begin
    if (rising_edge(clk)) then
        a_reg <= a_next;
        b_reg <= b_next;
        n_reg <= n_next;
         
    end if;
 end process;
     
 -- combitnational part
 
mux: process(sel, a_reg, b_reg, n_reg) is 
    begin
        if(sel = "00") then
            a_next <= std_logic_vector(to_unsigned(0, width)) & a_in;
            b_next <= b_in;
            n_next <= std_logic_vector(to_unsigned(width, width));
        elsif(sel = "01") then
            a_next <= a_reg;
            b_next <= b_reg;
            n_next <= n_reg;        

        elsif(sel = "01") then
            a_next <= a_reg(2*width-2 downto 0) & '0';
            b_next <= '0' & b_reg(width-1 downto 1);
            n_next <= std_logic_vector(unsigned(n_reg) - to_unsigned(1, width));
        
        else
            a_next <= (others => '0');
            b_next <= (others => '0');
            n_next <= (others => '0');

        end if;
    end process;
    
    b_next_0 <= b_next(0);
    count_0 <= '1' when n_next = std_logic_vector(to_unsigned (0, width)) else
               '0';
        
 
                
    

end Behavioral;
