







activitiesHandle_InvestAct2=new_activitiesHandle('activitiesHandle_InvestAct2',activitiesHandle)

function activitiesHandle_InvestAct2.recv_249_141(args)
local actid,act2id,times,flaglistlen,flagList,exflaglistlen,exflagList,ex=args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8]
local actType=SUB_ACTIVITY_TYPE.eInvestAct2

local old=activitiesModel:getSubActInfoData(actid,actType,act2id)
if old then
if old.ex and old.ex~=ex then
UIManager.info("成功解锁")
end
end

local data={flagList=flagList,exflagList=exflagList,ex=ex,times=times}
activitiesModel:setSubActInfoData(actid,actType,act2id,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,actType)
UIManager:callWindowFunc('UISubAct_tianmolu_v2_Win','refresh')
end

function activitiesHandle_InvestAct2.recv_249_145(actid,act2id,times)
local actType=SUB_ACTIVITY_TYPE.eInvestAct2


local data=activitiesModel:getSubActInfoData(actid,actType,act2id)
data.times=times
activitiesModel:setSubActInfoData(actid,actType,act2id,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,actType)

end
