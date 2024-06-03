----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/28/2024 01:28:10 AM
-- Design Name: 
-- Module Name: image_top_tb - image_top_tb_arch
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

entity image_top_tb is
--  Port ( );
end image_top_tb;

architecture image_top_tb_arch of image_top_tb is

component image_top is                                              
    Port ( clk : in STD_LOGIC;                                   
         vga_hs, vga_vs : out STD_LOGIC;                         
         vga_r, vga_b : out STD_LOGIC_VECTOR (4 downto 0);       
         vga_g : out STD_LOGIC_VECTOR (5 downto 0));             
end component image_top;                                                   
                                                                 
signal clk, vga_hs, vga_vs : std_logic;
signal vga_r, vga_b : std_logic_vector(4 downto 0);
signal vga_g : std_logic_vector(5 downto 0);

begin




dut : image_top port map(
    clk => clk,
    vga_hs => vga_hs,
    vga_vs => vga_vs,
    vga_r => vga_r,
    vga_b => vga_b,
    vga_g => vga_g
    
);

clock_gen : process begin
    clk <= '1';
    wait for 4 ns;
    clk <= '0';
    wait for 4 ns;
end process clock_gen;

end image_top_tb_arch;
