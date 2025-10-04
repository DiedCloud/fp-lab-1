import gleam/io

import lazy
import mapped
import moduled
import recursion
import tail_recursion

fn square_of_sum(n: Int) -> Int {
  { { n * { n + 1 } } / 2 } * { { n * { n + 1 } } / 2 }
}

pub fn math_solve(n: Int) -> Int {
  square_of_sum(n) - tail_recursion.sum_of_squares(n)
}

pub fn main() -> Nil {
  echo recursion.solve(100)
  echo tail_recursion.solve(100)
  echo moduled.solve(100)
  echo mapped.solve(100)
  echo lazy.solve(100)

  echo math_solve(100)

  io.println("Hello from task6!")
}
