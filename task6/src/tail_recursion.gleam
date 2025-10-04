fn sum_tailrec_impl(n: Int, acc: Int) -> Int {
  case n > 0 {
    True -> sum_tailrec_impl(n - 1, acc + n)
    False -> acc
  }
}

fn sum(n: Int) -> Int {
  sum_tailrec_impl(n, 0)
}

pub fn square_of_sum(n: Int) -> Int {
  sum(n) * sum(n)
}

fn sum_of_squares_impl(n: Int, acc: Int) -> Int {
  case n > 0 {
    True -> sum_of_squares_impl(n - 1, acc + n * n)
    False -> acc
  }
}

pub fn sum_of_squares(n: Int) -> Int {
  sum_of_squares_impl(n, 0)
}

pub fn solve(n: Int) -> Int {
  square_of_sum(n) - sum_of_squares(n)
}
