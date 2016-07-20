
let max = 20

let rec is_div number div =
  if (number mod div == 0)  then
    if (div == max) then
      number
    else
      is_div number (div+1)
  else
    is_div (number+1) 2


let num = is_div 2 2;;

let s_num = string_of_int num;;

print_endline s_num;;


