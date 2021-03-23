LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.STD_LOGIC_UNSIGNED.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 
ENTITY pwm_testbench  IS 
  GENERIC (
    phases  : INTEGER   := 1 ;  
    sys_clk  : INTEGER   := 50000000 ;  
    bits_resolution  : INTEGER   := 4 ;  
    pwm_freq  : INTEGER   := 100000 ); 
END ; 
 
ARCHITECTURE pwm_testbench_arch OF pwm_testbench IS
  SIGNAL reset_n   :  STD_LOGIC  ; 
  SIGNAL duty   :  std_logic_vector (bits_resolution - 1 downto 0)  ; 
  SIGNAL clk   :  STD_LOGIC  ; 
  SIGNAL pwm_out   :  std_logic_vector (phases - 1 downto 0)  ; 
  SIGNAL enable   :  STD_LOGIC  ; 
  COMPONENT pwm  
    GENERIC ( 
      phases  : INTEGER ; 
      sys_clk  : INTEGER ; 
      bits_resolution  : INTEGER ; 
      pwm_freq  : INTEGER  );  
    PORT ( 
      reset_n  : in STD_LOGIC ; 
      duty  : in std_logic_vector (bits_resolution - 1 downto 0) ; 
      clk  : in STD_LOGIC ; 
      pwm_out  : out std_logic_vector (phases - 1 downto 0) ; 
      enable  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : pwm  
    GENERIC MAP ( 
      phases  => phases  ,
      sys_clk  => sys_clk  ,
      bits_resolution  => bits_resolution  ,
      pwm_freq  => pwm_freq   )
    PORT MAP ( 
      reset_n   => reset_n  ,
      duty   => duty  ,
      clk   => clk  ,
      pwm_out   => pwm_out  ,
      enable   => enable   ) ; 



-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ps, End Time = 2 us, Period = 100 ns
  Process
	Begin
	 clk  <= '0'  ;
	wait for 50 ns ;
-- 50 ns, single loop till start period.
	for Z in 1 to 2000
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
-- Start Time = 0 ps, End Time = 2 us, Period = 0 ps
  Process
	Begin
	 reset_n  <= '0'  ;
	wait for 200000 ns ;
-- dumped values till 2 ns
	wait;
 End Process;


-- "Constant Pattern"
-- Start Time = 0 ps, End Time = 2 us, Period = 0 ps
  Process
	Begin
	 enable  <= '1'  ;
	wait for 200000 ns ;
-- dumped values till 2 ns
	wait;
 End Process;


-- "Constant Pattern"
-- Start Time = 0 ps, End Time = 2 us, Period = 0 ps
  Process
	Begin
	 duty  <= "0100"  ;
	wait for 200000 ns ;
-- dumped values till 2 ns
	wait;
 End Process;
END;
