gPlayTable.CreatePlay{
firstState = "StateInit",
["StateInit"] = {
    switch = function ()
        if Cbuf_cnt(CIsGetBall("Kicker"),100) then
            return "Shoot"
        end
    end,
    Kicker = task.KickerTask("get"),
    Receiver = task.RobotHalt("Receiver")
},

["Shoot"] = {
    switch = function ()
        if CIsBallKick("Kicker") then
            return "finish"
        end 
    end,
    --Kicker = task.KickerTask("shoot_test2"),
    Kicker = task.KickerTask("dianqiu_26"),
    Receiver = task.RobotHalt("Receiver")
},
name = "5-1"
}