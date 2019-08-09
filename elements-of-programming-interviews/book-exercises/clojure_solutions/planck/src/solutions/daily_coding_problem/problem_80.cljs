(ns solutions.daily-coding-problem.problem-80)

; Given the root of a binary tree, return a deepest node. For example, in the following tree, return d.
;       a
;     / \
;    b  c
;   /
;  d

(defn deepest-node [root]
  (defn do-deep-rec [n, depth]
    (cond
      (nil? n) [nil 0]
      (and (nil? (:l n)) (nil? (:r n))) [n depth]
      :else 
        (let [
          [ln ld] (do-deep-rec (:l n) (inc depth))
          [rn rd] (do-deep-rec (:r n) (inc depth))]
          (if (> ld rd)
            [ln ld]
            [rn rd]))))
  (get (do-deep-rec root 1) 0))
