







UIFullLingZhenHuiHuaRoleControl=gameState.addListener(fullScreenUI.create())

function UIFullLingZhenHuiHuaRoleControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eRoleLingZhenHuiHua,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end



function UIFullLingZhenHuiHuaRoleControl:showMainWin(argstable)
local startCallback=function()
local tabType=FULL_TAB_TYPE.eRoleLingZhenHuiHua
local args={
tabType=tabType,
showFg=false,
showBg=false,
viewNames={'UILingZhenHHroleMainWin'},
viewArgs={['UILingZhenHHroleMainWin']=argstable},
}
self:showUI(args)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end

function UIFullLingZhenHuiHuaRoleControl:showMainWinNoCloud(argstable)
local tabType=FULL_TAB_TYPE.eRoleLingZhenHuiHua
local args={
tabType=tabType,
showFg=false,
showBg=false,
viewNames={'UILingZhenHHroleMainWin'},
viewArgs={['UILingZhenHHroleMainWin']=argstable},
}
self:showUI(args)
end



function UIFullLingZhenHuiHuaRoleControl:showGameWin(argstable)
local startCallback=function()
local tabType=FULL_TAB_TYPE.eRoleLingZhenHuiHua
local args={
tabType=tabType,
showBg=false,
showFg=false,
viewNames={'UILingZhenHHroleGameExWin'},
viewArgs={['UILingZhenHHroleGameExWin']=argstable},
}
self:showUI(args)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end

function UIFullLingZhenHuiHuaRoleControl:showGameWinNoCloud(argstable)
local tabType=FULL_TAB_TYPE.eRoleLingZhenHuiHua
local args={
tabType=tabType,
showBg=false,
showFg=false,
viewNames={'UILingZhenHHroleGameExWin'},
viewArgs={['UILingZhenHHroleGameExWin']=argstable},
}
self:showUI(args)
end

