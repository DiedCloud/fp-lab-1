import gens/stream
import gleam/list
import gleam/result

import gleam/int
import gleam/pair
import gleam/string

fn length(n: Int) -> Int {
  n |> int.to_string |> string.length
}

fn get_fib_stream() -> stream.Stream(#(#(Int, Int), #(Int, Int))) {
  stream.Stream(head: fn() { #(#(1, 1), #(2, 1)) }, tail: fn() {
    stream.map(get_fib_stream(), fn(int_pair) {
      case int_pair {
        #(#(i1, f1), #(i2, f2)) -> #(#(i1 + 1, f2), #(i2 + 1, f1 + f2))
      }
    })
  })
}

pub fn solve(n: Int) -> Int {
  let i =
    stream.while(get_fib_stream(), fn(int_pair) {
      int_pair |> pair.second |> pair.second |> length < n
    })
    |> list.last
    |> result.unwrap(#(#(0, 0), #(0, 0)))
    |> pair.second
    |> pair.first
  // + 1 так как stream.while до момента, пока условие не выполнено
  i + 1
}
