







def_class("UIBagEquipFilterWin",UIWindowBase)









function UIBagEquipFilterWin:bindComponents()

self.btnResetFilter=UIButton.get(self,0)
self.btnSureFilter=UIButton.get(self,1)
self.Content=UIObject.get(self,2)
self.Root=UIObject.get(self,3)
self.scrollview=UIObject.get(self,4)
self.uiRoot=UIObject.get(self,5)

self.btnResetFilter:setButtonClick(function()self:onBtnResetFilter()end)

self.btnSureFilter:setButtonClick(function()self:onBtnSureFilter()end)


self.sprite_icon_suit_1=0
self.sprite_icon_suit_1=1
self.sprite_icon_suit_2=2
self.sprite_icon_suit_3=3
self.sprite_icon_suit_4=4
self.sprite_icon_suit_5=5
self.sprite_icon_suit_6=6
self.sprite_icon_suit_7=7
self.sprite_icon_suit_8=8
self.sprite_icon_suit_9=9
self.sprite_icon_suit_10=10
self.sprite_icon_suit_11=11
self.sprite_icon_suit_12=12
self.sprite_icon_suit_13=13
self.sprite_icon_suit_14=14
self.sprite_icon_suit_15=15
self.sprite_icon_suit_16=16
self.sprite_icon_suit_17=17

end


function UIBagEquipFilterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnResetFilter);self.btnResetFilter=nil;
_UIObject_release(self.btnSureFilter);self.btnSureFilter=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this

local _filter_Sub_Item_Type={
normal=1,
dropdown=2,
all=3,
}

local _equipPosDropDownNames
local _renameType=
{
[eAttributeType.eATK_PCT]='攻击率',
[eAttributeType.eDEF_PCT]='防御率',
[eAttributeType.eHP_PCT]='生命率',
}

local _filterPartItemIndex={
title=0,
infoList=1
}

local _filterSubItemIndex={
selectBtn=0,
dropdown=1,
selectTxt=2,
selectImg=3,
dropdownRoot=4,
dropdownCaption=5,
dropdownInfo=6,
dropIcon=7,
}















local _filter_Custom
_filter_Custom={
[BAG_FILTER_TYPE.eEquipPosType]={
initFilterArgs=function(self)
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipPosType]={}
end,
buildFilterArgs=function(self,filterArgs)

local args=filterArgs[ITEM_FILTER_TYPE.eBagEquipType]








if args~=nil then
local idx
local _,info=next(args)
for type,data in pairs(info)do
idx=data[1]
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipPosType][idx]=data
end
end
end,
subTypeList={_filter_Sub_Item_Type.all,_filter_Sub_Item_Type.normal,_filter_Sub_Item_Type.normal,_filter_Sub_Item_Type.normal},
getDropDownNameList=function(self,idx)
local type=_filter_Custom[BAG_FILTER_TYPE.eEquipPosType].subTypeList[idx]
if type==_filter_Sub_Item_Type.normal then return{}end

if idx>1 then return{}end
if _equipPosDropDownNames then return _equipPosDropDownNames end
_equipPosDropDownNames={"全部"}

local cfgs=cfg_discipleweaponconfig()
for index,cfg in ipairs(cfgs)do
_equipPosDropDownNames[#_equipPosDropDownNames+1]=cfg.name
end

return _equipPosDropDownNames
end,
onDropDownEvent=function(self,idx,index)
local filter=_filter_Custom[BAG_FILTER_TYPE.eEquipPosType]
local filterArgs=self.comFilterArgsList[BAG_FILTER_TYPE.eEquipPosType][idx]
if filterArgs==nil then
filterArgs={idx,{0}}
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipPosType][idx]=filterArgs
end
local dropdownList=filterArgs[2]
if filter.subTypeList[idx]~=_filter_Sub_Item_Type.normal then
table.clear(dropdownList)
dropdownList[1]=index
end
end,
onNormalClick=function(self,idx)
local filter=self.comFilterArgsList[BAG_FILTER_TYPE.eEquipPosType][idx]
if filter then
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipPosType][idx]=nil
else
if idx==1 then
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipPosType][idx]={idx,{0}}
else
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipPosType][idx]={idx,{}}
end
end
end,
dropdownDefaultSelect=function(self,idx,opGrid)
local type=_filter_Custom[BAG_FILTER_TYPE.eEquipPosType].subTypeList[idx]
if type==_filter_Sub_Item_Type.normal then return end
local idxlist=self.comFilterArgsList[BAG_FILTER_TYPE.eEquipPosType][idx]
if idxlist then
if#idxlist[2]==1 then
local sidx=idxlist[2][1]
self.updateDropDownIng=true
opGrid:SetChildDropDownValue(_filterSubItemIndex.dropdown,sidx)
self.updateDropDownIng=false
else
self.updateDropDownIng=true
opGrid:SetChildDropDownValue(_filterSubItemIndex.dropdown,0)
self.updateDropDownIng=false
_filter_Custom[BAG_FILTER_TYPE.eEquipPosType].onDropDownEvent(self,idx,0)
end
end
end,
getDropDownIdx=function(self,idx)
local idxlist=self.comFilterArgsList[BAG_FILTER_TYPE.eEquipPosType][idx]
return next(idxlist)
end,
getSubItemInfo=function(self)
local info={}

local name
for pos=EQUIP_TYPE.eWeapon,EQUIP_TYPE.eShoot do
name=cfg_discipleequiptypeconfig_get(pos).name
info[#info+1]=name
end
return 4,"类型",info
end,
updateDropDownValueList=function(self)end,
freshDropdown=function(self,idx,opGrid)
local names=_filter_Custom[BAG_FILTER_TYPE.eEquipPosType].getDropDownNameList(self,idx)
opGrid:SetChildDropDownOption(_filterSubItemIndex.dropdown,names)
opGrid:SetChildActive(_filterSubItemIndex.dropIcon,false)
local args=self.comFilterArgsList[BAG_FILTER_TYPE.eEquipPosType][idx]
local isSelect=args~=nil and next(args[2])~=nil
opGrid:SetChildGray(-1,not isSelect)

opGrid:SetChildDropDownCreatedAction(_filterSubItemIndex.dropdown,function()
local widget
for iconIdx=0,#names-1 do
widget=opGrid:GetChildDropDownItemWidget(_filterSubItemIndex.dropdown,iconIdx)
widget:SetChildActive(0,false)
end
end)
end,
getFilterArgs=function(self,args)
if next(args)then
local temp={}
for index,arg in pairs(args)do
temp[#temp+1]=arg
end
return{[ITEM_FILTER_TYPE.eBagEquipType]={[ITEM_FILTER_COMPARE.eEquals]=temp}}


end
end,
},
[BAG_FILTER_TYPE.eStage]={
initFilterArgs=function(self)
self.comFilterArgsList[BAG_FILTER_TYPE.eStage]={}
end,
buildFilterArgs=function(self,filterArgs)

local args=filterArgs[ITEM_FILTER_TYPE.eStage]








if args~=nil then
local _,info=next(args)
for _,idx in pairs(info)do
self.comFilterArgsList[BAG_FILTER_TYPE.eStage][idx]=idx
end
end
end,
subTypeList={_filter_Sub_Item_Type.normal,_filter_Sub_Item_Type.normal,_filter_Sub_Item_Type.normal,_filter_Sub_Item_Type.normal,_filter_Sub_Item_Type.normal,},
getDropDownNameList=function(self,idx)
local names={}
for index=1,5 do
names[#names+1]=FMT.fmt("{0}阶",mathHelper.numberToChinese(index))
end
return names
end,
onNormalClick=function(self,idx)
local filter=self.comFilterArgsList[BAG_FILTER_TYPE.eStage][idx]
if filter then
self.comFilterArgsList[BAG_FILTER_TYPE.eStage][idx]=nil
else
self.comFilterArgsList[BAG_FILTER_TYPE.eStage][idx]=idx
end
end,
getSubItemInfo=function(self)
local info={}

local name
for index=1,5 do
name=FMT.fmt("{0}阶",mathHelper.numberToChinese(index))
info[#info+1]=name
end
return 5,"阶数",info
end,
updateDropDownValueList=function(self)

end,
getFilterArgs=function(self,args)
if next(args)then
local temp={}
for index,arg in pairs(args)do
temp[#temp+1]=arg
end
return{[ITEM_FILTER_TYPE.eStage]={[ITEM_FILTER_COMPARE.eEquals]=temp}}


end
end,
},
[BAG_FILTER_TYPE.eEquipSuit]={
initFilterArgs=function(self)
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipSuit]={}

self.comFilterEquipSuitCfgDynamic={}
local equipSuitCfgs=cfg_discipleequipsuitconfig()

self.comFilterEquipSuitIndexDynamic={}
self.comFilterEquipSuitStateList={}
for index,cfg in ipairs(equipSuitCfgs)do
self.comFilterEquipSuitStateList[index]=0
end

local len=_filter_Custom[BAG_FILTER_TYPE.eEquipSuit].getSubItemInfo(self)
for index=1,len do
self.comFilterEquipSuitCfgDynamic[index]=table.weakCopy(equipSuitCfgs)
end
end,
buildFilterArgs=function(self,filterArgs)
local args=filterArgs[ITEM_FILTER_TYPE.eSuitEquip]
if args~=nil then
local _,info=next(args)
for idx,index in pairs(info)do
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipSuit][idx]=index
self.comFilterEquipSuitStateList[index]=idx
_filter_Custom[BAG_FILTER_TYPE.eEquipSuit].updateDropDownValueList(self,3,0)
end
end
end,
subTypeList={_filter_Sub_Item_Type.dropdown,_filter_Sub_Item_Type.dropdown,_filter_Sub_Item_Type.dropdown,_filter_Sub_Item_Type.dropdown,},
getDropDownNameList=function(self,idx)
local names={"取消"}

for index,cfg in ipairs(self.comFilterEquipSuitCfgDynamic[idx])do
names[#names+1]=cfg.name
end

return names
end,
onDropDownEvent=function(self,idx,index)
local filterIdx=self.comFilterArgsList[BAG_FILTER_TYPE.eEquipSuit][idx]or 0

if index==0 then
if filterIdx==0 then
return
else
self.comFilterEquipSuitStateList[filterIdx]=0
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipSuit][idx]=nil
end
else
local cfg=self.comFilterEquipSuitCfgDynamic[idx][index]
if filterIdx==0 then
self.comFilterEquipSuitStateList[cfg.id]=idx
else
self.comFilterEquipSuitStateList[filterIdx]=0
self.comFilterEquipSuitStateList[cfg.id]=idx
end
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipSuit][idx]=cfg.id
end
end,
onNormalClick=function(self,idx)end,
dropdownDefaultSelect=function(self,idx,opGrid,isFresh)
local type=_filter_Custom[BAG_FILTER_TYPE.eEquipSuit].subTypeList[idx]
if type==_filter_Sub_Item_Type.normal then return end
local index=self.comFilterArgsList[BAG_FILTER_TYPE.eEquipSuit][idx]
local isShowCaption=index==nil
opGrid:SetChildActive(_filterSubItemIndex.dropdownCaption,isShowCaption)
opGrid:SetChildActive(_filterSubItemIndex.dropdownInfo,not isShowCaption)
if not isShowCaption then
if isFresh then
local optionIdx=self.comFilterEquipSuitIndexDynamic[idx]
opGrid:SetChildDropDownValue(_filterSubItemIndex.dropdown,optionIdx)
end
else
opGrid:SetChildText(_filterSubItemIndex.dropdownCaption,"选择套装")
opGrid:SetChildDropDownValue(_filterSubItemIndex.dropdown,0)
end
end,
getDropDownIdx=function(self,idx)
local idx=self.comFilterArgsList[BAG_FILTER_TYPE.eEquipSuit][idx]
return idx
end,
freshDropdown=function(self,idx,opGrid)
local index=_this.comFilterArgsList[BAG_FILTER_TYPE.eEquipSuit][idx]
local isShowCaption=index==nil or index==0
opGrid:SetChildActive(_filterSubItemIndex.dropdownCaption,isShowCaption)
opGrid:SetChildActive(_filterSubItemIndex.dropdownInfo,not isShowCaption)
opGrid:SetChildActive(_filterSubItemIndex.dropIcon,not isShowCaption)
opGrid:SetChildGray(-1,isShowCaption)

if not isShowCaption then
local cfg=cfg_discipleequipsuitconfig_get(index)
local iconName=iconHelper.getSuitIcon(cfg.icon)
opGrid:SetChildIcon(_filterSubItemIndex.dropIcon,iconName,false)
end

local names={"取消"}
for index,cfg in ipairs(self.comFilterEquipSuitCfgDynamic[idx])do
names[#names+1]=cfg.name
end
opGrid:SetChildDropDownOption(_filterSubItemIndex.dropdown,names)
opGrid:SetChildDropDownCreatedAction(_filterSubItemIndex.dropdown,function()
local widget,icon,iconName
for iconIdx=0,#self.comFilterEquipSuitCfgDynamic[idx]do
widget=opGrid:GetChildDropDownItemWidget(_filterSubItemIndex.dropdown,iconIdx)
if iconIdx==0 then
widget:SetChildActive(0,false)
else
icon=self.comFilterEquipSuitCfgDynamic[idx][iconIdx].icon
iconName=iconHelper.getSuitIcon(icon)
widget:SetChildIcon(0,iconName,false)
end
end
end)
end,
getSubItemInfo=function(self)
return 4,"套装",{}
end,
updateDropDownValueList=function(self,pageIndex,opIndex)
local len=_filter_Custom[BAG_FILTER_TYPE.eEquipSuit].getSubItemInfo(self)


local temp,names,opGrid,sid
for gridIndex=1,len do
temp={}
sid=0
for cfgIndex,selectGrid in ipairs(self.comFilterEquipSuitStateList)do
if selectGrid==gridIndex or selectGrid==0 then
temp[#temp+1]=cfg_discipleequipsuitconfig_get(cfgIndex)
if selectGrid==gridIndex then
sid=#temp
end
end
end
self.comFilterEquipSuitCfgDynamic[gridIndex]=temp
self.comFilterEquipSuitIndexDynamic[gridIndex]=sid

if self.opGrids then
names={"取消"}
for index,cfg in ipairs(self.comFilterEquipSuitCfgDynamic[gridIndex])do
names[#names+1]=cfg.name
end
opGrid=self.opGrids[pageIndex][gridIndex-1]
opGrid:SetChildDropDownOption(_filterSubItemIndex.dropdown,names)
if sid>0 then
self.updateDropDownIng=true
opGrid:SetChildDropDownValue(_filterSubItemIndex.dropdown,sid)
self.updateDropDownIng=false
end
end
end
end,
getFilterArgs=function(self,args)
if next(args)then
local temp={}
for index,arg in pairs(args)do
temp[#temp+1]=arg
end
return{[ITEM_FILTER_TYPE.eSuitEquip]={[ITEM_FILTER_COMPARE.eEquals]=temp}}
end
end,
},
[BAG_FILTER_TYPE.eEquipRandomAttr]={
initFilterArgs=function(self)
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipRandomAttr]={}

self.comFilterEquipRandomAttrDynamic={}
self.comFilterEquipRandomAttrIndexDynamic={}
local attrs=equipsConfig.getEquipConstConfig().rangeattrs
self.attrsLookup={}
self.comFilterEquipRandomAttrStateList={}
local temp,tempList
tempList={}
for index,attr in ipairs(attrs)do
temp={id=index,attrid=attr}
tempList[#tempList+1]=temp
self.attrsLookup[index]=temp
self.comFilterEquipRandomAttrStateList[index]=0
end

local len=_filter_Custom[BAG_FILTER_TYPE.eEquipRandomAttr].getSubItemInfo(self)
for index=1,len do
self.comFilterEquipRandomAttrDynamic[index]=table.weakCopy(tempList)
end
end,
buildFilterArgs=function(self,filterArgs)
local args=filterArgs[ITEM_FILTER_TYPE.eEquipRandomAttr]

if args~=nil then
local _,info=next(args)
local attrInfo
for idx,attrid in pairs(info)do
for index,info in ipairs(self.attrsLookup)do
if info.attrid==attrid then
attrInfo=info
break
end
end
if attrInfo~=nil then
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipRandomAttr][idx]=attrInfo.id
self.comFilterEquipRandomAttrStateList[attrInfo.id]=idx
end
end
_filter_Custom[BAG_FILTER_TYPE.eEquipRandomAttr].updateDropDownValueList(self,4,0)
end
end,
subTypeList={_filter_Sub_Item_Type.dropdown,_filter_Sub_Item_Type.dropdown,_filter_Sub_Item_Type.dropdown,_filter_Sub_Item_Type.dropdown,},
getDropDownNameList=function(self,idx)
local names={"取消"}

local name
for index,attrData in ipairs(self.comFilterEquipRandomAttrDynamic[idx])do
if _renameType[attrData.attrid]then
name=_renameType[attrData.attrid]
else
name=helper.getAttributeName(attrData.attrid)
end
names[#names+1]=name
end
return names
end,
onDropDownEvent=function(self,idx,index)
local filterIdx=self.comFilterArgsList[BAG_FILTER_TYPE.eEquipRandomAttr][idx]or 0

if index==0 then
if filterIdx==0 then
return
else
self.comFilterEquipRandomAttrStateList[filterIdx]=0
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipRandomAttr][idx]=nil
end
else
local cfg=self.comFilterEquipRandomAttrDynamic[idx][index]
if filterIdx==0 then
self.comFilterEquipRandomAttrStateList[cfg.id]=idx
else
self.comFilterEquipRandomAttrStateList[filterIdx]=0
self.comFilterEquipRandomAttrStateList[cfg.id]=idx
end
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipRandomAttr][idx]=cfg.id
end

end,
onNormalClick=function(self,idx)end,
dropdownDefaultSelect=function(self,idx,opGrid,isFresh)
local type=_filter_Custom[BAG_FILTER_TYPE.eEquipRandomAttr].subTypeList[idx]
if type==_filter_Sub_Item_Type.normal then return end
local index=self.comFilterArgsList[BAG_FILTER_TYPE.eEquipRandomAttr][idx]
local isShowCaption=index==nil
opGrid:SetChildActive(_filterSubItemIndex.dropdownCaption,isShowCaption)
opGrid:SetChildActive(_filterSubItemIndex.dropdownInfo,not isShowCaption)
if not isShowCaption then
if isFresh then
local optionIdx=self.comFilterEquipRandomAttrIndexDynamic[idx]
opGrid:SetChildDropDownValue(_filterSubItemIndex.dropdown,optionIdx)
end
else
opGrid:SetChildText(_filterSubItemIndex.dropdownCaption,"选择属性")
self.updateDropDownIng=true
opGrid:SetChildDropDownValue(_filterSubItemIndex.dropdown,0)
self.updateDropDownIng=false
end
end,
getDropDownIdx=function(self,idx)
local idx=self.comFilterArgsList[BAG_FILTER_TYPE.eEquipRandomAttr][idx]
return idx
end,
freshDropdown=function(self,idx,opGrid)
local index=_this.comFilterArgsList[BAG_FILTER_TYPE.eEquipRandomAttr][idx]
local isShowCaption=index==nil
opGrid:SetChildActive(_filterSubItemIndex.dropdownCaption,isShowCaption)
opGrid:SetChildActive(_filterSubItemIndex.dropdownInfo,not isShowCaption)
opGrid:SetChildActive(_filterSubItemIndex.dropIcon,false)
opGrid:SetChildGray(-1,isShowCaption)


local filterCustom=_filter_Custom[BAG_FILTER_TYPE.eEquipRandomAttr]
local names=filterCustom.getDropDownNameList(_this,idx)
opGrid:SetChildDropDownOption(_filterSubItemIndex.dropdown,names)

opGrid:SetChildDropDownCreatedAction(_filterSubItemIndex.dropdown,function()
local widget,icon,iconName
for iconIdx=0,#self.comFilterEquipRandomAttrDynamic[idx]do
widget=opGrid:GetChildDropDownItemWidget(_filterSubItemIndex.dropdown,iconIdx)
widget:SetChildActive(0,false)
end
end)
end,
getSubItemInfo=function(self)
return 4,"随机属性<size=22><color=#ca631d>（筛选出同时满足所选条件的装备）</color></size>",{}
end,
updateDropDownValueList=function(self,pageIndex,opIndex)
local len=_filter_Custom[BAG_FILTER_TYPE.eEquipRandomAttr].getSubItemInfo(self)

local temp,names,opGrid,name,sid,attrid
for gridIndex=1,len do
temp={}
sid=0
for cfgIndex,selectGrid in pairs(self.comFilterEquipRandomAttrStateList)do
if selectGrid==gridIndex or selectGrid==0 then
temp[#temp+1]=self.attrsLookup[cfgIndex]
if selectGrid==gridIndex then
attrid=self.attrsLookup[cfgIndex].attrid
end
end
end
table.sort(temp,function(a,b)
return a.id<b.id
end)

for index,info in ipairs(temp)do
if info.attrid==attrid then
sid=index
end
end

self.comFilterEquipRandomAttrDynamic[gridIndex]=temp
self.comFilterEquipRandomAttrIndexDynamic[gridIndex]=sid

if self.opGrids then
names={"取消"}
for index,attrData in ipairs(self.comFilterEquipRandomAttrDynamic[gridIndex])do
if _renameType[attrData.attrid]then
name=_renameType[attrData.attrid]
else
name=helper.getAttributeName(attrData.attrid)
end
names[#names+1]=name
end
opGrid=self.opGrids[pageIndex][gridIndex-1]
opGrid:SetChildDropDownOption(_filterSubItemIndex.dropdown,names)
if sid>0 then
self.updateDropDownIng=true
opGrid:SetChildDropDownValue(_filterSubItemIndex.dropdown,sid)
self.updateDropDownIng=false
end
end
end
end,
getFilterArgs=function(self,args)
if next(args)then
local temp={}
local attrinfo
for index,arg in pairs(args)do
attrinfo=self.attrsLookup[arg]
temp[#temp+1]=attrinfo.attrid
end
return{[ITEM_FILTER_TYPE.eEquipRandomAttr]={[ITEM_FILTER_COMPARE.eAnd]=temp}}
end
end,
}
}




function UIBagEquipFilterWin:onLoaded(...)
self:bindComponents()

_this=self

self.updateDropDownIng=false

self.comFilterArgsList={}

end


function UIBagEquipFilterWin:__delete()
_this=nil

self:unbindComponents()
end




function UIBagEquipFilterWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.reset=argtable.reset
self.comfirmCallback=argtable.comfirmCallback
self.selectBagType=argtable.attach
self.equipBagFilter=argtable.equipBagFilter or{}

self.filterCfg=bagFilterConfig.getFilter(self.selectBagType)
self.filterTypes={}

local filterType,filterCustom
for index,cfg in pairs(self.filterCfg)do
filterType=cfg.type
self.filterTypes[index]=filterType
filterCustom=_filter_Custom[filterType]
if filterCustom then
filterCustom.initFilterArgs(self)
filterCustom.buildFilterArgs(self,self.equipBagFilter)
end
end

self:refreshAll()
end


function UIBagEquipFilterWin:onHide()

end

function UIBagEquipFilterWin:refreshAll()
self:refreshFilterPartAll()
end

function UIBagEquipFilterWin:refreshFilterPartAll()
local typeLen=#self.filterTypes

self.Content:setChildLayoutGroupCreateItems(typeLen)
local grids=self.Content:getChildLayoutGroupGridList()
self.pageGrids=grids
self.opGrids={}
local grid,filterType
for index=1,grids.Count do
grid=grids[index-1]
filterType=self.filterTypes[index]
self:refreshFilterPart(index,filterType,grid)
end
end

function UIBagEquipFilterWin:refreshFilterPart(index,filterType,grid)
local filterCustom,pageData,opGridLen,pageTitle
filterCustom=_filter_Custom[filterType]

opGridLen,pageTitle,pageData=filterCustom.getSubItemInfo(self)

grid:SetChildText(_filterPartItemIndex.title,pageTitle)

grid:SetChildLayoutGroupCreateItems(_filterPartItemIndex.infoList,opGridLen)
local opGrids=grid:GetChildLayoutGroupGridList(_filterPartItemIndex.infoList)
self.opGrids[index]=opGrids
local _filterType=filterType

local opGrid,gridName
for opIndex=1,opGrids.Count do
opGrid=opGrids[opIndex-1]
gridName=pageData and pageData[opIndex]

self:refreshFilterSubItem(index,opIndex,opGrid,_filterType,gridName)
end
end


local freshDropDown=function(index,opIndex,opGrid,isSelect,filterArgs,filterCustom,filterType,subItemType)
local type=filterCustom.subTypeList[opIndex]
if type==_filter_Sub_Item_Type.normal then return end

if subItemType==_filter_Sub_Item_Type.all then
isSelect=true
end
opGrid:SetChildActive(_filterSubItemIndex.dropdownRoot,isSelect)

filterCustom.freshDropdown(_this,opIndex,opGrid)

filterCustom.dropdownDefaultSelect(_this,opIndex,opGrid,true)

opGrid:SetChildDropDownChangeAction(_filterSubItemIndex.dropdown,function(idx)
if not _this.updateDropDownIng then

filterCustom.onDropDownEvent(_this,opIndex,idx)
filterCustom.updateDropDownValueList(_this,index,idx)
filterCustom.freshDropdown(_this,opIndex,opGrid)
filterCustom.dropdownDefaultSelect(_this,opIndex,opGrid,false)
end
end)

if type==_filter_Sub_Item_Type.all then
opGrid:ForceLayoutRect(-1)
end
end

function UIBagEquipFilterWin:refreshFilterSubItem(index,opIndex,opGrid,filterType,gridName)
local filterCustom=_filter_Custom[filterType]
local subItemType=filterCustom.subTypeList[opIndex]
local isShowAll=subItemType==_filter_Sub_Item_Type.all
local isShowSelectBtn=subItemType==_filter_Sub_Item_Type.normal or isShowAll
local isShowDropItem=subItemType==_filter_Sub_Item_Type.dropdown

opGrid:SetChildActive(_filterSubItemIndex.selectBtn,isShowSelectBtn)
opGrid:SetChildActive(_filterSubItemIndex.dropdownRoot,isShowDropItem)

local filterArgs=self.comFilterArgsList[filterType][opIndex]
if isShowSelectBtn then
local isSelect

isSelect=filterArgs~=nil

freshDropDown(index,opIndex,opGrid,isSelect,filterArgs,filterCustom,filterType,subItemType)

opGrid:SetChildText(_filterSubItemIndex.selectTxt,gridName)
opGrid:SetChildGray(_filterSubItemIndex.selectImg,not isSelect)

opGrid:SetChildButtonClick(_filterSubItemIndex.selectImg,function()
filterCustom.onNormalClick(_this,opIndex)

filterArgs=self.comFilterArgsList[filterType][opIndex]
isSelect=filterArgs~=nil
freshDropDown(index,opIndex,opGrid,isSelect,filterArgs,filterCustom,filterType,subItemType)
opGrid:SetChildGray(_filterSubItemIndex.selectImg,not isSelect)
end,true)
end

if isShowDropItem then
freshDropDown(index,opIndex,opGrid,true,filterArgs,filterCustom,filterType,subItemType)
end

opGrid:ForceLayoutRect(-1)
end






function UIBagEquipFilterWin:onBtnResetFilter()
local filterType,filterCustom
for index,cfg in pairs(self.filterCfg)do
filterType=cfg.type
filterCustom=_filter_Custom[filterType]
if filterCustom then
filterCustom.initFilterArgs(self)
end
end

self:refreshAll()
end



function UIBagEquipFilterWin:onBtnSureFilter()
local filterList={}

local filterArgs
for type,args in pairs(self.comFilterArgsList)do
filterArgs=_filter_Custom[type].getFilterArgs(self,args)
if filterArgs then
for filterType,filter in pairs(filterArgs)do
filterList[filterType]=filter
end
end
end


if self.comfirmCallback then
self.comfirmCallback(filterList)
end

self:myClose()
end

function UIBagEquipFilterWin:myClose()

self.parentWin:onCloseClick()
end

