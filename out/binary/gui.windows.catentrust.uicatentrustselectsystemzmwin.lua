







def_class("UICatEntrustSelectSystemZMWin",UIWindowBase)









function UICatEntrustSelectSystemZMWin:bindComponents()

self.getInfoProgressPart=UIObject.get(self,0)
self.getInfoTip=UIText.get(self,1)
self.gfList=UIObject.get(self,2)
self.gfScrollview=UIObject.get(self,3)
self.infoBtn=UIButton.get(self,4)
self.okBtn=UIButton.get(self,5)
self.Root=UIObject.get(self,6)
self.sysZmList=UIObject.get(self,7)
self.uiRoot=UIObject.get(self,8)
self.waitSpine=UIObject.get(self,9)
self.zmScrollView=UIObject.get(self,10)

self.infoBtn:setButtonClick(function()self:onInfoBtn()end)

self.okBtn:setButtonClick(function()self:onOkBtn()end)



end


function UICatEntrustSelectSystemZMWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.getInfoProgressPart);self.getInfoProgressPart=nil;
_UIObject_release(self.getInfoTip);self.getInfoTip=nil;
_UIObject_release(self.gfList);self.gfList=nil;
_UIObject_release(self.gfScrollview);self.gfScrollview=nil;
_UIObject_release(self.infoBtn);self.infoBtn=nil;
_UIObject_release(self.okBtn);self.okBtn=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.sysZmList);self.sysZmList=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.waitSpine);self.waitSpine=nil;
_UIObject_release(self.zmScrollView);self.zmScrollView=nil;
end
















local CmpWorldSlotItemIndex={
title=0,
zmlist=1,
}

local CmpZmSlotItemIndex={
icon=0,
name=1,
select=2,
}

local CmpGFSlotItemIndex={
this=-1,
icon=0,
iconBg=1,
name=2,
element=3,
button=4,
}


local _colorEffectLookup={
[0]=10155,10145,10146,10147,10148,10149
}

local _ab='ui/windows/catentrust/catentrust_atlas_pak.ab'

local _zmListTopOffset=39.5
local _zmItemHeight=165
local _zmListRowLen=3
local _zmItemSpaceY=10
local _areaItemSpaceY=-1.82
local _sysZmListWidth=551.8773




function UICatEntrustSelectSystemZMWin:onLoaded(...)
self:bindComponents()

self.selectWorldIndex=1
self.selectZMIndex=1







self:addNotify(notifyConfig.onSystemZMDetailInfo,function(...)self:endProgressPart(...)end)
end


function UICatEntrustSelectSystemZMWin:__delete()
self:unbindComponents()

end




function UICatEntrustSelectSystemZMWin:onShow(argtable,afterOnloaded)
self.wtSlotId=argtable.wtSlotId
self.parentWin=argtable.parentWin
self.tempWt=argtable.tempWt
self.wtSlotData=self.tempWt or catEntrustModel:getWtSlotDataById(self.wtSlotId)

self:refreshAll()
end


function UICatEntrustSelectSystemZMWin:onHide()

end


function UICatEntrustSelectSystemZMWin:refreshAll()
self.systemZmInfoList,self.systemZmInfoLookup=catEntrustModel:getTYSystemZmList()

self:refreshZmList()
self:refreshGFPreList()
end

function UICatEntrustSelectSystemZMWin:refreshZmList()
local len=#self.systemZmInfoList

if len>0 then
self:caculateSystemZmListHeight()
self.sysZmList:setChildSizeDelta(_sysZmListWidth,self.totalHeight)
self.sysZmList:setChildLayoutGroupCreateItems(len,function(index)
local item=self.sysZmList:getChildLayoutGroupGridItem(index-1)
self:bindSystemZmInfoItem(index,item)
end)
end
end

function UICatEntrustSelectSystemZMWin:bindSystemZmInfoItem(index,item)
local wdata=self.systemZmInfoList[index]
local subLen=#wdata.zmlist


local name=cfgHelper.get2(cfg_worldconfig_get,wdata.worldId,'name')
item:SetChildText(CmpWorldSlotItemIndex.title,name)

local isSelectWorld=self.selectWorldIndex==index


item:SetChildLayoutGroupCreateItems(CmpWorldSlotItemIndex.zmlist,subLen,function(sIndex)
local sItem=item:GetChildLayoutGroupGridItem(CmpWorldSlotItemIndex.zmlist,sIndex-1)

local data=wdata.zmlist[sIndex]

local icon=systemZongMenModel:getIconName(data.id,data.level)
local name=systemZongMenModel:getNameStr(data.id,data.nameIdx)

local isSelectZm=self.selectZMIndex==sIndex

sItem:SetChildCSImageIcon(CmpZmSlotItemIndex.icon,icon,true)
sItem:SetChildText(CmpZmSlotItemIndex.name,name)
sItem:SetChildActive(CmpZmSlotItemIndex.select,isSelectZm and isSelectWorld)

sItem:SetBaseItemClickEvent(-1,function()
self:onClickZMSlot(index,sIndex,item,sItem)
end)

sItem:SetChildSizeDelta(-1,_sysZmListWidth,self.systemZmItemHeightList[sIndex])
end)
end

function UICatEntrustSelectSystemZMWin:caculateSystemZmListHeight()
self.totalHeight=0
self.systemZmItemHeightList={}

local areaLen=#self.systemZmInfoList

for areaIndex,areaData in ipairs(self.systemZmInfoList)do
local zmLen=#areaData.zmlist

local maxLine=Mathf.Ceil(zmLen/_zmListRowLen)
local height=_zmListTopOffset+_zmItemHeight*maxLine+(maxLine-1)*_zmItemSpaceY
self.systemZmItemHeightList[areaIndex]=height

self.totalHeight=self.totalHeight+height
end
self.totalHeight=self.totalHeight+(areaLen-1)*_areaItemSpaceY
end

function UICatEntrustSelectSystemZMWin:onClickZMSlot(pIndex,sIndex,pItem,sItem)
local prePItem=self.sysZmList:getChildLayoutGroupGridItem(self.selectWorldIndex-1)
local preSItem=prePItem:GetChildLayoutGroupGridItem(CmpWorldSlotItemIndex.zmlist,self.selectZMIndex-1)
preSItem:SetChildActive(CmpZmSlotItemIndex.select,false)

sItem:SetChildActive(CmpZmSlotItemIndex.select,true)
self.selectWorldIndex=pIndex
self.selectZMIndex=sIndex

self:refreshGFPreList()
end

function UICatEntrustSelectSystemZMWin:refreshGFPreList()
local zmData=self.systemZmInfoList[self.selectWorldIndex].zmlist[self.selectZMIndex]
if zmData then
self.preGfInfoList=systemZongMenModel:getDetailPartInfo(zmData.serial,systemZongMenDetailDataPart.eCangJingGe)

if self.preGfInfoList then
local len=#self.preGfInfoList.gongfaList
table.sort(self.preGfInfoList.gongfaList,function(a,b)
local aCfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,a)
local bCfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,b)

return aCfg.color>bCfg.color
end)
local column=3


self.gfList:setChildLayoutGroupCreateItems(len,function(index)
local item=self.gfList:getChildLayoutGroupGridItem(index-1)
self:bindGFInfoItem(index,item)

item:SetBaseItemClickEvent(-1,function()
self:onClickGFSlot(index)
end)
end)
else

systemZongMenController:req_detailInfo(systemZongMenDetailDataPart.eCangJingGe,zmData.serial)
self:showProgressPart()
end
end
end

function UICatEntrustSelectSystemZMWin:bindGFInfoItem(index,item)
local gfId=self.preGfInfoList.gongfaList[index]

local isShowGfItem=gfId~=nil
item:SetChildActive(-1,isShowGfItem)
if isShowGfItem then
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfId)

local qualityIconName=FMT.fmt("image_maomaoweituo_pz{0}",cfg.color)
item:SetChildCSImageSprite(CmpGFSlotItemIndex.iconBg,_ab,qualityIconName)

local elements=UIGongFaModel:getGFElements(gfId)
local elementIcon=ELEMENT_TYPE.getIcon(elements[1])
item:SetChildCSImageSprite(CmpGFSlotItemIndex.element,globalABLookup.global,elementIcon)

item:SetChildText(CmpGFSlotItemIndex.name,cfg.name)

item:SetChildIcon(CmpGFSlotItemIndex.icon,iconHelper.getGongFaIcon(cfg.icon),false)

item:SetChildButtonClick(CmpGFSlotItemIndex.button,function()
self:onClickGFSlot(index)
end)
end
end

function UICatEntrustSelectSystemZMWin:onClickGFSlot(index)
local gfId=self.preGfInfoList.gongfaList[index]
UIManager:showWindow('UIGongFaTipsFourWin',{gfID=gfId})
end

function UICatEntrustSelectSystemZMWin:showProgressPart()
self.gfScrollview:setActive(false)
self.getInfoProgressPart:setActive(true)
self.waitSpine:setChildUIModelShowTarget(5476,1,{},eAnimationID.stand,false,false,0.1)
end

function UICatEntrustSelectSystemZMWin:endProgressPart(type,serial)
local selectSerial=self.systemZmInfoList[self.selectWorldIndex].zmlist[self.selectZMIndex].serial
if selectSerial==serial and type==systemZongMenDetailDataPart.eCangJingGe then
self:refreshGFPreList()

self:delayDo(0.5,function()
self.getInfoProgressPart:setActive(false)
self.gfScrollview:setActive(true)
end)
end
end







function UICatEntrustSelectSystemZMWin:onOkBtn()
local data=self.systemZmInfoList[self.selectWorldIndex].zmlist[self.selectZMIndex]
local wtSlotData=self.wtSlotData
catEntrustModel:setWtSlotExclusiveData(wtSlotData,'systemZmId',data.serial)
UIManager:invokeUIMethod('UICatEntrustWin','refreshAll')
self.parentWin:onClickClose()
catEntrustConfig.doNextProgress(wtSlotData)
end



function UICatEntrustSelectSystemZMWin:onInfoBtn()
local d={}
d.mode=3
d.title="说明"
d.name='cat_entrust_select_systemzm_rule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

