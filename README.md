# 🐍 Jogo da Cobrinha em Lua com LÖVE

Implementação do clássico Snake com Lua e LÖVE2D, focada em mecânicas de movimento direcional e crescimento progressivo.

## 📌 Índice
1. [Motivação](#-motivação)
2. [Funcionalidades](#-funcionalidades)
3. [Requisitos](#-requisitos)
4. [Instalação e Execução](#-instalação-e-execução)
5. [Controles](#-controles)
6. [Regras do Jogo](#-regras-do-jogo)
7. [Estrutura do Código](#-estrutura-do-código)
8. [Atualizações Futuras](#-atts-futuras)

---

## ✨ Motivação
Projeto desenvolvido para dominar conceitos essenciais de jogos 2D:
- **Movimentação direcional** com transições suaves
- **Gerenciamento de estados** (jogo ativo/game over)
- **Lógica de crescimento** baseada em lista encadeada
- **Sistema de dificuldade progressiva** (aumento de velocidade)
- **Colisões** com tratamento de bordas teleportáveis

---

## ✨ Funcionalidades
✔️ Sistema de pontuação dinâmico  
✔️ Reinício instantâneo (tecla R)  
✔️ Velocidade adaptativa (aumenta conforme pontuação)  
✔️ Efeito de "túnel" nas bordas  
✔️ Interface minimalista e funcional  

---

## 🔧 Requisitos
| Componente | Versão |
|------------|--------|
| Lua        | 5.3+   |
| LÖVE2D     | 11.3+  |
| SO         | Windows |
(não garanto nada em Linux e no Mac

---

## ✨ Instalação e Execução

- Programas usados:
  
| Programa        | Link                          |
|--------------|-------------------------------|
|  VS Code  | [Download](https://code.visualstudio.com)   |
|    Lua    | [Download](https://love2d.org/#download)    |

Instalado ambos, baixe no VS Code as seguintes extensões:
  - [Lua](https://marketplace.visualstudio.com/items?itemName=sumneko.lua)
  - [Love2D Support](https://marketplace.visualstudio.com/items?itemName=pixelbyte-studios.pixelbyte-love2d) 

Agora o ultimo passo é checar se o Love2D Support está vinculado a pasta do executavel do LOVE.
  - Vá até a extensão Love2D Support
  - Botão direito `Configurações`
  - Lá em `Pixebyte L0R2d: Path` o `Path to the Love2D executable file` deve estar na pasta onde está o Lua.Exe.
    
Ex: `D:\Programas\LOVE\love.exe`

  - Configurado, basta abrir a main.lua que está o código e rodar apertando  `ALT` +  `L`

---

## ✨ Controles
| Tecla        | Ação                          |
|--------------|-------------------------------|
| ↑ ↓ ← →      | Movimentação direcional       |
| R            | Reiniciar jogo (Game Over)    |
| ESC          | Sair do jogo                  |

---

## ✨ Regras do Jogo
1. **Crescimento**: Cada comida aumenta:
   - +1 segmento no corpo
   - +10 pontos
   + 5% de velocidade

2. **Game Over** ocorre quando:
   - A cabeça colide com o corpo

3. **Bordas**: A cobra atravessa as paredes e reaparece no lado oposto

---

## ✨ Estrutura do Código
```
/
├── main.lua          (Código fonte do jogo)
/
```

Principais componentes:
- `love.load()`: Inicialização
- `love.update(dt)`: Lógica do jogo
- `love.draw()`: Renderização
- Funções auxiliares: Movimento, colisão, geração de comida

---

## ✨ ATTS Futuras:
- Interface gráfica;
- Som
- Menu
