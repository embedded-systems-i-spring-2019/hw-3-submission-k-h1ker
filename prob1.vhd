library IEEE;
use IEEE.STD_LOGIC_1164.all, IEEE.NUMERIC_STD.all;

entity two_to_one_mux is
    port (a , b : in std_logic_vector(7 downto 0);
            sel : in std_logic;
            y   : out std_logic_vector(7 downto 0));
end two_to_one_mux;

architecture my_mux of two_to_one_mux is
begin

y <= a WHEN sel ='1' ELSE
            b;
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

entity prob1 is
    port(a, b    : in std_logic_vector(7 downto 0);
        clk, sel : in std_logic;
        ld       : in std_logic;
        f        : out std_logic_vector(7 downto 0));
end prob1;

architecture rtl_strut of prob1 is
    component two_to_one_mux
        port (a , b : in std_logic_vector(7 downto 0);
            sel : in std_logic;
            y   : out std_logic_vector(7 downto 0));
end component;

component reg8
    port (reg_in : in std_logic_vector(7 downto 0);
         ld, clk : in std_logic;
         reg_out : out std_logic_vector(7 downto 0));
end component;

signal s_mux_result : std_logic_vector(7 downto 0);

begin
    regA: reg8
    port map (reg_in => s_mux_result,
                ld => ld,
                clk => clk,
                reg_out => f);
m1 : two_to_one_mux
    port map( a => a,
              b => b,
              sel => sel,
              y => s_mux_result);
end  rtl_strut;
                