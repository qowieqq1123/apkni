








UIFullXJCaravanEscortController=gameState.addListener(fullScreenUI.create())

function UIFullXJCaravanEscortController:onAppStart()

local args=
{
skinType=fullScreenSkinType.eSkin5,
fullType=FULL_TYPE.eXJCaravanEscort,
}
self:initUI(args)
end

function UIFullXJCaravanEscortController:showMainWindow(argstable)
if not argstable then
argstable={}
end

local args=
{
showBg=true,
showTopMask=true,
viewNames={'UIXJCaravanEscort_mainWin'},
viewArgs={['UIXJCaravanEscort_mainWin']=argstable},
}
self:showUI(args)
end

function UIFullXJCaravanEscortController:showMainWindow_openEscortMsg(pageIdx,posIdx,shipGuid)
local argstable={
selectPageIdx=pageIdx,
openMsgPosIdx=posIdx,
openMsgShipGuid=shipGuid,
}

local args=
{
showBg=true,
showTopMask=true,
viewNames={'UIXJCaravanEscort_mainWin'},
viewArgs={['UIXJCaravanEscort_mainWin']=argstable},
}
self:showUI(args)
end

function UIFullXJCaravanEscortController:showMainWindow_openRecordWin(pageIdx)
local argstable={
selectPageIdx=pageIdx,
openRecordWin=true
}

local args=
{
showBg=true,
showTopMask=true,
viewNames={'UIXJCaravanEscort_mainWin'},
viewArgs={['UIXJCaravanEscort_mainWin']=argstable},
}
self:showUI(args)
end


function UIFullXJCaravanEscortController:showMainWindow_openShipRecordWin(shipGuid,isOpenWithMainWin)
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(shipGuid)
if not shipData then
UIManager.error("派遣已完成，无法查看仙舟详情")
return
end

if not isOpenWithMainWin then
local showType=2
local guid=shipGuid
xianjieController:openXJCaravanEscortShipMsgWin(showType,guid,true)
else
local posData=xianJieCaravanEscortModel:getSelfEscortShipPosDataListByShipGuid(shipGuid)
local posIdx=posData and posData.pos or nil

local argstable={
selectPageIdx=1,
openMsgPosIdx=posIdx,
openRecordWin=true,
}

local args=
{
showBg=true,
showTopMask=true,
viewNames={'UIXJCaravanEscort_mainWin'},
viewArgs={['UIXJCaravanEscort_mainWin']=argstable},
}
self:showUI(args)
end

end

function UIFullXJCaravanEscortController:showMainWindowByJump(param)

if not systemModel.isOpen(SYSTEM_DEFINE.eMiaoXingShangLv)then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eMiaoXingShangLv)
UIManager.error(tips)
return
end

return limitActivitiesController:jump(LIMIT_ACT_TYPE.eMiaoXingShangLv,param)
end