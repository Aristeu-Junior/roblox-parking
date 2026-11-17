# Prompt 15 — Monetização, polimento, áudio e instalador

Leia `CLAUDE.md` (e veja `AnimeMonetization.server.lua` do projeto 02 como referência).

## Tarefas
1. **Monetização justa** (`SLFMonetization.server.lua`, IDs = 0 em `SLFConfig_Monetization.lua` para eu preencher):
   - Game Passes: VIP (+XP/+Mani, tag no chat), Inventário Extra, Slot de Cosmético da Emul, Pacote Visual "Máscara de Pássaro Dourada".
   - Developer Products: Mani, Rebirth Tearjewel (limite diário), Reset de Status, Boost de XP 30 min.
   - **Nada de pay-to-win em raids**: bosses e Colossos não podem ser comprados.
   - `ProcessReceipt` idempotente (registro de compras processadas).
2. **HUD final** no estilo "janela holográfica do SF": HP/MP/STM, nível/XP, hotbar, minimapa, rastreador de missão, notificações e anúncio global. Responsivo para PC/mobile/console.
3. **Áudio** (`SLFAudio`): BGM por zona/boss/noite, SFX de combate. Use só áudios liberados da biblioteca do Roblox (IDs configuráveis), **nada da trilha do anime**.
4. **Câmera e feel**: shake, FOV no dash, hit-stop, slow-motion na esquiva perfeita e cutscenes.
5. **Tutorial opcional**, configurações (gráficos, sensibilidade, toggles de VFX, idioma PT/EN 💡) e tela de créditos.
6. **Auditoria**: rodar um checklist de segurança (todos os remotes validados), performance (MicroProfiler: o que otimizar) e DataStore (limites de requisição).
7. **`INSTALADOR_RAPIDO_STUDIO.lua`**: gera toda a árvore `src/` via Command Bar, igual aos projetos 01–03 (pode ser gerado por um script de build Node/Python que lê `src/` e embute os fontes).
8. Atualizar o `README.md` do projeto e o `README.md` raiz do repositório com o projeto 04.

## Critérios de aceite
- Abrir um Baseplate novo → colar o instalador → Play → jogo completo funcionando.
- Lista final de "o que falta para publicar" (thumbnails, ícone, descrição com nome inspirado, configuração de maturidade/questionário do Roblox).
- Atualize o CLAUDE.md marcando tudo como concluído.
