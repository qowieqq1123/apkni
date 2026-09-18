







def_class("UILianLianKanGameWin",UIWindowBase)









function UILianLianKanGameWin:bindComponents()

self.beginBtn=UIButton.get(self,0)
self.beginRoot=UIObject.get(self,1)
self.bottom=UIObject.get(self,2)
self.cardGrid=UIObject.get(self,3)
self.closebtn=UIButton.get(self,4)
self.debugtxt=UIText.get(self,5)
self.effect=UIObject.get(self,6)
self.numtxt=UIText.get(self,7)
self.numtxt0=UIText.get(self,8)
self.tybg=UIImage.get(self,9)

self.beginBtn:setButtonClick(function()self:onBeginBtn()end)

self.closebtn:setButtonClick(function()self:onClosebtn()end)



end


function UILianLianKanGameWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.beginBtn);self.beginBtn=nil;
_UIObject_release(self.beginRoot);self.beginRoot=nil;
_UIObject_release(self.bottom);self.bottom=nil;
_UIObject_release(self.cardGrid);self.cardGrid=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
_UIObject_release(self.debugtxt);self.debugtxt=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.numtxt);self.numtxt=nil;
_UIObject_release(self.numtxt0);self.numtxt0=nil;
_UIObject_release(self.tybg);self.tybg=nil;
end

















local cardWidth=150
local cardHeight=236
local cardSpace=Vector2.New(10,10)
local row=2
local col=6
local centerPos=Vector2.New(0,0)
local cardabName='ui/windows/littlegame/sharedtextures/xianjiexuanpaicard.ab'
local cardInitTypes={1,1,2,2,3,3,4,4,5,5,6,6}
local coverTime=0.5


local maxNum=row*col
local cardWidthHalf=cardWidth/2
local cardHeightHalf=cardHeight/2
local beginPos=Vector2.New(
-((col*cardWidth+(col-1)*cardSpace.x)/2-cardWidthHalf),
((row*cardHeight+(row-1)*cardSpace.y)/2-cardHeightHalf)
)


function UILianLianKanGameWin:onLoaded(...)
self:bindComponents()

webGLHelper:uiWindowCloseCamera(self.tybg)

self.isWin=0
self.isClosing=false
self:initData()
self:initCard()
end


function UILianLianKanGameWin:__delete()
self:unbindComponents()

webGLHelper:uiWindowShowCamera()
end

function UILianLianKanGameWin:onResultClose()
if self.isGaming then
if self.args.callback then
self.args.callback(self.isWin,self.times-self.clickNum)
end
end
end

function UILianLianKanGameWin:onClosebtn()
self:onCloseBtn()
end

function UILianLianKanGameWin:onCloseBtn()
if not self.isGaming then
self:closeSelf()
return
end
if not self.isClosing then
UILittleGameController:quitTips(function()
self.isWin=0
self.effect:setChildShowEffect(10064,true)
self:setTimer(2,1,function()
self:onResultClose()
self:closeSelf()
end)
end)
end
end


function UILianLianKanGameWin:onHide()

end

function UILianLianKanGameWin:doRotation(widget,flag,func)
local f=function()
widget:SetChildActive(3,flag)
widget:SetChildDORotate(0,Vector3.New(0,0,0),0.2,DG.Tweening.RotateMode.Fast,func)
end
widget:SetChildDORotate(0,Vector3.New(0,90,0),0.2,DG.Tweening.RotateMode.Fast,f)
end




function UILianLianKanGameWin:onShow(argtable,afterOnloaded)
self.args=argtable
self.num=self.args.time
self.mapId=self.args.mapId or 1
local cfg=cfgHelper.get(cfg_xianjiexuanpaiconfig_get,self.mapId)
self.cardIcons={}
for i,v in ipairs(cfg.map)do
table.insert(self.cardIcons,FMT.fmt("image_xjxpgwxx_{0}",v))
end
self.times=cfg.times
if self.num then
self.times=self.num
end
self.numtxt0:setText(FMT.fmt("可翻牌次数：{0}",self.times))
self.isWin=0
if self.args.isShowCloseBtn and self.args.isShowCloseBtn==1 then
self.closebtn:setActive(false)
end
self:resetCardGrid()
end

function UILianLianKanGameWin:initData()
self.allCardDatas={}
for i=1,maxNum do
local r=math.ceil(i/col)
local c=i%col
if c==0 then c=col end
local cardData={}
cardData.pos=Vector2.New(
beginPos.x+(c-1)*(cardWidth+cardSpace.x),
beginPos.y-(r-1)*(cardHeight+cardSpace.y)
)
cardData.cardType=cardInitTypes[i]
self.allCardDatas[i]=cardData
end
end

function UILianLianKanGameWin:initCard()
self.cardGrid:setChildLayoutGroupCreateItems(maxNum)
local gridlist=self.cardGrid:getChildLayoutGroupGridList()
for i=1,maxNum do
local cardData=self.allCardDatas[i]
cardData.widget=gridlist[i-1]
cardData.widget:SetChildButtonClick(1,function()
self:onCardClick(i)
end)
end
end

function UILianLianKanGameWin:resetCardGrid()
for i=1,maxNum do
local cardData=self.allCardDatas[i]
cardData.cardType=cardInitTypes[i]
local widget=cardData.widget
widget:SetChildActive(0,true)
widget:SetChildAnchoredPosition(0,cardData.pos)

widget:SetChildCSImageSprite(2,cardabName,self.cardIcons[cardData.cardType])

widget:SetChildActive(3,false)
end
self.oneOpen=nil
self.twoOpen=nil
self.lockclick=false
self.doneNum=0
self.clickNum=0
self:refreshScore()
self.cardGrid:setScale(Vector3.New(0,0,0))
self.bottom:setActive(false)
self.beginRoot:setActive(true)

self.isGaming=false
self:updateDebugText()
end

function UILianLianKanGameWin:collectCard()
self.lockclick=true
self.timer_counter=1

local func=function()
local cardData=self.allCardDatas[self.timer_counter]

if cardData==nil then
return
end
local pos=centerPos
local func2=nil
if self.timer_counter==maxNum then
func2=function()

cardData.widget:SetChildActive(3,true)
self:randomCard()
end
else
func2=function()

cardData.widget:SetChildActive(3,true)
end
end
cardData.widget:SetChildDOLocalMove(0,Vector3.New(pos.x,pos.y,0),0.2,func2)
self.timer_counter=self.timer_counter+1
end
self:setTimer(0.1,maxNum,func)
end

function UILianLianKanGameWin:randomCard()
local list=table.deepCopy(cardInitTypes)
for i=1,maxNum do
local cardData=self.allCardDatas[i]
local rand=math.random(1,#list)
local ty=list[rand]
table.remove(list,rand)
cardData.cardType=ty
end
for i=1,maxNum do
local cardData=self.allCardDatas[i]

cardData.widget:SetChildCSImageSprite(2,cardabName,self.cardIcons[cardData.cardType])
end

local func=function()
self:sendCard()
end
self:delayDo(0.2,func)

self:updateDebugText()
end

function UILianLianKanGameWin:sendCard()
self.timer_counter=1

local func=function()
local cardData=self.allCardDatas[self.timer_counter]

if cardData==nil then
return
end
local pos=cardData.pos
local func2=nil
if self.timer_counter==maxNum then
func2=function()
self:onReady()
end
end
cardData.widget:SetChildDOLocalMove(0,Vector3.New(pos.x,pos.y,0),0.2,func2)
self.timer_counter=self.timer_counter+1
end
self:setTimer(0.1,maxNum,func)
end

function UILianLianKanGameWin:onReady()
self.lockclick=false
end

function UILianLianKanGameWin:onCardClick(idx)
if not self.isGaming then return end
if self.lockclick then return end

if self.oneOpen==nil then
self.oneOpen=idx
local cardData=self.allCardDatas[idx]
self:doRotation(cardData.widget,false,nil)
self.clickNum=self.clickNum+1
self:refreshScore()
elseif self.twoOpen==nil and self.oneOpen~=idx then
self.twoOpen=idx
local cardData=self.allCardDatas[idx]
self:doRotation(cardData.widget,false,nil)
self.clickNum=self.clickNum+1
self:refreshScore()

self.lockclick=true
local func=function()
self:checkResult()
end
self:delayDo(0.5,func)
end
end

function UILianLianKanGameWin:checkResult()
local cardData1=self.allCardDatas[self.oneOpen]
local cardData2=self.allCardDatas[self.twoOpen]
if cardData1.cardType==cardData2.cardType then
local func=function()
self:doDisappear()
end
self:delayDo(0.2,func)
else
local func=function()
self:doRecover()
end
self:delayDo(coverTime,func)
end
end

function UILianLianKanGameWin:doRecover()
local cardData1=self.allCardDatas[self.oneOpen]
local cardData2=self.allCardDatas[self.twoOpen]
local func=function()
self.oneOpen=nil
self.twoOpen=nil
self.lockclick=false

self:checkFail()

end
self:doRotation(cardData1.widget,true,nil)
self:doRotation(cardData2.widget,true,func)
end

function UILianLianKanGameWin:doDisappear()
local cardData1=self.allCardDatas[self.oneOpen]
local cardData2=self.allCardDatas[self.twoOpen]

cardData1.widget:SetChildActive(0,false)

cardData2.widget:SetChildActive(0,false)
self.oneOpen=nil
self.twoOpen=nil
self.lockclick=false
self.doneNum=self.doneNum+2

self:checkSuccess()
end

function UILianLianKanGameWin:checkSuccess()
if self.doneNum>=maxNum then
local func=function()
self:onSuccess()
end
self:delayDo(0.2,func)
else

local func=function()
self:checkFail()
end
self:delayDo(0.2,func)
end
end

function UILianLianKanGameWin:onSuccess()

self.isWin=1
self.effect:setChildShowEffect(10060,true)
self.isClosing=true
self:setTimer(2,1,function()
self:onResultClose()
self:closeSelf()
end)
end

function UILianLianKanGameWin:checkFail()
if self.times-self.clickNum<=0 then

self.isWin=0
self.effect:setChildShowEffect(10064,true)
self.isClosing=true
self:setTimer(2,1,function()
self:onResultClose()
self:closeSelf()
end)
end
end

function UILianLianKanGameWin:refreshScore()
self.numtxt:setText(FMT.fmt('可翻牌次数：{0}',self.times-self.clickNum))
end

function UILianLianKanGameWin:onBeginBtn()
self.cardGrid:setScale(Vector3.New(1,1,1))
self.bottom:setActive(true)
self.beginRoot:setActive(false)

self.isGaming=true

if self.args.startCallback then
self.args.startCallback()
end

self:collectCard()
end

function UILianLianKanGameWin:onRuleClick()






end



function UILianLianKanGameWin:onColoredEgg()
self.debugModel=self.debugModel or false
self.debugModel=not self.debugModel
self:updateDebugText()
end

function UILianLianKanGameWin:updateDebugText()
local str=''
if self.debugModel then
for i=1,maxNum do
local r=math.ceil(i/col)
local c=i%col
if c==0 then c=col end
local cardData=self.allCardDatas[i]
str=str..cardData.cardType
if c<col then
str=str..' '
end
if r<row and c==col then
str=str..'\n'
end
end
end
self.debugtxt:setText(str)
end


