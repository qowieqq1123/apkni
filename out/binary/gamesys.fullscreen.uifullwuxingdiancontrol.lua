UIFullWuXingDianControl=gameState.addListener(fullScreenUI.create())

function UIFullWuXingDianControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eWuXingDian,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end


function UIFullWuXingDianControl:showWuXingDian(argstable,warning)
if not self:checkEnter(warning)then return false end
if not wuXingDianController:enterFightScene()then
argstable=argstable or{}
local tabType=FULL_TAB_TYPE.eWuXingDian
local args=
{
tabType=tabType,
showBg=true,
showTopMask=true,
viewNames={'UIWuXingDianMainWin'},
viewArgs={['UIWuXingDianMainWin']=argstable},
}
self:showUI(args)
end
return true
end

function UIFullWuXingDianControl:showWuXingDianWithLoading(argstable,warning)
if not self:checkEnter(warning)then return false end
if not wuXingDianController:enterFightScene()then
local func=function()
UIFullWuXingDianControl:showWuXingDian(argstable)
loadingControl.closeCloud()
end
loadingControl.openCloud(func)
end
return true
end

function UIFullWuXingDianControl:checkEnter(warning)
local ret=systemModel.isOpen(SYSTEM_DEFINE.eWuXingDian)
if not ret then
if warning then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eWuXingDian)
UIManager.error(tips)
end
return false
end
local build_id=SLG_SYSTEM_TYPE.eShiLianTa
local bdData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,build_id)
if bdData==nil then
if warning then
local name=cfgHelper.get2(cfg_monijybuildconfig_get,build_id,'name')
UIManager.error(FMT.fmt('尚未建造{0}',name))
end
return false
end
return true
end