
set labelCount 4                                             
set uniqueLabel 378579184
#################################################################################


##Editing for Signal sim:/pwm/clk
# "Clock Pattern" : dutyCycle = 50
# Start Time = 0 ps, End Time = 2 us, Period = 100 ns
#################################################################################


noforce sim:/pwm/clk
force -freeze sim:/pwm/clk 0 0 ps,1 50000 ps  -repeat 100000 ps -cancel @2000000 ps

        noforce sim:/pwm/clk
        force -freeze sim:/pwm/clk  0 0 ps, 1 50000 ps

when -label 378579184_1 {$now = @2000 ps} {
        set whenArray(378579184_1) 378579184_1
        noforce sim:/pwm/clk
        force -freeze sim:/pwm/clk 0 0 ps
}


##Editing for Signal sim:/pwm/reset_n
# "Constant Pattern"
# Start Time = 0 ps, End Time = 2 us, Period = 0 ps
#################################################################################

        noforce sim:/pwm/reset_n
        force -freeze sim:/pwm/reset_n 0 0 ps 

        noforce sim:/pwm/reset_n
        force -freeze sim:/pwm/reset_n  0 0 ps

when -label 378579184_2 {$now = @2000 ps} {
        set whenArray(378579184_2) 378579184_2
        noforce sim:/pwm/reset_n
        force -freeze sim:/pwm/reset_n 0 0 ps
}


##Editing for Signal sim:/pwm/enable
# "Constant Pattern"
# Start Time = 0 ps, End Time = 2 us, Period = 0 ps
#################################################################################

        noforce sim:/pwm/enable
        force -freeze sim:/pwm/enable 1 0 ps 

        noforce sim:/pwm/enable
        force -freeze sim:/pwm/enable  1 0 ps

when -label 378579184_3 {$now = @2000 ps} {
        set whenArray(378579184_3) 378579184_3
        noforce sim:/pwm/enable
        force -freeze sim:/pwm/enable 1 0 ps
}


##Editing for Signal sim:/pwm/duty
# "Constant Pattern"
# Start Time = 0 ps, End Time = 2 us, Period = 0 ps
#################################################################################

        noforce sim:/pwm/duty
        force -freeze sim:/pwm/duty 0000 0 ps 

        noforce sim:/pwm/duty
        force -freeze sim:/pwm/duty  0100 0 ps

when -label 378579184_4 {$now = @2000 ps} {
        set whenArray(378579184_4) 378579184_4
        noforce sim:/pwm/duty
        force -freeze sim:/pwm/duty 0100 0 ps
}
