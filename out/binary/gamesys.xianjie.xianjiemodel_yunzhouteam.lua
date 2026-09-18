






local _yunzhouDzLookup
local _yunzhouTeamDzLookup

function xianjieModel:clearData_yunzhouTeam()
self.yzDataList=nil
self.yzTeamDataList=nil
self.yzTeamDzFilterSortCondition=nil
self.yzTeamSoldierSelectList=nil
self.xjYzChuZhenTeamList=nil
self.xjDzOccupyTypeList=nil
self.xjYzLastChuZhenTeamData=nil
self.yzDataIsInit=nil
_yunzhouDzLookup={}
_yunzhouTeamDzLookup={}
end

function xianjieModel:initAllYunZhouTeamData()
if not self.yzDataIsInit then
self:clearData_yunzhouTeam()
self.yzDataIsInit=true
end
end



function xianjieModel:getXJYunZhouDataList()
if not self.yzDataList then

self:loadXJYunZhouDataList()
end
return self.yzDataList
end

function xianjieModel:getXJYunZhouDataByYzIdx(yzIdx)
if not self.yzDataList then
self:loadXJYunZhouDataList()
end

return self.yzDataList[yzIdx]
end

function xianjieModel:setXJYunZhouDataByYzIdx(yzIdx,data)
if not self.yzDataList then
self:loadXJYunZhouDataList()
end

local oldTeamList=self.yzDataList[yzIdx]and self.yzDataList[yzIdx].team or nil
if oldTeamList and next(oldTeamList)then
for posIdx,dzGuidStr in pairs(oldTeamList)do
_yunzhouDzLookup[dzGuidStr]=nil
end
end

self.yzDataList[yzIdx]=data

if data and data.team and next(data.team)then
for posIdx,dzGuidStr in pairs(data.team)do
_yunzhouDzLookup[dzGuidStr]={yzIdx=yzIdx,posIdx=posIdx}
end
end
end

function xianjieModel:setXJYunZhouDataTeamByYzIdx(yzIdx,teamList)
if not self.yzDataList then
self:loadXJYunZhouDataList()
end

if not self.yzDataList[yzIdx]then
self.yzDataList[yzIdx]={}
end

local oldTeamList=self.yzDataList[yzIdx].team
if oldTeamList and next(oldTeamList)then
for posIdx,dzGuidStr in pairs(oldTeamList)do
_yunzhouDzLookup[dzGuidStr]=nil
end
end

local list={}
if teamList~=nil and next(teamList)~=nil then
for posIdx,dzGuidStr in pairs(teamList)do
if UIDiscipleModel:isMyActorDZ(int64.new(dzGuidStr))then
list[posIdx]=dzGuidStr
end
end
end

if not next(list)then
self.yzDataList[yzIdx].team=nil
else
self.yzDataList[yzIdx].team=list

for posIdx,dzGuidStr in pairs(list)do
_yunzhouDzLookup[dzGuidStr]={yzIdx=yzIdx,posIdx=posIdx}
end
end
end

function xianjieModel:setXJYunZhouNameByYzIdx(yzIdx,name)
if not self.yzDataList then
self:loadXJYunZhouDataList()
end

if not self.yzDataList[yzIdx]then
self.yzDataList[yzIdx]={}
end
self.yzDataList[yzIdx].name=name
end

function xianjieModel:saveXJYunZhouDataList()
local saveData={}
if self.yzDataList and next(self.yzDataList)then
for yzIdx,data in pairs(self.yzDataList)do
local yzIdxStr=tostring(yzIdx)
local s_data={}
s_data.name=data.name
if data and data.team and next(data.team)then
local teamList=data.team
local list={}
for posIdx,dzGuidStr in pairs(teamList)do
local posIdxStr=tostring(posIdx)
list[posIdxStr]=dzGuidStr
end
s_data.team=list
end
saveData[yzIdxStr]=s_data
end






serverSaveController:send_254_102(SERVER_JSON_DATA_TYPE.eXJYZData,saveData)
end
end

function xianjieModel:loadXJYunZhouDataList()

local saveData=serverSaveModel:getJsonData(SERVER_JSON_DATA_TYPE.eXJYZData)or{}
local yzDataList={}
_yunzhouDzLookup={}
if saveData and tostring(saveData)~="userdata: NULL"and next(saveData)then
for yzIdxStr,data in pairs(saveData)do
local yzIdx=tonumber(yzIdxStr)
local s_data={}
s_data.name=data.name
if data and data.team and next(data.team)then
local teamList=data.team
local list={}
for posIdxStr,dzGuidStr in pairs(teamList)do
if UIDiscipleModel:isMyActorDZ(int64.new(dzGuidStr))then
local posIdx=tonumber(posIdxStr)
list[posIdx]=dzGuidStr

_yunzhouDzLookup[dzGuidStr]={yzIdx=yzIdx,posIdx=posIdx}
end
end
if next(list)~=nil then
s_data.team=list
end
end
yzDataList[yzIdx]=s_data
end
end
self.yzDataList=yzDataList
end

function xianjieModel:getXJYunZhouDataSelectLookUp()
if not _yunzhouDzLookup then
return{}
end
return _yunzhouDzLookup
end

function xianjieModel:removeXJYunZhouDataSelectDzByList(list)
if not self.yzDataList then
return
end

for _,v in ipairs(list)do
local yzIdx=v.yzIdx
local posIdx=v.posIdx
if self.yzDataList[yzIdx]and self.yzDataList[yzIdx].team then
local dzGuidStr=self.yzDataList[yzIdx].team[posIdx]
_yunzhouDzLookup[dzGuidStr]=nil
self.yzDataList[yzIdx].team[posIdx]=nil
if not next(self.yzDataList[yzIdx].team)then
self.yzDataList[yzIdx].team=nil
end
end
end
end

function xianjieModel:removeXJYunZhouDz(guid)
local delGuidStr=tostring(guid)
if not _yunzhouDzLookup or not _yunzhouDzLookup[delGuidStr]then
return
end
local yzIdx=_yunzhouDzLookup[delGuidStr].yzIdx
local posIdx=_yunzhouDzLookup[delGuidStr].posIdx
self.yzDataList[yzIdx].team[posIdx]=nil
if not next(self.yzDataList[yzIdx].team)then
self.yzDataList[yzIdx].team=nil
end

_yunzhouDzLookup[delGuidStr]=nil
end



function xianjieModel:getXJYunZhouTeamDataList()
if not self.yzTeamDataList then

self:loadXJYunZhouTeamDataList()
end
return self.yzTeamDataList
end

function xianjieModel:getXJYunZhouTeamDataByTeamIdx(teamIdx)
if not self.yzTeamDataList or not self.yzTeamDataList[teamIdx]then
return false
end
return self.yzTeamDataList[teamIdx]
end

function xianjieModel:setXJYunZhouTeamNameByTeamIdx(teamIdx,name)
if not self.yzTeamDataList then
self:loadXJYunZhouTeamDataList()
end

if not self.yzTeamDataList[teamIdx]then
self.yzTeamDataList[teamIdx]={}
end
self.yzTeamDataList[teamIdx].name=name
end

function xianjieModel:setXJYunZhouTeamDzListByTeamIdx(teamIdx,dzList)
if not self.yzTeamDataList then
self:loadXJYunZhouTeamDataList()
end

if not self.yzTeamDataList[teamIdx]then
self.yzTeamDataList[teamIdx]={}
end

local oldDzList=self.yzTeamDataList[teamIdx].dzList
if oldDzList and next(oldDzList)then
for posIdx,dzGuidStr in pairs(oldDzList)do
_yunzhouTeamDzLookup[dzGuidStr]=nil
end
end

local list={}
if dzList~=nil and next(dzList)~=nil then
for posIdx,dzGuidStr in pairs(dzList)do
if UIDiscipleModel:isMyActorDZ(int64.new(dzGuidStr))then
list[posIdx]=dzGuidStr
end
end
end

local idx=teamIdx
if list and next(list)then
self.yzTeamDataList[teamIdx].dzList=list
for posIdx,dzGuidStr in pairs(list)do
_yunzhouTeamDzLookup[dzGuidStr]={teamIdx=teamIdx,posIdx=posIdx}
end
else

table.remove(self.yzTeamDataList,teamIdx)
idx=nil
end

return idx
end

function xianjieModel:getXJYunZhouTeamSelectLookUp()
if not _yunzhouTeamDzLookup then
return{}
end

return _yunzhouTeamDzLookup
end


function xianjieModel:saveXJYunZhouTeamDataList()
local saveData={}
if self.yzTeamDataList and next(self.yzTeamDataList)then
for teamIdx,data in pairs(self.yzTeamDataList)do
local teamIdxStr=tostring(teamIdx)
local s_data={}
s_data.name=data.name
if data and data.dzList and next(data.dzList)then
local dzList=data.dzList
local list={}
for posIdx,dzGuidStr in pairs(dzList)do
local posIdxStr=tostring(posIdx)
list[posIdxStr]=dzGuidStr
end
s_data.dzList=list
end
saveData[teamIdxStr]=s_data
end

userActorArraySetting.set(ACTOR_SETTING_TYPE.eXJYunZhouTeam,'xjYzTeamDataList',saveData)

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXJYunZhouTeam)
end
end

function xianjieModel:loadXJYunZhouTeamDataList()
local saveData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXJYunZhouTeam,'xjYzTeamDataList',{})
local yzTeamDataList={}
_yunzhouTeamDzLookup={}
if next(saveData)then
for teamIdxStr,data in pairs(saveData)do
local teamIdx=tonumber(teamIdxStr)
local s_data={}
s_data.name=data.name
if data and data.dzList and next(data.dzList)then
local dzList=data.dzList
local list={}
for posIdxStr,dzGuidStr in pairs(dzList)do
if UIDiscipleModel:isMyActorDZ(int64.new(dzGuidStr))then
local posIdx=tonumber(posIdxStr)
list[posIdx]=dzGuidStr

_yunzhouTeamDzLookup[dzGuidStr]={teamIdx=teamIdx,posIdx=posIdx}
end
end
if next(list)~=nil then
s_data.dzList=list
end
end
yzTeamDataList[teamIdx]=s_data
end
end
self.yzTeamDataList=yzTeamDataList
end

function xianjieModel:removeXJYunZhouTeamDz(guid)
local delGuidStr=tostring(guid)
if not _yunzhouTeamDzLookup or not _yunzhouTeamDzLookup[delGuidStr]then
return
end
local teamIdx=_yunzhouTeamDzLookup[delGuidStr].teamIdx
local posIdx=_yunzhouTeamDzLookup[delGuidStr].posIdx
self.yzTeamDataList[teamIdx].dzList[posIdx]=nil
if not next(self.yzTeamDataList[teamIdx].dzList)then
table.remove(self.yzTeamDataList,teamIdx)
end

_yunzhouTeamDzLookup[delGuidStr]=nil
end


function xianjieModel:getXJYunZhouTeamDzFilterSortCondition()
if not self.yzTeamDzFilterSortCondition then
self.yzTeamDzFilterSortCondition={}
end
return self.yzTeamDzFilterSortCondition
end

function xianjieModel:setXJYunZhouTeamDzFilterSortCondition(sortCondition)
self.yzTeamDzFilterSortCondition=sortCondition
end


function xianjieModel:getXJYunZhouTeamSoldierSelectList(maxSelectCnt)
if not self.yzTeamSoldierSelectList then
self.yzTeamSoldierSelectList={}
end

if maxSelectCnt then
return self:getSoldierSelectListWithMaxSelectCnt(maxSelectCnt,self.yzTeamSoldierSelectList)
end

return self.yzTeamSoldierSelectList
end


function xianjieModel:getSoldierSelectListWithMaxSelectCnt(maxSelectCnt,soldierList)
if maxSelectCnt<=0 then
return{}
end

if not soldierList or not next(soldierList)then
return{}
end


local allSelectCnt=0
local selectList={}
local minLevel
local maxLevel
for soldierIdx,count in pairs(soldierList)do
if not minLevel or soldierIdx<minLevel then
minLevel=soldierIdx
end
if not maxLevel or soldierIdx>maxLevel then
maxLevel=soldierIdx
end
end

for soldierIdx=maxLevel,minLevel,-1 do
local count=soldierList[soldierIdx]
if count then
selectList[soldierIdx]=count
allSelectCnt=allSelectCnt+count
if allSelectCnt>=maxSelectCnt then
local delta=allSelectCnt-maxSelectCnt
selectList[soldierIdx]=selectList[soldierIdx]-delta
break
end
end
end

return selectList
end

function xianjieModel:setXJYunZhouTeamSoldierSelectList(selectList)
self.yzTeamSoldierSelectList=selectList
end

function xianjieModel:getXJYunZhouTeamChangeSoldierSelectList(originalSelectCnt,soldierIdxList,newSelectCnt,selectList,soldierCountList)
if not soldierCountList then
soldierCountList=yunjiayingModel:getSoldierCount(xjSoldierHurtType.eHealthy)
end

selectList=selectList or{}
local delta=newSelectCnt-originalSelectCnt
local allAddCount=0
local addCountList={}

local isAddZeroPercentNext=false
local loopCount=0
while delta~=0 do
originalSelectCnt=originalSelectCnt+allAddCount
local isUseZeroPercent=isAddZeroPercentNext
isAddZeroPercentNext=true
local percent_allSelectCnt=originalSelectCnt
if delta>0 then
for _,soldierIdx in ipairs(soldierIdxList)do
local count=soldierCountList[soldierIdx]or 0
local selectCount=selectList[soldierIdx]or 0
if addCountList[soldierIdx]then
selectCount=selectCount+addCountList[soldierIdx]
end
local remainingCount=count-selectCount
if remainingCount==0 then

percent_allSelectCnt=percent_allSelectCnt-selectCount
end
end

if percent_allSelectCnt==0 then

isUseZeroPercent=true
end
end

local originalDelta=delta
for _,soldierIdx in ipairs(soldierIdxList)do
local count=soldierCountList[soldierIdx]or 0
local selectCount=selectList[soldierIdx]or 0
if addCountList[soldierIdx]then
selectCount=selectCount+addCountList[soldierIdx]
end
local remainingCount=count-selectCount
if(delta>0 and remainingCount>0)or(delta<0 and selectCount>0)then

local percent_all=percent_allSelectCnt~=0 and selectCount/percent_allSelectCnt or 0
local addCount=math.floor(originalDelta*percent_all)
if percent_all==0 and isUseZeroPercent then
addCount=delta
elseif percent_all~=0 and originalDelta~=0 and addCount==0 then
addCount=delta
end

if addCount>0 and addCount>remainingCount then
addCount=remainingCount
elseif addCount<0 and addCount+selectCount<0 then
addCount=-selectCount
end

if addCount~=0 then
delta=delta-addCount
if not addCountList[soldierIdx]then
addCountList[soldierIdx]=0
end
addCountList[soldierIdx]=addCountList[soldierIdx]+addCount
selectCount=selectCount+addCount
allAddCount=allAddCount+addCount
end
end

local percent_self=count~=0 and selectCount/count or 0
if percent_self>0 and percent_self<1 then
isAddZeroPercentNext=false
end
if delta==0 then
break
end
end
if delta==0 then
break
end

loopCount=loopCount+1
if loopCount>20 then
return logErr("修士排布设置滑动条时循环超时 请检查前端代码")
end
end

for soldierIdx,addCount in pairs(addCountList)do
if not selectList[soldierIdx]then
selectList[soldierIdx]=addCount
else
selectList[soldierIdx]=selectList[soldierIdx]+addCount
end
end

return selectList
end




function xianjieModel:getXJFreeYzIndex()
local yzList=XianYunGangModel:getBoatList()or{}
for i,v in ipairs(yzList)do
local yzId=v.boatid
local chuZhengDzList=self:getXJYZChuZhenTeamList(yzId)
local isUsing=chuZhengDzList~=nil and next(chuZhengDzList)~=nil
if not isUsing then
return yzId
end
end

return nil
end


function xianjieModel:getXJFreeYzNum()
local yzList=XianYunGangModel:getBoatList()or{}
local num=0
for i,v in ipairs(yzList)do
local yzId=v.boatid
local chuZhengDzList=self:getXJYZChuZhenTeamList(yzId)
local isUsing=chuZhengDzList~=nil and next(chuZhengDzList)~=nil
if not isUsing then
num=num+1
end
end

return num
end

function xianjieModel:setXJYZChuZhenTeamList(yzIndex,dzList)
if not dzList or not next(dzList)then
return
end

if not self.xjYzChuZhenTeamList then
self.xjYzChuZhenTeamList={}
end
self.xjYzChuZhenTeamList[yzIndex]=dzList
end

function xianjieModel:removeXJYZChuZhenTeamList(yzIndex)
if not self.xjYzChuZhenTeamList then
return
end
local dzList=self.xjYzChuZhenTeamList[yzIndex]
if dzList then
for posIdx,guid in ipairs(dzList)do

self:setXJDzOccupyType(nil,guid)
end
end
self.xjYzChuZhenTeamList[yzIndex]=nil
end

function xianjieModel:getXJYZChuZhenTeamList(yzIndex)
if not self.xjYzChuZhenTeamList then
return nil
end
return self.xjYzChuZhenTeamList[yzIndex]
end

function xianjieModel:checkXJYunZhouIsFree(yzId)
local chuZhengDzList=xianjieModel:getXJYZChuZhenTeamList(yzId)
local isFree=chuZhengDzList==nil or next(chuZhengDzList)==nil
return isFree
end

function xianjieModel:checkXJYZChuZhenTeamResetYzData(yzIndex)
local dzList=self:getXJYZChuZhenTeamList(yzIndex)
if not dzList then

return
end

local teamList={}
local dzList_lookup={}
for posIdx,guid in ipairs(dzList)do
local guidStr=tostring(guid)
if not mathHelper.compareInt64(guid,Int64_0)then
teamList[posIdx]=guidStr
end
dzList_lookup[guidStr]=true
end

self:setXJYunZhouDataTeamByYzIdx(yzIndex,teamList)

















xianjieModel:saveXJYunZhouDataList()
end

function xianjieModel:setXJDzOccupyTypeList(occupyType,dzList)
if not dzList or not next(dzList)then
return
end

if not self.xjDzOccupyTypeList then
self.xjDzOccupyTypeList={}
end

for posIndex,guid in ipairs(dzList)do
local guidStr=tostring(guid)
self.xjDzOccupyTypeList[guidStr]=occupyType
end
end

function xianjieModel:setXJDzOccupyType(occupyType,guid)
if not self.xjDzOccupyTypeList then
self.xjDzOccupyTypeList={}
end

local guidStr=tostring(guid)
self.xjDzOccupyTypeList[guidStr]=occupyType
end


function xianjieModel:getDzXJOccupyType(dzGuid)
if not dzGuid or mathHelper.compareInt64(dzGuid,Int64_0)then
return nil
end

if self.xjDzOccupyTypeList then
local guidStr=tostring(dzGuid)
return self.xjDzOccupyTypeList[guidStr]
end

return nil
end


function xianjieModel:checkDzXJOccupy(dzGuid)

local dzState,stateStr=xianjieModel:getDZState(dzGuid,true)
if dzState then
return true
end
return false
end

function xianjieModel:getXJYZLastChuZhenTeamData()
if not self.xjYzLastChuZhenTeamData then
self:loadXJYZLastChuZhenTeamData()
end
return self.xjYzLastChuZhenTeamData
end


function xianjieModel:setXJYZLastChuZhenTeamData(yzIndex,soldierSelectList)
if not self.xjYzLastChuZhenTeamData then
self.xjYzLastChuZhenTeamData={}
end
self.xjYzLastChuZhenTeamData.yzIndex=yzIndex
self.xjYzLastChuZhenTeamData.soldierSelectList=soldierSelectList
end

function xianjieModel:saveXJYZLastChuZhenTeamData()
local saveData={}
if self.xjYzLastChuZhenTeamData and next(self.xjYzLastChuZhenTeamData)then
saveData.yzIndex=self.xjYzLastChuZhenTeamData.yzIndex
if self.xjYzLastChuZhenTeamData.soldierSelectList then
local list={}
for soldierId,count in pairs(self.xjYzLastChuZhenTeamData.soldierSelectList)do
local soldierIdStr=tostring(soldierId)
list[soldierIdStr]=count
end
saveData.soldierSelectList=list
end

userActorArraySetting.set(ACTOR_SETTING_TYPE.eXJYunZhouTeam,'xjYzLastChuZhenTeamData',saveData)

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXJYunZhouTeam)
end
end

function xianjieModel:loadXJYZLastChuZhenTeamData()
local saveData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXJYunZhouTeam,'xjYzLastChuZhenTeamData',{})
local yzLastChuZhenTeamData={}
yzLastChuZhenTeamData.yzIndex=saveData.yzIndex
if saveData.soldierSelectList and next(saveData.soldierSelectList)then
local list={}
for soldierIdStr,count in pairs(saveData.soldierSelectList)do
local soldierId=tonumber(soldierIdStr)
list[soldierId]=count
end
yzLastChuZhenTeamData.soldierSelectList=list
end
self.xjYzLastChuZhenTeamData=yzLastChuZhenTeamData
end


function xianjieModel:getXJFreeAndHasTeamYzIndex()
local yzList=XianYunGangModel:getBoatList()or{}
for i,v in ipairs(yzList)do
local yzId=v.boatid
local chuZhengDzList=self:getXJYZChuZhenTeamList(yzId)
local isUsing=chuZhengDzList~=nil and next(chuZhengDzList)~=nil
if not isUsing then
local yzData=self:getXJYunZhouDataByYzIdx(yzId)
if yzData and yzData.team and next(yzData.team)then
return yzId
end
end
end

return nil
end






function xianjieModel:getXJYZTeamFightValue(dzFightList,soldierList,jzAttrList,isMonster)
local teamFightValue=0

if dzFightList and next(dzFightList)then
for guidStr,fightValue in pairs(dzFightList)do
teamFightValue=teamFightValue+fightValue
end
end

if soldierList and next(soldierList)then
for soldierId,count in pairs(soldierList)do


local attrLookup={}

attrLookup[eAttributeType.eJZATK]=xianjieModel:getSoldierAttr(soldierId,xjSoldierAttr.atk)or 0
attrLookup[eAttributeType.eJZDEF]=xianjieModel:getSoldierAttr(soldierId,xjSoldierAttr.def)or 0
attrLookup[eAttributeType.eJZHP]=xianjieModel:getSoldierAttr(soldierId,xjSoldierAttr.hp)or 0

if jzAttrList and next(jzAttrList)then
local canAddJzAttrLookUp={
[eAttributeType.eJZATK]=true,
[eAttributeType.eJZATK_PCT]=true,
[eAttributeType.eJZDEF]=true,
[eAttributeType.eJZDEF_PCT]=true,
[eAttributeType.eJZHP]=true,
[eAttributeType.eJZHP_PCT]=true,
}


for attrId,value in pairs(jzAttrList)do
if canAddJzAttrLookUp[attrId]then
if attrLookup[attrId]then
attrLookup[attrId]=attrLookup[attrId]+value
else
attrLookup[attrId]=value
end
end
end
end

local trunAttrLookUp={}
local actor_exchange_mod=cfgHelper.getdef(cfg_jzconfig,"actor_exchange_mod")
local monster_exchange_mod=cfgHelper.getdef(cfg_jzconfig,"monster_exchange_mod")
local exchange_mod
if isMonster then
exchange_mod=monster_exchange_mod
else
exchange_mod=actor_exchange_mod
end

local ignoreAttrList={
[eAttributeType.eJZATK_PCT]=true,
[eAttributeType.eJZDEF_PCT]=true,
[eAttributeType.eJZHP_PCT]=true,
}
for attrId,value in pairs(attrLookup)do
if not ignoreAttrList[attrId]then
local finalValue=value
if attrId==eAttributeType.eJZATK then
local pct=attrLookup[eAttributeType.eJZATK_PCT]or 0
finalValue=finalValue*exchange_mod[1]*(1+pct)
elseif attrId==eAttributeType.eJZDEF then
local pct=attrLookup[eAttributeType.eJZDEF_PCT]or 0
finalValue=finalValue*exchange_mod[2]*(1+pct)
elseif attrId==eAttributeType.eJZHP then
local pct=attrLookup[eAttributeType.eJZHP_PCT]or 0
finalValue=finalValue*exchange_mod[3]*(1+pct)
end

trunAttrLookUp[attrId]=finalValue
end
end

local fightValue=cfgHelper.getFight(trunAttrLookUp)
teamFightValue=teamFightValue+fightValue*count
end
end

return teamFightValue
end


function xianjieModel:checkXJHasYunZhou()
local yzList=XianYunGangModel:getBoatList()or{}
local isHasYunZhou=#yzList>0
return isHasYunZhou
end


function xianjieModel:checkXJIsChuZheng(orderType,isWarning)
local orderCfg=xianjieModel:getOrderConfig(orderType)
local needYzType=orderCfg[1]
local isHasYunZhou=xianjieModel:checkXJHasYunZhou()
local isChuZheng=false
local isCanChuZheng=true
if needYzType==0 then

elseif needYzType==1 then

local freeYzIndex=xianjieModel:getXJFreeYzIndex()
local hasFreeYuZhou=freeYzIndex~=nil
if isHasYunZhou and hasFreeYuZhou then
isChuZheng=true
end
elseif needYzType==2 then

isChuZheng=true
if not isHasYunZhou then
if isWarning then
UIManager.error("当前没有可用云舟")
end
isCanChuZheng=false
end
end
return isChuZheng,isCanChuZheng
end

function xianjieModel:checkXJIsChuZhengEx(orderType,isWarning)
local orderCfg=xianjieModel:getOrderConfig(orderType)
local needYzType=orderCfg[1]
local isHasYunZhou=xianjieModel:checkXJHasYunZhou()
local isChuZheng=false
local isCanChuZheng=0
local tips=""
if needYzType==0 then

elseif needYzType==1 then

local freeYzIndex=xianjieModel:getXJFreeYzIndex()
local hasFreeYuZhou=freeYzIndex~=nil
if not isHasYunZhou and hasFreeYuZhou then
isChuZheng=true
end
elseif needYzType==2 then

isChuZheng=true
if not isHasYunZhou then
tips="当前暂无可用云舟"
if isWarning then
UIManager.error(tips)
end
isCanChuZheng=1
elseif not xianjieModel:getXJFreeYzIndex()then
tips="当前暂无空闲云舟"
if isWarning then
UIManager.error(tips)
end
isCanChuZheng=2
end
end
return isChuZheng,isCanChuZheng,tips
end



function xianjieModel:checkAndSetXJIsHasFirstTeam()

local yzList=XianYunGangModel:getBoatList()or{}
local isHasYunZhou=#yzList>0
if not isHasYunZhou then

return false
end


local minYzId
for i,v in ipairs(yzList)do
local yzId=v.boatid
local yzData=xianjieModel:getXJYunZhouDataByYzIdx(yzId)
if yzData and yzData.team and next(yzData.team)then

return false
else
if not minYzId or yzId<minYzId then
minYzId=yzId
end
end
end


local teamData=xianjieModel:getXJYunZhouTeamDataByTeamIdx(1)
if teamData and teamData.dzList and next(teamData.dzList)then

local dzList=teamData.dzList
local teamList={}
local dzList_lookup={}
for posIdx,guid in ipairs(dzList)do
local guidStr=tostring(guid)
if not mathHelper.compareInt64(guid,Int64_0)then
teamList[posIdx]=guidStr
end
dzList_lookup[guidStr]=true
end

self:setXJYunZhouDataTeamByYzIdx(minYzId,teamList)
else

local teamNum=5
local copyList={}
local selectList={}
local selectList_lookup={}
local teamPosType={
eFront=1,
eBack=2,
}
local teamPosTypeIndexLookup={
[1]=teamPosType.eFront,
[2]=teamPosType.eFront,
[3]=teamPosType.eBack,
[4]=teamPosType.eBack,
[5]=teamPosType.eBack,
}
local dzList=UIDiscipleModel:getAllDiscipleDataX()
for i=1,teamNum do
if not selectList[i]then
copyList={}
local posType=teamPosTypeIndexLookup[i]
for i2,locData in pairs(dzList)do
local netData=locData.netData.net
local dzguid=netData.discipleguid
local dzguid_str=netData.discipleguidStr

local dzState,stateStr=xianjieModel:getDZState(dzguid,true)
local isOccupy=dzState~=nil
if selectList_lookup[dzguid_str]==nil and not isOccupy then
local fight=UIDiscipleModel:getDiscipleFightValue(dzguid)
local job=UIDiscipleModel:getDiscipleJob(dzguid)
local pospriorty=UIDiscipleModel.getJobPosPriorty(job)
local priIdx=5
for ii,vv in ipairs(pospriorty)do
local posIdxType=teamPosTypeIndexLookup[vv]

if posIdxType==posType then
priIdx=ii
break
end
end
table.insert(copyList,{discipleguid=dzguid,discipleguidStr=dzguid_str,fight=fight,pospriorty=priIdx})
end
end
table.sort(copyList,function(a,b)
if a.pospriorty==b.pospriorty then
return a.fight>b.fight
else
return a.pospriorty<b.pospriorty
end
end)

local dizi=copyList[1]
if dizi then
selectList[i]=dizi.discipleguidStr
selectList_lookup[dizi.discipleguidStr]=i
end
end
end

self:setXJYunZhouDataTeamByYzIdx(minYzId,selectList)
self:setXJYunZhouTeamDzListByTeamIdx(1,selectList)
end

return true,minYzId
end



function xianjieModel:test_clearLocalSaveXJYZData()

serverSaveController:send_254_102(SERVER_JSON_DATA_TYPE.eXJYZData,nil)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eXJYunZhouTeam,'xjYzTeamDataList',nil)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eXJYunZhouTeam,'xjYzLastChuZhenTeamData',nil)

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXJYunZhouTeam)
self.yzDataList=nil
self.yzTeamDataList=nil
self.xjYzLastChuZhenTeamData=nil
end




function xianjieModel:checkSetXJIsHasFirstTeam()

local yzList=XianYunGangModel:getBoatList()or{}
local isHasYunZhou=#yzList>0
if not isHasYunZhou then

return false
end


local minYzId
for i,v in ipairs(yzList)do
local yzId=v.boatid
local yzData=xianjieModel:getXJYunZhouDataByYzIdx(yzId)
if yzData and yzData.team and next(yzData.team)then

return false
else
if not minYzId or yzId<minYzId then
minYzId=yzId
end
end
end


local teamData=xianjieModel:getXJYunZhouTeamDataByTeamIdx(1)
if teamData and teamData.dzList and next(teamData.dzList)then

local dzList=teamData.dzList
local teamList={}
local dzList_lookup={}
for posIdx,guid in ipairs(dzList)do
local guidStr=tostring(guid)
if not mathHelper.compareInt64(guid,Int64_0)then
teamList[posIdx]=guidStr
end
dzList_lookup[guidStr]=true
end


return true,teamList
else

local teamNum=5
local copyList={}
local selectList={}
local selectList_lookup={}
local teamPosType={
eFront=1,
eBack=2,
}
local teamPosTypeIndexLookup={
[1]=teamPosType.eFront,
[2]=teamPosType.eFront,
[3]=teamPosType.eBack,
[4]=teamPosType.eBack,
[5]=teamPosType.eBack,
}
local dzList=UIDiscipleModel:getAllDiscipleDataX()
for i=1,teamNum do
if not selectList[i]then
copyList={}
local posType=teamPosTypeIndexLookup[i]
for i2,locData in pairs(dzList)do
local netData=locData.netData.net
local dzguid=netData.discipleguid
local dzguid_str=netData.discipleguidStr

local dzState,stateStr=xianjieModel:getDZState(dzguid,true)
local isOccupy=dzState~=nil
if selectList_lookup[dzguid_str]==nil and not isOccupy then
local fight=UIDiscipleModel:getDiscipleFightValue(dzguid)
local job=UIDiscipleModel:getDiscipleJob(dzguid)
local pospriorty=UIDiscipleModel.getJobPosPriorty(job)
local priIdx=5
for ii,vv in ipairs(pospriorty)do
local posIdxType=teamPosTypeIndexLookup[vv]

if posIdxType==posType then
priIdx=ii
break
end
end
table.insert(copyList,{discipleguid=dzguid,discipleguidStr=dzguid_str,fight=fight,pospriorty=priIdx})
end
end
table.sort(copyList,function(a,b)
if a.pospriorty==b.pospriorty then
return a.fight>b.fight
else
return a.pospriorty<b.pospriorty
end
end)

local dizi=copyList[1]
if dizi then
selectList[i]=dizi.discipleguidStr
selectList_lookup[dizi.discipleguidStr]=i
end
end
end



return true,selectList
end
end