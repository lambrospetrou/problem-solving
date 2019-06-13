import com.lambrospetrou.hello.Hello
import kotlin.test.Test
import kotlin.test.assertEquals

class HelloTest {
    @Test
    fun whenWorld() {
        assertEquals("hello, world", Hello().world())
    }

    @Test
    fun whenWorld2() {
        assertEquals("hello, world 2", Hello().world2())
    }
}
