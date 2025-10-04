import gleam/list

fn get_seq_impl(n: Int, acc: List(Int)) -> List(Int) {
  case n > 0 {
    True -> get_seq_impl(n - 1, [n, ..acc])
    False -> acc
  }
}

fn get_seq(n: Int) -> List(Int) {
  get_seq_impl(n, [])
}

fn get_seq_squred_impl(n: Int, acc: List(Int)) -> List(Int) {
  case n > 0 {
    True -> get_seq_squred_impl(n - 1, [square(n), ..acc])
    False -> acc
  }
}

fn get_seq_squred(n: Int) -> List(Int) {
  get_seq_squred_impl(n, [])
}

fn square(x: Int) -> Int {
  x * x
}

fn add(count: Int, e: Int) -> Int {
  count + e
}

pub fn solve(n: Int) -> Int {
  let square_of_sum = get_seq(n) |> list.fold(0, add) |> square
  let sum_of_squares = get_seq_squred(n) |> list.fold(0, add)
  square_of_sum - sum_of_squares
}
