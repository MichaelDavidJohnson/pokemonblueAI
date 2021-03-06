module("util", package.seeall)

--[[local direction_table = {right = {x+1,y},
        left = {x-1, y},
        up = {x,y-1},
        down = {x,y+1}}]]

function button(name, spacing, num) -- presses button and prints input
  local n, m
  if num ~= nil then n = num else n = 1 end
  if spacing ~= nil then m = spacing else m = 0 end
  repeat
  ta = {A=false, B=false, select=false, right=false, left=false, R=false, start=false, L=false, down=false, up=false}
  ta[name] = true
  joypad.set(1, ta)
  --print(name)
  vba.frameadvance()
  vba.message(name)
  n = n - 1
  skipframes(m)
  until n == 0
end

function skipframes(frames)
  --pauses the program for frames frames
j = vba.framecount();
i = 0;
while i<frames do
  i = vba.framecount()-j;
  vba.frameadvance();
end
end

function move_coordinate(coordinate_x, coordinate_y, direction)
  local output_coordinate = {coordinate_x, coordinate_y}
  if direction == 'right' then
    output_coordinate[1] = output_coordinate[1] + 1
  elseif direction == 'left' then
    output_coordinate[1] = output_coordinate[1] - 1
  elseif direction == 'down' then
    output_coordinate[2] = output_coordinate[2] + 1
  elseif direction == 'up' then
    output_coordinate[2] = output_coordinate[2] - 1
  end
  return output_coordinate
end

function reverse(direction)
  if direction == 'right' then return 'left'
  elseif direction == 'left' then return 'right'
  elseif direction == 'up' then return 'down'
  elseif direction == 'down' then return 'up'
  end
end

function coordinates_to_direction(previous, current)
  if current[1] == previous[1] - 1 then
    if current[2] == previous[2] then
     return 'right'
    end
  end
  if current[1] == previous[1] + 1 then
    if current[2] == previous[2] then
      return 'left'
    end
  end
  if current[2] == previous[2] + 1 then
    if current[1] == previous[1] then
      return 'down'
    end
  end
  if current[2] == previous[2] - 1 then
    if current[1] == previous[1] then
      return 'up'
    end
  end
  if current[2] == previous[2] and current[1] == previous[1] then 
    return 'no_change'
  end
  return 'other_change'
end

function coordinate_to_string(coordinate)
  if coordinate[3] ~= nil then
    return tostring(coordinate[1]) .. ' ' .. tostring(coordinate[2]) .. ' ' .. tostring(coordinate[3])
  else 
    return tostring(coordinate[1]) .. ' ' .. tostring(coordinate[2]) 
  end
end

function string_to_coordinate(string)--returns {z,y,x}
  coordinate = {}
  converted_coordinate = {}
  for word in string:gmatch("%w+") do table.insert(coordinate, word) end
  for i = 1,#coordinate do
    converted_coordinate[i] = tonumber(coordinate[i]) end
  return converted_coordinate
end

function table.contains(table, element)
  
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end
