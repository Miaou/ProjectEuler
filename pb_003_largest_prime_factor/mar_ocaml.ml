let concat_factors f d =
  if f = ""
  then string_of_int d
  else f^" * "^(string_of_int d);;

let largest_divisor n =
  let rec largest_divisor_aux s n d r f =
    if d = s
    then (n, concat_factors f n)
    else if n = 1
    then (r,f)
    else if n mod d = 0
    then
      let f = concat_factors f d in
      largest_divisor_aux s (n/d) d d f
    else largest_divisor_aux s n (d+1) r f
  in
  largest_divisor_aux (int_of_float (sqrt (float_of_int n))) n 2 1 "";;

  let usage _ =
      Printf.printf "Usage: mar_ocaml [integer]\n";
      exit 1;;

  if Array.length(Sys.argv) = 2
  then
    let n =
      try
        int_of_string(Sys.argv.(1))
      with Failure("int_of_string") -> usage ()
    in
    let t = Sys.time() in
    let r,f = largest_divisor n in
    let t = (Sys.time() -. t) *. 1000.0 in
    Printf.printf
      "Input   : %i\nResult  : %i\nFactors : %i = %s\nTime    : %f ms\n"
      n r n f t
  else
    usage ()
