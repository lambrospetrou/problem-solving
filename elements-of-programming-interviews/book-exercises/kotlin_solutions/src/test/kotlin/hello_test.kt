import kotlin.test.*
import com.lambrospetrou.hello.*

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
