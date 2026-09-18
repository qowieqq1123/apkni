







def_class("UIMysteryEventSelectWin",UIWindowBase)









function UIMysteryEventSelectWin:bindComponents()

self.root=UIObject.get(self,0)



end


function UIMysteryEventSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
end



















local widgetIndex=
{
name=0,
button=1,
}


function UIMysteryEventSelectWin:onLoaded(...)
self:bindComponents()
end


function UIMysteryEventSelectWin:__delete()
self:unbindComponents()
end




function UIMysteryEventSelectWin:onShow(argtable,afterOnloaded)
self.args=argtable

local eventList=self.args.eventList
self.root:setChildLayoutGroupCreateItems(#eventList)
local gridlist=self.root:getChildLayoutGroupGridList()
local c=gridlist.Count
local item=nil
for i=0,c-1 do
item=gridlist[i]
if eventList[i+1]then
local eventId=eventList[i+1]
local cfg=MysteryEventModel.get_group_main_option(eventId)
if cfg then
item:SetChildText(widgetIndex.name,cfg.title)
end
item:SetChildButtonClickWithID(widgetIndex.button,function(idx)



MysteryEventSystem.send_18_8(self.args.guid,self.args.resultIndex,self.args.sysId,eventList[1])
MysteryEventModel:set_current_result_data(MysteryEventResult.EventResultType.nextEvent,eventList[1])
UIManager:closeWindow("UIMysteryEventSelectWin")
end,eventId)
end
end
end


function UIMysteryEventSelectWin:onHide()

end



