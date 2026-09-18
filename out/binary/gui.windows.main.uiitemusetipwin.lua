







def_class("UIItemUseTipWin",UIWindowBase)









function UIItemUseTipWin:bindComponents()

self.name=UIText.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.useBtn=UIButton.get(self,2)
self.UIBaseItemSmall=UIBaseItem.get(self,3)
self.root=UIObject.get(self,4)
self.btnText=UIObject.get(self,5)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.useBtn:setButtonClick(function()self:onUseBtn()end)



end


function UIItemUseTipWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.useBtn);self.useBtn=nil;
_UIObject_release(self.UIBaseItemSmall);self.UIBaseItemSmall=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.btnText);self.btnText=nil;
end
















local _this



function UIItemUseTipWin:onLoaded(...)
self:bindComponents()
_this=self

self:setRootVis(false)

self:addNotify(notifyConfig.on_item_list_changed,function(...)
if _this==nil then return end

_this:on_item_list_changed(...)
end)
end

function UIItemUseTipWin:__delete()
_this=nil

self:unbindComponents()
end

function UIItemUseTipWin:onShow(argtable,afterOnloaded)
local itemguid=bagUseControl.getAskGUID()
local item=bagModel.getItem(itemguid)

if item==nil then
self:moveNext()
return
end

local descText="使用"
if itemsConfig.getConfig(item.itemid).typename then
if itemsConfig.getConfig(item.itemid).typename=="道兵碎片"then
descText="合成"
end
end

if bagUseControl.isItemExpire(itemguid)then
descText="出售"
end
self.winlua:SetChildText(self.btnText:getID(),descText)

self:showUse(item)
end

function UIItemUseTipWin:onHide()

end


local _selectDisciple=function(itemid,itemguid,num)
local cfg=itemsConfig.getConfig(itemid)
local useCount=num
local funcparam=table.deepCopy(cfg.funcparam)
funcparam.itemguid=itemguid
funcparam.itemid=itemid
local data={funcparam=funcparam,useCount=useCount}
UIManager:showWindow("UIItemSelectRecruitDiscipleWin",data)
end

local _selectBox=function(itemid,itemguid,num)
local cfg=itemsConfig.getConfig(itemid)
local useCount=num
local funcparam=table.deepCopy(cfg.funcparam)
funcparam.itemguid=itemguid
local data={funcparam=funcparam,useCount=useCount}
UIManager:showWindow("UIBoxSelectWin",data)
end

local _funParamsType=
{
[item_funtion_type.selectDisciple]=function(...)
_selectDisciple(...)
end,
[item_funtion_type.selectbox]=function(...)
_selectBox(...)
end,
[item_funtion_type.eMiJingItem]=function(...)
bagProtocolControl.req_use_item(...)
end,
[item_funtion_type.eGiftPack]=function(itemid,itemguid,num)
UIManager:showWindow('UIItemBuyGiftPackWin',{itemguid=itemguid})
end,
}

local _FirstUseTypeFunc={
[2]={
typefunc=function(itemid,itemguid)end,

[3]=function(itemid,itemguid)
local itemConfig=itemsConfig.getConfig(itemid)
if itemConfig.jump then
jumpManager:jump(itemConfig.jump)
else
bagProtocolControl.req_use_item_by_itemguid(itemguid)
end
end
}
}





function UIItemUseTipWin:onCloseBtn()
bagUseControl.noUseItem(self.itemguid)
self:closeSelf()
end



function UIItemUseTipWin:onUseBtn()
if self.itemguid==nil then return end
local itemguid=self.itemguid
local item=bagModel.getItem(itemguid)
if item==nil then
UIManager.info('该道具已使用')
self:moveNext()
return
end

local itemid=item.itemid
if not itemsLookup:checkUseItemCondition(itemid,nil)then
return
end

local isExpire=bagUseControl.isItemExpire(itemguid)
if isExpire then
UIManager:showWindow('UIItemExpireSellTipWin')
bagUseControl.openBatchSellHandle()
return
end
local itemConfig=itemsConfig.getConfig(itemid)
local getusetype=itemConfig.getusetype
local usetype=getusetype[1]
local useParams=getusetype[2]
local paramType=itemsLookup.getParamType(itemConfig)
local num=item.itemcount
local func=function()
if itemsConfig.isClothing(itemid)then
ClothingController.fastDressClothing(itemid,itemguid,num)
self:onCloseBtn()
else
if useParams then
local jumpParams=useParams.jump
self:onCloseBtn()
jumpManager:jump(jumpParams)
else
local func=_funParamsType[paramType]
if func then
func(itemid,itemguid,num)
elseif itemConfig.special_limit then
bagProtocolControl.reqReuseItem(itemguid)
self:moveNext()
elseif bagUseControl.checkOpenBatchUseWin(itemguid)then
UIManager:showWindow('UIItemBatchUseWin')
bagUseControl.openBatchUseHandle()
else
bagProtocolControl.req_use_item_by_itemguid(itemguid)
end
end
end
end
if usetype==ITEM_GET_USE_TYPE.eHighAsk then
local desc='该物品为高价值物品，是否确定使用？'
self.dialogue=UIDialogManager.getConfirmDialog(self.dialogue,'提示',desc)
self.dialogue.okcallback=func
self.dialogue:show()
elseif usetype==ITEM_GET_USE_TYPE.eUseAsk then
if itemConfig.typename=="道兵碎片"then
local has=itemsModel.getCount(itemid)
local need=daobingConfig.getCombineCnt(itemid)
local cnt=math.floor(has/need)
if cnt<1 then
local name=itemsModel.getName(itemid)
UIManager.error(FMT.fmt('{0}不足，无法合成',name))
else
daobingController.reqCombine(itemid,cnt)
self:onCloseBtn()
end
elseif itemConfig.typename=="地图"then
local count=0
local max=3
local func=_funParamsType[paramType]
local TreasureMapList=MysteryModel:getTreasureMapUseCount()
if TreasureMapList then
for k,v in pairs(TreasureMapList)do
if v then
count=count+1
end
end

if count>=max then
UIManager.info("大世界上藏宝图秘境已达到上限（3/3）")
return
end
end

if func then
func(itemid,1)
end
self:onCloseBtn()
else
func()
end
elseif usetype==ITEM_GET_USE_TYPE.eJustFirstAsk then
if itemsConfig.isClothing(itemid)then
func()
else
if useParams then
local jumpParams=useParams.jump
self:onCloseBtn()
jumpManager:jump(jumpParams)
elseif _FirstUseTypeFunc[itemConfig.type1]then
if _FirstUseTypeFunc[itemConfig.type1][itemConfig.type2]then
local firstfunc=_FirstUseTypeFunc[itemConfig.type1][itemConfig.type2]
firstfunc(itemid,itemguid)
elseif _FirstUseTypeFunc[itemConfig.type1].typefunc then
_FirstUseTypeFunc[itemConfig.type1].typefunc(itemid,itemguid)
else
error(FMT.fmt("快捷使用缺少客户端配置 查 UIItemUseTipWin _FirstUseTypeFunc {0}-{1}-{2}",itemid,itemConfig.type1,itemConfig.type2))
return
end
self:onCloseBtn()
else
error(FMT.fmt("itemid : {0},not has firstfunc",itemid))
end
end

end
end

function UIItemUseTipWin:moveNext(itemguid)
local itemguid=self.itemguid
self.itemguid=nil
self:setRootVis()
bagUseControl.clearAskUse(itemguid,true)
end

function UIItemUseTipWin:showUse(item)
self.itemguid=item.itemguid
self.itemid=item.itemid
self:setRootVis(true)
self:fillItem(self.itemguid)
end


function UIItemUseTipWin:setRootVis(vis)
if self.rootVis==vis then return end
self.rootVis=vis
self.root:setActive(vis)
end

function UIItemUseTipWin:fillItem(itemguid)
local isExpire=bagUseControl.isItemExpire(itemguid)
local item=bagModel.getItem(itemguid)
local itemid=item.itemid
local itemcount=item.itemcount
local colorEffect=not webGLHelper:isHidePunchAni()and not isExpire
local conf={itemid=itemid,itemcount=itemcount>1 and itemcount or'',showCountBG=itemcount>1,colorEffect=colorEffect}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
local index=self.UIBaseItemSmall:getID()
if isExpire then
prop[PropIndex(DataPropKey.eWidgetQualityEx,0)]=0
end
prop[PropIndex(DataPropKey.eWidgetGray,1)]=isExpire
self.winlua:SetChildPropData(index,prop)
self.winlua:SetBaseItemChildGUID(index,itemguid)
self.winlua:SetBaseItemClickEvent(index,itemsComponentHelper.onItemClick)
end

function UIItemUseTipWin:changeItemCount(item)
local prop={}
local itemcount=item.itemcount

prop[PropIndex(DataPropKey.eWidgetActive,2)]=itemcount>1
prop[PropIndex(DataPropKey.eWidgetText,3)]=itemcount>1 and itemcount or''
local index=self.UIBaseItemSmall:getID()
self.winlua:SetChildPropData(index,prop)
end

function UIItemUseTipWin:onUseItem(itemguid)
if tostring(itemguid)~=tostring(self.itemguid)then return end
local item=bagModel.getItem(itemguid)
if item then
self:changeItemCount(item)
else
self:moveNext()
end
end

function UIItemUseTipWin:onUseItemid(itemid)
if self.itemid~=itemid then return end
local item=bagModel.getItem(self.itemguid)
if item then
self:changeItemCount(item)
else
self:moveNext()
end
end

function UIItemUseTipWin:onSelect(itemid)
if self.itemid~=itemid then return end
local item=bagModel.getItem(self.itemguid)
if item then
self:changeItemCount(item)
else
self:moveNext()
end
end

function UIItemUseTipWin:on_item_list_changed(array,lookup_guidStr)
local itemguidStr_=tostring(self.itemguid)

local item=bagModel.getItemByStr(itemguidStr_)
if item==nil then
self:moveNext()
return
end

local itemdata=lookup_guidStr[itemguidStr_]
if itemdata then
local changeType=itemdata[1]
local itemguidStr=itemdata[6]
if changeType==CHANGE_TYPE.eChanged and itemguidStr==itemguidStr_ or changeType==CHANGE_TYPE.eDelete then
if item~=nil then
self:changeItemCount(item)
else
self:moveNext()
end
end
end
end
