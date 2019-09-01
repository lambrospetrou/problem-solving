(ns solutions.p0008)

(defn count-unival [root]
  (defn rec [node]
    (cond 
      (nil? node) [0 true]
      (and (nil? (:left node)) (nil? (:right node))) [1 true]
      :else
       (let [[leftTotal leftUnival] (rec (:left node))
             [rightTotal rightUnival] (rec (:right node))
             subtreeTotal (+ leftTotal rightTotal)]
         (if (not= (get-in node [:left :val]) (get-in node [:right :val]) (:val node))
           [subtreeTotal false]
           ; Same values but we need the subtrees to also be unival for `node` to be.
           (if (and leftUnival rightUnival)
             [(inc subtreeTotal) true]
             [subtreeTotal false])))))
  (get (rec root) 0))
