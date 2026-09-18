





eventRelationControl=gameState.addListener({})
eventRelationControl.mainType=EVENT_TYPE.eNomal
eventRelationControl.subType=EVENT_NORMAL_SUB_TYPE.eDiziRelation

local _relationList
local _injectRelations

function eventRelationControl:onAppStart()
_relationList={
DISCIPLE_FRIEND_RELATION_TYEP.eQinmi,
DISCIPLE_FRIEND_RELATION_TYEP.eFriend,
DISCIPLE_FRIEND_RELATION_TYEP.eLengmo,
DISCIPLE_FRIEND_RELATION_TYEP.eYanwu,
DISCIPLE_FRIEND_RELATION_TYEP.eChoushi
}
_injectRelations=
{
DISCIPLE_RELATION_TYPE.eDaoLv,
DISCIPLE_RELATION_TYPE.eFamily,
DISCIPLE_RELATION_TYPE.eShiTu
}

self.refList={}
local refList=self.refList




local v=DISCIPLE_RELATION_TYPE.eFriend
refList[v]=eventRelationChildControl.new(v)


notifySystem:listenNotify(notifyConfig.onDiscipleInit,function(...)self:onDiziProInit(...)end)
notifySystem:listenNotify(notifyConfig.onDiscipleInjuryChange,function(...)self:onDiziInjuryChange(...)end)
notifySystem:listenNotify(notifyConfig.onDiscipleCreate,function(...)self:onDiziAdd(...)end)
notifySystem:listenNotify(notifyConfig.on_system_open,function(...)self:onSystemOpen(...)end)
socketManager:register_receiver(11,23,self.onRecvNextXiulian)
notifySystem:listenNotify(notifyConfig.onDiscipleStateChange,function(...)self:onDiscipleStateChange(...)end)
notifySystem:listenNotify(notifyConfig.onDiscipleRemove,function(...)self:onDiscipleRemove(...)end)
end

function eventRelationControl:onEnterState()
self:init()
eventRelationControl:invokeAllRefFunc('onEnterState')
end

function eventRelationControl:onLeaveState()
self:init()
eventRelationControl:invokeAllRefFunc('onLeaveState')
end

function eventRelationControl:init()
eventRelationControl:stopTimer()
self.systemOpen=false
self.isInitDiziData=false
self.isRecvStamp=false
self.dznum=nil
self.dznumDirty=nil
end




function eventRelationControl:onSystemInit()
if systemModel.isOpen(SYSTEM_DEFINE.eRelation)then
self.systemOpen=true

else

end
end





function eventRelationControl:onSystemOpen(sysid)
if SYSTEM_DEFINE.eRelation==sysid then
self.systemOpen=true

eventRelationControl:startTimer()
end
end

function eventRelationControl:onDiziProInit()
if self.isInitDiziData then return end
self.isInitDiziData=true
eventRelationControl:startTimer()
end

function eventRelationControl:onDiziAdd()
if eventRelationControl:getDiziLength()==1 then
eventRelationControl:invokeAllRefFunc('freshNextStamp',timeHelper.getServerLongTime())
end
end

function eventRelationControl:onDiscipleStateChange(guid,stateType,o,c)
if stateType==DISCIPLE_STATE_TYPE.eChuiWei then
self.dznumDirty=true
end
end

function eventRelationControl:onDiscipleRemove()
self.dznumDirty=true
end

function eventRelationControl:onDiziInjuryChange(diziguid)
if UIDiscipleModel:checkInjuryType(diziguid,eInjuryType.eImminent)then
for _,v in pairs(DISCIPLE_RELATION_TYPE)do
eventRelationControl:invokeRefFunc(v,'deleDizi',diziguid)
end
end
end

function eventRelationControl.onRecvNextXiulian(array)
local self=eventRelationControl
self.isRecvStamp=true
for _,v in pairs(DISCIPLE_RELATION_TYPE)do
eventRelationControl:invokeRefFunc(v,'onRecvNextXiulian',array[v])
end
eventRelationControl:startTimer()
end




function eventRelationControl:startTimer()
if not self.systemOpen then return end
if not self.isInitDiziData then return end
if not self.isRecvStamp then return end
if self.ticktimer then return end
self.ticktimer=timer.new()
self.ticktimer:start(0.07,function()
eventRelationControl:update()
end)
end

function eventRelationControl:stopTimer()
if self.ticktimer then
self.ticktimer:cancel()
end
self.ticktimer=nil
end

function eventRelationControl:update()
eventRelationControl:invokeAllRefFunc('update')
end

function eventRelationControl:invokeAllRefFunc(funname,...)
local refList=self.refList
for _,ref in pairs(refList)do
if ref and ref[funname]then
ref[funname](ref,...)
end
end
end

function eventRelationControl:invokeRefFunc(relationType,funname,...)
local ref=self.refList[relationType]
if ref and ref[funname]then
return ref[funname](ref,...)
end
end

function eventRelationControl:creatParamList(relationType,diziguid1,diziguid2)
return{relationType,diziguid1,diziguid2}
end

function eventRelationControl:getDiziID(paramList)
if paramList then
return paramList[2],paramList[3]
end
return nil
end

function eventRelationControl:handleParamListToTxt(paramList)
if paramList==nil then
logErr('关系事件没有找到任何参数')
return
end
local temp={}
local relationType=paramList[1]
local idx=1
for i=1,2 do
local diziguid=int64.new(tostring(paramList[idx+i]))
local diziInfo=UIDiscipleModel:getDiscipleData(diziguid)
local name=diziInfo.disciplename
local diziStr=FMT.fmt('dizi{0}',i)
temp[diziStr]={diziguid=diziguid,diziname=name}
end
return temp
end



function eventRelationControl:getDizi(diziguid)
local diziInfo=UIDiscipleModel:getDiscipleData(diziguid)
if diziInfo==nil or UIDiscipleModel:checkDiscipleState2(diziguid,DISCIPLE_STATE_TYPE.eChuiWei)then return end
return diziInfo
end

function eventRelationControl:getDiziLength()
if self.dznum==nil or self.dznumDirty~=false then
self.dznumDirty=false
local dizilist=UIDiscipleModel:getAllDiscipleDataX()
local hasDizi=dizilist~=nil
local num=0
if hasDizi then
for _,v in pairs(dizilist)do
local diziguid=v.netData.net.discipleguid
local diziInfo=eventRelationControl:getDizi(diziguid)
if diziInfo then
num=num+1
end
end
end
eventRelationChildControl:log(FMT.fmt('关系事件 弟子当前可以数量 {0}',num))
self.dznum=num
end
return self.dznum
end


function eventRelationControl:getOneDiziObject(diziguid,relationType)
local friendValueList=UIDiscipleModel:getRelationValueList(diziguid,relationType)
local dizilist={}
local meiliWei={}

local diziguidStr=tostring(diziguid)
mathHelper.randomSeed()
if friendValueList and#friendValueList>0 then
local weights=eventConfig.getCommonConfig().weights
local wei=table.deepCopy(weights)
local relationList=table.deepCopy(_relationList)
local index=mathHelper.weightRandom(wei)
while index do
local friendChildType=relationList[index]
for _,v in ipairs(friendValueList)do
local chType=UIDiscipleModel:getFriendRelationChildType(v[2])
local sub_diziguid=v[1]
local hasDZ=UIDiscipleModel:getDiscipleData(sub_diziguid)~=nil
if hasDZ and chType==friendChildType and diziguidStr~=tostring(sub_diziguid)then
dizilist[#dizilist+1]=sub_diziguid
meiliWei[#meiliWei+1]=UIDiscipleModel:getDiscipleBaseAttr(sub_diziguid,DISCIPLE_BASE_ATTR_TYPE.eMeiLi)
end
end
if#dizilist==0 then
table.remove(wei,index)
table.remove(relationList,index)
index=mathHelper.weightRandom(wei)
else
break
end
end
end

if#dizilist==0 then
local diziguidStr=tostring(diziguid)
local list=UIDiscipleModel:getAllDiscipleData()
for _,v in pairs(list)do
local sub_diziguid=v.netData.net.discipleguid
if diziguidStr~=tostring(sub_diziguid)and
not UIDiscipleModel:hasRelation(diziguid,sub_diziguid,_injectRelations)then
dizilist[#dizilist+1]=sub_diziguid
meiliWei[#meiliWei+1]=UIDiscipleModel:getDiscipleBaseAttr(sub_diziguid,DISCIPLE_BASE_ATTR_TYPE.eMeiLi)
end
end
end

if meiliWei and#meiliWei>0 then
local index=mathHelper.weightRandom(meiliWei)
if index then
return dizilist[index]
end
end
end

function eventRelationControl:showInJianwenChannel(timeStamp,paramList)
local relationType=paramList[1]
return eventRelationControl:invokeRefFunc(relationType,'showInJianwenChannel',timeStamp)
end