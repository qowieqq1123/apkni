






local _MODULENAME="xjFactionNPCModel"


def_table(_MODULENAME)
xjFactionNPCModel.name=_MODULENAME
xjFactionNPCModel.data={}

eXJFactionNPCConditionType={
eNPCLevel=1,
eTaskFinish=2,
eMessageRecv=3,
eFactionLevel=4,
}

local _checkXJFactionNPCCondition={
[eXJFactionNPCConditionType.eNPCLevel]=function(typo,npcId,lv)
local total,level=xjFactionNPCModel:getNPCRelation(npcId)
if level<lv then
local npcCfg=cfgHelper.get1(cfg_xianjieshilijiaohunpcconfig_get,npcId)
local imageCfg=cfgHelper.get1(cfg_npcimageconfig_get,npcCfg.image)
local lvCfg=cfgHelper.get1(cfg_xianjieshilijiaohufeellevelconfig_get,lv)
return false,FMT.fmt("{0}亲密度达到{1}",imageCfg.name,lvCfg.name)
end
return true
end,
[eXJFactionNPCConditionType.eTaskFinish]=function(typo,taskId)
if not taskModel:checkTaskFinish(taskId)then
local taskCfg=taskModel:getTaskConfig(taskId)
return false,FMT.fmt("完成委托【{0}】",taskCfg.name)
end
return true
end,
[eXJFactionNPCConditionType.eMessageRecv]=function(typo,messageId)
if not xjFactionNPCModel:isMessageRecved(messageId)then
local cfg=cfgHelper.get1(cfg_xianjieshilijiaohuchatconfig_get,messageId)
return false,FMT.fmt("获取消息【{0}】",cfg.chat_name)
end
return true
end,
[eXJFactionNPCConditionType.eFactionLevel]=function(typo,factionId,lv)
local total,level=xjFactionNPCModel:getReputationValue(factionId)
if level<lv then
local factionCfg=cfgHelper.get1(cfg_xianjieforceconfig_get,factionId)
local lvCfg=cfgHelper.get1(cfg_xianjiefeellevelconfig_get,lv)
return false,FMT.fmt("{0}声望达到{1}",factionCfg.name,lvCfg.name)
end
return true
end,
}

eXJFactionNPCGiftCountLimitType={
eNone=0,
eForever=1,
eNPCLevel=2,
}

local _getXJFactionNPCGiftCountMax={
[eXJFactionNPCGiftCountLimitType.eNone]=function(npcID,args)
return-1
end,
[eXJFactionNPCGiftCountLimitType.eForever]=function(npcID,args)
return args
end,
[eXJFactionNPCGiftCountLimitType.eNPCLevel]=function(npcID,args)
local total,level=xjFactionNPCModel:getNPCRelation(npcID)
return args[level]or 0
end,
}

local _taskLine2NPC={}
local _message2NPC={}
local _npc2Faction={}
local _gift2NPC={}
local _unlock2Npc={}
local _defaultRelationData=nil

function xjFactionNPCModel:onAppStart()
self.npcRelationItem=cfgHelper.get2(cfg_xianjieshilijiaohuconstconfig_get,1,"npcRelationItem")
self.allFactionList={}
for i,v in pairs(xianjieForceType)do
table.insert(self.allFactionList,v)
end

local configs=cfg_xianjieshilijiaohunpcconfig()
for id,cfg in pairs(configs)do
if cfg.first_task then
local taskCfg=taskModel:getTaskConfig(cfg.first_task)
local task_line=taskCfg.tasklineid
_taskLine2NPC[task_line]=id
end

if cfg.chat then
for index,info in ipairs(cfg.chat)do
local message=info[1]
local temp=_message2NPC[message]or{}
table.insert(temp,id)
_message2NPC[message]=temp
end
end

for i,v in ipairs(cfg.recv_list)do
local itemId=v[1]
local temp=_gift2NPC[itemId]or{}
table.insert(temp,id)
_gift2NPC[itemId]=temp
end

if cfg.unlock_consume then
local itemId=cfg.unlock_consume[1]
local temp=_unlock2Npc[itemId]or{}
table.insert(temp,id)
_unlock2Npc[itemId]=temp
end
end

configs=cfg_xianjieforceconfig()
for id,cfg in pairs(configs)do
for index,npcId in ipairs(cfg.npc_list)do
_npc2Faction[npcId]=id
end
end

local total,level,expCur,expMax,over=self:calculateNPCRelation(0)
_defaultRelationData={total,level,expCur,expMax,over}
end


function xjFactionNPCModel:onEnterState(isReconnect)
self.factionDatas={}
self.npcDatas={}
self.messageDatas={}
end


function xjFactionNPCModel:onProtocolReq()
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)then return end


local npcs=self:getAllNPCData()
local taskLookup=taskModel:filterCurTaskLine()
for npcId,data in pairs(npcs)do
local cfg=cfgHelper.get1(cfg_xianjieshilijiaohunpcconfig_get,npcId)
if cfg and cfg.first_task then
if data.task<=0 then
taskModel:addNewTask(cfg.first_task)
else
local taskCfg=taskModel:getTaskConfig(data.task)
if taskCfg.nextid and not taskModel:hasTask(taskCfg.nextid)then
taskModel:addNewTask(taskCfg.nextid)
end
end
end
end
end


function xjFactionNPCModel:onLeaveState(isReconnect)

end



function xjFactionNPCModel:initNPCData(args)
table.clear(self.npcDatas)

local npcList=args[2]or defaultT
local relationList=args[4]or defaultT
local flagList=args[8]or defaultT
local itemsList=args[12]or defaultT
local taskList=args[14]or defaultT
local freeList=args[16]or defaultT

for _,npcId in ipairs(npcList)do
self:addNPCDataImp(npcId)
end

for _,relationData in ipairs(relationList)do
local npcId=relationData.npc_id
local npcData=self:getNPCData(npcId)
if npcData then
local relation=relationData.feel_val
local total,level,expCur,expMax,over=self:calculateNPCRelation(relation)
npcData.relation=total
npcData.level=level
npcData.expCur=expCur
npcData.expMax=expMax
npcData.over=over
end
end

for _,flagData in ipairs(flagList)do
local npcId=flagData.npc_id
local npcData=self:getNPCData(npcId)
if npcData then
local flag=flagData.feel_level_get
npcData.flag=flag
end
end

for _,itemsData in ipairs(itemsList)do
local npcId=itemsData.npc_id
local npcData=self:getNPCData(npcId)
if npcData then
for i=1,itemsData.npc_gift_info_len do
local data=itemsData.npc_gift_info_list[i]
local itemId=data.item_id
local count=data.gift_count
npcData.items[itemId]=count
end
end
end

for _,taskData in ipairs(taskList)do
local npcId=taskData.npc_id
local npcData=self:getNPCData(npcId)
if npcData then
npcData.task=taskData.task_id
end
end

for _,freeData in ipairs(freeList)do
local npcId=freeData.npc_id
local npcData=self:getNPCData(npcId)
if npcData then
npcData.free=freeData.daily_gift_feel_num
end
end
end

function xjFactionNPCModel:initFactionData(factionDatas)
local configs=cfg_xianjieforceconfig()
local paramA=cfgHelper.get2(cfg_xianjieshilijiaohuconstconfig_get,1,"transformed_arg")/10000
for id,cfg in ipairs(configs)do
local reputation=self:calculateFactionTotalRelation(cfg.npc_list)
reputation=paramA*reputation
local level,expCur,expMax=self:calculateFactionReputation(reputation)
local data=self:getFactionData(id)
if data then
data.flag=0
data.reputation=reputation
data.level=level
data.expCur=expCur
data.expMax=expMax
else
self.factionDatas[id]={
id=id,
flag=0,
reputation=reputation,
level=level,
expCur=expCur,
expMax=expMax,
}
end
end
if factionDatas then
for i,v in ipairs(factionDatas)do
local data=self:getFactionData(v.shili_id)
if data then
data.flag=v.feel_level_get
end
end
end
end

function xjFactionNPCModel:initMessageData(messageList)
table.clear(self.messageDatas)
if messageList then
for i,v in ipairs(messageList)do
self.messageDatas[v]=true
end
end
end

function xjFactionNPCModel:calculateNPCRelation(relation)
local configs=cfg_xianjieshilijiaohufeellevelconfig()
local max=configs[#configs].feel_num
if relation>=max then
return max,#configs,0,0,relation-max
else
local level,curStep,maxStep,last
for i,v in ipairs(configs)do
if relation>=v.feel_num then
level=i
maxStep=v.feel_num-(last or 0)
last=v.feel_num
else
curStep=relation-(last or 0)
maxStep=v.feel_num-(last or 0)
break
end
end
if not curStep then
curStep=0
maxStep=0
end
return relation,level,curStep,maxStep,0
end
end

function xjFactionNPCModel:calculateFactionReputation(total)
local configs=cfg_xianjiefeellevelconfig()
local level,curStep,maxStep,last
for i,v in ipairs(configs)do
if total>=v.feel_num then
level=i
maxStep=v.feel_num-(last or 0)
last=v.feel_num
else
curStep=total-(last or 0)
maxStep=v.feel_num-(last or 0)
break
end
end
if not curStep then
curStep=0
maxStep=0
end
return level,curStep,maxStep
end

function xjFactionNPCModel:calculateFactionTotalRelation(npcList)
local reputation=0
for index,npc in ipairs(npcList)do
local relation=self:getNPCRelation(npc)
reputation=reputation+relation
end
return reputation
end

function xjFactionNPCModel:addNPCDataImp(npcId)
local total,level,expCur,expMax,over=unpack(_defaultRelationData)
local data={
id=npcId,
flag=0,
relation=total,
level=level,
expCur=expCur,
expMax=expMax,
over=over,
items={},
task=0,
free=0,
}
self.npcDatas[npcId]=data
end

function xjFactionNPCModel:addNPCData(npcId)
self:addNPCDataImp(npcId)

local cfg=cfgHelper.get1(cfg_xianjieshilijiaohunpcconfig_get,npcId)
if cfg.first_task then
taskModel:addNewTask(cfg.first_task)
end
end

function xjFactionNPCModel:getReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)then return false end

local configs=cfg_xianjieforceconfig()
for id,cfg in ipairs(configs)do
if self:getFactionReddot(id)then
return true
end
end
return false
end

function xjFactionNPCModel:getFactionReddot(faction)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieShiLiJH)then return false end
if not xianjieModel:judeForceisOpen(faction)then return false end
if self:getReputationReddot(faction)then
return true
end
local cfg=cfgHelper.get1(cfg_xianjieforceconfig_get,faction)
for index,npc in ipairs(cfg.npc_list)do
if self:getNPCReddot(npc)then
return true
end
end
return false
end

function xjFactionNPCModel:getFactionData(faction)
return self.factionDatas[faction]
end

function xjFactionNPCModel:setFactionFlag(faction,flag)
local data=self:getFactionData(faction)
if data then
data.flag=flag
end
end

function xjFactionNPCModel:getReputationReddot(faction)
local data=self:getFactionData(faction)
if data then
local cfg=cfgHelper.get1(cfg_xianjieforceconfig_get,faction)
for i=data.flag+1,data.level do
local rewards=cfg.reward[i]
if rewards and#rewards>0 then
return true
end
end
return false
end
return false
end

function xjFactionNPCModel:getReputationValue(faction)
local data=self:getFactionData(faction)
if data then
return data.reputation,data.level,data.expCur,data.expMax
else
return 0,1,0,0
end
end

function xjFactionNPCModel:refreshReputation(faction)
local data=self:getFactionData(faction)
if data then
local oldlv=data.level
local cfg=cfgHelper.get1(cfg_xianjieforceconfig_get,faction)
local paramA=cfgHelper.get2(cfg_xianjieshilijiaohuconstconfig_get,1,"transformed_arg")/10000
local reputation=self:calculateFactionTotalRelation(cfg.npc_list)
reputation=paramA*reputation
local level,expCur,expMax=self:calculateFactionReputation(reputation)
data.reputation=reputation
data.level=level
data.expCur=expCur
data.expMax=expMax
return oldlv~=level
end
return false
end

function xjFactionNPCModel:getReputationFlag(faction)
local data=self:getFactionData(faction)
if data then
return data.flag
end
return 0
end

function xjFactionNPCModel:getAllNPCData()
return self.npcDatas
end

function xjFactionNPCModel:getNPCData(npcId)
return self.npcDatas[npcId]
end

function xjFactionNPCModel:setNPCFlag(npcId,flag)
local data=self:getNPCData(npcId)
if data then
data.flag=flag

local loop_cost=cfgHelper.get2(cfg_xianjieshilijiaohuconstconfig_get,1,"loop_cost")
data.over=data.over%loop_cost
end
end

function xjFactionNPCModel:getNPCFlag(npcId)
local data=self:getNPCData(npcId)
if data then
return data.flag
end
return 0
end

function xjFactionNPCModel:getNPCDailyFree(npcId)
local data=self:getNPCData(npcId)
if data then
return data.free
end
return 0
end

function xjFactionNPCModel:setNPCDailyFree(npcId,free)
local data=self:getNPCData(npcId)
if data then
data.free=free
end
end

function xjFactionNPCModel:clearNPCDailyFree()
for i,v in pairs(self.npcDatas)do
v.free=0
end
end

function xjFactionNPCModel:getNPCReddot(npcId)
if not self:isNPCLock(npcId)then
return self:haveNPCOverGift()or self:haveNPCGift(npcId)or self:getNPCTaskData(npcId)~=nil or self:getNPCGiftReddot(npcId)
elseif self:hasNPCEnoughVisitItem(npcId)then
return true
end
return false
end

function xjFactionNPCModel:getNPCRelation(npcId)
local data=self:getNPCData(npcId)
if data then
return data.relation,data.level,data.expCur,data.expMax
else
return _defaultRelationData[1],_defaultRelationData[2],_defaultRelationData[3],_defaultRelationData[4]
end
end

function xjFactionNPCModel:addNPCGiftCount(npcId,itemsList)
local data=self:getNPCData(npcId)
if data and itemsList then
for i,v in ipairs(itemsList)do
local itemid=v.item_id
local itemCnt=v.item_count
local oldValue=data.items[itemid]or 0
data.items[itemid]=oldValue+itemCnt
end
end
end

function xjFactionNPCModel:setNPCRelation(npcId,relation)
local data=self:getNPCData(npcId)
if data then
local loop_cost=cfgHelper.get2(cfg_xianjieshilijiaohuconstconfig_get,1,"loop_cost")
local oldLv=data.level
local oldOver=data.over>=loop_cost

local total,level,expCur,expMax,over=self:calculateNPCRelation(relation)
data.relation=total
data.level=level
data.expCur=expCur
data.expMax=expMax
data.over=over
local newOver=data.over>=loop_cost

if oldLv~=level then
local cfg=cfgHelper.get1(cfg_xianjieshilijiaohunpcconfig_get,npcId)
for i,v in ipairs(cfg.recv_list)do
local itemId=v[1]
local limit=v[3]
local limitType=limit[1]
if limitType==eXJFactionNPCGiftCountLimitType.eNPCLevel then
data.items[itemId]=nil
end
end
return true
elseif oldOver~=newOver then
return true
end
end
return false
end

function xjFactionNPCModel:getNPCMessages(npcId)
local cfg=cfgHelper.get1(cfg_xianjieshilijiaohunpcconfig_get,npcId)
local list={}
if cfg.chat then
for i,v in ipairs(cfg.chat)do
local id=v[1]
local cond=v[2]
local check=xjFactionNPCModel:checkConditionsEx(cond)
if check and not xjFactionNPCModel:isMessageRecved(id)then
table.insert(list,id)
end
end
end
return list
end

function xjFactionNPCModel:getNPCGifts(npcId)
local total,level=self:getNPCRelation(npcId)
local flag=self:getNPCFlag(npcId)
local cfg=cfgHelper.get1(cfg_xianjieshilijiaohunpcconfig_get,npcId)
local list={}
for i=flag+1,level do
local rewards=cfg.reward[i]
if rewards and#rewards>0 then
table.insert(list,i)
end
end
return list
end

function xjFactionNPCModel:haveNPCGift(npcId)
local total,level=self:getNPCRelation(npcId)
local flag=self:getNPCFlag(npcId)
local cfg=cfgHelper.get1(cfg_xianjieshilijiaohunpcconfig_get,npcId)
for i=flag+1,level do
local rewards=cfg.reward[i]
if rewards and#rewards>0 then
return true
end
end
return false
end

function xjFactionNPCModel:haveNPCOverGift(npcId)
local data=self:getNPCData(npcId)
if data then
local loop_cost=cfgHelper.get2(cfg_xianjieshilijiaohuconstconfig_get,1,"loop_cost")
return data.over>=loop_cost
end
return false
end

function xjFactionNPCModel:getNPCTaskData(npcId,exCheck)
local cfg=cfgHelper.get1(cfg_xianjieshilijiaohunpcconfig_get,npcId)
if cfg.first_task then
local taskCfg=taskModel:getTaskConfig(cfg.first_task)
local task_line=taskCfg.tasklineid
local taskData=taskModel:getTaskByLine(task_line)
if taskData and self:checkTaskShowEx(taskData,exCheck)then
return taskData
end
end
end

function xjFactionNPCModel:isNPCLock(npcId)
local data=self:getNPCData(npcId)
return data==nil
end

function xjFactionNPCModel:hasNPCEnoughVisitItem(npcId)
local cfg=cfgHelper.get1(cfg_xianjieshilijiaohunpcconfig_get,npcId)
if cfg.unlock_consume then
local itemId=cfg.unlock_consume[1]
local itemNeed=cfg.unlock_consume[2]
local count=itemsModel.getCount(itemId)
return count>=itemNeed
end
return false
end

function xjFactionNPCModel:isMessageRecved(message)
return self.messageDatas[message]or false
end

function xjFactionNPCModel:setMessageRecved(message)
self.messageDatas[message]=true
end

function xjFactionNPCModel:checkConditionsEx(condId,content)
local condCfg=cfgHelper.get1(cfg_xianjieshilijiaohucondconfig_get,condId)
if condCfg and condCfg.cond_val then
return self:checkConditions(condCfg.cond_val,content)
end
return true
end

function xjFactionNPCModel:checkConditions(condList,content)
for i,v in ipairs(condList)do
local typo=v[1]
local checkHandle=_checkXJFactionNPCCondition[typo]
if checkHandle then
local check,err=checkHandle(unpack(v))
if not check then
content=content or"需要{0}"
return false,FMT.fmt(content,err),i
end
else
loggerUtil.logErrFMT("没有实现的仙界势力条件类型：{0}",typo)
end
end
return true
end

function xjFactionNPCModel:getNPCGiftCount(npcId,itemId)
local data=self:getNPCData(npcId)
if data then
return data.items[itemId]or 0
else
return 0
end
end

function xjFactionNPCModel:getNPCGiftNumMax(npcId,limitType,limitArgs)
local handle=_getXJFactionNPCGiftCountMax[limitType]
if handle then
return handle(npcId,limitArgs)
else
loggerUtil.logErrFMT("没有实现仙界势力NPC赠礼次数限制类型{0}的处理",limitType)
end
end

function xjFactionNPCModel:getNPCGiftReddot(npcId)
local data=self:getNPCData(npcId)
local max=cfgHelper.get2(cfg_xianjieshilijiaohuconstconfig_get,1,"daily_feel_gift_limit")
if data and data.free<max then
local total,level,stepCur,stepMax=self:getNPCRelation(npcId)
if stepCur and stepMax and stepCur==stepMax then
return false
end
local config=cfgHelper.get1(cfg_xianjieshilijiaohunpcconfig_get,npcId)
for i,v in ipairs(config.recv_list)do
local itemId=v[1]
local condId=v[2]
local limit=v[3]
local haveCnt=itemsModel.getCount(itemId)
if haveCnt>0 then
local check=xjFactionNPCModel:checkConditionsEx(condId)
if check then
local count=data.items[itemId]or 0
local maxCnt=xjFactionNPCModel:getNPCGiftNumMax(npcId,limit[1],limit[2])
if maxCnt>=0 and count<maxCnt then
return true
end
end
end
end
end
return false
end

function xjFactionNPCModel:findNPCByTask(taskId)
local taskCfg=taskModel:getTaskConfig(taskId)
return self:findNPCByTaskLine(taskCfg.tasklineid)
end

function xjFactionNPCModel:findNPCByTaskLine(taskLine)
return _taskLine2NPC[taskLine]
end

function xjFactionNPCModel:findNPCListByMessage(message)
return _message2NPC[message]
end

function xjFactionNPCModel:findFactionByNpc(npcId)
return _npc2Faction[npcId]
end

function xjFactionNPCModel:findNPCByGiftItemId(itemId)
return _gift2NPC[itemId]
end

function xjFactionNPCModel:findNPCByUnlockItemId(itemId)
return _unlock2Npc[itemId]
end

function xjFactionNPCModel:checkTaskShow(taskId)
local taskData=taskModel:getTask(taskId)
if taskData then
return self:checkTaskShowEx(taskData)
end
return false
end

function xjFactionNPCModel:finishNPCTask(npcId,taskId)
local npcData=self:getNPCData(npcId)
if npcData and npcData.task==taskId then
local taskCfg=taskModel:getTaskConfig(npcData.task)
if taskCfg.nextid then
npcData.task=taskCfg.nextid
end
end
end

function xjFactionNPCModel:checkTaskShowEx(taskData,exCheck)
local taskState=taskModel:getTaskState_transfromstate(taskData)

if taskState==taskModel.taskRewardState or taskState==taskModel.taskDoingState then
return true

elseif taskState==taskModel.taskAcceptState then

local check=taskModel:fitAcceptCondition(taskData.taskid)
if check then
if exCheck==true or exCheck==nil then
check=xjFactionNPCModel:checkTaskAcceptExtraCondition(taskData.taskid)
if check then
return true
end
else
return true
end
end
end

return false
end

function xjFactionNPCModel:checkTaskAcceptExtraCondition(taskId,content)
local extraCfg=cfgHelper.get1(cfg_xianjieshilijiaohutaskconfig_get,taskId)
if extraCfg then
return xjFactionNPCModel:checkConditionsEx(extraCfg.accept_limit,content)
end
return true
end