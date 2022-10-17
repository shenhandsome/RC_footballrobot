--desc: 
local Kickerdir2Receiverdir = function()
	return COurRole2RoleDir("Kicker", "Receiver")
end

local CReceiver2OppGoalDir = function()
	return CRole2OppGoalDir("Receiver")
end

--两机器人间距离
local Kicker2Receiver = function()
	return COurRole2RoleDist("Kicker", "Receiver")
end

gPlayTable.CreatePlay{
firstState = "GetBall",

["GetBall"] = {
	switch = function()
		if CBall2RoleDist("Receiver") < 20 and CIsGetBall("Receiver") then
			return "PassBall"
		end
	end,
	Kicker   = task.GotoPos("Kicker",140,0,Kickerdir2Receiverdir),
	Receiver = task.GetBall("Receiver","Receiver"),
},

["PassBall"] = {
	switch = function()
		if CBall2RoleDist("Kicker") < 20 then
			return "CDir"
		end
	end,
	-- 机器人急停
	Kicker   = task.RobotHalt("Kicker"),
	Receiver = task.ReceiverTask("passball_power25"),
},

["CDis"] = {
	switch = function()
		if Kicker2Receiver < 80 then
			return "CDir"
		end
	end,
	Kicker   = task.GotoPos("Kicker",140,0,CReceiver2OppGoalDir),
	Receiver = task.ReceiverTask("passball_power25"),
},


["CDir"] = {
	switch = function()
		if Cbuf_cnt(1,50) then
			return "Shoot"
		end
	end,
	Kicker   = task.GotoPos("Kicker",140,0,CReceiver2OppGoalDir),
	Receiver = task.ReceiverTask("passball_power25"),
	Receiver = task.GotoPos("Receiver",100,-60,Kickerdir2Receiverdir),
	--Receiver = task.RobotHalt("Receiver"),	
},




["Shoot"] = {
	switch = function()
		if CIsBallKick("Kicker") then
			return "finish"
		end
	end,
	Kicker = task.KickerTask("shemen"),
	Receiver = task.RobotHalt("Receiver"),
},

name = "3"
}