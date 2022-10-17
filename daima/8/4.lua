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
   Kicker= task.GotoPos("Kicker",120,0,KickDir),
   Receiver=task.GetBall("Receiver","Receiver"),
   Goalie=task.Goalie()
},

["PassBall"]={
   switch=function()
      --if CBall2RoleDist("Kicker") < 50 then
      if CIsBallKick("Receiver") then
         return "Back"
      end
   end,
   Kicker= task.GotoPos("Kicker",120,0,KickDir),
   --Receiver=task.ReceiverTask("oppshoot1"),
   Receiver=task.ReceiverTask("oppshoot2"),
   Goalie=task.Goalie()
},

["Back"]={
   switch=function()
      if (COurRole_x("Receiver")>298) then
      --if (COurRole_x("Receiver")>298) then
         return"Temp"
      end
   end,
   Receiver=task.GotoPos("Receiver",300,200,0)
   --Receiver=task.GoRecePos("Receiver")
},

["Temp"]={
   switch=function()
      if Cbuf_cnt(true,50) then
            return "GetBall1"
      end
   end,
   --Receiver=task.GotoPos("Receiver",-200,0)
},

["GetBall1"] = {
   switch = function()
      if CIsGetBall("Kicker") then
         return "Shoot"
      end
   end,
   Kicker=task.GetBall("Kicker","Kicker")
},

["Shoot"]={
   switch = function()
      if CIsBallKick("Kicker") then
         return "finish"
      end
   end,
   --Kicker = task.KickerTask("Shoot")
   --Kicker = task.KickerTask("shemen")
   Kicker = task.KickerTask("shemen_test4")
},

name="4"

}