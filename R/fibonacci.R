#' Calculate a fibonacci sequence
#'
#' Takes a sequence length and any two positive numbers in order to produce a fibonacci sequence. The fibonacci sequence is returned as a vector of numbers.
#' @param seq_length The length of the sequence as a number. The sequence length has to be greater than or equal to 2 (seq_length >= 2). The default is 10.
#' @param first_num The starting point of the sequence. Use any positive number that comes before second_num (first_num < second_num). The default is 0.
#' @param second_num The next number in the sequence after frist_num. Use any posiitive number that comes after first_num (second_num > first_num). The default is 1.
#' @keywords fibonacci, sequence, math, science, nature
#' @export
#' @examples
#' fibonacci('eight', 2, -1)  # wrong way 1
#' fibonacci(8, 2, -1)  # wrong way 2
#' fibonacci(8, 2, 1)  # wrong way 3
#' fibonacci(8, 2, 2) # wrong way 4

#' fibonacci(8, 10, 2)  # correct way!
#' fibonacci(seq_length = 20, first_num = 10, second_num = 15)  # yay!
#' fibonacci(30)
#' fibonacci()

fibonacci <- function(seq_length = 10, first_num = 0, second_num = 1){

    # MAKE SURE THERE ARE ONLY NUMBERS AS PARAMETERS
    if(!is.numeric(c(first_num, second_num, seq_length))){
        stop("Whoah there. You used a non-number as a paramerter. Check yourself and only use numbers.")
    }
    # MAKE SURE ALL PARAMETERS ARE GREATER THAN 0
    if(sum(c(first_num, second_num, seq_length) < 0) > 0){
        stop("Only use positive numbers please. Muchas gracias!")
    }
    # MAKE SURE THE SEQUENCE LENGTH IS 2 OR MORE
    if(seq_length < 1){
        stop("Make sure your sequence length is 1 or more you silly goose.")
    }
    # MAKE SURE THE SECOND NUMBER IS LARGER THAN THE FIRST
    if(second_num - first_num <= 0){
        stop("Make sure your second number is bigger than your first number slick.")
    }

    fibo_seq <- vector(length = seq_length)

    if(seq_length < 2){
        fibo_seq <- first_num

    } else if (seq_length == 2){
        fibo_seq[1:2] <- c(first_num, second_num)

    } else {
        fibo_seq[1:2] <- c(first_num, second_num)

        for(i in 3:seq_length){
            fibo_seq[i] <- fibo_seq[i - 2] + fibo_seq[i - 1]
        }
    }

    fibo_seq
}
