#' Write a MODFLOW multiplier file
#' 
#' @param mlt an \code{\link{RMODFLOW}} mlt object
#' @param file filename to write to; typically '*.mlt'
#' @param iprn format code for printing arrays in the listing file; defaults to -1 (no printing)
#' @return \code{NULL}
#' @export
write_mlt <- function(mlt,
                      file = {cat('Please select mlt file to overwrite or provide new filename ...\n'); file.choose()},
                      iprn=-1) {
  
  # data set 0
    v <- packageDescription("RMODFLOW")$Version
    cat(paste('# MODFLOW Multiplier File created by RMODFLOW, version',v,'\n'), file=file)
    cat(paste('#', comment(mlt)), sep='\n', file=file, append=TRUE)
    
  # data set 1
    write_modflow_variables(mlt$nml, file=file)
  
  # data set 2 + 3 
  for(i in 1:mlt$nml)
  {
    write_modflow_variables(mlt$mltnam[i], file=file) 
    if(length(mlt$rmlt[[i]])==1) {
      cat(paste('CONSTANT ', mlt$rmlt[[i]], '\n', sep=''), file=file, append=TRUE)
    } else {
      write_modflow_array(mlt$rmlt[[i]], file = file, iprn = iprn)
    }
  }  
}
