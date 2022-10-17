local KickerRole2BallDir = function ()
    return CRole2BallDir("Kicker")
end

gPlayTable.CreatePlay{
firstState = "StateInit",

["StateInit"] = {
    switch = function ()
        if CIsGetBall("Receiver") then
            return "Set"
        end
    end,
    Kicker = task.GotoPos("Kicker",60,50,KickerRole2BallDir),
    Receiver = task.GetBall("Receiver","Kicker")
},

["Set"] = {
    switch = function ()
        if Cbuf_cnt(true,80) then
            return "PassBall"
        end
    end,
    Kicker = task.GotoPos("Kicker",60,50,KickerRole2BallDir),
    Receiver = task.ReceiverTask("GetBall")
},

["PassBall"] = {
    switch = function ()
        if Cbuf_cnt(CBall2RoleDist("Kicker") < 30,50) then
            return "Temp"
        end
    end,
    Receiver = task.ReceiverTask("Shoot5"),
    Kicker = task.RobotHalt("Kicker")
},

["Temp"] = {
    switch = function ()
        if COurRole_x("Receiver") < 10 then
            return "Shoot"
        end
    end,
    Receiver = task.GotoPos("Receiver",0,0,0),
    Kicker = task.GotoPos("Kicker",50,50,0)
},

["Shoot"] = {
    switch = function ()
        if Cbuf_cnt(true,200) then
            return "finish"
        end
    end,
    Kicker = task.KickerTask("Shoot"),
    Receiver = task.RobotHalt("Receiver")
},


name = "123"

}