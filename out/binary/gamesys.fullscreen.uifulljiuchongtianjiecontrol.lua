







UIFullJiuChongTianJieControl=gameState.addListener(fullScreenUI.create())

function UIFullJiuChongTianJieControl:onAppStart()

local args={
fullType=FULL_TYPE.eJiuChongTianJieEnter,
skinType=fullScreenSkinType.eSkin5,

}
self:initUI(args)
end

function UIFullJiuChongTianJieControl:showFullWindow(argstable)
if JiuChongTianJieEnterModel:getState()~=eJiuChongTianJieStateType.eDoing then
return false
end
local args={
showBg=true,
viewNames={'UIJiuChongTianJieEnterWin'},
viewArgs={['UIJiuChongTianJieEnterWin']=argstable
},
}

local func=function()
self:showUI(args)
end
loadingControl.openCloud(func,0.5)
return true
end



function UIFullJiuChongTianJieControl:showSubWindow(argstable)
if JiuChongTianJieEnterModel:getState()~=eJiuChongTianJieStateType.eDoing then
return false
end
if argstable and argstable.sysType and not self:checkSubOpen(argstable.sysType)then
return false
end
local args={
showBg=true,
viewNames={'UIJiuChongTianJieEnterWin'},
viewArgs={['UIJiuChongTianJieEnterWin']=argstable,
},
}

local func=function()
self:showUI(args)
self:showWindow("UIJiuChongTianJieSubWin",argstable)
end
loadingControl.openCloud(func,0.5)
return true
end

function UIFullJiuChongTianJieControl:checkSubOpen(sysType)
local isShield=JiuChongTianJieEnterModel:isShield(sysType)
if isShield then
return false
end
local unlock=JiuChongTianJieEnterModel:getSysConditon(sysType)
if not unlock then
return false
end
return true
end