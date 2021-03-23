LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 
ENTITY clk_prescaler_testbench  IS 
  GENERIC (
    prescaler  : INTEGER   := 10 ); 
END ; 
 
ARCHITECTURE clk_prescaler_testbench_arch OF clk_prescaler_testbench IS
  SIGNAL clk   :  STD_LOGIC  ; 
  SIGNAL clock_out   :  STD_LOGIC  ; 
  SIGNAL reset   :  STD_LOGIC  ; 
  COMPONENT clk_prescaler  
    GENERIC ( 
      prescaler  : INTEGER  );  
    PORT ( 
      clk  : in STD_LOGIC ; 
      clock_out  : out STD_LOGIC ; 
      reset  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : clk_prescaler  
    GENERIC MAP ( 
      prescaler  => prescaler   )
    PORT MAP ( 
      clk   => clk  ,
      clock_out   => clock_out  ,
      reset   => reset   ) ; 



-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ns, End Time = 1 us, Period = 100 ns
  Process
	Begin
	 clk  <= '0'  ;
	wait for 50 ns ;
-- 50 ns, single loop till start period.
	for Z in 1 to 20
	loop
	    clk  <= '1'  ;
	   wait for 50 ns ;
	    clk  <= '0'  ;
	   wait for 50 ns ;
-- 950 ns, repeat pattern in loop.
	end  loop;
	 clk  <= '1'  ;
	wait for 50 ns ;
-- dumped values till 1 us
	wait;
 End Process;


-- "Constant Pattern"
-- Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  Process
	Begin
    clk  <= '1'  ; --esto es un reset inicial por 50 ns
	 wait for 50 ns ;
	 reset  <= '0'  ;
	wait for 1 us ;
-- dumped values till 1 us
	wait;
 End Process;
END;
