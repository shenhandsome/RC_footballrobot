local Kickerdir2Receiverdir = function()
	return COurRole2RoleDir("Kicker", "Receiver")
end

local CReceiver2OppGoalDir = function()
	return CRole2OppGoalDir("Receiver")
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
			return "Dir"
		end
	end,
	Kicker   = task.RobotHalt("Kicker"),
	Receiver = task.ReceiverTask("passball4"),
},

["Dir"] = {
	switch = function()
		if Cbuf_cnt(1,50) then
			return "Shoot"
		end
	end,
	Kicker   = task.GotoPos("Kicker",140,0,CReceiver2OppGoalDir),
	Receiver = task.ReceiverTask("passball4"),
},


["Shoot"] = {
	switch = function()
		if CIsBallKick("Kicker") then
			return "finish"
		end
	end,
	Kicker = task.KickerTask("shoot6"),
	Receiver = task.RobotHalt("Receiver"),
},

name = "4"
}