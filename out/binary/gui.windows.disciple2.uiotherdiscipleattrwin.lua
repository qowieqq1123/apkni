







def_class("UIOtherDiscipleAttrWin",UIWindowBase)









function UIOtherDiscipleAttrWin:bindComponents()

self.root=UIObject.get(self,0)
self.discipleModelRoot=UIObject.get(self,1)
self.discipleNameText=UIText.get(self,2)
self.discipleJobIcon=UIImage.get(self,3)
self.discipleFightTxt=UIText.get(self,4)
self.equipslist=UIObject.get(self,5)
self.alllAttrPointNumText=UIText.get(self,6)
self.polygonAttrPanel=UIObject.get(self,7)
self.proSkillGrid=UIObject.get(self,8)



end


function UIOtherDiscipleAttrWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.discipleNameText);self.discipleNameText=nil;
_UIObject_release(self.discipleJobIcon);self.discipleJobIcon=nil;
_UIObject_release(self.discipleFightTxt);self.discipleFightTxt=nil;
_UIObject_release(self.equipslist);self.equipslist=nil;
_UIObject_release(self.alllAttrPointNumText);self.alllAttrPointNumText=nil;
_UIObject_release(self.polygonAttrPanel);self.polygonAttrPanel=nil;
_UIObject_release(self.proSkillGrid);self.proSkillGrid=nil;
end
















local proSkillSort={1,3,5,7,2,4,6,8}
local _fuBaoItemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemTxtCount=2,
cmpItemName=3,
cmpItemStage=4,
cmpItemStageBg=5,
cmpFabaoTag=6,
cmpCountBg=7,
}

local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemTxtCount=2,
cmpItemAdd=3,
cmpItemName=4,
cmpItemStage=5,
cmpItemStageBg=6,
cmpItemNew=7,
cmpItemReddot=8,
cmpLock=9,
cmpFabaoTag=10,
cmpCountBg=11,
cmpStar=12,
cmpSuitIcon=13,
cmpLiandon=14,
xmicons=15,
xmstagetxt=16,
}

local _mountSlotIdx=2
local _lingshouSlotIdx=3

local _shiZhuangSlotIdx=4
local _vocEquipSlotIdx=5

local fuSlotIndex={
EQUIP_TYPE.eFuBao,
EQUIP_TYPE.eFuBao,
EQUIP_TYPE.eMount,
EQUIP_TYPE.eZhuZhan,
EQUIP_TYPE.eShiZhuang,
EQUIP_TYPE.eVocEquip,
}


function UIOtherDiscipleAttrWin:onLoaded(...)
self:bindComponents()

self.equipListWidget=self.equipslist:getChildWidgetBase()
for i,v in ipairs(fuSlotIndex)do
local index=i-1
self.equipListWidget:SetBaseItemClickEvent(index,function(...)self:onEquipItemClick(i,...)end)
self.equipListWidget:SetBaseItemChildIndex(index,v)
end
end


function UIOtherDiscipleAttrWin:__delete()
self:unbindComponents()
end


function UIOtherDiscipleAttrWin:onHide()

end




function UIOtherDiscipleAttrWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid

self:refreshInfo()
end

function UIOtherDiscipleAttrWin:onChangeDisciple(dis_guid)
self:onShow({guid=dis_guid})
end

function UIOtherDiscipleAttrWin:refreshInfo()
local disguid=self.disciple_guid
local dzData=otherPlayerModel:getDZData(disguid)
local baseData=dzData.base
local image=UIDiscipleModel.calculationDiscipleImageBase(baseData)


self.discipleNameText:setText(baseData.disciplename)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
self.discipleJobIcon:setSprite(globalABLookup.global,jobicon)

self.discipleFightTxt:setText(dzData:fightValNum_get())

self.discipleModelRoot:setChildUIModelRemoveTarget()
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildInSideModelEx(self.discipleModelRoot,modelParams,0.85,nil,0,0,false,true)

local allnum=0
local ratelist={}
local lookup={6,5,4,3,2,1}
local polygonMaxValue=cfgHelper.getglobal1('discipleattrex_max')
for i,v in ipairs(baseData.attrList)do
local a=v==0 and 1 or v
allnum=allnum+a
local aa=a
if aa>polygonMaxValue then
aa=polygonMaxValue
end
ratelist[lookup[i]]=aa/polygonMaxValue
end
self.alllAttrPointNumText:setText(FMT.fmt('总值：{0}',allnum))
local wiget=self.polygonAttrPanel:getChildWidgetBase()
for i=1,6 do
local idx=i-1
local attrType=i
local v=baseData.attrList[attrType]==0 and 1 or baseData.attrList[attrType]
wiget:SetChildText(idx,FMT.fmt('{0}\n<color=#549327>{1}</color>',UIDiscipleModel:discipleBaseAttrName(attrType),v))
end
wiget:SetChildUIPolygonImage(6,ratelist,0)
local color=dzData.color
local polygonIcon='image_shuxingtu_'..color
wiget:SetChildCSImageSprite(7,globalABLookup.diciplemain,polygonIcon)

self:refreshPorSkill()

self:freshEquips()
end

function UIOtherDiscipleAttrWin:refreshPorSkill()
local disguid=self.disciple_guid
local dzData=otherPlayerModel:getDZData(disguid)
local baseData=dzData.base

local proskilllist=baseData.proskillList
self.proSkillGrid:setChildLayoutGroupCreateItems(#proSkillSort)
local gridlist=self.proSkillGrid:getChildLayoutGroupGridList()
local c=gridlist.Count
if c>0 then
for i=1,c do
local ty=proSkillSort[i]
local item=gridlist[i-1]
local d=proskilllist[ty]

local name=cfgHelper.get2(cfg_discipleproskillconfig_get,ty,'name')
item:SetChildText(1,name)

item:SetChildText(2,FMT.fmt('{0}级',d.level))

local icon=cfgHelper.get2(cfg_discipleproskillconfig_get,ty,'icon')
item:SetChildCSImageSprite(0,globalABLookup.proskill,'image_gongzhongtp_'..icon)
end
end
end



function UIOtherDiscipleAttrWin:freshEquips()
local disguid=self.disciple_guid
local fbData=UIFuLuFangModel:getFubaoData(disguid,1)
self:fillFubaoItem(fbData,0)
fbData=UIFuLuFangModel:getFubaoData(disguid,2)
self:fillFubaoItem(fbData,1)

self:fillVocEquipItem()

self:fillClothingItem()

self:fillMountItem()

self:fillLingShouItem()
end

function UIOtherDiscipleAttrWin:fillFubaoItem(equip,equipSlotIdx)
local prop={}
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local jinglianStr=''
local stage=''
local iconName
if itemsConfig.isFubao(itemid)then
stage=itemConfig.stage and FMT.fmt('{0}阶',itemConfig.stage)or''
iconName=iconHelper.getIconName(itemid)
end
prop[PropIndex(DataPropKey.eWidgetQuality,_fuBaoItemWidgetIdx.cmpItemQualityIdx)]=color
prop[PropIndex(DataPropKey.eWidgetIcon,_fuBaoItemWidgetIdx.cmpItemIconIdx)]=iconName
prop[PropIndex(DataPropKey.eWidgetText,_fuBaoItemWidgetIdx.cmpItemTxtCount)]=jinglianStr
prop[PropIndex(DataPropKey.eWidgetActive,_fuBaoItemWidgetIdx.cmpItemName)]=false
prop[PropIndex(DataPropKey.eWidgetText,_fuBaoItemWidgetIdx.cmpItemStage)]=stage
prop[PropIndex(DataPropKey.eWidgetActive,_fuBaoItemWidgetIdx.cmpItemStageBg)]=stage~=''
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=itemguid or-1
else
prop[PropIndex(DataPropKey.eWidgetActive,_fuBaoItemWidgetIdx.cmpItemQualityIdx)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_fuBaoItemWidgetIdx.cmpItemIconIdx)]=false
prop[PropIndex(DataPropKey.eWidgetText,_fuBaoItemWidgetIdx.cmpItemTxtCount)]=''
prop[PropIndex(DataPropKey.eWidgetActive,_fuBaoItemWidgetIdx.cmpItemName)]=true
prop[PropIndex(DataPropKey.eWidgetText,_fuBaoItemWidgetIdx.cmpItemStage)]=''
prop[PropIndex(DataPropKey.eWidgetActive,_fuBaoItemWidgetIdx.cmpItemStageBg)]=false
prop[DataPropKey.eItemID]=-1
prop[DataPropKey.eItemSeries]=-1
end
self.equipListWidget:SetChildPropData(equipSlotIdx,prop)
end

function UIOtherDiscipleAttrWin:fillVocEquipItem()
local disguid=self.disciple_guid
local slotIdx=_vocEquipSlotIdx
local equipType=EQUIP_TYPE.eVocEquip
local equip=otherPlayerModel:getDZEquipData(disguid,equipType)
local prop={}
local hasBetter=false
local widget=self.equipListWidget:GetChildWidgetBase(slotIdx)
local scaleTable={}
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local isLD=liandonModel:getIsLianDonItem(itemid)
local color=itemConfig.color
local jinglianStr=''
local iconName
local isLock=bagHelper.isLock(equip)
local isFabao=false
local stage=itemConfig.stage

local showStage=false
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local xmstageStr=''
local star=0
local reddot=false
local suitIconName=''
if itemsConfig.isVocEquip(itemid)then
local jinglianlv=equip.itemData and equip.itemData.enhancelv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=itemsModel.getIconName(equip)

end

widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~=''or xmstageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,hasBetter or reddot)
widget:SetChildActive(_itemWidgetIdx.cmpLock,isLock)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)
else
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,hasBetter)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)

widget:SetChildScale(_itemWidgetIdx.cmpItemNew,Vector3(1,1,1))
end
for i,widget in ipairs(scaleTable)do
widget:SetChildDOScale(_itemWidgetIdx.cmpItemNew,1,0.5)
end
end

function UIOtherDiscipleAttrWin:onEquipItemClick(index,id,equipType,guid,attach)
if equipType==EQUIP_TYPE.eZhuZhan then
return self:onLingShouItemClick(id,equipType,guid,attach)
elseif id>0 then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchRoleItem,itemid=id,itemguid=guid,attach={diziguid=self.disciple_guid,pos=index}})
end
end

function UIOtherDiscipleAttrWin:onLingShouItemClick(id,equipType,guid,attach)
if id>0 then
local lsData=otherPlayerModel:getDZLingShouData(self.disciple_guid)
if lsData.isOther then
local dzData=otherPlayerModel:getDZBaseData(self.disciple_guid)
lingshouModel:applyLingShouAllWord_other(lsData)
lingshouModel:initAttrLookup_otherDz(lsData,dzData,true)
end
UIManager:showWindow('UILingShouTipsWin',{ls_guid=nil,lsData=lsData})
end
end

function UIOtherDiscipleAttrWin:fillClothingItem()
local diziguid=self.disciple_guid
local slotIdx=4
local widget=self.equipListWidget:GetChildWidgetBase(slotIdx)

local dzdata=otherPlayerModel:getDZData(diziguid)
local equip=dzdata.equipLookup[EQUIP_TYPE.eShiZhuang]

if not ClothingHelper.checkDiziConfig(dzdata.base.id)then
widget:SetChildActive(-1,false)
return
end

widget:SetChildActive(-1,true)
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=itemsModel.getIconName(equip)

local star=equip.itemData.star

widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)
widget:SetChildActive(10,false)
widget:SetChildStarNumber(11,star)
else
local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eClothing)
local showAdd=false
if self.showType==dicipleType.eSystem then
showAdd=true
end
local isnew=false

widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,showAdd)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,isnew)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,not isOpen)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
widget:SetChildActive(10,true)
widget:SetChildStarNumber(11,0)
end
if equip then

end
end


function UIOtherDiscipleAttrWin:fillMountItem()
local diziguid=self.disciple_guid
local slotIdx=2
local widget=self.equipListWidget:GetChildWidgetBase(slotIdx)

local dzdata=otherPlayerModel:getDZData(diziguid)

local equip=(dzdata.base.mountlistlen or 0)>0 and dzdata.base.mountList[1]
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=iconHelper.getIconName(itemid)
local isLD=liandonModel:getIsLianDonItem(itemid)

widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,isLD)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)
else
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end
end

function UIOtherDiscipleAttrWin:fillLingShouItem()
local diziguid=self.disciple_guid
local lsData=otherPlayerModel:getDZLingShouData(diziguid)
local equipSlotIdx=_lingshouSlotIdx
local widget=self.equipListWidget:GetChildWidgetBase(equipSlotIdx)
if lsData then

local color=lingshouModel.getColorEx(lsData)
widget:SetChildQulaity(_itemWidgetIdx.cmpItemQualityIdx,color)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,true)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)

widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetBaseItemChildID(-1,lsData.id)
widget:SetBaseItemChildGUID(-1,-1)
else
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)


widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)

widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)

widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)

widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end

if lsData then
comHelper.setChildModelRawImage_lingshou(widget,lsData.id,_itemWidgetIdx.cmpItemIconIdx,0,eHeadCenterType.eHead,1)
end
end

