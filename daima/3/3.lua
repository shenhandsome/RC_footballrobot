KickDir = function()
   return CRole2BallDir("Kicker")
end

ReceDir = function()
   return CRole2BallDir("Receiver")
end

gPlayTable.CreatePlay{
firstState="GetBall",

["GetBall"] = {
   switch = function()
      if CIsGetBall("Receiver") then
         return "PassBall"
      end
   end,
   Kicker   = task.GotoPos("Kicker",120,110,KickDir),
   Receiver = task.GetBall("Receiver","Receiver"),
   Goalie = task.Goalie()
},

["PassBall"] = {
    switch = function ()
        if CBall2RoleDist("Kicker") < 30 then
            return "Temp"
        end
    end,
    Kicker   = task.GotoPos("Kicker",120,110,KickDir),
    Receiver = task.ReceiverTask("passBall"),
    Goalie = task.Goalie()
},

["Temp"]={
   switch=function()
      if Cbuf_cnt(1,5) then
            return "Shoot"
      end
   end,
   Receiver=task.GotoPos("Receiver",240,-180)

},

["Shoot"] = {
   switch = function()
      if CIsBallKick("Kicker") then
         return "finish"
      end
   end,
   --Receiver = task.GotoPos("Receiver",175,-180),
   Receiver = task.RobotHalt("Receiver"),
   Kicker = task.KickerTask("Shoot"),
   Goalie = task.Goalie()
},

name="3"

}