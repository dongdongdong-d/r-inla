% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/spmesh.R
\name{plot.inla.CRS}
\alias{plot.inla.CRS}
\alias{plot.CRS}
\title{Plot CRS and inla.CRS objects}
\usage{
\method{plot}{inla.CRS}(
  x,
  xlim = NULL,
  ylim = NULL,
  outline = TRUE,
  graticule = c(15, 15, 45),
  tissot = c(30, 30, 30),
  asp = 1,
  add = FALSE,
  eps = 0.05,
  ...
)

\method{plot}{CRS}(
  x,
  xlim = NULL,
  ylim = NULL,
  outline = TRUE,
  graticule = c(15, 15, 45),
  tissot = c(30, 30, 30),
  asp = 1,
  add = FALSE,
  eps = 0.05,
  ...
)
}
\arguments{
\item{x}{A \code{CRS} or \code{\link[=inla.CRS]{inla.CRS()}} object.}

\item{xlim}{Optional x-axis limits.}

\item{ylim}{Optional y-axis limits.}

\item{outline}{Logical, if \code{TRUE}, draw the outline of the projection.}

\item{graticule}{Vector of length at most 3, to plot meridians with spacing
\code{graticule[1]} degrees and parallels with spacing \code{graticule[2]}
degrees. \code{graticule[3]} optionally specifies the spacing above and
below the first and last parallel.  When \code{graticule[1]==0} no meridians
are drawn, and when \code{graticule[2]==0} no parallels are drawn. Use
\code{graticule=NULL} to skip drawing a graticule.}

\item{tissot}{Vector of length at most 3, to plot Tissot's indicatrices with
spacing \code{tissot[1]} degrees and parallels with spacing \code{tissot[2]}
degrees. \code{tissot[3]} specifices a scaling factor.  Use
\code{tissot=NULL} to skip drawing a Tissot's indicatrices.}

\item{asp}{The aspect ratio for the plot, default 1.}

\item{add}{If \code{TRUE}, add the projecton plot to an existing plot.}

\item{eps}{Clipping tolerance for rudimentary boundary clipping}

\item{\dots}{Additional arguments passed on to the internal calls to
\code{plot} and \code{lines}.}
}
\description{
Plot the outline of a CRS or inla.CRS projection, with optional graticules
(transformed parallels and meridians) and Tissot indicatrices.
}
\examples{

if (require("sf") && require("sp")) {
    oblique <- c(0, 45, 45, 0)
    for (projtype in c("longlat", "lambert", "mollweide", "hammer")) {
        plot(inla.CRS(projtype), main = projtype)
        plot(inla.CRS(projtype, oblique = oblique), main = paste("oblique", projtype))
    }
}
}
\seealso{
\code{\link[=inla.CRS]{inla.CRS()}}
}
\author{
Finn Lindgren \href{mailto:finn.lindgren@gmail.com}{finn.lindgren@gmail.com}
}
