







local _LuaHelper=CS.LuaHelper

activitiesHandle_rolelingzhendiaoke=new_activitiesHandle('activitiesHandle_rolelingzhendiaoke',activitiesHandle)



local showRewards

function activitiesHandle_rolelingzhendiaoke:onEnterState()

end

function activitiesHandle_rolelingzhendiaoke:onLeaveState()

end

function activitiesHandle_rolelingzhendiaoke:get_showRewards()
return showRewards
end


function activitiesHandle_rolelingzhendiaoke.recv_249_224(...)





local args={...}
local subType=SUB_ACTIVITY_TYPE.eLingZhenHuiHua2
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data==nil then return end

data.topScore=args[3]or 0
data.isInit=true
data.campId=1
data.maxScore=args[4]
data.sdFlag=args[5]


local updateLongTime=timeHelper.getTodayZeroStamp()+15*60
local nowTime=timeHelper.getServerLongTime()
if updateLongTime<nowTime then
updateLongTime=updateLongTime+86400
end
data.nextUpdateDataTime=timeHelper.convertShortStamp(updateLongTime)

activitiesModel:setSubActInfoData(actID,subType,subID,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

UIManager:callWindowFunc('UILingZhenHHroleMainWin','refresh')

end


function activitiesHandle_rolelingzhendiaoke.recv_249_225(...)



local args={...}
local subType=SUB_ACTIVITY_TYPE.eLingZhenHuiHua2
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data==nil then return end

data.ftype=args[3]

activitiesModel:setSubActInfoData(actID,subType,subID,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

UIManager:callWindowFunc('UILingZhenHHroleGameExWin','handleSkill',data.ftype)
end


function activitiesHandle_rolelingzhendiaoke.recv_249_226(...)




local args={...}
local subType=SUB_ACTIVITY_TYPE.eLingZhenHuiHua2
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data==nil then return end

data.topScore=args[3]
data.maxScore=args[3]
data.sdFlag=args[4]

activitiesModel:setSubActInfoData(actID,subType,subID,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

notifySystem:postNotify(notifyConfig.onLingZengPengZhuangScoreChange,data.topScore)
end




function activitiesHandle_rolelingzhendiaoke:reqUseSkill(actid,subType,subid,ftype)
local json_str=jsonHelper.encode({1,ftype})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,subType,subid,json_str)
end

function activitiesHandle_rolelingzhendiaoke:reqSetScore(actid,subType,subid,score,sdFlag)
sdFlag=sdFlag or 0
local data=activitiesModel:getSubActInfoData(actid,subType,subid)

if data==nil then return end
local topScore=data.topScore or 0
if(score>topScore)or sdFlag==1 then
data.topScore=score
activitiesModel:setSubActInfoData(actid,subType,subid,data)
local json_str=jsonHelper.encode({2,score,sdFlag})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,subType,subid,json_str)
end
end

function activitiesHandle_rolelingzhendiaoke:reqSelectCampById(actid,subType,subid)


end

function activitiesHandle_rolelingzhendiaoke:reqGetCampScoreDataList(actid,subType,subid)


end




