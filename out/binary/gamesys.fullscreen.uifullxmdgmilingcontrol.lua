








UIFullXMDGMiLingControl=gameState.addListener(fullScreenUI.create())

function UIFullXMDGMiLingControl:onAppStart()

local function _showWindowMiLingWin(...)self:showWindowMiLingWin(...)end

local function _checkOpen1(...)return self:checkOpen1(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eXMDGPass,callback=_showWindowMiLingWin,reddotType=REDDIT_SUB_TYPE.sXMDGPass,checkOpen=_checkOpen1,},
}

local args=
{
skinType=fullScreenSkinType.eSkin11,
menulist=menulist,
fullType=FULL_TYPE.eXMDGPass,
}
self:initUI(args)
end

function UIFullXMDGMiLingControl:showWindowMiLingWin(argstable)

local args=
{
tabType=FULL_TAB_TYPE.eXMDGPass,
showBg=true,
showTopMask=true,
viewNames={'UIXM_XMDG_MiLingWin'},
viewArgs={['UIXM_XMDG_MiLingWin']=argstable or{}},

}
self:showUI(args)
if argstable.nextFunc then
local func=function()
argstable.nextFunc()
end
fullScreenUI.setNextActiveUICallback(func)
end
return true
end

function UIFullXMDGMiLingControl:checkOpen1(argstable)
return true
end