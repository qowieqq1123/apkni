

UIChuanGongGeControl=gameState.addListener(fullScreenUI.create())

function UIChuanGongGeControl:onAppStart()
socketManager:register_receiver(3,236,self.recv_3_236)

socketManager:register_receiver(3,237,self.recv_3_237)

local menulist=
{
{tabType=FULL_TAB_TYPE.eChuanGongGe,callback=function(...)self:showChuanGongGeWindow(...)end,
sendCallback=function()end},
{tabType=FULL_TAB_TYPE.eChuanGongGeZhuanYeJiNeng,callback=function(...)self:showChuanGongGeJingNengWindow(...)end,},
{tabType=FULL_TAB_TYPE.eLingShouChuanGong,callback=function(...)self:showChuanGongLingShouWindow(...)end,},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eChuanGongGe,

}
self:initUI(args)
end

function UIChuanGongGeControl:onEnterState(isReconnect)
if isReconnect then
return
end
end

function UIChuanGongGeControl:onLeaveState(isReconnect)
if isReconnect then
return
end
end

function UIChuanGongGeControl:showChuanGongGeWindowEx(argstable)
local tabType=argstable.args and argstable.args.tabType or FULL_TAB_TYPE.eChuanGongGe
if tabType==FULL_TAB_TYPE.eChuanGongGe then
UIChuanGongGeControl:showChuanGongGeWindow(argstable)
elseif tabType==FULL_TAB_TYPE.eChuanGongGeZhuanYeJiNeng then
UIChuanGongGeControl:showChuanGongGeJingNengWindow(argstable)
elseif tabType==FULL_TAB_TYPE.eLingShouChuanGong then
UIChuanGongGeControl:showChuanGongLingShouWindow(argstable)
end
end

function UIChuanGongGeControl:showChuanGongGeWindow(argstable)
local tabType=FULL_TAB_TYPE.eChuanGongGe
argstable=argstable or{}
argstable.isMenu=argstable.clickMenu
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIChuanGongGeWin'},
viewArgs={['UIChuanGongGeWin']=argstable},
}
self:showUI(args)
end

function UIChuanGongGeControl:showChuanGongGeJingNengWindow(argstable)
local tabType=FULL_TAB_TYPE.eChuanGongGeZhuanYeJiNeng
argstable=argstable or{}
argstable.isMenu=argstable.clickMenu
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIChuanGongGeWin_JingNeng'},
viewArgs={['UIChuanGongGeWin_JingNeng']=argstable},
}
self:showUI(args)
end

function UIChuanGongGeControl:showChuanGongLingShouWindow(argstable)
local tabType=FULL_TAB_TYPE.eLingShouChuanGong
argstable=argstable or{}
argstable.isMenu=argstable.clickMenu
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIChuanGongGeWin_LingShou'},
viewArgs={['UIChuanGongGeWin_LingShou']=argstable},
}
self:showUI(args)
end


function UIChuanGongGeControl:reqChuanGong(dzId1,dzId2,flag)
socketManager:send_3_236(dzId1,dzId2,flag)
end

function UIChuanGongGeControl.recv_3_236(dzId1,dzId2,ret)
if ret==0 then
local exArgs={tips={}}
UIDiscipleModel:setDZChuangGongReward(exArgs.tips,dzId1)
UIManager:invokeUIMethod('UIChuanGongGeWin','playChuanGong',exArgs)


UIDiscipleController.do_protocol_2_157(dzId1)
end
end

function UIChuanGongGeControl:reqChuanGong_jiNeng(dzId1,dzId2)
socketManager:send_3_237(dzId1,dzId2)
end

function UIChuanGongGeControl.recv_3_237(dzId1,dzId2,ret)
if ret==0 then
local exArgs={tips={}}

UIManager:invokeUIMethod('UIChuanGongGeWin_JingNeng','playChuanGong',exArgs)
end
end


function UIChuanGongGeControl:getJiNengCostConfig(proskill_type,lv)
return cfgHelper.get(cfg_chuangonggeskillconfig_get,proskill_type,lv)
end
