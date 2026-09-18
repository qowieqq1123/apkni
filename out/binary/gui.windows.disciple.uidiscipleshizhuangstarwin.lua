







def_class("UIDiscipleShiZhuangStarWin",UIWindowBase)









function UIDiscipleShiZhuangStarWin:bindComponents()

self.btnReset=UIButton.get(self,0)
self.btnStar=UIButton.get(self,1)
self.btnYuHua=UIButton.get(self,2)
self.collect=UIObject.get(self,3)
self.collectstar=UIObject.get(self,4)
self.collectupAttr=UIText.get(self,5)
self.collectupTitle=UIObject.get(self,6)
self.Content=UIObject.get(self,7)
self.dizi=UIButton.get(self,8)
self.dzbg=UIImage.get(self,9)
self.dzhead=UIObject.get(self,10)
self.dzname=UIText.get(self,11)
self.effect=UIObject.get(self,12)
self.jlTab=UIObject.get(self,13)
self.maxStar=UIText.get(self,14)
self.maxStarImg=UIObject.get(self,15)
self.model=UIObject.get(self,16)
self.modelbg=UIObject.get(self,17)
self.modelClick=UIButton.get(self,18)
self.name=UIImage.get(self,19)
self.root=UIObject.get(self,20)
self.ScrollView=UIScrollViewSlow.get(self,21)
self.star=UIObject.get(self,22)
self.starAttr_1=UIObject.get(self,23)
self.starAttr_2=UIObject.get(self,24)
self.starAttr_3=UIObject.get(self,25)
self.starAttr_4=UIObject.get(self,26)
self.starAttr_5=UIObject.get(self,27)
self.starAttr_6=UIObject.get(self,28)
self.starAttr_7=UIObject.get(self,29)
self.starAttr_8=UIObject.get(self,30)
self.starAttr_9=UIObject.get(self,31)
self.starCostTitle=UIText.get(self,32)
self.stardesc=UIText.get(self,33)
self.starItem=UIBaseItem.get(self,34)
self.starItemCreater=UIObject.get(self,35)
self.starPanel=UIObject.get(self,36)
self.starTab=UIObject.get(self,37)
self.starTitle=UIText.get(self,38)
self.titleName=UIImage.get(self,39)
self.upTitle=UIObject.get(self,40)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.btnStar:setButtonClick(function()self:onBtnStar()end)

self.btnYuHua:setButtonClick(function()self:onBtnYuHua()end)

self.dizi:setButtonClick(function()self:onDizi()end)

self.modelClick:setButtonClick(function()self:onModelClick()end)
self.starAttr={
self.starAttr_1,
self.starAttr_2,
self.starAttr_3,
self.starAttr_4,
self.starAttr_5,
self.starAttr_6,
self.starAttr_7,
self.starAttr_8,
self.starAttr_9,
}



end


function UIDiscipleShiZhuangStarWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.btnStar);self.btnStar=nil;
_UIObject_release(self.btnYuHua);self.btnYuHua=nil;
_UIObject_release(self.collect);self.collect=nil;
_UIObject_release(self.collectstar);self.collectstar=nil;
_UIObject_release(self.collectupAttr);self.collectupAttr=nil;
_UIObject_release(self.collectupTitle);self.collectupTitle=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.dizi);self.dizi=nil;
_UIObject_release(self.dzbg);self.dzbg=nil;
_UIObject_release(self.dzhead);self.dzhead=nil;
_UIObject_release(self.dzname);self.dzname=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.jlTab);self.jlTab=nil;
_UIObject_release(self.maxStar);self.maxStar=nil;
_UIObject_release(self.maxStarImg);self.maxStarImg=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.modelbg);self.modelbg=nil;
_UIObject_release(self.modelClick);self.modelClick=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.star);self.star=nil;
_UIObject_release(self.starAttr_1);self.starAttr_1=nil;
_UIObject_release(self.starAttr_2);self.starAttr_2=nil;
_UIObject_release(self.starAttr_3);self.starAttr_3=nil;
_UIObject_release(self.starAttr_4);self.starAttr_4=nil;
_UIObject_release(self.starAttr_5);self.starAttr_5=nil;
_UIObject_release(self.starAttr_6);self.starAttr_6=nil;
_UIObject_release(self.starAttr_7);self.starAttr_7=nil;
_UIObject_release(self.starAttr_8);self.starAttr_8=nil;
_UIObject_release(self.starAttr_9);self.starAttr_9=nil;
_UIObject_release(self.starCostTitle);self.starCostTitle=nil;
_UIObject_release(self.stardesc);self.stardesc=nil;
_UIObject_release(self.starItem);self.starItem=nil;
_UIObject_release(self.starItemCreater);self.starItemCreater=nil;
_UIObject_release(self.starPanel);self.starPanel=nil;
_UIObject_release(self.starTab);self.starTab=nil;
_UIObject_release(self.starTitle);self.starTitle=nil;
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.upTitle);self.upTitle=nil;
self.starAttr=nil;
end



















local _colomn=1
local _menu_slot_name='button_dytab'


function UIDiscipleShiZhuangStarWin:onLoaded(...)
self:bindComponents()

self.ScrollView:setSlowClickAction(function(...)self:onClickGrid(...)end)
self.ScrollView:bindSlowWidget(function(...)
self:bindGrid(...)
end)

self:addNotify(notifyConfig.on_item_list_changed,function(...)self:onItemsChanged(...)end)
self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChanged(...)end)
self.selectBentiList={}
self.sortType=1
self.sortOrder=eSortOrder.eDown
self.needFocus=true

self.modelbg:setChildUIModelShowTarget(4869,1,{},eAnimationID.enter,false,false)
end


function UIDiscipleShiZhuangStarWin:__delete()
self:unbindComponents()
UIManager:closeWindow('UITopMoneyWin2')
end




function UIDiscipleShiZhuangStarWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
local tween=self.root:setChildCanvasGroupDOFade(1,0.25)
tween:SetDelay(0.25)
local tabType=argtable and argtable.tabType or SEC_FULL_TAB_TYPE.discipleClothingStarUp
local itemguid=argtable and argtable.itemguid or self.bagList[1]
self.tabType=tabType
self.itemguid=itemguid
self:freshInfo()
end


function UIDiscipleShiZhuangStarWin:onHide()

end

function UIDiscipleShiZhuangStarWin:freshInfo()
self.selectBentiList={}
local money=tabScreenConfig.getTabMoneyByConfig(self.tabType)
UIManager:showWindow('UITopMoneyWin2',money)
self:freshBtns()
self:freshLeftPanel()
self:freshMidPanel()
self:freshRightPanel()
end

function UIDiscipleShiZhuangStarWin:freshBtns()
local widget2=self.starTab:getChildWidgetBase()

local ret=ClothingHelper.isMaxStarByGUID(self.itemguid)


widget2:SetChildActive(2,ret)
widget2:SetChildButtonClick(3,function()
self:onSelectTab(SEC_FULL_TAB_TYPE.discipleClothingStarUp)
end,true)
end

function UIDiscipleShiZhuangStarWin:onSelectTab(tabType)
if tabType==self.tabType then return end
self.tabType=tabType
local money=tabScreenConfig.getTabMoneyByConfig(self.tabType)
UIManager:showWindow('UITopMoneyWin2',money)

self:freshRightPanel()
end

function UIDiscipleShiZhuangStarWin:freshRightPanel()
local visStar=self.tabType==SEC_FULL_TAB_TYPE.discipleClothingStarUp
self.starPanel:setActive(visStar)
if visStar then
self:freshStarPanel()
end
end

function UIDiscipleShiZhuangStarWin:freshStarPanel()
local itemguid=self.itemguid
local equip=ClothingHelper.getEquip(itemguid)
local itemid=equip.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local maxlv=ClothingConfig.getStarMaxLv(itemid)
local starlv=ClothingModel:getStarLv(itemguid)or 0
local isMax=maxlv==starlv
local starCfg=ClothingHelper.getStarAttrs(itemCfg)
local starlvCfg=starCfg[starlv]

local hasUpMax=itemCfg.item

local nextLv=(hasUpMax or isMax)and maxlv or starlv+1

local widget=self.star:getChildWidgetBase()
widget:SetChildStarNumber(1,starlv)
widget:SetChildGroundStarNum(1,maxlv)
widget:SetChildActive(2,not isMax)

if not isMax then
widget:SetChildStarNumber(3,nextLv)
end

local attrList,diziAttrList=ClothingHelper.getStarBaseAttrs(itemid,starlv)
local UpAttrList,UpDiziAttrList=nil
if not isMax then
UpAttrList,UpDiziAttrList=ClothingHelper.getStarBaseAttrs(itemid,nextLv)
end

for i=1,#self.starAttr do
local widget=self.starAttr[i]:getChildWidgetBase()
local diziattrInfo=diziAttrList[i-#attrList]
if attrList[i]then
self.starAttr[i]:setActive(true)

local name,str=equipsHelper.getAttr(attrList[i][1],attrList[i][2])

widget:SetChildText(0,FMT.fmt("{0}：",name))
widget:SetChildText(1,str)
widget:SetChildActive(2,UpAttrList~=nil)
if UpAttrList then
local upName,addStr=equipsHelper.getAttr(UpAttrList[i][1],UpAttrList[i][2])
widget:SetChildText(3,addStr)
end
else
if diziattrInfo then
self.starAttr[i]:setActive(true)

local name,str=equipsHelper.getDiziAttr(diziattrInfo[1],diziattrInfo[2])

widget:SetChildText(0,FMT.fmt('{0}+{1}',name,str))
widget:SetChildText(1,'')
widget:SetChildActive(2,UpDiziAttrList~=nil)
if UpDiziAttrList then
local upName,addStr=equipsHelper.getDiziAttr(UpDiziAttrList[i-#attrList][1],UpDiziAttrList[i-#attrList][2])
widget:SetChildText(3,FMT.fmt('{0}+{1}',name,addStr))
end
else
self.starAttr[i]:setActive(false)
end

end

end

local title
local cfg=itemsConfig.getConfig(itemid)
title=cfgHelper.get(cfg_disciplevocationconfig_get,cfg.type1,"name")
local collectLv=ClothingModel:getClothingCollectStarLv(itemCfg.type2)
self.collect:setActive(collectLv~=nil)
self.collectupTitle:setActive(collectLv<maxlv)
if collectLv then
self.collectstar:setStarNumber(collectLv)
self.collectstar:setGroundStarNum(maxlv)
local attr=ClothingHelper.getCollectAttrs(itemid,collectLv)
local upName,addStr=equipsHelper.getAttr(attr[1][1],attr[1][2],nil,1)
self.collectupAttr:setText(FMT.fmt("{0}{1}：{2}",title,upName,addStr))

end



self:freshStarItem()

if hasUpMax==nil then
local costList=starlvCfg[1]or{}

local len=isMax and 0 or#costList
self.starItemCreater:setChildLayoutGroupCreateItems(len)
local grids=self.starItemCreater:getChildLayoutGroupGridList()
if len then
for i=1,len do
local cost=costList[i]
local itemid=cost[1]
local count=cost[2]
local countStr=UIDanYaoModel:getItemCountStr(itemid,count)
local item=grids[i-1]
local conf={itemid=itemid,itemcount=countStr,showCountBG=true,showname=false,showStage=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(0,prop)
end
end
end

if isMax then


self.btnStar:setActive(false)

else

self.starTitle:setText('')
self.btnStar:setActive(true)
local enough=self.enoughStarItem or false
self.winlua:SetChildButtonEnable(self.btnStar:getID(),enough,not enough)
end
local model
if itemguid then
local diziguid=ClothingModel:getDiziguidByItemguid(itemguid)
if diziguid then
local switchidx=ClothingModel:getEquipSwitchIdx(itemguid)
local imageInfo=table.deepCopy(UIDiscipleModel:getDiscipleImageInfo(diziguid,switchidx))
imageInfo.clothingId=itemid
imageInfo.clothingStar=starlv
local modelInfo=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo,nil,{clothingStar=starlv})
model={model=modelInfo.body,component=modelInfo.componets}
else
model=ClothingConfig.getModelArgs(itemid,starlv,diziguid)
end

else
model=ClothingConfig.getModelArgs(itemid,starlv)
end
self.model:setChildUIModelShowTarget(model.model,1.5,model.component,eAnimationID.stand,false,false,0)

if model.offset then
self.model:setChildUIModelShowTargetOffset(model.offset[1],model.offset[2])
end
end


function UIDiscipleShiZhuangStarWin:freshStarItem()
local itemguid=self.itemguid
local equip=ClothingHelper.getEquip(itemguid)
local itemid=equip.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local starlv=ClothingModel:getStarLv(itemguid)
local maxlv=ClothingConfig.getStarMaxLv(itemid)
local isMax=maxlv==starlv
local bentinum=ClothingConfig.getCostBenTiNum(starlv)

local hasUpMax=itemCfg.item

self.starItem:setActive(bentinum>0 and not isMax and not hasUpMax)

self.enoughStarItem=true
if bentinum>0 and not hasUpMax then
local num=#self.selectBentiList
local iconItemid=itemid
if num>0 then
local _itemguid=self.selectBentiList[1]
local equip=equipsHelper.getEquip(_itemguid)
if equip then
iconItemid=equip.itemid
end
end
local iconName=iconHelper.getIconName(iconItemid)
local widget=self.starItem:getChildWidgetBase()
local put=num>0
self.enoughStarItem=num>=bentinum
self.starItem:setBaseItemClickEvent(function()
self:onSelectBenti()
end)
local countStr=self.enoughStarItem and FMT.fmt('{0}/{1}',num,bentinum)or
FMT.cfmt(FONT_COLOR.eRedColor,'{0}/{1}',num,bentinum)
widget:SetChildActive(2,true)
widget:SetChildText(3,countStr)
widget:SetChildActive(4,put)
widget:SetChildActive(6,not put)
widget:SetChildActive(5,not put)

if put then
widget:SetChildQulaity(0,itemCfg.color)
widget:SetChildScale(1,Vector3.one)
widget:SetChildIcon(1,iconName,false)
else
widget:SetChildActive(0,false)
widget:SetChildScale(1,Vector3.zero)
end
end

if hasUpMax then
local costList={hasUpMax}
local len=isMax and 0 or#costList
self.starItemCreater:setChildLayoutGroupCreateItems(len)
local grids=self.starItemCreater:getChildLayoutGroupGridList()
if len then
for i=1,len do
local cost=costList[i]
local itemid=cost[1]
local count=cost[2]
local countStr=UIDanYaoModel:getItemCountStr(itemid,count)
local item=grids[i-1]
local conf={itemid=itemid,itemcount=countStr,showCountBG=true,showname=false,showStage=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(0,prop)
end
end
self.yuHuaCost=hasUpMax
self.winlua:SetChildButtonEnable(self.btnYuHua:getID(),true,UIDanYaoModel:getHaveItemCount(hasUpMax[1])<hasUpMax[2])
end

if isMax then


self.upTitle:setActive(false)
self.maxStarImg:setActive(true)
self.btnStar:setActive(false)
self.btnYuHua:setActive(false)
self.star:setChildAnchoredPos(230,-60.3)
self.btnReset:setActive(true)
self.winlua:SetChildButtonEnable(self.btnReset:getID(),true,hasUpMax~=nil)
else

self.starTitle:setText('')
self.maxStarImg:setActive(false)
self.upTitle:setActive(true)
self.star:setChildAnchoredPos(135,-60.3)
if not hasUpMax then
local enough=self.enoughStarItem or false
self.btnYuHua:setActive(false)
self.btnStar:setActive(true)
self.winlua:SetChildButtonEnable(self.btnStar:getID(),enough,not enough)
self.btnReset:setActive(starlv>0)
else
self.btnStar:setActive(false)
self.btnYuHua:setActive(true)
self.btnReset:setActive(false)
end
self.winlua:SetChildButtonEnable(self.btnReset:getID(),true,hasUpMax~=nil)
end


end

function UIDiscipleShiZhuangStarWin:freshLeftPanel()
local equip=ClothingHelper.getEquip(self.itemguid)
local itemid=equip.itemid
local type1=itemsConfig.getConfig(itemid).type1
local filter={}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eClothing
filter[ITEM_FILTER_TYPE.eItemType1]={[ITEM_FILTER_COMPARE.eEquals]={type1}}
local bagList=bagControl.getBagItemsByFilter(BAG_TYPE.eClothing,filter,false)


local equips=ClothingModel:getAllVocEquip(nil,type1)
bagList=table.concatTableX(bagList,equips)
bagList=self:sortEquip(bagList)

self.bagList=bagList
local rNum=#bagList
local row=math.ceil(rNum/_colomn)
self.ScrollView:clearSlowItems()
self.ScrollView:freshSlowGrids(rNum,row,_colomn,true)
end

function UIDiscipleShiZhuangStarWin:sortEquip(list)
return ClothingHelper.sortClothing(list,self.sortOrder)
end

function UIDiscipleShiZhuangStarWin:bindGrid(index,widget)
local itemInfo=self.bagList[index]
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid
local itemCfgs=itemsConfig.getConfig(itemid)
local color=itemCfgs.color
local iconName=itemsModel.getIconName(itemInfo)
local isSelect=tostring(self.itemguid)==tostring(itemguid)
local isEquiped=ClothingModel:isEquipedOnAnyDizi(itemguid)
local starlv=ClothingModel:getStarLv(itemguid)
widget:SetChildQulaity(0,color)
widget:SetChildIcon(1,iconName,false)
widget:SetChildActive(2,starlv>0)
widget:SetChildActive(4,isSelect)
widget:SetChildActive(5,isEquiped)
widget:SetChildStarNumber(6,starlv)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)
if self.needFocus and isSelect then
self.needFocus=nil
self.ScrollView:jumpToSlowItem(index)
end
end
local nameAtltas='ui/windows/disciple/clothing_name_atlas_pak.ab'
function UIDiscipleShiZhuangStarWin:freshMidPanel()
local itemguid=self.itemguid
local dzguid=ClothingModel:getDiziguidByItemguid(itemguid)
local equip=ClothingHelper.getEquip(itemguid)
local itemid=equip.itemid









self.name:setSprite(nameAtltas,FMT.fmt("image_dizishizhuangname_{0}",itemid))
if dzguid then
self.dizi:setActive(true)
local switchidx=ClothingModel:getEquipSwitchIdx(itemguid)
comHelper.setChildModelHeadIconBG(self.widget,self.dzbg:getID(),dzguid,switchidx)
comHelper.setChildModelRawImage(self.widget,dzguid,self.dzhead:getID(),0,eHeadCenterType.eHead,nil,nil,nil,switchidx)
self.dzname:setText(UIDiscipleModel:getDiscipleName(dzguid))
else
self.dizi:setActive(false)
end
end


function UIDiscipleShiZhuangStarWin:onSelectItem(itemguid)
if tostring(itemguid)==tostring(self.itemguid)then return end
self.itemguid=itemguid
self:freshMidPanel()
self:freshRightPanel()
return true
end


function UIDiscipleShiZhuangStarWin:onClickGrid(id,index,guid,attach)
if tostring(self.itemguid)==tostring(guid)then return end
local lastguid=self.itemguid
self.selectBentiList={}

if not self:onSelectItem(guid)then return end
if lastguid then
self.ScrollView:freshSlowItemByGUID(lastguid)
end
self.ScrollView:freshSlowItemByGUID(guid)

end

function UIDiscipleShiZhuangStarWin:onMoneyChanged(moneytype)
if moneytype==eMoneyType.mtXuanTie then

self:freshRightPanel()
end
end

function UIDiscipleShiZhuangStarWin:onItemsChanged(argsTable)

self:freshRightPanel()
end

function UIDiscipleShiZhuangStarWin:onSelectBenti()
local equip=equipsHelper.getEquip(self.itemguid)
local itemid=equip.itemid

local type2=itemsConfig.getConfig(itemid).type2


local filter={}
filter[ITEM_FILTER_TYPE.eItemType2]=type2
filter[ITEM_FILTER_TYPE.eItemguid]={ITEM_FILTER_COMPARE.eNot,{self.itemguid}}
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eClothing,filter)






local common_cfg=ClothingConfig.getCommonConfig().common
local common_cfg_arry=common_cfg[type2]or{}
local common_cfg_arry_zero=common_cfg[0]
if common_cfg_arry_zero then
for k,v in pairs(common_cfg_arry_zero)do
common_cfg_arry[k]=v
end
end

local temp={}
if common_cfg_arry then
for k,v in pairs(common_cfg_arry)do
temp[#temp+1]=k
end
if#temp>0 then

local baglistarry={}
for k,v in ipairs(temp)do
local filtertemp={}
filtertemp[ITEM_FILTER_TYPE.eItemid]=v
local baglisttemp=bagControl.getBagItemsByFilter(BAG_TYPE.eItemBag,filtertemp)
if#baglisttemp>0 and baglisttemp[1].itemcount and baglisttemp[1].itemcount>0 then
for i=1,baglisttemp[1].itemcount do
baglistarry[#baglistarry+1]=baglisttemp[1]
end
end
end


for k,v in ipairs(baglistarry)do
baglist[#baglist+1]=v
end
end
end


if#baglist==0 then
gainControl:showGainWin(itemid)
local itemname=itemsModel.getName(itemid)
UIManager.error(FMT.fmt('{0}数量不足',itemname))
return
end


local args={}
args.titleName="时装选择"
args.pos=1
args.extraWin='UIShiZhuangSelectWin'
local extraParams={}
local selectList=self.selectBentiList
local starlv=ClothingModel:getStarLv(self.itemguid)
local maxnum=ClothingConfig.getCostBenTiNum(starlv)

extraParams.selectList=selectList
extraParams.maxnum=maxnum
extraParams.list=baglist
extraParams.call=function(list)
if self and not self.isClose then
self.selectBentiList=list

self:freshStarItem()
end
end
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIDiscipleShiZhuangStarWin:onDizi()
local itemguid=self.itemguid
local dzguid=ClothingModel:getDiziguidByItemguid(itemguid)
UIFullCommonControl:jumpDiscipleMain(dzguid,
FULL_TAB_TYPE.eDiscipleEquip)
end




function UIDiscipleShiZhuangStarWin:onCloseBtn()
end



function UIDiscipleShiZhuangStarWin:onHelp()
end



function UIDiscipleShiZhuangStarWin:onBtnStar()
if not self:checkIsNowSwitchDisciple()then
UIManager.error("该弟子并非当前使用的职业，无法升星")
return
end
local itemguid=self.itemguid
local ret,args=ClothingHelper.isCanStar(itemguid,false)
if not ret then
if args==nil then
UIManager.error('已达星级上限')
return
end
local itemid=args[1]
local need=args[2]
gainControl:showGainWin(itemid)
UIManager.error(FMT.fmt('{0}不足',itemsModel.getName(itemid)))
return
end












local list=self.selectBentiList
ClothingController.req_2_124(itemguid,list)
end



function UIDiscipleShiZhuangStarWin:onModelClick()
end

function UIDiscipleShiZhuangStarWin:onBtnYuHua()
if not self:checkIsNowSwitchDisciple()then
UIManager.error("该弟子并非当前使用的职业，无法羽化")
return
end
local cost=self.yuHuaCost
if UIDanYaoModel:getHaveItemCount(cost[1])<cost[2]then
gainControl:showGainWin(cost[1])
UIManager.error(FMT.fmt('{0}不足',itemsModel.getName(cost[1])))
return
end
local costitem,costguid=bagControl.invokeFuncByItemId(cost[1],'getItemByItemID',cost[1])
ClothingController.req_2_124(self.itemguid,{costguid})
end

function UIDiscipleShiZhuangStarWin:onBtnReset()
if not self:checkIsNowSwitchDisciple()then
UIManager.error("该弟子并非当前使用的职业，无法重置星级")
return
end

local equip=equipsHelper.getEquip(self.itemguid)
local itemConfig=itemsConfig.getConfig(equip.itemid)
if itemConfig.item then
UIManager.info("羽化升星的时装无法重置星级")
return
end
UIManager:showWindow("UIDiscipleFashionClothResetWin",{itemguid=self.itemguid,itemid=equip.itemid})
end


function UIDiscipleShiZhuangStarWin:checkIsNowSwitchDisciple()
local itemguid=self.itemguid
if itemguid then
local diziguid=ClothingModel:getDiziguidByItemguid(itemguid)
if diziguid then
local switchidx=ClothingModel:getEquipSwitchIdx(itemguid)
if switchidx and switchidx~=0 then
return false
end
end
end
return true
end
