LOAD = 0x15
MOVE = 0x16
MUL = 0x17
ADD = 0x18
HALT  = 0x19

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
      registers[reg_index2] = nil
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
