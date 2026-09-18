







def_class("UITuLingGuiWeiWin",UIWindowBase)









function UITuLingGuiWeiWin:bindComponents()

self.bottom=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.effect=UIObject.get(self,2)
self.finishImg=UIImage.get(self,3)
self.gameArea=UIObject.get(self,4)
self.mask=UIObject.get(self,5)
self.progressbar=UIProgress.get(self,6)
self.startBtn=UIButton.get(self,7)
self.times=UIText.get(self,8)
self.times0=UIText.get(self,9)
self.title=UIText.get(self,10)
self.tybg=UIImage.get(self,11)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.startBtn:setButtonClick(function()self:onStartBtn()end)



end


function UITuLingGuiWeiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bottom);self.bottom=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.finishImg);self.finishImg=nil;
_UIObject_release(self.gameArea);self.gameArea=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.startBtn);self.startBtn=nil;
_UIObject_release(self.times);self.times=nil;
_UIObject_release(self.times0);self.times0=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.tybg);self.tybg=nil;
end

















local _this=nil
local time
local abPath='ui/windows/littlegame/sharedtextures/{0}.ab'
local gameAB
local imgName
local gameType=2


function UITuLingGuiWeiWin:onLoaded(...)
self:bindComponents()
_this=self

webGLHelper:uiWindowCloseCamera(self.tybg)

local typeConfig=cfg_littlegameconfig_get(gameType)
time=typeConfig.time or 60
self.tweenTips={}
end


function UITuLingGuiWeiWin:__delete()
self:unbindComponents()
_this=nil

webGLHelper:uiWindowShowCamera()

time=0
self.firstIndex=nil
self.secondIndex=nil
self.idList=nil
self.config=nil
self:stopGameTimer()
self.tweenTips={}

end




function UITuLingGuiWeiWin:onShow(argtable,afterOnloaded)
self.args=argtable
self.isWin=0
self.isClosing=false
self.title:setText('图灵归位')
self.mapId=self.args.mapId
if self.args.time then
time=self.args.time
end
if self.args.isShowCloseBtn and self.args.isShowCloseBtn==1 then
self.closeBtn:setActive(false)
end
self:initPanel()
end


function UITuLingGuiWeiWin:onHide()

end




function UITuLingGuiWeiWin:initPanel()
self.isGaming=false
self.mask:setActive(true)
self.bottom:setActive(false)
self.times:setText(time)

local cfg=cfg_pintugameconfig()
if self.mapId then
self.config=cfg[self.mapId]
else
local rand=math.random(1,#cfg)
self.config=cfg[rand]
end

if self.config then
self.times0:setText(FMT.fmt("挑战限时：{0}秒",time))
imgName=self.config.imgname
gameAB=FMT.fmt(abPath,imgName)
self.finishImg:setSprite(gameAB,FMT.fmt('{0}',imgName))

self.progressbar:setProgressValue(1,1)
self:initGameArea()
self:stopGameTimer()
end
end

function UITuLingGuiWeiWin:randomSortId(t)
local temp={}
local index=1
while#t~=0 do
local n=math.random(1,#t)
if t[n]~=nil then
temp[index]=t[n]
table.remove(t,n)
index=index+1
end
end
return temp
end

function UITuLingGuiWeiWin:initGameArea()
local row,col=3,3
local num=row*col
local tab={}
for i=1,num do
table.insert(tab,i)
end

self.idList=self:randomSortId(tab)
self.gameArea:setChildLayoutGroupCreateItems(num)
local gridlist=self.gameArea:getChildLayoutGroupGridList()
for i=1,num do
local item=gridlist[i-1]
if item then

item:SetChildCSImageSprite(0,gameAB,FMT.fmt('{0}_{1}',imgName,self.idList[i]))
item:SetChildActive(1,false)
item:SetChildButtonClick(0,function(...)
self:onClickItemCallback(i,col,num)
end)
end
end
end

function UITuLingGuiWeiWin:onClickItemCallback(index,col,num)

if self.isWin~=0 then
return
end
self.secondIndex=self.firstIndex and index
self.firstIndex=self.firstIndex or index
local firstItem=self.gameArea:getChildLayoutGroupGridItem(self.firstIndex-1)
if firstItem then
firstItem:SetChildActive(1,true)
if self.secondIndex then
if self:isNearItem(self.firstIndex,self.secondIndex,col)then
local secondItem=self.gameArea:getChildLayoutGroupGridItem(self.secondIndex-1)
if secondItem then


firstItem:SetChildCSImageSprite(0,gameAB,FMT.fmt('{0}_{1}',imgName,self.idList[self.secondIndex]))
secondItem:SetChildCSImageSprite(0,gameAB,FMT.fmt('{0}_{1}',imgName,self.idList[self.firstIndex]))
local temp=self.idList[self.firstIndex]
self.idList[self.firstIndex]=self.idList[self.secondIndex]
self.idList[self.secondIndex]=temp
end
end
firstItem:SetChildActive(1,false)

if next(self.tweenTips)then
for i,v in pairs(self.tweenTips)do
v:Kill()
v=nil
local item=self.gameArea:getChildLayoutGroupGridItem(i-1)
if item then
item:SetChildCanvasGroupAlpha(2,0)
end
end
end

self.firstIndex=nil
self.secondIndex=nil


else

for i=1,num do
if self:isNearItem(self.firstIndex,i,col)then
local item=self.gameArea:getChildLayoutGroupGridItem(i-1)
if item then
item:SetChildActive(2,true)
item:SetChildCanvasGroupAlpha(2,1)
local tween=item:SetChildCanvasGroupDOFade(2,0,0.75,nil)
tween:SetLoops(-1,_LoopType.Yoyo)
self.tweenTips[i]=tween
end
end
end


end
end
local isSuccess=true
for i,v in ipairs(self.idList)do
if i~=v then
isSuccess=false
end
end
if isSuccess then
self.isWin=1
self.effect:setChildShowEffect(10060,true)
self:setTimer(2,1,function()
if self.isGaming then
if self.args.callback then
self.args.callback(self.isWin,self.remainTime)
end
end
self:closeSelf()
end)
end
end

function UITuLingGuiWeiWin:isNearItem(lastIndex,curIndex,col)
local x=lastIndex%col
local fx=(1+col)%col
local tx=(col+col)%col
if x==fx then
return curIndex-lastIndex==1 or math.abs(curIndex-lastIndex)==col
else
if x==tx then
return curIndex-lastIndex==-1 or math.abs(curIndex-lastIndex)==col
else
return math.abs(curIndex-lastIndex)==1 or math.abs(curIndex-lastIndex)==col
end
end
end


function UITuLingGuiWeiWin:actionProgress()
self.progressbar:setProgressOnTime(time,0,time)
end


function UITuLingGuiWeiWin:onStartBtn()
if self.args.startCallback then
self.args.startCallback()
end
self.isGaming=true
self.mask:setActive(false)
self.bottom:setActive(true)
local isAction=false
local remainTime=time
self.remainTime=remainTime
local func=function(...)
if not isAction then
isAction=true
_this:actionProgress()
end
remainTime=remainTime-1
self.remainTime=remainTime
_this.times:setText(remainTime)
if remainTime<=0 then
_this:gameOver()
end
end
self.gameTimer=self:setTimer(1,0,func)
end

function UITuLingGuiWeiWin:onCloseBtn()




















if not self.isGaming then
self:closeSelf()
return
end
if not self.isClosing then
UILittleGameController:quitTips(function()
self.isWin=0
self.effect:setChildShowEffect(10064,true)
self.isClosing=true

self:setTimer(2,1,function()
if self.isGaming then
if self.args.callback then
self.args.callback(self.isWin,self.remainTime)
end
end
self:closeSelf()
end)
end)
end
end

function UITuLingGuiWeiWin:gameOver()
UIManager.info('时间到，失败')

self.isWin=0
self.effect:setChildShowEffect(10064,true)
self.isClosing=true
self:setTimer(2,1,function()
if self.isGaming then
if self.args.callback then
self.args.callback(self.isWin,self.remainTime)
end
end
self:closeSelf()
end)
end

function UITuLingGuiWeiWin:stopGameTimer()
if self.gameTimer then
self:stopTimerByID(self.gameTimer)
self.gameTimer=nil
end
end
