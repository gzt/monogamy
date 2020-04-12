#' Image Metrics
#'
#' A dataset containing results of a survey asking for
#' opinions about the quality of a set of distorted
#' binary images. The data is in "long" format. There
#' were 12 undistorted images ('base_img' and 'base_name')
#' and 15 versions of each distorted image ('img_no', and
#' 'distorted'). The 'mean' is the mean opinion score for each
#' image: the average rating each respondent gave the distorted
#' image compared to the base image. The standard deviation ('std')
#' is also reported. Several different quantitative binary image
#' quality metrics are also included, with their name in the 'metric'
#' column and th value of the comparison in the 'score' column.
#' @usage data(imagemetrics)
#'
#' @keywords datasets
#' @examples
#' head(imagemetrics)
#' aggregate(score ~ metric, imagemetrics, FUN = mean)
#' with(imagemetrics[imagemetrics$metric == "accuracy", ],
#'     plot(mean, score, xlab = "Accuracy", ylab = "Mean Opinion Score"))
"imagemetrics"
