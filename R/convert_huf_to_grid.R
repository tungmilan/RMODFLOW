#' Convert a parameter defined on the HUF grid to the numerical grid
#' 
#' @param values vector of parameter values, in the order of HGUNAM
#' @param huf huf object
#' @param dis dis object
#' @param mask masking 3d array, typically the IBOUND array, to speed up grid conversion; defaults to including all cells
#' @param type type of averaging that should be performed; either arithmetic (default), harmonic or geometric
#' @return 3d array
#' @export
#' @import RTOOLZ
convert_huf_to_grid <- function(values,huf,dis,mask=dis$TOP/dis$TOP,type='arithmetic')
{
  num_grid_array <- dis$BOTM*NA
  huf$BOTM <- huf$THCK*NA
  huf$BOTM[,,1] <- huf$TOP[,,1]-huf$THCK[,,1]
  for(k in 2:dim(huf$THCK)[3])
  {
    huf$BOTM[,,k] <- huf$BOTM[,,k-1]-huf$THCK[,,k]
  } 
  dis$TOP <- array(c(dis$TOP,dis$BOTM[,,1:(dis$NLAY-1)]),dim=c(dis$NROW,dis$NCOL,dis$NLAY))
  
  i <- rep(1:dis$NROW,dis$NCOL*dis$NLAY)
  j <- rep(rep(1:dis$NCOL,each=dis$NROW),dis$NLAY)
  k <- rep(1:dis$NLAY,each=dis$NROW*dis$NCOL)
  num_grid_array[which(mask==0)] <- 0
  get_weighted_mean <- function(cell)
  {
        iCell <- i[cell]
        jCell <- j[cell]
        kCell <- k[cell]
        cell_top <- dis$TOP[iCell,jCell,kCell]
        cell_botm <- dis$BOTM[iCell,jCell,kCell]
        thck <- pmin(huf$TOP[iCell,jCell,],cell_top) - pmax(huf$BOTM[iCell,jCell,],cell_botm)
        thck[which(thck < 0)] <- 0
        if(type=='arithmetic') return(weighted.mean(values,thck))
        if(type=='harmonic') return(weighted.harmean(values,thck))
        if(type=='geometric') return(weighted.geomean(values,thck))
  }
  weighted_means <- lapply(which(mask!=0),get_weighted_mean)
  num_grid_array[which(mask!=0)] <- weighted_means
  num_grid_array <- array(num_grid_array,dim=c(dis$NROW,dis$NCOL,dis$NLAY))
  return(as.modflow_3d_array(num_grid_array))
}