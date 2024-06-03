library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pixel_pusher is
    Port (
        clk, clk_en, VS : in STD_LOGIC := '0';
        pixel : in STD_LOGIC_VECTOR(7 downto 0);
        hcount : in STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
        vid : in STD_LOGIC := '0';
        R, B : out STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
        G : out STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
        addr : out STD_LOGIC_VECTOR(17 downto 0)
    );
end pixel_pusher;

architecture pixel_pusher_arch of pixel_pusher is
    signal addr_register : std_logic_vector(17 downto 0);

begin
    addr <= addr_register;

    pixel_processing : process(clk)
    begin
        if rising_edge(clk) then
            if VS = '0' then
                addr_register <= (others => '0');
            elsif clk_en = '1' and vid = '1' then
                if unsigned(hcount) < 480 then
                    addr_register <= std_logic_vector(unsigned(addr_register) + 1);
                    R <= pixel(7 downto 5) & "00";
                    G <= pixel(4 downto 2) & "000";
                    B <= pixel(1 downto 0) & "000";
                else
                    R <= (others => '0');
                    G <= (others => '0');
                    B <= (others => '0');
                end if;
            else
                R <= (others => '0');
                G <= (others => '0');
                B <= (others => '0');
            end if;
        end if;
    end process pixel_processing;

end pixel_pusher_arch;
