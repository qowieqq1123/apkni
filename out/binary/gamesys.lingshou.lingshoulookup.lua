







lingshouLookup={}


local table_insert=table.insert
local table_sort=table.sort

eLingShouSortType={
eFightSort=1,
eJingJieSort=2,
eColorSort=3,
eQianLi=4,
eZiZhi=5,
eFanYan=6,
eDaiShu=7,
eXueMai=8,


getLSSortList=function(self)
if self.getLSSortList_==nil then
self.getLSSortList_={self.eFightSort,self.eJingJieSort,self.eQianLi,self.eColorSort,self.eZiZhi,self.eXueMai}
end
return self.getLSSortList_
end,

getLSSortList2=function(self)
if self.getLSSortList2_==nil then
self.getLSSortList2_={self.eFightSort,self.eJingJieSort,self.eQianLi}
end
return self.getLSSortList2_
end,

getLSSortList3=function(self)
if self.getLSSortList3_==nil then
self.getLSSortList3_={self.eJingJieSort,self.eZiZhi,self.eFanYan}
end
return self.getLSSortList3_
end,

getLSSortList4=function(self)
if self.getLSSortList4_==nil then
self.getLSSortList4_={self.eJingJieSort,self.eFightSort,self.eColorSort}
end
return self.getLSSortList4_
end,

getLSSortList5=function(self)
if self.getSortList_==nil then
self.getSortList_={self.eQianLi,self.eJingJieSort,self.eFightSort,self.eColorSort}
end
return self.getSortList_
end,

getLSSortList6=function(self)
if self.getSortList_==nil then
self.getSortList_={self.eColorSort,self.eDaiShu,self.eZiZhi,self.eJingJieSort}
end
return self.getSortList_
end,

getLSSortList7=function(self)
if self.getLSSortList7_==nil then
self.getLSSortList7_={self.eFightSort,self.eJingJieSort,self.eQianLi,self.eColorSort}
end
return self.getLSSortList7_
end,

getLSSortList8=function(self)
if self.getLSSortList8_==nil then
self.getLSSortList8_={self.eJingJieSort,self.eDaiShu,self.eColorSort,self.eQianLi,self.eFightSort,self.eZiZhi,}
end
return self.getLSSortList8_
end,
}

eLingShouSortTypeName=
{
[eLingShouSortType.eFightSort]="战力",
[eLingShouSortType.eJingJieSort]="境界",
[eLingShouSortType.eColorSort]="品质",
[eLingShouSortType.eQianLi]="潜力",
[eLingShouSortType.eZiZhi]="资质",
[eLingShouSortType.eFanYan]="繁衍",
[eLingShouSortType.eDaiShu]="代数",
[eLingShouSortType.eXueMai]="血脉",

getName1=function(self,sortType)
return self[sortType]
end,
getName2=function(self,sortType)
return FMT.fmt("{0}顺序",self[sortType])
end,
getName2List=function(self)
local list={}
local temp=eLingShouSortType:getSortList()
for i,v in ipairs(temp)do
list[i]=self:getName2(v)
end
return list
end,
getName2List2=function(self,typelist)
local list={}
for i,v in ipairs(typelist)do
list[i]=self:getName2(v)
end
return list
end,
}

local sortFunctionLookup={
[eLingShouSortType.eFightSort]=function(result,sortTypeArgs,sortOrder,sortParams)
table_sort(result,function(a,b)
local va=lingshouModel:getFightValue(a.guid)
local vb=lingshouModel:getFightValue(b.guid)
return lingshouLookup:commonSortLingShou(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eLingShouSortType.eJingJieSort]=function(result,sortTypeArgs,sortOrder,sortParams)
table_sort(result,function(a,b)
local va=a.jj_lvl
local vb=b.jj_lvl
return lingshouLookup:commonSortLingShou(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eLingShouSortType.eColorSort]=function(result,sortTypeArgs,sortOrder,sortParams)
table_sort(result,function(a,b)
local va=lingshouModel:getColor(a.guid)
local vb=lingshouModel:getColor(b.guid)

if va~=vb then
if sortOrder==eSortOrder.eDown then
return va>vb
else
return va<vb
end
else
local fa=lingshouModel:getFightValue(a.guid)
local fb=lingshouModel:getFightValue(b.guid)
return lingshouLookup:commonSortLingShou(fa,fb,a,b,sortOrder,sortParams)
end

return lingshouLookup:commonSortLingShou(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eLingShouSortType.eQianLi]=function(result,sortTypeArgs,sortOrder,sortParams)
table_sort(result,function(a,b)
local va=lingshouModel.getLingShouPropertyVal(a,lingshouPropertyType.QIANLI)
local vb=lingshouModel.getLingShouPropertyVal(b,lingshouPropertyType.QIANLI)
return lingshouLookup:commonSortLingShou(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eLingShouSortType.eZiZhi]=function(result,sortTypeArgs,sortOrder,sortParams)
table_sort(result,function(a,b)
local va=lingshouModel.getLingShouPropertyVal(a,lingshouPropertyType.ZIZHI)
local vb=lingshouModel.getLingShouPropertyVal(b,lingshouPropertyType.ZIZHI)
return lingshouLookup:commonSortLingShou(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eLingShouSortType.eFanYan]=function(result,sortTypeArgs,sortOrder,sortParams)
table_sort(result,function(a,b)
local va=lingshouModel:getFanYanLeast(a.guid)
local vb=lingshouModel:getFanYanLeast(b.guid)
return lingshouLookup:commonSortLingShou(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eLingShouSortType.eDaiShu]=function(result,sortTypeArgs,sortOrder,sortParams)
table_sort(result,function(a,b)
local va=a.generation or 0
local vb=b.generation or 0
if va~=vb then
if sortOrder==eSortOrder.eDown then
return va>vb
else
return va<vb
end
else
local fa=lingshouModel:getFightValue(a.guid)
local fb=lingshouModel:getFightValue(b.guid)
return lingshouLookup:commonSortLingShou(fa,fb,a,b,sortOrder,sortParams)
end

return lingshouLookup:commonSortLingShou(va,vb,a,b,sortOrder,sortParams)
end)
end,
[eLingShouSortType.eXueMai]=function(result,sortTypeArgs,sortOrder,sortParams)
table_sort(result,function(a,b)
local va=a.xuemai_val or 0
local vb=b.xuemai_val or 0
if va~=vb then
if sortOrder==eSortOrder.eDown then
return va>vb
else
return va<vb
end
else
local fa=lingshouModel:getFightValue(a.guid)
local fb=lingshouModel:getFightValue(b.guid)
return lingshouLookup:commonSortLingShou(fa,fb,a,b,sortOrder,sortParams)
end

return lingshouLookup:commonSortLingShou(va,vb,a,b,sortOrder,sortParams)
end)
end,
}

LingShouFilterCNDType={
eBianYi=1,
eElement=2,
eRace=3,
eGeneration=4,
eState=5,
eColor=6,
eWordCount=7,
}
local filterCndFunctionLookup={
[LingShouFilterCNDType.eBianYi]=function(lsData,filterCondition)
local lscfg=lsData.cfg
for i1,v1 in ipairs(filterCondition)do
if v1==1 then

if lscfg.bianyi==0 then
return true
end
else

if lscfg.bianyi==1 then
return true
end
end
end
return false
end,
[LingShouFilterCNDType.eElement]=function(lsData,filterCondition)
local lscfg=lsData.cfg
for i1,v1 in ipairs(filterCondition)do
if lscfg.element==v1 then
return true
end
end
return false
end,
[LingShouFilterCNDType.eRace]=function(lsData,filterCondition)
local lscfg=lsData.cfg
for i1,v1 in ipairs(filterCondition)do
if lscfg.race==v1 then
return true
end
end
return false
end,
[LingShouFilterCNDType.eGeneration]=function(lsData,filterCondition)
for i1,v1 in ipairs(filterCondition)do
if lsData.generation and lsData.generation==v1 then
return true
end
end
return false
end,
[LingShouFilterCNDType.eState]=function(lsData,filterCondition)
local lsGuid=lsData.guid
local state=lingshouModel:getHighestStateType(lsGuid)
local cv=state==eLingShouStateType.petFree and 1 or 2
for i1,v1 in ipairs(filterCondition)do
if cv==v1 then
return true
end
end
return false
end,

[LingShouFilterCNDType.eColor]=function(lsData,filterCondition)
local lscfg=lsData.cfg
for i1,v1 in ipairs(filterCondition)do
if lscfg.color==v1 then
return true
end
end
return false
end,

[LingShouFilterCNDType.eWordCount]=function(lsData,filterCondition)
local wordList=lsData and lsData.wordList
local wordNum=wordList and#wordList or 0
for i1,v1 in ipairs(filterCondition)do
if wordNum==v1 then
return true
end
end
return false
end,
}








function lingshouLookup:getSortList(sortTypeArgs,filterCondition,sortOrder,sortParams)
local result={}
local alllingshou=lingshouModel:getLingShouDatas()
if alllingshou~=nil then
for guid,lsData in pairs(alllingshou)do
local lsID=lsData.id
local lscfg=cfgHelper.get1(cfg_lingshouconfig_get,lsID)
local add=true
if filterCondition~=nil then

if add and filterCondition[1]~=nil and#filterCondition[1]>0 then
local cndFunction=filterCndFunctionLookup[LingShouFilterCNDType.eBianYi]
add=cndFunction(lsData,filterCondition[1])
end


if add and filterCondition[2]~=nil and#filterCondition[2]>0 then
local cndFunction=filterCndFunctionLookup[LingShouFilterCNDType.eColor]
add=cndFunction(lsData,filterCondition[2])
end


if add and filterCondition[3]~=nil and#filterCondition[3]>0 then
local cndFunction=filterCndFunctionLookup[LingShouFilterCNDType.eElement]
add=cndFunction(lsData,filterCondition[3])
end


if add and filterCondition[4]~=nil and#filterCondition[4]>0 then
local cndFunction=filterCndFunctionLookup[LingShouFilterCNDType.eWordCount]
add=cndFunction(lsData,filterCondition[4])
end


if add and filterCondition[5]~=nil and#filterCondition[5]>0 then
local cndFunction=filterCndFunctionLookup[LingShouFilterCNDType.eRace]
add=cndFunction(lsData,filterCondition[5])
end
end
if add then
result[#result+1]=lsData
end
end
if#result>0 then
self:sortList(result,sortTypeArgs,sortOrder,sortParams)
end
end
return result
end

function lingshouLookup:getSortList2(reject_ls,sortCondition1,sortCondition1Type,sortCondition2,sortCondition2Type)
local reject_cb=function(lsData)
if reject_ls~=nil then
if mathHelper.compareInt64(lsData.guid,reject_ls)then
return true
end
end
return false
end
local sort_cb=function(a,b)
return a.color>b.color
end
return lingshouLookup:getSortList2Ex(sortCondition1,sortCondition1Type,sortCondition2,sortCondition2Type,reject_cb,sort_cb)
























































end

function lingshouLookup:getSortList2Ex(sortCondition1,sortCondition1Type,sortCondition2,sortCondition2Type,reject_cb,sort_cb)
local result={}
local lookup=lingshouModel:getLingShouDatas()
for k,lsData in pairs(lookup)do
local isReject=not reject_cb or reject_cb(lsData)
if not isReject then
local cur_color=lingshouModel:getColor(lsData.guid)
local add=true
local addx=true
if sortCondition1>0 then
addx=false
local floor=sortCondition1
local cur_floor=lingshouModel.getJJFloor(lsData.jj_lvl)
if sortCondition1Type==1 then
if cur_floor<=floor then
addx=true
end
else
if cur_floor==floor then
addx=true
end
end
add=add and addx
end
if sortCondition2>0 then
addx=false
local color=sortCondition2
if sortCondition2Type==1 then
if cur_color<=color then
addx=true
end
else
if cur_color==color then
addx=true
end
end
add=add and addx
end
if add then
local d={}
d.item=lsData
d.color=cur_color
table_insert(result,d)
end
end
if#result>0 then
if sort_cb then
table_sort(result,sort_cb)
end
end
end
return result
end


function lingshouLookup:getSortList3(sortTypeArgs,filterCondition,sortOrder,sortParams)
local result={}
local alllingshou=lingshouModel:getLingShouDatas()
if alllingshou~=nil then
for guid,lsData in pairs(alllingshou)do
local lsID=lsData.id
local lscfg=cfgHelper.get1(cfg_lingshouconfig_get,lsID)
local add=true
if filterCondition~=nil then

if filterCondition[1]~=nil and#filterCondition[1]>0 then
local cndFunction=filterCndFunctionLookup[LingShouFilterCNDType.eGeneration]
add=cndFunction(lsData,filterCondition[1])
end

if filterCondition[2]~=nil and#filterCondition[2]>0 then
local cndFunction=filterCndFunctionLookup[LingShouFilterCNDType.eBianYi]
add=cndFunction(lsData,filterCondition[2])
end

if filterCondition[3]~=nil and#filterCondition[3]>0 then
local cndFunction=filterCndFunctionLookup[LingShouFilterCNDType.eElement]
add=cndFunction(lsData,filterCondition[3])
end


if filterCondition[4]~=nil and#filterCondition[4]>0 then
local cndFunction=filterCndFunctionLookup[LingShouFilterCNDType.eRace]
add=cndFunction(lsData,filterCondition[4])
end
end
if add then
result[#result+1]=lsData
end
end
if#result>0 then
self:sortList(result,sortTypeArgs,sortOrder,sortParams)
end
end
return result
end
function lingshouLookup:getSortList4(sortTypeArgs,filterCondition,sortOrder,sortParams)
local result={}
local alllingshou=lingshouModel:getLingShouDatas()
if alllingshou~=nil then
for guid,lsData in pairs(alllingshou)do
local lsID=lsData.id
local lscfg=cfgHelper.get1(cfg_lingshouconfig_get,lsID)
local add=true
if filterCondition~=nil then

if filterCondition[1]~=nil and#filterCondition[1]>0 then
local cndFunction=filterCndFunctionLookup[LingShouFilterCNDType.eRace]
add=cndFunction(lsData,filterCondition[1])
end
end
if add then
result[#result+1]=lsData
end
end
if#result>0 then
self:sortList(result,sortTypeArgs,sortOrder,sortParams)
end
end
return result
end

function lingshouLookup:getSortList10(sortTypeArgs,filterCondition,sortOrder,sortParams)
local result={}
local alllingshou=lingshouModel:getLingShouDatas()
if alllingshou~=nil then
for guid,lsData in pairs(alllingshou)do
local lsID=lsData.id
local lsGuid=lsData.guid
local lscfg=cfgHelper.get1(cfg_lingshouconfig_get,lsID)
local add=true
if filterCondition~=nil then

if add and filterCondition[1]~=nil and#filterCondition[1]>0 then
local cndFunction=filterCndFunctionLookup[LingShouFilterCNDType.eState]
add=cndFunction(lsData,filterCondition[1])
end


if add and filterCondition[2]~=nil and#filterCondition[2]>0 then
local cndFunction=filterCndFunctionLookup[LingShouFilterCNDType.eGeneration]
add=cndFunction(lsData,filterCondition[2])
end


if add and filterCondition[3]~=nil and#filterCondition[3]>0 then
local cndFunction=filterCndFunctionLookup[LingShouFilterCNDType.eColor]
add=cndFunction(lsData,filterCondition[3])
end


if add and filterCondition[4]~=nil and#filterCondition[4]>0 then
local cndFunction=filterCndFunctionLookup[LingShouFilterCNDType.eElement]
add=cndFunction(lsData,filterCondition[4])
end


if add and filterCondition[5]~=nil and#filterCondition[5]>0 then
local cndFunction=filterCndFunctionLookup[LingShouFilterCNDType.eRace]
add=cndFunction(lsData,filterCondition[5])
end
end
if add then
result[#result+1]=lsData
end
end
if#result>0 then
self:sortList(result,sortTypeArgs,sortOrder,sortParams)
local selectable={}
local unselectable={}

for _,lsData in ipairs(result)do
local guid=lsData.guid
local canSelect=true

local state=lingshouModel:getHighestStateType(guid)
canSelect=(state==eLingShouStateType.petFree or state==eLingShouStateType.petBuild)

if canSelect then
selectable[#selectable+1]=lsData
else
unselectable[#unselectable+1]=lsData
end
end


local idx=1
for _,v in ipairs(selectable)do
result[idx]=v
idx=idx+1
end
for _,v in ipairs(unselectable)do
result[idx]=v
idx=idx+1
end
for i=idx,#result do
result[i]=nil
end
end
end
return result
end

function lingshouLookup:sortList(result,sortTypeArgs,sortOrder,sortParams)
if sortTypeArgs~=nil then
sortOrder=sortOrder or eSortOrder.eDown
local sortType
if type(sortTypeArgs)=='table'then
sortType=sortTypeArgs[1]
else
sortType=sortTypeArgs
end
local func=sortFunctionLookup[sortType]
if func then
func(result,sortTypeArgs,sortOrder,sortParams)
else
if sortParams then
if type(sortParams)=='function'then
sortParams(result,sortTypeArgs,sortOrder)
end
end
end
end
end

function lingshouLookup:getSortLsEquipList(sortTypeArgs,filterCondition,sortOrder,nowEquipLsGuid,isCheckDress)
local result={}
local alllingshou=lingshouModel:getLingShouDatas()
if alllingshou~=nil then
for guid,lsData in pairs(alllingshou)do
local lsID=lsData.id
local lscfg=cfgHelper.get1(cfg_lingshouconfig_get,lsID)
local add=true
local lsGuid=lsData.guid
if nowEquipLsGuid and mathHelper.compareInt64(lsGuid,nowEquipLsGuid)then
add=false
end
if add and isCheckDress then
local isDress=UIDiscipleModel:checkHasLingShouDZ(lsGuid)
if isDress then
add=false
end
end

if filterCondition~=nil then

if add and filterCondition[1]~=nil and#filterCondition[1]>0 then
local cndFunction=filterCndFunctionLookup[LingShouFilterCNDType.eElement]
add=cndFunction(lsData,filterCondition[1])
end

if add and filterCondition[2]~=nil and#filterCondition[2]>0 then
local cndFunction=filterCndFunctionLookup[LingShouFilterCNDType.eRace]
add=cndFunction(lsData,filterCondition[2])
end
end
if add then
result[#result+1]=lsData
end
end
if#result>0 then
self:sortList(result,sortTypeArgs,sortOrder)
end
end
return result
end

function lingshouLookup:commonSortLingShou(va,vb,a,b,sortOrder,sortParams)
sortParams=sortParams or{}
local check_a=0
local check_b=0
local lsData_a=a
local lsData_b=b
if sortParams[1]==true then

if lsData_a.isnew==true then check_a=check_a+100 end
if lsData_b.isnew==true then check_b=check_b+100 end
end

if sortParams[2]==true then

if lsData_a.follow_level>0 then check_a=check_a+10 end
if lsData_b.follow_level>0 then check_b=check_b+10 end
end

if check_a==check_b then
if va==vb then

local lsID_a=a.id
local lsID_b=b.id
local bianYiFlag_a=cfgHelper.get2(cfg_lingshouconfig_get,lsID_a,"bianyi")
local bianYiFlag_b=cfgHelper.get2(cfg_lingshouconfig_get,lsID_b,"bianyi")
local bianyiWeight_a=bianYiFlag_a==1 and 100 or 0
local bianyiWeight_b=bianYiFlag_b==1 and 100 or 0
return bianyiWeight_a>bianyiWeight_b
else
return helper.sortOrderComparis(va,vb,sortOrder)
end
else
return check_a>check_b
end
end


function lingshouLookup:getConditonFilter(sortCondition)
local c=1
local filterName={}
local filterFlag={}
filterName[c]={}
filterName[c][1]='变异'
filterName[c][2]={}
filterFlag[c]={}
local bylist={'无变异','变异'}
for i,v in ipairs(bylist)do
table.insert(filterName[c][2],{name=v,typeid=i})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,i)
table.insert(filterFlag[c],flag)
end

c=c+1
filterName[c]={}
filterName[c][1]='品质'
filterName[c][2]={}
filterFlag[c]={}
local colorlist={'紫','橙','红'}
local colorv={3,4,5}
for i,v in ipairs(colorlist)do
local typeid=colorv[i]
table.insert(filterName[c][2],{name=v,typeid=typeid})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,typeid)
table.insert(filterFlag[c],flag)
end

c=c+1
filterName[c]={}
filterName[c][1]='元素'
filterName[c][2]={}
filterFlag[c]={}
local elementList={}
local elementTypes=ELEMENT_TYPE:getFive()
for i,v in ipairs(elementTypes)do
local elementName=ELEMENT_TYPE.getName(v)
table.insert(elementList,{id=v,name=elementName})
end

for i,v in pairsBySortKey(elementList)do
if i>0 then
table.insert(filterName[c][2],{name=v.name,typeid=v.id})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,i)
table.insert(filterFlag[c],flag)
end
end

c=c+1
filterName[c]={}
filterName[c][1]='特质'
filterName[c][2]={}
filterFlag[c]={}
local countlist={'2','3','4','5'}
local countv={2,3,4,5}
for i,v in ipairs(countlist)do
local typeid=countv[i]
table.insert(filterName[c][2],{name=v,typeid=typeid})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,typeid)
table.insert(filterFlag[c],flag)
end

c=c+1
filterName[c]={}
filterName[c][1]='种族'
filterName[c][2]={}
filterFlag[c]={}
local racelist=cfg_lingshouraceconfig()
for i,v in pairsBySortKey(racelist)do
if i>0 then
table.insert(filterName[c][2],{name=v.name,typeid=v.id})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,i)
table.insert(filterFlag[c],flag)
end
end

return filterName,filterFlag
end

function lingshouLookup:getConditonFilter2(sortCondition)
local c=1
local filterName={}
local filterFlag={}
filterName[c]={}
filterName[c][1]='种族'
filterName[c][2]={}
filterFlag[c]={}
local racelist=cfg_lingshouraceconfig()
for i,v in pairsBySortKey(racelist)do
if i>0 then
table.insert(filterName[c][2],{name=v.name,typeid=v.id})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,i)
table.insert(filterFlag[c],flag)
end
end
return filterName,filterFlag
end

function lingshouLookup:getConditonFilter3(sortCondition)
local c=1
local filterName={}
local filterFlag={}
filterName[c]={}
filterName[c][1]='代数'
filterName[c][2]={}
filterFlag[c]={}
local dslist={'1代','2代'}
for i,v in ipairs(dslist)do
table.insert(filterName[c][2],{name=v,typeid=i})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,i)
table.insert(filterFlag[c],flag)
end

c=c+1
filterName[c]={}
filterName[c][1]='变异'
filterName[c][2]={}
filterFlag[c]={}
local bylist={'无变异','变异'}
for i,v in ipairs(bylist)do
table.insert(filterName[c][2],{name=v,typeid=i})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,i)
table.insert(filterFlag[c],flag)
end

c=c+1
filterName[c]={}
filterName[c][1]='元素'
filterName[c][2]={}
filterFlag[c]={}
local elementList={}
local elementTypes=ELEMENT_TYPE:getFive()
for i,v in ipairs(elementTypes)do
local elementName=ELEMENT_TYPE.getName(v)
table.insert(elementList,{id=v,name=elementName})
end
for i,v in pairsBySortKey(elementList)do
if i>0 then
table.insert(filterName[c][2],{name=v.name,typeid=v.id})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,i)
table.insert(filterFlag[c],flag)
end
end

c=c+1
filterName[c]={}
filterName[c][1]='种族'
filterName[c][2]={}
filterFlag[c]={}
local racelist=cfg_lingshouraceconfig()
for i,v in pairsBySortKey(racelist)do
if i>0 then
table.insert(filterName[c][2],{name=v.name,typeid=v.id})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,i)
table.insert(filterFlag[c],flag)
end
end
return filterName,filterFlag
end
function lingshouLookup:getConditonFilter4(sortCondition)

local c=0
local filterName={}
local filterFlag={}
local filterConflict={}

c=c+1
filterName[c]={}
filterName[c][1]='状态'
filterName[c][2]={}
filterFlag[c]={}
local bylist={'未安排','已安排'}
for i,v in ipairs(bylist)do
table.insert(filterName[c][2],{name=v,typeid=i})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,i)
table.insert(filterFlag[c],flag)
end


c=c+1
filterName[c]={}
filterName[c][1]='代数'
filterName[c][2]={}
filterFlag[c]={}
local dslist={'1代','2代'}
for i,v in ipairs(dslist)do
table.insert(filterName[c][2],{name=v,typeid=i})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,i)
table.insert(filterFlag[c],flag)
end

c=c+1
filterName[c]={}
filterName[c][1]='品质'
filterName[c][2]={}
filterFlag[c]={}
local bylist={'紫','橙','红'}
local bzv={3,4,5}
for i,v in ipairs(bylist)do
local typeid=bzv[i]
table.insert(filterName[c][2],{name=v,typeid=typeid})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,typeid)
table.insert(filterFlag[c],flag)
end

c=c+1
filterName[c]={}
filterName[c][1]='元素'
filterName[c][2]={}
filterFlag[c]={}
local elementList={}
local elementTypes=ELEMENT_TYPE:getFive()
for i,v in ipairs(elementTypes)do
local elementName=ELEMENT_TYPE.getName(v)
table.insert(elementList,{id=v,name=elementName})
end
for i,v in pairsBySortKey(elementList)do
if i>0 then
table.insert(filterName[c][2],{name=v.name,typeid=v.id})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,i)
table.insert(filterFlag[c],flag)
end
end

c=c+1
filterName[c]={}
filterName[c][1]='种族'
filterName[c][2]={}
filterFlag[c]={}
local racelist=cfg_lingshouraceconfig()
for i,v in pairsBySortKey(racelist)do
if i>0 then
table.insert(filterName[c][2],{name=v.name,typeid=v.id})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,i)
table.insert(filterFlag[c],flag)
end
end
return filterName,filterFlag,filterConflict
end

function lingshouLookup:getEquipLsListConditionFilter(sortCondition)
local c=1
local filterName={}
local filterFlag={}
filterName[c]={}
filterName[c][1]='元素'
filterName[c][2]={}
filterFlag[c]={}
local elementList={}
local elementTypes=ELEMENT_TYPE:getFive()
for i,v in ipairs(elementTypes)do
local elementName=ELEMENT_TYPE.getName(v)
table.insert(elementList,{id=v,name=elementName})
end

for i,v in pairsBySortKey(elementList)do
if i>0 then
table.insert(filterName[c][2],{name=v.name,typeid=v.id})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,i)
table.insert(filterFlag[c],flag)
end
end

c=c+1
filterName[c]={}
filterName[c][1]='种族'
filterName[c][2]={}
filterFlag[c]={}
local racelist=cfg_lingshouraceconfig()
for i,v in pairsBySortKey(racelist)do
if i>0 then
table.insert(filterName[c][2],{name=v.name,typeid=v.id})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,i)
table.insert(filterFlag[c],flag)
end
end

return filterName,filterFlag
end