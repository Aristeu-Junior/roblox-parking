# Prompt 11 — Os demais Colossos (Ctarnid, Siegwurm, Golduniine, Orchestra, Vysache, Lycagon real)

Leia `CLAUDE.md` e a seção 3 da enciclopédia. **Use o mesmo framework de raid do prompt 10** (generalize se precisar: `SLFRaidFramework`).

## Objetivo
Conteúdo de endgame em atualizações. Implemente agora **um framework genérico + Ctarnid completo**, e os outros como "esqueleto" configurável.

## Tarefas
1. **Refatorar** a raid do Wezaemon para `SLFRaidFramework` (fases, telegraph, timers, escala por jogador, recompensas, anúncio global). Wezaemon vira só uma config.
2. **Ctarnid do Abismo** (arco de Fifticia), raid de 4–8 jogadores:
   - Pré-quest em **Fifticia**: "Encontre os Discípulos do Abismo", NPCs no porto e nos destroços do Glory Ellis.
   - Descida para a cidade submersa (natação/ar limitado 💡).
   - **Mecânica do mundo invertido**: em certas fases a gravidade inverte (arena de cabeça para baixo) e/ou os buffs viram debuffs e vice-versa. Mostrar com filtro de cor invertida (`ColorCorrectionEffect`).
   - Fases em arenas diferentes, tentáculos com telegraph e adds marinhos (peixes-baleia).
3. **Esqueletos (configs + arena placeholder + 1 fase)** para:
   - **Siegwurm** (dragão dourado, céu, sopro em linha, Novo Continente).
   - **Golduniine** (mulher-serpente que se divide em vários corpos, enxames de cobras).
   - **Orchestra** (boss-rush musical: cada fase muda a música e o padrão rítmico de ataques).
   - **Vysache** (duelo de velocidade, desafio final de Rabituza).
   - **Lycagon real** (versão completa depois da Sombra do prompt 09).
4. Placeholder do **Novo Continente** liberado depois do Ctarnid (zona inicial com monstros Nv 100+ e sinalização "em construção").
5. Tela **"Sete Colossos"** (tipo Codex da Library): silhueta escura até ser descoberto, status global (derrotado/por quem/quando).

## Critérios de aceite
- Ctarnid jogável de ponta a ponta. Os outros aparecem no Codex e têm arena de teste.
- Adicionar um Colosso novo = criar um arquivo de config no framework.
- Atualize o CLAUDE.md.
