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
      if CBall2RoleDist("Receiver") < 50 then
         return "PassBall"
      end
   end,
   Kicker   = task.GotoPos("Kicker",120,110,KickDir),
   Receiver = task.GetBall("Receiver","Receiver"),
   Goalie = task.Goalie()
},
 
["PassBall"] = {
   switch = function ()
      --if CBall2RoleDist("Kicker") < 30 then
      if CIsBallKick("Kicker") then
            return "Back"
         end
      end,
   Kicker   = task.GotoPos("Kicker",120,110,KickDir),
   Receiver = task.ReceiverTask("passballour10"),
   Goalie = task.Goalie()
},

["Back"]={
   switch=function()
      if (COurRole_x("Receiver")<-190) then
         return"Temp"
      end
   end,
   Receiver=task.GotoPos("Receiver",-200,0,0)
   --Receiver=task.GoRecePos("Receiver")
},
 
["Temp"]={
   switch=function()
      if Cbuf_cnt(1,50) then
            return "Shoot"
      end
   end,
   --Receiver=task.GotoPos("Receiver",240,-180)
 
},
 
["Shoot"] = {
   switch = function()
      if CIsBallKick("Kicker") then
         return "finish"
      end
   end,
    --Receiver = task.GotoPos("Receiver",175,-180),
    --Receiver = task.RobotHalt("Receiver"),
    Kicker = task.KickerTask("shemen_test4"),
    Goalie = task.Goalie()
},
 
name="2"
 
}
