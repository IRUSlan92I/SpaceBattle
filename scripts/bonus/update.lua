-----Создание Бонусов-----
function game.bonus.create(enemyX, enemyY, type)
    local locBonus = {}
    locBonus.type = type
    locBonus.x = enemyX
    locBonus.y = enemyY
    locBonus.width = 50
    locBonus.height = 50
    locBonus.angle = 0
        
    if type == 1 then
        locBonus.texture = bonus.textures.lvlUp
    elseif type == 2 then
        locBonus.texture = bonus.textures.laser
    elseif type == 3 then
        locBonus.texture = bonus.textures.plasma
    elseif type == 4 then
        locBonus.texture = bonus.textures.health
    elseif type == 5 then
        locBonus.texture = bonus.textures.life
    end

    table.insert(bonus, locBonus)
end

-----Удаление Бонусов-----
function game.bonus.delete(deletedBonuses)

    for i,v in ipairs(deletedBonuses) do
        table.remove(bonus, v)
    end
end

-----Обновление Бонусов-----
function game.bonus.update(dt)

    local deletedBonuses = {}
    
    --Перебор Бонусов--
    for i,v in ipairs(bonus) do
 
        --Обновление Координат--
        v.x = v.x - dt * 250
        v.y = v.y + dt * 500 * math.cos(v.angle)
        v.angle = v.angle + 0.05

        --Удаление Бонусов Когда Они Уходят Далеко за Экран--
        if v.x < -100 then
            table.insert(deletedBonuses, i)
        end
        
        if CheckCollision(v.x, v.y, v.width, v.height, player.x, player.y, player.width, player.height) then
            if v.type == 1 then
                player.levelUp = true
                player.score = player.score + 200
            elseif v.type == 2 then
                player.weapon.type.new = "laser"
                player.weapon.changed = true
                player.score = player.score + 100
            elseif v.type == 3 then
                player.weapon.type.new = "plasma"
                player.weapon.changed = true
                player.score = player.score + 100
            elseif v.type == 4 then
                if player.health.current + 100 < player.health.max then
                    player.health.current = player.health.current + 100
                else
                    player.health.current = player.health.max
                end
                player.score = player.score + 50
            elseif v.type == 5 then
                if player.lifes.current < player.lifes.max then
                    player.lifes.current = player.lifes.current + 1
                end
                player.score = player.score + 250
            end
            table.insert(deletedBonuses, i)
        end
        
        

    end
    game.bonus.delete(deletedBonuses)

end