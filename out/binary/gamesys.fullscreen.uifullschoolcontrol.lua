








UIFullSchoolControl=gameState.addListener(fullScreenUI.create())

function UIFullSchoolControl:onAppStart()
local function _showSchoolMainWindow(...)self:showSchoolMainWindow(...)end
local function _showSchoolRewardWindow(...)self:showSchoolRewardWindow(...)end

local function _initSendPro1(...)self:initSendPro1(...)end
local function _initSendPro2(...)self:initSendPro2(...)end
local menulist=
{

{tabType=FULL_TAB_TYPE.eSchoolMain,callback=_showSchoolMainWindow,sendCallback=_initSendPro1},

{tabType=FULL_TAB_TYPE.eSchoolReward,callback=_showSchoolRewardWindow,sendCallback=_initSendPro2,reddotType=REDDIT_TYPE.eSchoolReward},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eSchool,
attachName={'entityId'},
}
self:initUI(args)
end


function UIFullSchoolControl:showSchoolMainWindow(argstable)
local tabType=FULL_TAB_TYPE.eSchoolMain
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UISchoolMainWin'},
viewArgs={['UISchoolMainWin']=argstable},
}
UISchoolController:req_data()
self:showUI(args)
return true
end


function UIFullSchoolControl:showSchoolRewardWindow(argstable)
local tabType=FULL_TAB_TYPE.eSchoolReward
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UISchoolRewardWin'},
viewArgs={['UISchoolRewardWin']=argstable},
}
self:showUI(args)
end

function UIFullSchoolControl:initSendPro1()

end

function UIFullSchoolControl:initSendPro2()

end