







activitiesHandle_jiucengyaolou=new_activitiesHandle('activitiesHandle_jiucengyaolou',activitiesHandle)

function activitiesHandle_jiucengyaolou:onInit()

end

function activitiesHandle_jiucengyaolou.recv_249_22(argtable)
local subType=SUB_ACTIVITY_TYPE.eJiuCengYaoLou

local actid=argtable[1]
local act2id=argtable[2]
local monlistlen=argtable[3]
local monList=argtable[4]




local level=argtable[5]
local floor=argtable[6]
local recvlistlen=argtable[7]
local recvList=argtable[8]
local passlistlen=argtable[9]
local passList=argtable[10]

local limitFlag=argtable[11]

local data={}
data.monidxList=monList or{}


data.level=level
data.floor=floor

local dataRecvList={}
if recvList then
for i,v in ipairs(recvList)do
dataRecvList[v.param_1]=v.param_2
end
end
data.recvList=dataRecvList

local dataPassList={}
if passList then
for i,v in ipairs(passList)do
dataPassList[v.param_1]=v.param_2
end
end
data.passList=dataPassList

data.limitFlag=limitFlag

activitiesModel:setSubActInfoData(actid,subType,act2id,data)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_jiucengyaolou.updateFloorData(actid,act2id,updateData)
local subType=SUB_ACTIVITY_TYPE.eJiuCengYaoLou
local data=activitiesModel:getSubActInfoData(actid,subType,act2id)
for i,v in pairs(updateData)do
data[i]=v
end
activitiesModel:setSubActInfoData(actid,subType,act2id,data)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_jiucengyaolou.recv_249_23(actid,act2id,floor,times)
local subType=SUB_ACTIVITY_TYPE.eJiuCengYaoLou

local data=activitiesModel:getSubActInfoData(actid,subType,act2id)
data.recvList=data.recvList or{}
data.recvList[floor]=times
activitiesModel:setSubActInfoData(actid,subType,act2id,data)

UIManager:invokeUIMethod("UISubAct_JiuCengYaoLouEnterWin","refreshRecvReward",floor)

local info=activitiesModel:getSubActInfo(actid,subType,act2id)
if info and info:isJXGetReward(floor)and times>1 then
local nextLayer=info:findNotJXClearLayer()or floor
UIManager:invokeUIMethod("UISubAct_JiuCengYaoLouEnterWin","onListClickLayer",nextLayer,true)
end


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_jiucengyaolou.recv_249_46(actid,act2id,len,list)
local subType=SUB_ACTIVITY_TYPE.eJiuCengYaoLou
local data=activitiesModel:getSubActInfoData(actid,subType,act2id)
if data then
data.logList=data.logList or{}
if len>0 then
local logStamp=timeHelper.getServerShortTime()
data.logList.logStamp=logStamp

data.logList.diZhanLog=list[1]
data.logList.jiXianLog=list[2]
data.logList.logStamp=logStamp

activitiesModel:setSubActInfoData(actid,subType,act2id,data)

UIManager:invokeUIMethod("UIJiuCengYaoLouLogWin","onRecv")
end
end
end

function activitiesHandle_jiucengyaolou.recv_249_47(actid,act2id,len,floorList)
if len>0 then
local subType=SUB_ACTIVITY_TYPE.eJiuCengYaoLou
local data=activitiesModel:getSubActInfoData(actid,subType,act2id)
if data then
for i,floor in ipairs(floorList)do
data.limitFlag=bitHelper.set_1(data.limitFlag,floor-1)
end
activitiesModel:setSubActInfoData(actid,subType,act2id,data)
UIManager:invokeUIMethod("UIJCYLJiXianJiangLiWin","onRefresh")
UIManager:invokeUIMethod("UISubAct_JiuCengYaoLouEnterWin","refreshJXReddot")

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end
end

function activitiesHandle_jiucengyaolou.recv_249_48(actid,act2id,len,list)
local subType=SUB_ACTIVITY_TYPE.eJiuCengYaoLou
local data=activitiesModel:getSubActInfoData(actid,subType,act2id)
if data then
data.jixianlogList=data.jixianlogList or{}
if len>0 then
local logStamp=timeHelper.getServerShortTime()
local jixianlogList={}
for i,v in ipairs(list)do
jixianlogList[v.param_1]=v
end
data.jixianlogList=jixianlogList
data.jixianlogList.logStamp=logStamp
activitiesModel:setSubActInfoData(actid,subType,act2id,data)

UIManager:invokeUIMethod("UIJCYLJiXianJiangLiWin","onRecv")
end
end
end


function activitiesHandle_jiucengyaolou:canGotReward(actid,subid,floor)

local passData=activitiesHandle_jiucengyaolou:getPassData(actid,subid,floor)
local recvData=activitiesHandle_jiucengyaolou:getRecvRewardData(actid,subid,floor)
if passData~=nil then
local times=recvData or 0
local subType=SUB_ACTIVITY_TYPE.eJiuCengYaoLou
local cfg=activitiesModel:getSubActivityConfig(subType,subid)
local floorCfg=cfg.floor[floor]
local costConfig=floorCfg[4]
local buyTimes=#costConfig
if times==0 then
return 1
elseif times>=1 and times<=buyTimes then
return 2
elseif times>buyTimes then
return 3
end
end
return 0
end


function activitiesHandle_jiucengyaolou:getPassData(actid,act2id,floor)
local subType=SUB_ACTIVITY_TYPE.eJiuCengYaoLou
local data=activitiesModel:getSubActInfoData(actid,subType,act2id)
data=data or{}
data.passList=data.passList or{}
return data.passList[floor]
end

function activitiesHandle_jiucengyaolou:getRecvRewardData(actid,act2id,floor)
local subType=SUB_ACTIVITY_TYPE.eJiuCengYaoLou
local data=activitiesModel:getSubActInfoData(actid,subType,act2id)
data=data or{}
data.recvList=data.recvList or{}
return data.recvList[floor]
end

function activitiesHandle_jiucengyaolou:pushFightData(result,log,data)
self.fightData={result,log,data}
end

function activitiesHandle_jiucengyaolou:popFightData()
local temp=self.fightData
self.fightData=nil
return temp
end

function activitiesHandle_jiucengyaolou:getMonLv(config,level)
local cList=config.level
for i,v in ipairs(cList)do
if level>=v[1]and level<=v[2]then
return v[3]
end
end
return-1
end

function activitiesHandle_jiucengyaolou:get_jixianCiTiao(subid,floor)
local config=activitiesModel:getSubActivityConfig(SUB_ACTIVITY_TYPE.eJiuCengYaoLou,subid)
if config then
local floorCfg=config.floor[floor]
local jixianJiangLi=floorCfg[7]
return jixianJiangLi
end
end

function activitiesHandle_jiucengyaolou:get_jixianCiTiaoNum(subid,floor)
local config=activitiesModel:getSubActivityConfig(SUB_ACTIVITY_TYPE.eJiuCengYaoLou,subid)
if config then
local floorCfg=config.floor[floor]
local jixianJiangLi=floorCfg[7]
if jixianJiangLi then
for num,v in pairs(jixianJiangLi)do
return num
end
end
end
end