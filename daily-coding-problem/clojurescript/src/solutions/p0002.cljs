(ns solutions.p0002)

(defn product-except-i-with-division [numbers]
  (let [total-product (reduce * numbers)]
    (map #(if (zero? %) 0 (/ total-product %)) numbers)))

(defn product-except-i 
  "Solution as described in https://stackoverflow.com/a/2680697/1066790"
  [numbers]
  (if (or (= numbers []) (= numbers [0]))
    numbers
    (let [
      len (count numbers)
      left-shifted (take len (reverse (reduce (fn [xs, current] (conj xs (* current (first xs)))) '(1) numbers)))
      right-shifted (reduce (fn [xs, current] (conj xs (* current (first xs)))) '(1) (reverse (rest numbers)))]
      
      (vec (map * left-shifted right-shifted)))))
