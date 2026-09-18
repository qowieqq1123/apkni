







def_class("UITabListComponent",UIWindowBase)









function UITabListComponent:bindComponents()

self.ToggleGroup=UIObject.get(self,0)



end


function UITabListComponent:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ToggleGroup);self.ToggleGroup=nil;
end



















local _this=nil
local menu_slot_name='button_dytab'


function UITabListComponent:onLoaded(...)
self:bindComponents()
_this=self
end


function UITabListComponent:__delete()
self:clearReddotFunction()
self:unbindComponents()
_this=nil
end




function UITabListComponent:onShow(argtable,afterOnloaded)
self.click=argtable.click
self.curSelectPage=argtable.init
self.reddotSubTypes=argtable.reddotSubTypes
self.tabTypes=argtable.tabTypes
self.indexs=argtable.indexs

self:clearReddotFunction()

local cnt=#argtable.names
self.ToggleGroup:setChildLayoutGroupCreateItems(cnt)
for i=1,cnt do
local data=argtable.names[i]
local item=self.ToggleGroup:getChildLayoutGroupGridItem(i-1)
item:SetChildButtonClickWithID(0,self.onToggleChange,i,true)
item:SetChildNewBieComponentId(0,FMT.fmt('UITabListComponent.toggleListItem_{0}',i))
item:SetChildText(1,data)

local isSelected=self.curSelectPage==i
local func=function()
if isSelected then

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,isSelected and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
end

if afterOnloaded then
item:SetChildUIModelShowTarget(2,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)
else
item:SetChildUIModelShowTarget(2,2017,1,{},eAnimationID.common_window_stand,false,false,0,func)
end





local isreddot=false
local reddotIndx=self.indexs[i]
local reddotSubType=self.reddotSubTypes[reddotIndx]
if reddotSubType then
isreddot=reddotClassManager.get_reddot(reddotSubType)
local func=function(...)
if self==nil or self.isClose then return end
self:refreshReddot(i,...)
end
self.reddotfuncs[reddotSubType]=func
reddotClassManager.register_event(reddotSubType,func)
end
item:SetChildActive(3,isreddot)
end
if self.click then
self.click(self.curSelectPage)
end
end

function UITabListComponent:clearReddotFunction()
if self.reddotfuncs then
for k,v in pairs(self.reddotfuncs)do
reddotClassManager.unregister_event(k,v)
end
end
self.reddotfuncs={}
end

function UITabListComponent:refreshReddot(index,class,sub_typo,last_flag,flag)
local item=self.ToggleGroup:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(3,flag)
end


function UITabListComponent:onHide()
self:clearReddotFunction()
end



function UITabListComponent:triggerToggle(idx)
self.onToggleChange(idx)
end


function UITabListComponent.onToggleChange(idx)

local tabType=_this.tabTypes[idx]
if not tabScreenConfig.showTabWarning(tabType)then return end
if _this.curSelectPage~=idx then
if _this.curSelectPage then
_this:setToggleOn(_this.curSelectPage,false)
end
_this.curSelectPage=idx

_this:setToggleOn(_this.curSelectPage,true)

if _this.click then
_this.click(_this.curSelectPage)
end
end
end

function UITabListComponent:setToggleOn(index,on)
local item=self.ToggleGroup:getChildLayoutGroupGridItem(index-1)
if on then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,on and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UITabListComponent:refreshItemName(argtable)
local cnt=#argtable
for i=1,cnt do
local data=argtable[i]
local item=self.ToggleGroup:getChildLayoutGroupGridItem(i-1)
if item then
item:SetChildText(1,data)
end
end
end
