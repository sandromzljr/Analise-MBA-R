# Instalando os pacotes
# install.packages('dplyr')
# install.packages('arules')
# install.packages('arulesviz')
# install.packages('htmlwidgets')
# install.packages('writexl')

# Carregando os pacotes
library(dplyr)
library(arules)
library(arulesViz)
library(htmlwidgets)
library(writexl)
options(warn = 1)

# Carregando e explorando o dataset
dados <- read.csv('data/dataset_bd3.csv')
dim(dados)
View(dados)
summary(dados)
str(dados)

