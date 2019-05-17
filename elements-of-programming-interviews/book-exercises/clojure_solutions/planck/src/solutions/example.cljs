(ns solutions.example)

(defn hello 
  {:test #(do
            (assert (= (hello) "hello, world!")))}
  ([] "hello, world!"))

(defn hello2 [] 
  "hello, world2!")
