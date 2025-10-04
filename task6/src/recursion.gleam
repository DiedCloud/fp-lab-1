fn sum_rec(n: Int) -> Int {
  case n > 0 {
    True -> n + sum_rec(n - 1)
    False -> n
  }
}

fn square_of_sum(n: Int) -> Int {
  sum_rec(n) * sum_rec(n)
}

fn sum_of_squares(n: Int) -> Int {
  case n > 0 {
    True -> n * n + sum_of_squares(n - 1)
    False -> n
  }
}

pub fn solve(n: Int) -> Int {
  square_of_sum(n) - sum_of_squares(n)
}
