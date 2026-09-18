







UIFullJiuLiDianControl=gameState.addListener(fullScreenUI.create())

function UIFullJiuLiDianControl:onAppStart()
local function _showRongHeWindow(...)self:showRongHeWindow(...)end
local function _showJueXingWindow(...)self:showJueXingWindow(...)end

local function _initSendRongHePro(...)self:initSendRongHePro(...)end
local function _initSendJueXingPro(...)self:initSendJueXingPro(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eLingShouRongHe,callback=_showRongHeWindow,sendCallback=_initSendRongHePro},

{tabType=FULL_TAB_TYPE.eLingShouJueXing,callback=_showJueXingWindow,sendCallback=_initSendJueXingPro},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eLingShouRongHe,

attachName={'entityId'},
}
self:initUI(args)
end

function UIFullJiuLiDianControl:initSendRongHePro()

end

function UIFullJiuLiDianControl:initSendJueXingPro()

end

function UIFullJiuLiDianControl:showRongHeWindow(argstable)

local tabType=FULL_TAB_TYPE.eLingShouRongHe
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UILingShouRongHeWin'},
viewArgs={['UILingShouRongHeWin']=argstable or{}},
}
self:showUI(args)
end

function UIFullJiuLiDianControl:showJueXingWindow(argstable)

local tabType=FULL_TAB_TYPE.eLingShouJueXing
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UILingShouAwakeWin'},
viewArgs={['UILingShouAwakeWin']=argstable or{}},
}
self:showUI(args)
end














