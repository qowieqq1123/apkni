







activitiesHandle_totalRecharge=new_activitiesHandle('activitiesHandle_totalRecharge',activitiesHandle)

function activitiesHandle_totalRecharge:onInit()

end

function activitiesHandle_totalRecharge.recv_249_150(args)
local actId,subId,totalRechargeNum,rewardFlag,len,zxlist=unpack(args)

local subType=SUB_ACTIVITY_TYPE.eRechargeAct1

local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if not data.isInit then
data.isInit=true
end

data.totalRechargeNum=totalRechargeNum or 0
data.rewardFlag=rewardFlag

data.selectData={}
if len>0 then
for i,v in ipairs(zxlist)do
data.selectData[v.id]=data.selectData[v.id]or{}
if v.zxidxList then
for i2,v2 in ipairs(v.zxidxList)do
if v2>0 then
data.selectData[v.id][i2]=v2
end
end
end
end
end

activitiesModel:setSubActInfoData(actId,subType,subId,data)

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info then
local openPanel=info:getSubActConfig('openPanel')
for i,v in ipairs(openPanel)do
local sub_panelType=v[1]
local sub_panelcfg=cfgHelper.get1(cfg_subactivityspanelconfig_get,sub_panelType)
if sub_panelcfg then
local winName=sub_panelcfg.panelname
local win=UIManager:findActiveWindow(winName)
if win then
win:refresh(true)
end
end
end
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_totalRecharge.recv_249_212(actId,subId,id,len,idxList)
if idxList then
local subType=SUB_ACTIVITY_TYPE.eRechargeAct1
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
data.selectData[id]=data.selectData[id]or{}
for i,v in ipairs(idxList)do
if v>0 then
data.selectData[id][i]=v
end
end
activitiesModel:setSubActInfoData(actId,subType,subId,data)

local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info then
local openPanel=info:getSubActConfig('openPanel')
for i,v in ipairs(openPanel)do
local sub_panelType=v[1]
local sub_panelcfg=cfgHelper.get1(cfg_subactivityspanelconfig_get,sub_panelType)
if sub_panelcfg then
local winName=sub_panelcfg.panelname
UIManager:callWindowFunc(winName,"refreshTaskItemByTaskIndex",id)
end
end
end
end
end