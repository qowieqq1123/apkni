







local _LuaHelper=CS.LuaHelper

activitiesHandle_lingzhendiaoke=new_activitiesHandle('activitiesHandle_lingzhendiaoke',activitiesHandle)



local showRewards

function activitiesHandle_lingzhendiaoke:onEnterState()

end

function activitiesHandle_lingzhendiaoke:onLeaveState()

end

function activitiesHandle_lingzhendiaoke:get_showRewards()
return showRewards
end


function activitiesHandle_lingzhendiaoke.recv_249_249(args)






local subType=SUB_ACTIVITY_TYPE.eLingZhenHuiHua
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data==nil then return end

data.topScore=args[3]or 0
data.campId=args[4]
data.isInit=true
data.maxScore=args[5]
data.sdFlag=args[6]


local updateLongTime=timeHelper.getTodayZeroStamp()
local nowTime=timeHelper.getServerLongTime()
if updateLongTime<nowTime then
updateLongTime=updateLongTime+86400
end
data.nextUpdateDataTime=timeHelper.convertShortStamp(updateLongTime)

activitiesModel:setSubActInfoData(actID,subType,subID,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

UIManager:callWindowFunc('UILingZhenHHMainWin','refresh')

end


function activitiesHandle_lingzhendiaoke.recv_249_250(...)



local args={...}
local subType=SUB_ACTIVITY_TYPE.eLingZhenHuiHua
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data==nil then return end

data.ftype=args[3]

activitiesModel:setSubActInfoData(actID,subType,subID,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)

UIManager:callWindowFunc('UILingZhenHHGameExWin','handleSkill',data.ftype)
end


function activitiesHandle_lingzhendiaoke.recv_249_251(...)




local args={...}
local subType=SUB_ACTIVITY_TYPE.eLingZhenHuiHua
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


function activitiesHandle_lingzhendiaoke.recv_249_252(...)



local args={...}
local subType=SUB_ACTIVITY_TYPE.eLingZhenHuiHua
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data==nil then return end

data.campId=args[3]

activitiesModel:setSubActInfoData(actID,subType,subID,data)


UIManager:invokeUIMethod("UILingZhenHHMainWin","refreshStartGamePanel",true)
end


function activitiesHandle_lingzhendiaoke.recv_249_253(...)




local args={...}
local subType=SUB_ACTIVITY_TYPE.eLingZhenHuiHua
local actID=args[1]
local subID=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subID)
if data==nil then return end

data.campDataList={}
local nowTime=timeHelper.getServerShortTime()
local nextUpdateTime=nowTime+3600
if args[3]>0 then
for i,v in ipairs(args[4])do
local campData={}
local campId=v.param_1
campData.id=campId
campData.score=v.param_2
campData.lastUpdateTime=v.param_3
campData.nextUpdateTime=nextUpdateTime
data.campDataList[campId]=campData
end
end

activitiesModel:setSubActInfoData(actID,subType,subID,data)


UIManager:callWindowFunc('UILingZhenHHMainWin','refresh')
end




function activitiesHandle_lingzhendiaoke:reqUseSkill(actid,subType,subid,ftype)
local json_str=jsonHelper.encode({1,ftype})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,subType,subid,json_str)
end

function activitiesHandle_lingzhendiaoke:reqSetScore(actid,subType,subid,score,sdFlag)
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

function activitiesHandle_lingzhendiaoke:reqSelectCampById(actid,subType,subid)
local json_str=jsonHelper.encode({3})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,subType,subid,json_str)
end

function activitiesHandle_lingzhendiaoke:reqGetCampScoreDataList(actid,subType,subid)
local json_str=jsonHelper.encode({4})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actid,subType,subid,json_str)
end




