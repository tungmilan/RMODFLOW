% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/write_lpf.R
\name{write_lpf}
\alias{write_lpf}
\title{Write a MODFLOW layer-property flow file}
\usage{
write_lpf(lpf, file = {    
  cat("Please select lpf file to overwrite or provide new filename ...\\n")    
  file.choose() }, dis = read_dis(), iprn = -1)
}
\arguments{
\item{lpf}{an \code{\link{RMODFLOW}} lpf object}

\item{file}{filename to write to; typically '*.lpf'}

\item{iprn}{format code for printing arrays in the listing file; defaults to -1 (no printing)}
}
\value{
\code{NULL}
}
\description{
Write a MODFLOW layer-property flow file
}

