#' Read a MODFLOW layer-property flow file
#' 
#' \code{read_lpf} reads in a MODFLOW layer property file and returns it as an \code{\link{RMODFLOW}} lpf object.
#' 
#' @param file filename; typically '*.lpf'
#' @return object of class lpf
#' @importFrom readr read_lines
#' @export
#' @seealso \code{\link{write_lpf}}, \code{\link{create_lpf}} and \url{http://water.usgs.gov/nrp/gwsoftware/modflow2000/MFDOC/index.html?lpf.htm}
read_lpf <- function(file = {cat('Please select lpf file ...\n'); file.choose()}) {
  
  lpf.lines <- read_lines(file)
  lpf <- list()
  
  # data set 0
    comments <- get_comments_from_lines(lpf.lines)
    lpf.lines <- remove_comments_from_lines(lpf.lines)
  
  # data set 1
    data_set1 <- remove_empty_strings(strsplit(lpf.lines[1],' ')[[1]])
    lpf.lines <- lpf.lines[-1]  
    lpf$ilpfcb <- as.numeric(data_set1[1])
    lpf$hdry <- as.numeric(data_set1[2])
    lpf$nplpf <- as.numeric(data_set1[3])
    lpf$storagecoefficient <- 'STORAGECOEFFICIENT' %in% data_set1
    lpf$constantcv <- 'CONSTANTCV' %in% data_set1
    lpf$thickstrt <- 'THICKSTRT' %in% data_set1
    lpf$nocvcorrection <- 'NOCVCORRECTION' %in% data_set1
    lpf$novfc <- 'NOVFC' %in% data_set1
    lpf$noparcheck <- 'NOPARCHECK' %in% data_set1
    rm(data_set1)
  
  # data set 2
    lpf$laytyp <- as.numeric(remove_empty_strings(strsplit(lpf.lines[1],' ')[[1]]))
    lpf.lines <- lpf.lines[-1]
  
  # data set 3
    lpf$layavg <- as.numeric(remove_empty_strings(strsplit(lpf.lines[1],' ')[[1]]))
    lpf.lines <- lpf.lines[-1]
  
  # data set 4
    lpf$chani <- as.numeric(remove_empty_strings(strsplit(lpf.lines[1],' ')[[1]]))
    lpf.lines <- lpf.lines[-1]
  
  # data set 5
    lpf$layvka <- as.numeric(remove_empty_strings(strsplit(lpf.lines[1],' ')[[1]]))
    lpf.lines <- lpf.lines[-1]
    
  # data set 6
    lpf$laywet <- as.numeric(remove_empty_strings(strsplit(lpf.lines[1],' ')[[1]]))
    lpf.lines <- lpf.lines[-1]
  
  # data set 7
    if(!as.logical(prod(lpf$laywet==0))) {
      data_set7 <- remove_empty_strings(strsplit(lpf.lines[1],' ')[[1]])
      lpf.lines <- lpf.lines[-1]  
      lpf$wetfct <- as.numeric(data_set7[1])
      lpf$iwetit <- as.numeric(data_set7[2])
      lpf$ihdwet <- as.numeric(data_set7[3])
      rm(data_set7)
    }
  
  # data set 8-9
    lpf$parnam <- vector(mode='character',length=lpf$nplpf)
    lpf$partyp <- vector(mode='character',length=lpf$nplpf)
    lpf$parval <- vector(mode='numeric',length=lpf$nplpf)
    lpf$nclu <- vector(mode='numeric',length=lpf$nplpf)
    lpf$mltarr <- matrix(nrow=dis$nlay, ncol=lpf$nplpf)
    lpf$zonarr <- matrix(nrow=dis$nlay, ncol=lpf$nplpf)
    lpf$iz <- matrix(nrow=dis$nlay, ncol=lpf$nplpf)
    for(i in 1:lpf$nplpf) {
      line.split <- split_line_words(lpf.lines[1]); lpf.lines <- lpf.lines[-1]
      lpf$parnam[i] <- line.split[1]
      lpf$partyp[i] <- line.split[2]
      lpf$parval[i] <- as.numeric(line.split[3])
      lpf$nclu[i] <- as.numeric(line.split[4])
      for(j in 1:lpf$nclu[i]) {
        line.split <- split_line_words(lpf.lines[1]); lpf.lines <- lpf.lines[-1]
        k <- as.numeric(line.split[1])
        lpf$mltarr[k,i] <- line.split[2]
        lpf$zonarr[k,i] <- line.split[3]
        lpf$iz[k,i] <- paste(line.split[-c(1:3)],collapse=' ')
      } 
    }
  
  # data set 10-16
    lpf$hk <- array(dim=c(dis$nrow, dis$ncol, dis$nlay))
    class(lpf$hk) <- 'rmodflow_3d_array'
    lpf$hani <- lpf$vka <- lpf$ss <- lpf$sy <- lpf$vkcb <- lpf$wetdry <- lpf$hk
    for(k in 1:dis$nlay) {
      
      # data set 10
        if('HK' %in% lpf$partyp) {
          lpf.lines <- lpf.lines[-1]  
          lpf$hk[,,k] <- NA
        } else {
          data_set10 <- read_modflow_array(lpf.lines,dis$nrow,dis$ncol,1)
          lpf.lines <- data_set10$remaining_lines
          lpf$hk[,,k] <- data_set10$array
          rm(data_set10)
        }
        
      # data set 11
        if(lpf$Chani[k] <= 0) {
          if('HANI' %in% lpf$partyp) {
            lpf.lines <- lpf.lines[-1]  
            lpf$hani[,,k] <- NA
          } else {
            data_set11 <- read_modflow_array(lpf.lines,dis$nrow,dis$ncol,1)
            lpf.lines <- data_set11$remaining_lines
            lpf$hani[,,k] <- data_set11$array
            rm(data_set11)
          }
        }
        
      # data set 12
        if('VK' %in% lpf$partyp | 'VANI' %in% lpf$partyp) {
          lpf.lines <- lpf.lines[-1]  
          lpf$vka[,,k] <- NA
        } else {
          data_set12 <- read_modflow_array(lpf.lines,dis$nrow,dis$ncol,1)
          lpf.lines <- data_set12$remaining_lines
          lpf$vka[,,k] <- data_set12$array
          rm(data_set12)
        }
        
      # data set 13
        if('TS' %in% dis$sstr) {
          if('SS' %in% lpf$partyp) {
            lpf.lines <- lpf.lines[-1]  
            lpf$ss[,,k] <- NA
          } else {
            data_set13 <- read_modflow_array(lpf.lines,dis$nrow,dis$ncol,1)
            lpf.lines <- data_set13$remaining_lines
            lpf$ss[,,k] <- data_set13$array
            rm(data_set13)
          }
        }
        
      # data set 14
        if('TS' %in% dis$sstr & lpf$laytyp[k] != 0) {
          if('SY' %in% lpf$partyp) {
            lpf.lines <- lpf.lines[-1]  
            lpf$sy[,,k] <- NA
          } else {
            data_set14 <- read_modflow_array(lpf.lines,dis$nrow,dis$ncol,1)
            lpf.lines <- data_set14$remaining_lines
            lpf$sy[,,k] <- data_set14$array
            rm(data_set14)
          }
        }
        
      # data set 15
        if(dis$laycbd[k] != 0) {
          if('VKCB' %in% lpf$partyp) {
            lpf.lines <- lpf.lines[-1]  
            lpf$vkcb[,,k] <- NA
          } else {
            data_set15 <- read_modflow_array(lpf.lines,dis$nrow,dis$ncol,1)
            lpf.lines <- data_set15$remaining_lines
            lpf$vkcb[,,k] <- data_set15$array
            rm(data_set15)
          }
        }
        
      # data set 16
        if(lpf$laywet[k] != 0 & lpf$laytyp[k] != 0) {
          data_set16 <- read_modflow_array(lpf.lines,dis$nrow,dis$ncol,1)
          lpf.lines <- data_set16$remaining_lines
          lpf$wetdry[,,k] <- data_set16$array
          rm(data_set16)
        }     
    }
  
  comment(lpf) <- comments
  class(lpf) <- c('lpf','modflow_package')
  return(lpf)
}
