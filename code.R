library(tidyverse)
library(treemap)
library(d3treeR)

readxl::read_xlsx("smeta_01.11.2024.xlsx") |> 
  group_by(level_1) |> 
  mutate(level_1_sum = sum(amount, na.rm = TRUE)) |> 
  ungroup() |> 
  mutate(level_1 = str_c(level_1, " (", level_1_sum, " р.)")) |>
  group_by(level_1, level_2) |> 
  mutate(level_2_sum = sum(amount, na.rm = TRUE)) |> 
  ungroup() |> 
  mutate(level_2 = str_c(level_2, " (", level_2_sum, " р.)")) |>
  group_by(level_1, level_2, level_3) |> 
  mutate(level_3_sum = sum(amount, na.rm = TRUE)) |> 
  ungroup() |> 
  mutate(level_3 = str_c(level_3, " (", level_3_sum, " р.)")) |>
  group_by(level_1, level_2, level_3, level_4) |> 
  mutate(level_4_sum = sum(amount, na.rm = TRUE)) |> 
  ungroup() |> 
  mutate(level_4 = str_c(level_4, " (", level_4_sum, " р.)")) |>
  treemap(dtf = _, 
        index=c("level_1", "level_2", "level_3", "level_4"), 
        vSize="amount", 
        type="index") |> 
  d3tree2(data = _, rootname = "Смета расходов с 01.11.2024")

