





itemsSortHelper={}


local _idx=0
local getIdx=function()
_idx=_idx+1
return _idx
end


ITEM_SORT_COMPARE_TYPE=
{
eUpOrder=1,
eDownOrder=2,
eEquals=3,
}


ITEM_SORT_TYPE=
{
eItemid=getIdx(),
eColor=getIdx(),
eStage=getIdx(),
eElement=getIdx(),
eJingjie=getIdx(),
eNewFlag=getIdx(),
eBagType=getIdx(),
eType1=getIdx(),
eRare=getIdx(),
eXianMo=getIdx(),
}

COMPARE_RET=
{
eLess=1,
eEquals=2,
eGreater=3,
}



local _sortFunc={

[ITEM_SORT_TYPE.eColor]=function(...)
return itemsSortHelper.sortByColor(...)
end,

[ITEM_SORT_TYPE.eStage]=function(...)
return itemsSortHelper.sortByStage(...)
end,

[ITEM_SORT_TYPE.eElement]=function(...)
return itemsSortHelper.sortByElement(...)
end,

[ITEM_SORT_TYPE.eNewFlag]=function(...)
return itemsSortHelper.sortByNewFlag(...)
end,

[ITEM_SORT_TYPE.eType1]=function(...)
return itemsSortHelper.sortByType1(...)
end,

[ITEM_SORT_TYPE.eRare]=function(...)
return itemsSortHelper.sortByRare(...)
end,

[ITEM_SORT_TYPE.eXianMo]=function(...)
return itemsSortHelper.sortByXianMo(...)
end,
}







function itemsSortHelper.sort(item,sortRule)
local aNum=0
local totalCompareType=sortRule.sort
for i,v in ipairs(sortRule)do
local sortType=v[1]
local compareArgs=v[2]
assert(i<=4)
local multi=math.pow(100,5-i)
local value,flag=itemsSortHelper.getValue(sortType,item,compareArgs,totalCompareType)
if flag then
local abs=1000
if totalCompareType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
abs=-1000
end
aNum=aNum+abs*multi
end
aNum=aNum+value*multi
end
return aNum
end

function itemsSortHelper.getValue(sortType,item,compareArgs,totalCompareType)
if _sortFunc[sortType]then
return _sortFunc[sortType](item,compareArgs,totalCompareType)
else
loggerUtil.logErrFMT('没找到背包筛选类型的方法')
end
end




function itemsSortHelper.sortByColor(item1,compareArgs,totalCompareType)
return itemsConfig.getConfig(item1.itemid).color or 0
end

function itemsSortHelper.sortByStage(item1,compareArgs,totalCompareType)
return itemsConfig.getConfig(item1.itemid).stage or 0
end

function itemsSortHelper.sortByType1(item1,compareArgs,totalCompareType)
return itemsConfig.getConfig(item1.itemid).type1 or 0
end

function itemsSortHelper.sortByRare(item1,compareArgs,totalCompareType)
return(item1.itemData~=nil and item1.itemData.fin_rare_id~=0)and 1 or 0
end

function itemsSortHelper.sortByXianMo(item1,compareArgs,totalCompareType)
local isxmEquip=equipsHelper.getEquipXMTypebyItemid(item1.itemid)
return isxmEquip>0 and 1 or 0
end


function itemsSortHelper.sortByElement(item1,compareArgs,totalCompareType)
local itemid=item1.itemid
local elementTable=itemsConfig.getConfig(itemid).element
local isFabao=itemsConfig.isFabao(itemid)
local sortNum
local ret=nil
if compareArgs and compareArgs[1]==ITEM_SORT_COMPARE_TYPE.eEquals and elementTable then
if type(elementTable)=='number'then
local element=elementTable
if isFabao then
element=fabaoConfig.getElementTypeByAttrid(elementTable)
end
sortNum=element
ret=compareArgs[2]==element
elseif type(elementTable)=='table'then
for i,v in ipairs(elementTable)do
local element=fabaoConfig.getElementTypeByAttrid(v[1])
if element==compareArgs[2]then
sortNum=element
ret=true
break
end
end
end
end
if sortNum==nil then
if totalCompareType==ITEM_SORT_COMPARE_TYPE.eUpOrder then
sortNum=20
else
sortNum=-1
end
end
return sortNum,ret
end

function itemsSortHelper.sortByNewFlag(item1,compareArgs,totalCompareType)
local itemguid=item1.itemguid
local newflag=bagNewHelper.getNewFlag(itemguid)
local num=newflag and 1 or 0
return num
end




function itemsSortHelper.isChangedAfterSort(list1,list2)
if list1==nil then list1={}end
if list2==nil then list2={}end
if#list1~=#list2 then return true end
local temp1={}
local temp2={}
for i,v in ipairs(list1)do
temp1[#temp1+1]=tostring(v.itemguid)
end

for i,v in ipairs(list2)do
temp2[#temp2+1]=tostring(v.itemguid)
end

for i,v in ipairs(temp1)do
if v~=temp2[i]then
return true
end
end
return false
end

function itemsSortHelper.sortItemsArrayByColor(a,b)
local aColor=itemsConfig.getConfig(a).color
local bColor=itemsConfig.getConfig(b).color
if aColor==bColor then
return a>b
else
return aColor>bColor
end
end



function itemsSortHelper.getFightSort(list,func)
return sortHelper.getSortLookup(list,func)
end
