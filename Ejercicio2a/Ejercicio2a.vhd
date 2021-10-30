
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Ejercicio2a is
	Generic(N:integer:=5;
				COUNT_MAX : integer := 5);
	port(
		clk,boton: in std_logic;
		leds: out std_logic;
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
	
	signal count : integer := 0;
	type state_type is (idle,wait_time); --state machine
	signal state : state_type := idle;

	
begin
	divisor:process(clk)
	begin
		if rising_edge(clk) then 
			clkdiv<=clkdiv + 1;
		end if;
	end process divisor;
	
	debounce: process(clkdiv(N))
	begin
		if rising_edge(clkdiv(N)) then
			case (state) is
				when idle =>
					if boton = '1' then  
					  state <= wait_time;
					else
					  state <= idle; --wait until button is pressed.
					end if;
					senal <= '0';
				when wait_time =>
					if(count = COUNT_MAX) then
						count <= 0;
						if boton = '1' then
							senal <= '1';
						end if;
						 state <= idle;  
					else
						count <= count + 1;
					end if; 
			end case;       
		 end if;        
	end process debounce;
	leds<=senal;
	
--	debounce:process(clk,delay1,delay2,delay3)
--	begin
--		if rising_edge(clk) then
--			delay1<=boton;
--			delay2<=delay1;
--			delay3<=delay2;
--		end if;
--		senal<=delay1 and delay2 and delay3;
--	end process debounce;
--	leds<=senal;
	
	activacion: process(clkdiv(N),senal)
	begin
		if rising_edge(clkdiv(N)) then
			if senal='1' then
				estado<=estado+1;
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
