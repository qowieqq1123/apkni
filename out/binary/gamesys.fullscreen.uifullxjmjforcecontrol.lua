
UIFullXJMJForceControl=gameState.addListener(fullScreenUI.create())

local _winName={
[1]="UIJiuYuanMainMJWin",
[2]="UIPengLaiMainMJWin",
[3]="UIYuJingMainMJWin",
}

function UIFullXJMJForceControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eMoJieShiLi,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

function UIFullXJMJForceControl:showUIJiuYuanMainMJWindow(argstable)
local viewName='UIJiuYuanMainMJWin'
local args=
{
showBg=true,
showTopMask=true,
viewNames={viewName},
viewArgs={[viewName]=argstable},
}
self:showUI(args)
end

function UIFullXJMJForceControl:showUIPengLaiMainMJWindow(argstable)
local viewName='UIPengLaiMainMJWin'
local args=
{
showBg=true,
showTopMask=true,
viewNames={viewName},
viewArgs={[viewName]=argstable},
}
self:showUI(args)
end

function UIFullXJMJForceControl:showUIYuJingMainMJWindow(argstable)
local viewName='UIYuJingMainMJWin'
local args=
{
showBg=true,
showTopMask=true,
viewNames={viewName},
viewArgs={[viewName]=argstable},
}
self:showUI(args)
end


function UIFullXJMJForceControl:getForceMainWinName(id)
return _winName[id]
end