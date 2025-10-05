import gleam/io

import lazy
import mapped
import moduled
import recursion
import tail_recursion

pub fn main() -> Nil {
  echo recursion.solve(1000)
  echo tail_recursion.solve(1000)
  echo moduled.solve(1000)
  echo mapped.solve(1000)
  echo lazy.solve(1000)

  io.println("Hello from task25!")
}
