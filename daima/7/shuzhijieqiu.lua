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
   
   Kicker=task.KickerTask("jieqiu"),
   Receiver = task.ReceiverTask("getball_task"),
   Goalie = task.Goalie()
},
 
["PassBall"] = {
   switch = function ()
      if CBall2RoleDist("Kicker") < 30 then
            return "Shoot"
      end
   end,
   kicker= task.KickerTask("jieqiu"),
   Receiver = task.ReceiverTask("passball1"),
   Goalie = task.Goalie()
},--[[
["Temp1"]={
   switch=function()
      if CIsBallKick("Receiver") then
            return "Shoot"
      end
   end,
   Receiver=task.GotoPos("Receiver",240,-180,0),
   Kicker= 
},]]


 
["Shoot"] = {
   switch = function()
      if CIsBallKick("Kicker") then
         return "finish"
      end
   end,
   --Receiver = task.GotoPos("Receiver",175,-180),
   Receiver = task.GotoPos("Receiver",-150, 0,0),
   Kicker = task.KickerTask("shemen_test"),
   Goalie = task.Goalie()
},
 
name="shuzhijieqiu"
 
}