let factorial n =
  let res = ref 1 in
  for i = 2 to n do
    res := !res * i
  done;
  !res;;

let sum_of_digits n =
  let res = ref 1 in
  let temp_n = ref n in
  while !temp_n > 0 do
    res := !res * (!temp_n mod 10);
    temp_n := !temp_n / 10
  done;
  !res;;

let solve n = sum_of_digits (factorial n)

(* Пример использования *)
let result = solve 100;;
print_int result;;

