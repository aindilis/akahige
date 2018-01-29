require(ggplot2)
require(ggrepel)

readings <- read.csv("blood_sugar.csv", colClasses = c("factor", "numeric", "numeric"))

# basic plot of all time
## ggplot(readings, aes(x=mins_since_midnight, y=value)) +
##     geom_point(shape=1) + 
##     geom_smooth()

#dev.off()

readings$date <- as.Date(readings$time, tz = "CDT")

#readings <- readings[readings$date >= as.Date("2017-11-20"), ]
#readings <- readings[readings$date <= as.Date("2017-11-10"), ]

readings <- readings[readings$mins_since_midnight > 250, ]

# don't show values above 250
readings$value <- pmin(readings$value, 250)

readings$date2 <- paste(c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")[as.POSIXlt(readings$date)$wday + 1], readings$date);

labeller <- function(df) {
    return (df$date2);
}

dateWithWeekday <- function (d) {
    return (paste(c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")[as.POSIXlt(d)$wday + 1], d));
}

bgOnly <- readings[readings$note == "", ]

# main charting function
chart <- function (data, byDate, trendLine) {
    p <- ggplot(data, aes(x=mins_since_midnight, y=value)) +
        ggtitle(paste("BG ", min(data$date), " - ", max(data$date))) +
        ylab("BG") + xlab("Time") + 
        geom_rect(ymin = -Inf, ymax = 80, alpha = 0.00,
                  xmin = -Inf, xmax = Inf, fill = 'khaki1') +
        geom_rect(ymin = 180, ymax = Inf, alpha = 0.00,
                  xmin = -Inf, xmax = Inf, fill = 'darksalmon') +
        geom_rect(ymin = 80, ymax = 180, alpha = 0.00,
                  xmin = -Inf, xmax = Inf, fill = 'darkolivegreen1') +
        annotate("rect", xmin=-Inf, xmax=Inf,
                 ymin=-Inf, ymax=80, alpha=0.3, fill="khaki1") +
        annotate("rect", xmin=-Inf, xmax=Inf,
                 ymin=180, ymax=200, alpha=0.1, fill="darksalmon") +
        annotate("rect", xmin=-Inf, xmax=Inf,
                 ymin=200, ymax=Inf, alpha=0.3, fill="darksalmon") +
        annotate("rect", xmin=-Inf, xmax=Inf,
                 ymin=80, ymax=180, alpha=0.3, fill="darkolivegreen1") +
        geom_point(shape=1) +
        geom_label_repel(aes(label = note), size = 3) +
        scale_x_continuous(labels=c("480" = "08:00",
                                    "720" = "12:00",
                                    "960" = "16:00",
                                    "1200" = "20:00"),
                           breaks=c(480, 720, 960, 1200)) +
        scale_y_continuous(limits=c(50, 250)) +
        scale_alpha_manual(values=c(0.01,1)) +
        theme(#panel.margin=unit(1, "lines"),
            panel.border = element_rect(color = "black", fill = NA, size = 1), 
            strip.background = element_rect(color = "black", size = 1))
    if (trendLine) {
        p <- p + geom_point(shape=2) + geom_smooth(method=loess, se=FALSE)
    }
    if (byDate) {
        p <- p + facet_grid(date ~ . , labeller = as_labeller(dateWithWeekday)) +
            ## only render the line on BG measurements
            ## (those with label are exercise or meals)
            geom_line(data = data[data$note == "", ])
    }
    p
}

chart(readings[readings$date >= max(readings$date) - 3, ], TRUE, FALSE)
#chart(bgOnly[bgOnly$date >= max(bgOnly$date) - 3, ], FALSE, TRUE)

#ggsave("blood_sugar_last_7_days.png")
#ggsave("blood_sugar.pdf", width = 10, height = 10, scale = 1)
