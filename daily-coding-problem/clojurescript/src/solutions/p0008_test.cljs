(ns solutions.p0008-test
  (:require [cljs.test :refer [deftest are]]
            [solutions.p0008 :refer [count-unival]]))

(deftest test-count-unival
  (are [expected tree] (= expected (count-unival tree))
    0 nil

    1 {:val 10}

    5 {:val 0
       :left {:val 1}
       :right {:val 0
               :left {:val 1
                      :left {:val 1}
                      :right {:val 1}}
               :right {:val 0}}}

    3 {:val 0
       :left {:val 1}
       :right {:val 0
               :left {:val 2
                      :left {:val 1}
                      :right {:val 1}}}}))
