let nb_digit = 3

let rev_string str =
  let len = String.length str in
  let res = String.create len in
  let last = len - 1 in
  for i = 0 to last do
    let j = last - i in
    res.[i] <- str.[j];
  done;
  (res)

let is_even n =
  n mod 2 = 0

(* https://en.wikipedia.org/wiki/Exponentiation_by_squaring *)
let pow base exponent =
  if exponent < 0 then invalid_arg "exponent can not be negative" else
  let rec aux accumulator base = function
    | 0 -> accumulator
    | 1 -> base * accumulator
    | e when is_even e -> aux accumulator (base * base) (e / 2)
    | e -> aux (base * accumulator) (base * base) ((e - 1) / 2) in
  aux 1 base exponent

(* Cette fonction détermine si un entier est un Palindrome *)
let est_un_palindrome n nb_digit =
  n > pow 10 (2 * nb_digit -1) &&
  let result = ref true in
  for i = 0 to nb_digit do
    result := !result && (((n / (pow 10 (2 * nb_digit - 1 - i))) mod 10) = ((n / (pow 10 i)) mod 10))
  done;
  !result;;
  (*(((n / 100000) = (n mod 10)) && (((n / 10000) mod 10) = ((n / 10) mod 10)) && (((n / 1000) mod 10) = ((n /100) mod 10)));;*)

(* Cette fonction effectue la recherche de Palindrome en force brute *)
let rec max_pal i j r =
  if j * (pow 10 nb_digit - 1) < r
  then r
  else match i,j with
    | 0,0 -> r
    | 0,_ -> max_pal (pow 10 nb_digit) (j-1) r
    | _,_ ->
    let candidat = i * j in
    if est_un_palindrome candidat nb_digit
    then max_pal (i - 1) j (max r candidat)
    else max_pal (i - 1) j r


let res = max_pal (pow 10 nb_digit - 1) (pow 10 nb_digit - 1) 0;;
let s_res = string_of_int res;;
print_endline s_res
