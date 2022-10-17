KickDir = function()
   return CRole2BallDir("Kicker")
end
 
ReceDir = function()
   return CRole2BallDir("Receiver")
end
 
gPlayTable.CreatePlay{
firstState="Go",

["Go"] = {
   switch = function()
      if (COurRole_x("Receiver")>1) then
         return "Back"
      end
   end,
   Receiver=task.GotoPos("Receiver",0,0,0)
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
            return "GetBall"
      end
   end,
   --Receiver=task.GotoPos("Receiver",240,-180)
},

["GetBall"] = {
   switch = function()
      if CIsGetBall("Kicker") then
         return "Shoot"
      end
   end,
   Kicker = task.GetBall("Kicker","Kicker")
},

["Shoot"] = {
   switch = function()
      if CIsBallKick("Kicker") then
         return "finish"
      end
   end,
   --Receiver = task.GotoPos("Receiver",175,-180),
   --Receiver = task.RobotHalt("Receiver"),
   --Kicker = task.KickerTask("shemen")
   Kicker = task.KickerTask("shoot_test2")
},

name="zhuangqiu"
 
}