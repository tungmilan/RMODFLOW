#' Write a MODFLOW output control option file
#' 
#' \code{write_oc} writes a MODFLOW output control option file based on an \code{\link{RMODFLOW}} oc object.
#' 
#' @param oc an \code{\link{RMODFLOW}} oc object
#' @param file filename to write to; typically '*.oc'
#' @return \code{NULL}
#' @export
#' @seealso \code{\link{read_oc}}, \code{\link{create_oc}} and \url{http://water.usgs.gov/nrp/gwsoftware/modflow2000/MFDOC/index.html?oc.htm}
write_oc <- function(oc,
                     file = {cat('Please select oc file to overwrite or provide new filename ...\n'); file.choose()}) {
  
  # data set 0
    v <- packageDescription("RMODFLOW")$Version
    cat(paste('# MODFLOW Output Control Option File created by RMODFLOW, version',v,'\n'), file=file)
    cat(paste('#', comment(oc)), sep='\n', file=file, append=TRUE)
    
  # data set 1
    if(!is.na(oc$ihedfm)) cat(paste('HEAD PRINT FORMAT', oc$ihedfm, '\n'), file=file, append=TRUE)
    if(!is.na(oc$chedfm)) cat(paste('HEAD SAVE FORMAT', oc$chedfm, ifelse(oc$head_label,'LABEL',''), '\n'), file=file, append=TRUE)
    if(!is.na(oc$ihedun)) cat(paste('HEAD SAVE UNIT', oc$ihedun, '\n'), file=file, append=TRUE)
    if(!is.na(oc$iddnfm)) cat(paste('DRAWDOWN PRINT FORMAT', oc$iddnfm, '\n'), file=file, append=TRUE)
    if(!is.na(oc$cddnfm)) cat(paste('DRAWDOWN SAVE FORMAT', oc$cddnfm, ifelse(oc$drawdown_label,'LABEL',''), '\n'), file=file, append=TRUE)
    if(!is.na(oc$iddnun)) cat(paste('DRAWDOWN SAVE UNIT', oc$iddnun, '\n'), file=file, append=TRUE)
    if(!is.na(oc$cboufm)) cat(paste('IBOUND SAVE FORMAT', oc$cboufm, ifelse(oc$ibound_label,'LABEL',''), '\n'), file=file, append=TRUE)
    if(!is.na(oc$ibouun)) cat(paste('IBOUND SAVE UNIT', oc$ibouun, '\n'), file=file, append=TRUE)
    if(oc$compact_budget) cat(paste('COMPACT BUDGET',ifelse(oc$aux,'AUX',''), '\n'), file=file, append=TRUE)
    
  # data set 2
    for(i in 1:length(oc$iperoc)) {
      write_modflow_variables(paste('PERIOD',oc$iperoc[i],'STEP',oc$itsoc[i]),file = file)
      if(oc$print_head[i]) write_modflow_variables('PRINT HEAD', file = file)
      if(oc$print_drawdown[i]) write_modflow_variables('PRINT DRAWDOWN', file = file)
      if(oc$print_budget[i]) write_modflow_variables('PRINT BUDGET', file = file)
      if(oc$save_head[i]) write_modflow_variables('SAVE HEAD', file = file)
      if(oc$save_drawdown[i]) write_modflow_variables('SAVE DRAWDOWN', file = file)
      if(oc$save_ibound[i]) write_modflow_variables('SAVE IBOUND', file = file)
      if(oc$save_budget[i]) write_modflow_variables('SAVE BUDGET', file = file)
    }
}
