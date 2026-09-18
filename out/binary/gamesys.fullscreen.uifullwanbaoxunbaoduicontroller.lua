








UIFullWanBaoXunBaoDuiController=gameState.addListener(fullScreenUI.create())

function UIFullWanBaoXunBaoDuiController:onAppStart()
local function _showWanBaoXunBaoDuiMTWindow(...)
self:showWanBaoXunBaoDuiMTWindow(...)
end
local function _showWanBaoXunBaoDuiGYWindow(...)
self:showWanBaoXunBaoDuiGYWindow(...)
end
local function _showWanBaoXunBaoDuiDZWindow(...)
self:showWanBaoXunBaoDuiDZWindow(...)
end
local function _initSendPro1(...)self:initSendPro1(...)end
local function _initSendPro2(...)self:initSendPro2(...)end
local function _initSendPro3(...)self:initSendPro3(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eWBXBD_MT,callback=_showWanBaoXunBaoDuiMTWindow,sendCallback=_initSendPro1,reddotType=REDDIT_SUB_TYPE.sWanBaoXunBaoDui_MT},

{tabType=FULL_TAB_TYPE.eWBXBD_GY,callback=_showWanBaoXunBaoDuiGYWindow,sendCallback=_initSendPro2,reddotType=REDDIT_SUB_TYPE.sWanBaoXunBaoDui_GY},

{tabType=FULL_TAB_TYPE.eWBXBD_DZ,callback=_showWanBaoXunBaoDuiDZWindow,sendCallback=_initSendPro3,reddotType=REDDIT_SUB_TYPE.sWanBaoXunBaoDui_DZ},
}


local args=
{
skinType=fullScreenSkinType.eSkin18,
menulist=menulist,
fullType=FULL_TYPE.eWanBaoXunBaoDui,
}
self:initUI(args)
end



function UIFullWanBaoXunBaoDuiController:initSendPro1()
wanBaoXunBaoDuiController:reqAdventureMapInfo()
end

function UIFullWanBaoXunBaoDuiController:initSendPro2()
wanBaoXunBaoDuiController:reqRecruitInfo()
end

function UIFullWanBaoXunBaoDuiController:showMainUI(args)
self:showWanBaoXunBaoDuiMTWindow(args)
end

function UIFullWanBaoXunBaoDuiController:showWanBaoXunBaoDuiMTWindow(argstable)
if not argstable then
argstable={}
end

if not systemModel.isOpen(SYSTEM_DEFINE.eWanBaoXunBaoDuiOpen)then return end

local args=
{
tabType=FULL_TAB_TYPE.eWBXBD_MT,
showBg=true,
showTopMask=true,
viewNames={'UIWanBaoXunBaoDui_MainWin','UIWanBaoXunBaoDui_MTSceneWin'},
viewArgs={['UIWanBaoXunBaoDui_MainWin']=argstable},
}
self:showUI(args)
return true
end

function UIFullWanBaoXunBaoDuiController:showWanBaoXunBaoDuiGYWindow(argstable)
if not argstable then
argstable={}
end

if not systemModel.isOpen(SYSTEM_DEFINE.eWanBaoXunBaoDuiOpen)then return end




local args=
{
tabType=FULL_TAB_TYPE.eWBXBD_GY,
showBg=true,
showTopMask=true,
viewNames={'UIWanBaoXunBaoDui_EmployeeWin','UIWanBaoXunBaoDui_MTSceneWin'},
viewArgs={['UIWanBaoXunBaoDui_EmployeeWin']=argstable},
}
self:showUI(args)
return true
end


function UIFullWanBaoXunBaoDuiController:showWanBaoXunBaoDuiDZWindow(argstable)
if not argstable then
argstable={}
end

if not systemModel.isOpen(SYSTEM_DEFINE.eWanBaoXunBaoDuiOpen)then return end

local args=
{
tabType=FULL_TAB_TYPE.eWBXBD_DZ,
showBg=true,
showTopMask=true,
viewNames={'UIWanBaoXunBaoDui_MTSceneWin','UIWanBaoXunBaoDui_EquipWin'},
viewArgs={['UIWanBaoXunBaoDui_EquipWin']=argstable},
}
self:showUI(args)
return true
end

function UIFullWanBaoXunBaoDuiController:showWanBaoXunBaoDuiRecruitWindow(argstable)
if not argstable then
argstable={}
end

if not systemModel.isOpen(SYSTEM_DEFINE.eWanBaoXunBaoDuiOpen)then return end

local args=
{
tabType=FULL_TAB_TYPE.eWBXBD_MT,
showBg=true,
showTopMask=true,
viewNames={'UIWanBaoXunBaoDui_MTSceneWin','UIWanBaoXunBaoDui_MainWin','UIWanBaoXunBaoDui_RecruitWin'},
viewArgs={['UIWanBaoXunBaoDui_MainWin']=argstable,},
}
self:showUI(args)
return true
end

function UIFullWanBaoXunBaoDuiController:checkReddot()
local channelReddot=UIFullWanBaoXunBaoDuiController:checkChannelReddot()
local recruitReddot=UIFullWanBaoXunBaoDuiController:checkRecruitReddot()
local state=channelReddot or recruitReddot
local index
if channelReddot then
index=1
elseif recruitReddot then
index=2
end
if channelReddot and recruitReddot then
index=3
end
return state,index
end

function UIFullWanBaoXunBaoDuiController:checkMTReddot()
local channelReddot=UIFullWanBaoXunBaoDuiController:checkChannelReddot()
local recruitReddot=UIFullWanBaoXunBaoDuiController:checkRecruitReddot()

return channelReddot or recruitReddot
end

function UIFullWanBaoXunBaoDuiController:checkChannelReddot()
local reddot=false
local channelDatas=wanBaoXunBaoDuiModel:getChannelDatas()
if channelDatas then
for k,v in pairs(channelDatas)do
if v.channel_state>WBXBD_Channel_STATE.doing then
reddot=true
break
end
end
end

return reddot
end

function UIFullWanBaoXunBaoDuiController:checkRecruitReddot()
local reddot=false
local recruitDatas=wanBaoXunBaoDuiModel:getRecruitDatas()
reddot=reddot or#recruitDatas>0
return reddot
end

function UIFullWanBaoXunBaoDuiController:checkGYReddot()
local reddot=false
return reddot
end

function UIFullWanBaoXunBaoDuiController:checkChannelIdleReddot()
local state=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eWBXBDIdleTip)
return not state
end

