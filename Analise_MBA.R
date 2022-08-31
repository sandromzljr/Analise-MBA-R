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

# Prepara o pacote convertendo as variáveis para o tipo fator
# variável que será usada

# Diminuindo a esparsidade para um melhor processamento
View(df1_two)
pacote <- df1_two
pacote$Item01 <- as.factor(pacote$Item01)
pacote$Item02 <- as.factor(pacote$Item02)
pacote$Item03 <- as.factor(pacote$Item03)
pacote$Item04 <- as.factor(pacote$Item04)
pacote$Item05 <- as.factor(pacote$Item05)
pacote$Item06 <- as.factor(pacote$Item06)
summary(pacote)
View(pacote)
str(pacote)

?split

pacote_split <- split(pacote$Item01, 
                      pacote$Item02,
                      pacote$Item03, 
                      pacote$Item04,
                      pacote$Item05, 
                      pacote$Item06)

View(pacote_split)

# Pode ser que seja necessário ler o README para entender às linhas abaixo.

# Transações
?as
transacoes <- as(pacote_split, "transactions")

# Inspeção das regras
?inspect
inspect(head(transacoes, 5))

# lhs é o antecedente do produto
# rhs é o consequente do produto

# Verificando regras de um produto: Dust-Off Compressed Gas 2 pack
?apriori
regras_produto1 <- apriori(transacoes,
                           parameter = list(conf = 0.5, minlen = 3),
                           appearance = list(rhs = "Dust-Off Compressed Gas 2 pack", default = "lhs"))

# Inspecionando às regras
inspect(head(sort(regras_produto1, by = "confidence"), 5))

# Alterando métricas para uma melhor filtragem

regras_produto1 <- apriori(transacoes,
                           parameter = list(minlen = 3, supp = 0.2, conf = 0.5, target = "rules"),
                           appearance = list(rhs = "Dust-Off Compressed Gas 2 pack", default = "lhs"))

# Inspecionando às regras
inspect(head(sort(regras_produto1, by = "confidence"), 5))

# Filtrando às regras redundantes
regras_produto1_clean <- regras_produto1[!is.redundant(regras_produto1)]

# Inspecionando às regras
inspect(head(sort(regras_produto1, by = "confidence"), 5))

# Sumário
summary(regras_produto1_clean)

# Plot
plot(regras_produto1_clean, measure = "support", shading = "confidence", method = "graph", engine = "html")

# Salvando o conjunto de regras em planilha excel
df_produto1 <- as(regras_produto1_clean, 'data.frame')
View(df_produto1)
write_xlsx(df_produto1, 'data/df_produto1.xlsx')