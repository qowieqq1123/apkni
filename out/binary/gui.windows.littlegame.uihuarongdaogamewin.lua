







def_class("UIHuaRongDaoGameWin",UIWindowBase)









function UIHuaRongDaoGameWin:bindComponents()

self.mask=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.btnClose=UIButton.get(self,2)
self.progressBar=UIProgress.get(self,3)
self.btnStart=UIButton.get(self,4)
self.map=UIObject.get(self,5)
self.timeTxt=UIText.get(self,6)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.btnStart:setButtonClick(function()self:onBtnStart()end)



end


function UIHuaRongDaoGameWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.btnStart);self.btnStart=nil;
_UIObject_release(self.map);self.map=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
end



local eBlockType=
{
eBig=0,
eTall=1,
eWide=2,
eNormal=3,
}


local blockCmpIndex=
{
widget=0,
root=1,
bg=2,
}


local _cols=4
local _rows=5


local _sensitivity=5


local _xPos={-400,-200,0,200}
local _yPos={150,100,50,0,-50}


local _config=
{
[1]={
map={
{1,1,1},{0,2,1},{1,4,1},
{1,1,3},{2,2,3},{1,4,3},
{3,1,5},{3,2,5},{3,3,5},{3,4,5},
},
id=1,
time=180,
}
}
















function UIHuaRongDaoGameWin:onLoaded(...)
self:bindComponents()
end


function UIHuaRongDaoGameWin:__delete()
self:stopGameTimer()
self:unbindComponents()
end




function UIHuaRongDaoGameWin:onShow(argtable,afterOnloaded)
self:updateData(argtable)
self:refreshUI()
end


function UIHuaRongDaoGameWin:onHide()

end






function UIHuaRongDaoGameWin:updateData(argtable)
local mapId=argtable and argtable.mapId or 1
local mapCfg=_config[mapId]
self.currMap=mapCfg.map
self.maxTime=mapCfg.time
self.time=self.maxTime

self.posList={}
self:updatePosList()

self.posState={}
self:updatePosState()
end


function UIHuaRongDaoGameWin:updatePosList()
for i,v in pairs(self.currMap)do
local blockType,x,y=v[1],v[2],v[3]
self.posList[i]={blockType=blockType,x=x,y=y}
if blockType==eBlockType.eBig then
self.targetIndex=i
end
end
end


function UIHuaRongDaoGameWin:updatePosState()
for i=1,_cols do
self.posState[i]={}
for j=1,_rows do
self.posState[i][j]=0
end
end

for i,v in pairs(self.posList)do
local blockType,x,y=v.blockType,v.x,v.y

self.posState[x][y]=i
if blockType==eBlockType.eTall then
self.posState[x][y+1]=i
elseif blockType==eBlockType.eWide then
self.posState[x+1][y]=i
elseif blockType==eBlockType.eBig then
self.posState[x][y+1]=i
self.posState[x+1][y]=i
self.posState[x+1][y+1]=i
end
end
end



function UIHuaRongDaoGameWin:refreshUI()
self:refreshMap()
end

function UIHuaRongDaoGameWin:refreshMap()
for i,v in ipairs(self.currMap)do
self.map:setChildBlockLayoutGroupCreateItem(v[1])
end
local blocklist=self.map:getChildLayoutGroupBlockList()
for i,v in ipairs(self.currMap)do
local widget=blocklist[i-1]
local pos=self.posList[i]
widget:SetChildLocalPos(blockCmpIndex.widget,_xPos[pos.x],_yPos[pos.y],0)

local beginDragCallback=function(...)
self:onBeginDragCallback(...)
end
local dragCallback=function(...)
self:onDragCallback(...)
end
local endDragCallback=function(...)
self:onEndDragCallback(...)
end
widget:InitDragItem(blockCmpIndex.widget,i,beginDragCallback,dragCallback,endDragCallback)
end
end

function UIHuaRongDaoGameWin:refreshTime()
self.timeTxt:setText(self.time)
self.progressBar:setProgressOnTime(self.time,0,self.maxTime)
end

function UIHuaRongDaoGameWin:showWin()
local showdata=
{
type='UIDialougeHighest',
title='提示',
content='恭喜获胜',
oktext='确认',
allowclickBG='false',
okcallback=function(...)
self:closeSelf()
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end

function UIHuaRongDaoGameWin:showLost()
local showdata=
{
type='UIDialougeHighest',
title='提示',
content='游戏结束',
oktext='确认',
allowclickBG='false',
okcallback=function(...)
self:closeSelf()
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end




function UIHuaRongDaoGameWin:startGameTimer()
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


function UIHuaRongDaoGameWin:stopGameTimer()
if not self.timer then
return
end
self:stopTimerByID(self.timer)
self.timer=nil
end



function UIHuaRongDaoGameWin:onBtnClose()
self:closeSelf()
end

function UIHuaRongDaoGameWin:onBtnStart()
self:startGameTimer()
self.mask:setActive(false)
end



function UIHuaRongDaoGameWin:onBeginDragCallback(index,position)
if self.time<=0 then
return
end
self.dragIndex=index
self.beginPos=position
end

function UIHuaRongDaoGameWin:onDragCallback(index,position)
end

function UIHuaRongDaoGameWin:onEndDragCallback(index,position)
if self.time<=0 then
return
end
if self.dragIndex~=index then
return
end

local distX=position.x-self.beginPos.x
local distY=position.y-self.beginPos.y

local pos=
{
x=self.posList[index].x,
y=self.posList[index].y,
}


if distY>_sensitivity then

pos.y=pos.y>1 and pos.y-1 or pos.y
elseif distY<_sensitivity*(-1)then

pos.y=pos.y<_rows and(pos.y+1)or pos.y
elseif distX<_sensitivity*(-1)then

pos.x=pos.x>1 and(pos.x-1)or pos.x
elseif distX>_sensitivity then

pos.x=pos.x<_cols and(pos.x+1)or pos.x
end


local blockType=self.posList[index].blockType
if self.posState[pos.x][pos.y]>0 and self.posState[pos.x][pos.y]~=index then return end
if blockType==eBlockType.eTall then
if self.posState[pos.x][pos.y+1]>0 and self.posState[pos.x][pos.y+1]~=index then return end

elseif blockType==eBlockType.eWide then
if self.posState[pos.x+1][pos.y]>0 and self.posState[pos.x+1][pos.y]~=index then return end

elseif blockType==eBlockType.eBig then
if self.posState[pos.x][pos.y+1]>0 and self.posState[pos.x][pos.y+1]~=index then return end
if self.posState[pos.x+1][pos.y]>0 and self.posState[pos.x+1][pos.y]~=index then return end
if self.posState[pos.x+1][pos.y+1]>0 and self.posState[pos.x+1][pos.y+1]~=index then return end

end


self.posList[index].x=pos.x
self.posList[index].y=pos.y
self:updatePosState()


local blocklist=self.map:getChildLayoutGroupBlockList()
local widget=blocklist[index-1]
widget:SetChildLocalPos(blockCmpIndex.widget,_xPos[pos.x],_yPos[pos.y],0)


local isWin=self:isWin()
if isWin then
self:stopGameTimer()
self:showWin()
end
end

function UIHuaRongDaoGameWin:isWin()
local target=self.posList[self.targetIndex]
if target.x==2 and target.y==4 then
return true
end
return false
end

