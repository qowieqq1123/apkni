







def_class("UIGuildOrderSetupWin_BuildLight",UIWindowBase)









function UIGuildOrderSetupWin_BuildLight:bindComponents()

self.controllClose=UIObject.get(self,0)
self.controllOpen=UIObject.get(self,1)
self.controllBtn=UIButton.get(self,2)
self.buildlightMode4=UIObject.get(self,3)
self.buildlightMode=UIObject.get(self,4)
self.buildlightMode2=UIObject.get(self,5)
self.buildlightMode3=UIObject.get(self,6)

self.controllBtn:setButtonClick(function()self:onControllBtn()end)



end


function UIGuildOrderSetupWin_BuildLight:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.controllClose);self.controllClose=nil;
_UIObject_release(self.controllOpen);self.controllOpen=nil;
_UIObject_release(self.controllBtn);self.controllBtn=nil;
_UIObject_release(self.buildlightMode4);self.buildlightMode4=nil;
_UIObject_release(self.buildlightMode);self.buildlightMode=nil;
_UIObject_release(self.buildlightMode2);self.buildlightMode2=nil;
_UIObject_release(self.buildlightMode3);self.buildlightMode3=nil;
end

















local _this


function UIGuildOrderSetupWin_BuildLight:onLoaded(...)
_this=self
self:bindComponents()
self.buildlightModes={self.buildlightMode,self.buildlightMode2,self.buildlightMode3,self.buildlightMode4}
end


function UIGuildOrderSetupWin_BuildLight:__delete()
self:unbindComponents()
self:ChangeDayState()
_this=nil
end




function UIGuildOrderSetupWin_BuildLight:onShow(argtable,afterOnloaded)
self.orderID=GUILD_ORDER_TYPE.eZongMenGenTi
self.isChange=false
self.isgray=false
self.thisdaystate={1,0,0,0}
self.Selectidx=1


local setup,cfg=guildOrderModel:getSetupData(self.orderID)
self.thisdaystate=setup.daystate



self:refreshItemControllBtn(self.orderID)
self:setcolorButton()
end


function UIGuildOrderSetupWin_BuildLight:onHide()

end



function UIGuildOrderSetupWin_BuildLight:onControllBtn(idx)
local orderID=_this.orderID
local setup=guildOrderModel:getSetupData(orderID)
setup.isOpen=not setup.isOpen
guildOrderModel:flushSetupData(orderID)
guildOrderModel:changeSetupOpen(orderID,setup.isOpen)
self:refreshItemControllBtn(orderID)
UIManager:invokeUIMethod('UIGuildOrderWin','checkitemorder',GUILD_ORDER_TYPE.eZongMenGenTi)
end


function UIGuildOrderSetupWin_BuildLight:refreshItemControllBtn(orderID)
local isSetupOpen=guildOrderModel:isOrderSetupOpen(orderID)
_this.winlua:SetChildActive(_this.controllClose:getID(),not isSetupOpen)
_this.winlua:SetChildActive(_this.controllOpen:getID(),isSetupOpen)
_this.isgray=not isSetupOpen
self:setgrayall(_this.isgray)
end


function UIGuildOrderSetupWin_BuildLight:setgrayall(flag)
for i=1,#_this.buildlightModes do
local widget=_this.buildlightModes[i]:getWidgetBase()
widget:SetChildActive(1,flag)
if _this.thisdaystate[i]==1 then
widget:SetChildActive(0,not flag)
else
widget:SetChildActive(0,false)
end
end
end


function UIGuildOrderSetupWin_BuildLight:setcolorButton()
for i=1,#_this.buildlightModes do
local widget=_this.buildlightModes[i]:getWidgetBase()

if _this.thisdaystate[i]==1 then
_this.Selectidx=i
widget:SetChildActive(0,not _this.isgray)
else
widget:SetChildActive(0,false)
end

widget:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onChangecolorClick(i)
end)
end
end


function UIGuildOrderSetupWin_BuildLight:colorchoose(index)
if index and _this.Selectidx==index then
return
end
local old=_this.Selectidx
_this.Selectidx=index

if old then
local oldItem=_this.buildlightModes[old]:getWidgetBase()
oldItem:SetChildActive(0,false)
end
local newItem=_this.buildlightModes[_this.Selectidx]:getWidgetBase()
newItem:SetChildActive(0,true)
end


function UIGuildOrderSetupWin_BuildLight:onChangecolorClick(index)
if _this.isgray then
UIManager.info('昼夜更替法令已关闭，开启法令后可变更选项')
return
end

self:colorchoose(index)
for k,v in ipairs(_this.thisdaystate)do
if k==_this.Selectidx then
_this.thisdaystate[k]=1
else
_this.thisdaystate[k]=0
end
end
end


function UIGuildOrderSetupWin_BuildLight:ChangeDayState()
if _this.thisdaystate then
local setup,cfg=guildOrderModel:getSetupData(_this.orderID)
setup.daystate=_this.thisdaystate
guildOrderModel:flushSetupData(_this.orderID)


local isSetupOpen=guildOrderModel:isOrderSetupOpen(_this.orderID)

if isSetupOpen then
buildlightController:setNature(false)
if _this.thisdaystate[1]==1 then
buildlightController:setTiemState(BUILD_LIGHT_TYPE.DAY)
elseif _this.thisdaystate[2]==1 then
buildlightController:setTiemState(BUILD_LIGHT_TYPE.DUSK)
elseif _this.thisdaystate[3]==1 then
buildlightController:setTiemState(BUILD_LIGHT_TYPE.NIGHT)
elseif _this.thisdaystate[4]==1 then
buildlightController:setTiemState(BUILD_LIGHT_TYPE.DAWN)
end
buildlightController:ChangeBuildLight()
else
buildlightController:cleartimedata()
buildlightController:setNature(true)
end
end
end
