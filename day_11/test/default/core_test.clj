(ns default.core-test
  (:require [clojure.test :refer :all]
            [default.core :refer :all]))

(deftest tuple-test
  (testing "Getting tuple direction works."
    (is (= [0,1] (get_direction_tuple "n")))
    (is (= [0,-1] (get_direction_tuple "s")))
    (is (= [-1,-0.5] (get_direction_tuple "sw")))
    (is (= [-1,0.5] (get_direction_tuple "nw")))
    (is (= [1,-0.5] (get_direction_tuple "se")))
    (is (= [1,0.5] (get_direction_tuple "ne")))
    ))
