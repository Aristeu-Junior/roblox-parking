# Prompt 03 — Sistema de combate

Leia `CLAUDE.md` e as seções 7, 9 e 10 da enciclopédia.

## Objetivo
Combate de ação rápido e responsivo, focado em **esquiva, crítico e timing**, que é a identidade do Sunraku.

## Tarefas
1. **Tipos de arma** (`SLFConfig_Weapons.lua`): adagas duplas, espada, espadão, lança, katana, punhos/manopla, cajado, kunai. Cada um com combo (3–5 hits), alcance, velocidade, custo de stamina e hitbox.
2. **Cliente (`SLFCombatClient.client.lua`)**: input (M1 atacar, `Q` esquiva/dash, `Shift` correr, `Space` pulo), animações procedurais/placeholder, predição visual leve, hit-stop, screen shake e números de dano flutuantes (crítico em destaque).
3. **Servidor (`SLFCombatServer.server.lua`)**: validação de alcance/ângulo/cooldown, hitbox por `GetPartBoundsInBox`/`Spatial query`, cálculo de dano pelo StatEngine e anti-exploit.
4. **Esquiva com i-frames** (janela configurável) e bônus de **"esquiva perfeita"** (contra-ataque crítico garantido por 1 s).
5. **Crítico pesado**: crítico ignora parte da defesa. Builds de LUC realmente brilham.
6. **Stamina**: correr, esquivar e atacar gastam STM. Sem STM, o jogador fica cansado (lento).
7. **Durabilidade de arma**: perde ao bater e quebra com 0 (dá para reparar na forja depois).
8. **Status negativos** genéricos: veneno, veneno corrosivo (reduz defesa), sangramento visual sem sangue, lentidão, atordoamento, medo.
9. **Morte e respawn**: tela "Você morreu", respawn no último ponto salvo da cidade e penalidade leve configurável.
10. Lock-on opcional (tecla `T` ou botão mobile) e **suporte mobile/console** (botões na tela).

## Critérios de aceite
- Lutar contra um boneco de treino (dummy) em cada tipo de arma, com dano, crítico e números corretos.
- Spam de remote não aumenta DPS (rate-limit funciona).
- Funciona com 2 jogadores (Start Server → 2 Players).
- Atualize o CLAUDE.md.
