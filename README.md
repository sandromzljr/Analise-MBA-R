<h1>Análise de Cesta de Compras (Market Basket Analysis)</h1>
<p>
<p>A Análise de Cesta de Compras (Market Basket Analysis) é uma das principais técnicas usadas  por  grandes  varejistas  para descobrir associações entre itens.  A  técnica  funciona procurando combinações de itens que ocorrem juntos com frequência nas transações. Em outras palavras,  permite  que  os  varejistas  identifiquem  as  relações  entre  os  itens que  as  pessoas compram.</p>
<p>São usadas 3 métricas principais para analisar o resultado do algoritmo Apriori, o mais usado em MBA:</p>
<ul>
  <li><b>Support</b> = Fração de transações que contêm X e Y. O support nos diz o quão popular é um item (ou conjunto de itens), conforme medido pela proporção de transações nas quais o item (ou conjunto de itens) aparece.</li>
  <br>
  <li><b>Confidence</b> = A confidence nos diz a probabilidade de compra do item Y quando o item X é comprado, expresso como {X -> Y}.</li>
  <br>
  <li><b>Lift</b> = Esta métrica indica quanto aumentou nossa confiança de que Y será comprado, dado que X foi comprado.</li>
</ul>
<p><i>O parâmetro <b>minlen</b> do algoritmo Apriori em R indica o comprimento mínimo da regra (por exemplo 3 itens se o parâmetro for igual a 3).</i></p>

