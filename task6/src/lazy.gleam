import gleam/list

import gens/lazy

fn square(x: Int) -> Int {
  x * x
}

fn add(count: Int, e: Int) -> Int {
  count + e
}

fn sum_of_squares(n: Int) -> Int {
  lazy.new()
  |> lazy.map(square)
  |> lazy.take(n + 1)
  |> list.fold(0, add)
}

fn square_of_sum(n: Int) -> Int {
  lazy.new()
  |> lazy.take(n + 1)
  |> list.fold(0, add)
  |> square
}

pub fn solve(n: Int) -> Int {
  square_of_sum(n) - sum_of_squares(n)
}
