let rec is_prime_aux n l r =
  match l with
  | [] -> true
  | d::l ->
    if d > r then true
    else if n mod d = 0 then false
    else is_prime_aux n l r

let is_prime n l = is_prime_aux n l (int_of_float (sqrt (float_of_int n)))

let rec prime n l i s =
  if s = n then
  List.nth l (n-1)
  else if is_prime i l then prime n (List.append l [i]) (i+2) (s+1)
  else prime n l (i+2) s

let n =
  try int_of_string (Sys.argv.(1))
  with _ -> print_string "Fournir l'index du premier à trouver en argument du programme"; exit 1

let _ = Printf.printf "%i: ---> %i <---\n" n (prime n [2] 3 0)