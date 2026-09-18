







def_class("UIGuildOrderSetupWin_quicklyZhaoMu",UIWindowBase)









function UIGuildOrderSetupWin_quicklyZhaoMu:bindComponents()

self.colorGrid=UIObject.get(self,0)
self.proskillGrid=UIObject.get(self,1)



end


function UIGuildOrderSetupWin_quicklyZhaoMu:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.colorGrid);self.colorGrid=nil;
_UIObject_release(self.proskillGrid);self.proskillGrid=nil;
end

















function UIGuildOrderSetupWin_quicklyZhaoMu:onLoaded(...)
self:bindComponents()
end


function UIGuildOrderSetupWin_quicklyZhaoMu:__delete()
self:unbindComponents()
if self.isChange then
guildOrderModel:changeSetupData(self.orderID)
end
end


function UIGuildOrderSetupWin_quicklyZhaoMu:onHide()

end




function UIGuildOrderSetupWin_quicklyZhaoMu:onShow(argtable,afterOnloaded)
self.orderID=GUILD_ORDER_TYPE.eQuicklyZhaoMu
self.isChange=false
local setup,cfg=guildOrderModel:getSetupData(self.orderID)

self.lockRefresh=true

local colorFlag=setup.colorFlag
local colorList=cfg.colorList
local c=#colorList
self.colorGrid:setChildLayoutGroupCreateItems(c)
local grids=self.colorGrid:getChildLayoutGroupGridList()
for i=1,c do
local colorItem=grids[i-1]
local color=colorList[i]
local name_str=eQualityColorName[color]
name_str=toColorString(color,name_str)
colorItem:SetChildText(1,name_str)
local flag=bitHelper.check_pos(colorFlag,i-1)
colorItem:SetChildToggle(0,flag)
colorItem:SetChildToggleChange(0,function(name,isOn)
self:onColorToggle(i,isOn)
end)

end

local proskillFlag=setup.proskillFlag
local proskillValues=setup.proskillValues
local proskillList=cfg.proskillList
local c2=#proskillList
self.proskillGrid:setChildLayoutGroupCreateItems(c2)
local grids2=self.proskillGrid:getChildLayoutGroupGridList()
for i=1,c2 do
local skillItem=grids2[i-1]
local proskillType=i
local proskillLevelList=proskillList[i]
local name_str=cfgHelper.get2(cfg_discipleproskillconfig_get,proskillType,'name')
name_str=FMT.fmt('{0}技能',name_str)
skillItem:SetChildText(1,name_str)
local flag=bitHelper.check_pos(proskillFlag,i-1)
skillItem:SetChildToggle(0,flag)
skillItem:SetChildToggleChange(0,function(name,isOn)
self:onProskillToggle(i,isOn)
end)

local curSelectIdx=proskillValues[i]
skillItem:SetChildDropDownChangeAction(2,function(idx_)self:onProskillDropdown(proskillType,idx_)end)
local dropdownNames={}
for i,level in ipairs(proskillLevelList)do
local str=FMT.fmt('{0}级及以上',level)
table.insert(dropdownNames,str)
end
skillItem:SetChildDropDownOption(2,dropdownNames)
skillItem:SetChildDropDownValue(2,curSelectIdx-1)
end
self.lockRefresh=false
end

function UIGuildOrderSetupWin_quicklyZhaoMu:onColorToggle(idx,isOn)
if self.lockRefresh then return end
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
if isOn then
setup.colorFlag=bitHelper.set_1(setup.colorFlag,idx-1)
else
setup.colorFlag=bitHelper.set_0(setup.colorFlag,idx-1)
end
guildOrderModel:flushSetupData(self.orderID)
self.isChange=true
end

function UIGuildOrderSetupWin_quicklyZhaoMu:onProskillToggle(idx,isOn)
if self.lockRefresh then return end
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
if isOn then
setup.proskillFlag=bitHelper.set_1(setup.proskillFlag,idx-1)
else
setup.proskillFlag=bitHelper.set_0(setup.proskillFlag,idx-1)
end
guildOrderModel:flushSetupData(self.orderID)
self.isChange=true
end

function UIGuildOrderSetupWin_quicklyZhaoMu:onProskillDropdown(proskillType,idx)
if self.lockRefresh then return end
idx=idx+1
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
local proskillValues=setup.proskillValues
proskillValues[proskillType]=idx
guildOrderModel:flushSetupData(self.orderID)
self.isChange=true
end