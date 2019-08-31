(ns solutions.p0100-test
  (:require [cljs.test :refer-macros [deftest is are]] 
            [solutions.p0100 :refer [total-steps]]))

(deftest it-works-with-empty-targets
  (is (total-steps {:x 0 :y 0} [])))

(deftest it-works-on-multiple-targets
  (are [expected targets] (= expected (total-steps {:x 0 :y 0} targets))
       4 [
           {:x 1 :y 1}
           {:x 2 :y 2}
           {:x 4 :y 4}
         ]
       6 [
           {:x 1 :y 1}
           {:x 4 :y 4}
           {:x 2 :y 2}
         ]
       10 [
           {:x 10 :y 1}
         ]
       11 [
           {:x -10 :y -11}
         ]))
