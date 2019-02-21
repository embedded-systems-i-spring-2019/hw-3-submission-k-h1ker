library IEEE;
use IEEE.STD_LOGIC_1164.all, IEEE.NUMERIC_STD.all;

entity two_to_one_mux is
    port (x, y: in std_logic_vector(7 downto 0);
            sel : in std_logic;
            z   : out std_logic_vector(7 downto 0));
end two_to_one_mux;

architecture my_mux of two_to_one_mux is
begin

z <= x WHEN sel ='1' ELSE
            y;
end my_mux;
library IEEE;
use IEEE.STD_LOGIC_1164.all, IEEE.NUMERIC_STD.all;
entity reg8 is
    port (reg_in : in std_logic_vector(7 downto 0);
         ld, clk : in std_logic;
         reg_out : out std_logic_vector(7 downto 0));
end reg8;

architecture reg8 of reg8 is
begin
   reg: process(clk)
    begin
        if(rising_edge(clk)) then
            if (ld = '1') then
                reg_out<=reg_in;
            end if;
        end if;
    end process;
end reg8;

library IEEE;
use IEEE.STD_LOGIC_1164.all, IEEE.NUMERIC_STD.all;

entity decoder_1to2 is
    port (ds : in std_logic;
         ld0, ld1 : out std_logic);
end decoder_1to2;

architecture my_decoder of decoder_1to2 is
begin
    ld0 <= NOT ds;
    ld1 <= ds;
end my_decoder;

library IEEE;
use IEEE.STD_LOGIC_1164.all, IEEE.NUMERIC_STD.all;

entity prob5 is
    port ( sel1, sel2 : in std_logic;
           clk        : in std_logic;
           a, b, c    : in std_logic_vector(7 downto 0);
           RAX, RBX   : out std_logic_vector(7 downto 0));
           
end prob5;

architecture ckt5 of prob5 is 
    component two_to_one_mux 
        port (x, y: in std_logic_vector(7 downto 0);
            sel : in std_logic;
            z   : out std_logic_vector(7 downto 0));
    end component;
    component reg8 
         port (reg_in : in std_logic_vector(7 downto 0);
         ld, clk : in std_logic;
         reg_out : out std_logic_vector(7 downto 0));
    end component;
    component decoder_1to2
        port (ds : in std_logic;
         ld0, ld1 : out std_logic);
    end component;
        
signal m1_result : std_logic_vector(7 downto 0);
signal ld1_out, ld0_out : std_logic;

begin
    m1 : two_to_one_mux
        port map( x    => B,
                  y    => C,
                  sel  => sel2,
                  z    => m1_result);
                  
    d1 : decoder_1to2
        port map( ds  => sel1,
                  ld0 => ld0_out,
                  ld1 => ld1_out);
    REGA : reg8
        port map ( clk     => clk,
                   ld      => ld1_out,
                   reg_in  => A,
                   reg_out => RAX);
    REGB : reg8
        port map ( clk     => clk,
                   ld      => ld0_out,
                   reg_in  => m1_result,
                   reg_out => RBX);
                  
                  
                  
end ckt5;