
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Ejercicio2b is
	Generic( 
				min:integer:=0;
				max:integer:=1000000;
				inc:integer:=333333;
				width:integer:=1000000;
				N:integer:=15);
	port(
		clk,boton: in std_logic;
		prueba: out std_logic;
		leds: out std_logic_vector(1 to 3):="000";
		motores: out std_logic);
end Ejercicio2b;

architecture Behavioral of Ejercicio2b is
	type edos is (EA,EB,EC,EP);
	signal FSM:edos:=EP;
	
	signal clkdiv: std_logic_vector(N downto 0);  
	signal delay1: std_logic:='0';
	signal delay2: std_logic:='0';
	signal delay3: std_logic:='0';
	signal senal: std_logic:='0';
	signal estado:  integer range 0 to 3:= 0;

	signal cntPWM: integer range 1 to width:= 1;  
	signal high: integer range min to max := min;
	
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
	
	--leds<=senal;
	
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
	
	MaqEdo:process(clkdiv(N))
	begin
		if rising_edge(clkdiv(N)) then
			case FSM is
				when EP => 
					if estado = 0 then 
						FSM <= EP; 
						leds<="000";
					else 
						FSM <= EA;  
					end if;
				when EA =>
					if estado = 1 then 
						FSM <= EA; 
						leds<="100";
					else 
						FSM <= EB;  
					end if;
				when EB =>
					if estado = 2 then 
						FSM <= EB; 
						leds<="110";
					else 
						FSM <= EC; 
					end if;
				when EC =>
					if estado = 3 then 
						FSM <= EC; 
						leds<="111";
					else 
						FSM <= EP; 
					end if;
				when others => null;
			end case;
		end if;
	end process MaqEdo;
	
	pulso:process(clk)
	begin
		if rising_edge(clk) then
			cntPWM<=cntPWM+1;
			high<=min+((estado)*(inc));
			if cntPWM<=high then
				motores<='1';
			else
				motores<='0';
			end if;
		else null;
		end if;
	end process pulso;
	
end Behavioral;

