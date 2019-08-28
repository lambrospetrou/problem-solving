(ns solutions.p0001-test
  (:require [cljs.test :refer-macros [deftest is]] 
            [solutions.p0001 :refer [contains-two-for-sum] :rename {contains-two-for-sum subj}]))

(deftest check-contains-two-numbers-to-sum
  (is (= true (subj 10 [1 2 3 4 5 6 7 8 9])))
  (is (= true (subj 17 [1 2 3 4 5 6 7 8 9])))
  (is (= true (subj 2 [1 2 1 2 3])))
  (is (= false (subj 6 [1 2 3]))))
