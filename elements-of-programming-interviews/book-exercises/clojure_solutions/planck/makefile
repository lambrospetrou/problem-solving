.PHONY: test test-lumo test-planck test-plk

# The argument "-c `clj -Spath`" below gets the clojure classpat which includes
# the `src` directory by default. Otherwise our namespace resolution will fail.

test: test-plk

# `plk` wraps the `planck` command and passes the Clojure classpath automatically.
test-plk:
	find src -iname "*-test.cljs" -exec plk -k .planck-cache {} \;

test-planck:
	#find src -iname "*-test.cljs" -exec planck -k .planck-cache -c `clj -Spath` {} \;
	find src -iname "*-test.cljs" -exec planck -k .planck-cache -c "src" {} \;

test-lumo:
	find src -iname "*-test.cljs" -exec lumo -k .lumo-cache -c "src" {} \;

