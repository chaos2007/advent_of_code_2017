import dunit.toolkit;

int get_distance(int number) {
    return 0;
}

unittest
{
    get_distance(1).assertEqual(0); //0
    get_distance(12).assertEqual(3); //3 down,left,left
    get_distance(23).assertEqual(2); //2 up,up
    get_distance(1024).assertEqual(31); //31
}

