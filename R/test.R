series.length <- 6 * 128 * 24
x1 <- periodic.series(start.period = 1 * 24, length = series.length)
x2 <- periodic.series(start.period = 8 * 24, length = series.length)
x3 <- periodic.series(start.period = 32 * 24, length = series.length)
x4 <- periodic.series(start.period = 128 * 24, length = series.length)

x <- x1 + x2 + x3 + x4

my.date <- seq(as.POSIXct("2014-10-14 00:00:00", format = "%F %T"),
               by = "hour",
               length.out = series.length)

my.data <- data.frame(date = my.date, x = x)

my.wt_log2 <- analyze.wavelet(my.data, "x",
                         loess.span = 0,
                         dt = 1/24, dj = 1/20,
                         lowerPeriod = 1/4,
                         make.pval = TRUE, n.sim = 10,
                         date.format = "%F %T", date.tz = "")

my.wt_linear <- analyze.wavelet(my.data, "x",
                          loess.span = 0,
                          dt = 1/24, dj = 1/20,
                          lowerPeriod = 1/4,
                          make.pval = TRUE, n.sim = 10,
                          date.format = "%F %T", date.tz = "", log2scale = FALSE)

wt.image(my.wt_log2, color.key = "interval", main = "wavelet power spectrum",
         legend.params = list(lab = "wavelet power levels"),
         periodlab = "period (days)")

wt.image(my.wt_linear, color.key = "interval", main = "wavelet power spectrum",
         legend.params = list(lab = "wavelet power levels"),
         periodlab = "period (days)")
