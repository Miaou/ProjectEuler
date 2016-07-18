
let max_term = 4000000

let rec fibonacci term1 term2 res =
  let new_term = term1 + term2 in
  if new_term >= max_term then res
  else
  if (new_term mod 2 == 0)
  then fibonacci term2 new_term (res+new_term)
  else fibonacci term2 new_term (res)

let sum = fibonacci 1 2 2;;

let s_sum = string_of_int sum;;

print_endline s_sum;;

