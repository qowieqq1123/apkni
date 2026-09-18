







def_class("UITabListComponent7",UIWindowBase)









function UITabListComponent7:bindComponents()

self.ToggleGroup=UIObject.get(self,0)



end


function UITabListComponent7:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ToggleGroup);self.ToggleGroup=nil;
end


local _this=nil
local menu_slot_name='button_dytab'


function UITabListComponent7:onLoaded(...)
self:bindComponents()
_this=self
self.ToggleGroup:setScale(Vector3.zero)
self.ToggleGroup:setChildDOScale(1,0.5)
end


function UITabListComponent7:__delete()
self:clearReddotFunction()
self:unbindComponents()
_this=nil
end




function UITabListComponent7:onShow(argtable,afterOnloaded)
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
item:SetChildNewBieComponentId(0,FMT.fmt('UITabListComponent7.toggleListItem_{0}',i))
item:SetChildText(1,data)

local isSelected=self.curSelectPage==i
local func=function()
if isSelected then


item:SetChildActive(6,isSelected)
end
end










item:SetChildActive(6,isSelected)
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

function UITabListComponent7:clearReddotFunction()
if self.reddotfuncs then
for k,v in pairs(self.reddotfuncs)do
reddotClassManager.unregister_event(k,v)
end
end
self.reddotfuncs={}
end

function UITabListComponent7:refreshReddot(index,class,sub_typo,last_flag,flag)
local item=self.ToggleGroup:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(3,flag)
end


function UITabListComponent7:onHide()
self:clearReddotFunction()
end



function UITabListComponent7:triggerToggle(idx)
self.onToggleChange(idx)
end


function UITabListComponent7.onToggleChange(idx)

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

function UITabListComponent7:setToggleOn(index,on)
local item=self.ToggleGroup:getChildLayoutGroupGridItem(index-1)





item:SetChildActive(6,on)
end

function UITabListComponent7:refreshItemName(argtable)
local cnt=#argtable
for i=1,cnt do
local data=argtable[i]
local item=self.ToggleGroup:getChildLayoutGroupGridItem(i-1)
item:SetChildText(1,data)
end
end
