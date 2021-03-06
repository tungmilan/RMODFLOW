% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_modflow.R, R/run_modflow.character.R, R/run_modflow.modflow.R
\name{run_modflow}
\alias{run_modflow}
\alias{run_modflow.character}
\alias{run_modflow.modflow}
\title{Generic function to run a modflow model}
\usage{
run_modflow(...)

\method{run_modflow}{character}(file, version = 2005, executable = NULL,
  par = NULL)

\method{run_modflow}{modflow}(modflow, version = 2005, executable = NULL,
  par = NULL)
}
\arguments{
\item{file}{path to name file; typically '*.nam'}

\item{version}{MODFLOW version to use; 2005 (default) is currently the only option}

\item{executable}{name of the MODFLOW executable to use; if not provided, the executable distributed with RMODFLOW is used, corresponding to version, machine and sysname}

\item{par}{vector of parameter value file parameter values to run the model with}

\item{modflow}{modflow object}

\item{version}{MODFLOW version to use; 2005 (default) is currently the only option}

\item{executable}{name of the MODFLOW executable to use; if not provided, the executable distributed with RMODFLOW is used, corresponding to version, machine and sysname}

\item{par}{vector of parameter value file parameter values to run the model with}
}
\description{
Generic function to run a modflow model

\code{run_modflow} runs a MODFLOW model.

\code{run_modflow} runs a MODFLOW model.
}

