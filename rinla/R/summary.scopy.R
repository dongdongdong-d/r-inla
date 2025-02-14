## Export: inla.summary.scopy

## ! \name{summary.scopy}
## ! \alias{inla.summary.scopy}
## ! \alias{summary.scopy}
## !
## ! \title{Computes the mean and stdev for the spline from \code{scopy}}
## !
## ! \description{This function computes the mean and stdev for the
## !              spline function that is implicite from an \code{scopy}
## !              model component}
## ! \usage{
## !     inla.summary.scopy(result, name, by = 0.05, range = c(0, 1))
## ! }
## ! \arguments{
## !   \item{result}{An \code{inla}-object,  ie the output from an \code{inla()} call}
## !   \item{name}{The name of the \code{scopy} model component
## !                 see \code{?inla::f} and argument \code{extraconstr}}
## !   \item{by}{The resolution of the results, in the scale where distance between two nearby
## !             locations is 1}
## !   \item{range}{The range of the locations, in \code{(from, to)}}
## ! }
## ! \value{
## !   A \code{data.frame} with locations, mean and stdev.
## !   if \code{name} is not found, NULL is returned.
## ! }
## ! \author{havard rue \email{hrue@r-inla.org}}
## ! \examples{
## ! ## see example in inla.doc("scopy")
## ! }

`inla.summary.scopy` <- function(result, name, by = 0.05, range = c(0, 1))
{
    stopifnot(!missing(result) && inherits(result, "inla"))
    if (is.null(result$misc$configs)) {
        stop("you need an inla-object computed with option 'control.compute=list(config = true)'.")
    }
    stopifnot(range[1] < range[2])

    cs <- result$misc$configs
    ld <- numeric(cs$nconfig)
    for (i in 1:cs$nconfig) {
        ld[i] <- cs$config[[i]]$log.posterior
    }
    p <- exp(ld - max(ld))
    p <- p / sum(p)

    k <- 1:length(inla.models()$latent$scopy$hyper)
    nms <- paste0("Beta", k, " for ", name, " (scopy)")

    idx <- c()
    theta <- names(cs$config[[1]]$theta)
    for(nm in nms) {
        j <- which(nm == theta)
        stopifnot(length(j) <= 1)
        if (length(j) == 1) {
            idx <- c(idx, j)
        }
    }
    if (length(idx) == 0) {
        return (NULL)
    }

    n <- length(idx)
    eps <- 1e-6
    stopifnot(diff(range) >= eps * n)
    by <- max(eps, min(1.0, by)) * diff(range) / (n - 1)
    xx <- seq(range[1], range[2], by = by)
    xx.loc <- range[1] + diff(range) * (0:(n-1)) / (n-1)
    ex <- numeric(length(xx))
    exx <- numeric(length(xx))
    for(i in 1:cs$nconfig) {
        fun <- splinefun(xx.loc, cs$config[[i]]$theta[idx], method = "natural")
        vals <- fun(xx)
        ex <- ex + p[i] * vals
        exx <- exx + p[i] * vals^2
    }
    m <- ex
    s <- sqrt(pmax(0, exx  - ex^2))

    return(data.frame(x = xx, mean = m, sd = s))
}
