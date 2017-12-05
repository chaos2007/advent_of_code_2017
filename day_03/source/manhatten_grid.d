import dunit.toolkit;

int get_distance(int number) {
    return 0;
}

int get_square_n(int number) {
    return 0;
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

