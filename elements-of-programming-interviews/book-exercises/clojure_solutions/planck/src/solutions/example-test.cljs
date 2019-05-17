(ns solutions.example-test
  (:require [cljs.test :refer-macros [deftest is run-tests]] 
            [solutions.example :as s]))

(deftest hello-test
  (is (= (s/hello) "hello, world!")))

(deftest hello2-test
  (is (= (s/hello2) "hello, world2!")))

(run-tests)
