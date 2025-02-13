let rec factorial n = if n = 0 then 1 else n * factorial (n - 1)

let rec sum_of_digits n =
  if n = 0 then 0 else (n mod 10) + sum_of_digits (n / 10)

let solve n = sum_of_digits (factorial n)

(* Пример использования *)
let result = solve 100;;
print_int result;;
