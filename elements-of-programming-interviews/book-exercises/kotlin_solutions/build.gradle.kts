plugins {
  kotlin("jvm") version "1.3.31"
}

repositories {
  mavenCentral()
}

dependencies {
  implementation(kotlin("stdlib-jdk8"))
  testImplementation(kotlin("test"))
  testImplementation(kotlin("test-junit"))
}
