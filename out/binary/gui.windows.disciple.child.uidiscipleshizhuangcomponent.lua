







def_class("UIDiscipleShiZhuangComponent",UIWindowBase)









function UIDiscipleShiZhuangComponent:bindComponents()

self.BagList=UIScrollViewSlow.get(self,0)
self.bagRoot=UIObject.get(self,1)
self.closeTag=UIObject.get(self,2)
self.collectAttr_0=UIText.get(self,3)
self.collectAttr_1=UIText.get(self,4)
self.collectAttr_2=UIText.get(self,5)
self.collectAttr_3=UIText.get(self,6)
self.collectAttr_4=UIText.get(self,7)
self.collectAttr_5=UIText.get(self,8)
self.collectMask=UIButton.get(self,9)
self.collectRoot=UIObject.get(self,10)
self.collectstar_1=UIObject.get(self,11)
self.collectstar_2=UIObject.get(self,12)
self.collectstar_3=UIObject.get(self,13)
self.collectstar_4=UIObject.get(self,14)
self.collectstar_5=UIObject.get(self,15)
self.collecttext=UIText.get(self,16)
self.Content=UIObject.get(self,17)
self.eattr_1=UIObject.get(self,18)
self.eattr_2=UIObject.get(self,19)
self.eattr_3=UIObject.get(self,20)
self.eattr_4=UIObject.get(self,21)
self.eattr_5=UIObject.get(self,22)
self.eattr_6=UIObject.get(self,23)
self.eattr_7=UIObject.get(self,24)
self.eattr_8=UIObject.get(self,25)
self.emptyClothing=UIObject.get(self,26)
self.equipAttrRoot=UIObject.get(self,27)
self.equipRoot=UIObject.get(self,28)
self.gainRoot=UIObject.get(self,29)
self.gainScrollView=UIScrollView.get(self,30)
self.Help=UIButton.get(self,31)
self.discipleJobIcon=UIImage.get(self,32)
self.lihuibutton=UIButton.get(self,33)
self.List=UIObject.get(self,34)
self.maxPreviewRoot=UIObject.get(self,35)
self.model=UIObject.get(self,36)
self.nameText=UIText.get(self,37)
self.notWear=UIText.get(self,38)
self.openTag=UIObject.get(self,39)
self.pattr_1=UIObject.get(self,40)
self.pattr_2=UIObject.get(self,41)
self.pattr_3=UIObject.get(self,42)
self.pattr_4=UIObject.get(self,43)
self.pattr_5=UIObject.get(self,44)
self.pattr_6=UIObject.get(self,45)
self.pattr_7=UIObject.get(self,46)
self.pattr_8=UIObject.get(self,47)
self.shoucang=UIButton.get(self,48)
self.showClothing=UIButton.get(self,49)
self.showClothingClose=UIObject.get(self,50)
self.showClothingOpen=UIObject.get(self,51)
self.showItem=UIObject.get(self,52)
self.showMax=UIButton.get(self,53)
self.showMaxClose=UIObject.get(self,54)
self.showMaxOpen=UIObject.get(self,55)
self.showWearable=UIObject.get(self,56)
self.showWearButton=UIButton.get(self,57)
self.toggleBtn=UIButton.get(self,58)
self.xianmoCloseTag=UIObject.get(self,59)
self.xianmoCloseTagText=UIText.get(self,60)
self.xianmoHideBtn=UIButton.get(self,61)
self.xianmoOpenTag=UIObject.get(self,62)
self.discipleJobIcon2=UIImage.get(self,63)
self.spBg=UIObject.get(self,64)

self.collectMask:setButtonClick(function()self:onCollectMask()end)

self.Help:setButtonClick(function()self:onHelp()end)

self.lihuibutton:setButtonClick(function()self:onLihuibutton()end)

self.shoucang:setButtonClick(function()self:onShoucang()end)

self.showClothing:setButtonClick(function()self:onShowClothing()end)

self.showMax:setButtonClick(function()self:onShowMax()end)

self.showWearButton:setButtonClick(function()self:onShowWearButton()end)

self.toggleBtn:setButtonClick(function()self:onToggleBtn()end)

self.xianmoHideBtn:setButtonClick(function()self:onXianmoHideBtn()end)
self.collectAttr={
[0]=self.collectAttr_0,
[1]=self.collectAttr_1,
[2]=self.collectAttr_2,
[3]=self.collectAttr_3,
[4]=self.collectAttr_4,
[5]=self.collectAttr_5,
}
self.collectstar={
self.collectstar_1,
self.collectstar_2,
self.collectstar_3,
self.collectstar_4,
self.collectstar_5,
}
self.eattr={
self.eattr_1,
self.eattr_2,
self.eattr_3,
self.eattr_4,
self.eattr_5,
self.eattr_6,
self.eattr_7,
self.eattr_8,
}
self.pattr={
self.pattr_1,
self.pattr_2,
self.pattr_3,
self.pattr_4,
self.pattr_5,
self.pattr_6,
self.pattr_7,
self.pattr_8,
}



end


function UIDiscipleShiZhuangComponent:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.BagList);self.BagList=nil;
_UIObject_release(self.bagRoot);self.bagRoot=nil;
_UIObject_release(self.closeTag);self.closeTag=nil;
_UIObject_release(self.collectAttr_0);self.collectAttr_0=nil;
_UIObject_release(self.collectAttr_1);self.collectAttr_1=nil;
_UIObject_release(self.collectAttr_2);self.collectAttr_2=nil;
_UIObject_release(self.collectAttr_3);self.collectAttr_3=nil;
_UIObject_release(self.collectAttr_4);self.collectAttr_4=nil;
_UIObject_release(self.collectAttr_5);self.collectAttr_5=nil;
_UIObject_release(self.collectMask);self.collectMask=nil;
_UIObject_release(self.collectRoot);self.collectRoot=nil;
_UIObject_release(self.collectstar_1);self.collectstar_1=nil;
_UIObject_release(self.collectstar_2);self.collectstar_2=nil;
_UIObject_release(self.collectstar_3);self.collectstar_3=nil;
_UIObject_release(self.collectstar_4);self.collectstar_4=nil;
_UIObject_release(self.collectstar_5);self.collectstar_5=nil;
_UIObject_release(self.collecttext);self.collecttext=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.eattr_1);self.eattr_1=nil;
_UIObject_release(self.eattr_2);self.eattr_2=nil;
_UIObject_release(self.eattr_3);self.eattr_3=nil;
_UIObject_release(self.eattr_4);self.eattr_4=nil;
_UIObject_release(self.eattr_5);self.eattr_5=nil;
_UIObject_release(self.eattr_6);self.eattr_6=nil;
_UIObject_release(self.eattr_7);self.eattr_7=nil;
_UIObject_release(self.eattr_8);self.eattr_8=nil;
_UIObject_release(self.emptyClothing);self.emptyClothing=nil;
_UIObject_release(self.equipAttrRoot);self.equipAttrRoot=nil;
_UIObject_release(self.equipRoot);self.equipRoot=nil;
_UIObject_release(self.gainRoot);self.gainRoot=nil;
_UIObject_release(self.gainScrollView);self.gainScrollView=nil;
_UIObject_release(self.Help);self.Help=nil;
_UIObject_release(self.discipleJobIcon);self.discipleJobIcon=nil;
_UIObject_release(self.lihuibutton);self.lihuibutton=nil;
_UIObject_release(self.List);self.List=nil;
_UIObject_release(self.maxPreviewRoot);self.maxPreviewRoot=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.nameText);self.nameText=nil;
_UIObject_release(self.notWear);self.notWear=nil;
_UIObject_release(self.openTag);self.openTag=nil;
_UIObject_release(self.pattr_1);self.pattr_1=nil;
_UIObject_release(self.pattr_2);self.pattr_2=nil;
_UIObject_release(self.pattr_3);self.pattr_3=nil;
_UIObject_release(self.pattr_4);self.pattr_4=nil;
_UIObject_release(self.pattr_5);self.pattr_5=nil;
_UIObject_release(self.pattr_6);self.pattr_6=nil;
_UIObject_release(self.pattr_7);self.pattr_7=nil;
_UIObject_release(self.pattr_8);self.pattr_8=nil;
_UIObject_release(self.shoucang);self.shoucang=nil;
_UIObject_release(self.showClothing);self.showClothing=nil;
_UIObject_release(self.showClothingClose);self.showClothingClose=nil;
_UIObject_release(self.showClothingOpen);self.showClothingOpen=nil;
_UIObject_release(self.showItem);self.showItem=nil;
_UIObject_release(self.showMax);self.showMax=nil;
_UIObject_release(self.showMaxClose);self.showMaxClose=nil;
_UIObject_release(self.showMaxOpen);self.showMaxOpen=nil;
_UIObject_release(self.showWearable);self.showWearable=nil;
_UIObject_release(self.showWearButton);self.showWearButton=nil;
_UIObject_release(self.toggleBtn);self.toggleBtn=nil;
_UIObject_release(self.xianmoCloseTag);self.xianmoCloseTag=nil;
_UIObject_release(self.xianmoCloseTagText);self.xianmoCloseTagText=nil;
_UIObject_release(self.xianmoHideBtn);self.xianmoHideBtn=nil;
_UIObject_release(self.xianmoOpenTag);self.xianmoOpenTag=nil;
_UIObject_release(self.discipleJobIcon2);self.discipleJobIcon2=nil;
_UIObject_release(self.spBg);self.spBg=nil;
self.collectAttr=nil;
self.collectstar=nil;
self.eattr=nil;
self.pattr=nil;
end


















local _colomn=5
local _creatGirdPrecent=100

function UIDiscipleShiZhuangComponent:onLoaded(...)
self:bindComponents()


self.sortType=1
self.sortOrder=eSortOrder.eDown

self.BagList:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)

self.gainScrollView:bindScrollWidget(function(...)
if self and not self.isClose then
self:fillGainData(...)
end
end)

self.gainScrollView:setClickAction(function(...)self:onGainItemClick(...)end)

self.showEquiped=userActorSetting.get("shizhuangShowEquiped",nil)
self.showWearable:setActive(self.showEquiped==true)

self:addNotify(notifyConfig.on_item_list_changed,function(...)self:onItemListChanged(...)end)
end


function UIDiscipleShiZhuangComponent:__delete()
self:unbindComponents()
end




function UIDiscipleShiZhuangComponent:onShow(argtable,afterOnloaded)
self.allItemsList=nil
local guid=argtable.guid
self.diziguid=guid
self.selectItemId=nil
self.selectMaxStar=nil


self.isToggle=UIDiscipleModel:getDiscipleHideHress(guid)==0
self.isXianMoToggle=UIDiscipleModel:getDiscipleXianMoHideDress(guid)==0

self:refreshShowMax()

self:refreshWearList(true)

self:refreshLeftWin()
self:refreshLeftEquipWin()

self:refreshToggle()
end


function UIDiscipleShiZhuangComponent:onHide()

end



function UIDiscipleShiZhuangComponent:refreshShowMax()
self.showMaxClose:setActive((not self.selectMaxStar))
self.showMaxOpen:setActive(not(not self.selectMaxStar))
end
function UIDiscipleShiZhuangComponent:onShowMax()
self.selectMaxStar=not self.selectMaxStar

self:refreshShowMax()

self:refreshLeftWin()
end

function UIDiscipleShiZhuangComponent:onItemListChanged(array)
local has=false
for i,v in ipairs(array)do
local itemid=v[3]
if itemsConfig.isClothing(itemid)then
has=true
break
end
end

if has then
self:refreshWearList(true)
end
end

function UIDiscipleShiZhuangComponent:onDressUp(diziguid)
self:refreshEquipList()
if diziguid==self.diziguid then
self:refreshLeftWin()
self:refreshLeftEquipWin()
self:refreshToggle()
end

end

function UIDiscipleShiZhuangComponent:onTakeDown(diziguid)
self:refreshEquipList()
if diziguid==self.diziguid then
self:refreshLeftWin()
self:refreshLeftEquipWin()
self:refreshToggle()
end
end

function UIDiscipleShiZhuangComponent:onStarUp()
self:refreshWearList()
self:refreshEquipList()
self:refreshLeftWin()
self:refreshLeftEquipWin()
end

function UIDiscipleShiZhuangComponent:isShowLiHuiBtn()
local itemid=nil
if self.selectItemId then
itemid=self.selectItemId
end
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(self.diziguid)
local bodyCfg=cfgHelper.get1(cfg_disciplebodyimageconfig_get,imageInfo.body)
if bodyCfg.clothing_map and itemid then
local change=bodyCfg.clothing_map[itemid]
if change then
return true
end
end
end

function UIDiscipleShiZhuangComponent:bindGrid(index,item)
local itemInfo=self.itemsList[index]
local isTemp=itemInfo==nil
if not isTemp then




local itemguid=itemInfo.itemguid



local star=itemInfo.itemData.star

local isEquiped=ClothingModel:isEquipedOnAnyDizi(itemguid)

local porp=itemsComponentHelper.getCommonFillData(itemInfo,{showCountBG=star>0,showcount=false,showname=false})


item:SetChildActive(0,true)
item:SetChildPropData(0,porp)

item:SetBaseItemClickEvent(0,function(itemid,index,itemguid,attach)
if not attach or type(attach)~='table'then
attach={}
attach.diziguid=self.diziguid
end

tipsManager.showTips({tipsType=TIPS_TYPE.eCommonClothing,formType=TIPS_FORM_TYPE.eEquipListWin,itemid=itemid,itemguid=itemguid,attach=attach})
end)

item:SetChildActive(2,isEquiped)
item:SetChildStarNumber(3,star)


else
item:SetChildActive(0,false)
item:SetChildActive(2,false)
item:SetChildStarNumber(3,0)
end
end

function UIDiscipleShiZhuangComponent:refreshWearList(refreshAll)
local chlist={}
local voc=UIDiscipleModel:getDiscipleJob(self.diziguid)
local diziId=UIDiscipleModel:getDiscipleID(self.diziguid)
local idLookUp={}

if not self.allItemsList or refreshAll then

local filter={}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eClothing
filter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eEquals,{voc}}
filter[ITEM_FILTER_TYPE.eDiscipleId]={ITEM_FILTER_COMPARE.eEquals,{diziId}}

local listF=bagControl.getBagItemsByFilter(BAG_TYPE.eClothing,filter,false)
local list=ClothingModel:getAllVocEquip(nil,voc)
listF=table.concatTableX(listF,list)

self.allItemsList=listF
end

for i,v in ipairs(self.allItemsList)do
if ClothingHelper.canDressByLimit(v.itemid,diziId,voc)then
local itemConfig=itemsConfig.getConfig(v.itemid)

local sort=v.itemid

if(not idLookUp[v.itemid])or(idLookUp[v.itemid]and v.itemData.star>idLookUp[v.itemid].itemData.itemData.star)then
idLookUp[v.itemid]={itemid=v.itemid,itemData=v,sort=sort}
end

end
end

for id,v in pairs(idLookUp)do
table.insert(chlist,v)
end

local vocItemConfig=ClothingHelper:get_voc_items(voc)

for i,v in ipairs(vocItemConfig)do
if not idLookUp[v.id]and ClothingHelper.canDressByLimit(v.id,diziId,voc)then


if not v.hide then

local sort=v.id+10000000

table.insert(chlist,{itemid=v.id,config=v,sort=sort})
else

local filter={}
filter[ITEM_FILTER_TYPE.eItemid]=v.id
local list=bagControl.getBagItemsByFilter(BAG_TYPE.eClothing,filter,false)
if list and next(list)then
table.insert(chlist,{itemid=v.id,config=v,sort=v.id+10000000})
end
end
end
end

table.sort(chlist,function(a,b)return a.sort<b.sort end)

table.insert(chlist,1,{itemid=-1})

local len=#chlist
self.List:setChildScrollViewCreateGrids(len,len)

self.emptyClothing:setActive(len==0)
if refreshAll then
if len>0 then
self.selectIdx=1

self.selectItemId=chlist[1].itemid
else
self.selectIdx=1

self.selectItemId=nil
end
end
local equipItemId=nil
local equiped=ClothingModel:getEquipByDizi(self.diziguid)
if equiped then
equipItemId=equiped.itemid
end
local selectItem,selectGrid
local grids=self.List:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local grid=grids[i-1]

local item=chlist[i]

local itemid=item.itemid

local star=0
local cfg

if itemid==-1 then
grid:SetChildText(0,'默认')
grid:SetChildActive(3,false)
grid:SetChildActive(4,false)
grid:SetChildActive(8,true)
grid:SetChildActive(9,true)
grid:SetChildScale(10,Vector3.one)
grid:SetChildScale(11,Vector3.zero)


local modelArgs=UIDiscipleModel:getDiscipleOutsideModelInfo(self.diziguid,nil,nil,{notClothing=true})

modelArgs.scale=0.5
modelArgs.offset={0,-20}
modelArgs.headCenter={0,20}

grid:SetChildUIModelShowTarget(1,modelArgs.body,modelArgs.scale,modelArgs.componets,eAnimationID.stand,true,nil)
grid:SetChildUIModelShowTargetOffset(1,modelArgs.offset[1],modelArgs.offset[2])
grid:SetChildUIModelShowColor(1,Color.New(1,1,1,1))
grid:SetChildUIModelGray(1,false)
grid:SetChildButtonClick(5,function()
self:onClickChlist(i,item,grid)

end)
else

local modelArgs=UIDiscipleModel:getDiscipleOutsideModelInfo(self.diziguid,nil,nil,{clothingId=itemid,clothingStar=ClothingConfig.getStarMaxLv(itemid)})
local modelParams={body=modelArgs.body,componets=modelArgs.componets}
modelParams.scale=0.5
modelParams.offset={0,-20}
modelParams.headCenter={0,20}

grid:SetChildUIModelShowTarget(1,modelParams.body,modelParams.scale,modelParams.componets,eAnimationID.stand,true,nil)
grid:SetChildUIModelShowTargetOffset(1,modelParams.offset[1],modelParams.offset[2])

if item.itemData then
star=item.itemData.itemData.star or 0
cfg=itemsConfig.getConfig(item.itemid)
local isEquiped=equipItemId==item.itemid
if isEquiped then
if refreshAll then
self.selectIdx=i
self.selectItemId=itemid
end
grid:SetChildActive(4,true)
else
grid:SetChildActive(4,false)
end

grid:SetChildGray(7,false)

grid:SetChildActive(6,false)

grid:SetChildUIModelGray(1,false)
else
cfg=item.config
grid:SetChildActive(4,false)
grid:SetChildGray(7,true)

grid:SetChildActive(6,true)

grid:SetChildUIModelGray(1,true)
end

if cfg.showRule and not item.itemData then

grid:SetChildUIModelShowColor(1,Color.New(0,0,0,1))
grid:SetChildText(0,"  ？？？？")
else

grid:SetChildUIModelShowColor(1,Color.New(1,1,1,1))
grid:SetChildText(0,cfg.name)
end

grid:SetChildButtonClick(5,function()
if cfg.showRule and not item.itemData then
UIManager.error("该时装尚未激活")
else
self:onClickChlist(i,item,grid)
end
end)

grid:SetChildLayoutGroupCreateItems(2,star)

grid:SetChildActive(3,cfg.otherColor==true)
grid:SetChildActive(8,not(cfg.otherColor==true))
grid:SetChildActive(9,cfg.otherColor==true)
grid:SetChildScale(10,not(cfg.otherColor==true)and Vector3.one or Vector3.zero)
grid:SetChildScale(11,cfg.otherColor==true and Vector3.one or Vector3.zero)
end



if self.selectIdx==i then
selectItem=item
selectGrid=grid
end
end
if refreshAll then
if selectItem then
self:onClickChlist(self.selectIdx,selectItem,selectGrid)
else
self:showGainwayWin(false)
self:refreshEquipList()
end
end

self.shoucang:setActive(len>0 and self.selectItemId~=-1)

self.List:setChildScrollViewSelectItem(self.selectIdx-1,false,true,true)

self.lihuibutton:setActive(self:isShowLiHuiBtn()or false)
end

function UIDiscipleShiZhuangComponent:onClickChlist(idx,item,grid)
local isGot=true
local cfg
if item.itemData then
cfg=itemsConfig.getConfig(item.itemid)
if item.itemData.itemData.star and item.itemData.itemData.star>=ClothingConfig.getStarMaxLv(item.itemid)then
self.showMax:setActive(false)
else
self.showMax:setActive(true)
end
else
cfg=item.config
isGot=false
if item.itemid==-1 then
self.showMax:setActive(false)
else
self.showMax:setActive(true)
end
end

if self.selectIdx then
local old=self.List:getChildScrollViewItemWidget(self.selectIdx-1)
if old then
old:SetChildActive(4,false)
end
end
self.selectIdx=idx
if item.itemid==-1 then
self.selectItemId=-1
isGot=true
self.shoucang:setActive(false)
else
self.selectItemId=cfg.id

self.shoucang:setActive(true)
end


grid:SetChildActive(4,true)

self:refreshLeftWin()

self:showGainwayWin(not isGot,item)

if isGot then
self:refreshEquipList()
end
if item.itemid==-1 then
else

end

self:refreshToggle()

self.lihuibutton:setActive(self:isShowLiHuiBtn()or false)
end


function UIDiscipleShiZhuangComponent:refreshEquipList()
local showItemId=self.selectItemId
if showItemId==-1 then
showItemId=nil
end
local chlist=self:sortEquip(self.allItemsList,showItemId)
self.itemsList=chlist
local chlen=#chlist



local tNum=_creatGirdPrecent
tNum=math.min(tNum,chlen)
local row=math.ceil(tNum/_colomn)+7
tNum=(row+7)*_colomn
local row=math.ceil(tNum/_colomn)

if not self.isSetZero then
self.BagList:freshSlowGrids(tNum,row,_colomn,self.isSetZero)
self.isSetZero=true
else
self.BagList:freshAllItems()
end

end

function UIDiscipleShiZhuangComponent:sortEquip(list,itemId)
return ClothingHelper.sortClothing(list,self.sortOrder,not self.showEquiped,itemId,self.diziguid)
end

function UIDiscipleShiZhuangComponent:refreshLeftWin()
local name=UIDiscipleModel:getDiscipleName(self.diziguid)
self.nameText:setText(name)
local jobicon=UIDiscipleModel:getJobIconNameX(self.diziguid)
local isSPdz=UIDiscipleModel:isSPDiscipleEx(self.diziguid)
self.discipleJobIcon:setSprite(globalABLookup.global,jobicon)
self.discipleJobIcon2:setActive(isSPdz)
self.spBg:setActive(isSPdz)
if isSPdz then
local switchidx=1
local switchJobIcon=UIDiscipleModel:getJobIconNameX(self.diziguid,switchidx)
self.discipleJobIcon2:setSprite(globalABLookup.global,switchJobIcon)
self.discipleJobIcon:setChildAnchoredPos(-10,10)
local scale=54/68
self.discipleJobIcon:setScale(Vector3(scale,scale,scale))
else
self.discipleJobIcon:setChildAnchoredPos(0,0)
self.discipleJobIcon:setScale(Vector3.one)
end
self:freshModel()
end

function UIDiscipleShiZhuangComponent:freshModel()
local itemid=nil
local star=nil
local euqip=ClothingModel:getEquipByDizi(self.diziguid)
if self.selectItemId then
itemid=self.selectItemId
else
if euqip then
itemid=euqip.itemid
star=euqip.itemData.star
end
end

local isEquiped=false
if euqip and euqip.itemid~=itemid then
isEquiped=true
end

local isToggle=self.isToggle
if isEquiped then
isToggle=true
end
local args={clothingId=itemid,clothingStar=star}
if not isToggle or itemid==-1 then
args={notClothing=true}
if not self.isXianMoToggle then
args.hideXianMo=true
end
end

if self.selectMaxStar and itemid~=-1 then
args.clothingStar=ClothingConfig.getStarMaxLv(itemid)
end

local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo2(self.diziguid,0,nil,args)
local scale=modelParams.scale*3.5


self.model:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,modelParams.anim,false,false,0.6)
end

function UIDiscipleShiZhuangComponent:refreshLeftEquipWin()
local euqip=ClothingModel:getEquipByDizi(self.diziguid)
if euqip then
self.notWear:setActive(false)
self.equipRoot:setActive(true)
local attrList,diziAttrs=ClothingHelper.getEquipBaseAttrsListByItemguid(euqip.itemguid,euqip.itemid,true)
local attrlen=#attrList
local diziAttrFirstIdx=attrlen%2==0 and attrlen or attrlen+1
for i=1,#self.eattr do
local widget=self.eattr[i]:getChildWidgetBase()
local attr=attrList[i]
local diziAttr=diziAttrs[i-diziAttrFirstIdx]
if attr then
self.eattr[i]:setScale(Vector3.one)
self.eattr[i]:setActive(true)
local name,str=equipsHelper.getAttr(attr[1],attr[2])
widget:SetChildText(0,FMT.fmt("<color=#7d3b17>{0}：</color>{1}",name,str))
else
if diziAttr then
self.eattr[i]:setScale(Vector3.one)
self.eattr[i]:setActive(true)
local name,str=equipsHelper.getDiziAttr(diziAttr[1],diziAttr[2])
widget:SetChildText(0,FMT.fmt("<color=#ca631d>{0}+{1}</color>",name,str))
else
if i==diziAttrFirstIdx then
self.eattr[i]:setActive(true)
self.eattr[i]:setScale(Vector3.zero)
else
self.eattr[i]:setActive(false)
end

end
end
end

local porp=itemsComponentHelper.getCommonFillData(euqip,{showcount=false,showname=true})


local widget=self.showItem:getChildWidgetBase()
widget:SetChildPropData(0,porp)

widget:SetBaseItemClickEvent(0,function(itemid,index,itemguid,attach)
if not attach or type(attach)~='table'then
attach={}
attach.diziguid=self.diziguid
end
tipsManager.showTips({tipsType=TIPS_TYPE.eCommonClothing,formType=TIPS_FORM_TYPE.eEquipListWin,itemid=itemid,itemguid=itemguid,attach=attach})
end)

widget:SetChildStarNumber(2,euqip.itemData.star or 0)

else
self.equipRoot:setActive(false)
self.notWear:setActive(true)
end
end

function UIDiscipleShiZhuangComponent:refreshToggle()
local isEquiped=ClothingModel:getEquipByDizi(self.diziguid)

local show=(self.selectItemId~=nil and(isEquiped~=nil and isEquiped.itemid==self.selectItemId))
self.toggleBtn:setActive(show)
self.openTag:setActive(self.isToggle)
self.closeTag:setActive(not self.isToggle)

local showXianMo=self.selectItemId==-1 and UIDiscipleModel:checkDiscipleXianMoVoc(self.diziguid)
local xm_voc=UIDiscipleModel:getDiscipleXianMoVoc(self.diziguid)
self.xianmoHideBtn:setActive(showXianMo)
self.xianmoOpenTag:setActive(self.isXianMoToggle)
self.xianmoCloseTag:setActive(not self.isXianMoToggle)
self.xianmoCloseTagText:setText(xm_voc==1 and'成仙'or'成魔')

self.showMax:setScale((self.isToggle or((self.selectItemId==nil or(isEquiped~=nil and isEquiped.itemid~=self.selectItemId))))and Vector3.one or Vector3.zero)
end

function UIDiscipleShiZhuangComponent:showGainwayWin(active,item)
self.maxPreviewRoot:setActive(active)
self.bagRoot:setLocalPosX((not active)and 0 or 100000)
if active then
local cfg=item.config

local attrList,diziAttrList=ClothingHelper.getEquipAttrsListByItemid(cfg.id,#cfg.star,true)
local attrlen=#attrList
local diziAttrFirstIdx=attrlen%2==0 and attrlen or attrlen+1
for i=1,#self.pattr do
local widget=self.pattr[i]:getChildWidgetBase()
local attr=attrList[i]
local diziAttr=diziAttrList[i-diziAttrFirstIdx]
if attr then
self.pattr[i]:setScale(Vector3.one)
self.pattr[i]:setActive(true)
local name,str=equipsHelper.getAttr(attr[1],attr[2])
widget:SetChildText(0,FMT.fmt("<color=#7d3b17>{0}：</color>{1}",name,str))
else
if diziAttr then
self.pattr[i]:setScale(Vector3.one)
self.pattr[i]:setActive(true)
local name,str=equipsHelper.getDiziAttr(diziAttr[1],diziAttr[2])
widget:SetChildText(0,FMT.fmt("<color=#ca631d>{0}+{1}</color>",name,str))
else
if i==diziAttrFirstIdx then
self.pattr[i]:setActive(true)
self.pattr[i]:setScale(Vector3.zero)
else
self.pattr[i]:setActive(false)
end

end

end
end

self:freshGainPanel(cfg.id)
end
end

function UIDiscipleShiZhuangComponent:freshGainPanel(itemid)
local itemCfg=itemsConfig.getConfig(itemid)
local produce=itemCfg.produce or{}
local len=#produce
self.produce=produce
self.gainScrollView:freshGridsNum(len,len,1,self.initGain~=true)
self.initGain=true
end

function UIDiscipleShiZhuangComponent:fillGainData(index,widget)
local info=self.produce[index]
local jump=info.jump
local hasjump=jump~=nil
local unLock,err=self:checkGainUnLock(info)
local isUnlock=jump and unLock or false
widget:SetChildText(0,info.desc)
widget:SetChildActive(1,not unLock)
widget:SetChildActive(2,isUnlock)
widget:SetChildButtonClick(3,function()
if not hasjump then

return
end
if isUnlock then
jumpManager:jump(jump)
else
UIManager.error(err)
end
end)
end

function UIDiscipleShiZhuangComponent:showCollect(active)
local itemId=self.selectItemId
active=active and itemId~=nil and itemId~=-1

self.collectRoot:setActive(active)
if active then
local title
local cfg=itemsConfig.getConfig(itemId)
title=cfgHelper.get(cfg_disciplevocationconfig_get,cfg.type1,"name")
local cfg=itemsConfig.getConfig(itemId)
local type2=cfg.type2
local star=ClothingModel:getClothingCollectStarLv(type2)

local maxStar=ClothingConfig.getStarMaxLv(itemId)

for i=0,maxStar do
local attr=ClothingHelper.getCollectAttrs(itemId,i)
if attr and attr[1]then
self:setCollectAttr(i,attr[1][1],attr[1][2],star,title)
end
end

local voc=cfgHelper.get(cfg_discipledresstypeconfig_get,type2,"voc")
local name=UIDiscipleModel:getJobName(voc)
self.collecttext:setText(FMT.fmt("时装首次升至指定星级后可提升收藏属性，\n收藏属性将提升宗门中{0}弟子的属性",name))
end
end

function UIDiscipleShiZhuangComponent:setCollectAttr(idx,attrType,attrValue,starlv,title)
if attrType==nil then
self.collectAttr[idx]:setActive(false)
return
end
self.collectAttr[idx]:setActive(true)
local name,str=equipsHelper.getAttr(attrType,attrValue,nil,1)
local attrStr=FMT.fmt('{0}{1}：{2}',title,name,str)
starlv=starlv or-0

if idx>=0 then
if starlv>idx-1 then
if self.collectstar[idx]then
self.widget:SetChildStarNumber(self.collectstar[idx]:getID(),idx)
end
self.collectAttr[idx]:setText(attrStr)
else
if self.collectstar[idx]then
self.widget:SetChildStarNumber(self.collectstar[idx]:getID(),0)
end
self.collectAttr[idx]:setText(FMT.fmt("<color=#827f78>{0}</color>",attrStr))
end
end
end

function UIDiscipleShiZhuangComponent:onCollectMask()
self.collectRoot:setActive(false)
end

function UIDiscipleShiZhuangComponent:checkGainUnLock(v)
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

function UIDiscipleShiZhuangComponent:onGainItemClick(id,index,guid,attach)

local produce=self.produce
local jumpArgs=produce[id].jump
if jumpArgs then
jumpManager:jump(jumpArgs)
else
loggerUtil.logErrFMT('道具{0}获取途径中跳转没有配置',self.itemid)
end
end




function UIDiscipleShiZhuangComponent:onHelp()
local d={}
d.title='时装规则'
d.mode=3
d.name='shizhuang_help_%d'
UIManager:showWindow('UIRuleWin',d)
end



function UIDiscipleShiZhuangComponent:onShoucang()


self:showCollect(true)
end



function UIDiscipleShiZhuangComponent:onShowWearButton()
self.showWearable:setActive(not self.showEquiped)
self.showEquiped=not self.showEquiped
userActorSetting.flushVal("shizhuangShowEquiped",self.showEquiped)
self:refreshEquipList()
end

function UIDiscipleShiZhuangComponent:onToggleBtn()
ClothingController.req_2_120(self.diziguid,self.isToggle and 1 or 0)
end

function UIDiscipleShiZhuangComponent:onXianmoHideBtn()
UIDiscipleController:reqXianMoImageHide(self.diziguid,self.isXianMoToggle and 1 or 0)
end

function UIDiscipleShiZhuangComponent:recvToggleBtn()
self.isToggle=not self.isToggle
self:refreshToggle()
self:freshModel()


end

function UIDiscipleShiZhuangComponent:recvXianMoToggleBtn()
self.isXianMoToggle=not self.isXianMoToggle
self:refreshToggle()
self:freshModel()
end

function UIDiscipleShiZhuangComponent:onLihuibutton()
self:showWindow("UIDiscipleShiZhuangLiHuiShowWin",{dizi=self.diziguid,itemid=self.selectItemId})
end
