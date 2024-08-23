series.length <- 3*128*24
x1 <- periodic.series(start.period = 1*24, length = series.length)
x2 <- periodic.series(start.period = 2*24, length = series.length)
x3 <- periodic.series(start.period = 4*24, length = series.length)
x4 <- periodic.series(start.period = 8*24, length = series.length)
x5 <- periodic.series(start.period = 16*24, length = series.length)
x6 <- periodic.series(start.period = 32*24, length = series.length)
x7 <- periodic.series(start.period = 64*24, length = series.length)
x8 <- periodic.series(start.period = 128*24, length = series.length)

x <- x1 + x2 + x3 + x4 + 3*x5 + x6 + x7 + x8 + rnorm(series.length)
y <- x1 + x2 + x3 + x4 - 3*x5 + x6 + 3*x7 + x8 + rnorm(series.length)

my.date <- seq(as.POSIXct("2014-10-14 00:00:00", format = "%F %T"),
               by = "hour",
               length.out = series.length)
my.data <- data.frame(date = my.date, x = x, y = y)

my.wc_log2 <- analyze.coherency(my.data, c("x","y"),
                           loess.span = 0,
                           dt = 1/24, dj = 1/20,
                           window.size.t = 1, window.size.s = 1/2,
                           lowerPeriod = 1/4,
                           make.pval = TRUE, n.sim = 10,
                           date.format = "%F %T", date.tz = "")

my.wc_linear <- analyze.coherency(my.data, c("x","y"),
                                loess.span = 0,
                                dt = 1/24, dj = 1/20,
                                window.size.t = 1, window.size.s = 1/2,
                                lowerPeriod = 1/4,
                                make.pval = TRUE, n.sim = 10,
                                date.format = "%F %T", date.tz = "", log2scale = FALSE)


wc.image(my.wc_log2, main = "cross-wavelet power spectrum, x over y",
         legend.params = list(lab = "cross-wavelet power levels"),
         periodlab = "period (days)")


wc.image(my.wc_linear, main = "cross-wavelet power spectrum, x over y",
         legend.params = list(lab = "cross-wavelet power levels"),
         periodlab = "period (days)", show.date = TRUE)


wc.avg(my.wc_log2, siglvl = 0.05, sigcol = 'red',
       periodlab = "period (days)")

wc.avg(my.wc_linear, siglvl = 0.05, sigcol = 'red',
       periodlab = "period (days)")


wc.phasediff.image(my.wc_log2, which.contour = "wp",
                   main = "image of phase differences, x over y",
                   periodlab = "period (days)")

wc.phasediff.image(my.wc_linear, which.contour = "wp",
                   main = "image of phase differences, x over y",
                   periodlab = "period (days)")
