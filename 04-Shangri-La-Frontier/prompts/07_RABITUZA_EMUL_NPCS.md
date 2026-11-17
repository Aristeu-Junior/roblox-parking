# Prompt 07 — Rabituza, Emul e NPCs

Leia `CLAUDE.md` e as seções 2, 5 e 13 da enciclopédia.

## Objetivo
Recriar o momento mais querido do começo da obra: encontrar a **Emul** e entrar no reino secreto dos coelhos, **Rabituza**.

## Tarefas
1. **Encontro com a Emul** (Cenário Único escondido):
   - Condição: estar na Floresta Desenfreada (ou numa área definida) com X% de HP depois de fugir/sobreviver a algo perigoso, ou derrotar N Vorpal Bunnies sem ser atingido (configurável e secreto).
   - Cutscene curta com câmera (`TweenService`) e diálogo em caixa estilo VN.
2. **Emul como companheira** (`SLFCompanion.server.lua`):
   - Segue o jogador (pathfinding leve) e tem falas contextuais (fofas/atrevidas).
   - Ajuda em combate: buff **Enchant: Vorpal**, cura pequena e magia de projétil, com cooldown.
   - **Teleporte para Rabituza** a partir de qualquer cristal de save.
   - Nível de afinidade que sobe com missões e presentes (cenouras 💡).
3. **Rabituza** (zona isolada, estética fofa: casas-toca, lanternas, cogumelos, tudo em escala de coelho):
   - **Vysache**: rei, dá missões de prova de força e treina o jogador (desbloqueia skills Vorpal).
   - **Bilac**: forja (implementada no prompt 08). Diálogo mal-humorado e engraçado.
   - Irmãos/coelhos NPC: vendedor, guarda, contador de lore.
   - Arena de treino contra coelhos guerreiros.
4. **Sistema de diálogo** genérico (`SLFDialogue`): árvore de falas em tabela, escolhas, condições (flags, nível, itens) e ações (dar item, iniciar quest, teleportar).
5. NPCs das cidades (loja, guilda, banco, igreja da **Santa Eristella** vendendo Água Benta).

## Critérios de aceite
- Jogador novo consegue achar a Emul seguindo dicas espalhadas (rumores nos NPCs), mas não por acidente.
- Emul segue, ajuda e teleporta, e o estado persiste.
- Atualize o CLAUDE.md.
