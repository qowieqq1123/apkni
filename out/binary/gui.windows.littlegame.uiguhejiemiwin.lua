







def_class("UIGuHeJieMiWin",UIWindowBase)









function UIGuHeJieMiWin:bindComponents()

self.bottom=UIObject.get(self,0)
self.btnClose=UIButton.get(self,1)
self.btnStart=UIButton.get(self,2)
self.effect=UIObject.get(self,3)
self.map=UIObject.get(self,4)
self.mask=UIObject.get(self,5)
self.progressBar=UIProgress.get(self,6)
self.timeTxt=UIText.get(self,7)
self.timeTxt0=UIText.get(self,8)
self.title=UIText.get(self,9)
self.tybg=UIImage.get(self,10)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.btnStart:setButtonClick(function()self:onBtnStart()end)



end


function UIGuHeJieMiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bottom);self.bottom=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.btnStart);self.btnStart=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.map);self.map=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.timeTxt0);self.timeTxt0=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.tybg);self.tybg=nil;
end

















local eBlockType=
{
eSpecial=0,
eVShort=1,
eVLong=2,
eHShort=3,
eHLong=4,
}


local blockCmpIndex=
{
widget=0,
root=1,
bg=2,
}


local _sensitivity=1.2


local _gridSide=75


local _xPos=-220
local _yPos=220

local xMax=6
local yMax=6

local fixed=0.95




function UIGuHeJieMiWin:onLoaded(...)
self:bindComponents()

webGLHelper:uiWindowCloseCamera(self.tybg)
end


function UIGuHeJieMiWin:__delete()
self:stopGameTimer()
self:unbindComponents()

webGLHelper:uiWindowShowCamera()
end




function UIGuHeJieMiWin:onShow(argtable,afterOnloaded)
self.args=argtable
self.argtime=self.args.time
self.isWin=0
self.isGaming=false
self.isClosing=false
if self.args.isShowCloseBtn and self.args.isShowCloseBtn==1 then
self.btnClose:setActive(false)
end
self:updateData(argtable)
self:refreshUI()
end


function UIGuHeJieMiWin:onHide()

end






function UIGuHeJieMiWin:updateData(argtable)
local gameType=4
local gameCfg=cfg_littlegameconfig_get(gameType)
self.gameName=gameCfg.name

local mapId=argtable and argtable.mapId or 1
local mapCfg=cfg_guhejiemimapconfig_get(mapId)
self.currMap=mapCfg.map
self.maxTime=mapCfg.time
if self.argtime then
self.maxTime=self.argtime
end
self.time=self.maxTime

self.timeTxt0:setText(FMT.fmt("挑战限时：{0}秒",self.maxTime))

self.mapBlocks={}
self:updateMapBlocks()
end


function UIGuHeJieMiWin:updateMapBlocks()
for i,v in pairs(self.currMap)do
local blockType,x,y=v[1],v[2],v[3]
local width,height=_gridSide,_gridSide
if blockType==eBlockType.eVShort then
height=_gridSide*2
elseif blockType==eBlockType.eSpecial then
width=_gridSide*2
elseif blockType==eBlockType.eVLong then
height=_gridSide*3
elseif blockType==eBlockType.eHShort then
width=_gridSide*2
elseif blockType==eBlockType.eHLong then
width=_gridSide*3
end
self.mapBlocks[i]={blockType=blockType,x=x,y=y,width=width,height=height}
if blockType==eBlockType.eSpecial then
self.targetIndex=i
end
end
end



function UIGuHeJieMiWin:refreshUI()
self:refreshMap()
self:refreshTitle()
end

function UIGuHeJieMiWin:refreshTitle()
self.title:setText(self.gameName)
end

function UIGuHeJieMiWin:refreshMap()
for i,v in ipairs(self.currMap)do
self.map:setChildBlockLayoutGroupCreateItem(v[1])
end
local blocklist=self.map:getChildLayoutGroupBlockList()
for i,v in ipairs(self.currMap)do
local widget=blocklist[i-1]
local pos=self.mapBlocks[i]
widget:SetChildLocalPos(blockCmpIndex.widget,_xPos+(pos.x-1)*_gridSide,_yPos-(pos.y-1)*_gridSide,0)

local beginDragCallback=function(...)
self:onBeginDragCallback(...)
end
local dragCallback=function(...)
self:onDragCallback(...)
end
local endDragCallback=function(index,position)
self:onEndDragCallback(index,position,widget)
end
widget:InitDragItem(blockCmpIndex.widget,i,beginDragCallback,dragCallback,endDragCallback)

local dragBlkType=self.mapBlocks[i].blockType
if dragBlkType==eBlockType.eSpecial then
widget:SetChildButtonClick(blockCmpIndex.widget,function()
self:onSpecialClick(i,widget)
end)
end
end
end

function UIGuHeJieMiWin:refreshTime()
self.timeTxt:setText(FMT.fmt("{0}秒",self.time))
self.progressBar:setProgressOnTime(self.time,0,self.maxTime)
end

function UIGuHeJieMiWin:showWin()














self.isWin=1
self.effect:setChildShowEffect(10060,true)

self:delayDo(0.3,function()

AudioManager.playAudio(544)
end)

self.isClosing=true
self:setTimer(2,1,function()
if self.isGaming then
if self.args.callback then
self.args.callback(self.isWin,self.time)
end
end
self:closeSelf()
end)
end

function UIGuHeJieMiWin:showLost()














self.isWin=0
self.effect:setChildShowEffect(10064,true)
self.isClosing=true
self:setTimer(2,1,function()
if self.isGaming then
if self.args.callback then
self.args.callback(self.isWin)
end
end
self:closeSelf()
end)
end




function UIGuHeJieMiWin:startGameTimer()
if self.timer then
return
end
local timerFunc=function()
self.time=self.time-1
self:refreshTime()
if self.time<=0 then
self:stopGameTimer()
self:showLost()
end
end
self.timer=self:setTimer(1,0,timerFunc)
self:refreshTime()
end


function UIGuHeJieMiWin:stopGameTimer()
if not self.timer then
return
end
self:stopTimerByID(self.timer)
self.timer=nil
end



function UIGuHeJieMiWin:onBtnClose()
if not self.isGaming then
self:closeSelf()
return
end
if not self.isClosing then
UILittleGameController:quitTips(function()
self.isWin=0
self.effect:setChildShowEffect(10064,true)
self:setTimer(2,1,function()
if self.isGaming then
if self.args.callback then
self.args.callback(self.isWin)
end
end
self:closeSelf()
end)
end)
end
end

function UIGuHeJieMiWin:onBtnStart()
if self.args.startCallback then
self.args.startCallback()
end
self.isGaming=true
self.bottom:setActive(true)
self:startGameTimer()
self.mask:setActive(false)
end



function UIGuHeJieMiWin:onSpecialClick(index,spewidget)
local dragBlkHeight=self.mapBlocks[index].height
local dragBlkPos=spewidget:GetChildLocalPosition(blockCmpIndex.widget)
local x=dragBlkPos.x
local blockList=self.map:getChildLayoutGroupBlockList()
local quit=_xPos+(xMax-1)*_gridSide
local distX=math.abs(quit-x)

for i,v in pairs(self.currMap)do

if i~=index then
local widget=blockList[i-1]
local pos=widget:GetChildLocalPosition(blockCmpIndex.widget)
local height=self.mapBlocks[i].height
local distY=math.abs(dragBlkPos.y-pos.y)
if distY==0 or(dragBlkPos.y>pos.y and distY<dragBlkHeight)or(dragBlkPos.y<pos.y and distY<height)then
if(pos.x>=x and pos.x<=quit)then
return
end
end
end
end
if distX then
local t=distX/200>0.7 and distX/200 or 0.7
spewidget:SetChildDOLocalMoveX(0,_xPos+(xMax)*_gridSide,t)
local fadeTween=spewidget:SetChildCanvasGroupDOFade(0,0,0.35,function()
self:showWin()
end)
fadeTween:SetDelay(t>0.7 and t-0.35 or 0.35)
end

end

function UIGuHeJieMiWin:checkX(index,dragBlkPos,position)
local dragBlkType=self.mapBlocks[index].blockType
local dragBlkWidth=self.mapBlocks[index].width
local dragBlkHeight=self.mapBlocks[index].height
local blockList=self.map:getChildLayoutGroupBlockList()

local x=dragBlkPos.x+(position.x-self.lastPos.x)*_sensitivity


for i,v in pairs(self.currMap)do

if i~=index then
local widget=blockList[i-1]
local pos=widget:GetChildLocalPosition(blockCmpIndex.widget)
local width=self.mapBlocks[i].width
local height=self.mapBlocks[i].height
local distY=math.abs(dragBlkPos.y-pos.y)
if distY==0 or(dragBlkPos.y>pos.y and distY<dragBlkHeight)or(dragBlkPos.y<pos.y and distY<height)then
if position.x>self.lastPos.x and dragBlkPos.x<pos.x then

if x>(pos.x-dragBlkWidth)then
x=(pos.x-dragBlkWidth)
end

elseif position.x<self.lastPos.x and dragBlkPos.x>pos.x then

if x<(pos.x+width)then
x=(pos.x+width)
end

end
end
end
end


if x>_xPos+(xMax-1)*_gridSide-dragBlkWidth+_gridSide then
x=_xPos+(xMax-1)*_gridSide-dragBlkWidth+_gridSide
elseif x<_xPos then
x=_xPos
end
return x
end

function UIGuHeJieMiWin:checkY(index,dragBlkPos,position)
local dragBlkType=self.mapBlocks[index].blockType
local dragBlkWidth=self.mapBlocks[index].width
local dragBlkHeight=self.mapBlocks[index].height
local blockList=self.map:getChildLayoutGroupBlockList()


local y=dragBlkPos.y+(position.y-self.lastPos.y)*_sensitivity


for i,v in pairs(self.currMap)do

if i~=index then
local widget=blockList[i-1]
local pos=widget:GetChildLocalPosition(blockCmpIndex.widget)
local width=self.mapBlocks[i].width
local height=self.mapBlocks[i].height
local distX=math.abs(dragBlkPos.x-pos.x)
if distX==0 or(dragBlkPos.x<pos.x and distX<dragBlkWidth)or(dragBlkPos.x>pos.x and distX<width)then
if position.y>self.lastPos.y and dragBlkPos.y<pos.y then

if y>(pos.y-height)then
y=(pos.y-height)
end

elseif position.y<self.lastPos.y and dragBlkPos.y>pos.y then

if y<(pos.y+dragBlkHeight)then
y=(pos.y+dragBlkHeight)
end

end
end
end
end




if y>_yPos then
y=_yPos
elseif dragBlkType==eBlockType.eSpecial and y<_yPos-(yMax-1)*_gridSide-_gridSide then
y=_yPos-(yMax-1)*_gridSide-_gridSide
elseif dragBlkType~=eBlockType.eSpecial and y<_yPos-(yMax-1)*_gridSide+dragBlkHeight-_gridSide then
y=_yPos-(yMax-1)*_gridSide+dragBlkHeight-_gridSide
end

return y
end

function UIGuHeJieMiWin:onBeginDragCallback(index,position)
self.lastPos=position


AudioManager.playAudio(523)
end

function UIGuHeJieMiWin:onDragCallback(index,position)
if self.time<=0 then
return
end
if not self.timer then
return
end
if self.isClosing then
return
end
local dragBlkType=self.mapBlocks[index].blockType
local dragBlkWidth=self.mapBlocks[index].width
local dragBlkHeight=self.mapBlocks[index].height
local blockList=self.map:getChildLayoutGroupBlockList()
local dragBlk=blockList[index-1]
local dragBlkPos=dragBlk:GetChildLocalPosition(blockCmpIndex.widget)

if dragBlkType==eBlockType.eVShort or dragBlkType==eBlockType.eVLong then









































local y=self:checkY(index,dragBlkPos,position)

dragBlk:SetChildLocalPosY(blockCmpIndex.widget,y)
self.lastPos=position

elseif dragBlkType==eBlockType.eHShort or dragBlkType==eBlockType.eHLong or dragBlkType==eBlockType.eSpecial then





































local x=self:checkX(index,dragBlkPos,position)

dragBlk:SetChildLocalPosX(blockCmpIndex.widget,x)
self.lastPos=position

end
end

function UIGuHeJieMiWin:onEndDragCallback(index,position,widget)
if not self.timer then
return
end
if self.isClosing then
return
end
local dragBlkPos=widget:GetChildLocalPosition(blockCmpIndex.widget)

local dragBlkType=self.mapBlocks[index].blockType
if dragBlkType==eBlockType.eVShort or dragBlkType==eBlockType.eVLong then

local y=self:checkY(index,dragBlkPos,position)
for i=1,yMax do
if y<=_yPos-(i-1)*_gridSide and y>=(_yPos-(i-1)*_gridSide)-_gridSide*fixed then
widget:SetChildLocalPosY(blockCmpIndex.widget,_yPos-(i-1)*_gridSide)
break
elseif y<=(_yPos-(i-1)*_gridSide)+_gridSide*fixed and y>=_yPos-i*_gridSide then
widget:SetChildLocalPosY(blockCmpIndex.widget,_yPos-i*_gridSide)
break
end
end

end
if dragBlkType==eBlockType.eHShort or dragBlkType==eBlockType.eHLong or dragBlkType==eBlockType.eSpecial then
local x=self:checkX(index,dragBlkPos,position)
for i=1,xMax do
if x>=_xPos+(i-1)*_gridSide and x<=(_xPos+(i-1)*_gridSide)+_gridSide*fixed then
widget:SetChildLocalPosX(blockCmpIndex.widget,_xPos+(i-1)*_gridSide)
break
elseif x<=_xPos+i*_gridSide and x>=(_xPos+i*_gridSide)-_gridSide*fixed then
widget:SetChildLocalPosX(blockCmpIndex.widget,_xPos+i*_gridSide)
break
end
end
end

self.lastPos=nil


local isWin=self:isWinFunc()
if isWin then
self:stopGameTimer()
if widget then
widget:SetChildDOLocalMoveX(0,_xPos+(xMax)*_gridSide,0.7)
local fadeTween=widget:SetChildCanvasGroupDOFade(0,0,0.35,function()
self:showWin()
end)
fadeTween:SetDelay(0.35)
end

end
end

function UIGuHeJieMiWin:isWinFunc()
if self.time<=0 then
return false
end

local blockList=self.map:getChildLayoutGroupBlockList()
local block=blockList[self.targetIndex-1]
local blockPos=block:GetChildLocalPosition(blockCmpIndex.widget)
if blockPos.x>=_xPos+(xMax-2)*_gridSide then
return true
end
return false
end


