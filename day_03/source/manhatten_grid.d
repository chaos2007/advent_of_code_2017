import dunit.toolkit;
import std.math;
import std.conv;

int get_distance(int number) {
	auto spiral_level = get_square_n(number);
	//Get_horizontal distance.
	return spiral_level - 1;
}

int get_square_n(int number) {
	auto spiral_level = 1;
	while( number > (2*spiral_level-1)^^2 ) {
		spiral_level++;
	}
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
    get_distance(12).assertEqual(3); //3 down,left,left
    get_distance(23).assertEqual(2); //2 up,up
    get_distance(1024).assertEqual(31); //31
}

