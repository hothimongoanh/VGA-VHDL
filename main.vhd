library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity main is
port(
clock, reset, transmit:in std_logic;
tx:out std_logic;
rx:in std_logic;
data:in std_logic_vector(7 downto 0);
led:out std_logic_vector(7 downto 0)
);
end entity;


architecture arch of main is

component uart_transmitter is
generic(
MAX_VALUE:std_logic_vector(12 downto 0)
);
port(
data : in std_logic_vector(7 downto 0);
clock, reset, transmit : in std_logic;
tx : out std_logic
);
end component;

component uart_receiver is
generic(
MAX_VALUE:std_logic_vector(12 downto 0)
);
port(
data : out std_logic_vector(7 downto 0);
receive : out std_logic;
clock, reset, rx : in std_logic
);
end component;

signal in_reset:std_logic;
signal in_transmit:std_logic;
signal in_data:std_logic_vector(7 downto 0);
signal received:std_logic;
begin


in_reset<=not reset;
in_transmit<=not transmit;

DD:process(received, in_reset)
begin
if in_reset='1' then
led<=(others=>'0');
elsif received'event and received='1' then
led<=in_data;
end if;

end process DD;



neco:uart_transmitter generic map("1010001011000") port map(data, clock, in_reset, in_transmit, tx);
neco2:uart_receiver generic map("1010001011000") port map(in_data, received, clock, in_reset, rx);
end arch;