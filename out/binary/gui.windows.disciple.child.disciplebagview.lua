







def_class("discipleBagView",UICloneObject)





discipleBagView.abName="ui/windows/disciple/child/disciplebagview.ab"

discipleBagView.assetName="discipleBagView"

local col=4

local itemConf={

showname=false,
showcount=false,
}

local _this=nil










function discipleBagView:bindComponents()

self.List=UIScrollView.get(self,0)
self.Num=UIText.get(self,1)
self.Help=UIButton.get(self,2)
self.Give=UIButton.get(self,3)

self.List:setClickAction(function(...)self:onClickList(...)end)
self.List:setRecyleData(self:getRecyleData())

self.Help:setButtonClick(function()self:onHelp()end)

self.Give:setButtonClick(function()self:onGive()end)

end


function discipleBagView:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.List);self.List=nil;
_UIObject_release(self.Num);self.Num=nil;
_UIObject_release(self.Help);self.Help=nil;
_UIObject_release(self.Give);self.Give=nil;
end









function discipleBagView:onLoaded(...)
self:bindComponents()
notifySystem:listenNotify(notifyConfig.onDiscipleBagAddItem,self.onDiscipleBagAddItem)
notifySystem:listenNotify(notifyConfig.onDiscipleBagDeleteItem,self.onDiscipleBagDeleteItem)
notifySystem:listenNotify(notifyConfig.onDiscipleLoyaltyChange,self.onDiscipleLoyaltyChange)
_this=self

self:onInit()
end


function discipleBagView:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.onDiscipleBagAddItem,self.onDiscipleBagAddItem)
notifySystem:removelistener(notifyConfig.onDiscipleBagDeleteItem,self.onDiscipleBagDeleteItem)
notifySystem:removelistener(notifyConfig.onDiscipleLoyaltyChange,self.onDiscipleLoyaltyChange)
_this=nil
self.disciple_guid=nil
end




function discipleBagView:onShow(argtable,afterOnloaded)

if argtable.force or self.disciple_guid~=argtable.guid then
self.disciple_guid=argtable.guid
self.itemDatas=UIDiscipleModel:getDiscipleBagShowList(self.disciple_guid)
local dataProps={}
for i,v in ipairs(self.itemDatas)do
local itemData={itemid=v}
table.insert(dataProps,itemsComponentHelper.getCommonFillData(itemData,itemConf))
end
self.List:setPropData(0,dataProps)
self.List:clearItem(#dataProps,self.max-1)

local loyalty=UIDiscipleModel:getDiscipleLoyalty(self.disciple_guid)
self.Num:setText(FMT.fmt("忠诚度：{0}",loyalty))
end
end


function discipleBagView:onHide()

end




function discipleBagView:onInit()
self.max=cfgHelper.get2(cfg_globalconfig_get,1,"disciplebagnum")
self.row=math.ceil(self.max/col)

self.List:freshGridsNum(self.max,self.row,col,false)
end

function discipleBagView:onClickList(itemid,index,itemguid,attach)
if itemid==nil or itemid==-1 then return end
local itemCfg=itemsConfig.getConfig(itemid)
if itemCfg.loyal_conf and itemCfg.loyal_conf[2]then
local reduceValue=itemCfg.loyal_conf[2]
local tipsArgs={
tipsType=TIPS_TYPE.eCommonItem,
formType=TIPS_FORM_TYPE.eBagGrids,
itemid=itemid,
itemguid=itemguid,
attach=self.disciple_guid,
btnsList={TIPS_BTNS_TYPE.eTakeDiscipleReward},



}
tipsManager.showTips(tipsArgs)
end
end

function discipleBagView:onHelp()
local d={}
d.title='弟子背包介绍'
d.mode=3
d.name='discipleBag_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function discipleBagView:onGive()
local args={}
args.titleName="可赏赐物品"
args.pos=2
args.extraWin='UIDiscipleGiveRewardDialog'
local extraParams={guid=self.disciple_guid}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function discipleBagView.onDiscipleBagAddItem(guid,items)
if guid==_this.disciple_guid then
for i,v in ipairs(items)do
table.insert(_this.itemDatas,v)
end
table.sort(_this.itemDatas,itemsSortHelper.sortItemsArrayByColor)

local dataProps={}
for i,v in ipairs(_this.itemDatas)do
local itemData={itemid=v}
table.insert(dataProps,itemsComponentHelper.getCommonFillData(itemData,itemConf))
end
_this.List:setPropData(0,dataProps)
end
end

function discipleBagView.onDiscipleBagDeleteItem(guid,item)
if guid==_this.disciple_guid then
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
cnt=cnt-1
local dataProps={}
for i=remove,#_this.itemDatas do
local v=_this.itemDatas[i]
local itemData={itemid=v}
table.insert(dataProps,itemsComponentHelper.getCommonFillData(itemData,itemConf))
end
_this.List:setPropData(remove-1,dataProps)
_this.List:clearItem(cnt,self.max-1)
end
end
end

function discipleBagView.onDiscipleLoyaltyChange(guid,oldValue,newValue)
if guid==_this.disciple_guid then
_this.Num:setText(FMT.fmt("忠诚度：{0}",newValue))
end
end

function discipleBagView:getRecyleData()
return itemsComponentHelper.getTempFillData({})
end
