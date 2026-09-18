







local _LuaHelper=CS.LuaHelper

activitiesHandle_guitutequan=new_activitiesHandle('activitiesHandle_guitutequan',activitiesHandle)



local showRewards

function activitiesHandle_guitutequan:onEnterState()

end

function activitiesHandle_guitutequan:onLeaveState()

end

function activitiesHandle_guitutequan:get_showRewards()
return showRewards
end


function activitiesHandle_guitutequan.recv_249_190(...)
local args={...}
local subType=SUB_ACTIVITY_TYPE.eGuiTuTeQuan
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
data.worldLevel=args[3]or 0

if data==nil then return end
activitiesModel:setSubActInfoData(actID,subType,subID,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
