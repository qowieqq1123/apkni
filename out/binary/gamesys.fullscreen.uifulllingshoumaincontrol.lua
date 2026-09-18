







UIFullLingShouMainControl=gameState.addListener(fullScreenUI.create())

function UIFullLingShouMainControl:onAppStart()
local function _showWindowInfo(...)self:showWindowInfo(...)end
local function _showWindowJingJie(...)self:showWindowJingJie(...)end
local function _showWindowQianLi(...)self:showWindowQianLi(...)end
local function _showWindowXueMai(...)self:showWindowXueMai(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eLingShouInfo,callback=_showWindowInfo,reddotType=REDDIT_SUB_TYPE.sLingShouInfo,},

{tabType=FULL_TAB_TYPE.eLingShouJingJie,callback=_showWindowJingJie,reddotType=REDDIT_SUB_TYPE.sLingShouJingJie},



{tabType=FULL_TAB_TYPE.eLingShouXueMai,callback=_showWindowXueMai,reddotType=REDDIT_SUB_TYPE.sLingShouXueMai},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eLingShouMain,
skinType=fullScreenSkinType.eSkin9,
attachName={'ls_guid','showPage','showShareBtn'},
}
self:initUI(args)
end

function UIFullLingShouMainControl:myShowWindow(argstable,tabType)









UIFullLingShouMainControl:myShowWindowEx(argstable,tabType)
return true
end

function UIFullLingShouMainControl:myShowWindowEx(argstable,tabType)
tabType=tabType or argstable.tabType
if tabType==nil then
tabType=FULL_TAB_TYPE.eLingShouInfo
argstable.tabType=tabType
end
if tabType==FULL_TAB_TYPE.eLingShouInfo then
self:showWindowInfo(argstable)
elseif tabType==FULL_TAB_TYPE.eLingShouJingJie then
self:showWindowJingJie(argstable)
elseif tabType==FULL_TAB_TYPE.eLingShouQianLi then
self:showWindowQianLi(argstable)
elseif tabType==FULL_TAB_TYPE.eLingShouXueMai then
self:showWindowXueMai(argstable)
end
end

function UIFullLingShouMainControl:showWindowInfo(argstable)
local tabType=FULL_TAB_TYPE.eLingShouInfo
argstable.showPage=self:getTabIdx(tabType)
argstable.showShareBtn=argstable.showShareBtn or false
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UILingShouMainWin'},
viewArgs={['UILingShouMainWin']=argstable or{}},
}
self:showUI(args)
end


function UIFullLingShouMainControl:showWindowJingJie(argstable)
local tabType=FULL_TAB_TYPE.eLingShouJingJie
argstable.showPage=self:getTabIdx(tabType)
argstable.showShareBtn=argstable.showShareBtn or false
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UILingShouMainWin'},
viewArgs={['UILingShouMainWin']=argstable},
}
self:showUI(args)
end

function UIFullLingShouMainControl:showWindowQianLi(argstable)
local tabType=FULL_TAB_TYPE.eLingShouQianLi
argstable.showPage=self:getTabIdx(tabType)
argstable.showShareBtn=argstable.showShareBtn or false
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UILingShouMainWin'},
viewArgs={['UILingShouMainWin']=argstable},
}
self:showUI(args)
end

function UIFullLingShouMainControl:showWindowXueMai(argstable)
local tabType=FULL_TAB_TYPE.eLingShouXueMai
argstable.showPage=self:getTabIdx(tabType)
argstable.showShareBtn=argstable.showShareBtn or false
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UILingShouMainWin'},
viewArgs={['UILingShouMainWin']=argstable},
}
self:showUI(args)
end

function UIFullLingShouMainControl:initSendPro1()

end

function UIFullLingShouMainControl:initSendPro2()

end

function UIFullLingShouMainControl:initSendPro3()

end

function UIFullLingShouMainControl:initSendPro4()

end


local _infoSingleTabConfig={
{tabType=FULL_TAB_TYPE.eLingShouInfo,},
}

function UIFullLingShouMainControl:showWindow_SingleInfoTab(parent,mainWinArgs)
local args={
menuConfig=_infoSingleTabConfig,
titleName="灵兽列表",
selectMenuIdx=1,
mainWinArgs=mainWinArgs,
canvas=5
}

parent:showWindow("UILingShouSpeTabMaskWin",args)
end