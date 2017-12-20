(ns default.core)

(defn get_direction_tuple
  "Get tuple describing direction"
  [direction]
  (def x {"n" [0,1], "s" [0,-1], "sw" [-1,-0.5], "nw" [-1,0.5], "se" [1,-0.5], "ne" [1,0.5]}) 
  (x direction)
)

(defn break_up_directions
  "Break commas out."
  [directions]
  (clojure.string/split directions #",")
)

(defn figure_out_coordinate
  "Figure out coordinates."
  [directions]
  (def split_directions (break_up_directions directions))
  (reduce + [0,0] split_directions)
)