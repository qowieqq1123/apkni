
UIFullZheXianControl=gameState.addListener(fullScreenUI.create())

local _winType=
{
eZhangJie=1,
eDaoTu=2,
eJiYuan=3,
}
UIFullZheXianControl.winType=_winType

function UIFullZheXianControl:onAppStart()
local args={
fullType=FULL_TYPE.eZheXianLing,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

function UIFullZheXianControl:showZheXianLingWindow(argstable)
if not systemModel.isOpen(SYSTEM_DEFINE.eZeXianLing)then
local msg=systemModel.getOpenTips(SYSTEM_DEFINE.eZeXianLing)
UIManager.error(msg)
return false
end
local isWait,desc=zheXianLingController:isWaitNextOpen()
local winType
argstable=argstable or{}
if isWait then
winType=_winType.eJiYuan
else
winType=argstable.winType or _winType.eZhangJie
end
argstable.winType=winType
local args={
showBg=false,
viewNames={'UIZheXianLingWin'},
viewArgs={['UIZheXianLingWin']=argstable},
}
self:showUI(args)
return true
end


function UIFullZheXianControl:showZheXianLingZhangJieWindow(argstable)
self:showZheXianLingWindow({winType=_winType.eZhangJie})
end

function UIFullZheXianControl:showZheXianLingDaoTuWindow(argstable)
self:showZheXianLingWindow({winType=_winType.eDaoTu})
end

function UIFullZheXianControl:showZheXianLingJiYuanWindow(argstable)
self:showZheXianLingWindow({winType=_winType.eJiYuan})
end

