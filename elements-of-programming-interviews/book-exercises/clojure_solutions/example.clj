(defn hello 
  {:test #(do
            (assert (= (hello) "hello, world!")))}
  ([] "hello, world!"))

(test #'hello)

