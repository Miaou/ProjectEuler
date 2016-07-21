
(* Affiche les conditions d'utilisation du programme *)
let usage prog_name =
    Printf.printf "Usage : %s [Integer] \n" prog_name;;

if Array.length(Sys.argv) == 2 then
  let max = int_of_string Sys.argv.(1) in

  (* Determine la liste des nombres premiers inférieurs à un nombre *)
  let rec filter_primes candidates_list max_prime product =
  if List.length candidates_list == 0 then
    (max_prime, product)
  else let elem = List.hd candidates_list in
  let s_elem = string_of_int elem in
  print_endline s_elem;
  if (max == elem) then
    (elem, (product*elem))
  else
    let tmp_list = List.tl candidates_list in
    let new_candidates_list = List.filter (fun x -> (x mod elem) != 0) tmp_list in
    filter_primes new_candidates_list elem (product * elem) in

  (* Utilitaire de création de liste *)
  let rec create_list min max =
  if min > max then
      []
  else
    min::create_list (min+1) max in

  let candidates_list = create_list 2 max in

  let (max_factor, product) = filter_primes candidates_list 2 1 in
  let s_max = string_of_int max_factor in
  print_endline s_max;
  let s_product = string_of_int product in
  print_endline s_product;

 let rec is_div number div =
  if (number mod div == 0)  then
    if (div == 1) then
      number
    else
      is_div number (div-1)
  else
    is_div (number+product) max in

  let num = is_div product max in
  let s_num = string_of_int num in
  print_endline s_num;
else
  let prog_name = Sys.argv.(0) in
  usage prog_name;;

