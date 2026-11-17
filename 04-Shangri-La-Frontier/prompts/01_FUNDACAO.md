# Prompt 01 — Fundação do projeto

Leia `CLAUDE.md` e a enciclopédia antes de começar.

## Objetivo
Criar o esqueleto técnico sobre o qual todos os outros sistemas vão rodar.

## Tarefas
1. `default.project.json` (Rojo) seguindo o mapeamento do CLAUDE.md, com `name: "ShangriLaFrontierRoblox"`.
2. `src/ReplicatedStorage/SLFNames.lua`
   - Tabela com **todos** os nomes da enciclopédia (personagens, NPCs, 7 Colossos, cidades, áreas, bosses de área, monstros, itens, skills, clãs).
   - Cada entrada tem `{ official = "...", inspired = "..." }` (ex.: Sunraku → "Pássaro Veloz", Lycagon → "Lobo da Noite Eterna").
   - Flag `USE_INSPIRED_NAMES = false` e uma função `SLFNames.get(id)`.
3. `src/ReplicatedStorage/SLFConfig.lua`: constantes globais (versão, autosave, nível máximo inicial 99, multiplicadores de XP, duração do dia/noite, limites de rate-limit).
4. `src/ReplicatedStorage/SLFTypes.lua`: tipos Luau (`PlayerData`, `ItemInstance`, `StatBlock`, `SkillState`, `QuestState`, `MonsterDef`).
5. `src/ServerScriptService/SLFRemotes.lua`: cria `ReplicatedStorage.SLFRemotes` com RemoteEvents/Functions nomeados por uma lista central, e um helper de **rate-limit por jogador/remote**.
6. `src/ServerScriptService/SLFDataManager.server.lua`
   - Schema `PlayerData` v1: nível, XP, pontos livres, status (HP, MP, STM, STR, DEX, AGI, TEC, VIT, LUC), classe, moedas (Mani), inventário, equipamento, skills, quests, flags de cenário, títulos/marcas, clã, configurações.
   - `UpdateAsync` com retry/backoff, session lock simples, autosave, `BindToClose`, migração por `version`.
   - Expõe API de módulo para os outros scripts: `get(player)`, `update(player, fn)`, sinal `DataLoaded`.
7. `src/StarterPlayer/StarterPlayerScripts/SLFClientBoot.client.lua`: espera os dados carregarem e mostra a tela "Conectando ao Shangri-La Frontier…" (estilo log-in de VR, com fade).
8. Um `src/ServerScriptService/SLFBootstrap.server.lua` que inicializa os módulos na ordem certa e loga no Output.

## Critérios de aceite
- Abrir no Studio + Play: sem erros no Output, jogador recebe dados padrão, sai e volta mantendo os dados (testar com API Services ativado).
- Trocar `USE_INSPIRED_NAMES` muda os nomes exibidos sem quebrar nada.
- Atualize "Estado atual" no CLAUDE.md e me explique como testar.
