import gleam/int
import gleam/string

fn get_index_impl(n: Int, i: Int, f1: Int, f2: Int) -> Int {
  let len = f2 |> int.to_string |> string.length
  case len >= n {
    True -> i
    False -> get_index_impl(n, i + 1, f2, f1 + f2)
  }
}

fn get_index(n: Int) -> Int {
  get_index_impl(n, 1, 0, 1)
}

pub fn solve(n: Int) -> Int {
  get_index(n)
}
