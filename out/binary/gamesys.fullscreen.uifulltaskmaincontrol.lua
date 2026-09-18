








UIFullTaskMainControl=gameState.addListener(fullScreenUI.create())

function UIFullTaskMainControl:onAppStart()
local function _showWindowTask(...)self:showWindowTask(...)end
local function _showWindowDaily(...)self:showWindowDaily(...)end
local function _showWindowLimitAct(...)self:showWindowLimitAct(...)end

local function _initSendPro1(...)self:initSendPro1(...)end
local function _initSendPro2(...)self:initSendPro2(...)end
local function _initSendPro3(...)self:initSendPro3(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eTaskMain_Task,callback=_showWindowTask,sendCallback=_initSendPro1,tagNumber=TagNumberHandleType.eBatchTask},

{tabType=FULL_TAB_TYPE.eTaskMain_Daily,callback=_showWindowDaily,sendCallback=_initSendPro2,reddotType=REDDIT_SUB_TYPE.sDailyTaskBase},

{tabType=FULL_TAB_TYPE.eLimitAct,callback=_showWindowLimitAct,sendCallback=_initSendPro3},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eTaskMain,
skinType=fullScreenSkinType.eSkin7,
}
self:initUI(args)
end


function UIFullTaskMainControl:showWindowTask(argstable)
local args=
{
tabType=FULL_TAB_TYPE.eTaskMain_Task,
showBg=true,
viewNames={'UITaskMainWin'},
viewArgs={['UITaskMainWin']=argstable or{}},
}
self:showUI(args)
return true
end

function UIFullTaskMainControl:showWindowDaily(argstable)
local args=
{
tabType=FULL_TAB_TYPE.eTaskMain_Daily,
showBg=true,
viewNames={'UIDailyTaskWin'},
viewArgs={['UIDailyTaskWin']=argstable or{}},
}
self:showUI(args)
return true
end

function UIFullTaskMainControl:showWindowLimitAct(argstable)
local args=
{
tabType=FULL_TAB_TYPE.eLimitAct,
showBg=true,
viewNames={'UILimitActListWin'},
viewArgs={['UILimitActListWin']=argstable or{}},
}
self:showUI(args)
return true
end

function UIFullDiscipleMainControl:initSendPro1()

end

function UIFullDiscipleMainControl:initSendPro2()

end

function UIFullDiscipleMainControl:initSendPro3()

end