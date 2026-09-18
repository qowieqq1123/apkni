







def_class("YYHYEquipGainWin",UIWindowBase)









function YYHYEquipGainWin:bindComponents()

self.root=UIObject.get(self,0)
self.filterPage=UIObject.get(self,1)
self.gainPage=UIObject.get(self,2)
self.dressToggle=UIToggleButton.get(self,3)
self.gainScrollView=UIScrollView.get(self,4)
self.gainTitle=UIText.get(self,5)
self.bagEndLine=UIObject.get(self,6)
self.bagLine=UIObject.get(self,7)
self.bagScrollView=UIScrollViewSlow.get(self,8)
self.canEquipTitle=UIText.get(self,9)
self.title=UIText.get(self,10)
self.equipLine=UIObject.get(self,11)
self.dressToggleText=UIText.get(self,12)
self.Dropdown1=UIDropdownEx.get(self,13)
self.Dropdown2=UIDropdownEx.get(self,14)
self.nameText=UIText.get(self,15)
self.bagPage=UIObject.get(self,16)
self.equipItem=UIBaseItem.get(self,17)
self.unEquipTitle=UIObject.get(self,18)
self.Item_Label=UIText.get(self,19)



end


function YYHYEquipGainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.filterPage);self.filterPage=nil;
_UIObject_release(self.gainPage);self.gainPage=nil;
_UIObject_release(self.dressToggle);self.dressToggle=nil;
_UIObject_release(self.gainScrollView);self.gainScrollView=nil;
_UIObject_release(self.gainTitle);self.gainTitle=nil;
_UIObject_release(self.bagEndLine);self.bagEndLine=nil;
_UIObject_release(self.bagLine);self.bagLine=nil;
_UIObject_release(self.bagScrollView);self.bagScrollView=nil;
_UIObject_release(self.canEquipTitle);self.canEquipTitle=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.equipLine);self.equipLine=nil;
_UIObject_release(self.dressToggleText);self.dressToggleText=nil;
_UIObject_release(self.Dropdown1);self.Dropdown1=nil;
_UIObject_release(self.Dropdown2);self.Dropdown2=nil;
_UIObject_release(self.nameText);self.nameText=nil;
_UIObject_release(self.bagPage);self.bagPage=nil;
_UIObject_release(self.equipItem);self.equipItem=nil;
_UIObject_release(self.unEquipTitle);self.unEquipTitle=nil;
_UIObject_release(self.Item_Label);self.Item_Label=nil;
end

















local _this


function YYHYEquipGainWin:onLoaded(...)
_this=self
self:bindComponents()
self.bagScrollView:setSlowClickAction(function(...)self:onBagItemClick(...)end)

UIManager:showWindow('UIDialgueBackPanel')
self.bagScrollView:bindSlowWidget(function(...)
self:fillBagData(...)
end)
end


function YYHYEquipGainWin:__delete()
self:unbindComponents()
end




function YYHYEquipGainWin:onShow(argtable,afterOnloaded)

end


function YYHYEquipGainWin:onHide()

end


function UIEquipGainWin:fillBagData(index,widget)
local itemInfo=self.filterBagList[index]
if itemInfo==nil then return end
local count=itemInfo.itemcount
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local diziguid=0
local itemData=itemInfo.itemData or{}
local name=''
local fightStr=''
local jinglianStr=''
local hasEquiped=false
local iconName
local stage=itemConfig.stage
local showStage=stage~=nil
local stageTitile=itemsConfig.getStageName(itemid)
local star=0
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
if itemsConfig.isEquip(itemid)then
local suitid=itemInfo.itemData and itemInfo.itemData.suitid or 0
local suitConfig=equipsConfig.getSuitConfig(suitid)
local suitName=suitConfig and FMT.fmt('[{0}]',suitConfig.name)or''
name=FMT.fmt('{0}{1}',suitName,itemsModel.getNameByItem(itemInfo))
fightStr=equipsHelper.getEquipFightX(itemid,itemguid)
local jinglianlv=itemsConfig.isEquip(itemid)and itemData.jinglianlv
jinglianStr=(jinglianlv and jinglianlv>0)and FMT.fmt('+{0}',jinglianlv)or''
diziguid=equipsModel.getDiziguidByItemguid(itemguid)
iconName=iconHelper.getIconName(itemid)
elseif itemsConfig.isFabao(itemid)then
name=itemInfo.itemData.name or''
fightStr=fabaoHelper.getBaseFight(itemid,itemguid)
diziguid=fabaoModel.getDiziguidByItemguid(itemguid)
iconName=itemsModel.getIconName(itemInfo)
local jinglianlv=itemInfo.itemData and itemInfo.itemData.jilianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
elseif itemsConfig.isDaoBing(itemid)then
name=itemConfig.name
fightStr=daobingHelper.getEquipFightX(itemid,itemguid)
iconName=iconHelper.getIconName(itemid)
diziguid=daobingModel:getDiziguidByItemguid(itemguid)
local jinglianlv=daobingModel:getJilianLv(itemguid)
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
star=daobingModel:getStarLv(itemguid)
stageStr=''
end
hasEquiped=diziguid~=nil
local isSelect=self.selectguid==itemguid
name=FMT.cfmt(color,name)

widgetHelper.setItemQulaity(widget,itemid,0)
widget:SetChildIcon(1,iconName,false)
widget:SetChildText(2,stageStr)
widget:SetChildText(3,name)
widget:SetChildText(4,fightStr)
widget:SetChildActive(5,isSelect)
widget:SetChildActive(6,hasEquiped)
widget:SetChildText(8,jinglianStr)
widget:SetChildActive(9,stageStr~='')
widget:SetChildActive(10,jinglianStr~='')
widget:SetChildStarNumber(11,star)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)

if hasEquiped then
comHelper.setChildModelRawImage(widget,diziguid,7,0,eHeadCenterType.eHead,0.6)
end
end


function UIEquipGainWin:refreshData()
local cfg=cfgHelper.get1(cfg_targetactivity1config_get,self.subId)
local rewards=cfg.grouprewards[self.groupId].rewards

local list
local len=#list
self.rwScrollView2:setChildScrollViewCreateGrids(len,1)
local grids=self.rwScrollView2:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]

local itemid


item:SetChildButtonClick(-1,function()
_this:onBagItemClick(itemid)
end)
end
end


function YYHYEquipGainWin:onBagItemClick(id,index,guid,attach)
self:onSelectItem(id,guid)
end


function YYHYEquipGainWin:onSelectItem(id,guid)
if self.selectguid==guid then return end
local oldguid=self.selectguid
self.selectguid=guid
local item=self.item
local itemguid
if item then itemguid=item.itemguid end
self.isSelectEquip=guid==itemguid
self.equipItem:setChildItemDataByDataPropKey(DataPropKey.eWidgetActive,5,itemguid==guid)
if oldguid then
self.bagScrollView:freshSlowItemByGUID(oldguid)
end
self.bagScrollView:freshSlowItemByGUID(guid)
self:freshEquipPage()

tipsManager.showTips({itemid=id})
end


function YYHYEquipGainWin:showTips(itemid,itemguid)
self.movepos=TIPS_MOVE_POS.eLeft
local backType=TIPS_BACK_TYPE.eNone
tipsManager.showTips({formType=TIPS_FORM_TYPE.eEquipListWin,
itemid=itemid,
itemguid=itemguid,
showModel=false,
movepos=TIPS_MOVE_POS.eRight,
backType=backType,
attach={diziguid=self.diziguid}})
self:doAni()
self.isShowTips=true
end


