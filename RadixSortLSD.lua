function convertnumbers(numbers) 
  local _numbers = {}
  
  for i = 0, 9, 1 do
    for innerKey, value in pairs(numbers[i]) do
      table.insert(_numbers, value)
    end
  end
  
  return _numbers
end

function getMaxVal(toSort) 
  local maxVal = 0
  
  for key, value in pairs(toSort) do
    if (value > maxVal) then
      maxVal = value
    end
  end
  
  return maxVal
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
  local maxVal = getMaxVal(toSort)
  maxVal = tostring(maxVal)
  local maxLen = #maxVal
  local maxDivisor = 10^(maxLen-1)
  print(maxDivisor)
  return sort(toSort, 1, maxDivisor)
end

unsortedList = { 123, 435, 456, 456, 456,234, 567, 876, 234, 2345, 5865, 1234, 23534262, 2342, 3125, 36243, 546 }
result = RadixSort(unsortedList)
print(table.concat(result, ", "))
