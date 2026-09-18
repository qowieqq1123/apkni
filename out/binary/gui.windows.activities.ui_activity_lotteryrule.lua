







def_class("UI_activity_lotteryRule",UIWindowBase)









function UI_activity_lotteryRule:bindComponents()

self.list=UIObject.get(self,0)



end


function UI_activity_lotteryRule:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.list);self.list=nil;
end


















local _this=nil



function UI_activity_lotteryRule:onLoaded(...)
self:bindComponents()
_this=self
end


function UI_activity_lotteryRule:__delete()
self:unbindComponents()
_this=nil
end




function UI_activity_lotteryRule:onShow(argtable,afterOnloaded)
self.activityId=argtable.activityId
self.subType=argtable.subType
self.subId=argtable.subId

local config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
local datas=config.reward_rule
self.list:setChildLayoutGroupCreateItems(#datas,function(index)
local item=self.list:getChildLayoutGroupGridItem(index-1)
local str=datas[index]
item:SetChildText(0,str)
end)
self.winlua:ForceLayoutRect(self.list:getID())
end


function UI_activity_lotteryRule:onHide()

end



