let rec scale digits factor carry acc =
  match digits with
  | [] -> if carry > 0 then scale digits factor (carry / 10) ((carry mod 10) :: acc) else acc
  | hd :: tl ->
      let prod = hd * factor + carry in
      scale tl factor (prod / 10) ((prod mod 10) :: acc)

let scale_tail digits factor =
  List.rev (scale digits factor 0 [])

let rec multiply acc i n =
  if i > n then acc
  else multiply (scale_tail acc i) (i + 1) n

let rec sum_of_digits digits acc =
  match digits with
  | [] -> acc
  | hd :: tl -> sum_of_digits tl (hd + acc)

let solve n =
  sum_of_digits (multiply [1] 2 n) 0

(* Пример использования *)
let result = solve 100;;
print_int result;;
