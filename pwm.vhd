--------------------------------------------------------------------------------
--
--   FileName:         pwm.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-bit Version 12.1 Build 177 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 8/1/2013 Scott Larson
--     Initial Public Release
--   Version 2.0 1/9/2015 Scott Larson
--     Transistion between duty cycles always starts at center of pulse to avoid
--     anomalies in pulse shapes
--    
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY pwm IS
  GENERIC(
      sys_clk         : INTEGER := 50_000_000; --system clock frequency in Hz
      pwm_freq        : INTEGER := 100_000;    --PWM switching frequency in Hz
      bits_resolution : INTEGER := 4;          --bits of resolution setting the duty cycle
      phases          : INTEGER := 1);         --number of output pwms and phases
  PORT(
      clk       : IN  STD_LOGIC;                                    --system clock
      reset_n   : IN  STD_LOGIC;                                    --asynchronous reset
      enable    : IN  STD_LOGIC;                                    --latches in new duty cycle
      duty      : IN  STD_LOGIC_VECTOR(bits_resolution-1 DOWNTO 0); --duty cycle
      pwm_out   : OUT STD_LOGIC_VECTOR(phases-1 DOWNTO 0));         --pwm outputs
END pwm;

ARCHITECTURE logic OF pwm IS
--type stateMachine_type is (Init_State, High_State,Low_State); -- Estados de PWM
--signal Current_StateMachine,Next_StateMachine : stateMachine_type; --contiene el estado de la maquina de estados
signal count: STD_LOGIC_VECTOR(bits_resolution-1 DOWNTO 0); --contador de pulso
signal Max_val: STD_LOGIC_VECTOR(bits_resolution-1 DOWNTO 0) := (others => '1');
BEGIN

process(clk) -- Counting
begin
	if(clk'event and clk = '1') then
		if (count < (Max_val-1)) then ---mod
			count <= count + 1;
		else
			count <= (others => '0');
		end if;
	end if;
end process;

process(clk) -- Pulsing
begin
	if(clk'event and clk = '1') then
		if (duty > count) then
			pwm_out <= "1";
		else
			pwm_out <= "0";
		end if;
	end if;
end process;
	
	--pwm_out <= "1" when count < duty else "1";
	
--	process(reset_n,count)
--   begin
--		if reset_n='1' then
--			Next_StateMachine <= Init_State;
--		elsif(rising_edge(clk)) then
--			if ena ='1' then
--				if duty >= count then
--					Next_StateMachine <= High_State;
--				else
--					Next_StateMachine <= Low_State;
--				end if;
--				count <= count +1;
--			else
--				Next_StateMachine <= Current_StateMachine;
--				count <= count;
--			end if;
--		end if;
--	end process;
--	
--	Current_StateMachine <= Next_StateMachine;

	--Proceso para dar atencion inmediata al reset y cambio de estado
--	process(clk, reset_n)
--	begin
--		if (reset = '1') then -- go to state Init if reset
--			Current_StateMachine <= Init_State;
--		elsif (clk'event and clk = '1') then -- otherwise update the states
--			Current_StateMachine <= Next_StateMachine;
--		else
--			null;
--		end if; 
--	end process;
--	--Proceso de logica 
--	--Mealy Design
--	process(Current_StateMachine, ena,count,duty)
--	begin 
--		-- store current state as next
--		Next_StateMachine <= Current_StateMachine; --required: when no case statement is satisfied
--		case Current_StateMachine is 
--			when zero =>  -- set 'tick = 1' if state = zero and level = '1'
--
--			when one =>  
--
--        end case; 
--    end process;

END logic;