









function xianjieController:onEnterState_RebuildPreview(isReconnet)
xianjieController:readLocalInfo_XianJie_ReBuildPreview()
notifySystem:listenNotify(notifyConfig.onEnterHomeFinish,self.onEnterHomeFinish)
end

function xianjieController:onLeaveState_RebuildPreview(isReconnet)

notifySystem:removelistener(notifyConfig.onEnterHomeFinish,self.onEnterHomeFinish)

self.rebuildPreviewActEnterHandle=nil
end

function xianjieController:onEnterHomeFinish()
xianjieController:fresh_XianJieRebuildPreview()
end


function xianjieController:fresh_XianJieRebuildPreview()
xianjieController:freshActEnter_Xianjie_ReBuildPreview()
xianjieController:showMsg_Xianjie_ReBuildPreview()
end

local _error_result={
noInCrossServer=1,
noInOpenDuration=2,
}
function xianjieController:checkCondiiton_Xianjie_ReBuildPreview(data)

if data==nil then return end

if not next(data)then



return false
end

local cross_sids=data.cross_sids
if cross_sids==nil then



return false
end

local begin_time=data.begin_time
local end_time=data.end_time
if begin_time==nil and end_time~=nil then



return false
end

local crossServerId=loginModel:getCrossServerId()


if not table.findValueEx(cross_sids,crossServerId,function(val)return tostring(val)end)then
return false,_error_result.noInCrossServer
end

local nowServerTime=timeHelper.getServerShortTime()
if nowServerTime<begin_time and nowServerTime>=end_time then
return false,_error_result.noInOpenDuration
end

return true
end

function xianjieController:getPreviewData()
local data=houtaiModel:getXianJieReBuildPreviewData()



if self.testXianJieRebuildPreview then
data={}
local time=timeHelper.getServerShortTime()
data.cross_sids={loginModel:getCrossServerId()}
data.begin_time=time
data.end_time=time+7200
end

return data or{}
end

function xianjieController:freshActEnter_Xianjie_ReBuildPreview()


local data=xianjieController:getPreviewData()

local isAdd=self:checkCondiiton_Xianjie_ReBuildPreview(data)

if not isAdd then

limitActivitiesModel:removeActInfo(LIMIT_ACT_TYPE.eXianJie_RebuildPreview)
return
end


limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eXianJie_RebuildPreview,data.begin_time,data.end_time)
end

function xianjieController:show_Xianjie_ReBuildPreview()
local data=xianjieController:getPreviewData()
local result,errorIdx=self:checkCondiiton_Xianjie_ReBuildPreview(data)

if not result then return end

local winArgs={groupId=1,beginTime=data.begin_time,endTime=data.end_time,countDownEndTips="预告已结束",timeFmt="重组倒计时：{0}"}

UIManager:showWindow("UICommonVisualGuideWin",winArgs)
end

function xianjieController:showMsg_Xianjie_ReBuildPreview()
if self.isShowed then return end


local data=xianjieController:getPreviewData()


local result,errorIdx=self:checkCondiiton_Xianjie_ReBuildPreview(data)

if not result then return end

local winArgs={groupId=1,beginTime=data.begin_time,endTime=data.end_time,countDownEndTips="预告已结束",timeFmt="重组倒计时：{0}",closeCallBack=function()xianjieController:writeLocalInfo_XianJie_ReBuildPreview()end}

msgWinControl:addMsgWin(msgWinType.eXianJieRebuildPreview,winArgs,nil,true)
end


local localInfoKey_XianJie_ReBuildPreview='localInfo_XianJie_ReBuildPreview'
function xianjieController:readLocalInfo_XianJie_ReBuildPreview()
local isShowFlag=userActorSetting.get(localInfoKey_XianJie_ReBuildPreview,0)

self.isShowed=isShowFlag==1
end

function xianjieController:writeLocalInfo_XianJie_ReBuildPreview()
self.isShowed=true
userActorSetting.set(localInfoKey_XianJie_ReBuildPreview,1)
userActorSetting.flush()
end

function xianjieController:resetLocalInfo_XianJie_ReBuildPreview()
userActorSetting.set(localInfoKey_XianJie_ReBuildPreview,0)
userActorSetting.flush()
self.isShowed=false
end


function xianjieController:test_XianJie_ReBuildPreview()
self.testXianJieRebuildPreview=true
xianjieController:fresh_XianJieRebuildPreview()
end

function xianjieController:test_PrintLimitActInfo()
local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eXianJie_RebuildPreview)


end



