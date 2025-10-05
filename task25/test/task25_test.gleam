import gleeunit

import lazy
import mapped
import moduled
import recursion
import tail_recursion

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn recursion_test() {
  assert recursion.solve(1000) == 4782
}

pub fn tail_recursion_test() {
  assert tail_recursion.solve(1000) == 4782
}

pub fn moduled_test() {
  assert moduled.solve(1000) == 4782
}

pub fn mapped_test() {
  assert mapped.solve(1000) == 4782
}

pub fn lazy_test() {
  assert lazy.solve(1000) == 4782
}
