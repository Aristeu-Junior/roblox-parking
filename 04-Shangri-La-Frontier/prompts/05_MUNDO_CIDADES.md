# Prompt 05 — Mundo, cidades, campos e ciclo dia/noite

Leia `CLAUDE.md` e as seções 5 e 13 da enciclopédia.

## Objetivo
Construir proceduralmente (via script, como em `AnimeMapBuilder` do projeto 02) o **Velho Continente** em escala Roblox.

## Tarefas
1. `SLFConfig_World.lua`: lista de zonas com `id, tipo (cidade/campo/dungeon/secreta), nívelRecomendado, bioma, conexões, bossDeArea, spawnTable, música`.
2. `SLFWorldBuilder.lua`: gera o mapa com Parts/Terrain, em blocos separados por zona (para fazer streaming e dormancy):
   - **Fastea** (cidade inicial): praça, NPC de tutorial, loja, ferreiro, ponto de save (cristal), quadro de missões.
   - **Floresta Desenfreada** → arena da **Serpente Voraz**.
   - **Secandil** → **Pântano Lamacento** (boss Mud Digger).
   - **Sadremma** (cidade grande de pedra entre penhascos, hub principal).
   - **Gruta da Floresta Prismática** (cristais coloridos, colmeia das Empire Bees, boss Clown Spider).
   - **Cânion das Almas Antigas** + **Penhasco do Ninho de Cristal** (Escorpiões de Cristal).
   - **Ruína de Ferro da Divindade** (estética da Era Divina: metal, neon azul).
   - **Fifticia** (cidade portuária) + **Destroços do Glory Ellis**.
   - **Rabituza** (instância/área isolada, só por teleporte; feita no prompt 07).
   - Local escondido do **Túmulo da Setsuna** (feito no prompt 10).
   - Placeholder bloqueado: "Novo Continente — Em breve".
3. **Bosses de área como portões**: a passagem para a próxima cidade só abre depois de derrotar o boss (por jogador, com flag salva).
4. **Pontos de save/respawn** (cristais) e **viagem rápida** entre cristais já visitados.
5. **Ciclo dia/noite** (`Lighting.ClockTime`) sincronizado pelo servidor, com evento `NightStarted/DayStarted` para os outros sistemas (monstros noturnos, Lycagon). Fase da lua opcional.
6. Minimapa simples + nome da zona aparecendo ao entrar ("Floresta Desenfreada — Nv 1–10").
7. `StreamingEnabled` ligado, `CastShadow=false` em decoração e LOD simples.

## Critérios de aceite
- Andar de Fastea até Fifticia passando pelos portões (bosses podem ser dummies por enquanto).
- Ciclo dia/noite visível e eventos disparando.
- FPS estável num PC fraco/mobile (relatar contagem de parts por zona).
- Atualize o CLAUDE.md.
