







UIFullSiFangPingYaoControl=gameState.addListener(fullScreenUI.create())

function UIFullSiFangPingYaoControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eSiFangPingYao,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end


function UIFullSiFangPingYaoControl:showDouFaTaiJumpWin(args)
local ret=systemModel.isOpen(SYSTEM_DEFINE.eFourSidesKillDemons)
if not ret then
if args.warning then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eFourSidesKillDemons)
UIManager.error(tips)
end
return false
end

AudioManager.playBtnClick()
UIFullSiFangPingYaoControl:showSiFangPingYaoMapWin(args,true)
end


function UIFullSiFangPingYaoControl:showDouFaTaiWindow(argstable)
local ret=systemModel.isOpen(SYSTEM_DEFINE.eFourSidesKillDemons)
if not ret then
if argstable.warning then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eFourSidesKillDemons)
UIManager.error(tips)
end
return false
end

UIFullSiFangPingYaoControl:showSiFangPingYaoMapWin({wxdId=wxdId,layer=slayer})
end


function UIFullSiFangPingYaoControl:showSiFangPingYaoMapWin(argstable)
if not SiFangPingYaoModel:checkData()then logErr('四方平妖 未接受到初始化数据')return end
local startCallback=function()
local tabType=FULL_TAB_TYPE.eSiFangPingYaoMap
local args={
tabType=tabType,
showFg=false,
showBg=false,
showTopMask=true,
viewNames={'UISiFangPingYaoMapWin'},
viewArgs={['UISiFangPingYaoMapWin']=argstable},
}
self:showUI(args)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end

function UIFullSiFangPingYaoControl:showSiFangPingYaoMapWinNoCloud(argstable)
local tabType=FULL_TAB_TYPE.eSiFangPingYaoMap
local args={
tabType=tabType,
showFg=false,
showBg=false,
showTopMask=true,
viewNames={'UISiFangPingYaoMapWin'},
viewArgs={['UISiFangPingYaoMapWin']=argstable},
}
self:showUI(args)
end


function UIFullSiFangPingYaoControl:showSiFangPingYaoMainWinNoCloud(argstable)
local tabType=FULL_TAB_TYPE.eSiFangPingYaoMain
local args={
tabType=tabType,
showBg=false,
showFg=false,
showTopMask=true,
viewNames={'UISiFangPingYaoMainWin'},
viewArgs={['UISiFangPingYaoMainWin']=argstable},
}
self:showUI(args)
end


function UIFullSiFangPingYaoControl:showSiFangPingYaoMainWin(argstable)
local startCallback=function()
local tabType=FULL_TAB_TYPE.eSiFangPingYaoMain
local args={
tabType=tabType,
showBg=false,
showFg=false,
showTopMask=true,
viewNames={'UISiFangPingYaoMainWin'},
viewArgs={['UISiFangPingYaoMainWin']=argstable},
}
self:showUI(args)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end