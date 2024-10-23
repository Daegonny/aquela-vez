local selected = nil

local square = {
    x = 400,
    y = 400,
    size = 50
}

local function is_hit(square, target_x, target_y)
    return square.x <= target_x
        and (square.x + square.size) >= target_x
        and square.y <= target_y
        and (square.y + square.size) >= target_y
end

local function maybe_select(square, target_x, target_y)
    if is_hit(square, target_x, target_y) then
        selected = square
    else
        selected = nil
    end
end

local function release(square, target_x, target_y)
    square.x = target_x - (square.size / 2)
    square.y = target_y - (square.size / 2)
    selected = nil
end

local function maybe_select_or_release(square, target_x, target_y)
    if selected then
        release(square, target_x, target_y)
    else
        maybe_select(square, target_x, target_y)
    end
end


local function draw_square(square)
    if selected then
        local thick_size = 2
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", square.x - thick_size, square.y - thick_size, square.size + 2 * thick_size,
            square.size + 2 * thick_size)
    end

    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", square.x, square.y, square.size, square.size)
end

function love.load()
    love.graphics.setBackgroundColor(0.5, 0.5, 0.5)
end

function love.update(dt)
    local x, y = love.mouse.getPosition()
    if selected then
        square.x = x - (square.size / 2)
        square.y = y - (square.size / 2)
    end
end

function love.mousereleased(x, y, _button)
    maybe_select_or_release(square, x, y)
    print("(" .. x .. ", " .. y .. ")")
end

function love.draw()
    draw_square(square)
end
