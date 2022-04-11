-----ЗАГРУЗКА СТОРОННИХ ФАЙЛОВ-----

require "scripts/mainMenu"          --функции связанные с главным меню
require "scripts/gameMode"          --функции связанные с экраном игры
require "scripts/gameInterface"     --функции связанные с интерфейсом игры

require "scripts/player/draw"       --функции связанные с отрисовкой игрока
require "scripts/player/update"     --функции связанные с обновлением игрока
require "scripts/player/load"       --функции связанные с загрузкой игрока

require "scripts/enemy/draw"        --функции связанные с отрисовкой врагов
require "scripts/enemy/update"      --функции связанные с обновлением врагов
require "scripts/enemy/load"        --функции связанные с загрузкой врагов

require "scripts/bonus/draw"        --функции связанные с отрисовкой бонусов
require "scripts/bonus/update"      --функции связанные с обновлением бонусов
require "scripts/bonus/load"        --функции связанные с загрузкой бонусов

require "scripts/levels/draw"        --функции связанные с отрисовкой уровней
require "scripts/levels/update"      --функции связанные с обновлением уровней
require "scripts/levels/load"        --функции связанные с загрузкой уровней

require "scripts/test"              --функции связанные с тестирование

-----ЗАГРУЗКА ПРОГРАММЫ-----
function love.load()
    
    --Размер Окна--
    love.graphics.setMode(1280, 720, false, false, 1)   --размер окна
    
    --Массив для Текущих Значений--
    current = {}

    --Проверка Текущего Состояния--
    --режим:
    --1) главное меню
    --2) игра
    current.screen = 1
    
    --кнопка:
    --1) новая игра
    --2) выход
    --3) продолжить
    --4) рестарт
    --5) меню
    current.button = buttonGame
    
    --выбор в меню:
    -- -1) вверх
    --  0) стоп
    --  1) вниз
    current.selection = 0
    
    menu.load()

    --Загрузка Игры--
    current.pause = false
    current.test = false
    current.enemies = 0
    current.godmode = false
    current.level = 1
    current.levelChanged = true
    current.levelCompleted = false
    current.gameCompleted = false

    game.background.load()
    game.level.load()
    game.player.load()
    game.enemy.load()
    game.bonus.load()
    

end

-----ОБНОВЛЕНИЕ ПРОГРАММЫ-----
function love.update(dt)
    
    --выполнение функций главного меню при его включении 
    if current.screen == 1 then
        menu.selection()
        menu.enter()
    end

    --выполнение функций игрового экрана при его включении 
    if current.screen == 2 then
        if not current.pause and not player.dead then
            game.update(dt)
        end
    end

end

-----ОТРИСОВКА ИГРЫ-----
function love.draw()
    if current.screen == 1 then     --если экран меню
        menu.draw()                 --то рисуем его
    
    elseif current.screen == 2 then --если экран игры
        game.draw()                 --то рисуем его
    end

end




---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

function love.keyreleased(key)

    if (current.screen == 1) or (player.dead) then     --если экран меню
    
        if key == "down" or key == "right" then       --то по нажатию "Вниз"
            current.selection = 1   --записать информацию о том что было нажато "Вниз"
        elseif key == "up" or key == "left" then     --а по нажатию "Вверх"
            current.selection = -1  --записать информацию о том что было нажато "Вверх"
        end
        
        if key == "escape" and current.pause == true then      
            current.pause = false           
            current.screen = 2              
        end
        
        if key == "escape" and player.dead then
            current.screen = 1
        end


        
    end
    
    if current.screen == 2 then             --если экран игры
        if key == "escape" then             --то по нажатию "Esc"
            current.pause = true            --поставить на паузу
            current.screen = 1              --открыть меню
            current.button = buttonResume   --и выбрать пункт "Продолжить"
        end
        
        if key == "p" then
            current.pause = not current.pause
        end
        
        if key == "t" then
            current.test = not current.test
        end
        
        if current.test then
            if key == "1" then
                player.weapon.changed = true
                player.weapon.type.new = "plasma"
            elseif key == "2" then
                player.weapon.changed = true
                player.weapon.type.new = "laser"
            end
        
            if key == "g" and current.test then
                current.godmode = not current.godmode
            end

            if key == "l" and player.level < 5 then
                player.levelUp = true
            end

            if key == "b" then
                game.bonus.create(1280, 360, math.random(1, bonus.types) )
            end
        end
    end
    
end