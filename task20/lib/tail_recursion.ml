let factorial n =
  let rec aux acc n =
    if n = 0 then acc else aux (acc * n) (n - 1)
  in
  aux 1 n

let sum_of_digits n =
  let rec aux acc n =
    if n = 0 then acc else aux (acc + (n mod 10)) (n / 10)
  in
  aux 0 n

let solve n =
  let fact = factorial n in
  sum_of_digits fact

(* Пример использования *)
let result = solve 100;;
print_int result;;
