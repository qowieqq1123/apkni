







def_class("UISubAct_ChiSeJinDi_RankRuleWin",UIWindowBase)









function UISubAct_ChiSeJinDi_RankRuleWin:bindComponents()

self.background=UIButton.get(self,0)
self.cdTips=UIText.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.stageList=UIObject.get(self,3)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_ChiSeJinDi_RankRuleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.cdTips);self.cdTips=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.stageList);self.stageList=nil;
end















local _this=nil
local _itemCmp={
stageName=0,
stageSection=1,
stageRewards=2,
stageNameBg=3,
}
local _abName="ui/windows/activities/sub_chisejindi/chisejindi_atlas_pak.ab"



function UISubAct_ChiSeJinDi_RankRuleWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_ChiSeJinDi_RankRuleWin:__delete()
self:unbindComponents()
_this=nil

self:stopCDTick()
end




function UISubAct_ChiSeJinDi_RankRuleWin:onShow(argtable,afterOnloaded)
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.parentWin=argtable.parentWin

self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

local scoreCfg=self.config.score
local nameCfg=self.config.scoreClient
self.stageList:setChildLayoutGroupCreateItems(#scoreCfg-1,function(index)
local item=self.stageList:getChildLayoutGroupGridItem(index-1)
local stage=#scoreCfg-index+1
local data=scoreCfg[stage]
local preData=scoreCfg[stage-1]
local rewardList=data[2]
local topLimit=data[1]

item:SetChildCSImageSprite(_itemCmp.stageName,_abName,nameCfg[stage][3])
item:SetChildCSImageSprite(_itemCmp.stageNameBg,_abName,nameCfg[stage][4])
item:SetChildText(_itemCmp.stageSection,topLimit)
item:SetChildLayoutGroupCreateItems(_itemCmp.stageRewards,#rewardList,function(idx)
local _item=item:GetChildLayoutGroupGridItem(_itemCmp.stageRewards,idx-1)
local _data=rewardList[idx]
local showCountBG=_data[2]>0
local countStr=showCountBG and mathHelper.formatNumber(_data[2])or""
local conf={itemid=_data[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
_item:SetChildPropData(-1,prop)
_item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
end)

self:startCDTick()
end


function UISubAct_ChiSeJinDi_RankRuleWin:onHide()

end




function UISubAct_ChiSeJinDi_RankRuleWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UISubAct_ChiSeJinDi_RankRuleWin:onBackground()
self:onCloseBtn()
end

function UISubAct_ChiSeJinDi_RankRuleWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_ChiSeJinDi_RankRuleWin:updateCDTick()
local nowStamp=timeHelper.getServerLongTime()
local deltaStamp=nowStamp-self.info.cycleBegin
local weekSecond=deltaStamp%self.info.cycleDuration
local leastTime=self.info.cycleDuration-weekSecond
local tipsStr=FMT.fmt("距离下次结算倒计时：<color=#00a504>{0}</color>",timeHelper.format_time_stamp3(leastTime))
self.cdTips:setText(tipsStr)
end

function UISubAct_ChiSeJinDi_RankRuleWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end