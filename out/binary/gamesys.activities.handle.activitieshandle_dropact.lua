







activitiesHandle_dropAct=new_activitiesHandle('activitiesHandle_dropAct',activitiesHandle)

function activitiesHandle_dropAct:onInit()

end

function activitiesHandle_dropAct.recv_249_73(actId,subId,sec)
local subType=SUB_ACTIVITY_TYPE.eDropAct

local data=activitiesModel:getSubActInfoData(actId,subType,subId)
data.getRewardSec=sec

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
win:refresh()
end
end
end
end


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end