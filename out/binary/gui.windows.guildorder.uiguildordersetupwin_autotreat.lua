







def_class("UIGuildOrderSetupWin_autoTreat",UIWindowBase)









function UIGuildOrderSetupWin_autoTreat:bindComponents()

self.useItemGrid=UIObject.get(self,0)
self.selectDzGrid=UIObject.get(self,1)
self.useItemAllToggle=UIToggleButton.get(self,2)
self.selectDzAllToggle=UIToggleButton.get(self,3)



end


function UIGuildOrderSetupWin_autoTreat:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.useItemGrid);self.useItemGrid=nil;
_UIObject_release(self.selectDzGrid);self.selectDzGrid=nil;
_UIObject_release(self.useItemAllToggle);self.useItemAllToggle=nil;
_UIObject_release(self.selectDzAllToggle);self.selectDzAllToggle=nil;
end



















function UIGuildOrderSetupWin_autoTreat:onLoaded(...)
self:bindComponents()
self.useItemAllToggle:setToggleChange(function(...)self:onUseItemAllToggleChanged(...)end)
self.selectDzAllToggle:setToggleChange(function(...)self:onSelectDzAllToggleChanged(...)end)
end


function UIGuildOrderSetupWin_autoTreat:__delete()
self:unbindComponents()
if self.isChange then
guildOrderModel:changeSetupData(self.orderID)
end
end




function UIGuildOrderSetupWin_autoTreat:onShow(argtable,afterOnloaded)
self.orderID=GUILD_ORDER_TYPE.eAutoTreat
self.isChange=false
local setup,cfg=guildOrderModel:getSetupData(self.orderID)


self:refreshUseItemPanel()
self:refreshUseItemAllToggleState()


self:refreshDzSelectPanel()
self:refreshSelectDzAllToggleState()

self.lockRefresh=false
end


function UIGuildOrderSetupWin_autoTreat:onHide()

end

function UIGuildOrderSetupWin_autoTreat:refreshUseItemPanel()
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
self.useItemList=cfg.useItemList
local useItemFlag=setup.useItemFlag
local useItemSelectCount=#self.useItemList
self.useItemGrid:setChildLayoutGroupCreateItems(useItemSelectCount)
local grids=self.useItemGrid:getChildLayoutGroupGridList()
for i=1,useItemSelectCount do
local item=grids[i-1]
local data=self.useItemList[i]
local itemId=data[1]
local itemCfg=itemsConfig.getConfig(itemId)
local itemColor=itemCfg.color
local name=data[2]
local name_str=FMT.cfmt(itemColor,name)
item:SetChildText(1,name_str)
local flag=bitHelper.check_pos(useItemFlag,i-1)
item:SetChildToggle(0,flag)
item:SetChildToggleChange(0,function(name,isOn)
self:onUseItemToggle(i,isOn)
end)
end
end

function UIGuildOrderSetupWin_autoTreat:refreshDzSelectPanel()
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
self.dzSelectListCfg=cfg.dzSelectList
local maxCol=5
local dzSelectFlag=setup.dzSelectFlag
local dzSelectItemCount=0
self.dzSelectIndexList={}
self.dzSelectIndexList_lookup={}
self.hideDzSelectItemIndexList={}
for i,v in ipairs(self.dzSelectListCfg)do

if self:checkShowCondition(i)then
local needGridCount=v[1]
local needToNextRowGridCount=maxCol-(dzSelectItemCount%maxCol)
if needGridCount>needToNextRowGridCount then

if needToNextRowGridCount>0 then
dzSelectItemCount=dzSelectItemCount+needToNextRowGridCount
end
end
local dzSelectItemIndex=dzSelectItemCount+1
self.dzSelectIndexList[i]=dzSelectItemIndex
self.dzSelectIndexList_lookup[dzSelectItemIndex]=i

dzSelectItemCount=dzSelectItemCount+needGridCount
else
table.insert(self.hideDzSelectItemIndexList,i)
end
end

self.selectDzGrid:setChildLayoutGroupCreateItems(dzSelectItemCount)
local grids2=self.selectDzGrid:getChildLayoutGroupGridList()
for i=1,dzSelectItemCount do
local item=grids2[i-1]
local dataIndex=self.dzSelectIndexList_lookup[i]
if dataIndex then

item:SetChildActive(3,true)
local data=self.dzSelectListCfg[dataIndex]

local showType=data[3]
local name=data[4]
if showType==1 then

item:SetChildDropDownChangeAction(2,function(idx_)self:onDzFightRankSelectDropdown(idx_,dataIndex)end)
local dzFightRankSelectDropdownNames={}
local dzFightRankSelectRange=data[5].selectRange
for i,rank in ipairs(dzFightRankSelectRange)do
local str=FMT.fmt(name,rank)
table.insert(dzFightRankSelectDropdownNames,str)
end
item:SetChildDropDownOption(2,dzFightRankSelectDropdownNames)
item:SetChildDropDownValue(2,setup.fightRankSelectIndex-1)
item:SetChildActive(4,false)
item:SetChildActive(2,true)
else
item:SetChildActive(2,false)
item:SetChildText(1,name)
item:SetChildActive(4,true)
end
local dataId=data.id
local flag=bitHelper.check_pos(dzSelectFlag,dataId-1)
item:SetChildToggle(0,flag)
item:SetChildToggleChange(0,function(name,isOn)
self:onDzSelectToggle(dataId,isOn)
end)
else

item:SetChildActive(3,false)
end
end
end

function UIGuildOrderSetupWin_autoTreat:checkShowCondition(dataIndex)
local data=self.dzSelectListCfg[dataIndex]
local showCondition=data[6]
if not showCondition then
return true
end

local checkType=showCondition[1]
local checkParam=showCondition[2]
if checkType==1 then

local bdType=checkParam
local list=zongmenModel:haveBuildByBuildId(bdType,true,true,false)
if list~=nil and#list>0 then
return true
end
end

return false
end

function UIGuildOrderSetupWin_autoTreat:refreshUseItemAllToggleState()
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
local useItemSelectCount=#self.useItemList
local maxFlag=2^useItemSelectCount-1
local useItemFlag=setup.useItemFlag
self.isUseItemAllToggle=useItemFlag==maxFlag
self.useItemAllToggle:setToggle(self.isUseItemAllToggle)
end

function UIGuildOrderSetupWin_autoTreat:refreshSelectDzAllToggleState()
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
local dzSelectCount=#self.dzSelectListCfg
local maxFlag=2^dzSelectCount-1
if self.hideDzSelectItemIndexList and next(self.hideDzSelectItemIndexList)then
for _,idx in ipairs(self.hideDzSelectItemIndexList)do

local data=self.dzSelectListCfg[idx]
local dataId=data.id
local flag=bitHelper.check_pos(setup.dzSelectFlag,dataId-1)
if flag then
maxFlag=bitHelper.set_1(maxFlag,dataId-1)
else
maxFlag=bitHelper.set_0(maxFlag,dataId-1)
end
end
end
local dzSelectFlag=setup.dzSelectFlag
self.isSelectDzAllToggle=dzSelectFlag==maxFlag
self.selectDzAllToggle:setToggle(self.isSelectDzAllToggle)
end

function UIGuildOrderSetupWin_autoTreat:onUseItemToggle(idx,isOn)
if self.lockRefresh then return end
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
if isOn then
setup.useItemFlag=bitHelper.set_1(setup.useItemFlag,idx-1)
else
setup.useItemFlag=bitHelper.set_0(setup.useItemFlag,idx-1)
end
guildOrderModel:flushSetupData(self.orderID)
self.isChange=true

self:refreshUseItemAllToggleState()
end

function UIGuildOrderSetupWin_autoTreat:onDzSelectToggle(dataId,isOn)
if self.lockRefresh then return end
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
if isOn then
setup.dzSelectFlag=bitHelper.set_1(setup.dzSelectFlag,dataId-1)
else
setup.dzSelectFlag=bitHelper.set_0(setup.dzSelectFlag,dataId-1)
end
guildOrderModel:flushSetupData(self.orderID)
self.isChange=true

self:refreshSelectDzAllToggleState()
end

function UIGuildOrderSetupWin_autoTreat:onUseItemAllToggleChanged(name,isToggle,data)
if isToggle==self.isUseItemAllToggle then return end
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
if isToggle then

local useItemSelectCount=#self.useItemList
local maxFlag=2^useItemSelectCount-1
setup.useItemFlag=maxFlag
else

local minFlag=0
setup.useItemFlag=minFlag
end
guildOrderModel:flushSetupData(self.orderID)
self.isUseItemAllToggle=isToggle
self:refreshUseItemPanel()
end

function UIGuildOrderSetupWin_autoTreat:onSelectDzAllToggleChanged(name,isToggle,data)
if isToggle==self.isSelectDzAllToggle then return end
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
if isToggle then

local dzSelectCount=#self.dzSelectListCfg
local maxFlag=2^dzSelectCount-1
setup.dzSelectFlag=maxFlag
else

local minFlag=0
if self.hideDzSelectItemIndexList and next(self.hideDzSelectItemIndexList)then
for _,idx in ipairs(self.hideDzSelectItemIndexList)do

local data=self.dzSelectListCfg[idx]
local dataId=data.id
local flag=bitHelper.check_pos(setup.dzSelectFlag,dataId-1)
if flag then
minFlag=bitHelper.set_1(minFlag,dataId-1)
else
minFlag=bitHelper.set_0(minFlag,dataId-1)
end
end
end
setup.dzSelectFlag=minFlag
end
guildOrderModel:flushSetupData(self.orderID)
self.isSelectDzAllToggle=isToggle
self:refreshDzSelectPanel()
end

function UIGuildOrderSetupWin_autoTreat:onDzFightRankSelectDropdown(idx,dataIndex)
if self.lockRefresh then return end
idx=idx+1
local setup,cfg=guildOrderModel:getSetupData(self.orderID)
setup.fightRankSelectIndex=idx
guildOrderModel:flushSetupData(self.orderID)
self.isChange=true
end


