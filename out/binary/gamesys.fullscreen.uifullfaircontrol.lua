




UIFullFairControl=gameState.addListener(fullScreenUI.create())

function UIFullFairControl:onAppStart()
local function _showFairWindow(...)self:showFairWindow(...)end
local function _showGuiShiWindow(...)self:showGuiShiWindow(...)end

local function _initSendFairPro(...)self:initSendFairPro(...)end
local function _initSendGuiShiPro(...)self:initSendGuiShiPro(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eFangShi,callback=_showFairWindow,sendCallback=_initSendFairPro},

{tabType=FULL_TAB_TYPE.eGuiShi,callback=_showGuiShiWindow,sendCallback=_initSendGuiShiPro,reddotType=REDDIT_SUB_TYPE.sHeiShi},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eFair,
attachName={'entityId'},
}
self:initUI(args)
end


function UIFullFairControl:showFairWindow(argstable)
local tabType=FULL_TAB_TYPE.eFangShi
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIFairWin'},
viewArgs={['UIFairWin']=argstable},
}
fairController:req_data()
self:showUI(args)
return true
end

function UIFullFairControl:showGuiShiWindow(argstable)
local tabType=FULL_TAB_TYPE.eGuiShi
argstable.fairType=eFairType.eBlackMarket

local tips=fairModel:get_tips_config(eFairType.eBlackMarket)
if tips then
argstable.talkTips=tips
end

local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIGuiShiWin'},
viewArgs={['UIGuiShiWin']=argstable},
}
self:showUI(args)
end

function UIFullFairControl:initSendFairPro()

end

function UIFullFairControl:initSendGuiShiPro()

end
