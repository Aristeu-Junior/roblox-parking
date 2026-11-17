# Prompt 09 — Lycagon, a noite e a Maldição

Leia `CLAUDE.md` e as seções 3 e 8 da enciclopédia.

## Objetivo
Fazer a noite ser **assustadora** e criar o encontro icônico com **Lycagon, o Ataque Noturno**.

## Tarefas
1. **Evento noturno do Lycagon** (`SLFLycagonEvent.server.lua`):
   - Só à noite, com chance pequena por jogador em zonas de floresta/campo e cooldown global.
   - Aviso: a luz some, névoa, uivo e olhos brilhando na escuridão.
   - Lycagon é **praticamente imbatível** nesse encontro: o objetivo é **sobreviver X segundos** (esquivando de investidas, garras e clones de sombra).
2. **Sobreviveu → Maldição de Lycagon** (marca permanente opcional):
   - Bloqueia os slots de **peito e pernas** (o personagem aparece sem camisa e de shorts, com marcas negras brilhantes no corpo).
   - Monstros de nível **menor** fogem do jogador (toggle nas configurações para não atrapalhar o farm).
   - Bônus: resistência mágica nas partes marcadas, +AGI/+crítico, aura escura.
   - Diálogos especiais de NPC (medo, curiosidade).
   - Remoção: missão com a Santa (pode reaplicar depois) ou derrotar o Lycagon no futuro.
3. **Morreu** → tudo normal, mas o jogador ganha o título "Presa da Noite" 💡.
4. **Raid: Sombra de Lycagon** (party de 4–8):
   - Arena escura em que a **visibilidade é uma mecânica** (luzes/tochas que os jogadores precisam acender para revelar os clones).
   - Fases: caça nas sombras → clones → fúria lunar.
   - Recompensa: material de lobo noturno e progresso no cenário do Lycagon.
5. Anúncio no servidor quando alguém é amaldiçoado ou vence a Sombra.

## Critérios de aceite
- Dá para testar com um comando de dev (`/forcenight`, `/spawnlycagon`) só em Studio.
- A maldição muda o visual e os slots, e persiste.
- Atualize o CLAUDE.md.
