% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/write_mlt.R
\name{write_mlt}
\alias{write_mlt}
\title{Write a MODFLOW multiplier file}
\usage{
write_mlt(mlt, file = {    
  cat("Please select mlt file to overwrite or provide new filename ...\\n")    
  file.choose() }, iprn = -1)
}
\arguments{
\item{mlt}{an \code{\link{RMODFLOW}} mlt object}

\item{file}{filename to write to; typically '*.mlt'}

\item{iprn}{format code for printing arrays in the listing file; defaults to -1 (no printing)}
}
\value{
\code{NULL}
}
\description{
Write a MODFLOW multiplier file
}

