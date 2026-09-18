








UIFullFriendMainControl=gameState.addListener(fullScreenUI.create())

function UIFullFriendMainControl:onAppStart()
local function _showWindowList(...)self:showWindowList(...)end
local function _showWindowAdd(...)self:showWindowAdd(...)end
local function _showWindowApply(...)self:showWindowApply(...)end

local function _initSendPro1(...)self:initSendPro1(...)end
local function _initSendPro2(...)self:initSendPro2(...)end
local function _initSendPro3(...)self:initSendPro3(...)end

local menulist=
{

{tabType=FULL_TAB_TYPE.eFriendList,callback=_showWindowList,reddotType=REDDIT_TYPE.eFriendPoint,sendCallback=_initSendPro1},

{tabType=FULL_TAB_TYPE.eFriendAdd,callback=_showWindowAdd,sendCallback=_initSendPro2},

{tabType=FULL_TAB_TYPE.eFriendApply,callback=_showWindowApply,reddotType=REDDIT_TYPE.eFriend,sendCallback=_initSendPro3},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eFriend,
skinType=fullScreenSkinType.eSkin6,
}
self:initUI(args)
end


function UIFullFriendMainControl:showWindowList(argstable)
local args=
{
tabType=FULL_TAB_TYPE.eFriendList,
showBg=true,
viewNames={'UIFriendListWin'},
viewArgs={['UIFriendListWin']=argstable or{}},
}

self:closeAllWindow()
return self:showUI(args)
end

function UIFullFriendMainControl:showWindowAdd(argstable)
argstable=argstable or{}
argstable.tabIndex=argstable.tabIndex or 1
local args=
{
tabType=FULL_TAB_TYPE.eFriendAdd,
showBg=true,
viewNames={'UIFriendAddWin'},
viewArgs={['UIFriendAddWin']=argstable or{}},
}
friendProtocolController.req_find_friend()
self:closeAllWindow()
return self:showUI(args)
end

function UIFullFriendMainControl:showWindowApply(argstable)
local args=
{
tabType=FULL_TAB_TYPE.eFriendApply,
showBg=true,
viewNames={'UIFriendApplyWin'},
viewArgs={['UIFriendApplyWin']=argstable or{}},
}
friendProtocolController.req_apply_list()
self:closeAllWindow()
return self:showUI(args)
end

function UIFullFriendMainControl:initSendPro1()
friendProtocolController.req_friend_list(eFriendListType.eLocal,1)
friendProtocolController.req_friend_list(eFriendListType.eCross,1)
friendProtocolController.req_friend_list(eFriendListType.eBlack,1)
end

function UIFullFriendMainControl:initSendPro2()
friendProtocolController.req_find_friend()
end

function UIFullFriendMainControl:initSendPro2()
friendProtocolController.req_apply_list()
end