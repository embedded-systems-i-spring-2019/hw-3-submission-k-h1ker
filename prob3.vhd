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

entity prob3 is
    port(  x, y           : in std_logic_vector(7 downto 0);
           clk, s1,s0     : in std_logic;
           lda, ldb       : in std_logic;
           rb             : out std_logic_vector(7 downto 0));
         
end prob3;
architecture ckt3 of prob3 is
     component two_to_one_mux
        port (x , y : in std_logic_vector(7 downto 0);
                sel : in std_logic;
                z   : out std_logic_vector(7 downto 0));
end component;

component reg8
    port (reg_in : in std_logic_vector(7 downto 0);
         ld, clk : in std_logic;
         reg_out : out std_logic_vector(7 downto 0));
end component;

signal mux1_result, mux2_result, RA_OUT, RB_OUT : std_logic_vector(7 downto 0);

begin
     m1 : two_to_one_mux
        port map (x   => x,
                  y   => RB_OUT,
                  sel => s1,
                  z   => mux1_result);

     m2 : two_to_one_mux
        port map (x   => RA_OUT,
                  y   => y,
                  z   => mux2_result,
                  sel => s0);
     REGA : reg8
        port map (reg_in  => mux1_result,
                  clk     => clk,
                  ld      => lda,
                  reg_out => RA_OUT);
     REGB : reg8
        port map (reg_in  => mux2_result,
                  clk     => clk,
                  ld      => ldb,
                  reg_out => RB_OUT);
end ckt3;
                          
         
         
         
         