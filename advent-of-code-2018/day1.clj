(require '[clojure.string :as str]
         '[clojure.java.io :as io])

(defn get-freqs [input]
   (with-open [rdr (io/reader input)]
     (doall (map #(Integer/parseInt (str/trim %)) (line-seq rdr)))))

(defn part1
  ([] (part1 "day1-input.txt"))
  ([input] 
   (let [freqs (get-freqs input)]
     (reduce + 0 freqs))))

(defn part2
  ([] (part2 "day1-input.txt"))
  ([input]
   (let [freqs (cycle (get-freqs input))]
     (reduce 
      (fn [[acc seen] new_freq]
        (let [new_acc (+ acc new_freq)]
             (if (get seen new_acc)
               (reduced new_acc)
               [new_acc (conj seen new_acc)])))
      [0 #{0}] 
      freqs))))
