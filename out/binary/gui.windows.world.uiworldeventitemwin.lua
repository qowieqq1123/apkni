







def_class("UIWorldEventItemWin",UIWindowBase)









function UIWorldEventItemWin:bindComponents()

self.Content=UIText.get(self,0)
self.Reputation=UIObject.get(self,1)
self.Reward=UIObject.get(self,2)
self.ReputationText=UIText.get(self,3)
self.RewardList=UIScrollView.get(self,4)

self.RewardList:setClickAction(itemsComponentHelper.onItemClick)








end


function UIWorldEventItemWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.Reputation);self.Reputation=nil;
_UIObject_release(self.ReputationText);self.ReputationText=nil;
_UIObject_release(self.Reward);self.Reward=nil;
_UIObject_release(self.RewardList);self.RewardList=nil;



self.RewardItems=nil
end

















function UIWorldEventItemWin:onLoaded(...)
self:bindComponents()
end


function UIWorldEventItemWin:__delete()
self:unbindComponents()
end




function UIWorldEventItemWin:onShow(argtable,afterOnloaded)
if not argtable then return end
self.content=argtable.content
self.reputation=argtable.reputation
self.rewards=argtable.rewards
self.closeFunc=argtable.close

self.Content:setText(self.content)
self.Reputation:setActive(self.reputation~=nil)
if self.reputation then
local reputationIdx=self.reputation[1]
local reputationValue=self.reputation[2]
local isGood=reputationIdx==0
local typeStr=isGood and"善良值"or"邪恶值"
local spid=isGood and 1 or 0
local numberStr=reputationValue<0 and reputationValue or FMT.fmt("+{0}",reputationValue)
numberStr=FMT.fmt("<color=#{0}>{1}</color>",isGood and"549327ff"or"c82c2cff",numberStr)
local reputationStr=FMT.fmt("{0}: {1}",typeStr,numberStr)
self.winlua:SetChildSpriteByPrefabIndex(self.Reputation:getID(),spid,false)
self.ReputationText:setText(reputationStr)
end
self.Reward:setActive(self.rewards~=nil)
if self.rewards then
local cnt=#self.rewards
local col=4
local row=math.ceil(cnt/col)
self.RewardList:freshGridsNum(cnt,row,col,false)

local propDatas={}
for i,v in ipairs(self.rewards)do
local conf={showname=false}
local item_data={itemid=v[1],itemcount=v[2]}
table.insert(propDatas,itemsComponentHelper.getCommonFillData(item_data,conf))
end
self.RewardList:initPropData(propDatas)











end
end


function UIWorldEventItemWin:onHide()

end




function UIWorldEventItemWin:onClickClose()
if self.closeFunc then self.closeFunc()end
end