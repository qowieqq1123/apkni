







def_class("UICJXYStageChapterWin",UIWindowBase)









function UICJXYStageChapterWin:bindComponents()

self.helpBtn=UIButton.get(self,0)
self.name=UIText.get(self,1)
self.rewardBtn=UIButton.get(self,2)
self.root=UIObject.get(self,3)
self.tab_1=UIButton.get(self,4)
self.tab_2=UIButton.get(self,5)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.tab_1:setButtonClick(function()self:onTab_1()end)

self.tab_2:setButtonClick(function()self:onTab_2()end)
self.tab={
self.tab_1,
self.tab_2,
}



end


function UICJXYStageChapterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tab_1);self.tab_1=nil;
_UIObject_release(self.tab_2);self.tab_2=nil;
self.tab=nil;
end















local _this=nil
local _tabCmp={
widget=0,
select=1,
reddot=2,
}
local _typeView={
[1]="UICJXYChapterTargetWin",
[2]="UICJXYChapterRankWin",
}
local _reddotFunc={
[1]="getTargetReddot",
[2]="getRankReddot",
}



function UICJXYStageChapterWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
self:addNotify(notifyConfig.onSeasonStageDataChange,self.onSeasonStageDataChange)
self:addNotify(notifyConfig.onSeasonOpenAnimationChange,self.onSeasonOpenAnimationChange)
end


function UICJXYStageChapterWin:__delete()
self:unbindComponents()
_this=nil
end




function UICJXYStageChapterWin:onShow(argtable,afterOnloaded)
self.showParams=argtable
self.stage=seasonModel:getStage(self.showParams.handleType,self.showParams.stageIdx)
self.stageCfg=seasonModel:getStageConfigEx(self.showParams.handleType,self.showParams.stageIdx)

self.name:setText(FMT.fmt("第{0}章·{1}",mathHelper.numberToChinese(self.showParams.stageIdx),self.stageCfg.name))

local show1=true
local show2=self.stageCfg.person_rank_cnt~=nil or self.stageCfg.guild_rank_cnt~=nil
local show=show1 and show2
self.tab_1:setActive(show)
self.tab_2:setActive(show)
if self.showParams.funcIdx1==nil then
if show1 then
self.showParams.funcIdx1=1
elseif show2 then
self.showParams.funcIdx1=2
end
elseif self.showParams.funcIdx1==1 and not show1 then
self.showParams.funcIdx1=2
elseif self.showParams.funcIdx1==2 and not show2 then
self.showParams.funcIdx1=1
end

for i,v in ipairs(self.tab)do
local widget=v:getChildWidgetBase()

local reddotFunc=_reddotFunc[i]
local checkStory=seasonModel:readOpenAnimRecord(self.showParams.handleType,self.showParams.stageIdx)==2
local reddot=checkStory and self.stage and self.stage[reddotFunc]and self.stage[reddotFunc](self.stage)or false
widget:SetChildActive(_tabCmp.reddot,reddot)

local select=self.showParams.funcIdx1==i
widget:SetChildActive(_tabCmp.select,select)
if select then
self:showWindow(_typeView[i],self.showParams)
else
self:hideWindow(_typeView[i])
end
end

self:refreshRewardBtn()
end


function UICJXYStageChapterWin:onHide()

end




function UICJXYStageChapterWin:onTab_1()
self:onClickTab(1)
end


function UICJXYStageChapterWin:onTab_2()
self:onClickTab(2)
end


function UICJXYStageChapterWin:onHelpBtn()
local ruleCfg=self.showParams.funcIdx1==1 and self.stageCfg.winArgs.ruleParam or self.stageCfg.rankRule
if ruleCfg then
local d={}
d.mode=3
d.title=ruleCfg[1]
d.name=ruleCfg[2]
UIManager:showWindow('UIRuleWin',d)
end
end


function UICJXYStageChapterWin:onRewardBtn()
if self.stage then
if not self.stage:isOverBegin()or not self.stage:checkOpen()then
return
end

if self.stage.free==0 then
seasonController:send_39_2(self.showParams.handleType,self.showParams.stageIdx,1)
end
end
end

function UICJXYStageChapterWin:onClickTab(index)
local selectIdx=self.showParams.funcIdx1
if selectIdx~=index then
local widget=self.tab[selectIdx]:getChildWidgetBase()
widget:SetChildActive(_tabCmp.select,false)
self:hideWindow(_typeView[selectIdx])

self.showParams.funcIdx1=index
self.showParams.funcIdx2=nil

local widget=self.tab[index]:getChildWidgetBase()
widget:SetChildActive(_tabCmp.select,true)
self:showWindow(_typeView[index],self.showParams)
end
end

function UICJXYStageChapterWin:refreshAllTabReddot()
for i,v in ipairs(self.tab)do
self:refreshTabReddot(i)
end
end

function UICJXYStageChapterWin:refreshTabReddot(index)
local widget=self.tab[index]:getChildWidgetBase()
local show=widget:GetChildActiveSelf(_tabCmp.widget)
if show then
local reddotFunc=_reddotFunc[index]
local checkStory=seasonModel:readOpenAnimRecord(self.showParams.handleType,self.showParams.stageIdx)==2
local reddot=checkStory and self.stage and self.stage[reddotFunc]and self.stage[reddotFunc](self.stage)or false
widget:SetChildActive(_tabCmp.reddot,reddot)
end
end

function UICJXYStageChapterWin:refreshRewardBtn()
if self.stage and self.stage:getConfig("free_reward")~=nil then
if not self.stage:isOverBegin()or not self.stage:checkOpen()or seasonModel:readOpenAnimRecord(self.showParams.handleType,self.showParams.stageIdx)~=2 then
self.rewardBtn:setActive(false)
else
self.rewardBtn:setActive(self.stage.free==0)
end
else
self.rewardBtn:setActive(false)
end
end

function UICJXYStageChapterWin.onSeasonChange()
_this.stage=seasonModel:getStage(_this.showParams.handleType,_this.showParams.stageIdx)
_this:refreshAllTabReddot()
_this:refreshRewardBtn()
end

function UICJXYStageChapterWin.onSeasonStageDataChange(season_id,chapter_idx)
if _this.showParams.handleType==season_id and _this.showParams.stageIdx==chapter_idx then
_this:refreshAllTabReddot()
_this:refreshRewardBtn()
end
end

function UICJXYStageChapterWin.onSeasonStageChange(season_id,chapter_idx)
if _this.showParams.handleType==season_id and _this.showParams.stageIdx==chapter_idx then
_this.stage=seasonModel:getStage(_this.showParams.handleType,_this.showParams.stageIdx)
_this:refreshAllTabReddot()
_this:refreshRewardBtn()
end
end

function UICJXYStageChapterWin.onSeasonOpenAnimationChange(season_id,chapter_idx,record)
if _this.showParams.handleType==season_id and _this.showParams.stageIdx==chapter_idx then
_this:refreshAllTabReddot()
_this:refreshRewardBtn()
end
end