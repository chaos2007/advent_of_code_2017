(ns default.core)

(defn get_direction_tuple
  "Get tuple describing direction"
  [direction]
  (def x {"n" [0.0,1.0], "s" [0.0,-1.0], "sw" [-1.0,-0.5], "nw" [-1.0,0.5], "se" [1.0,-0.5], "ne" [1.0,0.5]}) 
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
  (def direction_tuples (map get_direction_tuple split_directions))
  (reduce 
    (fn [current_loc, direction] 
      [(+ (nth current_loc 0) (nth direction 0)), (+ (nth current_loc 1) (nth direction 1))]
    )
    [0.0,0.0]
    direction_tuples
  )
)