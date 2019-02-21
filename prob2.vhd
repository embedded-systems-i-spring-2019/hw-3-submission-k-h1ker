library IEEE;
use IEEE.STD_LOGIC_1164.all, IEEE.NUMERIC_STD.all;

entity mux_4to1 is
        port ( x, y, z, rb    : in std_logic_vector(7 downto 0);
                ms        : in std_logic_vector( 1 downto 0);
                mx_out    : out std_logic_vector(7 downto 0));
end mux_4to1;


architecture my_4to1_mux of mux_4to1 is
    begin
        process (ms, rb, x, y, z)
            begin
                case ms is
                when "00" => mx_out <= rb;
                when "01" => mx_out <= z;
                when "10" => mx_out <=y;
                when "11" => mx_out <=x;
                when others => mx_out <= rb;
                end case;
        end process;
end my_4to1_mux;

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

entity prob2 is
    port(x, y, z    : in std_logic_vector(7 downto 0);
             clk    : in std_logic;
             ds     : in std_logic;
             ms     : in std_logic_vector(1 downto 0);
             ld     : out std_logic;
        RA, RB      : out std_logic_vector(7 downto 0));
end prob2;

architecture ckt2 of prob2 is 
    component mux_4to1
        port ( x, y, z, rb : in std_logic_vector(7 downto 0);
                ms        : in std_logic_vector( 1 downto 0);
                mx_out    : out std_logic_vector(7 downto 0));
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

signal RA_OUT, RB_OUT, s_mux_result : std_logic_vector(7 downto 0);
signal ld0_out, ld1_out : std_logic;
begin
    m1 : mux_4to1
        port map (x=>x,
                  y=>y,
                  z=>z,
                  rb=>RB_OUT,
                  ms=>ms,
                  mx_out=>s_mux_result);
    d1 : decoder_1to2
        port map ( ds=> ds,
                   ld0=> ld0_out,
                   ld1=> ld1_out);
    REGA : reg8
        port map (reg_in=> s_mux_result,
                    ld=> ld0_out,
                    reg_out=>RA_OUT,
                    clk=>clk);
    REGB : reg8
        port map (reg_in => RA_OUT,
                  ld=> ld1_out,
                  clk=> clk,
                  reg_out=>RB_OUT);
                  
end ckt2;
        
        
                 



