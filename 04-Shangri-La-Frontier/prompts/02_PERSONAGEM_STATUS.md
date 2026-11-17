# Prompt 02 — Criação de personagem, status e classes

Leia `CLAUDE.md` e as seções 1, 9 e 10 da enciclopédia.

## Objetivo
Recriar a sensação de "criar avatar num VRMMO": tela de criação, distribuição de status e classes.

## Tarefas
1. **Tela de criação de avatar** (só no primeiro login), em estilo "lobby VR" futurista:
   - Nome do avatar (filtrado com `TextService:FilterStringAsync`).
   - Presets de visual inspirados na obra, montados com Parts/acessórios próprios: **Máscara de Pássaro** (Sunraku), **Cavaleira de Lança** (Pencilgon), **Armadura Pesada** (Psyger-0), **Ninja** (Akane), **Lutador** (Oikatzo), **Pesquisador** (Kyōju). Cores customizáveis.
   - Botão "Pular tutorial" (referência ao Sunraku), que dá um título cômico.
2. **Classes iniciais** em `SLFConfig_Classes.lua`: Mercenário (duas lâminas, AGI), Cavaleiro (espada+escudo, VIT), Lanceiro (lança, STR/DEX), Mago (MP), Ninja (AGI/TEC), Lutador (punhos, TEC). Cada uma com status base, arma inicial e skill inicial.
3. **`SLFStatEngine.lua`** (módulo puro, testável):
   - Os 9 status: HP, MP, STM, STR, DEX, AGI, TEC, VIT, LUC.
   - Derivados: dano físico, velocidade de movimento (AGI), regen/uso de stamina, **chance e multiplicador de crítico (LUC/DEX)**, defesa (VIT), poder mágico.
   - Curva de XP, pontos livres por nível, soft-cap.
   - Função de **multiplicador por diferença de nível** (usada no Enchant Vorpal e nas lâminas Togetsu).
4. **Janela de Status** (tecla `C`) com o visual de janela holográfica do SF: barras, botões +/−, confirmar, resetar (com custo).
5. Aplicar os status ao `Humanoid` (WalkSpeed, JumpPower com limites) no servidor.

## Critérios de aceite
- Criar personagem → escolher classe → distribuir pontos → status persistem após rejoin.
- Build "AGI+LUC máximo, VIT mínima" (estilo Sunraku) é viável, mas morre rápido se for atingido.
- Testes simples do StatEngine num script de dev (`SLFDevTests.server.lua`, desligável por flag).
- Atualize o CLAUDE.md.
