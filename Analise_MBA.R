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

# Removendo às linhas em branco

linhas_pares <- seq(2, nrow(dados), 2)
linhas_impares <- seq(1, nrow(dados), 2)

# Separando os dados
df1 <- dados[linhas_pares, ]
View(df1)
df2 <- dados[linhas_impares, ]
View(df2)

# Verificando valores ausentes na primeira coluna
sum(is.na(df1$Item01))

# Verificando valores ausentes na segunda coluna(ATENÇÃO)

# is.na verifica a total ausência de dados,
# porém no dataset podemos ter um caractere, como o " "(espaço).
sum(is.na(df1$Item02))
View(df1)

# Verificando valores ausentes representados por espaço em branco " "
which(nchar(trimws(df1$Item01))==0)
which(nchar(trimws(df1$Item02))==0)

# Verificando valores ausentes representados por espaço em branco " " (utilizando regex)
grepl("^\\s*$", df1$Item02)

# Número de itens distintos
n_distinct(df1)

# Trabalhando com registros onde o item02 não é nulo
df1_two <- df1[!grepl("^\\s*$", df1$Item02), ]

# Número de itens distintos
n_distinct(df1_two)

