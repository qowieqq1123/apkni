







def_class("UIWanBaoJianShangWin",UIWindowBase)









function UIWanBaoJianShangWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.effect=UIObject.get(self,1)
self.gameRoot=UIObject.get(self,2)
self.playArea=UIObject.get(self,3)
self.progressbar=UIProgressBarAni.get(self,4)
self.ruleRoot=UIObject.get(self,5)
self.scoreArea=UIObject.get(self,6)
self.scoreTx=UIText.get(self,7)
self.startBtn=UIButton.get(self,8)
self.times=UIText.get(self,9)
self.title=UIText.get(self,10)
self.tybg=UIImage.get(self,11)
self.winCondition=UIText.get(self,12)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.startBtn:setButtonClick(function()self:onStartBtn()end)



end


function UIWanBaoJianShangWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.gameRoot);self.gameRoot=nil;
_UIObject_release(self.playArea);self.playArea=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.ruleRoot);self.ruleRoot=nil;
_UIObject_release(self.scoreArea);self.scoreArea=nil;
_UIObject_release(self.scoreTx);self.scoreTx=nil;
_UIObject_release(self.startBtn);self.startBtn=nil;
_UIObject_release(self.times);self.times=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.tybg);self.tybg=nil;
_UIObject_release(self.winCondition);self.winCondition=nil;
end
















local itemKid={
icon=0,
select=1,
button=2,
effect=3,
score=4
}



function UIWanBaoJianShangWin:onLoaded(...)
self:bindComponents()

webGLHelper:uiWindowCloseCamera(self.tybg)

self.globalCfg=cfgHelper.get1(cfg_wanbaojianshangglobalconfig_get,1)
self._onProgressUpdateAction=function(...)
self:onProgressUpdateAction(...)
end
self.progressbar:setUpdateAction(self._onProgressUpdateAction)
end


function UIWanBaoJianShangWin:__delete()
self:unbindComponents()

webGLHelper:uiWindowShowCamera()

self:stopGameTimer()

end




function UIWanBaoJianShangWin:onShow(argtable,afterOnloaded)
self.args=argtable
self.isWin=0
self.isClosing=false
self.usetime=0
self.argtime=self.args.time
if not self.args.mapId then
loggerUtil.logErrFMT("万宝鉴赏没有传入配置ID")
self:closeSelf()
return
end
if self.args.isShowCloseBtn and self.args.isShowCloseBtn==1 then
self.closeBtn:setActive(false)
end
self.cfg=cfgHelper.get1(cfg_wanbaojianshangconfig_get,self.args.mapId)
local title=self.cfg.name or"万宝鉴赏"
self.title:setText(title)
self:initRule()
self:initPlay()
end


function UIWanBaoJianShangWin:onHide()

end

function UIWanBaoJianShangWin:onResultClose()
if self.isGaming then
if self.args.callback then
self.args.callback(self.isWin,self.score,self.usetime)
end
end
end




function UIWanBaoJianShangWin:onCloseBtn()
if not self.isGaming then
self:closeSelf()
return
end
if not self.isClosing then
UILittleGameController:quitTips(function()
self.isWin=0
local showEffect=true
if self.args.showEffect~=nil then
showEffect=self.args.showEffect
end

if showEffect then
self.effect:setChildShowEffect(10064,true)
self:setTimer(2,1,function()
self:onResultClose()
self:closeSelf()
end)
else
self:onResultClose()
self:closeSelf()
end

end)
end
end


function UIWanBaoJianShangWin:onStartBtn()
self.isGaming=true
if self.args.startCallback then
self.args.startCallback()
end
self.ruleRoot:setActive(false)
self.gameRoot:setActive(true)
local truetime=self.cfg.time
if self.argtime then
truetime=self.argtime
end
local remainTime=truetime
self.progressbar:setActive(remainTime~=nil)
local step=1
if remainTime then












self.progressbar:animateFiveParams(remainTime,0,remainTime,remainTime,true)

end
end

function UIWanBaoJianShangWin:onProgressUpdateAction(div,time)
local truetime=self.cfg.time
if self.argtime then
truetime=self.argtime
end
local val=math.floor(div*truetime)

self.times:setText(FMT.fmt('{0}秒',val))
self.usetime=val
if val<=0 then
self:gameOver()
end
end

function UIWanBaoJianShangWin:initRule()
local truetime=self.cfg.time
if self.argtime then
truetime=self.argtime
end
local timeStr=truetime and FMT.fmt("{0}秒",truetime)or"无"
self.scoreMax=self.globalCfg.total*self.globalCfg.single
self.scoreLimit=self.cfg.score or self.scoreMax or 0
local conditionStr=FMT.fmt("挑战限时：{0}\t最高分数：{1}",timeStr,self.scoreLimit)
self.winCondition:setText(conditionStr)
end

function UIWanBaoJianShangWin:initPlay()

self.isGaming=false
local temp1={}
for i,v in ipairs(self.cfg.map)do
for j=1,v[2]do
table.insert(temp1,i)
end
end

local temp2={}
for i=1,self.globalCfg.total do
local cnt=#temp1
if cnt>0 then
local random=math.random(#temp1)
local index=table.remove(temp1,random)
table.insert(temp2,index)
table.insert(temp2,index)
else
table.insert(temp2,0)
table.insert(temp2,0)
end
end

self.data={}
for i=1,self.globalCfg.total*2 do
local random=math.random(#temp2)
local index=table.remove(temp2,random)
table.insert(self.data,index)
end


self.playArea:setChildLayoutGroupCreateItems(#self.data,function(itemIdx)
local itemCmp=self.playArea:getChildLayoutGroupGridItem(itemIdx-1)
local itemData=self.data[itemIdx]
local show=itemData>0
itemCmp:SetChildActive(itemKid.button,itemData>0)
if show then
local iconName=self.cfg.map[itemData][1]
itemCmp:SetChildIcon(itemKid.icon,iconName,true)
itemCmp:SetChildButtonClick(itemKid.button,function()
self:onClickItem(itemIdx)
end)
end
end)

self:setScore(0)


self.scoreArea:setChildLayoutGroupCreateItems(Mathf.Floor(#self.data/2),function(index)end)
self.pairNum=0
end

function UIWanBaoJianShangWin:onClickItem(index)
if not self.isGameOver then
if self.first then
local firstValue=self.data[self.first]
local secondValue=self.data[index]
if firstValue==secondValue and self.first~=index then
local firstCmp=self.playArea:getChildLayoutGroupGridItem(self.first-1)
local secondCmp=self.playArea:getChildLayoutGroupGridItem(index-1)
firstCmp:SetChildActive(itemKid.select,false)
firstCmp:SetChildActive(itemKid.button,false)
secondCmp:SetChildActive(itemKid.button,false)
firstCmp:SetChildShowEffect(itemKid.effect,10311,true)
secondCmp:SetChildShowEffect(itemKid.effect,10311,true)

AudioManager.playAudio(621)

local scoreCmp=self.scoreArea:getChildLayoutGroupGridItem(self.pairNum)
local pos=secondCmp:GetChildLocalPosition(-1)
scoreCmp:SetChildText(1,toColorString(FONT_COLOR.eGreenColor,FMT.fmt("分数+{0}",self.globalCfg.single)))
scoreCmp:SetChildLocalPosition(-1,Vector3(pos.x,pos.y,pos.z)+Vector3(60,30,0))
scoreCmp:SetChildCanvasGroupAlpha(1,1)
scoreCmp:SetChildCanvasGroupDOFade(1,0,1,nil)
scoreCmp:SetChildDOAnchorPosY(-1,pos.y-300,4.5,nil)
self.pairNum=self.pairNum+1

self.first=nil

self:setScore(self.score+self.globalCfg.single)




else
local itemCmp=self.playArea:getChildLayoutGroupGridItem(self.first-1)
itemCmp:SetChildActive(itemKid.select,false)


local secondCmp=self.playArea:getChildLayoutGroupGridItem(index-1)
secondCmp:SetChildActive(itemKid.select,true)
self.first=index
end
else
self.first=index
local itemCmp=self.playArea:getChildLayoutGroupGridItem(index-1)
itemCmp:SetChildActive(itemKid.select,true)
end
end
end

function UIWanBaoJianShangWin:setScore(score)
self.score=score
self.scoreTx:setText(FMT.fmt("分数：{0}（{1}分获胜）",toColorString(FONT_COLOR.eGreenColor,self.score),self.scoreLimit))
if self.score>=self.scoreLimit then
self:gamePass()
end
end

function UIWanBaoJianShangWin:gameOver()

self.isWin=0
self.isGameOver=true
local showEffect=true
if self.args.showEffect~=nil then
showEffect=self.args.showEffect
end

self.isClosing=true
if showEffect then
self.effect:setChildShowEffect(10064,true)
self:setTimer(4,1,function()
self:onResultClose()
self:closeSelf()
end)
else
self:onResultClose()
self:closeSelf()
end
end

function UIWanBaoJianShangWin:gamePass()

self.isWin=1
self.isGameOver=true
local showEffect=true
if self.args.showEffect~=nil then
showEffect=self.args.showEffect
end

self.isClosing=true
if showEffect then
self.effect:setChildShowEffect(10060,true)
self:setTimer(2,1,function()
self:onResultClose()
self:closeSelf()
end)
else
self:onResultClose()
self:closeSelf()
end
end

function UIWanBaoJianShangWin:stopGameTimer()
if self.gameTimer then
self:stopTimerByID(self.gameTimer)
self.gameTimer=nil
end
end