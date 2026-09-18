







UIFullShanMenControl=gameState.addListener(fullScreenUI.create())

function UIFullShanMenControl:onAppStart()
local function _showInfoWindow(...)self:showInfoWindow(...)end
local function _showDaZhenWindow(...)self:showDaZhenWindow(...)end
local function _showLiChangWindow(...)self:showLiChangWindow(...)end

local function _initSendPro1(...)self:initSendPro1(...)end
local function _initSendPro2(...)self:initSendPro2(...)end
local function _initSendPro3(...)self:initSendPro3(...)end

local menulist=
{






}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eShanMen,
}
self:initUI(args)
end

function UIFullShanMenControl:showInfoWindow(argstable)
local tabType=FULL_TAB_TYPE.eShanMenInfo
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIZongmenInfoWin'},
skinType=fullScreenSkinType.eSkin3,
}
self:showUI(args)
end

function UIFullShanMenControl:showDaZhenWindow(argstable)
local tabType=FULL_TAB_TYPE.eShanMenDaZhen
local args=
{
tabType=tabType,
showBg=true,
showTopMask=true,
viewNames={'UIShanMenDaZhen_mainWin'},
skinType=fullScreenSkinType.eSkin22,
}
self:showUI(args)
end

function UIFullShanMenControl:showLiChangWindow(argstable)
local tabType=FULL_TAB_TYPE.eShanMenLiChang
end

function UIFullShanMenControl:initSendPro1()

end

function UIFullShanMenControl:initSendPro2()

end

function UIFullShanMenControl:initSendPro3()

end

function UIFullShanMenControl:showDaZhenLevelUpWindow()
self:showWindow("UIShanMenDaZhen_levelUpWin")
end

function UIFullShanMenControl:showDaZhenBatchLevelUpWindow()
self:showWindow("UIShanMenDaZhen_batchLevelUpWin")
end

function UIFullShanMenControl:showDaZhenLevelUpFinishWindow(lastBuildLevel)
self:showWindow("UIShanMenDaZhen_lvUpFinishWin",{lastBuildLevel=lastBuildLevel})
end

function UIFullShanMenControl:showDaZhenLevelPreviewWindow()
self:showWindow("UIShanMenDaZhen_lvPreviewWin")
end