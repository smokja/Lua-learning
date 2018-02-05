function QuickSort(toSort)
  local length = #toSort
  local pivot = toSort[1]
  local right = {}
  local left = {}
  
  for i = 1 + 1, length, 1 do 
    if (toSort[i] > pivot) then 
      table.insert(right, toSort[i])
    else
      table.insert(left, toSort[i])
    end
  end  
  
  if (#left > 1) then
    left = QuickSort(left)
  end
  
  if (#right > 1) then
    right = QuickSort(right)
  end
  
  local newlist = {}
  for key, value in pairs(left) do 
    table.insert(newlist, value)
  end
  
  table.insert(newlist, pivot)
  
  for key, value in pairs(right) do 
    table.insert(newlist, value)
  end
  
  return newlist
end
