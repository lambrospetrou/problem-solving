(ns solutions.p0100)

(defn- distance-from-to [from to]
  (max (js/Math.abs (- (:x from) (:x to)))
       (js/Math.abs (- (:y from) (:y to)))))

(defn total-steps [from, targets]
  (:total (reduce (fn [{:keys [from total]} target]
                    {
                      :from target 
                      :total (+ total (distance-from-to from target))
                    })
                  {:from from :total 0} 
                  targets)))
