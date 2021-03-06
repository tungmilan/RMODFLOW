#' Write a MODFLOW basic file
#' 
#' \code{write_bas} writes a MODFLOW basic file based on an \code{\link{RMODFLOW}} bas object.
#' 
#' @param bas an \code{\link{RMODFLOW}} bas object
#' @param file filename to write to; typically '*.bas'
#' @param iprn format code for printing arrays in the listing file; defaults to -1 (no printing)
#' @return \code{NULL}
#' @export
write_bas <- function(bas,
                      file = {cat('Please select bas file to overwrite or provide new filename ...\n'); file.choose()},
                      iprn=-1) {
  
  # data set 0
    v <- packageDescription("RMODFLOW")$Version
    cat(paste('# MODFLOW Basic Package created by RMODFLOW, version',v,'\n'), file=file)
    cat(paste('#', comment(bas)), sep='\n', file=file, append=TRUE)
    
  # data set 1
    options <- NULL
    if(bas$xsection) options <- paste(options, 'XSECTION ',sep='')
    if(bas$chtoch) options <- paste(options, 'CHTOCH ',sep='')
    if(bas$free) options <- paste(options, 'FREE ',sep='')
    if(bas$printtime) options <- paste(options, 'PRINTTIME ',sep='')
    if(bas$showprogress) options <- paste(options, 'SHOWPROGRESS ',sep='')
    if(bas$stoperror) options <- paste(options,'STOPERROR ',bas$stoper,sep='')
    write_modflow_variables(options, file=file)
      
  # data set 2
    if(bas$xsection) {
      write_modflow_array(bas$ibound, file = file, iprn = iprn) # update after changing read_bas!
    } else {
      write_modflow_array(bas$ibound, file = file, iprn = iprn)
    }
  
  # data set 3
    write_modflow_variables(bas$hnoflo, file=file)
  
  # data set 4
    if(bas$xsection) {
      write_modflow_array(bas$strt, file = file, iprn = iprn) # update after changing read_bas!
    } else {
      write_modflow_array(bas$strt, file = file, iprn = iprn)
    }
}
