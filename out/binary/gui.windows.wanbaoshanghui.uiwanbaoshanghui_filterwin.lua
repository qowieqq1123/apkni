







def_class("UIWanBaoShangHui_filterWin",UIWindowBase)









function UIWanBaoShangHui_filterWin:bindComponents()

self.root=UIObject.get(self,0)
self.selectPanelMask=UIButton.get(self,1)
self.selectPanel=UIObject.get(self,2)
self.selectCloseBtn=UIButton.get(self,3)
self.btnReset=UIButton.get(self,4)
self.btnConfirm=UIButton.get(self,5)
self.layoutScrollView=UIObject.get(self,6)

self.selectPanelMask:setButtonClick(function()self:onSelectPanelMask()end)

self.selectCloseBtn:setButtonClick(function()self:onSelectCloseBtn()end)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.btnConfirm:setButtonClick(function()self:onBtnConfirm()end)



end


function UIWanBaoShangHui_filterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectPanelMask);self.selectPanelMask=nil;
_UIObject_release(self.selectPanel);self.selectPanel=nil;
_UIObject_release(self.selectCloseBtn);self.selectCloseBtn=nil;
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.btnConfirm);self.btnConfirm=nil;
_UIObject_release(self.layoutScrollView);self.layoutScrollView=nil;
end


local lianhuaAttrList={
{id=eAttributeType.eSpeed,name="速度"},
{id=eAttributeType.eHP_PCT,name="生命率"},
{id=eAttributeType.eCritical_MOD,name="暴击伤害"},
{id=eAttributeType.eCritical_DEF_MOD,name="暴击减伤"},
{id=eAttributeType.eCritical_rate,name="暴击率"},
{id=eAttributeType.eCritical_DEF,name="抗暴率"},
{id=eAttributeType.eOut_ATK_Up,name="物伤加成"},
{id=eAttributeType.eIn_ATK_Up,name="法伤加成"},
{id=eAttributeType.eBuff_hit,name="效果命中"},
{id=eAttributeType.eBuff_dodge,name="效果抵抗"},
{id=eAttributeType.eCure,name="治疗效果"},
{id=eAttributeType.eCured,name="被治疗效果"},
}

local equipRandomAttrList={
{id=eAttributeType.eATK,name="攻击"},
{id=eAttributeType.eDEF,name="防御"},
{id=eAttributeType.eHP,name="生命"},
{id=eAttributeType.eSpeed,name="速度"},
{id=eAttributeType.eATK_PCT,name="攻击率"},
{id=eAttributeType.eDEF_PCT,name="防御率"},
{id=eAttributeType.eHP_PCT,name="生命率"},
{id=eAttributeType.eCritical_rate,name="暴击率"},
{id=eAttributeType.eCritical_DEF,name="抗暴率"},
{id=eAttributeType.eCritical_MOD,name="暴击伤害"},
{id=eAttributeType.eCritical_DEF_MOD,name="暴击减伤"},
{id=eAttributeType.eOut_ATK_DEF,name="物伤减免"},
{id=eAttributeType.eIn_ATK_DEF,name="法伤减免"},
{id=eAttributeType.eBuff_hit,name="效果命中"},
{id=eAttributeType.eBuff_dodge,name="效果抵抗"},
}

local fubaoRandomAttrTypeList={
FUBAO_EFFECT_TYPE.eSixAttr,
FUBAO_EFFECT_TYPE.eProfessionExp,
FUBAO_EFFECT_TYPE.eGongFaExpSpeed,
}

local yuanpeiTypeList={
{id=101},
{id=102},
{id=111},
{id=112},
{id=121},
{id=122},
}

local yuanpeiMaterialTypeList={
{id=1},
{id=2},
{id=3},
{id=4},
{id=5},
{id=6},
{id=7},
{id=8},
{id=9},
{id=10},
{id=11},
{id=12},
{id=13},
{id=14},
{id=15},
{id=16},
{id=17},
{id=18},
{id=19},
{id=20},
}

local jinglianTypeList={
{id=1,name="未强化"},
{id=2,name="已强化"}
}


local filterGetListBySpecialType={
[2]={
[1]=function()

return table.toTable(eQualityColor.eOrange,eQualityColor.eRed)
end,

[2]=function()

return table.toTable(3,6)
end,
},
[3]={
[1]=function()

return table.toTable(eQualityColor.eOrange,eQualityColor.eRed)
end,
},
[4]={
[1]=function()

return table.toTable(eQualityColor.eOrange,eQualityColor.eRed)
end,
},
[5]={
[1]=function()

return table.toTable(eQualityColor.ePurple,eQualityColor.eRed)
end,
},
}

local filterTypeDataList={
[1]={
type=ITEM_FILTER_TYPE.eColor,
name="品质",
getSubItemName=function(index,subFilterList)
local color=subFilterList[index]
return FMT.fmt('{0}',eQualityColorName[color])
end,
getSubFilterList=function(filterTypeCfgIndex)
local list
if filterGetListBySpecialType[filterTypeCfgIndex]and filterGetListBySpecialType[filterTypeCfgIndex][1]then
list=filterGetListBySpecialType[filterTypeCfgIndex][1]()
else
list=table.toTable(eQualityColor.eGreen,eQualityColor.eRed)
end
return list
end,
getSubFilterId=function(index,subFilterList)
return subFilterList[index]
end,
},
[2]={
type=ITEM_FILTER_TYPE.eStage,
name="阶数",
getSubItemName=function(index,subFilterList)
local stage=subFilterList[index]
return FMT.fmt('{0}阶',stage)
end,
getSubFilterList=function(filterTypeCfgIndex)
local list
if filterGetListBySpecialType[filterTypeCfgIndex]and filterGetListBySpecialType[filterTypeCfgIndex][2]then
list=filterGetListBySpecialType[filterTypeCfgIndex][2]()
else
list=table.toTable(1,5)
end
return list
end,
getSubFilterId=function(index,subFilterList)
return subFilterList[index]
end,
},
[3]={
type=ITEM_FILTER_TYPE.eAnyElement,
name="五行",
getSubItemName=function(index,subFilterList)
local element=subFilterList[index]
return FMT.fmt('{0}系',ELEMENT_TYPE.getName(element))
end,
getSubFilterList=function(filterTypeCfgIndex)
local list=table.toTable(ELEMENT_TYPE.eGold,ELEMENT_TYPE.eSoil)
return list
end,
getSubFilterId=function(index,subFilterList)
return subFilterList[index]
end,
},
[4]={
type=ITEM_FILTER_TYPE.eSuitEquip,
name="套装",
getSubItemName=function(index,subFilterList)
local suitConfig=subFilterList[index]
return FMT.fmt('{0}',suitConfig.name)
end,
getSubFilterList=function(filterTypeCfgIndex)
local list=equipsConfig.getAllSuitConfig()
return list
end,
getSubFilterId=function(index,subFilterList)
return index
end,
},
[5]={
type=ITEM_FILTER_TYPE.eEquipType1,
name="类型",
getSubItemName=function(index,subFilterList)
local pos=subFilterList[index]
return cfg_discipleequiptypeconfig_get(pos).name
end,
getSubFilterList=function(filterTypeCfgIndex)
local list=EQUIP_SUIT_TYPES
return list
end,
getSubFilterId=function(index,subFilterList)
return subFilterList[index]
end,
},
[6]={
type=ITEM_FILTER_TYPE.eFabaoLianhuaAttr,
name="炼化属性",
getSubItemName=function(index,subFilterList)
local attrData=subFilterList[index]
return attrData.name
end,
getSubFilterList=function(filterTypeCfgIndex)
local list=lianhuaAttrList
return list
end,
getSubFilterId=function(index,subFilterList)
return subFilterList[index].id
end,
},
[7]={
type=ITEM_FILTER_TYPE.eEquipRandomAttr,
name="随机属性",
getSubItemName=function(index,subFilterList)
local attrData=subFilterList[index]
return attrData.name
end,
getSubFilterList=function(filterTypeCfgIndex)
local list=equipRandomAttrList
return list
end,
getSubFilterId=function(index,subFilterList)
return subFilterList[index].id
end,
},
[8]={
type=ITEM_FILTER_TYPE.eFubaoRandomAttr,
name="随机属性",
getSubItemName=function(index,subFilterList)
local name
local subFilterAttrData=subFilterList[index]
local attrType=subFilterAttrData[1]
local attrId=subFilterAttrData[2]
if attrType==FUBAO_EFFECT_TYPE.eSixAttr then
name=FMT.fmt("弟子{0}",UIDiscipleModel:discipleBaseAttrName(attrId))
elseif attrType==FUBAO_EFFECT_TYPE.eProfessionExp then
local cfg=cfgHelper.get1(cfg_discipleproskillconfig_get,attrId)
name=FMT.fmt('{0}经验',cfg.name)
elseif attrType==FUBAO_EFFECT_TYPE.eGongFaExpSpeed then
name=FMT.fmt("{0}经验",ELEMENT_TYPE.getNameGF(attrId))
end
return name
end,
getSubFilterList=function(filterTypeCfgIndex)
local list={}
for _,attrType in ipairs(fubaoRandomAttrTypeList)do
local listLen=#list
if attrType==FUBAO_EFFECT_TYPE.eSixAttr then
local attrTypeList=table.toTable(DISCIPLE_BASE_ATTR_TYPE.eZiZhi,DISCIPLE_BASE_ATTR_TYPE.eJiYuan)
for index,type in ipairs(attrTypeList)do
list[listLen+index]={attrType,type}
end
elseif attrType==FUBAO_EFFECT_TYPE.eProfessionExp then
local allCfg=cfg_discipleproskillconfig()
for index,cfg in pairs(allCfg)do
if type(index)=='number'then
list[listLen+index]={attrType,cfg.id}
end
end
elseif attrType==FUBAO_EFFECT_TYPE.eGongFaExpSpeed then
local attrTypeList=table.toTable(ELEMENT_TYPE.eGold,ELEMENT_TYPE.eSoil)
for index,type in ipairs(attrTypeList)do
list[listLen+index]={attrType,type}
end
end
end
return list
end,
getSubFilterId=function(index,subFilterList)
return subFilterList[index]
end,
},
[9]={
type=ITEM_FILTER_TYPE.eItemType1,
name="原胚类型",
getSubItemName=function(index,subFilterList)
local yuanpeiCfgId=subFilterList[index].id
local name=cfgHelper.get2(cfg_fabaoyuanpeitypeconfig_get,yuanpeiCfgId,'name')
return name
end,
getSubFilterList=function(filterTypeCfgIndex)
local list=yuanpeiTypeList
return list
end,
getSubFilterId=function(index,subFilterList)
return subFilterList[index].id
end,
},
[10]={
type=ITEM_FILTER_TYPE.eIsEquipQiangHua,
name="强化",
getSubItemName=function(index,subFilterList)
local data=subFilterList[index]
return data.name
end,
getSubFilterList=function(filterTypeCfgIndex)
local list=jinglianTypeList
return list
end,
getSubFilterId=function(index,subFilterList)
return subFilterList[index].id
end,
},
[11]={
type=ITEM_FILTER_TYPE.eIsFaBaoQiangHua,
name="强化",
getSubItemName=function(index,subFilterList)
local data=subFilterList[index]
return data.name
end,
getSubFilterList=function(filterTypeCfgIndex)
local list=jinglianTypeList
return list
end,
getSubFilterId=function(index,subFilterList)
return subFilterList[index].id
end,
},
[12]={
type=ITEM_FILTER_TYPE.eYuanPeiOwnerFabaoType,
name="材料类型",
getSubItemName=function(index,subFilterList)
local yuanpeiCfgId=subFilterList[index].id
local name=cfgHelper.get2(cfg_fabaoyuanpeitypeconfig_get,yuanpeiCfgId,'name')
return name
end,
getSubFilterList=function(filterTypeCfgIndex)
local list=yuanpeiMaterialTypeList
return list
end,
getSubFilterId=function(index,subFilterList)
return subFilterList[index].id
end,
},
}

local filterScrollItemCmp={
titleText=0,
filterSubItemList=1,
}
















function UIWanBaoShangHui_filterWin:onLoaded(...)
self:bindComponents()
end


function UIWanBaoShangHui_filterWin:__delete()
self:clearDelayTimer()
self:unbindComponents()
end




function UIWanBaoShangHui_filterWin:onShow(argtable,afterOnloaded)
if argtable and argtable.filterTypeCfgIndex then
self.filterTypeCfgIndex=argtable.filterTypeCfgIndex
self.winName=argtable.winName
self.tabType=argtable.tabType
else
logErr("筛选界面没有传入筛选类型索引 请检查前端传参是否正确")
return self:closeSelf()
end

local itemTypeCfgList=auctionModel:getItemTypeCfgList(self.tabType)
local itemTypeCfg=itemTypeCfgList[self.filterTypeCfgIndex]
self.filterTypeList=itemTypeCfg.subFilterType or{}
self.filterSelectList=self:getFilterSelectListByFilterRecording()
self:showSelectPanel()

self:refresh(true)
end


function UIWanBaoShangHui_filterWin:onHide()
self:clearDelayTimer()
end

function UIWanBaoShangHui_filterWin:refresh(isInit)
if isInit then


local filterTypeCount=#self.filterTypeList
self.layoutScrollView:setChildScrollViewCreateGrids(filterTypeCount,1)
end

local grids=self.layoutScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
self:refreshFilterScrollItem(grids[i-1],i,isInit)
end


end

function UIWanBaoShangHui_filterWin:refreshFilterScrollItem(item,index,isInit)
if item==nil then
item=self.layoutScrollView:getChildScrollViewItemWidget(index-1)
end

local filterTypeIndex=self.filterTypeList[index]
local typeData=filterTypeDataList[filterTypeIndex]
if typeData then
local filterType=typeData.type
local subFilterList=typeData.getSubFilterList(self.filterTypeCfgIndex)
if isInit then
local typeName=typeData.name
item:SetChildText(filterScrollItemCmp.titleText,typeName)
local subFilterCount=#subFilterList
item:SetChildLayoutGroupCreateItems(filterScrollItemCmp.filterSubItemList,subFilterCount)


local titleHeight=30
local subItemHeight=40
local topDis=5
local bottomDis=5
local row=math.ceil(subFilterCount/2)
local subListHeight=topDis+subItemHeight*row+bottomDis
local filterScrollItemHeight=titleHeight+subListHeight
local width=item:GetChildSizeDeltaX(-1)
item:SetChildSizeDelta(-1,width,filterScrollItemHeight)
item:SetChildSizeDelta(filterScrollItemCmp.filterSubItemList,width,subListHeight)
end

local grids=item:GetChildLayoutGroupGridList(filterScrollItemCmp.filterSubItemList)
for i=1,grids.Count do
local selectItem=grids[i-1]

local name=typeData.getSubItemName(i,subFilterList)
selectItem:SetChildText(0,name)

if not self.filterSelectList[filterTypeIndex]then
self.filterSelectList[filterTypeIndex]={}
end


local isToggle=self.filterSelectList[filterTypeIndex][i]or false


selectItem:SetChildToggle(-1,isToggle)


selectItem:SetChildToggleChange(-1,function(...)self:onToggleChanged(filterTypeIndex,i,...)end)
end
end

end

function UIWanBaoShangHui_filterWin:showSelectPanel()
self.winlua:SetChildDOTweenAnimation_DOPlay(self.selectPanel:getID(),'1',0,3)
self.selectPanelMask:setActive(true)
end

function UIWanBaoShangHui_filterWin:closeSelectPanel()
self.winlua:SetChildDOTweenAnimation_DOPlay(self.selectPanel:getID(),'2',0,3)
self.selectPanelMask:setActive(false)

self.delayTimer=self:delayDo(0.3,function()
return self:closeSelf()
end)
end


function UIWanBaoShangHui_filterWin:getFilter()
local filter={}

for filterTypeIndex,selectList in pairs(self.filterSelectList)do
local filterTypeData=filterTypeDataList[filterTypeIndex]
if filterTypeData then
local filterType=filterTypeData.type
filter[filterType]={}
local filterSelectId={}
local subFilterList=filterTypeData.getSubFilterList(self.filterTypeCfgIndex)
for index,selectFlag in pairs(selectList)do
if selectFlag then
local filterId=filterTypeData.getSubFilterId(index,subFilterList)
filterSelectId[#filterSelectId+1]=filterId
end
end
if not next(filterSelectId)then
filter[filterType]=nil
else
if filterType==ITEM_FILTER_TYPE.eFabaoLianhuaAttr
or filterType==ITEM_FILTER_TYPE.eEquipRandomAttr
or filterType==ITEM_FILTER_TYPE.eFubaoRandomAttr then
filter[filterType]={ITEM_FILTER_COMPARE.eAnd,filterSelectId}
else
filter[filterType]={ITEM_FILTER_COMPARE.eEquals,filterSelectId}
end
end
else
logErr(FMT.fmt("找不到子筛选类型为{0}对应的筛选数据 请确认是否支持此类型筛选",filterTypeIndex))
end
end

return filter
end


function UIWanBaoShangHui_filterWin:getFilterSelectListByFilterRecording()
local filterSelectList={}

local filter=auctionModel:getPersonAuctionSecondFilter(self.filterTypeCfgIndex,self.tabType)
if not filter or not next(filter)then
return{}
end

for index,filterTypeIndex in ipairs(self.filterTypeList)do
local typeData=filterTypeDataList[filterTypeIndex]
local filterType=typeData.type
local filterConditionList=filter[filterType]

if filterConditionList and next(filterConditionList)then
filterSelectList[filterTypeIndex]={}
local subFilterList=typeData.getSubFilterList(self.filterTypeCfgIndex)
local selectIdList=filterConditionList[2]or{}
local selectIdList_lookup={}
for _,subFilterId in ipairs(selectIdList)do
if type(subFilterId)=='table'then
local key=0
for i,v in ipairs(subFilterId)do
key=key+v*100^(i-1)
end
selectIdList_lookup[key]=true
else
selectIdList_lookup[subFilterId]=true
end
end

for i,_ in pairs(subFilterList)do
local subFilterId=typeData.getSubFilterId(i,subFilterList)
if type(subFilterId)=='table'then
local key=0
for i,v in ipairs(subFilterId)do
key=key+v*100^(i-1)
end
if selectIdList_lookup[key]then
filterSelectList[filterTypeIndex][i]=true
end
else
if selectIdList_lookup[subFilterId]then
filterSelectList[filterTypeIndex][i]=true
end
end
end
end
end

return filterSelectList
end





function UIWanBaoShangHui_filterWin:onSelectPanelMask()
self:closeSelectPanel()
end



function UIWanBaoShangHui_filterWin:onSelectCloseBtn()
self:closeSelectPanel()
end



function UIWanBaoShangHui_filterWin:onBtnReset()
self.filterSelectList={}

self:refresh()
end



function UIWanBaoShangHui_filterWin:onBtnConfirm()

local filter=self:getFilter()

auctionModel:setPersonAuctionConditionFilter(self.filterTypeCfgIndex,filter,self.tabType)

local win=UIManager:findActiveWindow(self.winName)
if win then

win:refresh()
end

self:closeSelectPanel()
end

function UIWanBaoShangHui_filterWin:onToggleChanged(filterTypeIndex,index,name,isToggle,data)

self.filterSelectList[filterTypeIndex][index]=isToggle


self:refresh()
end

function UIWanBaoShangHui_filterWin:clearDelayTimer()
if self.delayTimer then
self:stopTimerByID(self.delayTimer)
self.delayTimer=nil
end
end