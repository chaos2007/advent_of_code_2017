(ns default.core)

(defn get_direction_tuple
  "Get tuple describing direction"
  [direction]
  (def x {"n" [0,1], "s" [0,-1], "sw" [-1,-0.5], "nw" [-1,0.5], "se" [1,-0.5], "ne" [1,0.5]}) 
  (x direction)
)