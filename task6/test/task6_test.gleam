import gleeunit

import lazy
import mapped
import moduled
import recursion
import tail_recursion
import task6

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn recursion_test() {
  assert recursion.solve(100) == 25_164_150
}

pub fn tail_recursion_test() {
  assert tail_recursion.solve(100) == 25_164_150
}

pub fn moduled_test() {
  assert moduled.solve(100) == 25_164_150
}

pub fn mapped_test() {
  assert mapped.solve(100) == 25_164_150
}

pub fn lazy_test() {
  assert lazy.solve(100) == 25_164_150
}

pub fn math_test() {
  assert task6.math_solve(100) == 25_164_150
}
