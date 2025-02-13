let rec scale digits factor carry =
  match digits with
  | [] -> if carry > 0 then (carry mod 10) :: scale [] factor (carry / 10) else []
  | hd :: tl ->
      let prod = hd * factor + carry in
      (prod mod 10) :: scale tl factor (prod / 10)

let rec multiply acc i n =
  if i > n then acc
  else multiply (scale acc i 0) (i + 1) n

let rec sum_of_digits = function
  | [] -> 0
  | hd :: tl -> hd + sum_of_digits tl

let solve n =
  sum_of_digits (multiply [1] 2 n)

(* Пример использования *)
let result = solve 100;;
print_int result;;
