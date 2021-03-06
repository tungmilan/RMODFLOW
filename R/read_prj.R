#' Read a projection file
#' 
#' \code{read_prj} reads in projection file and returns it as a prj object.
#' 
#' @param file filename; typically '*.prj'
#' @return object of class prj
#' @importFrom readr read_lines
#' @export
read_prj <- function(file = {cat('Please select prj file ...\n'); file.choose()}) {
  prj.lines <- readr::read_lines(file)
  prj <- list()
  prj$projection <- prj.lines[1]
  prj$origin <- as.numeric(RMODFLOW:::remove_empty_strings(strsplit(prj.lines[2],' ')[[1]]))
  prj$rotation <- as.numeric(RMODFLOW:::remove_empty_strings(strsplit(prj.lines[3],' ')[[1]])[1])
  if(length(prj.lines) > 3) prj$starttime <- as.POSIXct(prj.lines[4])
  class(prj) <- 'prj'
  return(prj)
}
