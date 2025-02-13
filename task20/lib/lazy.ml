module LazyList = struct
  type 'a t = Nil | Cons of 'a * (unit -> 'a t)

  let rec from n = Cons (n, fun () -> from (n + 1))

  let rec take n = function
    | Nil -> []
    | Cons (x, xs) when n > 0 -> x :: take (n - 1) (xs ())
    | _ -> []

  let rec fold_left f acc = function
    | Nil -> acc
    | Cons (x, xs) -> fold_left f (f acc x) (xs ())

  let factorial n =
    take n (from 1)
    |> List.fold_left ( * ) 1

  let sum_of_digits n =
    string_of_int n
    |> String.to_seq
    |> List.of_seq
    |> List.fold_left (fun acc c -> acc + (int_of_char c - int_of_char '0')) 0
end

let solve n =
  let fact = LazyList.factorial n in
  LazyList.sum_of_digits fact

(* Пример использования *)
let result = solve 100;;
print_int result;;
