







def_class("UIGuildOrderSetupWin_autoBuy",UIWindowBase)









function UIGuildOrderSetupWin_autoBuy:bindComponents()

self.elseGrid=UIObject.get(self,0)
self.moneyGrid=UIObject.get(self,1)
self.clColorDropdown=UIDropdown.get(self,2)
self.jjDanYaoDropdown=UIDropdown.get(self,3)
self.ltDanYaoDropdown=UIDropdown.get(self,4)
self.equipColorDropdown=UIDropdown.get(self,5)
self.controllBtn=UIButton.get(self,6)
self.controllClose=UIObject.get(self,7)
self.controllOpen=UIObject.get(self,8)

self.controllBtn:setButtonClick(function()self:onControllBtn()end)



end


function UIGuildOrderSetupWin_autoBuy:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.elseGrid);self.elseGrid=nil;
_UIObject_release(self.moneyGrid);self.moneyGrid=nil;
_UIObject_release(self.clColorDropdown);self.clColorDropdown=nil;
_UIObject_release(self.jjDanYaoDropdown);self.jjDanYaoDropdown=nil;
_UIObject_release(self.ltDanYaoDropdown);self.ltDanYaoDropdown=nil;
_UIObject_release(self.equipColorDropdown);self.equipColorDropdown=nil;
_UIObject_release(self.controllBtn);self.controllBtn=nil;
_UIObject_release(self.controllClose);self.controllClose=nil;
_UIObject_release(self.controllOpen);self.controllOpen=nil;
end

















function UIGuildOrderSetupWin_autoBuy:onLoaded(...)
self:bindComponents()
end


function UIGuildOrderSetupWin_autoBuy:__delete()
self:unbindComponents()
if self.isChange then
guildOrderModel:changeSetupData(self.orderID)
end
end


function UIGuildOrderSetupWin_autoBuy:onHide()

end



function UIGuildOrderSetupWin_autoBuy:onControllBtn(idx)
local orderID=self.orderID
local setup=guildOrderModel:getSetupData(orderID)
setup.isOpen=not setup.isOpen
guildOrderModel:flushSetupData(orderID)
guildOrderModel:changeSetupOpen(orderID,setup.isOpen)

self:onShow(nil,false)
UIManager:invokeUIMethod('UIGuildOrderWin','checkitemorder',GUILD_ORDER_TYPE.eAutoBuy)
end


function UIGuildOrderSetupWin_autoBuy:refreshItemControllBtn(orderID)
local isSetupOpen=guildOrderModel:isOrderSetupOpen(orderID)

self.winlua:SetChildActive(self.controllClose:getID(),not isSetupOpen)
self.winlua:SetChildActive(self.controllOpen:getID(),isSetupOpen)

self.isgray=not isSetupOpen

end





function UIGuildOrderSetupWin_autoBuy:onShow(argtable,afterOnloaded)
self.orderID=GUILD_ORDER_TYPE.eAutoBuy
self.isChange=false
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
self.lockRefresh=true
self:refreshItemControllBtn(self.orderID)

local moneyFlag=setup.moneyFlag
local moneyRange=cfg.moneyRange
local c=#moneyRange
self.moneyGrid:setChildLayoutGroupCreateItems(c)
local grids=self.moneyGrid:getChildLayoutGroupGridList()
for i=1,c do
local moneyItem=grids[i-1]
local moneyType=moneyRange[i]
local name_str=moneyModel.getMoneyName(moneyType)
moneyItem:SetChildText(1,name_str)

moneyItem:SetChildCSImageIcon(2,moneyModel.getIconNameEx(moneyType),true)
local flag=bitHelper.check_pos(moneyFlag,i-1)
moneyItem:SetChildToggle(0,flag)
moneyItem:SetChildToggleChange(0,function(name,isOn)
self:onMoneyToggle(i,isOn)
end)
end

self.equipColorDropdown:setChangeAction(function(idx_)self:onEquipColorDropdown(idx_)end)
local equipColorDropdownNames={}
local equipColorRange=cfg.equipColorRange
for i,color in ipairs(equipColorRange)do
local str
if color==-1 then
str='不购买'
else
str=FMT.fmt('{0}及以上',eQualityColorName[color])
end
table.insert(equipColorDropdownNames,str)
end
self.equipColorDropdown:setOption(equipColorDropdownNames)
self.equipColorDropdown:setValue(setup.equipColorIndex-1)

self.jjDanYaoDropdown:setChangeAction(function(idx_)self:onJJDanYaoDropdown(idx_)end)
local jjDanYaoDropdownNames={}
local jjDanYaoRange=cfg.jjDanYaoRange
for i,color in ipairs(jjDanYaoRange)do
local str
if color==-1 then
str='不购买'
else
str=FMT.fmt('{0}及以上',eQualityColorName[color])
end
table.insert(jjDanYaoDropdownNames,str)
end
self.jjDanYaoDropdown:setOption(jjDanYaoDropdownNames)
self.jjDanYaoDropdown:setValue(setup.jjDanYaoIndex-1)

self.ltDanYaoDropdown:setChangeAction(function(idx_)self:onLTDanYaoDropdown(idx_)end)
local ltDanYaoDropdownNames={}
local ltDanYaoRange=cfg.ltDanYaoRange
for i,color in ipairs(ltDanYaoRange)do
local str
if color==-1 then
str='不购买'
else
str=FMT.fmt('{0}及以上',eQualityColorName[color])
end
table.insert(ltDanYaoDropdownNames,str)
end
self.ltDanYaoDropdown:setOption(ltDanYaoDropdownNames)
self.ltDanYaoDropdown:setValue(setup.ltDanYaoIndex-1)

self.clColorDropdown:setChangeAction(function(idx_)self:onCLColorDropdown(idx_)end)
local clColorDropdownNames={}
local clColorRange=cfg.clColorRange
for i,color in ipairs(clColorRange)do
local str
if color==-1 then
str='不购买'
else
str=FMT.fmt('{0}品及以上',color)
end
table.insert(clColorDropdownNames,str)
end
self.clColorDropdown:setOption(clColorDropdownNames)
self.clColorDropdown:setValue(setup.clColorIndex-1)

local elseFlag=setup.elseFlag
local elseRange=cfg.elseRange
local c2=#elseRange
self.elseGrid:setChildLayoutGroupCreateItems(c2)
local grids2=self.elseGrid:getChildLayoutGroupGridList()
for i=1,c2 do
local item=grids2[i-1]
local data=elseRange[i]
local name_str=data[3]
item:SetChildText(1,name_str)
local flag=bitHelper.check_pos(elseFlag,i-1)
item:SetChildToggle(0,flag)
item:SetChildToggleChange(0,function(name,isOn)
self:onElseToggle(i,isOn)
end)
end

self.lockRefresh=false

end

function UIGuildOrderSetupWin_autoBuy:onMoneyToggle(idx,isOn)
if self.lockRefresh then return end
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
if isOn then
setup.moneyFlag=bitHelper.set_1(setup.moneyFlag,idx-1)
else
setup.moneyFlag=bitHelper.set_0(setup.moneyFlag,idx-1)
end
guildOrderModel:flushSetupData(self.orderID)
self.isChange=true
end

function UIGuildOrderSetupWin_autoBuy:onEquipColorDropdown(idx)
if self.lockRefresh then return end
idx=idx+1
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
setup.equipColorIndex=idx
guildOrderModel:flushSetupData(self.orderID)
self.isChange=true
end

function UIGuildOrderSetupWin_autoBuy:onJJDanYaoDropdown(idx)
if self.lockRefresh then return end
idx=idx+1
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
setup.jjDanYaoIndex=idx
guildOrderModel:flushSetupData(self.orderID)
self.isChange=true
end

function UIGuildOrderSetupWin_autoBuy:onLTDanYaoDropdown(idx)
if self.lockRefresh then return end
idx=idx+1
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
setup.ltDanYaoIndex=idx
guildOrderModel:flushSetupData(self.orderID)
self.isChange=true
end

function UIGuildOrderSetupWin_autoBuy:onCLColorDropdown(idx)
if self.lockRefresh then return end
idx=idx+1
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
setup.clColorIndex=idx
guildOrderModel:flushSetupData(self.orderID)
self.isChange=true
end

function UIGuildOrderSetupWin_autoBuy:onElseToggle(idx,isOn)
if self.lockRefresh then return end
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
if isOn then
setup.elseFlag=bitHelper.set_1(setup.elseFlag,idx-1)
else
setup.elseFlag=bitHelper.set_0(setup.elseFlag,idx-1)
end
guildOrderModel:flushSetupData(self.orderID)
self.isChange=true
end
