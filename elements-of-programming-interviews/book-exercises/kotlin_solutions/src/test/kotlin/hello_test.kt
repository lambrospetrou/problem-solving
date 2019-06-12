import kotlin.test.*
import com.lambrospetrou.hello.*

class HelloTest {
  @Test
  fun whenWorld() {
    assertEquals(Hello().world(), "hello, world")
  }
}
