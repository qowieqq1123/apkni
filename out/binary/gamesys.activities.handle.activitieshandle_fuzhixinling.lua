







activitiesHandle_fuzhixinling=new_activitiesHandle('activitiesHandle_fuzhixinling',activitiesHandle)

function activitiesHandle_fuzhixinling:onInit()

end

function activitiesHandle_fuzhixinling.recv_249_33(actId,subId,flag)
local subType=SUB_ACTIVITY_TYPE.eFuZheXinLing
activitiesModel:setSubActInfoData(actId,subType,subId,flag)
local win=UIManager:findActiveWindow('UISubAct_FuZhiXinLingWin')
if win then
win:refresh()
end
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end