# https://adventofcode.com/2022/day/2

## Setup ----

library(data.table)

input.raw <- fread("input_day2.txt", header = FALSE)

setnames(input.raw, c("V1", "V2"), c("opp", "me"))

input.dt <- input.raw

## Part 1 ----

input.dt[, c("opp", "me") := list(match(opp, LETTERS),
                                               match(me, LETTERS) - 23)]

input.dt[, c("result.key", "idx") := list(paste0(opp, "_", me),
                                          .I)]

lookup.dt <- data.table(result.key = c("1_1", "1_2", "1_3", "2_1", "2_2", "2_3", "3_1", "3_2", "3_3"),
                        score = c(3, 6, 0, 0, 3, 6, 6, 0, 3))

results.dt <- input.dt[lookup.dt, on = c("result.key")][order(idx)]

sum(results.dt[, lapply(.SD, sum), .SDcols = c("me", "score")])

## Part 2 ----

input.dt[, "me_strategy" := fcase(me == 1, 0,
                                  me == 2, 3,
                                  me == 3, 6)]

input.dt[, c("strategy.key") := paste0(opp, "_", me_strategy)]

lookup_strategy.dt <- data.table(strategy.key = c("1_0", "1_3", "1_6", "2_0", "2_3", "2_6", "3_0", "3_3", "3_6"),
                                 game = c(3, 1, 2, 1, 2, 3, 2, 3, 1))

results.dt2 <- input.dt[lookup_strategy.dt, on = c("strategy.key")][order(idx)]

sum(results.dt2[, lapply(.SD, sum), .SDcols = c("me_strategy", "game")])
