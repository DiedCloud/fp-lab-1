let factorial n =
  List.fold_left ( * ) 1 (List.init n (fun i -> i + 1))

let sum_of_digits n =
  string_of_int n
  |> String.to_seq
  |> List.of_seq
  |> List.map (fun c -> int_of_char c - int_of_char '0')
  |> List.fold_left ( + ) 0

let solve n =
  let fact = factorial n in
  sum_of_digits fact

(* Пример использования *)
let result = solve 100;;
print_int result;;
