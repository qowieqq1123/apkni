







activitiesHandle_gongceqiandao=new_activitiesHandle('activitiesHandle_gongceqiandao',activitiesHandle)

function activitiesHandle_gongceqiandao:onInit()

end


function activitiesHandle_gongceqiandao.recv_249_174(actId,subId,level,sign_flag,reward_flag)

local subType=SUB_ACTIVITY_TYPE.egongCheQianDao
local data={}
data.level=level

data.sign_flag=sign_flag
data.reward_flag=reward_flag

activitiesModel:setSubActInfoData(actId,subType,subId,data)

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)


local msgType=msgWinType.eGongceqiandao
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info then
local openPanel=info:getSubActConfig('openPanel')
msgType=info:getSubActConfig('msgWinType')or msgWinType.eGongceqiandao
for i,v in ipairs(openPanel)do
local sub_panelType=v[1]
local sub_panelcfg=cfgHelper.get1(cfg_subactivityspanelconfig_get,sub_panelType)
if sub_panelcfg then
local winName=sub_panelcfg.panelname
UIManager:callWindowFunc(winName,"refreshList",true)
end
end
end


if initProControl.isDone()then
msgWinControl:addMsgWin(msgType,{act_id=actId,sub_act_type=SUB_ACTIVITY_TYPE.egongCheQianDao,sub_act_id=subId})
end



end

