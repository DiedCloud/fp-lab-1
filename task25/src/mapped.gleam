import gleam/int
import gleam/list
import gleam/result
import gleam/string

import recursion

fn length(n: Int) -> Int {
  n |> int.to_string |> string.length
}

fn get_seq(upper_bound: Int, acc: List(Int)) -> List(Int) {
  case acc {
    [] -> get_seq(upper_bound, [1])
    [f1, ..] if f1 >= upper_bound -> acc
    [f1, ..] -> get_seq(upper_bound, [f1 + 1, ..acc])
  }
}

fn find_index_of_first_with_length_less_than_n(
  n: Int,
  seq: List(Int),
  initial_length: Int,
) -> Result(Int, Nil) {
  case seq {
    [] -> Error(Nil)
    [a, ..tail] ->
      case length(a) < n {
        True -> Ok(initial_length - list.length(seq))
        False ->
          find_index_of_first_with_length_less_than_n(n, tail, initial_length)
      }
  }
}

fn solve_batch(n: Int, start_index: Int, batch_size: Int) -> Int {
  let indexes = get_seq(start_index + batch_size, [start_index])
  let last_index = list.first(indexes) |> result.unwrap(0)

  let fibs = indexes |> list.map(recursion.get_fib)
  let last_fib_length = list.first(fibs) |> result.unwrap(0) |> length

  case last_fib_length >= n {
    True -> {
      let rest_index_amount_res =
        find_index_of_first_with_length_less_than_n(n, fibs, list.length(fibs))

      case rest_index_amount_res |> result.is_ok {
        True -> last_index - result.unwrap(rest_index_amount_res, 0) + 1
        False -> solve_batch(n, last_index + 1, batch_size)
      }
    }

    False -> solve_batch(n, last_index + 1, batch_size)
  }
}

pub fn solve(n: Int) -> Int {
  solve_batch(n, 0, 100)
}
