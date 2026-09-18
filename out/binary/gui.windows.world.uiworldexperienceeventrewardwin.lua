







def_class("UIWorldExperienceEventRewardWin",UIWindowBase)









function UIWorldExperienceEventRewardWin:bindComponents()

self.Content=UIText.get(self,0)
self.Reputation=UIImage.get(self,1)
self.Reward=UIObject.get(self,2)
self.ReputationText=UIText.get(self,3)
self.RewardItems={}
self.RewardItems[1]=UIBaseItem.get(self,4)
self.RewardItems[2]=UIBaseItem.get(self,5)
self.RewardItems[3]=UIBaseItem.get(self,6)
self.RewardItems[4]=UIBaseItem.get(self,7)



end


function UIWorldExperienceEventRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.Reputation);self.Reputation=nil;
_UIObject_release(self.ReputationText);self.ReputationText=nil;
_UIObject_release(self.Reward);self.Reward=nil;
for i,v in ipairs(self.RewardItems)do
_UIObject_release(v)
end
self.RewardItems=nil
end

















function UIWorldExperienceEventRewardWin:onLoaded(...)
self:bindComponents()
end


function UIWorldExperienceEventRewardWin:__delete()
self:unbindComponents()
end




function UIWorldExperienceEventRewardWin:onShow(argtable,afterOnloaded)
self.cfg=cfgHelper.get1(cfg_experienceeventrewardconfig_get,argtable[1])
self.group=argtable[2]
self.experience=argtable[3]
self.progess=argtable[4]
self.task=argtable[5]

self.Content:setText(self.cfg.content)
local reputationData=self.cfg.reputation
self.Reputation:setActive(reputationData~=nil)
if reputationData then
local reputationIdx=reputationData[1]
local reputationValue=reputationData[2]
local isGood=reputationIdx==0
local typeStr=isGood and"善良值"or"邪恶值"
local spid=isGood and 1 or 0
local numberStr=reputationValue<0 and reputationValue or FMT.fmt("+{0}",reputationValue)
numberStr=FMT.fmt("<color=#{0}>{1}</color>",isGood and"02FF2EFF"or"FB0F0FFF",numberStr)
local reputationStr=FMT.fmt("{0}: {1}",typeStr,numberStr)
self.winlua:SetChildSpriteByPrefabIndex(self.Reputation:getID(),spid,false)
self.ReputationText:setText(reputationStr)
end
self.Reward:setActive(self.cfg.rewards~=nil)
if self.cfg.rewards then
for i,v in ipairs(self.RewardItems)do
local rewardData=self.cfg.rewards[i]
local show=rewardData~=nil
v:setActive(show)
if show then
local conf={showname=false}
local item_data={itemid=rewardData[1],itemcount=rewardData[2]}
v:setChildPropData(itemsComponentHelper.getCommonFillData(item_data,conf))
end
end
end
end


function UIWorldExperienceEventRewardWin:onHide()

end




function UIWorldExperienceEventRewardWin:onClickClose()

if self.cfg.battle then
worldExperienceController:send_5_5(self.group,self.experience,self.cfg.battle,self.task.disciples)
else
worldExperienceController:passExperience(self.group,self.progess)
self.task:updateProgress()
end
self:closeSelf()
UIManager:closeWindow("UIWorldExperienceEventWin")
end
