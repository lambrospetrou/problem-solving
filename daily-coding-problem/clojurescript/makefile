.PHONY: test test-lumo test-planck test-plk

test: test-raw

# `plk` wraps the `planck` command and passes the Clojure classpath automatically.
test-raw:
	mkdir -p .planck-cache
	plk -k .planck-cache src/solutions/test-runner.cljs

# The argument "-c `clj -Spath`" below gets the clojure classpath which includes
# the `src` directory by default. Otherwise our namespace resolution will fail.
# If we use `deps.edn` to specify dependencies then we should use the clojure path
# to get auto-resolving and downloading automatically using clojure.

# `plk` wraps the `planck` command and passes the Clojure classpath automatically.
test-plk:
	mkdir -p .planck-cache
	# This assumes that the test files have the `(run-tests)` command themselves.
	find src -iname "*_test.cljs" -exec plk -k .planck-cache {} \;
	# find src -iname "*-test.cljs" -exec planck -k .planck-cache -c "src" {} \;
