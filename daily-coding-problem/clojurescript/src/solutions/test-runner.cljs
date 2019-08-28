; Run this with `plk src/solutions/test-runner.cljs`

(ns solutions.test-runner
  (:require [cljs.test :refer-macros [run-tests]]
            ; All namespaces to be tested
            [solutions.p0080-test]))

(defmethod cljs.test/report [:cljs.test/default :end-run-tests] [m]
  (if (cljs.test/successful? m)
    (println "\nOK")
    (println "\nFAIL")))

(run-tests 'solutions.p0080-test)
