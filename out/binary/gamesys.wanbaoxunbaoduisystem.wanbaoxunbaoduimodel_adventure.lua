







function wanBaoXunBaoDuiModel:initChannelData()
local channelAllCfg=cfg_catchannelconfig()

self.channelDatas={}
self.showChannelDataList={}
self.showChannelNum=#channelAllCfg

for k,channelCfg in pairs(channelAllCfg)do
self:initChannelDataById(channelCfg.id)

table.insert(self.showChannelDataList,self.channelDatas[channelCfg.id])

local state
if channelCfg.consume~=nil then
if channelCfg.consume[1]==-1 then
state=WBXBD_Channel_STATE.tqlock
else
state=WBXBD_Channel_STATE.lock
end
else
state=WBXBD_Channel_STATE.idle
end

self.channelDatas[channelCfg.id].channel_state=state
end
end




function wanBaoXunBaoDuiModel:initChannelDataById(id)
self.channelDatas[id]={

channel_state=WBXBD_Channel_STATE.lock,
open_state=false,
channel_Id=id,
isShow=true,


employeeLen=0,
employeeList={},
reward={},


log={},


bt_num=0,
bt_state=WBXBD_BT_STATE.none,

server_data=nil,

start_time=0,
need_time=0,
base_exp_up=0,
base_other_up=0,
}
end




function wanBaoXunBaoDuiModel:resetChannelData(channel_id)
local data=self.channelDatas[channel_id]
if data.timer then
data.timer:cancel()
data.timer=nil
end


data.server_data=nil


data.task_Id=-1

data.employeeLen=0

data.employeeList={}

data.base_exp_up=0

data.base_other_up=0

data.spe_up=0



data.jwCatList=nil

data.jwRewardList=nil

data.intervalJW=0

data.jwUpdataNum=0

data.start_time=0
data.need_time=0
data.base_exp_up=0
data.base_other_up=0
end





function wanBaoXunBaoDuiModel:setChannelData(totalUnlockChannelNum,channelOpenList)
self.totalUnlockChannelNum=totalUnlockChannelNum
self.channelOpenList=channelOpenList or{}
if self.totalUnlockChannelNum>0 then
for k,v in pairs(self.channelOpenList)do
self.channelDatas[v].open_state=true
self.channelDatas[v].channel_state=WBXBD_Channel_STATE.idle
if not self.channelDatas[v].isShow then
self.showChannelNum=self.showChannelNum+1
end
end

wanBaoXunBaoDuiModel:sortChannelList()
end
end



function wanBaoXunBaoDuiModel:sortChannelList()
table.sort(self.showChannelDataList,function(ac,bc)
if ac.channel_state==bc.channel_state then
return ac.channel_Id<bc.channel_Id
else
return ac.channel_state>bc.channel_state
end
end)
end




function wanBaoXunBaoDuiModel:addChannel(channel_id)
self.channelOpenList[#self.channelOpenList+1]=channel_id

self.channelDatas[channel_id].open_state=true
self.channelDatas[channel_id].isShow=true
self.channelDatas[channel_id].channel_state=WBXBD_Channel_STATE.idle
self.channelDatas[channel_id].start_time=0
self.channelDatas[channel_id].isShow=true

self.totalUnlockChannelNum=self.totalUnlockChannelNum+1

wanBaoXunBaoDuiModel:sortChannelList()

notifySystem:postNotify(notifyConfig.onWanBaoXunBaoDuiUnlockChannel,channel_id)

wanBaoXunBaoDuiController:freshShipState(channel_id)
end




function wanBaoXunBaoDuiModel:getChannelDatas()
return self.channelDatas
end





function wanBaoXunBaoDuiModel:getChannelDataById(id)
return self.channelDatas[id]
end





function wanBaoXunBaoDuiModel:setDispatchingChannel(channel_num2,channelList)
self.adventureChannelNum=channel_num2
if self.adventureChannelNum>0 then
for k,channelData in pairs(channelList)do
self:setDispatchingChannelByInfo(channelData)
end
end
end



function wanBaoXunBaoDuiModel:updateAdventureChannelNum()
self.adventureChannelNum=0
for k,channelData in ipairs(self.showChannelDataList)do
if channelData.task_Id and channelData.task_Id>0 then
self.adventureChannelNum=self.adventureChannelNum+1
end
end
end




function wanBaoXunBaoDuiModel:getAdventureChannelNum()
self:updateAdventureChannelNum()
return self.adventureChannelNum
end




function wanBaoXunBaoDuiModel:getUnlockChannelNum()
return self.totalUnlockChannelNum
end





function wanBaoXunBaoDuiModel:addDispatchChannel(task_id,channel_id)

self.channelDatas[channel_id].task_Id=task_id
self.channelDatas[channel_id].channel_Id=channel_id
self.channelDatas[channel_id].channel_state=WBXBD_Channel_STATE.preparing

for k,v in pairs(self.adventureMapPointList)do
if v.id==task_id then
v.isUse=true
end
end
wanBaoXunBaoDuiModel:updateAdventureChannelNum()

wanBaoXunBaoDuiController:doProcessByChannelId(channel_id)

notifySystem:postNotify(notifyConfig.onWanBaoXunBaoDuiTakeTask,channel_id,task_id)
end





function wanBaoXunBaoDuiModel:addDispatchingChannel(channel_id,channelInfo)
self:setDispatchingChannelByInfo(channelInfo)

local callback=function()
UIManager:invokeUIMethod("UIWanBaoXunBaoDui_MainWin","initUI")
end

wanBaoXunBaoDuiController:finishDispatchByChannelId(channel_id)


notifySystem:postNotify(notifyConfig.onWanBaoXunBaoDuiGoAdventure,channel_id,callback)
end

local transformTable=function(t,typeName,valueName)
if t==nil then return t end

local temp={}
for k,v in pairs(t)do
if valueName then
temp[v[typeName]]=v[valueName]
else
temp[v[typeName]]=v
end
end
return temp
end




function wanBaoXunBaoDuiModel:setDispatchingChannelByInfo(info)
local temp=self.channelDatas[info.channel_id]

temp.server_data=info

temp.open_state=true

temp.task_Id=info.id

temp.channel_Id=info.channel_id

temp.employeeLen=info.cat_num

temp.employeeList=info.catList or{}

temp.base_exp_up=info.base_exp_up/100

temp.base_other_up=info.base_other_up/100

temp.spe_up=info.spe_up/10000



temp.jwCatList=transformTable(info.jwCatList,'param_1','param_2')

temp.jwRewardList=transformTable(info.jwRewardList,'id')

temp.intervalJW=info.need_time/(Mathf.Max(info.jw_num,1))

temp.jwUpdataNum=0

temp.start_time=info.start_time
temp.need_time=info.need_time
temp.base_exp_up=info.base_exp_up
temp.base_other_up=info.base_other_up


temp.sendTick=nil


if temp.timer then
temp.timer:cancel()
temp.timer=nil
end

if temp.employeeLen>0 then
for index=1,temp.employeeLen do
local guid=temp.employeeList[index]

self.workingEmployees[guid]=temp.channel_Id
end
end

wanBaoXunBaoDuiModel:freshChannelState(temp.channel_Id)
end




function wanBaoXunBaoDuiModel:freshChannelState(channel_id)
local temp=self.channelDatas[channel_id]
local info=temp.server_data


local curServerTime=timeHelper.getServerShortTime()
if info~=nil then
if info.start_time==0 then
if temp.task_Id~=-1 then
temp.channel_state=WBXBD_Channel_STATE.preparing
else
temp.channel_state=WBXBD_Channel_STATE.idle
end
elseif info.total_time>0 and info.need_time==info.total_time then
temp.channel_state=WBXBD_Channel_STATE.finish
elseif info.total_time>0 and info.need_time>info.total_time then
temp.channel_state=WBXBD_Channel_STATE.early_return
elseif curServerTime>=info.start_time+info.need_time then


wanBaoXunBaoDuiController:reqEarlyReturn(temp.channel_Id,WBXBD_Adventure_Return_Type.return_finish)
elseif info.start_time+info.need_time>curServerTime then
wanBaoXunBaoDuiModel:setAdventureTimer(temp)
end
end
end




function wanBaoXunBaoDuiModel:checkChannelFinish(channel_id)
local temp=self.channelDatas[channel_id]

local info=temp.server_data
if info then
local curServerTime=timeHelper.getServerShortTime()
if curServerTime>=info.start_time+info.need_time then
wanBaoXunBaoDuiController:reqEarlyReturn(temp.channel_Id,WBXBD_Adventure_Return_Type.return_finish)
end
end
end




function wanBaoXunBaoDuiModel:setAdventureTimer(data)
if data.timer then
data.timer:cancel()
data.timer=nil
end
local const_def=self:getConstDef()
data.rewardShiftCount=0
data.timer=timer.new()
data.spend_time=wanBaoXunBaoDuiModel:getAdventureSpendTime(data.channel_Id)

local func=function()
data.spend_time=wanBaoXunBaoDuiModel:getAdventureSpendTime(data.channel_Id)


local num=wanbaoXunBaoDuiHelper:FloorProtect(data.spend_time/const_def.reward_time)
if data.rewardShiftCount~=num then
UIManager:invokeUIMethod('UIWanBaoXunBaoDui_MainWin','freshRewardDisplay')
data.rewardShiftCount=num
end

local jwnum=wanbaoXunBaoDuiHelper:FloorProtect(data.spend_time/data.intervalJW)
if data.jwUpdataNum~=jwnum then
wanBaoXunBaoDuiModel:updateJWLog(data)
data.jwUpdataNum=jwnum
end

if data.spend_time>=data.need_time then

data.timer:cancel()
data.timer=nil
wanBaoXunBaoDuiController:reqEarlyReturn(data.channel_Id,WBXBD_Adventure_Return_Type.return_finish)


end
end
data.timer:start(1,func,-1)
func()
data.channel_state=WBXBD_Channel_STATE.doing
end





function wanBaoXunBaoDuiModel:getAdventureSpendTime(channel_id)

local channelData=self.channelDatas[channel_id]
local curServerShortTime=timeHelper.getServerShortTime()
local spendTime=curServerShortTime-channelData.start_time
spendTime=Mathf.Min(spendTime,channelData.need_time)
if channelData.channel_state==WBXBD_Channel_STATE.done or channelData.channel_state==WBXBD_Channel_STATE.finish then
spendTime=channelData.need_time
end

return spendTime
end




function wanBaoXunBaoDuiModel:createJWLog(channel_data)
channel_data.log={}

local spendTime=wanBaoXunBaoDuiModel:getAdventureSpendTime(channel_data.channel_Id)
local jwnum=wanbaoXunBaoDuiHelper:FloorProtect(spendTime/channel_data.intervalJW)

for index=1,jwnum do
local jwid=channel_data.server_data.jwList[index]
local jwCfg=cfgHelper.get1(cfg_catadventurelogconfig_get,jwid)

local jwtype=jwCfg.rewards[1]
local catList
local itemList
local exp
if channel_data.server_data.jw_cat_num>0 then
catList=channel_data.jwCatList[jwid]
end
if jwtype==1 then

exp=jwCfg.rewards[2]
elseif jwtype==2 then
exp=jwCfg.rewards[2]
elseif jwtype==3 then

itemList=channel_data.jwRewardList[jwid]
end

if catList==nil then
catList=table.randomIndex(channel_data.employeeList)
end



local content=jwCfg.content
if catList then
if type(catList)=='table'then
for cindex=1,#catList do

local catguid=catList[cindex]
local catinfo=wanBaoXunBaoDuiModel:getCatData(catguid)
local name=cfgHelper.get2(cfg_catnameconfig_get,catinfo.name_id,'name')
local gstr="{cname"..cindex.."}"

content=string.gsub(content,gstr,name)
end
elseif type(catList)=='number'then

local catguid=catList
local catinfo=wanBaoXunBaoDuiModel:getCatData(catguid)
local name=cfgHelper.get2(cfg_catnameconfig_get,catinfo.name_id,'name')
local gstr="{cname".. 1 .."}"

content=string.gsub(content,gstr,name)
end
end


if itemList~=nil then
for cindex=1,itemList.num do

local itemData=itemList.rewardList[cindex]
local itemId=itemData.param_1
local itemNum=itemData.param_2
local name=itemsConfig.getItemName(itemId)
local gstr='{item'..cindex..'}'

content=string.gsub(content,gstr,name)
end
end


if exp~=nil then

local name=exp
local gstr='{num'.. 1 ..'}'

content=string.gsub(content,gstr,name)
end


local shortTime=timeHelper.convertLongStamp(channel_data.start_time)
local temp={
content=content,
time=shortTime+channel_data.intervalJW*index
}
table.insert(channel_data.log,temp)
end
end




function wanBaoXunBaoDuiModel:updateJWLog(channel_data)

wanBaoXunBaoDuiModel:createJWLog(channel_data)

UIManager:invokeUIMethod('UIWanBaoXunBaoDui_MainWin','refreshAdventureLog',channel_data.channel_Id,channel_data)
end





function wanBaoXunBaoDuiModel:setQiyuEvent(qiyu_num,qiyuList)
self.qiyu_num=qiyu_num
self.qiyuList=qiyuList or{}
end




function wanBaoXunBaoDuiModel:getQiyuEvent()
return self.qiyuList or{}
end





function wanBaoXunBaoDuiModel:dealChannelReturn(channel_id,channelInfo)
self:setDispatchingChannelByInfo(channelInfo)

reddotControl.on_change_catch_type(CATCH_TYPE.eWanBaoXunBaoDuiTask)

self:deleteLocalMapPoint(channelInfo.task_Id)

UIManager:invokeUIMethod("UIWanBaoXunBaoDui_MainWin","initUI")
UIManager:invokeUIMethod("UIWanBaoXunBaoDui_MTSceneWin","playAdventureReturn",self.channelDatas[channelInfo.channel_id])

notifySystem:postNotify(notifyConfig.onWanBaoXunBaoDuiAdventureReturn,self.channelDatas[channelInfo.channel_id])
end




function wanBaoXunBaoDuiModel:giveUpAdventure(channel_id)
local channeldata=self.channelDatas[channel_id]
local employeeList=channeldata.employeeList

for k,guid in pairs(channeldata.employeeList)do
self.workingEmployees[guid]=nil
end
self:resetChannelData(channel_id)
self.channelDatas[channel_id].channel_state=WBXBD_Channel_STATE.idle


self:deleteLocalMapPoint(channeldata.task_Id)

reddotControl.on_change_catch_type(CATCH_TYPE.eWanBaoXunBaoDuiTask)

UIManager:invokeUIMethod("UIWanBaoXunBaoDui_MainWin","initUI")

UIManager:invokeUIMethod("UIWanBaoXunBaoDui_MTSceneWin","refresh",channel_id,employeeList)
end





function wanBaoXunBaoDuiModel:dealChannelReturnResult(len,list)

for index=1,len do
local info=list[index]
local channel_id=info.param_1
local qiyu_id=info.param_2

local channeldata=self.channelDatas[channel_id]

self.dealFinishChannelId=channel_id

self.startShowResult=true

wanBaoXunBaoDuiModel:updateChannelDataByIndex(channel_id)
local prizeReward=self.prizeReward or{}
if#prizeReward==0 and(not wanBaoXunBaoDuiController:getXZSReceiveFlag())then
UIManager.info('本次冒险没有获得任何物资')
end

for index=1,channeldata.employeeLen do
local guid=channeldata.employeeList[index]
self.workingEmployees[guid]=nil
end
MysteryModel:setWanBaoXunBaoDuiCatModel(channeldata.employeeList[1])


self:deleteLocalMapPoint(channeldata.task_Id)

self:resetChannelData(channel_id)
MysteryModel:setWanBaoXunBaoDuichannel_state(self.channelDatas[channel_id].channel_state)
self.channelDatas[channel_id].channel_state=WBXBD_Channel_STATE.idle

if tonumber(tostring(qiyu_id))>0 then
self.qiyuList[#self.qiyuList+1]=qiyu_id
end

wanBaoXunBaoDuiController:freshShipState(channel_id)
end


reddotControl.on_change_catch_type(CATCH_TYPE.eWanBaoXunBaoDuiTask)

self.startShowResult=true
MysteryModel:handelWanBaoXunBaoDuiMiJinOpen()
wanBaoXunBaoDuiModel:showAdventureFinishSettlementWin()

UIManager:invokeUIMethod("UIWanBaoXunBaoDui_ReceiveTransitionWin",'closeSelf')

wanBaoXunBaoDuiController:setXZSReceiveFlag(0)

notifySystem:postNotify(notifyConfig.onWanBaoXunBaoDuiAadcentrueFinish,len)
end



function wanBaoXunBaoDuiModel:dealFinishAdventure()
local channeldata=self.channelDatas[self.dealFinishChannelId]
local employeeList=channeldata.employeeList
UIManager:invokeUIMethod("UIWanBaoXunBaoDui_MainWin","initUI")

local func=function()

UIManager:invokeUIMethod("UIWanBaoXunBaoDui_MTSceneWin","refresh",self.dealFinishChannelId,employeeList)
end
UIManager:invokeUIMethod("UIWanBaoXunBaoDui_MTSceneWin","playAdventureFinishGoOut",func)

self.dealFinishChannelId=nil
end




function wanBaoXunBaoDuiModel:getChannelNumber()
return self.showChannelNum
end




function wanBaoXunBaoDuiModel:getChannelOpenDatas()
return self.channelOpenList
end




function wanBaoXunBaoDuiModel:getMainWinChannelDatas()
return self.showChannelDataList,self.totalUnlockChannelNum
end




function wanBaoXunBaoDuiModel:caculateTeQuanBaseRewardUp()
local totalTqCfg=cfg_cattequanconfig()
local baseUp=0
for index,tqCfg in ipairs(totalTqCfg)do
if self.channelDatas[tqCfg.channelid].open_state then
baseUp=baseUp+tqCfg.mod
end
end
return baseUp
end





function wanBaoXunBaoDuiModel:updateChannelDataByIndex(channelid)
local data=self.channelDatas[channelid]
local temp=data

local const_def=self:getConstDef()
local isShowReward=data.channel_state>WBXBD_Channel_STATE.idle


if isShowReward and data~=nil then

local rate=1

local taskcfg=wanBaoXunBaoDuiModel:getTaskConfig(data.task_Id)
local condition=wanBaoXunBaoDuiModel:getChannelConditionDataByIndex(channelid)

local base_exp_up=0
local base_other_up=0
local isNeedCaculateReward=data.channel_state>WBXBD_Channel_STATE.preparing
local isPrearing=data.channel_state==WBXBD_Channel_STATE.preparing


temp.reward={}
temp.txDropList={}
temp.extraRewrd={}

temp.name=taskcfg.name
temp.spRewardRate=condition.spRewardRate
data.spend_time=wanBaoXunBaoDuiModel:getAdventureSpendTime(temp.channel_Id)



local baseUp=wanBaoXunBaoDuiModel:caculateTeQuanBaseRewardUp()

local beu,bou,rwu,dl=wanBaoXunBaoDuiModel:dealCatTxForChannelData(temp,taskcfg)

temp.base_exp_up=beu+condition.upRate+baseUp
temp.base_other_up=bou+condition.upRate+baseUp
temp.txDropList=dl


base_exp_up=data.base_exp_up
base_other_up=data.base_other_up


if isNeedCaculateReward then
local totalUpdateNum=wanbaoXunBaoDuiHelper:FloorProtect(data.need_time/const_def.reward_time)
local curUpdateNum=wanbaoXunBaoDuiHelper:FloorProtect(data.spend_time/const_def.reward_time)
rate=curUpdateNum/totalUpdateNum
end

for index,rewardData in ipairs(taskcfg.rewards)do
local rewardItemID=rewardData[1]
local rewardItemNum=rewardData[2]
local upRate=0
local gray=0

if rewardItemID==-1 then
rewardItemNum=wanbaoXunBaoDuiHelper:FloorProtect(rewardItemNum*(1+(base_exp_up/100)))
upRate=base_exp_up
rewardItemID=17328
else
rewardItemNum=wanbaoXunBaoDuiHelper:FloorProtect(rewardItemNum*(1+(base_other_up/100)))
upRate=base_other_up
end

rewardItemNum=wanbaoXunBaoDuiHelper:FloorProtect(rewardItemNum*rate)


temp.reward[#temp.reward+1]={rewardItemID,rewardItemNum,upRate=upRate,gray=gray}
end

for index,dropid in ipairs(temp.txDropList)do
local extraData=zongmenControl:getRewardConfigData(dropid,zongmenModel:getLevel())

for _,rewardData in ipairs(extraData)do
local itemData=table.weakCopy(rewardData)
itemData[2]=wanbaoXunBaoDuiHelper:FloorProtect(itemData[2]*rate)
if(data.channel_state>WBXBD_Channel_STATE.doing and itemData[2]>0)or data.channel_state<=WBXBD_Channel_STATE.doing then
table.insert(temp.extraRewrd,itemData)
end
end
end

if isNeedCaculateReward then
if data.server_data.drop_reward_num>0 then
for index=1,data.server_data.drop_reward_num do
local dropItemData=data.server_data.dropList[index]
if data.spend_time>=dropItemData.time and dropItemData.num>0 then
for dIndex=1,dropItemData.num do
local dropItem=dropItemData.rewardList[dIndex]
local itemID=dropItem.param_1
local itemNum=dropItem.param_2

local itemData={itemID,itemNum}
temp.reward[#temp.reward+1]=itemData
end
end
end
end
else
for k,dropid in pairs(taskcfg.drops)do
local showItems=zongmenControl:getRewardConfigData(dropid,zongmenModel:getLevel())

for si,itemdata in ipairs(showItems)do
temp.reward[#temp.reward+1]=itemdata
end
end
end


if data.channel_state>WBXBD_Channel_STATE.preparing then
wanBaoXunBaoDuiModel:createJWLog(data)
end
end

return temp
end






function wanBaoXunBaoDuiModel:dealCatTxForChannelData(data,taskCfg)
local base_exp_up=0
local base_other_up=0
local spRewardRate=0
local txDropList={}

if data.employeeLen>0 then
local dimao=taskCfg.dimao

for cindex,catguid in pairs(data.employeeList)do
local catInfo=wanBaoXunBaoDuiModel:getCatData(catguid)

if catInfo.sortTxSpe~=nil then
if catInfo.sortTxSpe[WBXBD_Cat_Tx_Spe_Type.revise_Exp]~=nil then
local reviseExpDataList=catInfo.sortTxSpe[WBXBD_Cat_Tx_Spe_Type.revise_Exp]

for index,rexpData in ipairs(reviseExpDataList)do
local needDimao=rexpData[2]
local value=rexpData[3]

if needDimao==dimao then
base_exp_up=base_exp_up+value
end
end
end

if catInfo.sortTxSpe[WBXBD_Cat_Tx_Spe_Type.add_SpeRate]~=nil then
local addSpeDataList=catInfo.sortTxSpe[WBXBD_Cat_Tx_Spe_Type.add_SpeRate]

for index,rexpData in ipairs(addSpeDataList)do
local value=rexpData[2]

spRewardRate=spRewardRate+value
spRewardRate=Mathf.Min(10000,spRewardRate)
spRewardRate=Mathf.Max(0,spRewardRate)
end
end

if catInfo.sortTxSpe[WBXBD_Cat_Tx_Spe_Type.revise_OtherReward]~=nil then
local reviseOtherDataList=catInfo.sortTxSpe[WBXBD_Cat_Tx_Spe_Type.revise_OtherReward]

for index,rexpData in ipairs(reviseOtherDataList)do
local needDimao=rexpData[2]
local value=rexpData[3]

if needDimao==dimao then
base_other_up=base_other_up+value
end
end
end

if catInfo.sortTxSpe[WBXBD_Cat_Tx_Spe_Type.drop_Item]~=nil then
local dropItemDataList=catInfo.sortTxSpe[WBXBD_Cat_Tx_Spe_Type.drop_Item]

for index,dropItem in ipairs(dropItemDataList)do
local dropid=dropItem[2]

table.insert(txDropList,dropid)
end
end
end
end
end
return base_exp_up,base_other_up,spRewardRate,txDropList
end





function wanBaoXunBaoDuiModel:getChannelConditionDataByIndex(channelid)
local data=self.channelDatas[channelid]
local temp
if data and data.task_Id and data.task_Id>0 then
temp={}
local totalProp={}

local taskcfg=cfgHelper.get1(cfg_catmapconfig_get,data.task_Id)
local mapColorCfg=cfgHelper.get1(cfg_catmapcolorconfig_get,taskcfg.color)
local const_def=self:getConstDef()
local upRateFixed=taskcfg.propParam

temp.techan=taskcfg.techan
temp.conditionState=true

if data.employeeLen<const_def.num[1]then
temp.conditionState=false
temp.conditionDesc=FMT.fmt("派遣猫猫数量不足，至少派遣{0}位",const_def.num[1])
end

if data.employeeList and data.channel_state==WBXBD_Channel_STATE.preparing then
for k,v in pairs(data.employeeList)do
local catInfo=self.employeeLookUp[tostring(v)]

for kk,vv in pairs(catInfo.propList)do
totalProp[kk]=(totalProp[kk]or 0)+vv
end

for kk,vv in pairs(catInfo.txList or{})do
totalProp[vv*100]=1
end

if catInfo.tili<taskcfg.tili then



end
end
else
if data.channel_state>WBXBD_Channel_STATE.preparing then
totalProp=data.server_data.propList

for k,v in pairs(data.employeeList)do

local catInfo=self.employeeLookUp[tostring(v)]

for kk,vv in pairs(catInfo.txList or{})do
totalProp[vv*100]=1
end
end
end
end

temp.totalProp=totalProp

local propNames=wanBaoXunBaoDuiModel:getPropNameList()
temp.comditions={}
temp.upRate=0
for k,maxValue in pairs(taskcfg.propNeed)do
local totalValue=totalProp[k]or 0
local rate=Mathf.Min(totalValue/maxValue,1)*upRateFixed[k]
rate=wanbaoXunBaoDuiHelper:FloorProtect(rate)


temp.comditions[k]={}
temp.comditions[k].value=totalValue
temp.comditions[k].maxValue=maxValue
temp.comditions[k].name=propNames[k]


temp.upRate=temp.upRate+rate
end
temp.upRate=wanbaoXunBaoDuiHelper:FloorProtect(temp.upRate)

local reduceTili=0
local totalEndurance=totalProp[WBXBD_Cat_Attr_Type.endurance]or 0
if totalEndurance>mapColorCfg.needNL then
reduceTili=wanbaoXunBaoDuiHelper:FloorProtect((totalEndurance-mapColorCfg.needNL)/const_def.sub_tili_param)
reduceTili=Mathf.Min(reduceTili,taskcfg.maxSubTili)
end
temp.comditions[#temp.comditions+1]={
name="消耗体力",
value=taskcfg.tili,
reduceTili=reduceTili,
}
temp.needTili=Mathf.Max(taskcfg.tili-reduceTili,0)

temp.txcondition={}
temp.spReachLen=0
for k,v in pairs(taskcfg.needTx)do
temp.txcondition[k]={}
local txconfig=cfgHelper.get1(cfg_cattxconfig_get,v)

temp.txcondition[k].id=txconfig.id
temp.txcondition[k].name=txconfig.name
temp.txcondition[k].frame=txconfig.frame
temp.txcondition[k].isReach=totalProp[v*100]and true or false

if temp.txcondition[k].isReach then
temp.spReachLen=temp.spReachLen+1
end
end


local beu,bou,rwu,dl=wanBaoXunBaoDuiModel:dealCatTxForChannelData(data,taskcfg)
local techanRate=taskcfg.techan[1][3]
local cal_yunqi=const_def.cal_yunqi
local spRateList={[0]=0,techanRate,const_def.tx_up_spe_mod}
local needYQ=cfgHelper.get2(cfg_catmapcolorconfig_get,taskcfg.color,'needYQ')
local spRate=rwu
local totalProp_Luck=totalProp[WBXBD_Cat_Attr_Type.luck]or 0
local addSpRate=0

for k=0,temp.spReachLen do
spRate=spRate+spRateList[k]
end

if totalProp_Luck>needYQ then
addSpRate=wanbaoXunBaoDuiHelper:FloorProtect(Mathf.Max(0,(totalProp_Luck-needYQ)/cal_yunqi[1]))*cal_yunqi[2]
end
local spRewardRate=spRate+addSpRate

temp.spRewardRate=Mathf.Max(0,spRewardRate)
temp.spRewardRate=Mathf.Min(10000,temp.spRewardRate)
temp.spRewardRate=temp.spRewardRate/100
end

return temp
end




function wanBaoXunBaoDuiModel:getQuickFillEmployeeToChannel(index)
local channelData=self.channelDatas[index]
if channelData.employeeLen<3 then
local catlist=wanBaoXunBaoDuiModel:getSelectEmployeeData(channelData)
local tili=cfgHelper.get2(cfg_catmapconfig_get,channelData.task_Id,'tili')

local quickList={}
local needNum=3-channelData.employeeLen
for k=1,needNum do
local catinfo=catlist[k]
if catinfo then
local catMaxTili=wanBaoXunBaoDuiModel:caculationMaxTili(catinfo)
if catMaxTili>=tili then
table.insert(quickList,catinfo.guid)
self.workingEmployees[catinfo.guid]=channelData.channel_Id
end
end
end

if#quickList==0 then
UIManager.info("无合适的猫猫进行派遣")
return
end

local posList={}
for index=1,3 do
if channelData.employeeList[index]==nil then
table.insert(posList,index)
if quickList[#posList]then
channelData.employeeList[index]=quickList[#posList]
channelData.employeeLen=channelData.employeeLen+1
end
end
end

wanBaoXunBaoDuiModel:clearDispathTimer()


for aindex=1,#quickList do
local pindex=posList[aindex]
UIManager:invokeUIMethod("UIWanBaoXunBaoDui_MTSceneWin","setBtState",pindex,true)
end

local dIndex=0
local fillLen=#quickList-1
local curLen=0
channelData.filling=true
local func=function()
dIndex=dIndex+1
local catguid=quickList[dIndex]
local pindex=posList[dIndex]

UIManager:invokeUIMethod("UIWanBaoXunBaoDui_MTSceneWin","dispatchCrew",catguid,pindex)
curLen=curLen+1
if curLen==fillLen then
channelData.filling=false
end
end
if#quickList-1>0 then
self.dispatchTimer=timer.new()
self.dispatchTimer:start(0.5,func,#quickList-1)
end
func()
UIManager:invokeUIMethod("UIWanBaoXunBaoDui_MainWin","initUI")
else
UIManager.info('喵，冒险船已满员啦')
end
end



function wanBaoXunBaoDuiModel:clearDispathTimer()
if self.dispatchTimer~=nil then
self.dispatchTimer:cancel()
self.dispatchTimer=nil
end
end




function wanBaoXunBaoDuiModel:doQuickRetractEmployeeToChannel(channel_id)
local channelData=self.channelDatas[channel_id]

for k,id in pairs(channelData.employeeList)do
self.workingEmployees[id]=nil
end

channelData.employeeLen=0
channelData.employeeList={}

UIManager:invokeUIMethod("UIWanBaoXunBaoDui_MTSceneWin","refreshCrew")
UIManager:invokeUIMethod("UIWanBaoXunBaoDui_MainWin","refreshChannelSelectEmployee",channel_id)

end






function wanBaoXunBaoDuiModel:removeDispatchEmployee(channel_id,index,guid)
self.channelDatas[channel_id].employeeList[index]=nil
self.channelDatas[channel_id].employeeLen=self.channelDatas[channel_id].employeeLen-1
self.workingEmployees[guid]=nil


UIManager:invokeUIMethod("UIWanBaoXunBaoDui_MTSceneWin","freshBaseCrewItem",index)
UIManager:invokeUIMethod("UIWanBaoXunBaoDui_MainWin","refreshChannelSelectEmployee",channel_id)
end






function wanBaoXunBaoDuiModel:addDispatchEmployee(channel_id,index,guid)
if self.channelDatas[channel_id].employeeList[index]then
local pguid=self.channelDatas[channel_id].employeeList[index]
self.channelDatas[channel_id].employeeLen=self.channelDatas[channel_id].employeeLen-1
self.workingEmployees[pguid]=nil
end
self.channelDatas[channel_id].employeeList[index]=guid
self.channelDatas[channel_id].employeeLen=self.channelDatas[channel_id].employeeLen+1
self.workingEmployees[guid]=channel_id


UIManager:invokeUIMethod("UIWanBaoXunBaoDui_MTSceneWin","dispatchCrew",guid,index)
UIManager:invokeUIMethod("UIWanBaoXunBaoDui_MainWin","refreshChannelSelectEmployee",channel_id)

UIFullWanBaoXunBaoDuiController:closeWindow("UIWanBaoXunBaoDui_SelectEmployeeWin")
end




function wanBaoXunBaoDuiModel:addBtNum(channel_id)
self.channelDatas[channel_id].bt_num=self.channelDatas[channel_id].bt_num+1
end




function wanBaoXunBaoDuiModel:reduceBtNum(channel_id)
self.channelDatas[channel_id].bt_num=self.channelDatas[channel_id].bt_num-1
end




function wanBaoXunBaoDuiModel:resetBtNum(channel_id)
self.channelDatas[channel_id].bt_num=0
end





function wanBaoXunBaoDuiModel:setChannelBtState(channel_id,state)
self.channelDatas[channel_id].bt_state=state
end




function wanBaoXunBaoDuiModel:getChannelDefaultSelectIndex()
local index=1
local id=1
local openMap=true
for i,ChannelData in pairs(self.showChannelDataList)do
if ChannelData.channel_state>WBXBD_Channel_STATE.idle and ChannelData.open_state then
index=i
id=ChannelData.channel_Id
openMap=false
break
end
end

return index,id,openMap
end






function wanBaoXunBaoDuiModel:checkDispatch(channel_id,data)
local channeldata=self.channelDatas[channel_id]
local taskcfg=self:getTaskConfig(channeldata.task_Id)
return data.tili>=taskcfg.tili
end





function wanBaoXunBaoDuiModel:getChanelListByState(stateList)
local list={}
local idsList={}

local adList=self:getChannelDatas()
for index,data in pairs(adList)do
if table.findValue(stateList,data.channel_state)then
list[#list+1]=data
idsList[#idsList+1]=data.channel_Id
end
end

return list,idsList
end






function wanBaoXunBaoDuiModel:setAdventurePointData(num,tasklist)
self.mapPointNum=num
if self.mapPointNum>0 then
local localMapPoint=wanBaoXunBaoDuiModel:getLocalMapPoint()
for k,v in pairs(tasklist)do

local point=localMapPoint[v]
self.adventureMapPointList[k]={}
self.adventureMapPointList[k].id=v

self.adventureMapPointList[k].mapPoint=point
self.isUse=false

end
for k,data in pairs(self.adventureMapPointList)do
if data.mapPoint==nil then
local dimaoType=cfgHelper.get2(cfg_catmapconfig_get,data.id,'dimao')
local point=wanBaoXunBaoDuiModel:getRandomPoint(dimaoType)
data.mapPoint=point

localMapPoint[data.id]=point
end
end

wanBaoXunBaoDuiModel:setLocalMapPoint(localMapPoint)

else
self.adventureMapPointList={}
end
end





function wanBaoXunBaoDuiModel:getRandomPoint(type)
local randomPoint=cfgHelper.get2(cfg_catmappointconfig_get,type,'pointgroup')
local tempRandomPoint=table.deepCopy(randomPoint)

for k,mapdata in pairs(self.adventureMapPointList)do
local dimaoType=cfgHelper.get2(cfg_catmapconfig_get,mapdata.id,'dimao')
if dimaoType==type and(not mapdata.isUse)then
if mapdata.mapPoint~=nil then
tempRandomPoint[mapdata.mapPoint]=nil
end
end
end

local tempList={}
for k,v in pairs(tempRandomPoint)do
table.insert(tempList,k)
end
return table.randomIndex(tempList)
end




function wanBaoXunBaoDuiModel:getAdvPoints()
local temp={}
for k,v in pairs(self.adventureMapPointList)do
if not v.isUse then
temp[#temp+1]=v
end
end
return temp
end




function wanBaoXunBaoDuiModel:getAdventurePointFreshLeftTime()
return timeHelper.getServerNewDayFiveLeftTime()
end





function wanBaoXunBaoDuiModel:getMapConditionDatasById(mappoint)

local temp={}

if mappoint then
local taskcfg=self:getTaskConfig(mappoint.id)
local pointcfg=self:getTerrainConfig(taskcfg.dimao)

temp.state=true

temp[1]={
title="探险地貌",
conditions={
{
name="地貌",
info=pointcfg.name
}
}
}

temp[2]={
title="属性要求",
conditions={
{
name="力量",
info=taskcfg.propNeed[1]
},
{
name="智慧",
info=taskcfg.propNeed[2]
},
{
name="灵巧",
info=taskcfg.propNeed[3]
}
}
}

temp[3]={
title="体力消耗",
conditions={
{
name="体力",
info=taskcfg.tili
}
}
}
else
temp.state=false
temp[1]={
title="探险地貌",
conditions={}
}

temp[2]={
title="属性要求",
conditions={}
}

temp[3]={
title="体力消耗",
conditions={}
}
end

return temp
end





function wanBaoXunBaoDuiModel:getAdventurePointReward(mapPoint)
local temp={}
local rlist={}

local taskcfg=self:getTaskConfig(mapPoint.id)

for k,reward in pairs(taskcfg.clientRewardShow)do
local conf={
itemid=reward[1],
itemcount=reward[2]>1 and reward[2]or'',
showCountBG=reward[2]>1,
showname=false
}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
table.insert(temp,propData)
table.insert(rlist,reward[2]==-1)
end
return temp,rlist
end





function wanBaoXunBaoDuiModel:getTaskIdByIndex(mapSelectId)
local mappoint=self.adventureMapPointList[mapSelectId]
return mappoint
end




function wanBaoXunBaoDuiModel:setAdventurePrize(reward)
for index,itemData in ipairs(reward)do
if itemData.itemguid~=nil then
self.prizeRewardLookup[tostring(itemData.itemguid)]=itemData
else
if self.prizeRewardLookup[itemData.itemid]then
local num=self.prizeRewardLookup[itemData.itemid].num
self.prizeRewardLookup[itemData.itemid].num=num+itemData.num
else
self.prizeRewardLookup[itemData.itemid]=itemData
end
end
end


self.prizeReward={}

for key,itemData in pairs(self.prizeRewardLookup)do
self.prizeReward[#self.prizeReward+1]=itemData
end

table.sort(self.prizeReward,function(a,b)
return a.sortWeight>b.sortWeight
end)
end



function wanBaoXunBaoDuiModel:initPrizeData()
self.startShowResult=true
self.prizeReward={}
self.prizeRewardLookup={}
self.uplevelCatList={}
end





function wanBaoXunBaoDuiModel:checkOpenUnlock(channelid)
local channelOpenCfg=cfgHelper.get1(cfg_catchannelconfig_get,channelid)
if channelOpenCfg.isOrder then
local preChannelid=channelid-1
local channeldata=wanBaoXunBaoDuiModel:getChannelDataById(preChannelid)
if channeldata.open_state then
return true
else
UIManager.info('需先解锁前置航道')
return false
end
end
return true
end

local LocalMapPointKey='LocalMapPointKey'




function wanBaoXunBaoDuiModel:setLocalMapPoint(localMapPoint)
local temp={}
if localMapPoint~=nil and next(localMapPoint)~=nil then
for k,v in pairs(localMapPoint)do
if v~=nil then
table.insert(temp,{k,v})
end
end
end
userActorSetting.set(LocalMapPointKey,temp)
userActorSetting.flush()
end




function wanBaoXunBaoDuiModel:getLocalMapPoint()
local localMapPoint=userActorSetting.get(LocalMapPointKey,{})
local temp={}
if localMapPoint~=nil and#localMapPoint>1 then
for k,v in pairs(localMapPoint)do
temp[v[1]]=v[2]
end
end
return temp
end




function wanBaoXunBaoDuiModel:deleteLocalMapPoint(id)
local localMapPoint=wanBaoXunBaoDuiModel:getLocalMapPoint()
if localMapPoint[id]~=nil then
localMapPoint[id]=nil
end
wanBaoXunBaoDuiModel:setLocalMapPoint(localMapPoint)
end





function wanBaoXunBaoDuiModel:checkDispatchTili(channel_data)
local indexList={}
local huifuList={}
local needConsumeNum=0
local moneyid

local channelConditionData=wanBaoXunBaoDuiModel:getChannelConditionDataByIndex(channel_data.channel_Id)
local need_tili=channelConditionData.needTili


for index,catguid in pairs(channel_data.employeeList)do
local catdata=wanBaoXunBaoDuiModel:getCatData(catguid)
if catdata.tili<need_tili then
table.insert(indexList,index)

local const_def=wanBaoXunBaoDuiModel:getConstDef()
local maxTili=wanBaoXunBaoDuiModel:caculationMaxTili(catdata)
moneyid=const_def.add_tili_need[1]
local rate=const_def.add_tili_need[2]
local least=maxTili-catdata.tili
local needNum=rate*least

needConsumeNum=needConsumeNum+needNum

table.insert(huifuList,{catdata.guid,least})
end
end

if#huifuList>0 then

wanBaoXunBaoDuiModel:showRestoreTiliDialog(moneyid,huifuList,needConsumeNum,indexList)
return false
end


return true
end







function wanBaoXunBaoDuiModel:showRestoreTiliDialog(money_id,huifuList,needConsumeNum,indexList)
local callback=function()
local moneyNum=itemsModel.getCount(money_id)
if moneyNum>=needConsumeNum then
self.restoreTiliIndexList=indexList
wanBaoXunBaoDuiController:reqRecoverCatTiliByUseMoney(#huifuList,huifuList)
else
gainControl:showGainWin(money_id,needConsumeNum)
end
end

local iconname=iconHelper.getIconName(money_id)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,40)

local contentStr=FMT.fmt('猫猫体力不足,是否花费 {0} {1} 恢复猫猫全部体力',iconStr,needConsumeNum)

local show_data={
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
okcallback=callback,
moneytypes={{eMoneyType.mtYuBi}},
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end





function wanBaoXunBaoDuiModel:isEmptyReward(channel_id)
wanBaoXunBaoDuiModel:updateChannelDataByIndex(channel_id)
local channelData=wanBaoXunBaoDuiModel:getChannelDataById(channel_id)

local const_def=wanBaoXunBaoDuiModel:getConstDef()
local reward_time=const_def.reward_time

return channelData.spend_time<reward_time
end




function wanBaoXunBaoDuiModel:showChannelGoInfoTip(channel_id)
local data=wanBaoXunBaoDuiModel:getChannelDataById(channel_id)
if data.bt_num>0 then
if data.bt_state==WBXBD_BT_STATE.dispatch then
UIManager.info('猫猫还在路上')
elseif data.bt_state==WBXBD_BT_STATE.restoretili then
UIManager.info('猫猫在吃鱼呢~等一会~')
end
end
end



function wanBaoXunBaoDuiModel:resetAllChannelData()
for k,channelData in pairs(self.channelDatas)do
if channelData.open_state then
self:resetChannelData(channelData.channel_Id)
end
end
end




function wanBaoXunBaoDuiModel:checkChannelIdle()
if self.channelDatas then
for k,channelData in pairs(self.channelDatas)do
if channelData.channel_state==WBXBD_Channel_STATE.idle and channelData.open_state then
return true
end
end
end
end





function wanBaoXunBaoDuiModel:removeWorkingCat(guid)
if self.workingEmployees[guid]then
self.workingEmployees[guid]=nil
end
end




function wanBaoXunBaoDuiModel:addWorkingCat(guid)
self.workingEmployees[guid]=999
end
