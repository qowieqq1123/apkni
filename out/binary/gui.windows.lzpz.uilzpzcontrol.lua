

UILZPZControl=gameState.addListener(fullScreenUI.create())

function UILZPZControl:onAppStart()

local args=
{
fullType=FULL_TYPE.eLingZhenPengZhuang,
skinType=fullScreenSkinType.eSkin15,
}
self:initUI(args)
end

function UILZPZControl:onEnterState(isReconnect)
if isReconnect then
return
end

self.receiveFlag=0
self.topScore=0
end

function UILZPZControl:onLeaveState(isReconnect)
if isReconnect then
return
end
end

function UILZPZControl:showGameWin(argstable)
local tabType=FULL_TAB_TYPE.eLingZhenPengZhuang

local args=
{
tabType=tabType,
showBg=true,
showTopMask=true,
viewNames={'UILingZhenPZGameExWin'},
viewArgs={['UILingZhenPZGameExWin']=argstable},
}
self:showUI(args)

return true
end

function UILZPZControl:showMainWin(argstable)
local tabType=FULL_TAB_TYPE.eLingZhenPengZhuang

local args=
{
tabType=tabType,
showBg=true,
showTopMask=true,
viewNames={'UILingZhenPZMainWin'},
viewArgs={['UILingZhenPZMainWin']=argstable},
}
self:showUI(args)

return true
end

function UILZPZControl:isActOpen()
local data=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eLingZhenPengZhuang)
if data and data.state==2 then
return true
end
return false
end


function UILZPZControl:testOpenResultWin(nowScore,originalTopScore,nowTopScore)
lingZhenPengZhuangModel:setTopScore(nowTopScore)
UIManager:showWindow('UILZPZResultWin',{success=true,score=nowScore,originalTopScore=originalTopScore})
end