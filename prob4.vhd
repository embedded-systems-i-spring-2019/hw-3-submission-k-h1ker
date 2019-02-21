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

entity and_gate is
    port( in_1, in_2 : in std_logic;
          and_result : out std_logic);
end and_gate;

architecture and_gate of and_gate is
begin
 and_result <= in_1 and in_2;
end and_gate;
library IEEE;
use IEEE.STD_LOGIC_1164.all, IEEE.NUMERIC_STD.all;
entity inverter is
    port (  input1 : in std_logic;
            output1: out std_logic);
end inverter;

architecture inverter of inverter is
begin
    output1 <= not input1;
end inverter;


library IEEE;
use IEEE.STD_LOGIC_1164.all, IEEE.NUMERIC_STD.all;

entity prob4 is
 port (LDB, S1, LDA, RD, S0 : in std_logic;
       clk                 : in std_logic;
       x, y                : in std_logic_vector(7 downto 0);
       RA, RB              : out std_logic_vector(7 downto 0));
end prob4;

architecture ctk4 of prob4 is
 component two_to_one_mux is
    port (x, y: in std_logic_vector(7 downto 0);
            sel : in std_logic;
            z   : out std_logic_vector(7 downto 0));
 end component;
 component and_gate is
    port( in_1, in_2 : in std_logic;
          and_result : out std_logic);
 end component;
 
 component inverter is
 port (  input1 : in std_logic;
         output1: out std_logic);
 end component;

component reg8 is
    port (reg_in : in std_logic_vector(7 downto 0);
         ld, clk : in std_logic;
         reg_out : out std_logic_vector(7 downto 0));
end component;

signal gate1_result, gate2_result, inverter_result : std_logic;
signal m1_result, m2_result, RB_OUT : std_logic_vector(7 downto 0);

begin 
    m1 : two_to_one_mux
        port map (x   => x,
                  y   => y,
                  z   => m1_result,
                  sel => S1);
    m2 : two_to_one_mux
        port map ( x   => RB_OUT,
                   y   => y,
                   sel => S0,
                   z   => m2_result);
    gate1 : and_gate
        port map( in_1       => LDB,
                  in_2       => inverter_result,
                  and_result => gate1_result);
    gate2 : and_gate
        port map( in_1       => LDA,
                  in_2       => RD,
                  and_result => gate2_result);
    REGB : reg8
        port map( ld      => gate1_result,
                  reg_in  => m1_result,
                  reg_out => RB_OUT,
                  clk     => clk);
    REGA : reg8
        port map ( ld      => gate2_result,
                   reg_in  => m2_result,
                   reg_out => RA,
                   clk     => clk);
end ctk4;