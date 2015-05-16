#' Read a GMS 2D grid file
#' 
#' \code{read.gms2dgrid} reads in a GMS 2D grid file and returns it as an \code{\link{RMODFLOW}} gms2dgrid object.
#' 
#' @param file Filename
#' @return Object of class gms2dgrid
#' @importFrom readr read_lines
#' @export
read_gms_2d_grid <- function(file)
{
  grid2d <- NULL
  grid2d.lines <- read_lines(file)
  #2dgrid.lines <- remove.comments.from.lines(mlt.lines)
  grid2d.lines <- grid2d.lines[-1]    
  grid2d$objtype <- as.character(strsplit(grid2d.lines[1],'\"')[[1]][2])
  grid2d.lines <- grid2d.lines[-1]
  grid2d.lines <- grid2d.lines[-1]
  grid2d$nd <- as.numeric(strsplit(grid2d.lines[1],' ')[[1]][3])
  grid2d.lines <- grid2d.lines[-1]
  grid2d$nc <- as.numeric(strsplit(grid2d.lines[1],' ')[[1]][3])    
  grid2d.lines <- grid2d.lines[-1]
  grid2d$n <- as.character(strsplit(grid2d.lines[1],'\"')[[1]][2])    
  grid2d.lines <- grid2d.lines[-1]    
  grid2d.lines <- grid2d.lines[-1] 
  
  grid2d$nddata <- as.numeric(grid2d.lines[1:grid2d$nd])
  grid2d$ncdata <- as.numeric(grid2d.lines[(1+grid2d$nd):(grid2d$nd + grid2d$nc)])              
  
  class(grid2d) <- 'gms_2d_grid'
  return(grid2d)
}