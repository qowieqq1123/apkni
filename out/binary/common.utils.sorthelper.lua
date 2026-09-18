sortHelper={}

function sortHelper.getSortLookup(list,func)
local sortList={}
local sortLookup={}
local sortIdxLookup={}
for i,v in ipairs(list)do
local val=func(v)or 0
if sortLookup[val]==nil then
sortLookup[val]=true
sortList[#sortList+1]=val
end
end
table.sort(sortList,function(a,b)
return a<b
end)
for i,val in ipairs(sortList)do
sortIdxLookup[val]=i
end
return sortIdxLookup,#sortList
end