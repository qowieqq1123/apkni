







def_class("UIDiscipleGiveRewardDialog",UIWindowBase)









function UIDiscipleGiveRewardDialog:bindComponents()

self.ScrollView=UIScrollView.get(self,0)
self.Num=UIText.get(self,1)
self.Delta=UIText.get(self,2)
self.Give=UIButton.get(self,3)

self.Give:setButtonClick(function()self:onGive()end)



end


function UIDiscipleGiveRewardDialog:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.Num);self.Num=nil;
_UIObject_release(self.Delta);self.Delta=nil;
_UIObject_release(self.Give);self.Give=nil;
end
















local _col=4
local _min_row=1
local _this=nil

local sortFunc=function(a,b)
local aCfg=itemsConfig.getConfig(a.itemid)
local bCfg=itemsConfig.getConfig(b.itemid)
if aCfg.color==bCfg.color then
return a.itemid>b.itemid
else
return aCfg.color>bCfg.color
end
end




function UIDiscipleGiveRewardDialog:onLoaded(...)
self:bindComponents()

self.ScrollView:setClickAction(function(...)self:onClickItem(...)end)
self.ScrollView:setRecyleData(self:getRecyleData())
self.ScrollView:setLongTouchAction(function(...)self:onLongTouchItem(...)end)

notifySystem:listenNotify(notifyConfig.onDiscipleLoyaltyChange,self.onDiscipleLoyaltyChange)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
_this=self
self.selecteds={}
self.selectCnt=0
self.loyaltyDelta=0
self.loyaltyBase=0
self.maxGrid=0
end


function UIDiscipleGiveRewardDialog:__delete()
self:unbindComponents()

notifySystem:removelistener(notifyConfig.onDiscipleLoyaltyChange,self.onDiscipleLoyaltyChange)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)

_this=nil
self.selecteds={}
self.selectCnt=0
self.loyaltyDelta=0
self.loyaltyBase=0
self.maxGrid=0
end




function UIDiscipleGiveRewardDialog:onShow(argtable,afterOnloaded)
if argtable then
self.parentWin=argtable.parentWin
self.disciple_guid=argtable.guid
self.limit=cfgHelper.get2(cfg_globalconfig_get,1,"disciplebagnum")-UIDiscipleModel:getDiscipleBagCount(self.disciple_guid)

self.items={}
local bagTypes={BAG_TYPE.eItemBag,BAG_TYPE.eMaterialsBag,BAG_TYPE.eEquipBag}
for i,bagType in ipairs(bagTypes)do
local list=bagControl.getBagItems(bagType)
for i2,v in ipairs(list)do
local itemCfg=itemsConfig.getConfig(v.itemid)
if itemCfg.loyal_conf and itemCfg.loyal_conf[1]then
table.insert(self.items,v)
end
end
end

table.sort(self.items,sortFunc)


local cnt=#self.items
local propDatas={}
for i,v in ipairs(self.items)do
local item_conf={

select=self.selecteds[tostring(v.itemgui)]~=nil,
showcount=v.itemcount>1,
showCountBG=true,
showname=false,
showStageBg=true,
}
local propData=itemsComponentHelper.getCommonFillData(v,item_conf)
table.insert(propDatas,propData)
end

local row=math.max(math.ceil(cnt/_col),_min_row)
self.maxGrid=row*_col

self.ScrollView:freshGridsNum(self.maxGrid,row,_col,false)
self.ScrollView:setPropData(0,propDatas)
self.ScrollView:clearItem(#propDatas,self.maxGrid-1)

self:setBaseNum()
self:setDeltaNum()
end
end


function UIDiscipleGiveRewardDialog:onHide()

end





function UIDiscipleGiveRewardDialog:onGive()
local itemIDs={}
for i,v in pairs(self.selecteds)do
local good=self.items[v]
local item=bagControl.invokeFuncByItemId(good.itemid,'getItem',i)
if item then
table.insert(itemIDs,item.itemid)
end
end

if#itemIDs<=0 then
return UIManager.error("尚未选择物品")
end

if self.selectCnt>self.limit then
return UIManager.error("弟子储物袋无法收纳过多物品")
end

UIDiscipleController:requireGiveDiscipleReward(self.disciple_guid,itemIDs)

self:clearAllSelected()

self:onClickClose()
end


function UIDiscipleGiveRewardDialog:onClickClose()
self.parentWin:onCloseClick()
end

function UIDiscipleGiveRewardDialog:onClickItem(itemid,index,itemguid,attach)


local itemCfg=itemsConfig.getConfig(itemid)
local key=tostring(itemguid)
local have=self.selecteds[key]~=nil
if itemCfg.loyal_conf and itemCfg.loyal_conf[1]then
local addValue=itemCfg.loyal_conf[1]
if have then
self.selecteds[key]=nil
self.selectCnt=self.selectCnt-1
self.loyaltyDelta=self.loyaltyDelta-addValue
else
if self.selectCnt>=self.limit then
return UIManager.error("已超过弟子的储物袋空间")
end

self.selecteds[key]=index
self.selectCnt=self.selectCnt+1
self.loyaltyDelta=self.loyaltyDelta+addValue
end

self:setItemSelect(index-1,not have)
self:setDeltaNum()
end
end

function UIDiscipleGiveRewardDialog:onLongTouchItem(itemid,index,itemguid,attach)

if itemid==nil or itemid==-1 then return end
local itemCfg=itemsConfig.getConfig(itemid)
if itemCfg.loyal_conf and itemCfg.loyal_conf[1]then
local addValue=itemCfg.loyal_conf[1]
local tipsArgs={

formType=TIPS_FORM_TYPE.eDiscipleBag,
itemid=itemid,
itemguid=itemguid,
attach={
disciple_guid=self.disciple_guid,
desc=FMT.fmt("<size=20><color=#FD8950FF>赏赐增加忠诚度：{0}</color></size>",addValue)
},
btnsList={TIPS_BTNS_TYPE.eGiveDiscipleReward},
move=TIPS_MOVE_POS.eCenter,



}

tipsManager.showTips(tipsArgs)
end
end

function UIDiscipleGiveRewardDialog:setBaseNum(value)
self.loyaltyBase=value or UIDiscipleModel:getDiscipleLoyalty(self.disciple_guid)
self.Num:setText(FMT.fmt("弟子忠诚度：{0}",self.loyaltyBase))
end

function UIDiscipleGiveRewardDialog:setDeltaNum()
local showDelta=math.min(cfgHelper.get2(cfg_discipleloyaltyconfig_get,1,'max')-self.loyaltyBase,self.loyaltyDelta)
local deltaTx=next(self.selecteds)~=nil and FMT.cfmt(FONT_COLOR.eGreenColor,"(+{0})",showDelta)or""
self.Delta:setText(deltaTx)
end

function UIDiscipleGiveRewardDialog:setItemSelect(index,isSelect)
self.ScrollView:freshItem(index,PropIndex(DataPropKey.eWidgetActive,1),isSelect)
end

function UIDiscipleGiveRewardDialog.onDiscipleLoyaltyChange(guid,oldValue,newValue)
_this:setBaseNum(newValue)
end

function UIDiscipleGiveRewardDialog.on_item_changed(changeType,itemguid,itemid,oldVal,newVal)

local itemCfg=itemsConfig.getConfig(itemid)
if itemCfg.loyal_conf then
local index=_this:findItemIndex(itemguid)

if changeType==CHANGE_TYPE.eChanged then
if index then
_this.items[index].itemcount=newVal
_this.ScrollView:freshItem(index-1,PropIndex(DataPropKey.eWidgetText,4),newVal)
end
elseif changeType==CHANGE_TYPE.eDelete then
if index then
_this.selecteds[tostring(itemguid)]=nil
_this.selectCnt=_this.selectCnt-1

table.remove(_this.items,index)
local propDatas={}
for i=index,#_this.items do
local v=_this.items[i]
local item_conf={

select=_this.selecteds[tostring(v.itemgui)]~=nil,
showname=false,
}
local propData=itemsComponentHelper.getCommonFillData(v,item_conf)
table.insert(propDatas,propData)
end
_this.ScrollView:setPropData(index-1,propDatas)
_this.ScrollView:clearItem(#propDatas,_this.maxGrid-1)
end
elseif changeType==CHANGE_TYPE.eAdd then
if not index then
table.insert(_this.items,itemBagModel:getItem(itemguid))
table.sort(_this.items,sortFunc)
local cnt=#_this.items
if cnt>_this.maxGrid then
local row=math.max(math.ceil(cnt/_col),_min_row)
_this.maxGrid=row*_col
_this.ScrollView:freshGridsNum(_this.maxGrid,row,_col,false)
end

local propDatas={}
for i,v in ipairs(_this.items)do
local item_conf={

select=_this.selecteds[tostring(v.itemgui)]~=nil,
showname=false,
}
local propData=itemsComponentHelper.getCommonFillData(v,item_conf)
table.insert(propDatas,propData)
end
_this.ScrollView:setPropData(0,propDatas)
_this.ScrollView:clearItem(#propDatas,_this.maxGrid-1)
end
end
end
end

function UIDiscipleGiveRewardDialog:findItemIndex(itemguid)
for i,v in ipairs(_this.items)do
if itemguid==v.itemguid then
return i
end
end
end

function UIDiscipleGiveRewardDialog:getRecyleData()
local prop=itemsComponentHelper.getTempFillData({})
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
return prop
end

function UIDiscipleGiveRewardDialog:clearAllSelected()
for i,v in pairs(self.selecteds)do
self.ScrollView:freshItem(v,PropIndex(DataPropKey.eWidgetActive,1),false)
end
self.selecteds={}
self.selectCnt=0
end
