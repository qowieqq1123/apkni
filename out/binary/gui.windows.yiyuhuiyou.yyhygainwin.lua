







def_class("YYHYGainWin",UIWindowBase)









function YYHYGainWin:bindComponents()

self.root=UIObject.get(self,0)
self.gainPage=UIObject.get(self,1)
self.fubaoFilter=UIDropdown.get(self,2)
self.dressToggle=UIToggleButton.get(self,3)
self.gainTitle=UIText.get(self,4)
self.gainScrollView=UIScrollView.get(self,5)
self.scrollview=UIObject.get(self,6)
self.unEquipTitle=UIObject.get(self,7)
self.fubaoItem=UIBaseItem.get(self,8)



end


function YYHYGainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.gainPage);self.gainPage=nil;
_UIObject_release(self.fubaoFilter);self.fubaoFilter=nil;
_UIObject_release(self.dressToggle);self.dressToggle=nil;
_UIObject_release(self.gainTitle);self.gainTitle=nil;
_UIObject_release(self.gainScrollView);self.gainScrollView=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.unEquipTitle);self.unEquipTitle=nil;
_UIObject_release(self.fubaoItem);self.fubaoItem=nil;
end
















local _this
local _movePosX=
{
[TIPS_MOVE_POS.eRight]=20,
[TIPS_MOVE_POS.eLeft]=-280,
}



function YYHYGainWin:onLoaded(...)
self:bindComponents()

_this=self

self.dressToggle:setToggleChange(function(...)self:onToggleChanged(...)end)
self.fubaoFilter:setChangeAction(function(...)self:onDropdownChange(...)end)

self.scrollview:setChildScrollViewInit(0.5,true,self.on_item_click,nil)
self.fubaoItem:setBaseItemClickEvent(function(...)
self:onClickBaseItem(...)
end)
self.gainScrollView:setClickAction(function(...)self:onGainItemClick(...)end)

self.gainScrollView:bindScrollWidget(function(...)
self:fillGainData(...)
end)
end


function YYHYGainWin:__delete()
self:unbindComponents()

_this=nil

if self.isShowTips then
tipsManager.closeTips()
end
end


function YYHYGainWin.on_item_click(clickNum,index)
local data=_this.yuerDatas[index+1]
if data then
local guid=data.itemguid
if _this.selectguid==guid then return end
_this.selectguid=guid

if _this.selectIndex then
local item=_this.scrollview:getChildScrollViewItemWidget(_this.selectIndex)
item:SetChildActive(0,false)
end

_this.selectIndex=index

local item=_this.scrollview:getChildScrollViewItemWidget(index)
item:SetChildActive(0,true)

if data then
_this:showTips(data.itemid,data.itemguid)
end

end
end


function YYHYGainWin:onClickBaseItem(id,index,guid,attach)
if self.selectguid==guid then return end
self.selectguid=guid

local item=self.item
local itemguid
if item then itemguid=item.itemguid end
self.fubaoItem:setChildItemDataByDataPropKey(DataPropKey.eWidgetActive,3,itemguid==guid)
self:showTips(item.itemid,item.itemguid)
self:refreshFuBaoList(self.selectStage)
end

function YYHYGainWin:onDropdownChange(idx)
if self.lockRefresh then return end
idx=idx+1
if self.sortTypeIndex==idx then return end
self.sortTypeIndex=idx
self.selectStage=self.sortTypeList[idx]


end


function YYHYGainWin:onToggleChanged(name,isToggle,data)



end




function YYHYGainWin:onShow(argtable,afterOnloaded)
argtable={}
self.diziguid=argtable.diziguid
self.pos=argtable.pos
self.item=nil


self.tuijianItemid=12149




YYHYGainWin:refreshYuErList(self.selectStage)

if self.item==nil then
self.on_item_click(1,0)
end


_this.fubaoFilter:setActive(false)
_this.dressToggle:setActive(false)


self:freshGainPage()
end


function YYHYGainWin:onHide()

end


function YYHYGainWin:freshEquipPage()
local hasItem=false

self.fubaoItem:setActive(hasItem)
self.unEquipTitle:setActive(not hasItem)

if hasItem and self.selectguid==nil then
self.selectguid=self.item.itemguid
self.isSelectEquip=true
self:showTips(self.item.itemid,self.item.itemguid)
end

end


function YYHYGainWin:fillItem(item)
if item==nil then return end
local prop={}
local itemid=item.itemid
local itemguid=item.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=itemConfig.stage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local iconName=iconHelper.getIconName(itemid)

prop[PropIndex(DataPropKey.eWidgetQuality,0)]=color
prop[PropIndex(DataPropKey.eWidgetIcon,1)]=iconName
prop[PropIndex(DataPropKey.eWidgetText,2)]=itemConfig.name
prop[PropIndex(DataPropKey.eWidgetActive,3)]=self.selectguid==itemguid
prop[PropIndex(DataPropKey.eWidgetActive,4)]=stageStr~=''
prop[PropIndex(DataPropKey.eWidgetText,5)]=stageStr
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=itemguid
self.fubaoItem:setChildPropData(prop)
end


function YYHYGainWin:initSort()
self.sortTypeList={0,5,4,3,2,1}
local namelist={
'所有',
'5阶玉符',
'4阶玉符',
'3阶玉符',
'2阶玉符',
'1阶玉符',
}
self.fubaoFilter:setOption(namelist)
self.sortTypeIndex=1
self.selectStage=self.sortTypeList[self.sortTypeIndex]
self.lockRefresh=true
self.fubaoFilter:setValue(self.sortTypeIndex-1)
self.lockRefresh=false
end

function YYHYGainWin:getFuBaoDatas(stage)
local checkDress=self.dressToggle:getToggle()

local filter={}
if stage>0 then
filter[ITEM_FILTER_TYPE.eStage]={ITEM_FILTER_COMPARE.eEquals,{stage}}
end

local itemguid=-1
if self.item then
itemguid=self.item.itemguid
end
local items=UIFuLuFangModel.getAllFuBao(self.diziguid,filter,checkDress)
return items
end


function YYHYGainWin:refreshFuBaoList(stage)


local filter={}
filter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eEquals,{itemType}}
self.fubaoDatas=bagControl.getBagItemsByFilter(BAG_TYPE.eItemBag,filter)

self.scrollview:setChildScrollViewDelayCreateGrids(#self.fubaoDatas,1,0.02,1,false,false,function(index,widget)
if _this==nil then return end
local diziguid_=_this.diziguid
local data=_this.fubaoDatas[index+1]
local itemId=data.itemid
local itemguid=data.itemguid
local isSelect=self.selectguid==itemguid
widget:SetChildActive(0,isSelect)
widgetHelper.setNormalRewardItem(widget,1,{itemId,0})
local cfg=itemsConfig.getConfig(itemId)
widget:SetChildText(2,cfg.name)

local stageTitile=itemsConfig.getStageName(itemId)
local stageStr=cfg.stage and pfwindowslController:getStageStr(itemId,stageTitile)or''
widget:SetChildActive(5,stageStr~='')
widget:SetChildText(6,stageStr)

local hasEquiped=UIFuLuFangModel:isEquipedOnAnyDizi(itemguid)
widget:SetChildActive(3,hasEquiped)
if hasEquiped then
local diziguid=UIFuLuFangModel:getDzGuidByItemGuid(itemguid)
widget:SetChildActive(7,diziguid==diziguid_)
widget:SetChildActive(3,diziguid~=diziguid_)
if diziguid and diziguid~=diziguid_ then
comHelper.setChildModelRawImage(widget,diziguid,4,0,eHeadCenterType.eHead)

end
end
end)
end



function YYHYGainWin:refreshYuErList(stage)


local filter={}

filter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eEquals,{21}}
_this.yuerDatas=bagControl.getBagItemsByFilter(BAG_TYPE.eItemBag,filter)


local selectyuerid=YiYuHuiYouModel:getXianLuId()


_this.scrollview:setChildScrollViewDelayCreateGrids(#_this.yuerDatas,1,0.02,1,false,false,function(index,widget)
if _this==nil then return end

local data=_this.yuerDatas[index+1]
local itemId=data.itemid
local itemguid=data.itemguid
local isSelect=self.selectguid==itemguid

widget:SetChildActive(0,isSelect)
widgetHelper.setNormalRewardItem(widget,1,{itemId,0})
local cfg=itemsConfig.getConfig(itemId)
widget:SetChildText(2,cfg.name)

local stageTitile=itemsConfig.getStageName(itemId)
local stageStr=cfg.stage and pfwindowslController:getStageStr(itemId,stageTitile)or''
widget:SetChildActive(5,stageStr~='')
widget:SetChildText(6,stageStr)
widget:SetChildActive(7,itemId==selectyuerid)
widget:SetChildActive(8,data.itemcount>1)
widget:SetChildText(9,data.itemcount)

local hasEquiped=false
widget:SetChildActive(3,hasEquiped)
if hasEquiped then
local diziguid=UIFuLuFangModel:getDzGuidByItemGuid(itemguid)
widget:SetChildActive(7,diziguid==1)
widget:SetChildActive(3,diziguid~=1)
if diziguid and diziguid~=1 then
comHelper.setChildModelRawImage(widget,diziguid,4,0,eHeadCenterType.eHead)

end
end
end)
end




function YYHYGainWin:freshGainPage()

local noitem=#_this.yuerDatas==0
_this.gainPage:setActive(noitem)


if noitem then
local tuijianItemid=_this.tuijianItemid
local itemConf=itemsConfig.getConfig(tuijianItemid)
_this.produce=itemConf.produce

local produce=_this.produce or{}
local len=#produce
_this.gainScrollView:freshGridsNum(len,len,1,_this.initGain~=true)
_this.initGain=true
end
end


function YYHYGainWin:fillGainData(index,widget)
local info=_this.produce[index]
local jump=info.jump
local unLock,err=_this:checkGainUnLock(info)
local isUnlock=jump and unLock or false
widget:SetChildText(0,info.desc)
widget:SetChildActive(1,not unLock)
widget:SetChildActive(2,isUnlock)
widget:SetChildButtonClick(3,function()
if isUnlock then
jumpManager:jump(jump)
else
UIManager.error(err)
end
end)
end

function YYHYGainWin:checkGainUnLock(v)
local sysid=v.sysid
local lv=v.lv
if sysid then
if not systemModel.isOpen(sysid)then
local name=systemConfig.getSystemName(sysid)
return false,FMT.fmt('请先开启{0}系统，无法跳转',name)
end
end
if lv then
if playerModel:getActorLevel()<lv then
return false,FMT.fmt('宗门等级不足{0}级，无法跳转',lv)
end
end
return true
end



function YYHYGainWin:showTips(itemid,itemguid)
self.movepos=TIPS_MOVE_POS.eLeft
local args={
formType=TIPS_FORM_TYPE.eYuEr,
itemid=itemid,
itemguid=itemguid,
movepos=TIPS_MOVE_POS.eRight,
attach={
diziguid=self.diziguid,
pos=self.pos,
},
}
tipsManager.showTips(args)
self:doAni()
self.isShowTips=true
end

function YYHYGainWin:closeTips()
self.movepos=TIPS_MOVE_POS.eRight
tipsManager.closeTips()
self:doAni()
self.isShowTips=false
end

function YYHYGainWin:doAni()
if self.movepos then
self.winlua:SetChildDOAnchorPosX(self.root:getID(),_movePosX[self.movepos],0.5)
end
end




function YYHYGainWin:onCloseClick()
self:closeSelf()
end