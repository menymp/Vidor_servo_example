LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 
ENTITY servo_test_angle_testbench  IS 
END ; 
 
ARCHITECTURE servo_test_angle_testbench_arch OF servo_test_angle_testbench IS
  SIGNAL AngleValueOut   :  std_logic_vector (12 downto 0)  ; 
  SIGNAL CountAngle   :  std_logic_vector (1 downto 0)  ; 
  COMPONENT servo_test_angle  
    PORT ( 
      AngleValueOut  : out std_logic_vector (12 downto 0) ; 
      CountAngle  : in std_logic_vector (1 downto 0) ); 
  END COMPONENT ; 
BEGIN
  DUT  : servo_test_angle  
    PORT MAP ( 
      AngleValueOut   => AngleValueOut  ,
      CountAngle   => CountAngle   ) ; 



-- "Counter Pattern"(Range-Up) : step = 1 Range(00-11)
-- Start Time = 0 ps, End Time = 2 us, Period = 300 ns
  Process
	variable VARCountAngle  : std_logic_vector (1 downto 0);
	Begin
	 CountAngle  <= "00"  ;
	wait for 300 ns ;
	 CountAngle  <= "01"  ;
	wait for 300 ns ;
	 CountAngle  <= "10"  ;
	wait for 300 ns ;
	 CountAngle  <= "11"  ;
	wait for 300 ns ;
-- dumped values till 2 ns
	wait;
 End Process;
END;
