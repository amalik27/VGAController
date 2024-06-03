library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity clock_div is
    port (
        clk : in std_logic;
        en  : out std_logic
    );
end clock_div;

architecture clock_div_arch of clock_div is
    signal divider_counter : std_logic_vector(26 downto 0) := (others => '0');
begin
    divider_process: process(clk) 
    begin
        if rising_edge(clk) then
            if unsigned(divider_counter) < 4 then
                divider_counter <= std_logic_vector(unsigned(divider_counter) + 1);
                en <= '0';
            else    
                divider_counter <= (others => '0');
                en <= '1';
            end if;
        end if;     
    end process;

end clock_div_arch;
