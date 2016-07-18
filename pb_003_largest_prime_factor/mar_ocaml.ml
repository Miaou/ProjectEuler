let largest_divisor n =
  let rec largest_divisor_aux n d r f =
    if r >= n
    then (r,f)
    else if n mod d = 0
    then
      let f =
        if f = ""
        then string_of_int d
        else f^" * "^(string_of_int d) in
      largest_divisor_aux (n/d) d d f
    else largest_divisor_aux n (d+1) r f
  in
  largest_divisor_aux n 2 1 "";;

  if Array.length(Sys.argv) = 2
  then
    let n = int_of_string(Sys.argv.(1)) in
    let t = Sys.time() in
    let r,f = largest_divisor n in
    let t = (Sys.time() -. t) *. 1000.0 in
    Printf.printf
      "Input   : %i\nResult  : %i\nFactors : %i = %s\nTime    : %f ms\n"
      n r n f t
  else
    begin
      Printf.printf "Usage: mar_ocaml [integer]\n";
      exit 1
    end
