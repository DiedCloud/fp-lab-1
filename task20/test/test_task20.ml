open OUnit2
open Task20_lib

(* Tailrec tests *)
let test_tailrec _ =
  assert_equal 3 (Tail_recursion.solve 5);;
  assert_equal 648 (Tail_recursion.solve 100);;
;;

(* Rec tests *)
let test_rec _ =
  assert_equal 3 (Recursion.solve 5);;
  assert_equal 648 (Recursion.solve 100);;
;;

(* Module tests *)
let test_moduled _ =
  assert_equal 3 (Moduled.solve 5);;

(* Iterative tests*)
let test_iterative _ =
  assert_equal 3 (Iterative.solve 5);;
  assert_equal 648 (Iterative.solve 100);;
;;

(* Map tests *)
let test_mapped _ =
  assert_equal 3 (Mapped.solve 5);;
;;

(* Lazy collections tests *)
let test_lazy _ =
  assert_equal 3 (Lazy.solve 5);;
;;

let suite =
  "Project Euler Problem 20 Tests"
  >::: [ "Tailrec - " >:: test_tailrec
       ; "Rec - " >:: test_rec
       ; "Moduled - " >:: test_moduled
       ; "Iterative - " >:: test_iterative
       ; "Mapped - " >:: test_mapped
       ; "Lazy - " >:: test_lazy
       ]
;;

let _ = run_test_tt_main suite
