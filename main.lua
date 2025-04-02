-- ______________________ CONSTANTES _______________________
local LARGURA, ALTURA = 600, 400  -- Dimensões da tela
local TAMANHO_QUADRADO = 20       -- Tamanho de cada célula da grade

-- ______________________ VARIÁVEIS _______________________
local cobra, direcao, proxima_direcao, comida
local pontuacao, velocidade, tempo_ultimo_movimento, game_over

-- _________________ FUNÇÕES AUXILIARES ___________________

-- Função responsável por mover a cobra
local function mover_cobra()
    direcao = proxima_direcao
    
    -- Move o corpo (exceto a cabeça)
    for i = #cobra, 2, -1 do
        cobra[i].x = cobra[i-1].x
        cobra[i].y = cobra[i-1].y
    end
    
    -- Move a cabeça conforme a direção
    if direcao == "cima" then
        cobra[1].y = cobra[1].y - TAMANHO_QUADRADO
    elseif direcao == "baixo" then
        cobra[1].y = cobra[1].y + TAMANHO_QUADRADO
    elseif direcao == "esquerda" then
        cobra[1].x = cobra[1].x - TAMANHO_QUADRADO
    elseif direcao == "direita" then
        cobra[1].x = cobra[1].x + TAMANHO_QUADRADO
    end
    
    -- Tratamento de bordas (teleporte)
    if cobra[1].x < 0 then cobra[1].x = LARGURA - TAMANHO_QUADRADO end
    if cobra[1].x >= LARGURA then cobra[1].x = 0 end
    if cobra[1].y < 0 then cobra[1].y = ALTURA - TAMANHO_QUADRADO end
    if cobra[1].y >= ALTURA then cobra[1].y = 0 end
end

-- Verifica colisão com o próprio corpo
local function verificar_colisao()
    for i = 2, #cobra do
        if cobra[1].x == cobra[i].x and cobra[1].y == cobra[i].y then
            game_over = true
            return
        end
    end
end

-- Verifica se a cobra comeu a comida
local function verificar_comida()
    if cobra[1].x == comida.x and cobra[1].y == comida.y then
        -- Obtém o último segmento da cobra
        local ultimo = cobra[#cobra]
        table.insert(cobra, {x = ultimo.x, y = ultimo.y})
        
        -- Gera nova comida alinhada à grade
        comida.x = math.random(0, LARGURA - TAMANHO_QUADRADO)
        comida.y = math.random(0, ALTURA - TAMANHO_QUADRADO)
        comida.x = comida.x - (comida.x % TAMANHO_QUADRADO)
        comida.y = comida.y - (comida.y % TAMANHO_QUADRADO)
        
        -- Aumenta pontuação e reduz velocidade
        pontuacao = pontuacao + 10
        velocidade = math.max(0.05, velocidade - 0.005)
    end
end

-- ________________ FUNÇÕES PRINCIPAIS LÖVE ________________

-- Inicializa o jogo
function love.load()
    math.randomseed(os.time())
    love.window.setTitle("Jogo da Cobrinha em Lua")
    love.window.setMode(LARGURA, ALTURA)
    
    -- Configuração inicial da cobra
    cobra = {
        {x = LARGURA/2, y = ALTURA/2},
        {x = LARGURA/2 - TAMANHO_QUADRADO, y = ALTURA/2},
        {x = LARGURA/2 - 2*TAMANHO_QUADRADO, y = ALTURA/2}
    }
    direcao = "direita"
    proxima_direcao = "direita"
    
    -- Configuração inicial da comida
    comida = {
        x = math.random(0, LARGURA - TAMANHO_QUADRADO),
        y = math.random(0, ALTURA - TAMANHO_QUADRADO)
    }
    comida.x = comida.x - (comida.x % TAMANHO_QUADRADO)
    comida.y = comida.y - (comida.y % TAMANHO_QUADRADO)
    
    -- Inicialização das variáveis do jogo
    pontuacao = 0
    velocidade = 0.1
    tempo_ultimo_movimento = 0
    game_over = false
end

-- Atualiza o estado do jogo a cada frame
function love.update(dt)
    if game_over then return end
    
    tempo_ultimo_movimento = tempo_ultimo_movimento + dt
    
    if tempo_ultimo_movimento >= velocidade then
        tempo_ultimo_movimento = 0
        mover_cobra()
        verificar_colisao()
        verificar_comida()
    end
end

-- Desenha elementos do jogo
function love.draw()
    -- Fundo
    love.graphics.setColor(0.1, 0.1, 0.1)
    love.graphics.rectangle("fill", 0, 0, LARGURA, ALTURA)
    
    -- Cobra
    for _, segmento in ipairs(cobra) do
        love.graphics.setColor(0, 1, 0)
        love.graphics.rectangle("fill", segmento.x, segmento.y, TAMANHO_QUADRADO, TAMANHO_QUADRADO)
    end
    
    -- Comida
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", comida.x, comida.y, TAMANHO_QUADRADO, TAMANHO_QUADRADO)
    
    -- Pontuação
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Pontuação: " .. pontuacao, 10, 10)
    
    -- Mensagem de game over
    if game_over then
        love.graphics.setColor(1, 0, 0)
        love.graphics.print("GAME OVER! Pressione R para reiniciar", LARGURA/2 - 150, ALTURA/2)
    end
end

-- Captura eventos do teclado
function love.keypressed(key)
    if key == "r" and game_over then
        love.load()  -- Reinicia o jogo
    end
    
    if not game_over then
        if key == "up" and direcao ~= "baixo" then
            proxima_direcao = "cima"
        elseif key == "down" and direcao ~= "cima" then
            proxima_direcao = "baixo"
        elseif key == "left" and direcao ~= "direita" then
            proxima_direcao = "esquerda"
        elseif key == "right" and direcao ~= "esquerda" then
            proxima_direcao = "direita"
        end
    end
end
