chatGGModel=gameState.addListener({})
local _data={}
local _key='gg_data'
local _dirty=false

function chatGGModel:onAppStart()
notifySystem:listenNotify(notifyConfig.loadActorSetting,self.onLoadActorSetting)
end

function chatGGModel:onEnterState()
timeEventController.addNormalTimerHandler(1,'chatGGModel',self)
end

function chatGGModel:onLeaveState()
timeEventController.removeNormalTimerHandler(1,'chatGGModel')
end

function chatGGModel:onNormalUpdate()
if _dirty then
_dirty=false
userActorSetting.flush(true)
end
end

function chatGGModel.onLoadActorSetting()
_data=userActorSetting.get(_key,{})
end


function chatGGModel.getJiazuLookup(array)
if array==nil or#array==0 then return{}end
local lookup={}
for i,v in ipairs(array)do
local info=array[i]
for ii,vv in ipairs(info.xzfamilyList or{})do
local idStr=FMT.fmt('{0}',vv.un_family_id)
lookup[idStr]=true
end
end
return lookup
end

function chatGGModel.initJiazuData(lookup)
_data.jiazu=lookup
chatGGModel.store()
end

function chatGGModel.changeJiazuData(id,flag)
if flag==nil then flag=false end
if _data.jiazu==nil then _data.jiazu={}end
local jiazu=_data.jiazu
local idStr=FMT.fmt('{0}',id)
local ret=jiazu[idStr]or false
if ret==flag then return false end
if flag then
jiazu[idStr]=true
chatGGControl.onJiaZuFresh()
else
jiazu[idStr]=nil
end
chatGGModel.store()
end

function chatGGModel.initJiazu(array)
local lookup1=chatGGModel.getJiazuLookup(array)
local lookup2=_data.jiazu
if chatGGModel.isChangeBool(lookup1,lookup2)then
chatGGControl.onJiaZuFresh()
end
_data.jiazu={}
chatGGModel.initJiazuData(lookup1)
end


function chatGGModel.initMonster(array)
local list1=chatGGModel.getMonsterList(array)
local list2=_data.monster
if chatGGModel.isChangeNumber(list1,list2)then
chatGGControl.onMonsterFresh()
end
_data.monster={}
chatGGModel.initMonsterData(list1)
end

function chatGGModel.getMonsterList(array)
if array==nil or#array==0 then return{}end
local list={}
if array then
for i,v in ipairs(array)do
local areaId=v.areaid
local monsterList=v.monList
for j,vv in ipairs(monsterList)do
local monsterId=vv.param_1
local key=FMT.fmt('{0}_{1}',areaId,monsterId)
list[#list+1]=key
end
end
end
return list
end

function chatGGModel.initMonsterData(list)
_data.monster=list
chatGGModel.store()
end

function chatGGModel.changeMonsterData(areaId,idx,monsterId,flag)
if idx==nil then return end
idx=tostring(idx)
if flag==nil then flag=false end
if _data.monster==nil then _data.monster={}end
local monster=_data.monster
local key=FMT.fmt('{0}_{1}',areaId,monsterId)
local val=-1
if flag then val=key end
if monster[idx]==val then return end
monster[idx]=val





if flag then
chatGGControl.onMonsterFresh()
end
chatGGModel.store()
end


function chatGGModel.initMijing(array)
local lookup1=chatGGModel.getMijingLookup(array)
local lookup2=_data.mijing
if chatGGModel.isChangeBool(lookup1,lookup2)then
chatGGControl.onMiJingFresh()
end
_data.mijing={}
chatGGModel.initMijingData(lookup1)
end

function chatGGModel.getMijingLookup(array)
if array==nil or#array==0 then return{}end
local lookup={}
if array then
for i,v in ipairs(array)do
if not(v.worldId==0 and v.worldX==0 and v.worldY==0 and v.worldZ==0)then
local idStr=FMT.fmt('{0}',v.id)
lookup[idStr]=true
end
end
end
return lookup
end

function chatGGModel.initMijingData(lookup)
_data.mijing=lookup
chatGGModel.store()
end

function chatGGModel.changeMijingData(id,flag)
if flag==nil then flag=false end
if _data.mijing==nil then _data.mijing={}end
local mijing=_data.mijing
local idStr=FMT.fmt('{0}',id)
local ret=mijing[idStr]or false
if ret==flag then return false end
if flag then
mijing[idStr]=true
chatGGControl.onMiJingFresh()
else
mijing[idStr]=nil
end
chatGGModel.store()
end



function chatGGModel.isChangeBool(lookup1,lookup2)
if lookup1==nil and lookup2==nil then return false end
if lookup1==nil and lookup2~=nil and next(lookup2)==true then return true end
if lookup2==nil and lookup1~=nil and next(lookup1)==true then return true end
lookup1=lookup1 or{}
lookup2=lookup2 or{}
for k,v in pairs(lookup1)do
local flag1=v or false
local flag2=lookup2[k]or false
if flag1~=flag2 then return true end
end
for k,v in pairs(lookup2)do
local flag1=v
local flag2=lookup1[k]
if flag1~=flag2 then return true end
end
return false
end

function chatGGModel.isChangeNumber(lookup1,lookup2)
if lookup1==nil and lookup2==nil then return false end
if lookup1==nil and lookup2~=nil and next(lookup2)==true then return true end
if lookup2==nil and lookup1~=nil and next(lookup1)==true then return true end
lookup1=lookup1 or{}
lookup2=lookup2 or{}
for k,v in pairs(lookup1)do
local flag1=v or-1
local flag2=lookup2[k]or-1
if flag1~=flag2 then return true end
end
for k,v in pairs(lookup2)do
local flag1=v or-1
local flag2=lookup1[k]or-1
if flag1~=flag2 then return true end
end
return false
end

function chatGGModel.store()
userActorSetting.set(_key,_data)
_dirty=true
end