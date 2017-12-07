import dunit.toolkit;
import std.math;
import std.conv;
import std.stdio;


int get_distance(int number) {
	auto spiral_level = get_square_n(number);
	auto vertical = spiral_level - 1;
	auto horizontal = get_horizontal_distance(spiral_level, number);
	return vertical + horizontal;
}

int get_horizontal_distance(int spiral_level, int number) {
	if(spiral_level == 1) return 0;
	auto width = (spiral_level-1)*2;
	auto difference = (2*spiral_level-1)^^2-number;
	while(difference >= width) difference-=width;
	return abs(difference-(width/2));
}

int get_square_n(int number) {
	auto spiral_level = 1;
	while( number > (2*spiral_level-1)^^2 ) spiral_level++;
	return spiral_level;
}

unittest
{
    get_square_n(1).assertEqual(1);
    get_square_n(2).assertEqual(2);
    get_square_n(9).assertEqual(2);
    get_square_n(10).assertEqual(3);
    get_square_n(25).assertEqual(3);
    get_square_n(26).assertEqual(4);
    get_distance(1).assertEqual(0); //0
    get_distance(2).assertEqual(1); //0
    get_distance(3).assertEqual(2); //0
    get_distance(4).assertEqual(1); //0
    get_distance(5).assertEqual(2); //0
    get_distance(12).assertEqual(3); //3 down,left,left
    get_distance(14).assertEqual(3); //3 down,left,left
    get_distance(23).assertEqual(2); //2 up,up
    get_distance(25).assertEqual(4);
    get_distance(1024).assertEqual(31); //31
    get_distance(265149).assertEqual(438); //31
}

