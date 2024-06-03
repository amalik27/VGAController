library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Un-comment to use numerical standard library

entity image_top is
    Port (
        clk : in STD_LOGIC;
        vga_hs, vga_vs : out STD_LOGIC;
        vga_r, vga_b : out STD_LOGIC_VECTOR(4 downto 0);
        vga_g : out STD_LOGIC_VECTOR(5 downto 0)
    );
end image_top;

architecture image_top_arch of image_top is
    signal en : std_logic;
    signal hcount, vcount : std_logic_vector(9 downto 0);
    signal vs, vid : std_logic;
    signal dout : std_logic_vector(7 downto 0);
    signal addr : std_logic_vector(17 downto 0);

begin
    vga_vs <= vs;

    -- Instantiate the Clock Divider directly from the work library
    U1: entity work.clock_div port map (
        clk => clk,
        en => en
    );

    -- Instantiate the VGA Controller directly from the work library
    U2: entity work.vga_ctrl port map (
        clk => clk,
        clk_en => en,
        hcount => hcount,
        vcount => vcount,
        vid => vid,
        hs => vga_hs,
        vs => vs
    );

    -- Instantiate the Picture component directly from the work library
    U3: entity work.picture port map (
        clka => clk,
        addra => addr,
        douta => dout
    );

    -- Instantiate the Pixel Pusher directly from the work library
    U4: entity work.pixel_pusher port map (
        clk => clk,
        clk_en => en,
        VS => vs,
        pixel => dout,
        hcount => hcount,
        vid => vid,
        R => vga_r,
        B => vga_b,
        G => vga_g,
        addr => addr
    );

end image_top_arch;
