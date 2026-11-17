# Prompt 04 — Skills e evolução de skills

Leia `CLAUDE.md` e a seção 9 da enciclopédia.

## Objetivo
Sistema de skills **data-driven** em que as skills **evoluem com o uso** (v1 → v2 → v3), igual ao SF.

## Tarefas
1. `SLFSkillDB.lua` com estrutura: `id, nameId (SLFNames), classe/requisito, tipo (ativa/passiva/buff/movimento), custo (MP/STM), cooldown, efeito, vfxId, evoluiPara, usosParaEvoluir`.
2. Skills mínimas da obra (nomes via SLFNames):
   - **Enchant: Vorpal**: buff de arma, crítico muito maior contra alvo de nível superior.
   - **Lua do Espelho d'Água** (Lakemirror Moon): corte em X que gera um clone espelhado que golpeia de novo (v1→v3 aumenta hits).
   - **Espelho Evanescente**: deixa uma imagem residual que atrai a agressão.
   - **Ignition**: buff de STR/DEX nos primeiros segundos de luta.
   - **Nitro Gain**: troca % de HP por STR/AGI.
   - **Accel / Climax Boost**: AGI multiplicado contra inimigos mais fortes.
   - Técnicas do **livro do Wezaemon** (iaijutsu que atravessa armadura). Ficam bloqueadas até a raid do prompt 10.
   - 💡 Skills de outras classes (Lança Perfurante, Escudo Firme, Bola de Fogo, Shuriken, Golpe Contador).
3. **Parkour do Sunraku** (passivas de movimento): corrida na parede curta, pulo duplo e dash aéreo, desbloqueados por nível/AGI.
4. **Hotbar** com 4–6 slots (`1–6` / `E,R,F` / botões mobile), arrastar e soltar a partir do **Livro de Skills** (tecla `K`).
5. Barra de progresso de evolução e notificação "Skill evoluiu!" com efeito.
6. VFX procedurais leves (Beams, ParticleEmitters, Trails) com pooling.

## Critérios de aceite
- Equipar, usar, ver cooldown, evoluir uma skill depois de N usos, e tudo persiste.
- Adicionar uma skill nova = só uma entrada no SkillDB (+ um handler se for de tipo novo).
- Atualize o CLAUDE.md.
