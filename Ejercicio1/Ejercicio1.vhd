
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Ejercicio1 is
	Generic( 
				min:integer:=0;
				max:integer:=1000000;
				inc:integer:=1;
				width:integer:=1000000;
				N:integer:=11);
	port(
		clk: in std_logic;
		switches: in std_logic_vector(0 to 7):="00000000";
		leds: out std_logic_vector(0 to 7):="00000000");
end Ejercicio1;

architecture Behavioral of Ejercicio1 is
	
	signal clkdiv: std_logic_vector(N downto 0);  
	
	signal cnt0:  integer range 0 to 1000000:= 0;
	signal cnt1:  integer range 0 to 1000000:= 0;
	signal cnt2:  integer range 0 to 1000000:= 0;
	signal cnt3:  integer range 0 to 1000000:= 0;
	signal cnt4:  integer range 0 to 1000000:= 0;
	signal cnt5:  integer range 0 to 1000000:= 0;
	signal cnt6:  integer range 0 to 1000000:= 0;
	signal cnt7:  integer range 0 to 1000000:= 0;

	signal cntPWM0: integer range 0 to width:= 0;
	signal cntPWM1: integer range 0 to width:= 0;
	signal cntPWM2: integer range 0 to width:= 0;
	signal cntPWM3: integer range 0 to width:= 0;
	signal cntPWM4: integer range 0 to width:= 0;
	signal cntPWM5: integer range 0 to width:= 0;
	signal cntPWM6: integer range 0 to width:= 0;
	signal cntPWM7: integer range 0 to width:= 0;
	
	signal high0: integer range min to max := min;
	signal high1: integer range min to max := min;
	signal high2: integer range min to max := min;
	signal high3: integer range min to max := min;
	signal high4: integer range min to max := min;
	signal high5: integer range min to max := min;
	signal high6: integer range min to max := min;
	signal high7: integer range min to max := min;
	
	signal PWMleds: std_logic_vector(0 to 7):="00000000";
	
begin
	leds<=PWMleds;
	divisor:process(clk)
	begin
		if rising_edge(clk) then 
			clkdiv<=clkdiv + 1;
		end if;
	end process divisor;
	
	tiempocnt:process(clkdiv(N))
	begin
		if rising_edge(clkdiv(N)) then 
			if switches(0)='1' then
				cnt0<=cnt0+1;
				if cnt0=1000000 then cnt0<=cnt0;
				end if;
			else cnt0<=0;
			end if;

			if switches(1)='1' then
				cnt1<=cnt1+1;
				if cnt1=1000000 then cnt1<=cnt1;
				end if;
			else cnt1<=1;
			end if;
			
			if switches(2)='1' then
				cnt2<=cnt2+1;
				if cnt2=1000000 then cnt2<=cnt2;
				end if;
			else cnt2<=1;
			end if;
			
			if switches(3)='1' then
				cnt3<=cnt3+1;
				if cnt3=1000000 then cnt3<=cnt3;
				end if;
			else cnt3<=1;
			end if;
			
			if switches(4)='1' then
				cnt4<=cnt4+1;
				if cnt4=1000000 then cnt4<=cnt4;
				end if;
			else cnt4<=1;
			end if;
			
			if switches(5)='1' then
				cnt5<=cnt5+1;
				if cnt5=1000000 then cnt5<=cnt5;
				end if;
			else cnt5<=1;
			end if;
			
			if switches(6)='1' then
				cnt6<=cnt6+1;
				if cnt6=1000000 then cnt6<=cnt6;
				end if;
			else cnt6<=1;
			end if;
			
			if switches(7)='1' then
				cnt7<=cnt7+1;
				if cnt7=1000000 then cnt7<=cnt7;
				end if;
			else cnt7<=1;
			end if;
		end if;
	end process tiempocnt;
	
	pulso:process(clk)
	begin
		if rising_edge(clk) then
				cntPWM0<=cntPWM0+1;
				high0<=min+((cnt0)*(inc));
				if cntPWM0<=high0 then
					PWMleds(0)<='1';
				else
					PWMleds(0)<='0';
				end if;
			
				cntPWM1<=cntPWM1+1;
				high1<=min+((cnt1)*(inc));
				if cntPWM1<=high1 then
					PWMleds(1)<='1';
				else
					PWMleds(1)<='0';
				end if;
			
				cntPWM2<=cntPWM2+1;
				high2<=min+((cnt2)*(inc));
				if cntPWM2<=high2 then
					PWMleds(2)<='1';
				else
					PWMleds(2)<='0';
				end if;
			
				cntPWM3<=cntPWM3+1;
				high3<=min+((cnt3)*(inc));
				if cntPWM3<=high3 then
					PWMleds(3)<='1';
				else
					PWMleds(3)<='0';
				end if;
			
				cntPWM4<=cntPWM4+1;
				high4<=min+((cnt4)*(inc));
				if cntPWM4<=high4 then
					PWMleds(4)<='1';
				else
					PWMleds(4)<='0';
				end if;
			
				cntPWM5<=cntPWM5+1;
				high5<=min+((cnt5)*(inc));
				if cntPWM5<=high5 then
					PWMleds(5)<='1';
				else
					PWMleds(5)<='0';
				end if;
			
				cntPWM6<=cntPWM6+1;
				high6<=min+((cnt6)*(inc));
				if cntPWM6<=high6 then
					PWMleds(6)<='1';
				else
					PWMleds(6)<='0';
				end if;

				cntPWM7<=cntPWM7+1;
				high7<=min+((cnt7)*(inc));
				if cntPWM7<=high7 then
					PWMleds(7)<='1';
				else
					PWMleds(7)<='0';
				end if;
		else null;
		end if;
	end process pulso;
	
end Behavioral;


