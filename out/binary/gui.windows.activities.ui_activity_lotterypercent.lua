







def_class("UI_activity_lotteryPercent",UIWindowBase)









function UI_activity_lotteryPercent:bindComponents()

self.list=UIObject.get(self,0)



end


function UI_activity_lotteryPercent:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.list);self.list=nil;
end
















local _this=nil




function UI_activity_lotteryPercent:onLoaded(...)
self:bindComponents()
_this=self
end


function UI_activity_lotteryPercent:__delete()
self:unbindComponents()
_this=nil
end




function UI_activity_lotteryPercent:onShow(argtable,afterOnloaded)
self.activityId=argtable.activityId
self.subType=argtable.subType
self.subId=argtable.subId

local config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
local datas=config.reward_percent
self.list:setChildLayoutGroupCreateItems(#datas,function(index)
local item=self.list:getChildLayoutGroupGridItem(index-1)
local data=datas[index]
item:SetChildText(0,data[1])
item:SetChildText(1,FMT.fmt("{0}%",data[2]/100))
end)
end


function UI_activity_lotteryPercent:onHide()

end



