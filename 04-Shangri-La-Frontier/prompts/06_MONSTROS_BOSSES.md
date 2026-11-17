# Prompt 06 — Monstros, IA e bosses de área

Leia `CLAUDE.md` e a seção 6 da enciclopédia.

## Objetivo
Bestiário data-driven com IA eficiente e bosses com padrões legíveis.

## Tarefas
1. `SLFMonsterDB.lua`: `id, nameId, nível, HP, dano, defesa, velocidade, comportamento (passivo/agressivo/bando/noturno/emboscada), ataques[], dropTable, xp, mani, modelBuilderId`.
2. Monstros canônicos (modelos procedurais próprios, low-poly):
   - **Goblin**, **Goblin Berserker**, **Redcap Goblin** (só à noite).
   - **Vorpal Bunny selvagem**: fofo, mas **crítico letal**, foge e contra-ataca. Drop raro de **Vorpal Chopper**.
   - **Empire Bee** Operária (passiva), Caçadora (agressiva) e **Rainha** (mini-boss).
   - **Escorpião de Cristal** (camuflagem: semi-transparente até atacar, anda em grupo).
   - **Escorpião de Cristal Dourado** (raro, mini-boss, spawn com chance baixa e anúncio no servidor).
   - 💡 Fillers por bioma: slime do pântano, lobo noturno, golem de ruína, morcego da gruta, mímico de baú.
3. `SLFMonsterAI.server.lua`: máquina de estados (Idle → Patrol → Chase → Attack → Return), **telegraph** visual antes de golpes fortes (área vermelha no chão), aggro por dano, **dormancy** por zona sem jogadores, spawners com limite e respawn.
4. **Bosses de área** (`SLFBossDB`), cada um com 2 fases e padrões:
   - **Serpente Voraz**: bote, enrolar (agarrão; escapa com esquiva), cauda em arco.
   - **Mud Digger**: cava e reaparece embaixo do jogador, jatos de lama.
   - **Clown Spider**: teias que prendem, saltos, invoca filhotes.
   - **Humming Lich**: projéteis mágicos, invoca esqueletos, zumbido que causa lentidão.
   - Barra de HP de boss no topo, música própria e porta que fecha na arena.
5. **Loot**: drops individuais por jogador (sem roubo de loot), raridade com cor, coleta por proximidade.
6. **Bestiário** (tecla `B`), no estilo SF-Zoo: monstros vistos e derrotados, contagem de abates, drops descobertos e recompensa por completar.

## Critérios de aceite
- Cada zona do prompt 05 tem spawn funcionando e o boss abre o portão ao morrer.
- 30+ monstros ativos sem queda séria de FPS no servidor.
- Atualize o CLAUDE.md.
