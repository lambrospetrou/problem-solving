; Run this with `plk src/solutions/test-runner.cljs`

(ns solutions.test-runner
  (:require [cljs.test :refer-macros [run-tests run-all-tests]]
            ; All namespaces to be tested
            [solutions.p0001-test]
            [solutions.p0080-test]
            [solutions.p0100-test]))

(defmethod cljs.test/report [:cljs.test/default :end-run-tests] [m]
  (if (cljs.test/successful? m)
    (println "\nOK")
    (println "\nFAIL")))

; (run-tests 'solutions.p0001-test
;            'solutions.p0080-test)
(run-all-tests #"solutions.*-test")
