# 🐦 Projeto 04 — Shangri-La Frontier (Roblox)

Action RPG / MMO-lite inspirado em **Shangri-La Frontier**, que vai ser construído com o **Claude Code** a partir de prompts sequenciais.

## 📁 O que tem aqui
| Arquivo | Para que serve |
|---|---|
| [`CLAUDE.md`](./CLAUDE.md) | Contexto permanente que o Claude Code lê sozinho: regras, stack (Luau + Rojo), convenções e checklist de progresso |
| [`docs/ENCICLOPEDIA_SHANGRI_LA_FRONTIER.md`](./docs/ENCICLOPEDIA_SHANGRI_LA_FRONTIER.md) | **Listagem completa da obra**: personagens, NPCs, 7 Colossos, Wezaemon, cidades, áreas, monstros, itens, skills, sistemas, outros jogos, clãs, arcos e lore |
| [`prompts/`](./prompts/) | 16 prompts em ordem (00 → 15) |

## 🚀 Como usar com o Claude Code
1. Abra o terminal **nesta pasta** (`04-Shangri-La-Frontier`) e rode `claude`.
2. Cole o conteúdo de `prompts/00_KICKOFF.md` e responda as dúvidas que ele fizer.
3. Para cada etapa, digite: `Leia e execute prompts/01_FUNDACAO.md` (depois 02, 03…).
4. Ao fim de cada etapa, **teste no Studio** (o Claude explica como) antes de ir para a próxima.
5. Se a conversa ficar longa, use `/clear` entre etapas. O `CLAUDE.md` guarda o "Estado atual".

## 🗺️ Ordem dos prompts
| # | Prompt | Conteúdo da obra coberto |
|---|---|---|
| 00 | Kickoff | Leitura e planejamento |
| 01 | Fundação | Rojo, DataStore, remotes, `SLFNames` (anti-DMCA) |
| 02 | Personagem & Status | Criação de avatar, 9 status, classes |
| 03 | Combate | Esquiva, crítico, stamina, durabilidade |
| 04 | Skills | Enchant Vorpal, Lakemirror Moon, Ignition, parkour, evolução |
| 05 | Mundo | Fastea → Fifticia, áreas, dia/noite |
| 06 | Monstros & Bosses | Goblins, Vorpal Bunny, Empire Bee, Escorpiões, bosses de área |
| 07 | Rabituza & Emul | Emul, Vysache, Bilac, diálogos |
| 08 | Itens & Forja | Vorpal Chopper, Togetsu, lâminas Empire Bee, Exceed Charge |
| 09 | Lycagon | Noite, maldição, raid da Sombra |
| 10 | Raid Wezaemon | Setsuna, 3 fases, Kirin, Inventoria, anúncio global |
| 11 | Colossos | Ctarnid completo + Siegwurm, Golduniine, Orchestra, Vysache |
| 12 | Clãs & PvP | Traveling Wolves etc., PK, duelo, Mailbird |
| 13 | Missões | Campanha, Cenários Únicos, Codex da Library |
| 14 | Hub de Kusoges | Faeria, arena samurai, GH:C, Nephilim Hollow |
| 15 | Monetização & Instalador | Passes, HUD, áudio, instalador 1-clique |

> ⚠️ **Direitos autorais:** veja a seção 15 da enciclopédia. O `SLFNames.USE_INSPIRED_NAMES` permite trocar todos os nomes oficiais por nomes alternativos antes de publicar.
