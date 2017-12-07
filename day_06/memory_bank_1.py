import unittest
from sets import Set


def redistribute_bank(banks):
    largest = max(banks)
    start_bank = banks.index(largest)
    banks[start_bank] = 0
    for x in range(1,largest+1):
        banks[(start_bank+x)%len(banks)]+=1
    return banks

def find_repeat_bank(banks):
    combos = Set()
    combos.add(tuple(banks))
    current_redistribute = 0
    while True:
        current_redistribute+=1
        banks = redistribute_bank(banks)
        if tuple(banks) in combos:
            return current_redistribute
        combos.add(tuple(banks))

def find_repeat_bank_2(banks):
    combos = Set()
    combos.add(tuple(banks))
    while True:
        banks = redistribute_bank(banks)
        if tuple(banks) in combos:
            repeated_bank = tuple(banks)
            break
        combos.add(tuple(banks))

    current_redistribute = 1
    while tuple(redistribute_bank(banks)) != repeated_bank:
        current_redistribute+=1
    return current_redistribute
        


class TestMemoryBank(unittest.TestCase):
    def test_redistribute(self):
        self.assertEqual([2,4,1,2], redistribute_bank([0,2,7,0]))
        self.assertEqual([3,1,2,3], redistribute_bank([2,4,1,2]))
        self.assertEqual([0,2,3,4], redistribute_bank([3,1,2,3]))
        self.assertEqual([1,3,4,1], redistribute_bank([0,2,3,4]))
        self.assertEqual([2,4,1,2], redistribute_bank([1,3,4,1]))

    def test_stopping_on_repeat(self):
        self.assertEqual(5, find_repeat_bank([0,2,7,0]))
        self.assertEqual(11137, find_repeat_bank([14,0,15,12,11,11,3,5,1,6,8,4,9,1,8,4]))

    def test_stopping_on_repeat(self):
        self.assertEqual(4, find_repeat_bank_2([0,2,7,0]))
        self.assertEqual(1037, find_repeat_bank_2([14,0,15,12,11,11,3,5,1,6,8,4,9,1,8,4]))

if __name__ == '__main__':
    unittest.main()