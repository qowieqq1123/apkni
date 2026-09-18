





eventRelationChildControl=simple_class()
local _defineStr='event_relation_check_list_{0}'


function eventRelationChildControl:__init(relationType)
self.relationType=relationType
self.storeStr=FMT.fmt(_defineStr,relationType)
self:onAppStart()
end

function eventRelationChildControl:__delete()
self.relationType=nil
self.storeStr=nil
end

function eventRelationChildControl:onAppStart()

end

function eventRelationChildControl:onEnterState()
self:init()
end

function eventRelationChildControl:onLeaveState()
self:init()
end

function eventRelationChildControl:init()
self.logWait=false
self.isReadLocalList=nil
self.listNum=0
self.localDzList=nil
self.localDzLookup=nil
self.dzList={}
self.dzLookup={}
self.nextStamp=0
self.initStamp=nil
self.isRecvStamp=false
self.firstCricleFinish=false
self.isInit=false
self.isChange=false
end






function eventRelationChildControl:onRecvNextXiulian(shortStamp)
local stamp=timeHelper.convertLongStamp(shortStamp)
self.nextStamp=stamp
if self.initStamp==nil then
self.initStamp=stamp

local curStamp=timeHelper.getServerLongTime()
local minStamp=curStamp-90000
if self.initStamp<minStamp then
self.initStamp=minStamp
self.nextStamp=minStamp
loggerUtil.logErrFMT('关系事件下发时间戳太小：{0}',timeHelper.getFormatByStamp(stamp))
end
end

self.isRecvStamp=true
end


function eventRelationChildControl:update()
self:initDiziList()
self:logWaitTime()
self:dequeue()
end

function eventRelationChildControl:initDiziList()
if self:hasDzInList()then return end

local dizilist=UIDiscipleModel:getAllDiscipleDataX()
local hasDizi=dizilist~=nil
if not hasDizi then return end

self:readLocalData()

local num=0
local localDzList=self.localDzList
if not self.isReadLocalList and#localDzList>0 then
self.isReadLocalList=true
local flag=false
for i,v in pairs(localDzList)do
local diziguid=int64.new(v)
local ret=self:addDizi(diziguid)
flag=flag or ret
if ret then
num=num+1
end
end
if not self.isChange then
self.isChange=self:getChange(localDzList)
end
if flag==false then
self:log('关系事件 读取本地数据初始化，无弟子可加入列表')
else
self:log('关系事件 读取本地数据初始化，当前弟子数量：',num)
end
else
local flag=false
for i,v in pairs(dizilist)do
local diziguid=v.netData.net.discipleguid
local ret=self:addDizi(diziguid)
flag=flag or ret
if ret then
num=num+1
end
end
if flag==false then
self:log('关系事件 无弟子可加入列表')
else
self:log('关系事件 初始化列表，当前弟子数量：',num)
end
if not self.isChange then
self.isChange=self:getChange(localDzList)
end
self:freshLocalFile(true)
end
end

function eventRelationChildControl:getNextSpaceTime()
local num=eventRelationControl:getDiziLength()
if num==0 then return end
local relationType=self.relationType
local conf=eventConfig.getCommonConfig().relationconf[relationType]
local div=((num/conf[2])-1)*conf[3]
local space=math.floor((conf[1]+div)/num*60)
return space
end


function eventRelationChildControl:getDzList()
return self.dzList
end

function eventRelationChildControl:hasDzInList()
return#self.dzList>0
end

function eventRelationChildControl:addDizi(diziguid)
local diziInfo=eventRelationControl:getDizi(diziguid)
if not diziInfo then return false end
local dzLookup=self.dzLookup
local dzList=self.dzList
if dzLookup[tostring(diziguid)]then return end
dzList[#dzList+1]=diziguid
dzLookup[tostring(diziguid)]=#dzList
self.listNum=self.listNum+1
self:log(FMT.fmt('关系事件 轮询列表增加弟子:{0} 列表弟子数量：{1}',UIDiscipleModel:getDiscipleName(diziguid),self.listNum))
self:addLocalData(diziguid,false)
return true
end

function eventRelationChildControl:dequeueDizi(idx,remove)
local dzLookup=self.dzLookup
local dzList=self.dzList
local diziguid=dzList[idx]
if diziguid==nil then return end

if remove then
dzLookup[tostring(diziguid)]=nil
table.remove(dzList,idx)
self:removeLocalData(diziguid)
self.listNum=self.listNum-1
end
if not UIDiscipleModel:isZMDisciple(diziguid)then return end
self:log(FMT.fmt('关系事件 筛选出触发事件弟子:{0} 序号：{1} 列表弟子数量：{2}',tostring(UIDiscipleModel:getDiscipleName(diziguid)),idx,self.listNum))
return diziguid
end

function eventRelationChildControl:deleDizi(diziguid)
local dzLookup=self.dzLookup
local dzList=self.dzList
local guidStr=tostring(diziguid)
if not dzLookup[guidStr]then return end
local idx=dzLookup[guidStr]
dzLookup[guidStr]=nil
local len=#dzList
table.remove(dzList,idx)
self:removeLocalData(diziguid)
self.listNum=self.listNum-1
if len>#dzList then
self:log(FMT.fmt('关系事件 删除弟子:{0}  列表弟子数量：{1}',tostring(UIDiscipleModel:getDiscipleName(diziguid)),self.listNum))
end
end

function eventRelationChildControl:dequeue()
if not self.isRecvStamp then return end
if not self:hasDzInList()then

return
end
self:triggerEvent()
self.firstCricleFinish=true

end














function eventRelationChildControl:triggerEvent()
local stamp=timeHelper.getServerLongTime()
local nextStamp=self.nextStamp
if stamp<nextStamp then return end
local space=self:getNextSpaceTime()
if space==nil then return end
while stamp>=nextStamp do
local len=#self.dzList
if len<=0 then
if not self.firstCricleFinish then
self:initDiziList()
else break end
end
local idx=math.random(1,len)
local diziguid=self:dequeueDizi(idx,true)
if diziguid==nil then break end
local triggerArray=self:createTriggerInfo(diziguid,nextStamp)
if triggerArray then
eventTriggerContorl:enQueue(triggerArray)
nextStamp=nextStamp+space
self.nextStamp=nextStamp
end
end
end

function eventRelationChildControl:createTriggerInfo(diziguid,timeStamp)
if diziguid==nil then
self:log('关系事件 触发弟子guid为空')
return
end
if UIDiscipleModel:getDiscipleData(diziguid)==nil then
self:deleDizi(diziguid)
self:log('关系事件 弟子已死，无法触发')
return
end
local diziname=UIDiscipleModel:getDiscipleName(diziguid)
if UIDiscipleModel:checkInjuryType(diziguid,eInjuryType.eImminent)then
self:deleDizi(diziguid)
self:log(FMT.fmt('关系事件 弟子{0}频死，无法触发',diziname))
return
end
local objectguid=eventRelationControl:getOneDiziObject(diziguid,self.relationType)
if objectguid==nil then
self:log(FMT.fmt('关系事件 找不到关系改变弟子，无法触发',diziname))
objectguid=0

else
self:log(FMT.fmt('关系事件 弟子关系改变对象：',UIDiscipleModel:getDiscipleName(objectguid)))
end
local mainType=eventRelationControl.mainType
local subType=eventRelationControl.subType
local paramList={}
local triggerId=0
if objectguid~=0 then
local releation1Value=UIDiscipleModel:getReleationValue(diziguid,objectguid,self.relationType)
local childType1=UIDiscipleModel:getRelationChildType(self.relationType,releation1Value)
local sex1=UIDiscipleModel:getDiscipleSex(diziguid)

local releation2Value=UIDiscipleModel:getReleationValue(objectguid,diziguid,self.relationType)
local childType2=UIDiscipleModel:getRelationChildType(self.relationType,releation2Value)
local sex2=UIDiscipleModel:getDiscipleSex(objectguid)

triggerId=eventConfig.getRelationId(childType1,childType2,sex1,sex2)or 0
self:log('关系触发参数：',childType1,childType2,sex1,sex2,triggerId)
paramList=eventRelationControl:creatParamList(self.relationType,diziguid,objectguid)
else
self:log('没找到发生关系的弟子')
end
self:log(FMT.fmt('关系事件 弟子{0}触发关系事件，触发真实时间：{1}   {2}',diziname,timeHelper.getFormatByStamp(timeStamp),timeHelper.convertShortStamp(timeStamp)))
return eventTriggerModel.creatClientTriggerData(mainType,subType,triggerId,paramList,nil,timeStamp)
end

function eventRelationChildControl:freshNextStamp(stamp)
local space=self:getNextSpaceTime()
if space==nil then return end
local nextStamp=stamp+space
self:log(FMT.fmt('关系事件 弟子触发事件间隔 {0}',space))
self.nextStamp=nextStamp
end


function eventRelationChildControl:addLocalData(diziguid)
self:readLocalData()
local localDzList=self.localDzList
local localDzLookup=self.localDzLookup
local guidStr=tostring(diziguid)
if localDzLookup[guidStr]then return end
localDzLookup[guidStr]=true
localDzList[#localDzList+1]=guidStr
end

function eventRelationChildControl:removeLocalData(diziguid)
self:readLocalData()
local localDzList=self.localDzList
local localDzLookup=self.localDzLookup
local guidStr=tostring(diziguid)
if localDzLookup[guidStr]==nil then return end
localDzLookup[guidStr]=nil
for i,v in ipairs(localDzList)do
if v==guidStr then
table.remove(localDzList,i)
break
end
end
self.isChange=true
self:freshLocalFile(true)
end

function eventRelationChildControl:readLocalData()
if self.localDzList==nil or self.localDzLookup==nil then
self.localDzList={}
self.localDzLookup={}
local localDzList=self.localDzList
local localDzLookup=self.localDzLookup
local list=userActorArraySetting.get(ACTOR_SETTING_TYPE.eEvent,self.storeStr,{})
for i,v in ipairs(list)do
localDzList[#localDzList+1]=v
localDzLookup[v]=true
end
end
end

function eventRelationChildControl:freshLocalFile(canDelay)
if not self.isChange then return end
self.isChange=false
eventControl.freshLocalVal(self.storeStr,self.localDzList,canDelay)
end

function eventRelationChildControl:clearLocalFile()
eventControl.freshLocalVal(self.storeStr,nil,true)
end

function eventRelationChildControl:getChange(localDzList)
return table.isDiff(localDzList,self.localDzList)
end


function eventRelationChildControl:showInJianwenChannel(timeStamp)
return timeStamp and self.initStamp and timeStamp>=self.initStamp or false
end

function eventRelationChildControl:log(...)

end


function eventRelationChildControl:logWaitTime()












end
