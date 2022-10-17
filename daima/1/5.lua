kickerdir = function()
	return CRole2BallDir("Kicker")
end

ReceiverDir = function()
	return CRole2BallDir("Receiver")
end

gPlayTable.CreatePlay{
firstState = "GotoPos",

["GotoPos"] = {
	switch = function ()
		if CNormalStart() then
			return "PenaltyKick"
		elseif CGameOn() then
			return "finish"
		end
	end,
	Kicker = task.GotoPos("Kicker",200,0,kickerdir),
	Receiver = task.NormalDef("Receiver"),
	Goalie = task.Goalie()
},



["PenaltyKick"] = {
	switch = function()
		if CIsBallKick("Kicker") or CGameOn() then
			return "finish"
		end
	end,
	Kicker   = task.KickerTask("shoot"),
	Receiver = task.NormalDef("Receiver"),
	Goalie   = task.Goalie()
},

name = "5"
}