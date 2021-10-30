
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Ejercicio2a is
	port(
		boton: in std_logic;
		leds: out std_logic_vector(0 to 2);
		motores: out std_logic_vector(1 downto 0));
end Ejercicio2a;

architecture Behavioral of Ejercicio2a is
	signal delay1,delay2,delay3,senal: std_logic;
begin


end Behavioral;

