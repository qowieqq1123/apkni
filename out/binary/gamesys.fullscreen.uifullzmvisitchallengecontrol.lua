UIFullZMVisitChallengeControl=gameState.addListener(fullScreenUI.create())

function UIFullZMVisitChallengeControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eZongMenVisitorChallenge,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end


function UIFullZMVisitChallengeControl:showZMVisitChallengeWin(argstable,warning)
if not self:checkEnter(warning)then return false end
if not zmvisitchallengeController:enterFightScene()then
argstable=argstable or{}
local tabType=FULL_TAB_TYPE.eZongmenVisitorChallenge
local args=
{
tabType=tabType,
showBg=true,
viewNames={'UIZongMenVisitorChallengeMainWin','UITopMaskWin'},
viewArgs={['UIZongMenVisitorChallengeMainWin']=argstable},
}
self:showUI(args)
end
return true
end

function UIFullZMVisitChallengeControl:checkEnter(warning)
local ret=systemModel.isOpen(SYSTEM_DEFINE.eVisitor)
if not ret then
if warning then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eVisitor)
UIManager.error(tips)
end
return false
end

return true
end