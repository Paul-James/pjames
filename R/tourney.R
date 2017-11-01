#' Tournament seeding
#'
#' Creates the seeding for a tournament bracket randomly given the names of the participants.
#' @param ... Each participant name as a character string separated by commas.
#' @keywords tournament, tourney, wrestle jump, soccer physics, seed, seeding, bracket
#' @export
#' @examples
#' tourney('Andrew', 'David', 'Keith', 'Paul', 'Jordan', 'Cristian', 'Matthew', 'Blair')

tourney <- function(...){
  players <- unlist(list(...))

  bracket <- data.frame(
    player = players[sample(1:length(players), replace = FALSE)]
    )

  View(bracket)
}
