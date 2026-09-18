









local limitActInfo_miaoxingshanglv={name='miaoxingshanglv'}


function limitActInfo_miaoxingshanglv:onInit()

end


function limitActInfo_miaoxingshanglv:onStart()


xianJieCaravanEscortController:reqGetSelfEscortData()

xianJieCaravanEscortModel:setXJCaravanEscortActCanDispatchEndTime()
end


function limitActInfo_miaoxingshanglv:onUpdate()
if self:checkDoing()then
local canDispatchEndTime=xianJieCaravanEscortModel:getXJCaravanEscortActCanDispatchEndTime()
if canDispatchEndTime and canDispatchEndTime>0 then
local nowTime=timeHelper.getServerShortTime()
if nowTime>=canDispatchEndTime then
local isChange=self.isInCanDispatchTime==true
self.isInCanDispatchTime=false

if isChange then

notifySystem:postNotify(notifyConfig.onXJCaravanEscortCanDispatchTimeEnd)
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eMiaoXingShangLv)
end
else
self.isInCanDispatchTime=true
end

end
end
end


function limitActInfo_miaoxingshanglv:onDelete()

end


function limitActInfo_miaoxingshanglv:onFinish()
self.isInCanDispatchTime=false

end


function limitActInfo_miaoxingshanglv:checkReddot()
return xianJieCaravanEscortModel:checkCaravanEscortEnterReddot()
end


function limitActInfo_miaoxingshanglv:jump(args)

local openFunc=function()
if args and args.needAddShipGuid then
local shipGuid=args.needAddShipGuid
xianJieCaravanEscortController:addCaravanEscortTeamByShipGuid(shipGuid)
end

return UIFullXJCaravanEscortController:showMainWindow(args)
end









local sceneType=xianjieModel:getScenceType()
if not sceneType or not(xianjienSceneType:isXianYu(sceneType)or sceneType==xianjienSceneType.eXianJie)then

local show_data=
{
title='提示',
_okText="确定",
_cancelText="取消",
tipsText="喵行商旅需前往仙界查看，是否前往？",
closetopbtn=true,
cellcallback=function()
fullScreenUI.closeActiveUI(false,true)
return xianjieController:jumpXianJie(xianjienSceneType.eXianJie,nil,openFunc)
end,
}
UIManager:showWindow('UIDialougeNormalTip',show_data)
else
fullScreenUI.closeActiveUI(false,true)
openFunc()
end
end

return limitActInfo_miaoxingshanglv