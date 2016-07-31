(* Affiche les conditions d'utilisation du programme *)
let usage prog_name =
    Printf.printf "Usage : %s [Integer] \n" prog_name;;

if Array.length(Sys.argv) == 2 then
  let max = int_of_string Sys.argv.(1) in

  let is_even n = n mod 2 = 0 in

  (* https://en.wikipedia.org/wiki/Exponentiation_by_squaring *)
  let pow base exponent =
  if exponent < 0 then invalid_arg "exponent can not be negative" else
  let rec aux accumulator base = function
    | 0 -> accumulator
    | 1 -> base * accumulator
    | e when is_even e -> aux accumulator (base * base) (e / 2)
    | e -> aux (base * accumulator) (base * base) ((e - 1) / 2) in
  aux 1 base exponent in

  let rec calculate_sum_and_square_sum index sum square_sum =
  if index > max then
    (sum, square_sum)
  else
    calculate_sum_and_square_sum (index+1) (sum+index) (square_sum + pow index 2) in


  let result = calculate_sum_and_square_sum 1 0 0 in
  let sum = pow (fst result) 2 in
  let square_sum = snd result in

  let final_result = sum - square_sum in

  Printf.printf ("Result for max = %d : %d \n") max final_result;


else
  let prog_name = Sys.argv.(0) in
  usage prog_name;;




