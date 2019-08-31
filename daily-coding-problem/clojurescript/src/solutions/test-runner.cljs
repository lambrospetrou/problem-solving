; Run this with `plk src/solutions/test-runner.cljs`

(ns solutions.test-runner
  (:require [cljs.test :refer-macros [run-tests run-all-tests]]
            ; All namespaces to be tested
            [solutions.p0001-test]
            [solutions.p0002-test]
            [solutions.p0080-test]
            [solutions.p0100-test]))

; Result for all the tests run.
(defmethod cljs.test/report [:cljs.test/default :end-run-tests] [m]
  (if (cljs.test/successful? m)
    (println "\nOK")
    (println "\nFAIL")))

; Print each of the `deftest` running.
(defmethod cljs.test/report [:cljs.test/default :begin-test-var] [m]
  (println "\u001B[32m\t" (-> m :var meta :name) "\u001B[0m"))

; (run-tests 'solutions.p0001-test
;            'solutions.p0080-test)
(run-all-tests #"solutions.*-test")
