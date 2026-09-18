







UIFullYuShouFangControl=gameState.addListener(fullScreenUI.create())

function UIFullYuShouFangControl:onAppStart()
local function _showJPWindow(...)self:showJPWindow(...)end

local function _initSendJPPro(...)self:initSendJPPro(...)end

local menulist=
{
{tabType=FULL_TAB_TYPE.eYuShouFang,callback=_showJPWindow,sendCallback=_initSendJPPro},
}


local args={
menulist=menulist,
fullType=FULL_TYPE.eYuShouFang,
attachName={'entityId'},
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

function UIFullYuShouFangControl:showJPWindow(argstable)
local args={
tabType=FULL_TAB_TYPE.eYuShouFang,
showBg=true,
viewNames={'UILingShouYSFJiaoPeiWin'},
viewArgs={['UILingShouYSFJiaoPeiWin']=argstable},
}
self:showUI(args)
end

function UIFullYuShouFangControl:initSendJPPro()

end