







activitiesHandle_fabaomilu=new_activitiesHandle('activitiesHandle_fabaomilu',activitiesHandle)









function activitiesHandle_fabaomilu:onInit()

end


function activitiesHandle_fabaomilu.recv_249_161(actid,act2id,sec)




local subType=SUB_ACTIVITY_TYPE.eFaBaoMiLu
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

local old_sec=data.sec
data.sec=sec
activitiesModel:setSubActInfoData(actID,subType,subid,data)
if old_sec~=nil then
UIManager.info('领取成功')
UIManager:invokeUIMethod('UISubAct_fabaomilu_win','rec_refresh')
activitiesModel:refreshSubActUnlock(actID)

if not newbieModel.isFinish(NEWBIE_LUA_FUNC_TYPE.FirstTimeMiLuLuaFunc)then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.FirstTimeMiLuLuaFunc)
end
end
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end