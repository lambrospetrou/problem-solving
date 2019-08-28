(ns solutions.p0080-test
  (:require [cljs.test :refer-macros [deftest is run-tests]] 
            [solutions.p0080 :as p80]))

(deftest check-deepest-nodes
  (is (= (:val (p80/deepest-node 
  {
    :val "a",
    :l {
      :val "b"
      :l {
        :val "d"
      }
    },
    :r {:val "c"}
  })) "d")))

; (run-tests)
