







helper={}


pairsBySortKey=function(t,f)
local a={}
for n in pairs(t)do a[#a+1]=n end
table.sort(a,f)
local i=0
return function()
i=i+1
return a[i],t[a[i]]
end
end











function helper.sortOrderComparis(va,vb,sortOrder)
if sortOrder==eSortOrder.eDown then
return va>vb
else
return va<vb
end
end



function helper.randomHitNumberRate(rate)
if rate<=0 then return false end
if rate>=1 then return true end
local h=rate/2
local min=(rate-h)*100
local max=(rate+h)*100
local r=math.random(1,100)
return r>=min and r<=max
end