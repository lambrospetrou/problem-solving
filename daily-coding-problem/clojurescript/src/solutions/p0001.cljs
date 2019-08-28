(ns solutions.p0001)

(defn contains-two-for-sum [n xs]
  (defn do-rec [xs seen]
    (if (nil? xs)
        false
        (let [[hd & tl] xs
              matches (not (nil? (get seen hd)))]
          (if matches
              true
              (do-rec tl (conj seen (- n hd)))))))
  (do-rec xs #{}))
