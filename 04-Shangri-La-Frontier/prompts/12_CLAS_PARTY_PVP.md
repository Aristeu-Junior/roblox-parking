# Prompt 12 — Clãs, party, PvP e social

Leia `CLAUDE.md` e a seção 12 da enciclopédia.

## Tarefas
1. **Party** (até 4, raids até 8): convite, líder, XP compartilhado por proximidade, marcadores no minimapa e HP dos aliados na HUD.
2. **Clãs** (`SLFClanService`): criar (custo em Mani), nome/tag filtrados, emblema montado com peças (ex.: lobo + flor), cargos, banco do clã, chat do clã e **alianças** entre clãs.
   - Clãs NPC/"lendários" da obra aparecem no Hall da Fama como referência: Traveling Wolves, Black Wolf, Library, SF-Zoo, Ashura-kai (nomes via SLFNames).
   - Persistência entre servidores com DataStore + `MessagingService`.
3. **PvP**:
   - Zonas seguras (cidades) vs. zonas de PvP opcionais.
   - **Modo PK** com flag de "Procurado" (nome vermelho, recompensa pela cabeça, guardas das cidades atacam). Inspirado no passado PK da Pencilgon e no Ashura-kai.
   - **Duelo 1v1** por convite (estilo Kyōgoku), com placar.
4. **Pássaro-Correio (Mailbird)**: enviar mensagens e itens para jogadores offline (com taxa), com filtro de texto.
5. **Títulos e Hall da Fama**: primeiros abates de boss/Colosso, ranking de nível, ranking de duelo.
6. **Trocas** seguras entre jogadores (janela dupla de confirmação, anti-scam).

## Critérios de aceite
- Testar com 3 jogadores locais: party, clã, duelo, PK + procurado, correio.
- Todo texto de jogador passa pelo `TextService` (regras do Roblox).
- Atualize o CLAUDE.md.
