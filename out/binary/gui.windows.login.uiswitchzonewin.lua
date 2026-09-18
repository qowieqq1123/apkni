







def_class("UISwitchZoneWin",UIWindowBase)









function UISwitchZoneWin:bindComponents()

self.menuScrollView=UIObject.get(self,0)
self.menuGrid=UIObject.get(self,1)



end


function UISwitchZoneWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.menuScrollView);self.menuScrollView=nil;
_UIObject_release(self.menuGrid);self.menuGrid=nil;
end


















local _this
local componentIndex=
{
icon=0,
clicker=1,
}


local Desc
local ZoneName
local ZoneTime


function UISwitchZoneWin:onLoaded(...)
self:bindComponents()
_this=self
ZoneName=pfwindowslController:getZoneNameCfg()
Desc=pfwindowslController:getZoneDescCfg()
ZoneTime=pfwindowslController:getZoneTimeCfg()
end


function UISwitchZoneWin:__delete()
self:unbindComponents()
end




function UISwitchZoneWin:onShow(argtable,afterOnloaded)
self.ZoneEnterInfo=pfwindowslController:getZoneEnterInfo()

local curLocalZone=pfwindowslController:getLocalZone()
self.curSelectIndex=curLocalZone
self:refreshMenu()
end


function UISwitchZoneWin:onHide()

end



function UISwitchZoneWin:refreshMenu()
local c=#self.ZoneEnterInfo
self.menuGrid:setChildLayoutGroupCreateItems(c)
if c>0 then
local grids=self.menuGrid:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
self:refreshMenuItem(item,i)
end
end
end

function UISwitchZoneWin:refreshMenuItem(item,idx)
if item==nil then
item=self.menuGrid:getChildLayoutGroupGridItem(idx-1)
end


self:refreshMenuItemSelect(item,idx,self.curSelectIndex==idx)

self:refreshMenuItemState(item,idx)

item:SetChildButtonClick(componentIndex.clicker,function()
self:onItemClick(idx)
end)

end

function UISwitchZoneWin:onSelectIndex(idx)
local curZone=ZoneName[idx]
_this.curSelectIndex=idx

pfwindowslController:setLocalZone(_this.curSelectIndex)
pfwindowslController:changeLocalZoneHandle(_this.curSelectIndex)
self:closeClick()
end

function UISwitchZoneWin:onItemClick(idx)

local curZone=ZoneName[idx]
if _this.curSelectIndex==idx then
UIManager.info(string.format("Already in Region %s",curZone))
return
end
local curDesc=Desc[idx]
local curZoneTime=ZoneTime[idx]
local curDescZone=string.format(curDesc,curZoneTime)
local showdata=
{
type='UIDialouge',
title='tips',
content=curDescZone,
oktext='Confirm',
canceltext='Cancel',
okcallback=function(...)
if _this then
_this:onSelectIndex(idx)
end
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()

end

local iconList=
{
[1]="button_qiehuaneu",
[2]="button_qiehuanna",
}

local iconAb=
{
[1]="ui/windows/login/sharedtextures/button_qiehuaneu.ab",
[2]="ui/windows/login/sharedtextures/button_qiehuanna.ab",
}

function UISwitchZoneWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGrid:getChildLayoutGroupGridItem(idx-1)
end

local showIcon=true
item:SetChildActive(componentIndex.icon,showIcon)
if showIcon then
local ab=iconAb[idx]
local iconname=iconList[idx]
item:SetChildCSImageSprite(componentIndex.icon,ab,iconname)
end
end


function UISwitchZoneWin:closeClick()
self:closeSelf()
end

function UISwitchZoneWin:refreshMenuItemState(item,idx)
if item==nil then
item=self.menuGrid:getChildLayoutGroupGridItem(idx-1)
end
local isGray=_this.curSelectIndex==idx
item:SetChildImageExGray(componentIndex.icon,isGray)
end
