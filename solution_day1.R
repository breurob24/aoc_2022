# https://adventofcode.com/2022/day/1

## Setup ----

library(data.table)

input.raw <- as.numeric(readLines("input_day1.txt"))

input.dt <- data.table(calories = input.raw)

input.dt[, "elve_id" := fifelse(.I == 1, 
                             1,
                             fifelse(is.na(calories),
                                     .I,
                                     0))]

input.dt$elve_id[which(input.dt$elve_id == 0)] <- NA

input.dt[, "elve_id" := nafill(elve_id, type = "locf")]

## Part 1 ----

results.dt <- input.dt[, .(total_calories = sum(calories, na.rm = TRUE)), by = elve_id][order(-total_calories)]

##  Part 2 ----
sum(results.dt[, total_calories[1:3]])
