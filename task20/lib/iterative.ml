let scale digits factor =
  let acc = ref [] in
  let carry = ref 0 in
  List.iter (fun hd ->
    let prod = hd * factor + !carry in
    acc := (prod mod 10) :: !acc;
    carry := prod / 10
  ) digits;
  while !carry > 0 do
    acc := (!carry mod 10) :: !acc;
    carry := !carry / 10
  done;
  List.rev !acc

let factorial n =
  let result = ref [1] in
  for i = 2 to n do
    result := scale !result i
  done;
  !result

let sum_of_digits digits =
  let sum = ref 0 in
  List.iter (fun d -> sum := !sum + d) digits;
  !sum

let solve n = sum_of_digits (factorial n)

(* Пример использования *)
let result = solve 100;;
print_int result;;

