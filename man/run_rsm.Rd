% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_rsm.R
\name{run_rsm}
\alias{run_rsm}
\title{Run a MODFLOW model response surface mapping}
\usage{
run_rsm(file, executable = "mf2005", par = NULL, include = NULL,
  trans = NULL, lower, upper, n)
}
\arguments{
\item{file}{path to name file; typically '*.nam'}

\item{executable}{name of the MODFLOW executable to use}

\item{par}{central parameter values (for all or only included parameters); current parameter value file values are used if par is not provided}

\item{include}{logical vector indicating which parameters in the parameter value file to include in the mapping}

\item{trans}{vector of transformations; currently only 'log' is supported}

\item{lower}{lower parameter bounds}

\item{upper}{upper parameter bounds}

\item{n}{number of intervals sampled for each parameter}
}
\value{
an rsm object with the full list of parameters and the response value
}
\description{
\code{run_modflow_rsm} runs a MODFLOW response surface mapping.
}

