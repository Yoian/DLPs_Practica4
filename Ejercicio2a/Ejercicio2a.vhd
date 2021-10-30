
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Ejercicio2a is
	Generic(N:integer:=5);
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
	signal estadoA:  std_logic:='0';--integer range 0 to 1:= 0;
	
	
begin
	divisor:process(clk)
	begin
		if rising_edge(clk) then 
			clkdiv<=clkdiv + 1;
		end if;
	end process divisor;
	
	debounce:process(clk)
	begin
		if rising_edge(clk) then
			delay1<=boton;
			delay2<=delay1;
			delay3<=delay2;
		end if;
		
	end process debounce;
	senal<=delay1 and delay2 and delay3;
	leds<=senal;
	
	activacion: process(senal)
		variable estadoB:  std_logic:='0';
	begin
		--if rising_edge(clk) then
			if falling_edge(senal) then
				estadoB:=not estadoB;
			else
				estadoB:=estadoB;
			end if;
		estadoA<=estadoB;	
		--end if;
	end process activacion;
	prueba<=estadoA;
	
	MaqEdo:process(estadoA,clk)
	begin
		if rising_edge(clk) then
			case FSM is
				when EP => 
					if estadoA = '0' then 
						FSM <= EP; 
						motores<="00";
					else 
						FSM <= EA; 
						motores<="11"; 
					end if;
				when EA =>
					if estadoA = '0' then 
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
