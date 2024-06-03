library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vga_ctrl is
    Port (
        clk : in std_logic;
        clk_en : in std_logic;
        hcount, vcount : out std_logic_vector(9 downto 0) := (others => '0');
        vid : out std_logic;
        hs, vs  : out std_logic
    );
end vga_ctrl;

architecture vga_ctrl_arch of vga_ctrl is
    signal hor_counter : std_logic_vector(9 downto 0) := (others => '0');
    signal ver_counter : std_logic_vector(9 downto 0) := (others => '0');

begin
    hcount <= hor_counter;
    vcount <= ver_counter;

    -- Process to manage the horizontal and vertical counters
    counter_proc : process(clk) 
    begin
        if rising_edge(clk) then
            if clk_en = '1' then
                if unsigned(hor_counter) < 799 then
                    hor_counter <= std_logic_vector(unsigned(hor_counter) + 1);
                else
                    hor_counter <= (others => '0');
                    if unsigned(ver_counter) < 524 then
                        ver_counter <= std_logic_vector(unsigned(ver_counter) + 1);
                    else
                        ver_counter <= (others => '0');
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- Process to generate the video display signal (vid)
    vid_proc : process(hor_counter, ver_counter)
    begin
        if unsigned(hor_counter) > 639 or unsigned(ver_counter) > 479 then
            vid <= '0';
        else
            vid <= '1';
        end if;
    end process;

    -- Process to generate the horizontal sync signal (hs)
    hs_proc : process(hor_counter)
    begin
        if unsigned(hor_counter) > 655 and unsigned(hor_counter) < 752 then
            hs <= '0';
        else
            hs <= '1';
        end if;
    end process;

    -- Process to generate the vertical sync signal (vs)
    vs_proc : process(ver_counter)
    begin
        if unsigned(ver_counter) = 490 or unsigned(ver_counter) = 491 then
            vs <= '0';
        else
            vs <= '1';
        end if;
    end process;

end vga_ctrl_arch;
