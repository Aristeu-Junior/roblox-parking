# CLAUDE.md — Projeto 04: Shangri-La Frontier (Roblox)

> O Claude Code lê este arquivo automaticamente sempre que é aberto nesta pasta. Ele vale para **todos** os prompts em `prompts/`.

## O que é o projeto
Action RPG (estilo MMO-lite) no Roblox, inspirado no anime/mangá **Shangri-La Frontier**. O jogador cria um avatar, distribui status, explora cidades e campos, enfrenta bosses de área, entra no reino secreto dos coelhos (Rabituza), ganha uma companheira (Emul), forja armas com a Bilac e enfrenta Monstros Únicos e os **Sete Colossos** em raids.

**Fonte da verdade do conteúdo:** `docs/ENCICLOPEDIA_SHANGRI_LA_FRONTIER.md`. Antes de inventar nomes, monstros, itens ou locais, **consulte a enciclopédia**. Itens marcados com 💡 são sugestões não-canônicas, e os marcados com ⚠️ devem ficar fáceis de renomear.

## Propriedade intelectual (escopo do projeto)
- É um **fan game** inspirado na obra. Todo o código, os modelos, os VFX e os textos são **originais**, escritos do zero
- **Não** reproduzir texto, diálogos, falas, letras de música, arte nem trilha da obra. Diálogos de NPC são escritos com palavras próprias
- Nomes oficiais ficam isolados em `SLFNames.lua`, e o flag `USE_INSPIRED_NAMES` troca todos de uma vez antes de publicar
- Se algum pedido esbarrar em reproduzir material protegido, faça uma **versão original equivalente** e avise, sem travar a etapa

## Público e tom
- Público infantojuvenil (Roblox). Violência leve, sem sangue (dano com partículas/flash)
- Interface e textos em **português do Brasil**
- Ritmo rápido, humor de "gamer", lutas de boss com padrões legíveis

## Stack e convenções técnicas (as mesmas dos projetos 01–03 deste repositório)
- **Luau** com `--!strict` sempre que possível
- **Rojo**: `default.project.json` mapeando:
  - `src/ReplicatedStorage` → ReplicatedStorage (ModuleScripts compartilhados: configs, engines puras, tipos)
  - `src/ServerScriptService` → ServerScriptService (`*.server.lua` = Script, `*.lua` = ModuleScript)
  - `src/StarterPlayer/StarterPlayerScripts` → StarterPlayerScripts (`*.client.lua` = LocalScript)
- Prefixo **`SLF`** em todos os módulos/scripts (ex.: `SLFConfig`, `SLFCombatServer.server.lua`)
- **Todo nome de personagem/monstro/local/item fica em `SLFNames.lua`**. Nenhum outro arquivo escreve nome oficial "hardcoded". O flag `SLFNames.USE_INSPIRED_NAMES` troca tudo por nomes alternativos (proteção contra DMCA)
- Todos os números de balanceamento ficam em `SLFConfig.lua` (ou submódulos `SLFConfig_*`)
- **Servidor autoritativo**: o cliente só envia *intenção* (ex.: "ataquei", "usei skill 2"). Dano, drops, XP e moedas são calculados no servidor. Valide distância, cooldown e rate-limit em todo RemoteEvent
- Remotes criados pelo servidor numa pasta `ReplicatedStorage.SLFRemotes`
- **DataStore** com chave versionada (`SLF_PlayerData_v1`), `UpdateAsync`, retry com backoff, autosave a cada 120 s e no `BindToClose`, e migração de schema por campo `version`
- Performance: `CastShadow = false` em peças decorativas, pooling de projéteis/VFX, IA de monstros desligada quando não há jogador perto (dormancy por zona), sem `while true do` sem `task.wait`
- Visuais geométricos/procedurais próprios. **Não** use decals, logos nem músicas oficiais
- Todo projeto termina com um `INSTALADOR_RAPIDO_STUDIO.lua` (gera toda a árvore via Command Bar), igual aos projetos 01–03

## Estrutura alvo
```
04-Shangri-La-Frontier/
├─ CLAUDE.md
├─ README.md
├─ default.project.json
├─ INSTALADOR_RAPIDO_STUDIO.lua
├─ docs/ENCICLOPEDIA_SHANGRI_LA_FRONTIER.md
├─ prompts/            (prompts sequenciais 00–15)
└─ src/
   ├─ ReplicatedStorage/        SLFNames, SLFConfig*, SLFTypes, SLFStatEngine, SLFItemDB, SLFSkillDB, SLFMonsterDB ...
   ├─ ServerScriptService/      SLFDataManager, SLFCombatServer, SLFMonsterAI, SLFWorldBuilder, SLFQuestServer ...
   └─ StarterPlayer/StarterPlayerScripts/  SLFClientUI, SLFCombatClient, SLFCameraFX, SLFAudio ...
```

## Regras de trabalho
1. Ao terminar cada prompt, **atualize a seção "Estado atual"** abaixo (o que foi feito, arquivos novos, pendências)
2. Não quebre sistemas de prompts anteriores. Se precisar mudar uma API, ajuste todos os chamadores
3. Explique no final de cada etapa **como testar no Studio** (passo a passo, F5 / Start Server com 2 jogadores)
4. Prefira tabelas de dados (DB modules) a lógica espalhada. Adicionar um monstro/item novo deve exigir só uma entrada de tabela

## Estado atual
- [ ] 01 Fundação
- [ ] 02 Personagem & Status
- [ ] 03 Combate
- [ ] 04 Skills
- [ ] 05 Mundo & Cidades
- [ ] 06 Monstros & Bosses de Área
- [ ] 07 Rabituza, Emul & NPCs
- [ ] 08 Itens, Equipamentos & Forja
- [ ] 09 Maldição de Lycagon & Noite
- [ ] 10 Raid Wezaemon (Cenário Único EX)
- [ ] 11 Colossos restantes
- [ ] 12 Clãs, Party, PvP & Social
- [ ] 13 Missões, Cenários Únicos & Anúncio Global
- [ ] 14 Hub de Kusoges (minigames)
- [ ] 15 Monetização, Polimento & Instalador
