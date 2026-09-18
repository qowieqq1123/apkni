







def_class("UIFaBaoYuanPeiFilterWin",UIWindowBase)









function UIFaBaoYuanPeiFilterWin:bindComponents()

self.backBtn=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.qualityPart=UIObject.get(self,2)
self.refiningMaterialsPart=UIObject.get(self,3)
self.resetBtn=UIButton.get(self,4)
self.typePart=UIObject.get(self,5)
self.uiRoot=UIObject.get(self,6)
self.winTitleTx=UIText.get(self,7)

self.backBtn:setButtonClick(function()self:onBackBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.resetBtn:setButtonClick(function()self:onResetBtn()end)



end


function UIFaBaoYuanPeiFilterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backBtn);self.backBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.qualityPart);self.qualityPart=nil;
_UIObject_release(self.refiningMaterialsPart);self.refiningMaterialsPart=nil;
_UIObject_release(self.resetBtn);self.resetBtn=nil;
_UIObject_release(self.typePart);self.typePart=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.winTitleTx);self.winTitleTx=nil;
end

















local _this


local _maxSelectMaterialFilterNum=3

local _bagFilterTypes={
BAG_FILTER_TYPE.eItemType1Type,
BAG_FILTER_TYPE.eColor,
BAG_FILTER_TYPE.eMaterialsType
}

local _itemQualityColors={
[0]=eQualityColor.eRed,
[1]=eQualityColor.eOrange,
[2]=eQualityColor.ePurple
}


function table.size(t)
local size=0
for _ in pairs(t)do
size=size+1
end

return size
end





function string.subEx(str,startIndex,endIndex)

local _getBytes=function(char)
if not char then
return
end
local code=string.byte(char)
if code<127 then
return 1
elseif code<=223 then
return 2
elseif code<=239 then
return 3
elseif code<=247 then
return 4
else
return 0
end
end

local tmpStr=str
local byteStart=1
local byteEnd=-1
local index=1
local bytes=0
local strLen=string.lenEx(str)
if startIndex>strLen then
error("Index out of range! Valid range: 1 to "..strLen)
end

startIndex=math.max(startIndex,1)
endIndex=endIndex or strLen

while string.len(tmpStr)>0 do
if index==startIndex then
byteStart=bytes+1
end

if index==endIndex+1 then
byteEnd=bytes
break
end

bytes=bytes+_getBytes(tmpStr)
tmpStr=string.sub(str,bytes+1)
index=index+1
end
return string.sub(str,byteStart,byteEnd)
end


local _typeShowMaxWordNum=2












local _getPrefixNamesByType1=function(self,type1Id)
local infoList=self.yuanpeiPrefixTypes[type1Id]
local result={}
for _,v in ipairs(infoList)do
table.insert(result,v.prefixName)
end
return result
end



local _getFilterDataTableByType=function(self,type)
local filterData=self.filterDataTable[type]
filterData=filterData or{}
return filterData
end









local _yuanpeiFilterUntil={
[BAG_FILTER_TYPE.eItemType1Type]={


initFilterDataTable=function(self)
self.filterDataTable[BAG_FILTER_TYPE.eItemType1Type]={}
end,




buildFilterDataTable=function(self,filterTableCache)
local cache=filterTableCache[ITEM_FILTER_TYPE.eItemType1AndType2]
if cache==nil then return end

local filter=self.filterDataTable[BAG_FILTER_TYPE.eItemType1Type]
local _,data=next(cache)
for _,v in pairs(data)do
local type1=math.floor(v/100)
local type2=v%10
filter[type1]=filter[type1]or{}

table.insert(filter[type1],type2)
end
end,



getFilterFunc=function(self,filterData)

if filterData==nil then
return nil
end

local _transformMarkToFinalOutput=function(rawData)
local prefixTypeInfoMap=self.yuanpeiPrefixTypes

for k,v in pairs(rawData)do
if next(v)==nil then
for k1,v1 in pairs(prefixTypeInfoMap[k])do
table.insert(v,k1)
end
end
end
end

_transformMarkToFinalOutput(filterData)

local data={}
for k,v in pairs(filterData)do
local len=#v

for i=1,len do

data[#data+1]=k*100+v[i]
end
end

return next(data)~=nil and{
[ITEM_FILTER_TYPE.eItemType1AndType2]={
[ITEM_FILTER_COMPARE.eEquals]=data
}
}
or nil
end,


setTypeFilterResult=function(self,selectTypeId,filterResult)
local dataTable=self.filterDataTable[BAG_FILTER_TYPE.eItemType1Type]

dataTable[selectTypeId]=next(filterResult)and filterResult or nil





end

},

[BAG_FILTER_TYPE.eColor]={


initFilterDataTable=function(self)
self.filterDataTable[BAG_FILTER_TYPE.eColor]={}
end,




buildFilterDataTable=function(self,filterTableCache)
local cache=filterTableCache[ITEM_FILTER_TYPE.eColor]
if cache==nil then return end

local filter=self.filterDataTable[BAG_FILTER_TYPE.eColor]

local _,data=next(cache)
filter=filter or{}
for _,v in ipairs(data)do
table.insert(filter,v)
end
end,



getFilterFunc=function(self,filterData)

if filterData==nil then
return nil
end

return next(filterData)~=nil and{
[ITEM_FILTER_TYPE.eColor]={
[ITEM_FILTER_COMPARE.eEquals]=filterData
}
}
or nil
end,
},

[BAG_FILTER_TYPE.eMaterialsType]={


initFilterDataTable=function(self)
self.filterDataTable[BAG_FILTER_TYPE.eMaterialsType]={}
end,




buildFilterDataTable=function(self,filterTableCache)
local cache=filterTableCache[ITEM_FILTER_TYPE.eFaBaoYuanPeiLianZhiMaterial]
if cache==nil then return end

local filter=self.filterDataTable[BAG_FILTER_TYPE.eMaterialsType]

local andFilter=cache[ITEM_FILTER_COMPARE.eAnd]
if andFilter then

for _,v1 in ipairs(andFilter)do
filter[v1]=1
end
end

local notFilter=cache[ITEM_FILTER_COMPARE.eNot]
if notFilter then

for _,v2 in ipairs(notFilter)do
filter[v2]=0
end
end

end,



getFilterFunc=function(self,filterData)

if filterData==nil then
return nil
end

local filter={[ITEM_FILTER_TYPE.eFaBaoYuanPeiLianZhiMaterial]={}}
local selectList,ignoreList={},{}

for id,state in pairs(filterData)do
if state==1 then
selectList[#selectList+1]=id
elseif state==0 then
ignoreList[#ignoreList+1]=id
end
end

if next(selectList)==nil and next(ignoreList)==nil then
return nil
end

if next(selectList)~=nil then
filter[ITEM_FILTER_TYPE.eFaBaoYuanPeiLianZhiMaterial][ITEM_FILTER_COMPARE.eAnd]=selectList
end

if next(ignoreList)~=nil then
filter[ITEM_FILTER_TYPE.eFaBaoYuanPeiLianZhiMaterial][ITEM_FILTER_COMPARE.eNot]=ignoreList
end

return next(filter)~=nil and filter or nil
end,
}
}







function UIFaBaoYuanPeiFilterWin:onLoaded(...)
self:bindComponents()

self.yuanpeiTypes={}

self.yuanpeiLianZhiMaterials={}

self.yuanpeiPrefixTypes={}


self.qualityFilterTable={}

self.lianZhiMtFilterTable={}

_this=self
end


function UIFaBaoYuanPeiFilterWin:__delete()
self:unbindComponents()

self:killTweener()


self.safeguardCachedFilterDataCallback(self:getYuanPeiFilter())
end




function UIFaBaoYuanPeiFilterWin:onShow(argtable,afterOnloaded)
self.selectBagType=argtable.selectBagType
self.closeCallback=argtable.closeCallback
self.refreshItemsCallback=argtable.refreshItemsCallback
self.safeguardCachedFilterDataCallback=argtable.safeguardCachedFilterDataCallback
self.yuanpeiFilter=argtable.yuanpeiFilter

self.filterDataTable={}

self:initialize()

if afterOnloaded then
self:playUIShowAnimation()
end
end


function UIFaBaoYuanPeiFilterWin:onHide()

end




function UIFaBaoYuanPeiFilterWin:onCloseBtn()





self:onCompleteYuanPeiTypeFilter()

if self.closeCallback then
self.closeCallback()
end
self:closeSelf()
end


function UIFaBaoYuanPeiFilterWin:onResetBtn()

self:resetFilter()
end



function UIFaBaoYuanPeiFilterWin:initialize()
self.yuanpeiTypes,self.yuanpeiLianZhiMaterials,self.yuanpeiPrefixTypes
=self:getFaBaoYuanPeiDataFromConfigs(cfg_fabaoyuanpeitypeconfig(),cfg_fabaoyuanpeiprefixtypeconfig())

self:initFilterUntil()

self:initializeTypeLayoutGroupItems()
self:initializeMaterialsLayoutGroupItems()
self:initializeQualityButtonGroup()

for _,v in ipairs(_bagFilterTypes)do
self:refreshUIState(v)
end
end

function UIFaBaoYuanPeiFilterWin:initFilterUntil()
local count=#_bagFilterTypes
for i=1,count do
local t=_bagFilterTypes[i]
local filterUntil=_yuanpeiFilterUntil[t]
if filterUntil then
filterUntil.initFilterDataTable(self)
filterUntil.buildFilterDataTable(self,self.yuanpeiFilter)
end
end
end


function UIFaBaoYuanPeiFilterWin:initializeTypeLayoutGroupItems()

local typePartWb=self.typePart:getChildWidgetBase()

local typeList=self.yuanpeiTypes
local prefixTypeMap=self.yuanpeiPrefixTypes
local typeCount=#typeList


local itemTypeFilterUntil=_yuanpeiFilterUntil[BAG_FILTER_TYPE.eItemType1Type]


local createYuanPeiTypeItem=function(index)
local item=typePartWb:GetChildLayoutGroupGridItem(0,index-1)
local toggleBtn=item:GetChildWidgetBase(0)
local flagBtn=item:GetChildWidgetBase(1)


local typeCfg=typeList[index]
toggleBtn:SetChildText(0,typeCfg.name)



item:SetChildButtonClick(0,function()


local typeFilterData=_getFilterDataTableByType(self,BAG_FILTER_TYPE.eItemType1Type)
local data=typeFilterData[typeCfg.id]




local enable=data==nil


if enable then
data={}
else
data=nil
end
typeFilterData[typeCfg.id]=data
_this:refreshUIState(BAG_FILTER_TYPE.eItemType1Type)
_this.refreshItemsCallback(_this:getYuanPeiFilter())
end)



item:SetChildButtonClick(1,function()

local typeFilterData=_getFilterDataTableByType(self,BAG_FILTER_TYPE.eItemType1Type)
local data=typeFilterData[typeCfg.id]


data=data or{}

local args={
widgetHeight=flagBtn:GetChildSizeDeltaY(-1),
widgetPosition=flagBtn:GetChildPosition(-1),
invokeWin=_this,
recordData=data,
selectedTypeId=typeCfg.id,
prefixTypeInfoList=prefixTypeMap[typeCfg.id],
refreshItemCallback=function(result)
itemTypeFilterUntil.setTypeFilterResult(_this,result.selectedTypeId,result.filterData)
self:refreshUIState(BAG_FILTER_TYPE.eItemType1Type)
_this.refreshItemsCallback(_this:getYuanPeiFilter())
end,
closeCallback=function(result)
end
}



typeFilterData[typeCfg.id]=data
self:showWindow("UIFaBaoYuanPeiTypeFilterSubWin",args)
end)
end
typePartWb:SetChildLayoutGroupCreateItems(0,typeCount,createYuanPeiTypeItem)
self.winlua:ForceLayoutVertical(self.typePart:getID())


end

function UIFaBaoYuanPeiFilterWin:initializeMaterialsLayoutGroupItems()


local lianzhiMaterialsPartWb=self.refiningMaterialsPart:getChildWidgetBase()

local lianzhiMtTypeList=self.yuanpeiLianZhiMaterials
local lianzhiMtTypeCount=#lianzhiMtTypeList

local _showErrorUI=function()
UIManager.error("最多选中三个炼制材料")
end


local createLianZhiMtTypeItem=function(index)
local item=lianzhiMaterialsPartWb:GetChildLayoutGroupGridItem(0,index-1)


local mtCfg=lianzhiMtTypeList[index]

item:SetChildText(0,mtCfg.name)

local _getAndFilterDataCount=function(t)
local size=0
for _,state in pairs(t)do
if state==1 then
size=size+1
end
end

return size
end

item:SetChildButtonClick(1,function()
local materialFilterData=_getFilterDataTableByType(self,BAG_FILTER_TYPE.eMaterialsType)

if materialFilterData==nil then return end


local lastState=materialFilterData[mtCfg.id]

local filterDataCount=_getAndFilterDataCount(materialFilterData)
if lastState==nil and filterDataCount>=_maxSelectMaterialFilterNum then
_showErrorUI()
return
end

if lastState==nil or lastState==0 then
materialFilterData[mtCfg.id]=1
else
materialFilterData[mtCfg.id]=nil
end

_this:refreshUIState(BAG_FILTER_TYPE.eMaterialsType)
_this.refreshItemsCallback(_this:getYuanPeiFilter())
end)
item:SetChildButtonClick(2,function()
local materialFilterData=_getFilterDataTableByType(self,BAG_FILTER_TYPE.eMaterialsType)

if materialFilterData==nil then return end

local lastState=materialFilterData[mtCfg.id]







if lastState==nil or lastState==1 then
materialFilterData[mtCfg.id]=0
else
materialFilterData[mtCfg.id]=nil
end

_this:refreshUIState(BAG_FILTER_TYPE.eMaterialsType)
_this.refreshItemsCallback(_this:getYuanPeiFilter())
end)
end
lianzhiMaterialsPartWb:SetChildLayoutGroupCreateItems(0,lianzhiMtTypeCount,createLianZhiMtTypeItem)

end


function UIFaBaoYuanPeiFilterWin:initializeQualityButtonGroup()
local qualityPartWb=self.qualityPart:getChildWidgetBase()


for i,v in pairs(_itemQualityColors)do
local buttonWb=qualityPartWb:GetChildWidgetBase(i)

buttonWb:SetChildButtonClick(-1,function()
local qualityFilterData=_getFilterDataTableByType(self,BAG_FILTER_TYPE.eColor)

local qualityColor=v


if table.containsValue(qualityFilterData,qualityColor)then
table.removeValue(qualityFilterData,qualityColor)
else
table.insert(qualityFilterData,qualityColor)
end

_this:refreshUIState(BAG_FILTER_TYPE.eColor)
_this.refreshItemsCallback(_this:getYuanPeiFilter())
end)
end
end





function UIFaBaoYuanPeiFilterWin:refreshUIState(filterType)
if filterType==BAG_FILTER_TYPE.eItemType1Type then
self:refreshItemsState_ItemType()
elseif filterType==BAG_FILTER_TYPE.eColor then
self:refreshQualityButtonState()
elseif filterType==BAG_FILTER_TYPE.eMaterialsType then
self:refreshItemsState_MaterialType()
end
end

function UIFaBaoYuanPeiFilterWin:refreshItemsState_MaterialType()
local refiningMaterialsPartWb=self.refiningMaterialsPart:getChildWidgetBase()
local materialFilterData=_getFilterDataTableByType(self,BAG_FILTER_TYPE.eMaterialsType)

local materialInfoList=self.yuanpeiLianZhiMaterials
local materialCount=#materialInfoList

for index=1,materialCount do
local item=refiningMaterialsPartWb:GetChildLayoutGroupGridItem(0,index-1)

local info=materialInfoList[index]


local state=materialFilterData[info.id]

if state==nil then
item:SetChildGray(1,true)
item:SetChildGray(2,true)
else
local isSelected=state==1
item:SetChildGray(1,not isSelected)
item:SetChildGray(2,isSelected)
end
end

end

function UIFaBaoYuanPeiFilterWin:refreshQualityButtonState()
local qualityPartWb=self.qualityPart:getChildWidgetBase()

local qualityFilterData=_getFilterDataTableByType(self,BAG_FILTER_TYPE.eColor)

for i,v in pairs(_itemQualityColors)do
local buttonWb=qualityPartWb:GetChildWidgetBase(i)
local enable=table.containsValue(qualityFilterData,v)

buttonWb:SetChildGray(-1,not enable)
end
end


function UIFaBaoYuanPeiFilterWin:refreshItemsState_ItemType()

local typePartWb=self.typePart:getChildWidgetBase()

local typeList=self.yuanpeiTypes
local prefixTypeMap=self.yuanpeiPrefixTypes
local typeCount=#typeList


local typeFilterData=_getFilterDataTableByType(self,BAG_FILTER_TYPE.eItemType1Type)

local isGray

for index=1,typeCount do
local item=typePartWb:GetChildLayoutGroupGridItem(0,index-1)
local flagBtn=item:GetChildWidgetBase(1)
local typeCfg=typeList[index]

local prefixNameCount=#prefixTypeMap[typeCfg.id]


local selected=typeFilterData[typeCfg.id]

isGray=selected==nil
local showAll=selected==nil or next(selected)==nil or#selected==prefixNameCount
local flagText="全部"


item:SetChildGray(-1,isGray)


if not showAll then
local first=_getPrefixNamesByType1(self,typeCfg.id)[selected[1]]

local tmp=string.subEx(first,1,math.min(string.lenEx(first),_typeShowMaxWordNum))
tmp=tmp.."..."
flagText=tmp
end

flagBtn:SetChildText(0,flagText)
end
end





function UIFaBaoYuanPeiFilterWin:getFaBaoYuanPeiDataFromConfigs(yuanpeiTypeCfg,yuanpeiPrefixTypeCfg)
local t1,t2,t3={},{},{}
for i,v in pairs(yuanpeiTypeCfg)do

table.insert((i>100)and t1 or t2,{
id=v.id,
name=v.name
})
end

for _,v in ipairs(yuanpeiPrefixTypeCfg)do
local type1Id=v.type1
t3[type1Id]=t3[type1Id]or{}
table.insert(t3[type1Id],{
type2Id=v.type2,
prefixName=v.prefixName
})
end

return t1,t2,t3
end

function UIFaBaoYuanPeiFilterWin:getYuanPeiFilter()
local result={}
for _,v in ipairs(_bagFilterTypes)do
local filterUntil=_yuanpeiFilterUntil[v]
if filterUntil==nil then
goto continue
end

local data=filterUntil.getFilterFunc(self,_getFilterDataTableByType(self,v))

if data==nil then
goto continue
end

local filterType,filter=next(data)
result[filterType]=filter

::continue::
end






local t={}
for _,v in pairs(FABAO_YUANPEI_MAT_TYPE)do
table.insert(t,v)
end
result[ITEM_FILTER_TYPE.eItemType1]={
[ITEM_FILTER_COMPARE.eEquals]=t
}

return result
end

function UIFaBaoYuanPeiFilterWin:resetFilter()
local needReset=false
for _,type in ipairs(_bagFilterTypes)do
if self.filterDataTable~=nil and next(self.filterDataTable[type])~=nil then
self.filterDataTable[type]={}
needReset=true
end
end

if needReset then
for _,type in ipairs(_bagFilterTypes)do
self:refreshUIState(type)
end
self.refreshItemsCallback(self:getYuanPeiFilter())
end

end

function UIFaBaoYuanPeiFilterWin:onBackBtn()
self:onCloseBtn()
end


function UIFaBaoYuanPeiFilterWin:onCompleteYuanPeiTypeFilter()

end

function UIFaBaoYuanPeiFilterWin:playUIShowAnimation()
self.uiRoot:setChildAnchoredPos(1000,0)
self.uiRoot:setChildCanvasGroupAlpha(0)

self.tweener1=self.uiRoot:setChildDOAnchorPosX(345.63,0.2)
self.tweener2=self.uiRoot:setChildCanvasGroupDOFade(1,0.2)
end

function UIFaBaoYuanPeiFilterWin:killTweener()
if self.tweener1 then
self.tweener1:Kill()
self.tweener1=nil
end
if self.tweener2 then
self.tweener2:Kill()
self.tweener2=nil
end
end


