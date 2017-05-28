open Printf


(* Affiche les conditions d'utilisation du programme *)
let usage prog_name =
    Printf.printf "Usage : %s [Integer] \n" prog_name;;

if Array.length(Sys.argv) == 2 then
  let max = int_of_string Sys.argv.(1) in

  (* Determine la liste des nombres premiers inférieurs à un nombre *)
  let rec filter_primes candidates_list =
  if List.length candidates_list == 0 then
    []
  else let elem = List.hd candidates_list in
  (*let s_elem = string_of_int elem in
  print_endline s_elem;*)
  (* critère d'arrêt *)
  if (elem > max) then
    []
  else
    let tmp_list = List.tl candidates_list in
    let new_candidates_list = List.filter (fun x -> (x mod elem) != 0) tmp_list in
    elem::filter_primes new_candidates_list in

  (* Utilitaire de création de liste de candidats premiers.
   2 et tous les nombres pairs sont exlus de la liste pour
   des raisons de perf. *)
  let rec create_list min max =
  if min > max then
      []
  else
    min::create_list (min+2) max in

  let candidates_list = create_list 3 max in

  (* on recupere le 2 *)
  let prime_list = 2::filter_primes candidates_list in
  let prime_list_length = List.length prime_list in

  let s_prime_list_length = string_of_int prime_list_length in

  (* construction de la somme cumulative *)
  let rec build_cumulative_list prime_list cumul = match prime_list with
    | [] -> []
    | [h] -> [cumul+h]
    | h::remain -> [cumul+h]@build_cumulative_list remain (cumul+h) in

  let cumul_list = build_cumulative_list prime_list 0 in

  (* vérification de la somme *)
  let rec check_sum_at_index start_index sum_length =
  let temp_sum = (List.nth cumul_list (start_index + sum_length)) - (List.nth cumul_list start_index) in
  (* optim: pas la peine d'aller plus loin si la somme cumul est déjà plus grande que le max*)
  if (temp_sum > max) then
    0
  else
    if List.mem temp_sum prime_list then
      temp_sum
    else
      if (start_index = prime_list_length - sum_length - 1) then
        0
      else
        check_sum_at_index (start_index+1) sum_length in

  (* vérification des chaines de manière décroissante *)
  let rec check_consecutives_primes sum_length =
  let check_length = check_sum_at_index 0 sum_length in
  if check_length = 0 then
    check_consecutives_primes (sum_length-1)
  else
    check_length in

  (*let () = List.iter (printf "%d ") prime_list in*)
  (*let () = List.iter (printf "%d ") cumul_list in*)
  let sum_result = check_consecutives_primes (prime_list_length - 1) in
  let s_sum_result = string_of_int sum_result in
  print_endline "\n s_prime_list_length";
  print_endline s_prime_list_length;
  print_endline "\n Sum result:";
  print_endline s_sum_result;
  print_endline "End of program";
  (*let s_sum = string_of_int sum in
  print_endline s_sum;*)

else
  let prog_name = Sys.argv.(0) in
  usage prog_name;;

