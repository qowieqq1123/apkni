







def_class("UIDiscipleBagComponent",UIWindowBase)









function UIDiscipleBagComponent:bindComponents()

self.List=UIScrollView.get(self,0)
self.Help=UIButton.get(self,1)
self.Give=UIButton.get(self,2)
self.noCheckTips=UIObject.get(self,3)
self.Num=UIText.get(self,4)
self.Content=UIObject.get(self,5)

self.Help:setButtonClick(function()self:onHelp()end)

self.Give:setButtonClick(function()self:onGive()end)



end


function UIDiscipleBagComponent:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.List);self.List=nil;
_UIObject_release(self.Help);self.Help=nil;
_UIObject_release(self.Give);self.Give=nil;
_UIObject_release(self.noCheckTips);self.noCheckTips=nil;
_UIObject_release(self.Num);self.Num=nil;
_UIObject_release(self.Content);self.Content=nil;
end
















local col=4

local itemConf={

showname=false,
showcount=false,
showStageBg=true,
}

local _this=nil




function UIDiscipleBagComponent:onLoaded(...)
self:bindComponents()




notifySystem:listenNotify(notifyConfig.onDiscipleBagAddItem,self.onDiscipleBagAddItem)
notifySystem:listenNotify(notifyConfig.onDiscipleBagDeleteItem,self.onDiscipleBagDeleteItem)
notifySystem:listenNotify(notifyConfig.onDiscipleLoyaltyChange,self.onDiscipleLoyaltyChange)
_this=self

self:onInit()
end


function UIDiscipleBagComponent:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.onDiscipleBagAddItem,self.onDiscipleBagAddItem)
notifySystem:removelistener(notifyConfig.onDiscipleBagDeleteItem,self.onDiscipleBagDeleteItem)
notifySystem:removelistener(notifyConfig.onDiscipleLoyaltyChange,self.onDiscipleLoyaltyChange)
_this=nil
self.disciple_guid=nil
end




function UIDiscipleBagComponent:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid
self.itemDatas=UIDiscipleModel:getDiscipleBagShowList(self.disciple_guid)

local loyalty=UIDiscipleModel:getDiscipleLoyalty(self.disciple_guid)
local loyalty_str=FMT.fmt("忠诚度：{0}",loyalty)
if UIDiscipleModel:checkLowLoyalty(self.disciple_guid)then
loyalty_str=FMT.fmt('<color=#FF5757>{0}</color>',loyalty_str)
end
self.Num:setText(loyalty_str)

local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
self.notCheck=dzSpecialitySpecialEffectController:getChuWuDaiNotCheck(netData)
self.noCheckTips:setActive(self.notCheck)

self:refreshList(afterOnloaded)
end


function UIDiscipleBagComponent:onHide()
self.List:setActive(false)
end



function UIDiscipleBagComponent:onInit()
self.max=cfgHelper.get2(cfg_globalconfig_get,1,"disciplebagnum")
end

function UIDiscipleBagComponent:onClickNoCheck(index)
UIManager.error('该弟子无法查看物品')
end

function UIDiscipleBagComponent:onClickList(itemid,index,itemguid,attach)
if itemid==nil or itemid==-1 then return end
if self.notCheck then
UIManager.error('该弟子无法查看物品')
return
end
local itemCfg=itemsConfig.getConfig(itemid)
if itemCfg.loyal_conf and itemCfg.loyal_conf[2]then
local reduceValue=itemCfg.loyal_conf[2]
local tipsArgs={

formType=TIPS_FORM_TYPE.eDiscipleBag,
itemid=itemid,
itemguid=itemguid,
attach={
disciple_guid=self.disciple_guid,
desc=FMT.fmt("<size=20><color=#FD8950FF>收缴减少忠诚度：{0}</color></size>",reduceValue)
},
btnsList={TIPS_BTNS_TYPE.eTakeDiscipleReward},
move=TIPS_MOVE_POS.eCenter,



}
tipsManager.showTips(tipsArgs)
end
end

function UIDiscipleBagComponent:onHelp()
local d={}
d.mode=3
d.name='discipleBag_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIDiscipleBagComponent:onGive()
if self.notCheck then
UIManager.error('该弟子不可赏赐物品')
return
end
local args={}
args.titleName="可赏赐物品"
args.pos=2
args.extraWin='UIDiscipleGiveRewardDialog'
local extraParams={guid=self.disciple_guid}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIDiscipleBagComponent.onDiscipleBagAddItem(guid,items)
if mathHelper.compareInt64(guid,_this.disciple_guid)then
for i,v in ipairs(items)do
table.insert(_this.itemDatas,v)
end
table.sort(_this.itemDatas,itemsSortHelper.sortItemsArrayByColor)

_this:refreshList(false)
end
end

function UIDiscipleBagComponent.onDiscipleBagDeleteItem(guid,item)
if mathHelper.compareInt64(guid,_this.disciple_guid)then
local remove=nil
local cnt=#_this.itemDatas
for i=cnt,1,-1 do
local v=_this.itemDatas[i]
if v==item then
remove=i
break
end
end

if remove then
table.remove(_this.itemDatas,remove)
local endIndex=cnt<=_this.max and cnt or _this.max
for i=remove,endIndex do
_this:refreshListItem(i)
end
end
end
end

function UIDiscipleBagComponent.onDiscipleLoyaltyChange(guid,oldValue,newValue)
if mathHelper.compareInt64(guid,_this.disciple_guid)then
_this.Num:setText(FMT.fmt("忠诚度：{0}",newValue))
end
end

function UIDiscipleBagComponent:getRecyleData()
if not self.fillProp then
self.fillProp=itemsComponentHelper.getTempFillData({})
self.fillProp[PropIndex(DataPropKey.eWidgetIcon,3)]=""
self.fillProp[PropIndex(DataPropKey.eWidgetActive,9)]=false
end
return self.fillProp
end

function UIDiscipleBagComponent:refreshList(init)
self.List:setActive(true)
if init then
self.Content:setChildLayoutGroupCreateItems(self.max,function(index)
self:refreshListItem(index,true)
end)
else
for i=1,self.max do
self:refreshListItem(i)
end
end
end

function UIDiscipleBagComponent:refreshListItem(index,click)
local item=self.Content:getChildLayoutGroupGridItem(index-1)
local itemid=self.itemDatas[index]
if itemid and itemid>0 then
if self.notCheck then
local propData=self:getRecyleData()
item:SetChildPropData(0,propData)
item:SetChildActive(1,true)
else
local itemData={itemid=itemid}
local dataProp=itemsComponentHelper.getCommonFillData(itemData,itemConf)
item:SetChildPropData(0,dataProp)
item:SetChildActive(1,false)
end
else
local propData=self:getRecyleData()
item:SetChildPropData(0,propData)
item:SetChildActive(1,false)
end
if click then
item:SetBaseItemClickEvent(0,function(...)
self:onClickList(...)
end)
item:SetChildButtonClick(1,function()
self:onClickNoCheck(index)
end)
end
end