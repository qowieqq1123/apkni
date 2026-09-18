







def_class("UINPCPKVictoryWin",UIWindowBase)









function UINPCPKVictoryWin:bindComponents()

self.tipsTxt=UIText.get(self,0)
self.rewardGridPanel=UIObject.get(self,1)



end


function UINPCPKVictoryWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.rewardGridPanel);self.rewardGridPanel=nil;
end

















function UINPCPKVictoryWin:onLoaded(...)
self:bindComponents()
end


function UINPCPKVictoryWin:__delete()
self:unbindComponents()
end


function UINPCPKVictoryWin:onHide()

end




function UINPCPKVictoryWin:onShow(argtable,afterOnloaded)
self.tipstr=argtable.tipstr

local intimacy=argtable.intimacy
self.rewards=table.deepCopy(argtable.rewards)or{}

local reward={itemid=xianzhanModel.showItemid,num=intimacy}
table.insert(self.rewards,reward)

self:updateView()
end

function UINPCPKVictoryWin:updateView()



self.tipsTxt:setText(self.tipstr)

local num=#self.rewards
self.rewardGridPanel:setChildLayoutGroupCreateItems(num)
local grids=self.rewardGridPanel:getChildLayoutGroupGridList()
for i=1,num do
local item=grids[i-1]
local reward=self.rewards[i]
local itemId=reward.itemid
local itemNum=reward.num
item:SetChildCSImageIcon(0,iconHelper.getIconName(itemId),false)
local itemConfig=itemsConfig.getConfig(itemId)
local numstr=FMT.fmt('{0}+{1}',itemConfig.name,itemNum)
item:SetChildText(1,numstr)
end
end