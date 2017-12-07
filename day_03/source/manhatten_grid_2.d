import dunit.toolkit;
import std.math;
import std.conv;
import std.stdio;
import std.typecons;

int get_first_larger_than(int number) {
	auto x = 0;
	auto y = 0;
	auto spiral_level=2;
	int[Tuple!(int,int)] grid;
	grid[tuple(x, y)] = 1;

	while(true) {
		auto width = (spiral_level-1)*2;
		x++;
		if(fill_in_value(x,y,grid) > number) {
			return grid[tuple(x,y)];
		}
		foreach( _; 0 .. width-1 ) {
			y++;
			if(fill_in_value(x,y,grid) > number) {
				return grid[tuple(x,y)];
			}
		}
		foreach( _; 0 .. width ) {
			x--;
			if(fill_in_value(x,y,grid) > number) {
				return grid[tuple(x,y)];
			}
		}
		foreach( _; 0 .. width) {
			y--;
			if(fill_in_value(x,y,grid) > number) {
				return grid[tuple(x,y)];
			}
		}
		foreach( _; 0 .. width) {
			x++;
			if(fill_in_value(x,y,grid) > number) {
				return grid[tuple(x,y)];
			}
		}
		spiral_level++;
	}
}
int fill_in_value(int x, int y, ref int[Tuple!(int,int)] grid) {
	writeln("x: ", x, " y: ", y);
	auto sum = 0;
	foreach( x_i; -1 .. 2) {
		foreach( y_i; -1 .. 2) {
			if( x_i != 0 || y_i != 0 ) {
				writeln("x_i: ", x_i, " y_i: ", y_i);
				sum+=grid.get(tuple(x+x_i,y+y_i),0);
			}
		}
	}
	grid[tuple(x,y)] = sum;
	return sum;
}

unittest
{
	get_first_larger_than(1).assertEqual(2);
	get_first_larger_than(2).assertEqual(4);
	get_first_larger_than(4).assertEqual(5);
	get_first_larger_than(5).assertEqual(10);
	get_first_larger_than(10).assertEqual(11);
	get_first_larger_than(11).assertEqual(23);
	get_first_larger_than(23).assertEqual(25);
	get_first_larger_than(25).assertEqual(26);
	get_first_larger_than(26).assertEqual(54);
	get_first_larger_than(54).assertEqual(57);
	get_first_larger_than(57).assertEqual(59);
	get_first_larger_than(147).assertEqual(304);
	get_first_larger_than(265149).assertEqual(304);

}

