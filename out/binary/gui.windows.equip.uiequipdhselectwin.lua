







def_class("UIEquipDHSelectWin",UIWindowBase)









function UIEquipDHSelectWin:bindComponents()

self.creater=UIObject.get(self,0)
self.Dropdown=UIDropdownEx.get(self,1)
self.btnCreater=UIObject.get(self,2)



end


function UIEquipDHSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.creater);self.creater=nil;
_UIObject_release(self.Dropdown);self.Dropdown=nil;
_UIObject_release(self.btnCreater);self.btnCreater=nil;
end


















function UIEquipDHSelectWin:onLoaded(...)
self:bindComponents()
self.Dropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
self.filterIdx=0
self.btnIdx=1
self:freshAllData()
self:initDrop()
end

function UIEquipDHSelectWin:__delete()
self:unbindComponents()

if UIManager:isActive("UITipsWin")then
UIManager:closeWindow("UITipsWin")
end
end

function UIEquipDHSelectWin:onShow(argtable,afterOnloaded)
self.selectCB=argtable.selectCB
self.itemguid=argtable.itemguid
self:freshInfo()
end

function UIEquipDHSelectWin:onHide()

end


function UIEquipDHSelectWin:freshInfo()
local cfg=equipsConfig.getEquipDianHuaDefCfg()
local minColor=cfg.min_equip_color

local filter={}
filter[ITEM_FILTER_TYPE.eStage]=self.stageLookup[self.btnIdx]
filter[ITEM_FILTER_TYPE.eColor]={ITEM_FILTER_COMPARE.eGreaterEquals,minColor}

if self.filterIdx>0 then
filter[ITEM_FILTER_TYPE.eEquipType1]=self.posLook[self.filterIdx]
end

local equips=equipsModel.getEquipByFilter(filter)

local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eEquipBag,filter,false)

local temp={}
for _,v in ipairs(equips)do
if equipsHelper.isCanDianHua(v.itemguid)then
temp[#temp+1]=v
end
end

for i,v in ipairs(baglist)do
if equipsHelper.isCanDianHua(v.itemguid)then
temp[#temp+1]=v
end
end

local len=#temp
self.creater:setChildLayoutGroupCreateItems(len,function(i)
local widget=self.creater:getChildLayoutGroupGridItem(i-1)
local item=temp[i]
local itemid=item.itemid
local itemguid=item.itemguid
local isEquip=equipsModel.isEquipedOnAnyDizi(itemguid)
local itemCfg=itemsConfig.getConfig(itemid)
local color=itemCfg.color
local name=itemCfg.name
local cfg={itemid=itemid,itemguid=itemguid,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(cfg)
local suitIcon=equipsHelper.getEquipSuitIcon(item)
local type2=itemsConfig.getConfig(itemid).type2
local vocList=equipsHelper.getLimitVoc(type2)or{}
local vocDesc=''
local select=tostring(self.itemguid)==tostring(itemguid)
for i,v in ipairs(vocList)do
local vocationConfig=equipsConfig.getDiziVocationConfig(v)
local hide=vocationConfig.hide
if not hide then
local _name=vocationConfig.name
local split=i~=1 and' 'or''
vocDesc=FMT.fmt('{0}{1}[{2}]',vocDesc,split,_name)
end
end
if vocDesc==''then
vocDesc='[全职业]'
end
prop[PropIndex(DataPropKey.eWidgetIcon,10)]=suitIcon
widget:SetChildPropData(0,prop)
widget:SetChildText(1,name)
widget:SetChildText(2,vocDesc)
widget:SetChildActive(3,isEquip)
widget:SetChildActive(4,not select)
widget:SetChildButtonClick(4,function()
if self.selectCB then
self.selectCB(itemguid)
end
end,true)
widget:SetChildActive(5,select)
widget:SetChildButtonClick(5,function()
if self.selectCB then
self.selectCB(itemguid)
end
end,true)

widget:SetBaseItemClickEvent(0,function()

local attach={}
attach.selectCB=self.selectCB
tipsManager.showTips({formType=TIPS_FORM_TYPE.eTianGongGeDianHua,
itemid=itemid,
showModel=true,
itemguid=itemguid,
attach=attach,
})
end)

widget:SetChildButtonClick(6,function()

local attach={}
attach.selectCB=self.selectCB
tipsManager.showTips({formType=TIPS_FORM_TYPE.eTianGongGeDianHua,
itemid=itemid,
showModel=true,
itemguid=itemguid,
attach=attach,
})
end)
end)

self:freshBtns()
end


function UIEquipDHSelectWin:initDrop()
self.Dropdown:setOption(self.posNames)
self.Dropdown:setValue(0)
end

function UIEquipDHSelectWin:onDropdownChange(index)
if self.filterIdx==index then return end
self.filterIdx=index
self:freshInfo()
end

function UIEquipDHSelectWin:freshBtns()
local minStage=self.minStage
local maxStage=self.maxStage
local len=maxStage-minStage+1
self.btnCreater:setChildLayoutGroupCreateItems(len,function(i)
local widget=self.btnCreater:getChildLayoutGroupGridItem(i-1)
local stage=self.stageLookup[i]
widget:SetChildActive(0,self.btnIdx~=i)
widget:SetChildActive(1,self.btnIdx==i)
widget:SetChildButtonClick(2,function()
self:onSelectBtn(i)
end,true)
widget:SetChildText(3,FMT.fmt('{0}阶',stage))
end)
end

function UIEquipDHSelectWin:onSelectBtn(i)
if self.btnIdx==i then return end
local oldidx=self.btnIdx
self.btnIdx=i
if oldidx then
local widget=self.btnCreater:getChildLayoutGroupGridItem(oldidx-1)
widget:SetChildActive(0,true)
widget:SetChildActive(1,false)
end
local widget=self.btnCreater:getChildLayoutGroupGridItem(i-1)
widget:SetChildActive(0,false)
widget:SetChildActive(1,true)
self:freshInfo()
end

function UIEquipDHSelectWin:getAllDianHuaEquips()
local cfg=equipsConfig.getEquipDianHuaDefCfg()
local minStage=cfg.min_equip_stage
local minColor=cfg.min_equip_color
self.minColor=minColor
local filter={}
filter[ITEM_FILTER_TYPE.eStage]={ITEM_FILTER_COMPARE.eGreaterEquals,minStage}
filter[ITEM_FILTER_TYPE.eColor]={ITEM_FILTER_COMPARE.eGreaterEquals,minColor}
local equips=equipsModel.getEquipByFilter(filter)
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eEquipBag,filter)
local temp={}
for i,v in ipairs(equips)do
if equipsHelper.isCanDianHua(v.itemguid)then
temp[#temp+1]=v
end
end

for i,v in ipairs(baglist)do
if equipsHelper.isCanDianHua(v.itemguid)then
temp[#temp+1]=v
end
end
return temp
end

function UIEquipDHSelectWin:freshAllData()
local list=self:getAllDianHuaEquips()
local maxStage=nil
local minStage=nil
for i,v in ipairs(list)do
local stage=itemsConfig.getConfig(v.itemid).stage
if maxStage==nil or stage>maxStage then
maxStage=stage
end
if minStage==nil or stage<minStage then
minStage=stage
end
end
self.maxStage=maxStage
self.minStage=minStage

self.stageLookup={}
if minStage and maxStage then
local index=0
for i=minStage,maxStage do
index=index+1
self.stageLookup[index]=i
end
end

local posNames={}
posNames[#posNames+1]='全部'
local posLook={}
for i=EQUIP_TYPE.eWeapon,EQUIP_TYPE.eShoot do
posNames[#posNames+1]=cfgHelper.get2(cfg_discipleequiptypeconfig_get,i,'name')
posLook[i]=i
end
self.posNames=posNames
self.posLook=posLook
end