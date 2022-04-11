-----КОНСТАНТЫ-----
enemyOnStart = 1

-----Массивы Функций-----
game = {}                   --массив с функциями по работе с экраном игры
game.enemy = {}             --массив с функциями по работе с врагами
game.enemy.shot = {}        --массив с функциями по работе с выстрелами игрока
game.player = {}            --массив с функциями по работе с игроком
game.player.weapon = {}     --массив с функциями по работе с оружием игрока
game.player.shot = {}       --массив с функциями по работе с выстрелами игрока
game.test = {}              --массив с функциями для тестирования
game.bonus = {}
game.background = {}
game.level = {}

-----ОТРИСОВКА ИГРЫ-----
function game.draw()
    
    game.background.draw()

    --Игрок--
    game.player.draw()
    game.player.shot.draw()
    
    --Враги--
    game.enemy.draw()
    game.enemy.shot.draw()
    
    --Бонусы--
    game.bonus.draw()
    
    --Интерфейс--
    game.interface()
    
    --Тестирование--
    game.test.draw()
    

end



-----ОБНОВЛЕНИЕ ИГРЫ-----
function game.update(dt)
    
    game.background.update(dt)
    
    game.level.update()
    
    game.player.weapon.update()
    game.player.dead()
    game.player.control(dt)
    game.player.shot.update(dt)
    game.player.levelUpdate()
    

    enemy.type = 1
    game.enemy.create(dt)

    game.enemy.update(dt)
    game.enemy.shot.update(dt)
    
    game.bonus.update(dt)
    
    
end


function DistanceMeasurement(box1x, box1y, box1w, box1h, box2x, box2y, box2w, box2h)
    local x1 = box1x + box1w/2
    local y1 = box1y + box1h/2
    local x2 = box2x + box2w/2
    local y2 = box2y + box2h/2
    local dist = ( (x1 - x2)^2 + (y1 - y2)^2 )^0.5
    return dist
end

function CheckCollision(box1x, box1y, box1w, box1h, box2x, box2y, box2w, box2h)
    if box1x > box2x + box2w - 1 or -- box1 на правой стороне box2?
        box1y > box2y + box2h - 1 or -- box1 под box2?
        box2x > box1x + box1w - 1 or -- box2 на правой стороне box1?
        box2y > box1y + box1h - 1 -- box2 под box1?
    then
        return false -- Нет коллизии!!
    else
        return true -- Есть контакт!
    end
end

function game.background.load()
    background1 = {}
    background1.texture = love.graphics.newImage("textures/background.png")
    background1.x = 0
    background1.y = 0
    background2 = {}
    background2.texture = love.graphics.newImage("textures/background.png")
    background2.x = 2560
    background2.y = 0
end

function game.background.update(dt)
    background1.x = background1.x - dt * 500
    
    if background1.x < -2560 then
        background1.x = 1280
    end
    
    background2.x = background2.x - dt * 500
    
    if background2.x < -2560 then
        background2.x = 1280
    end
end

function game.background.draw()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(background1.texture, background1.x, background1.y)
    love.graphics.draw(background2.texture, background2.x, background2.y)
end
