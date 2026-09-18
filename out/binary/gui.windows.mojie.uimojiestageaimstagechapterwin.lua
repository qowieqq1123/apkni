







def_class("UIMoJieStageAimStageChapterWin",UIWindowBase)









function UIMoJieStageAimStageChapterWin:bindComponents()

self.helpBtn=UIButton.get(self,0)
self.name=UIText.get(self,1)
self.rankBtn=UIButton.get(self,2)
self.rewardBtn=UIButton.get(self,3)
self.root=UIObject.get(self,4)
self.seasonEndCD=UIText.get(self,5)
self.seasonEndPreiview=UIObject.get(self,6)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UIMoJieStageAimStageChapterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.seasonEndCD);self.seasonEndCD=nil;
_UIObject_release(self.seasonEndPreiview);self.seasonEndPreiview=nil;
end



















function UIMoJieStageAimStageChapterWin:onLoaded(...)
self:bindComponents()
end


function UIMoJieStageAimStageChapterWin:__delete()
self:stopSeasonEndCD()

self:unbindComponents()
end




function UIMoJieStageAimStageChapterWin:onShow(argtable,afterOnloaded)
self.showParams=argtable
self.handle=seasonModel:getHandle(self.showParams.handleType)
self.stage=seasonModel:getStage(self.showParams.handleType,self.showParams.stageIdx)
self.stageCfg=seasonModel:getStageConfigEx(self.showParams.handleType,self.showParams.stageIdx)

local show1=self.stageCfg.person_rank_cnt~=nil
local show2=self.stageCfg.guild_rank_cnt~=nil
if self.showParams.funcIdx2==nil then
if show1 then
self.showParams.funcIdx2=eSeasonRankType.ePlayer
elseif show2 then
self.showParams.funcIdx2=eSeasonRankType.eGuild
end
elseif self.showParams.funcIdx2==eSeasonRankType.ePlayer and not show1 then
self.showParams.funcIdx2=eSeasonRankType.eGuild
elseif self.showParams.funcIdx2==eSeasonRankType.eGuild and not show2 then
self.showParams.funcIdx2=eSeasonRankType.ePlayer
end

self.name:setText(FMT.fmt("第{0}章·{1}",mathHelper.numberToChinese(self.showParams.stageIdx),self.stageCfg.name))

self.rankBtn:setActive(show1 or show2)
self.helpBtn:setActive((self.stageCfg.winArgs.ruleParam or self.stageCfg.rankRule)~=nil)

local storyed=seasonModel:readOpenAnimRecord(self.showParams.handleType,self.showParams.stageIdx)==2


self:showWindow('UIMJMBChapterTargetWin',self.showParams)

self:refreshSeasonEndPreview()

self:refresh()

self.MJZJID=xianjieModel:getMoJunZhangJieID()
end


function UIMoJieStageAimStageChapterWin:onHide()

end

function UIMoJieStageAimStageChapterWin:refresh()
local isShowName=seasonModel:readOpenAnimRecord(self.showParams.handleType,self.showParams.stageIdx)==2
self.name:setActive(isShowName)
end






function UIMoJieStageAimStageChapterWin:onHelpBtn()
if self.stageCfg.winArgs.ruleParam then
local ruleCfg=self.stageCfg.winArgs.ruleParam
local type=ruleCfg[1]

if type==1 then
local d={}
d.mode=3
d.title=ruleCfg[2]
d.name=ruleCfg[3]
self:showWindow('UIRuleScrollViewWin',d)
elseif type==2 then
local groupId=ruleCfg[2]

local args={
ruleGroupID=groupId
}
if groupId==ruleTipsImageGroup.eZhengTaoMoJun then
if self.MJZJID==MoJunZhangJieID.two then
args={ruleGroupID=ruleTipsImageGroup.eZhengTaoMoJun2,}
end
end
self:showWindow('UIRuleTipsImage2Win',args)
end
elseif self.stageCfg.rankRule then
local ruleCfg=self.stageCfg.rankRule
local d={}
d.mode=3
d.title=ruleCfg[1]
d.name=ruleCfg[2]
self:showWindow('UIRuleScrollViewWin',d)
end
end



function UIMoJieStageAimStageChapterWin:onRankBtn()

local args={
handleType=self.showParams.handleType,
stageIdx=self.showParams.stageIdx,
selectIdx=self.showParams.funcIdx2,
parentWin=self,
}
if self.stageCfg.rankPanel then
self:showWindow(self.stageCfg.rankPanel,args)
else
self:showWindow("UIMJMBChapterRankListWin",args)
end
end



function UIMoJieStageAimStageChapterWin:onRewardBtn()

end


function UIMoJieStageAimStageChapterWin:refreshSeasonEndPreview()
self:startSeasonEndCD()
end

function UIMoJieStageAimStageChapterWin:startSeasonEndCD()
self:stopSeasonEndCD()

local enterData=xianjieModel:getMoJieEnterData()
local endTime=enterData.eTime
local curTime=timeHelper.getServerShortTime()
local leftTime=endTime-curTime
local isShow=leftTime<=7*84600 and leftTime>0
local isShowLast=isShow

self.seasonEndPreiview:setActive(isShow)

local func=function()
curTime=timeHelper.getServerShortTime()
leftTime=endTime-curTime
isShow=leftTime<=7*84600 and leftTime>0

if isShowLast~=isShow then
self.seasonEndPreiview:setActive(isShow)
end

if leftTime<0 then
self:stopSeasonEndCD()
end

self.seasonEndCD:setText(timeHelper.format_time_stamp3(leftTime))
isShowLast=isShow
end

self.seasonEndCDTimer=self:setTimer(1,0,func)
func()
end

function UIMoJieStageAimStageChapterWin:stopSeasonEndCD()
if self.seasonEndCDTimer then
self:stopTimerByID(self.seasonEndCDTimer)
self.seasonEndCDTimer=nil
end
end
