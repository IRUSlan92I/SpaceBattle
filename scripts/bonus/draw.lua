-----Отрисовка Бонусов-----
function game.bonus.draw()
    for i,v in ipairs(bonus) do
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(v.texture, v.x-25, v.y-25)
    end
end
