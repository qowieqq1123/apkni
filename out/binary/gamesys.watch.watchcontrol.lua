
watchControl=gameState.addListener({})

local _triggerType=nil
local _btnConfig={}

function watchControl:onAppStart()

local function _onClickWatchInfoCallback(...)self:onClickWatchInfoCallback(...)end
local function _onClickAddFriendCallback(...)self:onClickAddFriendCallback(...)end
local function _onClickChatCallback(...)self:onClickChatCallback(...)end


local function _filterWatchInfoCallback(...)self:filterWatchInfoCallback(...)end
local function _filterAddFriendCallback(...)self:filterAddFriendCallback(...)end
local function _filterChatCallback(...)self:filterChatCallback(...)end

_btnConfig=
{
{type=WATCH_BTN_TYPE.eWatchInfo,name='查看信息',func=_onClickWatchInfoCallback,filter=_filterWatchInfoCallback},

{type=WATCH_BTN_TYPE.eAddFrendly,name='添加好友',func=_onClickAddFriendCallback,filter=_filterAddFriendCallback},

{type=WATCH_BTN_TYPE.eChat,name='私聊',func=_onClickChatCallback,filter=_filterChatCallback},
}
socketManager:register_receiver(26,1,wingControl.recv_watchInfo)
end

function watchControl:onEnterState()
_triggerType=nil
end


function watchControl.getBtnConfig()
return _btnConfig
end


function watchControl.getBtnConfigByType(_showtype)
for i=1,#_btnConfig do
if _btnConfig[i].type==_showtype then
return _btnConfig[i]
end
end
end

function watchControl.setTriggerType(typo)
_triggerType=typo
end

function watchControl.get_trigger_type()
return _triggerType
end







function watchControl.reqWatchInfo(actorid,WATCH_TRIIGER_TYPE)
if not WATCH_TRIIGER_TYPE then
error('没有传入查看方式:WATCH_TRIIGER_TYPE')
return
end

watchControl.setTriggerType(WATCH_TRIIGER_TYPE)
end


function wingControl.recv_watchInfo(argstable)































if _triggerType==WATCH_TRIIGER_TYPE.eChat then
args.trigger=WATCH_TRIIGER_TYPE.eAllChat
watchControl:onClickChatCallback(args)
else

end
end







function watchControl.closeWatchPanel()
UIManager:closeWindow('UIRoleWatchWin')
end







function watchControl:onClickAddFriendCallback(argstable)

if argstable~=nil then

end
end

function watchControl:onClickChatCallback(argstable)

end



function watchControl:onClickWatchInfoCallback(argstable)

end







function watchControl:filterAddFriendCallback(argstable)

end


function watchControl:filterChatCallback(argstable)

end


function watchControl:filterWatchInfoCallback(argstable)

end



