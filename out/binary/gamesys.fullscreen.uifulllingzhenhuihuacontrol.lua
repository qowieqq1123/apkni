







UIFullLingZhenHuiHuaControl=gameState.addListener(fullScreenUI.create())

function UIFullLingZhenHuiHuaControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eLingZhenHuiHua,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end



function UIFullLingZhenHuiHuaControl:showMainWin(argstable)
local startCallback=function()
local tabType=FULL_TAB_TYPE.eLingZhenHuiHua
local args={
tabType=tabType,
showFg=false,
showBg=false,
viewNames={'UILingZhenHHMainWin'},
viewArgs={['UILingZhenHHMainWin']=argstable},
}
self:showUI(args)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end

function UIFullLingZhenHuiHuaControl:showMainWinNoCloud(argstable)
local tabType=FULL_TAB_TYPE.eLingZhenHuiHua
local args={
tabType=tabType,
showFg=false,
showBg=false,
viewNames={'UILingZhenHHMainWin'},
viewArgs={['UILingZhenHHMainWin']=argstable},
}
self:showUI(args)
end



function UIFullLingZhenHuiHuaControl:showGameWin(argstable)
local startCallback=function()
local tabType=FULL_TAB_TYPE.eLingZhenHuiHua
local args={
tabType=tabType,
showBg=false,
showFg=false,
viewNames={'UILingZhenHHGameExWin'},
viewArgs={['UILingZhenHHGameExWin']=argstable},
}
self:showUI(args)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end

function UIFullLingZhenHuiHuaControl:showGameWinNoCloud(argstable)
local tabType=FULL_TAB_TYPE.eLingZhenHuiHua
local args={
tabType=tabType,
showBg=false,
showFg=false,
viewNames={'UILingZhenHHGameExWin'},
viewArgs={['UILingZhenHHGameExWin']=argstable},
}
self:showUI(args)
end

