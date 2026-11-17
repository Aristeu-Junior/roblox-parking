# Dr. Parking 4 v1.30: resumo das mecânicas (especificação de comportamento)

Fonte: análise estática do APK (sem executar). Este documento descreve **o que o jogo faz**, para servir de base a uma implementação nova e original em Luau. Não é tradução de código. Valores numéricos são unidades internas do jogo (JBox2D, vista de cima, 2D); precisarão de ajuste de escala no Roblox (studs).

## 1. Visão geral da estrutura
- Jogo 2D de vista superior com física JBox2D, renderizado em OpenGL por um framework próprio (`com.ansangha.framework`).
- Núcleo: um "mundo" com o carro do jogador, um oponente (modo online), vagas (lots), obstáculos (cones, caixas, cercas, barreiras, placas, grama), moedas e câmeras.
- Modos: menu, mapa/seleção de fase, loja de carros, garagem, offline, online (2 jogadores), tutorial, missões/quests, pausa, final.
- Dinheiro: ouro (gold) e rubi (ruby), com compras dentro do app. (Não replicar monetização do original.)

## 2. Modelo de direção do carro (por quadro)
Entradas: acelerar, frear, ângulo do volante (valor normalizado, aprox. -1 a 1), marcha.

- **Passo de tempo limitado** a no máximo 0,1 s por quadro.
- **Contagem inicial:** durante os primeiros 5,5 s da fase as entradas são forçadas para "freio ativo", então o carro fica parado.
- **Marchas:** P (estacionado), R (ré), N, D (frente). Só D e R aplicam força do motor; a força do motor é aplicada na direção em que o carro aponta, com sinal invertido em R.
- **Arrancada suave:** abaixo de 1 de velocidade, em D ou R é aplicado um empurrão extra pequeno (0,6) para o carro sair do lugar.
- **Freio:** quando acionado, aplica força contrária ao movimento com intensidade `força de freio`. Se a velocidade cair abaixo de 0,3 com freio, o carro para por completo.
- **Resistência:** atrito constante (-0,09) mais um termo que cresce com baixa velocidade (-0,33 / velocidade), para o carro desacelerar sozinho.
- **Aderência lateral (drift):** a cada quadro a velocidade é corrigida em direção ao eixo do carro; a diferença entre "velocidade desejada na direção do carro" e a velocidade real gera o deslizamento. Isso faz o carro seguir onde as rodas apontam, sem deslizar demais.
- **Esterço:** a rotação do carro por quadro é proporcional a ângulo do volante x velocidade x fator de giro; ou seja, não gira parado. O ângulo visual da roda é 36° x volante.
- **Integração física:** depois dessas forças, o passo do mundo JBox2D é executado e a posição/ângulo do corpo são lidos de volta.

## 3. Estatísticas e evolução dos carros
- 15 carros (ids 0 a 14), em 3 classes: **0 = compacto, 1 = médio, 2 = grande**, alternando ao longo da lista.
- Cada carro tem: meia-largura, meia-comprimento, posição das rodas, altura da roda, fator de giro, altura/posição da câmera em 1ª pessoa, preço (100, 200, 300 … até 1800) e três habilidades base.
- Três habilidades por carro, cada uma somada com upgrades e tuning do jogador:
  1. **Motor:** força = 0,69 + 0,02 x pontos.
  2. **Freio:** força = 4,0 + 0,3 x pontos.
  3. **Direção:** giro = fator do carro x (1 + 0,005 x pontos).
- Garagem de 6 vagas de carros; slots, upgrades e "tuning" por carro; XP por carro dá nível; há compra de carro aleatório e venda.

## 4. Regra de estacionar (pontuação por vaga)
Condição para a vaga contar: carro em **P (marcha estacionado), com velocidade ≤ 1**, e **os quatro cantos** do retângulo do carro dentro do retângulo da vaga. (Há uma checagem separada "está dentro da vaga" só pelos quatro cantos, usada para o aviso visual.)

Pontuação de 1 a 3 (estrelas/moedas), baseada em:
- deslocamento do centro do carro até o centro da vaga (x + y, normalizado pelo tamanho útil da vaga);
- desalinhamento angular (diferença entre o ângulo do carro e o da vaga, dobrado para valer também a vaga "de costas"), multiplicado pelo meio-comprimento do carro;
- ângulo das rodas no momento.

Regras:
- **1 (ruim):** desalinhamento ponderado > 12, ou deslocamento normalizado > 0,5.
- **3 (perfeito):** desalinhamento ponderado ≤ 6, deslocamento ≤ 0,25 e roda quase reta (±12°). Conta como "perfect parking".
- **2:** qualquer caso intermediário.
- Cada vaga rende moedas (1, 2 ou 3) que aparecem na posição do carro.

## 5. Acidentes e avisos
- Colisão do carro do jogador com obstáculos/paredes encerra a fase como acidente.
- Há um nível de aviso de proximidade (1 a 4) com base em checagens de colisão em distâncias crescentes à frente do carro (usado para sensores/aviso sonoro e visual).

## 6. Progressão de fases
- Fases numeradas; cada fase gera um mapa a partir de uma **semente aleatória** (`iRandomSeed`) e uma lista de 4 missões (vagas) a completar em ordem.
- O jogador completa as vagas em sequência; o mapa se repete com a mesma semente, o que permite o modo online de duas pessoas jogarem o mesmo mapa.
- Registro de posição ao longo do tempo (para replay/"fantasma" nas últimas missões).
- Fases desbloqueadas progressivamente; 'prática' separada.

## 7. Quests e extras
Tipos de quest: ganhar partidas, sequências de vitórias/estacionamentos, estacionamento perfeito, distância percorrida, subir de nível, jogar online, usar visão em 1ª pessoa, etc., com recompensa.

## 8. Câmeras e interface
- Câmeras: longe, média, perto e 1ª pessoa; espelhos esquerdo, direito e traseiro.
- Controles na tela: volante (arrastar), pedais de acelerar e frear, seletor de marcha.

## 8b. Fases, mapas e missões (leitura completa)
- **80 fases (0 a 79)**, cada uma com um mapa **desenhado à mão** (não procedural): uma arena retangular (ex.: 16x24, 20x20, 13x20 unidades), uma lista de vagas, obstáculos e a posição/ângulo inicial do carro.
- **Medidas da vaga padrão:** 1,4 de largura por 2,8 de comprimento; vagas em fila têm espaçamento de 2,59 entre centros; vagas laterais giradas 90°.
- Cada fase tem uma **lista de 1 a 3 missões** (4 no caso padrão): são índices de vagas da própria fase. A cada vaga completada, a próxima é indicada. A fase só termina ao completar todas.
- Fases iniciais (0 a ~14) são simples: 1 vaga entre 5 (reta, de ré ou lateral). A partir da fase 14 aparecem 2 e depois 3 vagas em sequência, com obstáculos (cones, caixas, cercas, barreiras, placas, grama).
- Em cada partida, as vagas sorteadas dentro da lista da fase mudam por semente aleatória (0 a 99.999), então a mesma fase pode pedir vagas diferentes.
- **Online:** a fase é sorteada entre 18 e 79, sem repetir as últimas 10 usadas; a mesma semente e lista de vagas vão para os dois jogadores. Vence quem completar as vagas primeiro (o jogador atrás recebe um pequeno bônus de motor, +0,2, no modo online).

## 8c. Recompensas, nível e dinheiro
- **Concluir uma fase nova** (a mais alta liberada) dá **+300 de ouro** e libera a próxima.
- **Ganho por partida:** pontos = bônus de estacionamento (1, 2 ou 3 por vaga) + (vagas completadas)² + 0,1 x distância percorrida.
  - Ouro ganho = pontos.
  - XP do carro = 80 x pontos.
- **Nível do carro (0 a 9):** limites de XP crescem 1,5x por nível (4096, depois +6144, +9216 ...). Subir de nível aumenta o upgrade do carro.
- **Acidente:** perde ouro = preço do carro x (velocidade + 2) x 0,05 (500 se o carro for inválido). O XP e o ouro de pontos ainda são contados.
- **Estatísticas guardadas:** distância, tempo dirigido, estacionamentos perfeitos, acidentes, fases concluídas, vitórias, derrotas e sequências (streaks) por modo.

## 8d. Quests
Uma quest ativa por vez, sorteada por tempo; 12 tipos. Recompensas de ouro: 5000 ou 7000 (a de "vencer uma fase específica" paga 2000 + 100 x fase). Exemplos: estacionar N vezes (5 ou 10), vitórias seguidas (3 ou 5), estacionar 50 ou 20 vezes, subir um nível do carro, percorrer 500 de distância, usar a 1ª pessoa, estacionamentos perfeitos (20), vencer em uma fase 18 a 79. Perder ou bater zera as sequências.

## 8e. Salvamento, online e nuvem (referência, não replicar)
- O progresso é salvo localmente e na nuvem (Firebase), no máximo uma vez por minuto.
- Online por salas no Firebase Realtime Database: um cria, outro entra; cada lado envia posição e estado ao outro.
- No Roblox, isso vira DataStore (salvamento) e servidores/teleport (salas).

## 8f. Controles de toque (jogabilidade)
- **Volante virtual:** arrastar em círculo ao redor do centro. O giro acumulado é limitado a ±540° (1,5 volta para cada lado) e cada movimento individual é limitado a 40°. O valor enviado ao carro é ângulo/540, de -1 a 1. Tocar no centro do volante (raio < 24) toca a **buzina**.
- **Volante volta sozinho ao centro** quando solto, mais rápido conforme a velocidade (taxa = min(velocidade, 5) x 250° por segundo). Parado, ele não volta.
- **Pedais:** acelerar e frear são botões liga/desliga (sem gradação). Soltar o dedo ao sair da área desliga.
- **Câmbio:** alavanca vertical com 4 posições, de cima para baixo: **P, R, N, D**. Só vai para P se a velocidade estiver abaixo de 1 ou o freio estiver pressionado. Cada troca toca um som de marcha.
- **Câmeras (botão alterna 4 modos):** terceira pessoa em 3 distâncias (zoom 1,0 / 1,2 / 1,44) e **1ª pessoa**. Dá para girar a câmera arrastando (rotação horizontal 0 a 360°, altura vertical limitada a 27 a 89); tocar perto de 0° realinha.
- **Espelhos:** retrovisor traseiro e laterais (esquerdo/direito disponíveis na 1ª pessoa), liga/desliga.
- **Opções:** música liga/desliga, som liga/desliga, **motorista à direita ou esquerda** (muda o lado do volante na 1ª pessoa), **volante à esquerda ou à direita da tela** (inverte o layout dos botões), mostrar FPS.
- **Sons de apoio:** bipe de proximidade (mais rápido quanto mais perto do obstáculo, nível de aviso 1 a 3), contagem 3-2-1-vai, motor, câmbio, buzina, batida, moeda e palmas ao vencer.

## 8g. Personalização e progressão do carro
- **Garagem de 6 vagas.** Cada vaga guarda: carro (1 de 15), skin, **slots base**, **tuning**, **upgrade** e XP.
- **Skins:** cada modelo tem 2 texturas (0 = comum, 1 = especial). A especial vem de compra com rubi ou de carro aleatório com bons atributos.
- **Três atributos** por carro: motor, freio, direção. O valor real é slot + upgrade (usado nas fórmulas da seção 3).
- **Comprar com ouro:** preço do carro x 50. Atributos iniciais = os do modelo, skin comum.
- **Comprar com rubi:** preço do carro em rubis. Atributos = modelo + 3 em cada, skin especial.
- **Carro aleatório:** custa 10.000 de ouro. Os primeiros sorteios só dão carros de ids baixos (1–6 nas 3 primeiras compras, 1–9 até a 6ª, 1–12 até a 9ª) e depois qualquer carro, com a décima compra garantindo um carro bom (id 3 a 14). O jogo evita repetir o último carro sorteado. Atributos recebem bônus aleatório (0–3, 0–3, 0–3, com no mínimo 1 no total).
- **Tuning:** custa 1.000 de ouro e aumenta 1 ponto em um dos três atributos, **sorteado**, com limite de 9 tunings por carro. Há regras que garantem que os primeiros pontos do tuning não vão todos para o mesmo atributo.
- **Upgrade por nível:** cada nível de XP do carro converte um ponto de tuning em upgrade, distribuído entre os três atributos em rodízio. Ou seja, o tuning é o "potencial" e o nível libera esse potencial.
- **Estrelas do carro:** (soma dos atributos + 9) / 9, usada como classificação visual.
- **Vender:** zera o slot da garagem e devolve ouro. O valor sugerido é preço x 2 mais 100 por ponto de slot e de tuning.
- **Melhor carro:** o jogo seleciona automaticamente o carro com maior soma de atributos.

## 8h. Ligas e ranking online
- 3 ligas, uma por classe de carro (id mod 3: 0 compacto, 1 médio, 2 grande). Para entrar na liga é preciso ter um carro da classe.
- **Rating por liga**, tipo Elo: ganhar dá `200 - chance` (mais se rating baixo, metade acima de 5000 e de novo acima de 6000), perder tira `chance`, onde chance é a probabilidade estimada de ganhar contra o oponente (1 a 199).
- **Nome da classe do jogador** pelo rating total: < 3000, < 9000, < 18000, ou acima.
- **Recompensa por partida online:** 0,8 x distância + 30 x vagas², +5 x distância se vencer, +100 se vencer por conclusão, + bônus de rating, mínimo 3. Vai para ouro e XP do carro.
- Há partida **amistosa** (sem rating).

## 8i. Como o mapa é montado visualmente (estrutura, sem usar os arquivos)
O jogo é 3D visto de cima. Para cada fase, a cena é montada em camadas, de baixo para cima:
1. **Chão externo** (textura de terreno): um plano grande, do tamanho da arena + 12 unidades de margem em cada eixo.
2. **Asfalto**: um plano do tamanho exato da arena (2 x meia-largura por 2 x meia-comprimento), um pouco acima do chão.
3. **Muros**: 4 faixas ao redor do perímetro, esticadas conforme o tamanho da arena (altura proporcional ao lado), cercando a área jogável.
4. **Prédios** ao fundo, usados como pano de fundo.
5. **Vagas**: retângulos pintados no asfalto. Há três variações visuais: branca (normal), verde (vaga ativa quando o carro está dentro) e amarela (vaga-alvo).
6. **Seta de destaque**: uma seta que flutua sobre a vaga-alvo, subindo e descendo ao longo do tempo (animada pelo tempo do jogo), some quando o carro já está dentro da vaga.
7. **Obstáculos** colocados por posição e ângulo (cone, caixa, cerca, barreira, placa, grama, grama circular, grama em setor, grama triangular e "display"/expositor). Cada um tem seu modelo e uma textura própria, mais uma versão simplificada usada só para a sombra.
8. **Sombras** projetadas (textura de sombra suave) sob carros e obstáculos.
9. **Marcas de freio e de ré**: 15 pequenos modelos de risco de pneu e luz de ré, usados sob cada carro conforme o modelo.
10. **Moedas** que aparecem quando você estaciona.
11. **Carros extras (ecars)**: 7 carros de cenário (estacionados ou parados), que servem de obstáculo.

Regra de iluminação: uma luz ambiente fraca mais uma luz direcional; a iluminação é ligada só para os objetos 3D, não para o chão.

Inventário de texturas do app (só como referência do que o visual precisa):
- Ambiente: terreno, asfalto, muro, prédio, linha de vaga, seta, moeda, pneu (2 variações), sombra (2), luz de freio e luz de ré.
- Objetos: barreira, caixa, cone, cerca, placa, grama (4 formatos), 3 variações de expositor.
- Carros: 15 modelos, cada um com 2 texturas (comum e especial), mais os 7 carros de cenário.
- Interface: 5 atlas de sprites (menu, UI, mundo, fundo e logo).

## 8j. Física, colisões e a "regra do acidente" (leitura completa)
- **Qualquer contato do corpo físico do carro com algo (muro, obstáculo ou carro estacionado) é acidente imediato.** O callback de início de contato só marca "colidiu"; os de fim, pré e pós-solução ficam vazios. Não há dano gradual, não há dano por velocidade: encostou, a fase acaba.
- O carro é um corpo dinâmico com um polígono de 8 vértices por modelo (forma arredondada na frente e atrás), com a origem deslocada por um "pitch" (eixo traseiro), e não por um retângulo. O corpo é marcado como "bala" (anti-atravessamento) e tem atrito/restituição ajustados para quase não quicar. Modelos sem polígono próprio usam um retângulo simples.
- Obstáculos são corpos **estáticos** com formas simples: retângulos finos (barreira 2,0 x 0,2; cerca 2,0 x 0,5; placa 2,0 x 0,12; display 6,0 x 0,3), um retângulo comprido (parede 1,6 x 6,0), cone pequeno (círculo de raio 0,15), canteiros de grama redondos (raio 2,5), em setor ou triangulares (polígonos).
- **Margem de segurança em 3 níveis (aviso):** além do retângulo do carro (reduzido 0,1 de cada lado), o jogo testa 3 retângulos maiores (+0,2, +0,4, +0,6). Se o menor deles bater, nível de aviso 1 (mais urgente), depois 2 e 3; sem batida, nível 4 (livre). O nível controla a frequência do bipe de proximidade.
- Esses testes de aviso são feitos por **geometria própria** (cantos do retângulo contra os limites da arena, obstáculos e carros estacionados), não pela física.
- **Dentro da vaga:** testa os 4 cantos do retângulo do carro dentro do retângulo da vaga (0 = fora).

## 8k. Carros estacionados (o quebra-cabeça de cada fase)
- **Todas as vagas do mapa são ocupadas por um carro estacionado** (visual 3D mais corpo físico), exceto a vaga-alvo da missão atual, que fica vazia.
- Cada vaga ocupada recebe, por sorteio determinístico da semente da fase: modelo/cor do carro (7 tipos de carro de cenário), deslocamento lateral (-2 a +2), deslocamento longitudinal (-2 a +2) e uma pequena rotação (-4° a +4°, às vezes invertida em 180°), de modo que cada carro estacionado fica um pouco torto e a vaga livre parece "apertada" e mais difícil.
- A cada missão concluída, o carro da próxima vaga-alvo é removido ("hide") e essa vaga fica livre. Depois de concluir uma vaga, o jogador continua dirigindo até a próxima.
- A semente avança a cada vaga, então a mesma fase com a mesma semente reproduz exatamente os mesmos carros tortos (importante para o online e para o replay).

## 8l. Os 80 mapas (varredura completa de `initMap`)
Cada mapa define: tamanho da arena (meia-largura x meia-altura), vagas (posição, tamanho, ângulo), obstáculos (tipo, posição, ângulo), posição e ângulo inicial do carro, e quantas vagas é preciso completar (1, 2 ou 3).
- **Arena:** de 5,1 x 5,1 (fase 46/47, a menor) a 14,8 x 10,4 e 9 x 16 (fase 79), tipicamente 8–11 de meia-largura. Arenas estreitas e longas aparecem em fases de "corredor" (fase 12: 3,35 x 13,4; fase 28: 2,5 x 13).
- **Missões a completar:** fases 0–13 = 1 vaga; 14–28 = 2; 29–39 = 3; 40–77 = 2; 78–79 = 3. Fases 63 e 69 são as mais cheias (18 e 10 vagas, muitos obstáculos).
- **Tipos de obstáculo (ids 0–9), por forma de colisão:** 0 retângulo fino e comprido, 1 retângulo longo e estreito (parede), 2 círculo muito pequeno (cone), 3 retângulo pequeno (caixa), 4 retângulo fino, 5 círculo grande (raio 2,5), 6 retângulo muito fino, 7 e 8 polígonos de canteiro (triângulo/setor), 9 retângulo largo e fino (display). A ligação exata entre id e nome do modelo não foi confirmada.
- **Padrões de vaga:** fileira reta (1 a 6 vagas), fileiras opostas, vagas laterais a 90°, círculos grandes no meio da arena (fases 6, 20, 48, 60, 62) e fases de slalom (fase 12, com 8 canteiros alternando de lado). A fase 29 começa com o carro girado a 315°.
- **Posição inicial:** quase sempre no centro, ou encostado em um canto ou lateral, de frente para as vagas. Ângulo inicial 0° (45° na fase 43, 315° na fase 29).
- Obs.: as fases 23, 24, 30, 64, 65 e 70 são agrupadas com outras no código (rótulos de caso compartilhados) e não foram listadas separadamente; as fases fora do intervalo caem em um mapa "padrão" simples (arena 2x2 com 2 vagas opostas).

## 8m. Fluxo de telas (máquina de estados)
0 Carregando → 9 Menu principal (garagem) ↔ 10 Loja de carros ↔ 11 Loja (ouro/rubi) ↔ 12 Opções (as 4 abas têm botões fixos para ouro e rubi) → 7 Seleção de modo (treino; ligas pequena/média/grande por classe de carro; canal/amistoso) → 8 Seleção de fase (setas para trocar de fase, só até a mais alta liberada) → 3 Partida offline → 5 Sucesso (replay do estacionamento + próxima fase / trocar de carro / voltar) ou 6 Fim (acidente) → de volta ao menu.
- 4 Pausa (continuar ou voltar ao mapa); 1 Partida online; 2 Fim online (resultado, rematch); 13 Diálogo; 14 Diálogo de quest; 15 Tutorial; 16 Saída.
- **Tutorial:** dispara sozinho na fase 0 aos 3,5 s; 4 passos (volante/pedais/câmbio/espelhos; arrastar para girar câmera; botão de câmera) e permite inverter o lado do volante.
- **Replay de sucesso:** o jogo grava até 240 posições (a partir da penúltima vaga) com posição, ângulo, volante, marcha e freio; na tela de sucesso, depois de 1 s, reproduz a manobra como "câmera lenta" do próprio estacionamento.
- **Contagem inicial:** 5,5 s de espera (começa a buzina de partida aos 2,4 s, o motor aos 2,6 s, e 3 bipes aos 3,1 / 3,9 / 4,7 s, "go" aos 5,5 s).
- Quando você estaciona, 1, 2 ou 3 moedas 3D aparecem sobre o carro.
- O laço principal usa passo variável limitado a 0,004–0,2 s, e a física limita cada passo a 0,1 s.

## 8n. Online (protocolo e arquitetura)
- **Sem servidor autoritativo**: cada jogador simula o próprio carro e envia o estado ao outro; o oponente é um "fantasma" sem colisão física com você. Cheating é possível por desenho; o jogo confia nos clientes.
- **Matchmaking:** um nó "Waiting" no Firebase Realtime Database; o criador cria uma sala e o outro entra. Cada lado escreve em "ToJoiner" ou "ToCreator" (mensagens de texto numeradas, polling por listener).
- **Mensagens (texto separado por espaço):**
  - `P` perfil: 3 ratings, carro, skin, 3 atributos, estrelas de tuning, país, nome.
  - `A` atualização/rematch: ratings + carro + skin + atributos.
  - `S` início; `R` versão do app (para comparar compatibilidade; cancela amistoso se a versão do oponente for mais antiga); `I` informação de partida (fase, semente, 4 missões); `O Y/N` fim de jogo (venceu ou perdeu); `T` ping.
  - `U` estado do carro, enviado várias vezes por segundo: tempo, x, y, ângulo, ângulo do volante, marcha, freio, velocidade x e y, missões completadas.
- **Suavização do oponente:** entre mensagens o oponente avança pela velocidade recebida e a velocidade decai 1% por quadro (amortecimento), para não travar; o relógio local é alinhado ao do oponente durante a contagem.
- O criador gera a fase online (`generateOnlineStage`) e a envia; o outro usa a mesma semente.
- Ligas: o carro precisa ser da classe da liga (`id mod 3`); se não for, o jogo troca automaticamente para um carro compatível.
- Ranking global e conquistas (32 conquistas) estão ligados ao Google Play Games.

## 8o. Salvamento
- Um único objeto JSON guarda: versão, preferências (música, som, lado do volante, lado do motorista), ouro e rubi (guardados de forma ofuscada, para dificultar edição do arquivo), fase mais alta liberada, estatísticas (distância, tempo, acidentes, perfeitos, missões), quest ativa (progresso, recompensa), 3 ratings com vitórias/derrotas/sequências, 32 conquistas e a garagem (até 12 posições no formato salvo, 6 usadas no jogo).
- Atributos de cada carro são empacotados em bits (slot 5 bits, tuning 4 bits, upgrade 4 bits por atributo) para economizar espaço.
- Salvamento local + nuvem (Firestore) com backup periódico e sincronização ao entrar (`loadFromCloud`, `saveToCloud`, `processStateLoaded`).
- Valores iniciais dependem do país do aparelho: a preferência padrão de lado do motorista é definida por uma lista de países que dirigem à esquerda (Reino Unido, Índia, Japão, Austrália etc.).

## 8p. Anotações finais da leitura
- Não leio anúncios, como você pediu.
- Fora do escopo desta leitura: layout de interface (sprites e posições de botões), os efeitos visuais de partículas e a lista de conquistas (nomes).

## 8q. Interface (UI/UX)

### Sistema de coordenadas e botões
- **Resolução lógica fixa de 800 de largura**; a altura varia com a proporção da tela (altura = 800 x altura/largura). Todos os botões são posicionados nesse espaço, então o layout escala para qualquer aparelho.
- Todo botão é um "pad" com tipo, posição e tamanho. **4 tipos:** 1 = volante (círculo que acompanha o ângulo do dedo), 2 = pedal (liga enquanto o dedo está sobre ele), 3 = botão de toque simples, 4 = alavanca vertical (câmbio). Cada pad tem uma área de toque **60 unidades maior** que o desenho, para facilitar o toque.
- Há uma tabela de pads ativos/inativos por tela: cada troca de tela limpa tudo e ativa só os botões daquela tela.
- Há suporte a multitoque: o dedo no volante e outro no pedal ao mesmo tempo.

### HUD da partida (offline/online)
- **Volante** grande no canto inferior (lado escolhido nas opções), ocupando cerca de 180 x 180; **pedal de freio** (52 x 66) e **acelerador** (50 x 110) do lado oposto; **alavanca do câmbio** vertical (80 x 94) no extremo da tela; **botão de câmera** (40 x 40) abaixo do centro do lado; **pausa** (40 x 40) no canto superior.
- **Espelhos** no topo: traseiro (120 x 60, centro) e laterais (45 x 60, a 200 de cada lado do centro) em miniatura, só aparecem se ligados.
- **Contagem regressiva** 3-2-1 grande no centro (sprites "3", "2", "1") entre 3,1 e 5,5 s.
- **Dicas animadas** nas fases iniciais: seta que pisca e desliza sobre o câmbio (fases 3 a 5, para usar a ré) e sobre o freio/câmbio quando o carro está na vaga nas fases abaixo de 14 (indica "pare e coloque em P").
- **Vaga e seta flutuante** no mapa (ver 8i); **moedas** sobre o carro ao estacionar; faixa **"GOOD! / GREAT! / PERFECT!"** (marrom, azul, verde) conforme a nota de 1 a 3.
- **Painel de 1ª pessoa:** um painel preto com velocímetro e conta-giros desenhado sobre a visão do motorista, com o logotipo do estúdio no centro.

### Telas de menu
- **Estilo visual:** madeira e papel pardo (marrom/bege), placas com parafusos de metal, texto em fonte grossa estilo "cartoon" com contorno escuro (branco ou laranja), ícones simples. Tudo em atlas de sprites.
- **Barra superior fixa:** contador de rubi (esquerda, com "+") e de ouro (direita, com "+"); os números contam **animados** (somam de 1 em 1, de 2 em 2, de 20 em 20... conforme a diferença) quando o saldo muda.
- **Menu principal (garagem):** o carro atual gira no centro (arrastar gira), setas esquerda/direita para trocar entre as 6 vagas, contador "n/6", nome da classe do jogador (NOVICE / EXPERT / MASTER / LEGEND) com o rating (dividido por 10), **3 barras de atributo** (ENGINE, BRAKE, STEERING) com 30 segmentos coloridos (base, slot, upgrade e potencial de tuning em cores diferentes) mais o número "total (+extra+upgrade)", estrelas de tuning/upgrade, ícone da liga do carro, botão **TUNING** (com o custo de 1000 de ouro) ou **BUY CAR** se a vaga está vazia, ou **MAX TUNING** se esgotou, e um botão de vender.
- **Botão "QUEST TODAY"** no topo e botões de placar e conquistas (Google Play Games).
- **Botão START grande** no canto inferior direito (placa de madeira); na seleção de modo ele vira **PRACTICE**.
- **Quatro abas** na base: Menu (casa), Loja de carros (carro), Loja (carrinho) e Opções (engrenagem).
- **Seleção de modo:** 3 cartões das ligas **C / M / L** (Compact / Midsize / Large), cada um com ícone, rating e vitórias/derrotas ("12W 5L"); cartões de liga sem carro correspondente aparecem **escurecidos** (30% de brilho) e abrem um aviso. Mais o botão de canal (amistoso) e o de treino.
- **Busca de oponente:** escurece a tela, mostra uma ampulheta e só mostra o botão "cancelar" depois de 5 s.
- **Seleção de fase:** setas esquerda e direita trocam de fase, e o botão de jogar só funciona até a fase liberada. (O atlas tem um sprite de cadeado, provavelmente usado para fases bloqueadas; não confirmei o uso no código.)
- **Tela de sucesso:** a tela escurece suavemente (até 25% de preto), aparece "MISSION SUCCESS" depois de 1 s, mostra o replay do estacionamento com o carro, os botões de próxima fase, voltar e trocar de carro (só se você tem mais de um) aparecem depois de 2,5 s.
- **Tela de resultado online (deduzida dos sprites, não li o código de desenho):** o atlas traz "YOU WON!" / "YOU LOST!" em letras laranja grandes, "VS" e "LEVEL UP". O oponente tem nome, país e rating recebidos pela rede (ver 8n).
- **Diálogos:** caixa de papel pardo com um ou dois botões (OK / Cancelar), usados para compra, venda e avisos.
- **Opções:** 4 botões grandes lado a lado (música, som, lado do motorista, lado do volante) com ícone e estado, e botão de FPS escondido no canto.
- **Tutorial:** balão de fala de papel com ícones (volante, pedal, câmbio, câmera), seta de dedo e instruções, com botões de próxima e "inverter lado do volante".

### Atlas de sprites (ui.png e menu.png)
- `ui.png` (1024 x 1024): marcas P-R-N-D do câmbio (grandes e pequenas), volante, pedais, estrela cheia e vazia, moeda e rubi, "YOU WON/YOU LOST", números e "VS", seta laranja, ícone de arrastar com o dedo, "LEVEL UP", cadeado, alfabeto completo da fonte, cartões de papel, "QUEST COMPLETED", faixas GOOD/GREAT/PERFECT, ícones C/M/L, painel do carro com mostradores.
- `menu.png` (1024 x 1024): botões de menu (casa, carro, carrinho, engrenagem, seta, rosto), ícones de música/som/volante/motorista, pilhas de moedas e de rubis em 4 tamanhos, "QUEST TODAY", "START", "PRACTICE", "FREE GOLD", "QUEST", cartões das 3 ligas, setas, balão de fala e cartões de papel.

## 9. O que NÃO usar do original
Modelos, texturas, sons, nome, interface e logotipos do Dr. Parking 4 pertencem ao desenvolvedor. A implementação no Roblox deve usar assets próprios ou licenciados e um nome próprio.
