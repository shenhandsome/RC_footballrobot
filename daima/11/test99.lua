a=CGetBallX()
b=CGetBallY()
KickDir = function()
   return CRole2BallDir("Kicker")
end
 
ReceDir = function()
   return CRole2BallDir("Receiver")
end

gPlayTable.CreatePlay{
firstState="Run",

["Run"] = {
   switch = function()
      if (COurRole_x("Receiver")>(a-41)) then
         return "PassBall"
      end
   end,
   Kicker= task.GotoPos("Kicker",120,110,KickDir),
   Receiver=task.GotoPos("Receiver",a-40,b,ReceDir),
   Goalie=task.Goalie()
},

["PassBall"]={
   switch=function()
      --if CBall2RoleDist("Kicker") < 50 then
      if ((CGetBallX()~=a) or (CGetBallY()~=b))then
         return "Back"
      end
   end,
   Kicker= task.GotoPos("Kicker",120,110,KickDir),
   --Receiver=task.ReceiverTask("shoot010"),
   Receiver=task.GotoPos("Receiver",a,b,ReceDir),
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

name="test99"

}