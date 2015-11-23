let rec is_prime_aux n primes i r =
  let d = primes.(i) in
    if d > r then true
    else if n mod d = 0 then false
    else is_prime_aux n primes (i+1) r

let is_prime primes n = is_prime_aux n primes 0 (int_of_float (sqrt (float_of_int n)))

let rec prime_aux n primes i s =
  if s = n then primes.(s-1)
  else if is_prime primes i then
    begin
      primes.(s) <- i;
      prime_aux n primes (i+2) (s+1)
    end
  else prime_aux n primes (i+2) s

let prime n =
  let primes = Array.make n 0 in
  primes.(0) <- 2;
  prime_aux n primes 3 1

let n =
  try int_of_string (Sys.argv.(1))
  with _ -> print_string "Fournir l'index du premier à trouver en argument du programme"; exit 1

let _ = Printf.printf "%i: ---> %i <---\n" n (prime n)