% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_kdep.R
\name{read_kdep}
\alias{read_kdep}
\title{Read a MODFLOW hydraulic conductivity depth-dependence capability file}
\usage{
read_kdep(file = {     cat("Please select kdep file ...\\n")     file.choose()
  }, dis = {     cat("Please select corresponding dis file ...\\n")    
  read_dis(file.choose()) }, huf = {    
  cat("Please select corresponding huf file ...\\n")     read_huf(file.choose(),
  dis = dis) })
}
\arguments{
\item{file}{Filename; typically *.kdep}

\item{dis}{discretization file object; defaults to that with the same filename but with extension '.dis'}

\item{huf}{hydrogeologic unit file object; defaults to that with the same filename but with extension '.huf'}
}
\value{
object of class kdep
}
\description{
\code{read_kdep} reads in a MODFLOW Hydraulic-Conductivity Depth-Dependence Capability file and returns it as an \code{\link{RMODFLOW}} kdep object.
}

