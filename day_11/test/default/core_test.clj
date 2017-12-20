(ns default.core-test
  (:require [clojure.test :refer :all]
            [default.core :refer :all]
  )
)

(deftest tuple-test
  (testing "Getting tuple direction works."
    (is (= [0,1] (get_direction_tuple "n")))
    (is (= [0,-1] (get_direction_tuple "s")))
    (is (= [-1,-0.5] (get_direction_tuple "sw")))
    (is (= [-1,0.5] (get_direction_tuple "nw")))
    (is (= [1,-0.5] (get_direction_tuple "se")))
    (is (= [1,0.5] (get_direction_tuple "ne")))
  )
)

(deftest string-split-test
  (testing "splitting string."
    (is (= ["nw","n","s"] (break_up_directions "nw,n,s")))
  )
)

(deftest figure-out-coordinate
  (testing "Figure out coordinate"
    (is (= [3,1.5] (figure_out_coordinate "ne,ne,ne")))
    (is (= [0,0] (figure_out_coordinate "ne,ne,sw,sw")))
    (is (= [2,-1] (figure_out_coordinate "ne,ne,s,s")))
    (is (= [-1,-2.5] (figure_out_coordinate "se,sw,se,sw,sw")))
  )
)
