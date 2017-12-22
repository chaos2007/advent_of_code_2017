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
      [(+ (nth current_loc 0) (nth direction 0)), 
       (+ (nth current_loc 1) (nth direction 1))
      ]
    )
    [0.0, 0.0]
    direction_tuples
  )
)

(defn is_on_main_path
  "Determine if currently on main path to the origin"
  [origin, current_node]
  (def difference [(- (nth current_node 0) (nth origin 0)), (- (nth current_node 1) (nth origin 1))])
  (def above_or_below (= (nth origin 0) (nth current_node 0)))
  (def first_diagonal (= (/ (nth difference 0) 2) (nth difference 1)))
  (def second_diagonal (= (* (/ (nth difference 0) 2) -1) (nth difference 1)))
  (or above_or_below first_diagonal second_diagonal)
)

(defn head_toward_goal
  "Determine step to get closer to goal."
  [origin, current_node]
  (def on_column (= (nth origin 0) (nth current_node 0)))
  (def difference [(- (nth current_node 0) (nth origin 0)), (- (nth current_node 1) (nth origin 1))])
  (if on_column 
    (if (< (nth origin 1) (nth current_node 1))
      [0.0, -1.0]
      [0.0, 1.0]
    )
    (if (neg? (nth difference 0) )
      (if (neg? (nth difference 1))
        [1.0, 0.5]
        [1.0, -0.5]
      )
      (if (neg? (nth difference 1))
        [-1.0, 0.5]
        [-1.0, -0.5]
      )
    )
  )
)


(defn calculate_distance
  "Calculate distance"
  [origin, current_node, step]
  (if (= current_node origin)
    step
    (do 
      (def direction (head_toward_goal origin current_node))
      (def new_node [(+ (nth current_node 0) (nth direction 0)), (+ (nth current_node 1) (nth direction 1))])
      (recur origin new_node (+ step 1))
    )
  )
)

(defn find_lost_kid
  "Given string find lost kid."
  [direction_string]
  (def kid (figure_out_coordinate direction_string))
  (calculate_distance [0.0,0.0] kid 0)
)

(defn find_lost_kid_from_file
  "Given string find lost kid."
  [file]
  (find_lost_kid (slurp file))
)

(defn furthest_traveled_recurse
  "recursive"
  [origin, current_node, directions, max_distance]
  (if (empty? directions)
    max_distance
    (do 
      (def direction (first directions))
      (def node [(+ (nth current_node 0) (nth direction 0)), (+ (nth current_node 1) (nth direction 1))])
      (def new_max (calculate_distance origin node 0))
      (recur origin node (rest directions) (if (> new_max max_distance) new_max max_distance))
    )
  )
)
(defn furthest_ever_traveled
  "Find furthest ever traveled."
  [direction_string]
  (def split_directions (break_up_directions direction_string))
  (def direction_tuples (map get_direction_tuple split_directions))
  (furthest_traveled_recurse [0.0,0.0] [0.0,0.0] direction_tuples 0)
)

(defn furthest_ever_traveled_from_file
  "Given string find furthest ever traveled."
  [file]
  (furthest_ever_traveled (slurp file))
)