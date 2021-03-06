transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/TOSHIBA/Desktop/Maestria\ Docs\ Ingreso/semestre\ 2/Quartus/VidorFPGA-master/ip/SYSTEM_PLL {C:/Users/TOSHIBA/Desktop/Maestria Docs Ingreso/semestre 2/Quartus/VidorFPGA-master/ip/SYSTEM_PLL/SYSTEM_PLL.v}
vlog -sv -work work +incdir+C:/Users/TOSHIBA/Desktop/Maestria\ Docs\ Ingreso/semestre\ 2/Quartus/VidorFPGA-master/projects/vidor_pwm {C:/Users/TOSHIBA/Desktop/Maestria Docs Ingreso/semestre 2/Quartus/VidorFPGA-master/projects/vidor_pwm/MKRVIDOR4000_top.v}
vlog -sv -work work +incdir+C:/Users/TOSHIBA/Desktop/Maestria\ Docs\ Ingreso/semestre\ 2/Quartus/VidorFPGA-master/projects/vidor_pwm/db {C:/Users/TOSHIBA/Desktop/Maestria Docs Ingreso/semestre 2/Quartus/VidorFPGA-master/projects/vidor_pwm/db/system_pll_altpll.v}
vcom -93 -work work {C:/Users/TOSHIBA/Desktop/Maestria Docs Ingreso/semestre 2/Quartus/VidorFPGA-master/projects/vidor_pwm/pwm.vhd}
vcom -93 -work work {C:/Users/TOSHIBA/Desktop/Maestria Docs Ingreso/semestre 2/Quartus/VidorFPGA-master/projects/vidor_pwm/clk_prescaler.vhd}
vcom -93 -work work {C:/Users/TOSHIBA/Desktop/Maestria Docs Ingreso/semestre 2/Quartus/VidorFPGA-master/projects/vidor_pwm/servo_test_angle.vhd}

vcom -93 -work work {C:/Users/TOSHIBA/Desktop/Maestria Docs Ingreso/semestre 2/Quartus/VidorFPGA-master/projects/vidor_pwm/simulation/modelsim/servo_test_angle_testbench.vhd}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclone10lp_ver -L rtl_work -L work -voptargs="+acc"  servo_test_angle_testbench

add wave *
view structure
view signals
run -all
