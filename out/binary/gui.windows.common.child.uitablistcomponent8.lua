







def_class("UITabListComponent8",UIWindowBase)









function UITabListComponent8:bindComponents()

self.ToggleGroup=UIObject.get(self,0)



end


function UITabListComponent8:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ToggleGroup);self.ToggleGroup=nil;
end
















local _this=nil
local menu_slot_name='button_dytab'


function UITabListComponent8:onLoaded(...)
self:bindComponents()
_this=self
end


function UITabListComponent8:__delete()
self:clearReddotFunction()
self:unbindComponents()
_this=nil
end




function UITabListComponent8:onShow(argtable,afterOnloaded)
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
item:SetChildNewBieComponentId(0,FMT.fmt('UITabListComponent8.toggleListItem_{0}',i))
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
if self.indexs and self.reddotSubTypes then
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
end
item:SetChildActive(3,isreddot)
end
if self.click then
self.click(self.curSelectPage)
end
end

function UITabListComponent8:clearReddotFunction()
if self.reddotfuncs then
for k,v in pairs(self.reddotfuncs)do
reddotClassManager.unregister_event(k,v)
end
end
self.reddotfuncs={}
end

function UITabListComponent8:refreshReddot(index,class,sub_typo,last_flag,flag)
local item=self.ToggleGroup:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(3,flag)
end


function UITabListComponent8:onHide()
self:clearReddotFunction()
end



function UITabListComponent8:triggerToggle(idx)
self.onToggleChange(idx)
end


function UITabListComponent8.onToggleChange(idx)

if _this.tabTypes then
local tabType=_this.tabTypes[idx]
if not tabScreenConfig.showTabWarning(tabType)then return end
end
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

function UITabListComponent8:setToggleOn(index,on)
local item=self.ToggleGroup:getChildLayoutGroupGridItem(index-1)
if on then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,on and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UITabListComponent8:refreshItemName(argtable)
local cnt=#argtable
for i=1,cnt do
local data=argtable[i]
local item=self.ToggleGroup:getChildLayoutGroupGridItem(i-1)
if item then
item:SetChildText(1,data)
end
end
end
