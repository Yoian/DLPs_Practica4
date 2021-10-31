
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Ejercicio2a is
	Generic(N:integer:=15);
	port(
		clk,boton: in std_logic;
		leds,prueba: out std_logic;
		motores: out std_logic_vector(1 downto 0));
end Ejercicio2a;

architecture Behavioral of Ejercicio2a is
	type edos is (EA,EP);
	signal FSM:edos:=EP;
	
	signal clkdiv: std_logic_vector(N downto 0);  
	signal delay1: std_logic:='0';
	signal delay2: std_logic:='0';
	signal delay3: std_logic:='0';
	signal senal: std_logic:='0';
	signal estado:  integer range 0 to 1:= 0;
	
begin
	divisor:process(clk)
	begin
		if rising_edge(clk) then 
			clkdiv<=clkdiv + 1;
		end if;
	end process divisor;
	
	debounce:process(clkdiv(N),boton)
	begin
		if rising_edge(clkdiv(N)) then
			delay1<=boton;
			delay2<=delay1;
			delay3<=delay2;
			senal<=delay1 and delay2 and delay3;
		end if;
		
	end process debounce;
	
	leds<=senal;
	--senal<=delay1 and delay2 and delay3;
	
	activacion: process(senal,clkdiv(N))
	begin
		if rising_edge(clkdiv(N)) then
			if falling_edge(senal) then
				estado<=estado+1;
			else
				estado<=estado;
			end if;
		end if;
	end process activacion;
	
	MaqEdo:process(estado,clkdiv(N))
	begin
		if rising_edge(clkdiv(N)) then
			case FSM is
				when EP => 
					if estado = 0 then 
						FSM <= EP; 
						motores<="00";
					else 
						FSM <= EA; 
						motores<="11"; 
					end if;
				when EA =>
					if estado = 0 then 
						FSM <= EP; 
						motores<="00";
					else 
						FSM <= EA; 
						motores<="11"; 
					end if;
				when others => null;
			end case;
		end if;
	end process MaqEdo;
	
end Behavioral;
