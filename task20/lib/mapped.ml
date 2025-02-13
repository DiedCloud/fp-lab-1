let factorial n =
  Array.init n (fun i -> i + 1)
  |> Array.fold_left ( * ) 1

let sum_of_digits n =
  String.to_seq (string_of_int n)
  |> Array.of_seq
  |> Array.map (fun c -> Char.code c - Char.code '0')
  |> Array.fold_left ( + ) 0

let solve n =
  let fact = factorial n in
  sum_of_digits fact

(* Пример использования *)
let result = solve 100;;
print_int result;;
