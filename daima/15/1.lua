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
   Kicker= task.GotoPos("Kicker",120,110,KickDir),
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
   Kicker= task.GotoPos("Kicker",120,110,KickDir),
   Receiver=task.ReceiverTask("shoot015"),
   --Receiver=task.ReceiverTask("shoot012"),
   Goalie=task.Goalie()
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
      if Cbuf_cnt(true,50) then
            return "GetBall1"
      end
   end,
   --Receiver=task.GotoPos("Receiver",-200,0)
},

["GetBall1"] = {
   switch = function()
      if CIsGetBall("Kicker") then
         return "Judge"
      end
   end,
   Kicker=task.GetBall("Kicker","Kicker")
},

["Judge"] = {
   switch = function()
     if (COurRole_y("Kicker")<-5) then
         return "Shoot2"
         else
         return "Shoot1"
      end
   end,
},

["Shoot1"]={
   switch = function()
      if CIsBallKick("Kicker") then
         return "finish"
      end
   end,
   Kicker = task.KickerTask("shemen_test4")
   --Kicker = task.KickerTask("shemen")
   --Kicker = task.KickerTask("shoot_test2")
},

["Shoot2"]={
   switch = function()
      if CIsBallKick("Kicker") then
         return "finish"
      end
   end,
   Kicker = task.KickerTask("test")
   --Kicker = task.KickerTask("shemen")
   --Kicker = task.KickerTask("shoot_test2")
},

name="1"

}