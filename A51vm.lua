LOAD = 0x1
MOVE = 0x2
MUL = 0x3
ADD = 0x4
HALT  = 0x5

function init()
  local instructions = assemble("code.a51")
  if (instructions ~= nil) then  
    local result = vmexec(instructions)
    print("count"..#result)
    for key, value in pairs(result) do
      print("Register: "..key)
      print("Value "..value)
    end
  end
end

function vmexec(opc)
  local registers = {}
  local pc = 1
  while (1) do
    if (opc[pc] == LOAD) then
      local reg_index = opc[pc + 1]
      local val = opc[pc + 2]
      registers[reg_index] = val
      pc = pc + 3
    elseif (opc[pc] == MOVE) then
      local reg_index1 = opc[pc + 1]
      local reg_index2 = opc[pc + 2]
      registers[reg_index1] = registers[reg_index2]
      pc = pc + 3
    elseif (opc[pc] == MUL) then
      local reg_index = opc[pc + 1]
      local factor = opc[pc + 2]
      registers[reg_index] = registers[reg_index] * factor
      pc = pc + 3
    elseif (opc[pc] == ADD) then
      local reg_index = opc[pc + 1]
      local summand = opc[pc + 2]
      registers[reg_index] = registers[reg_index] + summand
      pc = pc + 3
    elseif (opc[pc] == HALT) then
       return registers
    end
  end
end

function split(line, regex)
  local values = {}
  for value in string.gmatch(line, regex) do 
    table.insert(values, value)
  end
  
  return values
end

function is_operation(operation) 
  return (operation == "HALT" or operation == "ADD" or operation == "MUL" or operation == "MOVE" or operation == "LOAD")
end

function parse_line(line) 
  local args = split(line, "%S+")
  if (#args > 3) then
    return nil
  end  
  
  local operation = args[1]
  if (not is_operation(operation)) then
    return nil
  end
  
  local param1 = args[2]
  local param2 = args[3]
  
  if (operation == nil and (tonumber(param1) == nil or tonumber(param2) == nil)) then
    return nil
  end
  
  return operation, param1, param2
end


function assemble(file)
  local instructions = { }
  local lines = lines_from(file)
  local pc = 1
  local declared_registers = { }
  
  while (1) do
    local line = lines[pc]
    local operation, param1, param2 = parse_line(line)
    if (operation == "MOVE") then
      if (not declared_registers[param2]) then
        print("register not declared, line "..pc)
        return nil
      end
      
      table.insert(instructions, MOVE)
      table.insert(instructions, param1)
      table.insert(instructions, param2)
      if (not declared_registers[param1]) then
        declared_registers[param1] = true
      end
      
    elseif (operation == "ADD") then
      if (not declared_registers[param1]) then
        print("register not declared, line "..pc)
        return nil
      end
      
      table.insert(instructions, ADD)
      table.insert(instructions, param1)
      table.insert(instructions, param2)
    elseif (operation == "LOAD") then
      table.insert(instructions, LOAD)
      table.insert(instructions, param1)
      table.insert(instructions, param2)
      declared_registers[param1] = true
    elseif (operation == "MUL") then
      if (not declared_registers[param1]) then
        print("register not declared, line "..pc)
        return nil
      end
      
      table.insert(instructions, MUL)
      table.insert(instructions, param1)
      table.insert(instructions, param2)
    elseif (operation == "HALT") then
      table.insert(instructions, HALT)
      break
    else 
      print("operation not known, line "..pc)
      return nil
    end
    
    pc = pc + 1
  end
  
  return instructions
end

function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

function lines_from(file)
  if not file_exists(file) then return {} end
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end



init()
