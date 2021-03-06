% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_pvl.R
\name{read_pvl}
\alias{read_pvl}
\title{Read a MODFLOW parameter value file}
\usage{
read_pvl(file = {     cat("Please select pvl file ...\\n")     file.choose()
  }, read_all = F)
}
\arguments{
\item{file}{filename; typically '*.pvl'}

\item{read_all}{logical, indicating if \code{np} parameters should be read, or the full parameter table (only relevant if external codes use the pvl file for storing additional parameters).}
}
\value{
object of class pvl
}
\description{
\code{read_pvl} reads in a MODFLOW parameter value file and returns it as an \code{\link{RMODFLOW}} pvl object.
}

