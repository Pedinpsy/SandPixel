
pixelSize = 5
width = 800
heigth = 1000
countPixelH = heigth/pixelSize
countPixelW = width/pixelSize
matriz = {}
controlTime = 0
dir = {1,-1}
color = 100
tempo = 0



function love.load()
    love._openConsole()
    for i = 0, width do
        matriz[i] = {}  -- Cria uma sub-tabela
        for j = 0, heigth do
            matriz[i][j] = 0  -- Define o valor inicial como zero
        end
    end
  
	love.window.setMode(width, heigth)
end

function love.update(dt)
    tempo = tempo + dt
    controlTime = controlTime+dt
   
        updateSand()
        controlTime = 0
     
    drawSandByclick()
    
    
end

function love.draw()

    if debugMode then 
        drawLines(countPixelH,countPixelW)
    end

    drawSands()
    love.graphics.setColor(1, 1, 1)
   
end

function drawSandByclick()
    local mouseX, mouseY = love.mouse.getPosition()
    if love.mouse.isDown(1) then
        local frequencia_r = 0.3  -- Frequência da variação do componente vermelho
        local frequencia_g = 0.6 -- Frequência da variação do componente verde
        local frequencia_b = 0.9 -- Frequência da variação do componente azul
        
        local amplitude_r = 160   -- Amplitude da variação do componente vermelho
        local amplitude_g = 160   -- Amplitude da variação do componente verde
        local amplitude_b = 160   -- Amplitude da variação do componente azul
    
        local r = amplitude_r * math.sin(frequencia_r * tempo) + amplitude_r
        local g = amplitude_g * math.sin(frequencia_g * tempo) + amplitude_g
        local b = amplitude_b * math.sin(frequencia_b * tempo) + amplitude_b
        matriz[math.floor(mouseX/pixelSize)][math.floor(mouseY/pixelSize)] = {}
        matriz[math.floor(mouseX/pixelSize)][math.floor(mouseY/pixelSize)][1] = r/256
        matriz[math.floor(mouseX/pixelSize)][math.floor(mouseY/pixelSize)][2] = g/256
        matriz[math.floor(mouseX/pixelSize)][math.floor(mouseY/pixelSize)][3] = b/256
        color  = color * 1.2
    end
end

function updateSand()
    
        for j = countPixelH, 0, -1  do
            for i = countPixelW,0 , -1 do
            if (matriz[i][j] ~= 0 and j < countPixelH-1) then
                if(matriz[i][j+1] == 0 )then 
                matriz[i][j],matriz[i][j+1] = 0,matriz[i][j]
            
                else
                    choosenDir = dir[math.random(#dir)]
                    if(i+choosenDir >= 0 and i+choosenDir < countPixelW and matriz[i+choosenDir][j+1] == 0) then 
                        matriz[i][j],matriz[i+choosenDir][j+1] = 0,matriz[i][j]
                        
                    else
                        choosenDir = choosenDir * -1
                        if(i+choosenDir >= 0 and i+choosenDir < countPixelW and matriz[i+choosenDir][j+1] == 0) then 
                            matriz[i][j],matriz[i+choosenDir][j+1] = 0,matriz[i][j]     
                        end
                    end

                end
                
            end 
        end
    end

end

function drawSands()
    for i = 0, countPixelW do
        for j = 0,  countPixelH do
           
            if matriz[i][j] ~= 0 then
                --print(matriz[i][j][1],matriz[i][j][2],matriz[i][j][3])
                love.graphics.setColor(matriz[i][j][1], matriz[i][j][2], matriz[i][j][3])
                love.graphics.rectangle("fill", i*pixelSize, j*pixelSize,pixelSize,pixelSize)
            end
        end
    end
end

function drawLines()   
    for i = 0, countPixelH do
        love.graphics.setColor(1, 1, 1)
        love.graphics.line(0, i*pixelSize , width,i*pixelSize )
    end
    for i = 0,  countPixelW do
        love.graphics.setColor(1, 1, 1)
        love.graphics.line(i*pixelSize, 0 ,i*pixelSize,heigth )
    end   
    
end