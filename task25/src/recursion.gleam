import gleam/int
import gleam/string

/// Расчёт числа Фибоначчи всё-таки через хвостовую рекурсию, так как иначе очень много фреймов и времени
fn get_fib_impl(n: Int, f1: Int, f2: Int) -> Int {
  case n {
    0 -> f1
    1 -> f2
    _ -> get_fib_impl(n - 1, f2, f1 + f2)
  }
}

pub fn get_fib(n: Int) -> Int {
  get_fib_impl(n, 0, 1)
}

fn get_index(n: Int, i: Int) -> Int {
  let len = get_fib(i) |> int.to_string |> string.length
  case len >= n {
    True -> i
    False -> get_index(n, i + 1)
  }
}

pub fn solve(n: Int) -> Int {
  get_index(n, 0)
}
