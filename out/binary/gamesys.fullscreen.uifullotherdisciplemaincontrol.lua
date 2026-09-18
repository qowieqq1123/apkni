







UIFullOtherDiscipleMainControl=gameState.addListener(fullScreenUI.create())

function UIFullOtherDiscipleMainControl:onAppStart()
local function _showWindowInfo(...)self:showWindowInfo(...)end
local function _showWindowAttr(...)self:showWindowAttr(...)end

local function _initSendPro1(...)self:initSendPro1(...)end
local function _initSendPro2(...)self:initSendPro2(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eOtherDiscipleInfo,callback=_showWindowInfo,sendCallback=_initSendPro1},

{tabType=FULL_TAB_TYPE.eOtherDiscipleAttr,callback=_showWindowAttr,sendCallback=_initSendPro2},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eOtherDiscipleMain,
skinType=fullScreenSkinType.eSkin10,
attachName={'dis_guid'},
}
self:initUI(args)
end

function UIFullOtherDiscipleMainControl:myShowWindow(argstable,tabType)
tabType=tabType or FULL_TAB_TYPE.eOtherDiscipleInfo
if tabType==FULL_TAB_TYPE.eOtherDiscipleInfo then
self:showWindowInfo(argstable)
elseif tabType==FULL_TAB_TYPE.eOtherDiscipleAttr then
self:showWindowAttr(argstable)
end
end

function UIFullOtherDiscipleMainControl:showWindowInfo(argstable)
local args=
{
tabType=FULL_TAB_TYPE.eOtherDiscipleInfo,
showBg=true,
viewNames={'UIOtherDiscipleMainWin'},
viewArgs={['UIOtherDiscipleMainWin']=argstable},
}
self:showUI(args)
end


function UIFullOtherDiscipleMainControl:showWindowAttr(argstable)
local args=
{
tabType=FULL_TAB_TYPE.eOtherDiscipleAttr,
showBg=true,
viewNames={'UIOtherDiscipleMainWin'},
viewArgs={['UIOtherDiscipleMainWin']=argstable},
}
self:showUI(args)
end

function UIFullOtherDiscipleMainControl:initSendPro1()

end

function UIFullOtherDiscipleMainControl:initSendPro2()

end
