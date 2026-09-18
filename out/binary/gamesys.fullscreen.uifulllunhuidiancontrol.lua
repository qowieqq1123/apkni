




UIFullLunHuiDianControl=gameState.addListener(fullScreenUI.create())

function UIFullLunHuiDianControl:onAppStart()

local _showZHWindow=function(...)
self:showZHWindow(...)
end
local _showHQTWindow=function(...)
self:showHQTWindow(...)
end

local _checkOpenZH=function(...)
return true
end
local _checkOpenHQT=function(...)
return LunHuiDianModel:checkHQTSystem()
end

local menulist=
{

{tabType=FULL_TAB_TYPE.eLunHuiDian_zh,callback=_showZHWindow,checkOpen=_checkOpenZH},

{tabType=FULL_TAB_TYPE.eLunHuiDian_hqt,callback=_showHQTWindow,checkOpen=_checkOpenHQT},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eLunHuiDian,
skinType=fullScreenSkinType.eSkin24,
attachName={'entityId'},
}
self:initUI(args)
end


function UIFullLunHuiDianControl:showMainWindow(argstable)
argstable=argstable or{}
self:showZHWindow(argstable)
end

function UIFullLunHuiDianControl:showMainHQTWindow(argstable)
argstable=argstable or{}
self:showHQTWindow(argstable)
end


function UIFullLunHuiDianControl:showZHWindow(argstable)
argstable=argstable or{}
local tabType=FULL_TAB_TYPE.eLunHuiDian_zh
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UILunHuiDianWin'},
viewArgs={['UILunHuiDianWin']=argstable},
}
self:showUI(args)
return true
end


function UIFullLunHuiDianControl:showHQTWindow(argstable)
argstable=argstable or{}
local tabType=FULL_TAB_TYPE.eLunHuiDian_hqt
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIHunQiTaiWin'},
viewArgs={['UIHunQiTaiWin']=argstable},
}
self:showUI(args)
return true
end