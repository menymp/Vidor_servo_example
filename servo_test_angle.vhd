library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
  
entity servo_test_angle is
	port (	CountAngle      : IN  STD_LOGIC_VECTOR(1 DOWNTO 0); --caso
				AngleValueOut   : OUT STD_LOGIC_VECTOR(12 DOWNTO 0));
end servo_test_angle;
  
architecture bhv of servo_test_angle is  
begin
  
	AngleValueOut <=	"0000110011010" when CountAngle = "00" else -- 0 grados
							"0001001100110" when CountAngle = "01" else -- 90 grados
							"0001001100110" when CountAngle = "10" else -- 90 grados
							"0001100110011" when CountAngle = "11";		 --180 grados
  
end bhv;