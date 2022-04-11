-----Создание Врагов-----
function game.enemy.create(dt)
    if enemy.count == nil  then
        enemy.count = enemyOnStart
    end
    if enemy.left > 0 then
        if enemy.count <= 0 and current.enemies < 5 then
            enemy.massEnemyIndex = enemy.massEnemyIndex+1
            enemy.type = level.lvl1.enemy[enemy.massEnemyIndex]
            
            local locEnemy = {}
            locEnemy.texture = {}
            locEnemy.speed = {}
            locEnemy.shot = {}
            
            if enemy.type == 1 then
                locEnemy.sideSpeed = 0
                locEnemy.angle = math.random(math.pi - 0.5, math.pi + 0.5)
                locEnemy.reload = 0
                locEnemy.type = 1
                locEnemy.width = enemy.type1.width
                locEnemy.height = enemy.type1.height
                locEnemy.health = enemy.type1.health
                locEnemy.x = enemy.type1.x
                locEnemy.y = enemy.type1.y
                locEnemy.realX = locEnemy.x + locEnemy.width / 2
                locEnemy.realY = locEnemy.y + locEnemy.height / 2
                locEnemy.speed.current = enemy.type1.speed.current
                locEnemy.speed.max = enemy.type1.speed.max
                locEnemy.shot.damage = enemy.type1.shot.damage
                locEnemy.shot.speed = enemy.type1.shot.speed
                locEnemy.acceleration = enemy.type1.acceleration
                locEnemy.texture.ship = enemy.type1.texture.ship
                locEnemy.texture.shot = enemy.type1.texture.shot
                enemy.massEnemyIndex = enemy.massEnemyIndex+1
                enemy.delay = 250

                table.insert(enemy, locEnemy)
                
            elseif enemy.type == 2 then
                locEnemy.sideSpeed = 0
                locEnemy.angle = math.random(math.pi - 0.5, math.pi + 0.5)
                locEnemy.reload = 0
                locEnemy.type = 2
                locEnemy.width = enemy.type2.width
                locEnemy.height = enemy.type2.height
                locEnemy.health = enemy.type2.health + 100
                locEnemy.x = enemy.type2.x
                locEnemy.y = enemy.type2.y
                locEnemy.realX = locEnemy.x + locEnemy.width / 2
                locEnemy.realY = locEnemy.y + locEnemy.height / 2
                locEnemy.speed.current = enemy.type2.speed.current
                locEnemy.speed.max = enemy.type2.speed.max
                locEnemy.shot.damage = enemy.type2.shot.damage
                locEnemy.shot.speed = enemy.type2.shot.speed
                locEnemy.acceleration = enemy.type2.acceleration
                locEnemy.texture.ship = enemy.type2.texture.ship
                locEnemy.texture.shot = enemy.type2.texture.shot
                enemy.massEnemyIndex = enemy.massEnemyIndex+1
                enemy.delay = 250

                table.insert(enemy, locEnemy)
            end
            
            current.enemies = current.enemies + 1
            enemy.count = enemy.delay
            enemy.left = enemy.left - 1

        else
            enemy.count = enemy.count - 100 * dt
        end
    else
        current.levelCompleted = true
        current.level = current.level + 1
        current.levelChanged = true
    end
        
end

-----Удаление Врагов-----
function game.enemy.delete(deletedEnemies)

    for i,v in ipairs(deletedEnemies) do
        table.remove(enemy, v)
        current.enemies = current.enemies - 1
    end
end

-----Обновление Врагов-----
function game.enemy.update(dt)

    local deletedEnemies = {}
    local deletedPlayerShots = {}
    
    --Перебор Врагов--
    for i,v in ipairs(enemy) do

        
        --Разгон--
        if v.speed.current < v.speed.max and v.speed.current > -v.speed.max then
            if DistanceMeasurement(player.x, player.y, player.width, player.height, v.x, v.y, v.width, v.height) > 500 then
                v.speed.current = v.speed.current + v.acceleration * dt
            else
                if v.speed.current > 0 then
                    v.speed.current = v.speed.current - v.acceleration * dt * (v.speed.current / 100 + 0.1)
                else
                    v.speed.current = v.speed.current - v.acceleration * dt
                end
            end
        end
        if v.realY > player.realY then
            v.sideSpeed = v.sideSpeed + dt * 75
        else
            v.sideSpeed = v.sideSpeed - dt * 75
        end
        
        --Обновление Координат--
        v.x = v.x + v.speed.current * dt * math.cos(v.angle)
        v.y = v.y + v.speed.current * dt * math.sin(v.angle)
        v.x = v.x + v.sideSpeed * dt * math.cos(v.angle+math.pi/2)
        v.y = v.y + v.sideSpeed * dt * math.sin(v.angle+math.pi/2)
        
        --Расчет Углов--
        test.angle1 = {x = v.x, y = v.y}
        test.angle2 = {x = v.x + v.width * math.cos(v.angle+math.pi), y = v.y + v.width * math.sin(v.angle+math.pi) }
        test.angle3 = {x = test.angle2.x + v.height * math.sin(v.angle+math.pi), y = test.angle2.y - v.height * math.cos(v.angle+math.pi) }
        test.angle4 = {x = v.x + v.height * math.sin(v.angle+math.pi), y = v.y - v.height * math.cos(v.angle+math.pi) }
        

        --Расчет Реальных Координат--
        v.realX = (test.angle1.x + test.angle3.x) / 2
        v.realY = (test.angle1.y + test.angle3.y) / 2

        --Поворот--
        if directionCheckUp7(v.realX, v.realY, v.angle, player.realX, player.realY)  then
            v.angle = v.angle - dt
        else
            v.angle = v.angle + dt
        end



        --Удаление Врагов Когда Их ХП Падает Ниже Нуля--
        if v.health <= 0 then
            table.insert(deletedEnemies, i)
            
            player.score = player.score + 500

            local bonusCreate = math.random(1, 10)
            if bonusCreate == 1 then
                game.bonus.create(v.x, v.y, math.random(1, bonus.types) )
            end
            
        end
        
        --Удаление Врагов Когда Они Уходят Далеко за Экран--
        if v.x < -1000 or v.x > 2280 or v.y < -1000 or v.y > 1720 then
            table.insert(deletedEnemies, i)
        end
        
        --Перебор Снарядов и Проверка на Попадания--
        for ii,vv in ipairs(player.shot) do
            if hitCheck(v.x, v.y, v.width, v.height, v.angle, vv.x, vv.y, vv.size.width, vv.size.height) then
                v.health = v.health - math.random(vv.damage*0.5, vv.damage*2)
                
                v.angle = v.angle + math.random(-1, 1) * player.weapon.projectile.kick
                v.speed.current = v.speed.current - player.weapon.projectile.kick * 10
                
                table.insert(deletedPlayerShots, ii)
                
            end
        end
        game.player.shot.delete(deletedPlayerShots)
        
        --Стрельба--
        if v.reload < 0 then
            game.enemy.shot.create(v)
            v.reload = 10
        else
            v.reload = v.reload - dt*5
        end


    end
    game.enemy.delete(deletedEnemies)

end


function directionCheckUp7(enemyX, enemyY, enemyA, playerX, playerY)
    local y = (playerX - enemyX) * math.tan(enemyA) + enemyY
    if y < playerY then
        return true
    else
        return false
    end
end

function hitCheck(enemyX, enemyY, enemyW, enemyH, enemyA, shotX, shotY, shotW, shotH)
    -- 1 2
    -- 4 3
    
    local max = {x = math.max(test.angle1.x, test.angle2.x, test.angle3.x, test.angle4.x), y = math.max(test.angle1.y, test.angle2.y, test.angle3.y, test.angle4.y)}
    local min = {x = math.min(test.angle1.x, test.angle2.x, test.angle3.x, test.angle4.x), y = math.min(test.angle1.y, test.angle2.y, test.angle3.y, test.angle4.y)}
    
    local shell = {x = shotX + shotW / 2, y = shotY + shotH / 2}
    
    if ( (shell.y > min.y) and (shell.y < max.y) and (shell.x > min.x) and (shell.x < max.x) ) then
        
        return true

    else
        return false
    end
end

function game.enemy.shot.create(v)
    local shot = {}
    shot.x = v.realX
    shot.y = v.realY
    shot.angle = v.angle
    shot.speed = v.shot.damage
    shot.damage = v.shot.speed
    shot.size = {}
    shot.size.width = 15
    shot.size.height = 15
    shot.texture = v.texture.shot    
    
    table.insert(enemy.shot, shot)
end

function game.enemy.shot.update(dt)
    local deletedEnemyShots = {}
    for i,v in ipairs(enemy.shot) do
        v.x = v.x + v.speed * dt * math.cos(v.angle)
        v.y = v.y + v.speed * dt * math.sin(v.angle)
        
        if v.x < 0 or v.y > 720 or v.y < 0 or v.x > 1280 then
            table.insert(deletedEnemyShots, i)
        end
        
        if CheckCollision(v.x, v.y, v.size.width, v.size.height, player.x, player.y, player.width, player.height) then
            if not current.godmode then
                player.health.current = player.health.current - v.damage
            end
            table.insert(deletedEnemyShots, i)
        end
    end
    game.enemy.shot.delete(deletedEnemyShots)
end

function game.enemy.shot.delete(deletedEnemyShots)
    for i,v in ipairs(deletedEnemyShots) do
        table.remove(enemy.shot, v)
    end
end

function game.enemy.reset()
    while current.enemies ~= 0 do
        table.remove(enemy, i)
        current.enemies = current.enemies - 1
    end
end