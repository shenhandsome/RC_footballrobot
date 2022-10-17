#include "shoot.h"
#include "utils/maths.h"
//用户注意；接口需要如下声明
extern "C"_declspec(dllexport) PlayerTask player_plan(const WorldModel* model, int robot_id);

enum ball_near  //PenaltyArea
{

	outOfOrbit,
	onOrbit,
	shoot
};

PlayerTask player_plan(const WorldModel* model, int robot_id){
	PlayerTask task;
	//获取对方球门坐标
	point2f& opp_goal = -FieldPoint::Goal_Center_Point;
	const float pi = 3.1415926;
	const float& circleR = 10;
	const float& DetAngle = 0.6;
	const point2f& goal = FieldPoint::Goal_Center_Point;
	//获取球的坐标
	const point2f& ball = model->get_ball_pos();
	const point2f& kicker = model->get_our_player_pos(robot_id);
	const float& dir = model->get_our_player_dir(robot_id);
	ball_near orbit;
	point2f shootPosOnOrbit = ball + Maths::vector2polar(circleR, (ball - opp_goal).angle());
	float toShootDir = fabs((kicker - ball).angle() - (ball - opp_goal).angle());   //(kicker - shootPosOnOrbit).length();
	//获取射手到球的距离
	float toBallDist = (kicker - ball).length();
	//float toBallDist1 = ()
	int random;
	if (ball.x > 100){
		random = rand() % 10;
	}
	else{
		random = rand() % 30;
	}

	if (random % 2 == 0)
	{
		random = random;
	}
	else
	{
		random = -random;
	}

	float toOppGoalDir;
	if (ball.y > 0){
		toOppGoalDir = (opp_goal - kicker + Maths::vector2polar(-random, pi / 2)).angle();
	}
	else{
		toOppGoalDir = (opp_goal - kicker + Maths::vector2polar(random, pi / 2)).angle();
	}
	float toBallDir = (ball - kicker).angle();
	point2f robotBallAcrossCirclePoint = ball + Maths::vector2polar(circleR, (kicker - ball).angle());
	point2f AntishootPosOnOrbit = ball + Maths::vector2polar(circleR, (opp_goal - ball).angle());
	point2f BallToRobot = kicker - ball;
	if (toBallDist >circleR + 14)
		orbit = outOfOrbit;
	else if (toShootDir > 0.5)
		orbit = onOrbit;
	else
		orbit = shoot;

	bool getBall = toBallDist < 14;
	float diffdir_onorbit = 0;
	float b2r = BallToRobot.angle();
	float o2b = (ball - opp_goal).angle();
	bool add;
	switch (orbit)
	{
	case outOfOrbit:
		task.target_pos = robotBallAcrossCirclePoint;
		task.orientate = toOppGoalDir;
		break;
	case onOrbit:
		if (b2r * o2b >0){
			if (b2r > 0){
				if (b2r > o2b)
					add = false;
				else
					add = true;
			}
			else{
				if (b2r > o2b)
					add = false;
				else
					add = true;
			}
		}
		else{
			if (b2r > 0)
				add = true;
			else
				add = false;
		}
		if (add)
		{
			//+
			task.target_pos = ball + Maths::vector2polar(circleR, BallToRobot.angle() + DetAngle);
			task.orientate = toOppGoalDir;
		}
		else
		{
			//-
			task.target_pos = ball + Maths::vector2polar(circleR, BallToRobot.angle() - DetAngle);
			task.orientate = toOppGoalDir;
		}
		break;
	case shoot:
		task.target_pos = ball + Maths::vector2polar(7, (ball - opp_goal).angle());
		//task.target_pos = ball + Maths::vector2polar(7, (ball - goal).angle());
		task.orientate = toOppGoalDir;
		task.needKick = true;
		task.flag = 1;
		//cout << "--------toBallDist:" << toBallDist << endl;

		float cur_dir = fabs(model->get_our_player_dir(robot_id) - task.orientate);
		//cout << "---------cur_dir:" << cur_dir << endl;
		if (toBallDist < 20 && cur_dir < 0.05){
			//task.kickPower = 30;
			task.kickPower = 12;
		}
		break;
	}
	return task;
}
