--desc: 
local Kicker2BallDir = function ()
    return CRole2BallDir("Kicker")
end

local y = function()
    if CGetBallY() > 0 then
        return -50
    else return 50
    end
end

local ny = function()
    if CGetBallY() > 0 then
        return 50
    else return -50
    end
end

gPlayTable.CreatePlay{
firstState = "GetBall",

--取球
--前锋到达容易射门点
--中场面向球门取球
--中场确认取球后执行传球
["GetBall"] = {
    switch = function ()
        if CIsGetBall("Receiver") then
            return "PassBall"
        end
    end,
    Kicker = task.GotoPos("Kicker",60,y,Kicker2BallDir),
    Receiver = task.GetBall("Receiver","Receiver")
},


--传球
--朝向球门中心轻轻踢球
--待稳定后中场撤离
["PassBall"] = {
    switch = function ()
        if Cbuf_cnt(true,80) then
            return "CDis"
        -- if Cbuf_cnt( CIsBallKick("Receiver"),80) then
        --     return "CDis"
        -- elseif CIsBallKick("Receiver") == false and not CIsGetBall("Receiver") then
        --     return "GetBall2"
        end
    end,
    Receiver = task.ReceiverTask("Shoot8_20"),
    -- Kicker = task.GetBall("Kicker","Kicker")
    -- Kicker = task.RobotHalt("Kicker")
},

["GetBall2"] = {
    switch = function ()
        if CIsGetBall("Receiver") then
            return "PassBall"
        end
    end,
    Kicker = task.GotoPos("Kicker",60,y,Kicker2BallDir),
    Receiver = task.GetBall("Receiver","Receiver")
},

["CDis"] = {
    switch = function ()
        if COurRole_x("Receiver") < -50 then
            return "Shoot"
        end
    end,
    Receiver = task.GotoPos("Receiver",-100,0,0),
    --Kicker = task.GotoPos("Kicker",100,ny,0)
},

["Shoot"] = {
    switch = function ()
        if Cbuf_cnt(true,80) then
            return "finish"
        end
    end,
    -- Kicker = task.GetBall("Kicker", "Kicker"),
    Kicker = task.KickerTask("shemen"),
    -- Kicker = task.Shoot("Kicker"),
    Receiver = task.RobotHalt("Receiver")
},


name = "4"

}