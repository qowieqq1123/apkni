









local guildOrderAI_autoTreat={name='autoTreat'}
local _this
local _getWeightFunc={
[1]=function(dzguid,setup,baseWeight,selectParam)
local discipleguidStr=tostring(dzguid)
local selectFightRangeIndex=setup.fightRankSelectIndex
local rankRangeList=selectParam and selectParam.selectRange or{}
local nowMinRankNum=rankRangeList[selectFightRangeIndex]or 0
if not _this.discipleFightSortList or nowMinRankNum~=_this.minRankNum then
_this:refreshDiscipleFightSortList()
end

if _this.discipleFightSortList[discipleguidStr]then
local addWeight=_this.discipleFightSortList[discipleguidStr].addWeight
return baseWeight+addWeight
end
return-1
end,
[2]=function(dzguid,setup,baseWeight,selectParam)
local bdData=zongmenModel:getDiscipleWorkroom(dzguid)
if bdData then

local bd_cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
if selectParam.win_type then

if bd_cfg.win_type and bd_cfg.win_type==selectParam.win_type then
return baseWeight
end
end

if selectParam.bdType then

if bd_cfg.build_type==selectParam.bdType then
return baseWeight
end
end

if selectParam.bdTypeList then

if selectParam.bdTypeList[bd_cfg.build_type]then
return baseWeight
end
end
end
return-1
end,
[3]=function(dzguid,setup,baseWeight,selectParam)
local data=wudaotangModel:getDisDataByGuid(dzguid)
if data then

return baseWeight
end
return-1
end,
[4]=function(dzguid,setup,baseWeight,selectParam)
local data,world,index=chuanSongZhenModel:findDiscipleData(dzguid)
if data then

return baseWeight
end
return-1
end,
[5]=function(dzguid,setup,baseWeight,selectParam)
local postType=selectParam.postType
if postType then

local dzPost=UIDiscipleModel:getDisciplePost(dzguid)
if dzPost==postType then
return baseWeight
end
end
return-1
end,
[6]=function(dzguid,setup,baseWeight,selectParam)
local bdData=zongmenModel:getDiscipleWorkroom(dzguid)
if not bdData then

return baseWeight
end
return-1
end,
[7]=function(dzguid,setup,baseWeight,selectParam)

if douFaTaiModel:checkDiscipleInDefense(dzguid)then

return baseWeight
end


if lundaodahuiModel:isOpened()then
local myRank=lundaodahuiModel:getMyRank()or 0
if myRank>0 and lundaodahuiModel:isInTeam(dzguid)then

return baseWeight
end
end


local subActType=SUB_ACTIVITY_TYPE.eSectCompetition
local subActList=activitiesModel:getActSubList_subType_doing(subActType)
if subActList and next(subActList)then
local subActInfo=subActList[1]
local multipleTeams={}
for teamIdx=1,2 do
local defTeam=subActInfo:getDefTeamFive(teamIdx)or{}
multipleTeams[teamIdx]={}
for posIdx,dis_guid in ipairs(defTeam)do
if mathHelper.validInt64(dis_guid)and mathHelper.compareInt64(dzguid,dis_guid)then

return baseWeight
end
end
end
end

return-1
end,
}


function guildOrderAI_autoTreat:onInit()
_this=self
self.coolDownTime_winOpen=10
self.coolDownTime_check=30
self.onDiscipleCreate_callback=function(...)self:onDiscipleCreate(...)end
self.onDiscipleFightChanged_callback=function(...)self:onDiscipleCreate(...)end
notifySystem:listenNotify(notifyConfig.onDiscipleCreate,self.onDiscipleCreate_callback)
notifySystem:listenNotify(notifyConfig.onDiscipleFightChanged,self.onDiscipleFightChanged_callback)
end


function guildOrderAI_autoTreat:onDelete()
self.coolDownTime_winOpen=nil
self.checkTime=nil
self.coolDownTime_check=nil
notifySystem:removelistener(notifyConfig.onDiscipleCreate,self.onDiscipleCreate_callback)
notifySystem:removelistener(notifyConfig.onDiscipleFightChanged,self.onDiscipleFightChanged_callback)
self.onDiscipleCreate_callback=nil
self.onDiscipleFightChanged_callback=nil
_this=nil
end

function guildOrderAI_autoTreat:checkCond()

if UIManager:isActive('UIDiscipleSelectWin')or UIManager:isActive('UIDiscipleMainWin')
or UIManager:isActive('UIGuildOrderWin')
or UIManager:isActive('UIGuildOrderSetupWin_autoTreat')
or UIManager:isActive('UIDiscipleBatchZhiliaoWin')
or UIManager:isActive('UIDiscipleChuiweiWin')
or UIManager:isActive('UIFuncItemUseWin')then
return false
end
return true
end


function guildOrderAI_autoTreat:onUpdate()
local orderID=self.orderID
local setup,cfg=guildOrderModel:getSetupData(orderID)
if not setup.isOpen then
return guildOrderAIState.eClosed
end

if not self:checkCond()then

self:SetCoolDown(self.coolDownTime_winOpen)
return guildOrderAIState.eCond
end

if setup.useItemFlag>0 and setup.dzSelectFlag>0 then

local useItemCfgList=cfg.useItemList
local useItemSortList={}
local canUseCount=0
for i=1,#useItemCfgList do
local flag=bitHelper.check_pos(setup.useItemFlag,i-1)
if flag then
local data=useItemCfgList[i]
local itemId=data[1]
local itemCfg=itemsConfig.getConfig(itemId)
local itemColor=itemCfg.color
local itemCount=bagControl.invokeFuncByItemId(itemId,'getItemCountByItemID',itemId)
local item={
itemId=itemId,
itemColor=itemColor,
itemCount=itemCount,
}
table.insert(useItemSortList,item)
canUseCount=canUseCount+itemCount
end
end
if canUseCount>0 then

local dizilist=UIDiscipleModel:getAllDiscipleDataX()
local hasDizi=dizilist~=nil
local dzChuiWeiList={}
if hasDizi then
for _,v in pairs(dizilist)do
local diziguid=v.netData.net.discipleguid
if UIDiscipleModel:checkShouYuanChuiWeiType(diziguid)then
local weight=self:checkDiscipleTreatWeight(diziguid)
if weight>=0 then
local dzItem={
dzguid=diziguid,
weight=weight,
}
table.insert(dzChuiWeiList,dzItem)
end
end
end
end

if next(dzChuiWeiList)then

table.sort(useItemSortList,function(a,b)
return a.itemColor>b.itemColor
end)


table.sort(dzChuiWeiList,function(a,b)
return a.weight>b.weight
end)

local reqData={}
local useItemIdx=1
for i,v in ipairs(dzChuiWeiList)do
local useItem
local selectIdx
for i=useItemIdx,#useItemSortList do
if useItemSortList[i].itemCount>0 then
useItem=useItemSortList[i]
selectIdx=i
break
end
end

if useItem then
useItemIdx=selectIdx
local useItemId=useItem.itemId
useItem.itemCount=useItem.itemCount-1
reqData[#reqData+1]={v.dzguid,useItemId,1}
else
break
end
end

if next(reqData)then

bagProtocolControl.req_dizi_use_item_list(#reqData,reqData)
end
end
end
end


self:SetCoolDown(self.coolDownTime_check)
return guildOrderAIState.eReplay
end

function guildOrderAI_autoTreat:checkDiscipleTreatWeight(dzguid)
local orderID=self.orderID
local setup,cfg=guildOrderModel:getSetupData(orderID)
local selectDzCfgList=cfg.dzSelectList
local dzSelectFlag=setup.dzSelectFlag
local maxWeight=-1
for dataIndex,data in ipairs(selectDzCfgList)do
local dataId=data.id
local flag=bitHelper.check_pos(dzSelectFlag,dataId-1)
if flag then
local selectBaseWeight=data[2]
local selectType=data[3]
local selectParam=data[5]
if _getWeightFunc[selectType]then
local weight=_getWeightFunc[selectType](dzguid,setup,selectBaseWeight,selectParam)
if weight>maxWeight then
maxWeight=weight
end
end
end
end

return maxWeight
end


function guildOrderAI_autoTreat:refreshDiscipleFightSortList()
self.discipleFightSortList={}
self.minFightValue=nil
self.minRankNum=0
local orderID=self.orderID
local setup,cfg=guildOrderModel:getSetupData(orderID)
if not setup.isOpen then

return
end

local dataIndex=1
local isCheckFight=bitHelper.check_pos(setup.dzSelectFlag,dataIndex-1)
if not isCheckFight then

return
end
local selectFightRangeIndex=setup.fightRankSelectIndex
local rankRangeList=cfg.dzSelectList[dataIndex][5]and cfg.dzSelectList[dataIndex][5].selectRange or{}
self.minRankNum=rankRangeList[selectFightRangeIndex]or 0
if self.minRankNum<=0 then
return
end

local discipleList=discipleLookup:getSortDiscipleList(eDiscipleSortType.eFightSort,{},eSortOrder.eDown)
local discipleCount=#discipleList
local count=math.min(discipleCount,self.minRankNum)
for i=1,count do
local netData=discipleList[i].netData
local discipleguid=netData.net.discipleguid
local discipleguidStr=netData.net.discipleguidStr
local addWeight=self.minRankNum-i
self.discipleFightSortList[discipleguidStr]={
topIndex=i,
addWeight=addWeight,
discipleguid=discipleguid,
}
local dzFightValue=UIDiscipleModel:getDiscipleFightValue(discipleguid)
if not self.minFightValue or dzFightValue<self.minFightValue then
self.minFightValue=dzFightValue
end
end
end


function guildOrderAI_autoTreat:onDiscipleCreate(dis_guid)
local orderID=self.orderID
local setup,cfg=guildOrderModel:getSetupData(orderID)
if not setup.isOpen then

return
end

local dataIndex=1
local isCheckFight=bitHelper.check_pos(setup.dzSelectFlag,dataIndex-1)
if not isCheckFight then

return
end
local dzFightValue=UIDiscipleModel:getDiscipleFightValue(dis_guid)
if self.minFightValue and dzFightValue>=self.minFightValue then

self:refreshDiscipleFightSortList()
end
end


function guildOrderAI_autoTreat:onDiscipleFightChanged(diziguid,oldVal,newVal,optype)
local orderID=self.orderID
local setup,cfg=guildOrderModel:getSetupData(orderID)
if not setup.isOpen then

return
end

local dataIndex=1
local isCheckFight=bitHelper.check_pos(setup.dzSelectFlag,dataIndex-1)
if not isCheckFight then

return
end
if self.minFightValue then
local needRefresh=false
if oldVal<self.minFightValue and newVal>=self.minFightValue then
needRefresh=true
elseif oldVal>=self.minFightValue and newVal<self.minFightValue then
needRefresh=true
end

if needRefresh then

self:refreshDiscipleFightSortList()
end
end
end
return guildOrderAI_autoTreat