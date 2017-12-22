(ns default.core-test
  (:require [clojure.test :refer :all]
            [default.core :refer :all]
  )
)

(deftest tuple-test
  (testing "Getting tuple direction works."
    (is (= [0.0,1.0] (get_direction_tuple "n")))
    (is (= [0.0,-1.0] (get_direction_tuple "s")))
    (is (= [-1.0,-0.5] (get_direction_tuple "sw")))
    (is (= [-1.0,0.5] (get_direction_tuple "nw")))
    (is (= [1.0,-0.5] (get_direction_tuple "se")))
    (is (= [1.0,0.5] (get_direction_tuple "ne")))
  )
)

(deftest string-split-test
  (testing "splitting string."
    (is (= ["nw","n","s"] (break_up_directions "nw,n,s")))
  )
)

(deftest figure-out-coordinate
  (testing "Figure out coordinate"
    (is (= [3.0,1.5] (figure_out_coordinate "ne,ne,ne")))
    (is (= [0.0,0.0] (figure_out_coordinate "ne,ne,sw,sw")))
    (is (= [2.0,-1.0] (figure_out_coordinate "ne,ne,s,s")))
    (is (= [-1.0,-2.5] (figure_out_coordinate "se,sw,se,sw,sw")))
  )
)

(deftest calculate-steps-from-location
  (testing "Calculating number of steps from location."
    (is (= 3 (calculate_distance [0.0,0.0] [3.0,1.5] 0)))
    (is (= 0 (calculate_distance [0.0,0.0] [0.0,0.0] 0)))
    (is (= 2 (calculate_distance [0.0,0.0] [2.0,-1.0] 0)))
    (is (= 3 (calculate_distance [0.0,0.0] [-1.0,-2.5] 0)))
  )
)

(deftest on-main-path-to-node
  (testing "Determining if on one of the main paths to origin"
    (is (= true (is_on_main_path [0.0,0.0] [0.0,1.0])))
    (is (= true (is_on_main_path [0.0,0.0] [1.0,0.5])))
    (is (= true (is_on_main_path [0.0,0.0] [1.0,-0.5])))
    (is (= true (is_on_main_path [0.0,0.0] [0.0,-1.0])))
    (is (= true (is_on_main_path [0.0,0.0] [-1.0,-0.5])))
    (is (= true (is_on_main_path [0.0,0.0] [-1.0,0.5])))
    (is (= false (is_on_main_path [0.0,0.0] [-1.0,-1.5])))
    (is (= false (is_on_main_path [0.0,0.0] [-2.0,-2.0])))
    (is (= false (is_on_main_path [0.0,0.0] [-3.0,0.5])))
    (is (= false (is_on_main_path [0.0,0.0] [-1.0,2.5])))
  )
)

(deftest head-toward-goal
  (testing "If not on main path, should head diagonally toward, otherwise head toward goal."
    (is (= [0.0,-1.0] (head_toward_goal [0.0,0.0] [0.0,1.0])))
    (is (= [-1.0,-0.5] (head_toward_goal [0.0,0.0] [1.0,0.5])))
    (is (= [-1.0,0.5] (head_toward_goal [0.0,0.0] [1.0,-0.5])))
    (is (= [0.0,1.0] (head_toward_goal [0.0,0.0] [0.0,-1.0])))
    (is (= [1.0,0.5] (head_toward_goal [0.0,0.0] [-1.0,-0.5])))
    (is (= [1.0, -0.5] (head_toward_goal [0.0,0.0] [-1.0,0.5])))
    (is (= [1.0,0.5] (head_toward_goal [0.0,0.0] [-1.0,-1.5])))
    (is (= [1.0,0.5] (head_toward_goal [0.0,0.0] [-2.0,-2.0])))
    (is (= [1.0,-0.5] (head_toward_goal [0.0,0.0] [-3.0,0.5])))
    (is (= [1.0,-0.5] (head_toward_goal [0.0,0.0] [-2.0,0.0])))
    (is (= [-1.0,-0.5] (head_toward_goal [0.0,0.0] [2.0,2.0])))
  )
)

(deftest find-kid
  (testing "find-kid"
    (is (= 3 (find_lost_kid "ne,ne,ne")))
    (is (= 0 (find_lost_kid "ne,ne,sw,sw")))
    (is (= 2 (find_lost_kid "ne,ne,s,s")))
    (is (= 3 (find_lost_kid "se,sw,se,sw,sw")))
    (is (= 805 (find_lost_kid_from_file "puzzle_input.txt")))
  )
)

(deftest find-furthest-traveled
  (testing "find-kid"
    (is (= 3 (furthest_ever_traveled "ne,ne,ne")))
    (is (= 2 (furthest_ever_traveled "ne,ne,sw,sw")))
    (is (= 2 (furthest_ever_traveled "ne,ne,s,s")))
    (is (= 3 (furthest_ever_traveled "se,sw,se,sw,sw")))
    (is (= 1535 (furthest_ever_traveled_from_file "puzzle_input.txt")))
  )
)