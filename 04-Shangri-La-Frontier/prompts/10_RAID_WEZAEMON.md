# Prompt 10 — Raid: Wezaemon, o Guardião do Túmulo (Cenário Único EX)

Leia `CLAUDE.md` e a seção 4 da enciclopédia (é o arco central da 1ª temporada).

## Objetivo
A luta mais épica do jogo: **3 jogadores** (party fixa, igual ao trio Sunraku/Pencilgon/Oikatzo) contra o Wezaemon.

## Tarefas
1. **Cadeia de missões de preparação**:
   - Rumor do túmulo escondido → achar o **Túmulo da Setsuna** (local secreto, só à noite).
   - Diálogo com o espírito da **Setsuna dos Dias Distantes** (melancólico).
   - Missão de comprar/obter **Água Benta da Santa** e **Rebirth Tearjewels**.
2. **Instância da raid** (`SLFRaidWezaemon.server.lua`): servidor reservado ou arena isolada, party de 1–3 (escala HP por número de jogadores) e campo de flores sob a lua.
3. **Fases** (com telegraph claro):
   - **Fase 1**: katana. Cortes rápidos que **ignoram defesa**, iaijutsu de longo alcance e contra-ataques se o jogador spammar.
   - **Fase 2**: invoca a montaria mecânica **Kirin** (nome via SLFNames). Duas barras de HP: um jogador segura o Kirin enquanto os outros atacam o Wezaemon. O Kirin dá cobertura e escudo.
   - **Fase 3**: aviso na tela e contagem para o golpe de limpar a arena (**"Céu Limpo"**). Sobrevive quem usou a Água Benta / Tearjewel ou fez a esquiva perfeita no frame certo.
   - Timer total opcional (falhou → expulso com recompensa de consolação).
4. **Vitória**:
   - Cutscene: Wezaemon caminha até o túmulo e descansa, e a Setsuna agradece.
   - **Anúncio global** em todos os servidores (`MessagingService`) com o nome da party.
   - Recompensas por função: **Livro de Skill do Wezaemon** (quem deu o golpe final/DPS), **Reator de Éter** (quem derrubou o Kirin), **Broche da Setsuna** (suporte), e todos ganham acesso ao **Inventoria**.
   - Título "Guardião do Túmulo derrotado" + emblema (lobo + flor) disponível para o clã.
5. **Primeiro abate do servidor** fica num **Hall da Fama** (DataStore ordenado / OrderedDataStore) na praça de Sadremma.
6. Modo de **replay da raid** com dificuldade maior depois da primeira vitória.

## Critérios de aceite
- Raid jogável do começo ao fim com 1 e com 3 jogadores (Studio: Start Server 3 players).
- Mecânicas legíveis: ninguém morre sem aviso visual.
- Atualize o CLAUDE.md.
