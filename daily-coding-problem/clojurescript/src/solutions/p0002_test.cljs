(ns solutions.p0002-test
  (:require [cljs.test :refer-macros [deftest testing is are]] 
            [solutions.p0002 :refer [product-except-i-with-division product-except-i]]))

(defn- do-tests [test-func]
  (testing "with invalid array"
    (is (= [] (test-func [])))
    (is (= [0] (test-func [0])))
    (is (= [1] (test-func [10]))))
    
  (testing "with valid array"
    (are [input expected] (= expected (test-func input))
      [1, 2, 3, 4, 5] [120, 60, 40, 30, 24]
      [3 2 1] [2 3 6])))

(deftest test-product-except-i-with-division
  (do-tests product-except-i-with-division))

(deftest test-product-except-i
  (do-tests product-except-i))
