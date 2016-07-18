
let max_range = 1000

let rec sum_multiples number res =
  if number >= max_range then res
  else
  if (number mod 5 == 0) || (number mod 3 == 0)
  then sum_multiples (number + 1) (res + number)
  else sum_multiples (number + 1) (res)


let sum = sum_multiples 0 0;;

let s_sum = string_of_int sum;;

print_endline s_sum;;

