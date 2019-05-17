(ns hello
  (:require [clojure.test :refer :all]))

(defn hello 
  {:test #(do
            (assert (= (hello) "hello, world!")))}
  ([] "hello, world!"))

;(test #'hello)


(defn hello2 [] 
  "hello, world!")

(deftest hello2-test
  (is (= (hello) "hello, world!")))

(run-tests)

