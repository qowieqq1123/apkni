
UIFullTianMingZengLiController=gameState.addListener(fullScreenUI.create())

function UIFullTianMingZengLiController:onAppStart()
local function _showWindowTianMingZengLi(...)self:showWindowTianMingZengLi(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eTianMingZengLi,callback=_showWindowTianMingZengLi,reddotType=REDDIT_SUB_TYPE.sTMZLsys},
}

local args=
{
skinType=fullScreenSkinType.eSkin11,
menulist=menulist,
fullType=FULL_TYPE.eTianMingZengLi,
}
self:initUI(args)
end

function UIFullTianMingZengLiController:showWindowTianMingZengLi(argstable)

local args=
{
tabType=FULL_TAB_TYPE.eTianMingZengLi,
showBg=true,
showTopMask=true,


viewNames={'UITianmingSysWin'},
viewArgs={['UITianmingSysWin']=argstable or{}},

}
self:showUI(args)
return true
end

function UIFullTianMingZengLiController:showMainUI(args)
local isCanOpenWin=tianmingzengliController:checkIsCanOpenTMZLWin()
if isCanOpenWin then
if not activitiesController:jumpSystem_subType(SUB_ACTIVITY_TYPE.eTianMingZengLi_sys,args)then
self:showWindowTianMingZengLi(args)
end
end
return isCanOpenWin
end