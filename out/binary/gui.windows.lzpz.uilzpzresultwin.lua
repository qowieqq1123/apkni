







def_class("UILZPZResultWin",UIWindowBase)









function UILZPZResultWin:bindComponents()

self.bg=UIButton.get(self,0)
self.success=UIObject.get(self,1)
self.failure=UIObject.get(self,2)
self.tipsText=UIText.get(self,3)
self.effect=UIObject.get(self,4)
self.topScore=UIText.get(self,5)
self.nowScore=UIText.get(self,6)
self.rewardPanel=UIObject.get(self,7)
self.getRewardTitle=UIObject.get(self,8)
self.rewardView=UIObject.get(self,9)
self.rewardList=UIObject.get(self,10)
self.getAllTips=UIObject.get(self,11)
self.progressbar=UIProgressBarAni.get(self,12)
self.topScoreUpIcon=UIObject.get(self,13)
self.progressText=UIText.get(self,14)
self.beforeShowPanel=UIObject.get(self,15)
self.beforeEffect=UIObject.get(self,16)
self.resultPanel=UIObject.get(self,17)

self.bg:setButtonClick(function()self:onBg()end)



end


function UILZPZResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.success);self.success=nil;
_UIObject_release(self.failure);self.failure=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.topScore);self.topScore=nil;
_UIObject_release(self.nowScore);self.nowScore=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.getRewardTitle);self.getRewardTitle=nil;
_UIObject_release(self.rewardView);self.rewardView=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.getAllTips);self.getAllTips=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.topScoreUpIcon);self.topScoreUpIcon=nil;
_UIObject_release(self.progressText);self.progressText=nil;
_UIObject_release(self.beforeShowPanel);self.beforeShowPanel=nil;
_UIObject_release(self.beforeEffect);self.beforeEffect=nil;
_UIObject_release(self.resultPanel);self.resultPanel=nil;
end















local _this




function UILZPZResultWin:onLoaded(...)
self:bindComponents()
_this=self

self.progressbar:setFinishAction(function(...)
if not _this then return end
_this:onProgressAniFinish(...)
end)
end


function UILZPZResultWin:__delete()
_this=nil
self:unbindComponents()

UIManager:callWindowFunc('UILingZhenPZGameWin','clearGame')
end




function UILZPZResultWin:onShow(argtable,afterOnloaded)
local success=argtable.success
self.callback=argtable.callback
self.successFlag=argtable.success
self.success:setActive(success)
self.failure:setActive(not success)
self.score=argtable.score
self.originalTopScore=argtable.originalTopScore


if success then
self.resultPanel:setChildCanvasGroupAlpha(0)
self.beforeShowPanel:setActive(true)
self.beforeEffect:setChildShowEffect(10060,true)
self.resultPanel:setActive(false)
self:delayDo(1.5,function()
if not _this then return end
self:refreshResultPanel()
self.resultPanel:setActive(true)
self.resultPanel:setChildCanvasGroupDOFade(1,0.5,function()
if not _this then return end
self.beforeShowPanel:setActive(false)
end)
end)
self.bg:setGray(false)
else
self.bg:setGray(true)
self.beforeShowPanel:setActive(false)
self.resultPanel:setActive(true)
self.resultPanel:setChildCanvasGroupAlpha(1)
self:refreshResultPanel()
end

end


function UILZPZResultWin:onHide()

end

function UILZPZResultWin:refreshResultPanel()
local success=self.successFlag
if success then
self.effect:setChildShowEffect(10014,true)
end


self.nowScore:setText(self.score)
self.nowTopScore=lingZhenPengZhuangModel:getTopScore()or 0
self.topScore:setText(self.nowTopScore)
local isUpdateTopScore=self.originalTopScore<self.nowTopScore
self.topScoreUpIcon:setActive(isUpdateTopScore)


local allRewardCfg=cfg_lingzhenpengzhuangstageconfig()
local originalLevel=1
local nowLevel=1
local maxLevelId=allRewardCfg[#allRewardCfg].id
local rewardList_lookup={}
for i=1,#allRewardCfg do
local cfg=allRewardCfg[i]
local score=cfg.score
local lastLevel=i>1 and i-1 or nil
local lastLevelScore=lastLevel and allRewardCfg[lastLevel].score or 0
if self.originalTopScore>=lastLevelScore then
originalLevel=cfg.id
end
if self.nowTopScore>=lastLevelScore then
nowLevel=cfg.id
end

if self.originalTopScore<score and self.nowTopScore>=score then
local reward=cfg.reward
for _,v in ipairs(reward)do
local itemId=v[1]
local itemCount=v[2]
if rewardList_lookup[itemId]then
rewardList_lookup[itemId]=rewardList_lookup[itemId]+itemCount
else
rewardList_lookup[itemId]=itemCount
end
end
end
end

local isShowReward=nowLevel>originalLevel
local isMax=originalLevel>=maxLevelId
self.rewardPanel:setActive(isShowReward)
self.getAllTips:setActive(not isShowReward and isMax)
if isShowReward then
local rewardList={}
for itemId,count in pairs(rewardList_lookup)do
rewardList[#rewardList+1]={itemId,count}
end
table.sort(rewardList,function(a,b)
local itemId1=a[1]
local itemId2=b[1]
local itemColor1=itemsConfig.getItemColor(itemId1)
local itemColor2=itemsConfig.getItemColor(itemId2)
if itemColor1==itemColor2 then
return itemId1<itemId2
else
return itemColor1>itemColor2
end
end)

self.rewardList:setChildLayoutGroupCreateItems(#rewardList)
local grids=self.rewardList:getChildLayoutGroupGridList()
for j=1,grids.Count do
local item=grids[j-1]
item:SetChildActive(-1,true)
local itemCfg=rewardList[j]
local itemId=itemCfg[1]
local itemNum=itemCfg[2]
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end


self.curScore=self.originalTopScore
self.curLevel=originalLevel
local lastLevel=self.curLevel-1
if lastLevel<=0 then
lastLevel=nil
end
local lastLevelScore=lastLevel and allRewardCfg[lastLevel].score or 0
local levelMaxScore=allRewardCfg[self.curLevel].score
local maxScore=allRewardCfg[maxLevelId].score
self.finalTargetLevel=nowLevel
self.finalTargetScore=self.nowTopScore
if self.finalTargetScore>maxScore then
self.finalTargetScore=maxScore
end
local cur=math.floor((self.curScore-lastLevelScore)/(levelMaxScore-lastLevelScore)*100)
local animTarget
if self.finalTargetScore>=levelMaxScore then
self.targetScore=levelMaxScore
animTarget=100
else
self.targetScore=self.finalTargetScore
animTarget=math.floor((self.targetScore-lastLevelScore)/(levelMaxScore-lastLevelScore)*100)
end




self.progressText:setText(FMT.fmt('{0}/{1}',self.targetScore,levelMaxScore))

if isUpdateTopScore then

self.progressbar:animateFiveParams(cur,animTarget,100,0.5,false)
else
self.progressbar:animateFourParams(cur,100,0,false)
end

end

function UILZPZResultWin:onProgressAniFinish()
if not _this then
return
end
local allRewardCfg=cfg_lingzhenpengzhuangstageconfig()

if self.targetScore<self.finalTargetScore then
local lastLevel=self.curLevel
self.curLevel=self.curLevel+1
self.curScore=self.targetScore
local lastLevelScore=self.targetScore
local levelMaxScore=allRewardCfg[self.curLevel].score
local animTarget
if self.finalTargetScore>=levelMaxScore then
self.targetScore=levelMaxScore
animTarget=100
else
self.targetScore=self.finalTargetScore
animTarget=math.floor((self.targetScore-lastLevelScore)/(levelMaxScore-lastLevelScore)*100)
end







self.progressText:setText(FMT.fmt('{0}/{1}',self.targetScore,levelMaxScore))
self:delayDo(0.1,function()
if _this==nil then
return
end
_this.progressbar:animateFiveParams(0,animTarget,100,0.5,false)
end)
else
local levelMaxScore=allRewardCfg[self.curLevel].score
if self.targetScore==levelMaxScore and allRewardCfg[self.curLevel+1]~=nil then
levelMaxScore=allRewardCfg[self.curLevel+1].score
self.curScore=self.targetScore





self.progressbar:animateFourParams(0,100,0,false)
self.progressText:setText(FMT.fmt('{0}/{1}',self.curScore,levelMaxScore))
end
end

end




function UILZPZResultWin:onCloseClick()
self.bg:setButtonClick(function()end,true)
if self.callback then
local callback=self.callback
callback()
end
self:closeSelf()
end

function UILZPZResultWin:onBg()
self:onCloseClick()
end


function UILZPZResultWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid,showModel=true,})

end