
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Ejercicio2a is
	Generic(N:integer:=5);
	port(
		clk,boton: in std_logic;
		leds: out std_logic;
		motores: out std_logic_vector(1 downto 0));
end Ejercicio2a;

architecture Behavioral of Ejercicio2a is
	type edos is (EA,EP);
	signal ASM:edos:=EA;
	
	signal delay1,delay2,delay3,delay4,senal: std_logic;
	signal clkdiv: std_logic_vector(N downto 0);
	signal estado:  integer range 0 to 1:= 0;
begin

	divisor:process(clk)
	begin
		if rising_edge(clk) then
			clkdiv<=clkdiv + 1;
		end if;
	end process divisor;
	
	debounce:process(clkdiv(N),delay1,delay2,delay3)
	begin
		if rising_edge(clkdiv(N)) then
			delay1<=boton;
			delay2<=delay1;
			delay3<=delay2;
		end if;
		senal<=delay1 and delay2 and delay3;
	end process debounce;
	leds<=senal;
	
	activacion: process(boton,estado,clk)
	begin
		if rising_edge(clk)and boton='1' then
			estado<=estado+1;
		end if;
		if estado=1 then
			motores<="11";
		else 
			motores<="00";
		end if;
	end process activacion;

end Behavioral;

