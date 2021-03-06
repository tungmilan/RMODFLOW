% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/convert_xyz_to_grid.R
\name{convert_xyz_to_grid}
\alias{convert_xyz_to_grid}
\title{Convert real world coordinates to modflow coordinates}
\usage{
convert_xyz_to_grid(x, y, prj = NULL, z = NULL, dis = NULL,
  output = "xyz")
}
\arguments{
\item{x}{real world x coordinate}

\item{y}{real world y coordinate}

\item{prj}{prj object}

\item{z}{real world z coordinate; optional}

\item{dis}{dis object; optional}

\item{output}{character; containing 'xyz','ijk' and/or 'off' for the return of x, y, z, i, j, k, roff, coff and loff modflow coordinates}
}
\value{
data frame with modflow coordinates
}
\description{
Convert real world coordinates to modflow coordinates
}
\details{
If dis is not provided, only x, y and z coordinates are returned. If z is not provided, no third dimension coordinates are returned. For the x, y and z modflow coordinates, the origin is placed at the lower left corner of the grid.
}

