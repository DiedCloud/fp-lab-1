import gleam/int
import gleam/list
import gleam/result
import gleam/string

fn get_fib_seq_impl(n: Int, acc: List(Int)) -> List(Int) {
  let l = list.first(acc) |> result.unwrap(0) |> int.to_string |> string.length
  case acc {
    _ if l >= n -> acc
    [] -> get_fib_seq_impl(n, [1])
    [_] -> get_fib_seq_impl(n, [1, 1])
    [f1, f2, ..] -> get_fib_seq_impl(n, [f1 + f2, ..acc])
  }
}

fn get_fib_seq(n: Int) -> List(Int) {
  get_fib_seq_impl(n, [])
}

pub fn solve(n: Int) -> Int {
  get_fib_seq(n) |> list.length
}
