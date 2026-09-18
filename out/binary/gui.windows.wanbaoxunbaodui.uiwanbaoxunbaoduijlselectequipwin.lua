







def_class("UIWanBaoXunBaoDuiJLSelectEquipWin",UIWindowBase)









function UIWanBaoXunBaoDuiJLSelectEquipWin:bindComponents()

self.root=UIObject.get(self,0)
self.uiroot=UIObject.get(self,1)
self.equipScrollView=UILoopListView.new(self,2)
self.closeBtn=UIButton.get(self,3)
self.nontips=UIText.get(self,4)
self.sortTypeDropdown=UIDropdown.get(self,5)
self.dressStateRoot=UIObject.get(self,6)
self.dressStateBtn=UIButton.get(self,7)
self.selectImg=UIObject.get(self,8)

self.equipScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.dressStateBtn:setButtonClick(function()self:onDressStateBtn()end)



end


function UIWanBaoXunBaoDuiJLSelectEquipWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.uiroot);self.uiroot=nil;
self.equipScrollView:deleteSelf();self.equipScrollView=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.nontips);self.nontips=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.dressStateRoot);self.dressStateRoot=nil;
_UIObject_release(self.dressStateBtn);self.dressStateBtn=nil;
_UIObject_release(self.selectImg);self.selectImg=nil;
end















local CmpSlotItemIndex={
item=0,
name=1,
info=2,
putBtn=3,
state=4,
removeBtn=5,
equipBtn=6,
}

local colorWoldList={
'绿','蓝','紫','橙','红','粉'
}



function UIWanBaoXunBaoDuiJLSelectEquipWin:onLoaded(...)
self:bindComponents()

local qualityDropDownChangeEvent=function(...)
self:onChangeQualityDropDown(...)
end
self.sortTypeDropdown:setChangeAction(qualityDropDownChangeEvent)

self.loopListView=self.winlua:GetChildUILoopListView(self.equipScrollView:getID())
self.loopListViewCmp=self.winlua:GetChildLoopListView2(self.equipScrollView:getID())

self.loopListView:SetAction(function(...)
self:onFreshListView(...)
end,function(...)
self:onStartView(...)
end)
end


function UIWanBaoXunBaoDuiJLSelectEquipWin:__delete()
self:unbindComponents()
end




function UIWanBaoXunBaoDuiJLSelectEquipWin:onShow(argtable,afterOnloaded)
self.putcallback=argtable.putcallback
self.removecallback=argtable.removecallback
self.equipcallback=argtable.equipcallback
self.type=argtable.type
self.catguid=argtable.catguid
self.selectGuid=argtable.selectGuid
self.dropDownIndex=1

self.dressState=wanBaoXunBaoDuiModel:getSelectEquipDressState()

self:freshQualityDropDown()
self:initUI()

if afterOnloaded then
self.uiroot:setChildDOAnchorPosX(-258.83,0.3,nil)
end
end


function UIWanBaoXunBaoDuiJLSelectEquipWin:onHide()

end





function UIWanBaoXunBaoDuiJLSelectEquipWin:onCloseBtn()
UIFullWanBaoXunBaoDuiController:closeWindow('UIWanBaoXunBaoDuiJLSelectEquipWin')
end



function UIWanBaoXunBaoDuiJLSelectEquipWin:onDressStateBtn()
self.dressState=not self.dressState
wanBaoXunBaoDuiModel:setSelectEquipDressState(self.dressState)
self:initUI()
end

function UIWanBaoXunBaoDuiJLSelectEquipWin:initUI()
local equipdata=wanBaoXunBaoDuiController:getMaomaoEquipBagDataInBag(1,self.dropDownIndex)
local equipedData={}
if self.type==WBXBD_SelectEquip_TYPE.REFINE and self.dressState then
equipedData=wanBaoXunBaoDuiModel:getCatEquips()
end

table.sort(equipdata,function(a,b)
local ac=itemsConfig.getItemColor(a.itemid)
local bc=itemsConfig.getItemColor(b.itemid)
local ajllv=a.itemData and a.itemData.jl_lv or 0
local bjllv=b.itemData and b.itemData.jl_lv or 0

if ac==bc then
return ajllv>bjllv
else
return ac>bc
end
end)
equipdata=table.concatTable(equipedData,equipdata)
self.equipData=equipdata

local len=#self.equipData
local guidList={}
local idlist={}
local prefabNameList={}
for index=1,len do
table.insert(idlist,index)
table.insert(guidList,index)
table.insert(prefabNameList,'WBXBD_SelectEquipSlotItem')
end
self.loopListView:InitDataList(len,prefabNameList,idlist,guidList,nil)

self:freshEventListRect()

self.nontips:setActive(#equipdata==0)


self.selectImg:setActive(self.dressState)
end

function UIWanBaoXunBaoDuiJLSelectEquipWin:onStartView()

end

function UIWanBaoXunBaoDuiJLSelectEquipWin:onFreshListView(index,item)
index=index+1
local data=self.equipData[index]
local itemid=data.itemid
local itemguid=data.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local name=FMT.cfmt(color,itemConfig.name)
local static=itemConfig.static
local catguid=data.equiped
local isER=self.type==WBXBD_SelectEquip_TYPE.ER
local itemAttrVal,itemAttrValType=wanBaoXunBaoDuiModel:statisticsEquipAttr(data)
local propName=wanBaoXunBaoDuiModel:getPropNameList()

local jl_lv=data.itemData and data.itemData.jl_lv or 0
local countStr=jl_lv>0 and FMT.fmt("{0}级",jl_lv)or""

local info=FMT.fmt('属性：{0} +{1}',propName[itemAttrValType],itemAttrVal)

local conf={itemid=itemid,itemcount=countStr,showCountBG=jl_lv>0,showname=false,itemguid=itemguid}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(CmpSlotItemIndex.item,prop)
item:SetBaseItemClickEvent(CmpSlotItemIndex.item,itemsComponentHelper.onItemClick)

local isSelectItem=self.selectGuid==itemguid
local isShowPutBtn=(self.type==WBXBD_SelectEquip_TYPE.put or self.type==WBXBD_SelectEquip_TYPE.REFINE)and(not isSelectItem)
local isShowRemoveBtn=(isER and catguid~=nil)or isSelectItem
local isShowEquioBtn=isER and catguid==nil and(not isSelectItem)

item:SetChildText(CmpSlotItemIndex.name,name)
item:SetChildText(CmpSlotItemIndex.info,info)
item:SetChildActive(CmpSlotItemIndex.state,data.equiped~=nil)
item:SetChildActive(CmpSlotItemIndex.putBtn,isShowPutBtn)
item:SetChildActive(CmpSlotItemIndex.removeBtn,isShowRemoveBtn)
item:SetChildActive(CmpSlotItemIndex.equipBtn,isShowEquioBtn)
item:SetChildButtonClick(CmpSlotItemIndex.putBtn,function()
self.putcallback(itemguid,catguid)
self:closeSelf()
end,true)

item:SetChildButtonClick(CmpSlotItemIndex.removeBtn,function()
if self.removecallback then
self.removecallback(itemguid,self.catguid)
end
self:closeSelf()
end,true)

item:SetChildButtonClick(CmpSlotItemIndex.equipBtn,function()
if self.equipcallback then
self.equipcallback(itemguid,self.catguid)
end
self:closeSelf()
end,true)
end

function UIWanBaoXunBaoDuiJLSelectEquipWin:freshEventListRect()
self.loopListViewCmp:ResetListView()
end

function UIWanBaoXunBaoDuiJLSelectEquipWin:freshQualityDropDown()
local optiontxts={}
for index=1,5 do
table.insert(optiontxts,FMT.fmt('{0}品以上',colorWoldList[index]))
end
self.sortTypeDropdown:setOption(optiontxts)
self.sortTypeDropdown:setValue(self.dropDownIndex-1)
end

function UIWanBaoXunBaoDuiJLSelectEquipWin:onChangeQualityDropDown(dropIdx)
self.selectIndex=1
local idx=dropIdx+1
self.dropDownIndex=idx
self:initUI()
end

