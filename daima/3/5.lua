gPlayTable.CreatePlay{
firstState="PenaltyKick",

["PenaltyKick"]={
	switch=function()
        if CIsBallKick("Kicker") then
	        return"finish"
	    end
	end,
    Kicker=task.PenaltyKick("Kicker"),
	Receiver=task.RefDef("Receiver"),
	Goalie=task.Goalie()
},

name="5"

}