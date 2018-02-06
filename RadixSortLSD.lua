function convertnumbers(numbers) 
  local newlist = {}
  
  for i = 0, 9, 1 do
    for innerKey, value in pairs(numbers[i]) do
      table.insert(newlist, value)
    end
  end
  
  return newlist
end

function getMaxLen(toSort) 
  local highest = 0
  
  for key, value in pairs(toSort) do
    if (value > highest) then
      highest = value
    end
  end
  
  return highest
end


function sort(toSort, divisor, maxDivisor) 
  local numbers = {}
  for i = 0, 9, 1 do
    numbers[i] = {} --initialize every list
  end
  
  for key, value in pairs(toSort) do
    local digit = math.floor((value / divisor)) % 10
    print(digit)
    table.insert(numbers[digit], value)
  end
  
  local newlist = convertnumbers(numbers)
  if (divisor == maxDivisor) then
    return newlist
  end
  
 return sort(newlist, divisor * 10, maxDivisor)
end

function RadixSort(toSort)
  local highest = getMaxLen(toSort)
  highest = tostring(highest)
  local maxLen = #highest
  local maxDivisor = 10^maxLen
  print(maxDivisor)
  return sort(toSort, 1, maxDivisor)
end

unsortedList = { 123, 435, 456, 456, 456,234, 567, 876, 234, 2345, 5865, 1234 }
result = RadixSort(unsortedList)
print(table.concat(result, ", "))
