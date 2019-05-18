package example

import (
    "testing"
)

func TestHello(t *testing.T) {
    result := Hello()
    if result != "hello, world!" {
        t.Errorf("Expected >hello, world!< got %v", result)
    }
}

