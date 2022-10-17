kickerdir = function()
	return CRole2BallDir("Kicker")
end

ReceiverDir = function()
	return CRole2BallDir("Receiver")
end

oppGoalDir = function()
	return CRole2OppGoalDir("Receiver")
end

gPlayTable.CreatePlay{

firstState = "start",
	
["start"] = {
	switch = function ()
		if CNormalStart() then
			return "KickOff"
		elseif CGameOn() then
			return "finish"
		end
	end,
	Kicker = task.GotoPos("Kicker",100,100,kickerdir),
	Receiver = task.GotoPos("Receiver",-50,0,ReceiverDir),
	Goalie = task.Goalie()
},

["KickOff"] = {
	switch = function()
		if CGameOn() then
			return "finish"
		elseif CIsGetBall("Receiver") then
			return "passball"
		end
	end,
	Receiver= task.GetBall("Receiver","Kicker"),
	Kicker = task.GotoPos("Kicker",100,100,kickerdirr),
	Goalie = task.Goalie()
},

["passball"] = {
	switch = function()
		if CIsBallKick("Receiver")then
			return "Shoot"
		end
	end,
	Receiver = task.ReceiverTask("passball2"),
	Kicker = task.GotoPos("Kicker",100,100,kickerdir),
	Goalie = task.Goalie()
},

["Shoot"] = {
	switch = function()
		if CIsBallKick("Kicker")then
			return "finish"
		end
	end,
	Receiver = task.GotoPos("Receiver",-100,-100),
	Kicker = task.KickerTask("Shoot"),
	Goalie = task.Goalie()
},

name = "2"
}