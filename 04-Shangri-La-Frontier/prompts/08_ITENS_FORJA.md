# Prompt 08 — Itens, equipamentos, inventário e forja

Leia `CLAUDE.md` e a seção 7 da enciclopédia.

## Objetivo
Loop de progressão: **farmar material → forjar com a Bilac → ficar mais forte → enfrentar bosses maiores**.

## Tarefas
1. `SLFItemDB.lua`: armas, armaduras (cabeça, peito, braços, cintura, pernas, pés), acessórios, consumíveis, materiais, itens-chave. Raridades: Comum, Incomum, Raro, Épico, Único.
2. **Inventário** (tecla `I`): grid, filtros, comparar status, equipar/desequipar, descartar, stack de materiais, limite de slots expansível.
3. **Visual do equipamento** no personagem (peças próprias soldadas ao rig).
4. Itens canônicos (nomes via SLFNames):
   - **Vorpal Chopper** (adaga, +dano crítico).
   - **Togetsu [Crescente] e [Minguante]**: forjadas pela Bilac a partir de 2 Vorpal Choppers + material. Escalam com **diferença de nível**.
   - **Lâminas Gêmeas da Empire Bee** (material da Rainha): aplicam **veneno corrosivo**.
   - **Manopla Exceed Charge**: acumula carga ao acertar/esquivar e solta um golpe enorme com recuo (material do Escorpião Dourado).
   - **Máscara de Pássaro** (cabeça, cosmético + pequeno bônus de AGI).
   - **Água Benta da Santa**, **Rebirth Tearjewel** (revive 1x), poções HP/MP/STM.
5. **Forja da Bilac** (`SLFForge.server.lua`): receitas, upgrade +1…+10 com chance, reparo de durabilidade e **reforja** (transformar uma arma em outra). Falas da Bilac reagem a materiais estranhos.
6. **Loja** em cada cidade (Mani como moeda), compra/venda.
7. **Inventoria** (bloqueado até o prompt 10): armazém compartilhado entre personagens + área-base.

## Critérios de aceite
- Farmar → forjar Togetsu → equipar → ver dano maior contra alvo de nível mais alto.
- Nenhuma duplicação de item em teste de lag/rejoin rápido (transações atômicas no servidor).
- Atualize o CLAUDE.md.
