shader_type canvas_item;

uniform float progress : hint_range(0,1);
uniform bool right = false;
uniform bool left = false;
uniform bool up = false;
uniform bool down = false;

const float PI = 3.14159265359;

float roll_right(float t, float uvx)
{
	return 32.0*(-1.0*uvx + (2.0 -1.0*uvx)*cos(uvx*t*PI));
}


float roll_up(float t, float uvy)
{
	return 32.0*cos(uvy*t*PI) - 32.0;
}

void vertex()
{
	if(right)
	{
		VERTEX.x += roll_right(1.0 - progress, UV.x);
	}
	else if(left)
	{
		VERTEX.x += roll_right(progress, UV.x);
	}
	else if(up)
	{
		VERTEX.y += roll_up(progress, UV.y);
	}
	else if(down)
	{
		VERTEX.y += roll_up(1.0 - progress, UV.y);

	}
}
