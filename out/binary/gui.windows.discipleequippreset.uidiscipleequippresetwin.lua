







def_class("UIDiscipleEquipPresetWin",UIWindowBase)









function UIDiscipleEquipPresetWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.discipleList=UIScrollView.get(self,1)
self.emptyBg=UIObject.get(self,2)
self.emptyTips=UIText.get(self,3)
self.emptyTipsBg=UIObject.get(self,4)
self.emptyTipsMask=UIButton.get(self,5)
self.helpBtn=UIButton.get(self,6)
self.myPresetNum=UIText.get(self,7)
self.presetContent=UIObject.get(self,8)
self.saveBtn=UIButton.get(self,9)
self.totalPresetNum=UIText.get(self,10)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.emptyTipsMask:setButtonClick(function()self:onEmptyTipsMask()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.saveBtn:setButtonClick(function()self:onSaveBtn()end)



end


function UIDiscipleEquipPresetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.discipleList);self.discipleList=nil;
_UIObject_release(self.emptyBg);self.emptyBg=nil;
_UIObject_release(self.emptyTips);self.emptyTips=nil;
_UIObject_release(self.emptyTipsBg);self.emptyTipsBg=nil;
_UIObject_release(self.emptyTipsMask);self.emptyTipsMask=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.myPresetNum);self.myPresetNum=nil;
_UIObject_release(self.presetContent);self.presetContent=nil;
_UIObject_release(self.saveBtn);self.saveBtn=nil;
_UIObject_release(self.totalPresetNum);self.totalPresetNum=nil;
end


















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
ban=17,
exist=18,
}
local _this
local abname="ui/windows/equip/chongzhu_atlas_pak.ab"
local abName="ui/windows/discipleequippreset/equippreset_atlas_pak.ab"

function UIDiscipleEquipPresetWin:onLoaded(...)
self:bindComponents()
_this=self
self._on_select_dis=function(...)
self:on_select_dis(...)
end
self.discipleList:setClickAction(self._on_select_dis)
end


function UIDiscipleEquipPresetWin:__delete()
self:unbindComponents()
_this=nil
end




function UIDiscipleEquipPresetWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.dis_guid
self.disciplelist=argtable.disciplelist
self.curDisIndex=nil
if self.disciplelist==nil then
local sortType=UIDiscipleModel:getSaveSortType()
local sortCondition=UIDiscipleModel:getSaveSortCondition()
local sortOrder=eSortOrder.eDown
local list=discipleLookup:getSortDiscipleList(sortType,sortCondition,sortOrder)
self.disciplelist=list
end
if#self.disciplelist>0 then
if self.disciple_guid==nil then
self.curDisIndex=1
self.disciple_guid=self.disciplelist[self.curDisIndex].netData.net.discipleguid
else
for i,v in ipairs(self.disciplelist)do
local netdata=v.netData.net
if mathHelper.compareInt64(netdata.discipleguid,self.disciple_guid)then
self.curDisIndex=i
break
end
end
end
end
if self.disciple_guid~=nil then
self:refreshDisciplePreset()
else
self:closeSelf()
return
end
self:refreshDiscipleList()
end


function UIDiscipleEquipPresetWin:refreshDiscipleList()
local tNum=#self.disciplelist

self.discipleList:freshGridsNum(tNum,tNum,1,true)
for i=1,tNum do
local item=self.discipleList:getGridObjectByindex(i-1)
local netdata=self.disciplelist[i].netData.net
local discipleguid=netdata.discipleguid

comHelper.setChildModelHeadIconBG(item,0,discipleguid)

comHelper.setChildModelRawImage(item,discipleguid,1,0,eHeadCenterType.eHead)

local isSelect=self.curDisIndex==i
self:changItemSelect(item,i,isSelect)

item:SetChildActive(2,false)

item:SetChildActive(6,false)
end
self.discipleList:jumpToLockX(self.curDisIndex)
end

function UIDiscipleEquipPresetWin:changItemSelect(item,idx,isSelect)
if item==nil then
item=self.discipleList:getGridObjectByindex(idx-1)
end
item:SetChildActive(3,isSelect)
end

function UIDiscipleEquipPresetWin:on_select_dis(id,index,guid,attach)
if self.curDisIndex==index then return end

local old=self.curDisIndex
self.curDisIndex=index
if old then
self:changItemSelect(nil,old,false)
end
self:changItemSelect(nil,self.curDisIndex,true)

local netdata=self.disciplelist[self.curDisIndex].netData.net
local dis_guid=netdata.discipleguid
self.disciple_guid=dis_guid

self:refreshDisciplePreset()
end


function UIDiscipleEquipPresetWin:refreshDisciplePreset()
self.usedIdx=nil
self.enableError={}
self.presetDataList=discipleEquipPresetController:getDiscipleEquipPreset(self.disciple_guid)or{}
local discipleEquipPresetNum=#self.presetDataList
self.presetContent:setChildLayoutGroupCreateItems(discipleEquipPresetNum,function(index)
self:refreshDisciplePresetItem(index)
end)
self.emptyBg:setActive(discipleEquipPresetNum<=0)
local disciplePresetMax,totalPresetMax=discipleEquipPresetController:getEquipPresetMaxNum()
local totalEquipPresetNum=discipleEquipPresetController:getTotalEquipPresetNum()
local color1=discipleEquipPresetNum>=disciplePresetMax and"#C82C2C"or"#549327"
local color2=totalEquipPresetNum>=totalPresetMax and"#C82C2C"or"#549327"
self.myPresetNum:setText(string.format("本弟子配装方案：<color=%s>%d/%d</color>",color1,discipleEquipPresetNum,disciplePresetMax))
self.totalPresetNum:setText(string.format("宗门总配装方案：<color=%s>%d/%d</color>",color2,totalEquipPresetNum,totalPresetMax))
end

function UIDiscipleEquipPresetWin:refreshDisciplePresetItem(index)
local presetItem=self.presetContent:getChildLayoutGroupGridItem(index-1)
local presetData=self.presetDataList[index]
local isUsed=discipleEquipPresetController:checkDiscipleEquipPresetSame(self.disciple_guid,index)
if isUsed then
self.usedIdx=index
end
presetItem:SetChildText(0,index)
presetItem:SetChildText(1,presetData.presetName or"")
presetItem:SetChildButtonClick(2,function()
self:onRenamePreset(index)
end)
presetItem:SetChildButtonClick(3,function()
self:onDeletePreset(index)
end)
presetItem:SetChildButtonClick(4,function()
self:onDetailPreset(index)
end)
presetItem:SetChildButtonClick(5,function()
self:onUsePreset(index)
end)
presetItem:SetChildActive(5,not isUsed)
presetItem:SetChildActive(6,isUsed)
presetItem:SetChildCSImageSprite(17,globalABLookup.global,isUsed and"frame_djshuliangkuang_4"or"frame_djshuliangkuang_1")
presetItem:SetChildCSImageSprite(18,abName,isUsed and"image_yijianpeizhuang_2"or"image_yijianpeizhuang_3")

self:refreshPresetGongFa(presetItem,index)
self:refreshPresetFaBao(presetItem,index)
self:refreshPresetDaoBing(presetItem,index)
self:refreshPresetYuFu(presetItem,index)
self:refreshPresetVocEquip(presetItem,index)
self:refreshPresetEquipSuit(presetItem,index)
local typeMap={
eEquipPresetType.eEquipWeapon,
eEquipPresetType.eEquipClothes,
eEquipPresetType.eEquipCrown,
eEquipPresetType.eEquipShoes,
eEquipPresetType.eMount,
eEquipPresetType.eDress,
}
for _,presetType in ipairs(typeMap)do
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,index,presetType)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,index,presetType)
local otherUse=discipleEquipPresetController:checkDiscipleEquipPresetOtherUse(self.disciple_guid,index,presetType)
if(exist and not ban)or otherUse then
self.enableError[index]=true
end
end
end


function UIDiscipleEquipPresetWin:refreshPresetGongFa(presetItem,index)
if not presetItem then
presetItem=self.presetContent:getChildLayoutGroupGridItem(index-1)
end
local gfSlot1=presetItem:GetChildWidgetBase(7)
local gfID1=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,index,eEquipPresetType.eGongFa1)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,index,eEquipPresetType.eGongFa1)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,index,eEquipPresetType.eGongFa1)
if gfID1 and gfID1>0 and not ban then
self.enableError[index]=true
end
if gfID1 and gfID1>0 and exist then
local gfIcon1=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID1,'icon')
gfSlot1:SetChildIcon(0,iconHelper.getGongFaIcon(gfIcon1),false)
gfSlot1:SetChildImageExGray(0,not ban)
gfSlot1:SetChildActive(1,false)
gfSlot1:SetChildActive(2,not ban)
gfSlot1:SetChildActive(3,false)
gfSlot1:SetChildButtonClick(-1,function()
if not ban then
UIManager.error("弟子境界等级不足")
end
UIManager:showWindow('UIGongFaTipsWin',{guid=self.disciple_guid,gfID=gfID1,tipsType=3})
end)
else
gfSlot1:SetChildIcon(0,nil,false)
gfSlot1:SetChildImageExGray(0,false)
gfSlot1:SetChildActive(1,true)
gfSlot1:SetChildActive(2,false)
gfSlot1:SetChildActive(3,not exist)
gfSlot1:SetChildButtonClick(-1,function()
if not exist then
local screenPos=gfSlot1:GetChildUIScreenPos(2)
self:clickNotExistItem(screenPos,index,eEquipPresetType.eGongFa1)
end
end)
end

local gfSlot2=presetItem:GetChildWidgetBase(8)
local gfID2=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,index,eEquipPresetType.eGongFa2)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,index,eEquipPresetType.eGongFa2)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,index,eEquipPresetType.eGongFa2)
if gfID2 and gfID2>0 and not ban then
self.enableError[index]=true
end
if gfID2 and gfID2>0 and exist then
local gfIcon2=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID2,'icon')
gfSlot2:SetChildIcon(0,iconHelper.getGongFaIcon(gfIcon2),false)
gfSlot2:SetChildImageExGray(0,not ban)
gfSlot2:SetChildActive(1,false)
gfSlot2:SetChildActive(2,not ban)
gfSlot2:SetChildActive(3,false)
gfSlot2:SetChildButtonClick(-1,function()
if not ban then
UIManager.error("弟子境界等级不足")
end
UIManager:showWindow('UIGongFaTipsWin',{guid=self.disciple_guid,gfID=gfID2,tipsType=3})
end)
else
gfSlot2:SetChildIcon(0,nil,false)
gfSlot2:SetChildImageExGray(0,false)
gfSlot2:SetChildActive(1,true)
gfSlot2:SetChildActive(2,false)
gfSlot2:SetChildActive(3,not exist)
gfSlot2:SetChildButtonClick(-1,function()
if not exist then
local screenPos=gfSlot2:GetChildUIScreenPos(2)
self:clickNotExistItem(screenPos,index,eEquipPresetType.eGongFa2)
end
end)
end
end


function UIDiscipleEquipPresetWin:refreshPresetFaBao(presetItem,index)
if not presetItem then
presetItem=self.presetContent:getChildLayoutGroupGridItem(index-1)
end
local itemSlot=presetItem:GetChildWidgetBase(9)
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,index,eEquipPresetType.eFaBao)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,index,eEquipPresetType.eFaBao)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,index,eEquipPresetType.eFaBao)
local otherUse=discipleEquipPresetController:checkDiscipleEquipPresetOtherUse(self.disciple_guid,index,eEquipPresetType.eFaBao)
local equip=bagModel.getItem(itemguid)
if not equip then
equip=fabaoHelper.getFabao(itemguid)
end
self:fillItem(itemSlot,equip,index,eEquipPresetType.eFaBao,ban,exist,otherUse)
end


function UIDiscipleEquipPresetWin:refreshPresetDaoBing(presetItem,index)
if not presetItem then
presetItem=self.presetContent:getChildLayoutGroupGridItem(index-1)
end
local itemSlot=presetItem:GetChildWidgetBase(10)
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,index,eEquipPresetType.eDaoBing)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,index,eEquipPresetType.eDaoBing)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,index,eEquipPresetType.eDaoBing)
local otherUse=discipleEquipPresetController:checkDiscipleEquipPresetOtherUse(self.disciple_guid,index,eEquipPresetType.eDaoBing)
local equip=bagModel.getItem(itemguid)
if not equip then
equip=daobingModel:getEquip(itemguid)
end
self:fillItem(itemSlot,equip,index,eEquipPresetType.eDaoBing,ban,exist,otherUse)
end


function UIDiscipleEquipPresetWin:refreshPresetYuFu(presetItem,index)
if not presetItem then
presetItem=self.presetContent:getChildLayoutGroupGridItem(index-1)
end
local yfSlot1=presetItem:GetChildWidgetBase(11)
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,index,eEquipPresetType.eYuFu1)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,index,eEquipPresetType.eYuFu1)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,index,eEquipPresetType.eYuFu1)
local otherUse=discipleEquipPresetController:checkDiscipleEquipPresetOtherUse(self.disciple_guid,index,eEquipPresetType.eYuFu1)
local equip=bagModel.getItem(itemguid)
if not equip then
equip=UIFuLuFangModel:getItem(itemguid)
end
self:fillItem(yfSlot1,equip,index,eEquipPresetType.eYuFu1,ban,exist,otherUse)

local yfSlot2=presetItem:GetChildWidgetBase(12)
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,index,eEquipPresetType.eYuFu2)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,index,eEquipPresetType.eYuFu2)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,index,eEquipPresetType.eYuFu2)
local otherUse=discipleEquipPresetController:checkDiscipleEquipPresetOtherUse(self.disciple_guid,index,eEquipPresetType.eYuFu2)
local equip=bagModel.getItem(itemguid)
if not equip then
equip=UIFuLuFangModel:getItem(itemguid)
end
self:fillItem(yfSlot2,equip,index,eEquipPresetType.eYuFu2,ban,exist,otherUse)
end


function UIDiscipleEquipPresetWin:refreshPresetVocEquip(presetItem,index)
if not presetItem then
presetItem=self.presetContent:getChildLayoutGroupGridItem(index-1)
end
local itemSlot=presetItem:GetChildWidgetBase(13)
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,index,eEquipPresetType.eVocEquip)
local ban=discipleEquipPresetController:checkDiscipleEquipPresetBan(self.disciple_guid,index,eEquipPresetType.eVocEquip)
local exist=discipleEquipPresetController:checkDiscipleEquipPresetExist(self.disciple_guid,index,eEquipPresetType.eVocEquip)
local otherUse=discipleEquipPresetController:checkDiscipleEquipPresetOtherUse(self.disciple_guid,index,eEquipPresetType.eVocEquip)
local equip=bagModel.getItem(itemguid)
if not equip then
equip=vocEquipModel:getEquip(itemguid)
end
self:fillItem(itemSlot,equip,index,eEquipPresetType.eVocEquip,ban,exist,otherUse)
end


function UIDiscipleEquipPresetWin:refreshPresetEquipSuit(presetItem,index)
if not presetItem then
presetItem=self.presetContent:getChildLayoutGroupGridItem(index-1)
end
local typeMap={
{eEquipPresetType.eEquipWeapon,EQUIP_TYPE.eWeapon},
{eEquipPresetType.eEquipClothes,EQUIP_TYPE.eClothes},
{eEquipPresetType.eEquipCrown,EQUIP_TYPE.eCap},
{eEquipPresetType.eEquipShoes,EQUIP_TYPE.eShoot},
}
local suitList={}
for i,v in ipairs(typeMap)do
local presetType=v[1]
local itemguid=discipleEquipPresetController:getDiscipleEquipPresetGuid(self.disciple_guid,index,presetType)
local equip=bagModel.getItem(itemguid)
if not equip then
local equipType=v[2]
equip=equipsHelper.getEquipByDizi(self.disciple_guid,equipType)
end
if equip then
local suit=equip.itemData.suitid
if suit>0 then
suitList[suit]=(suitList[suit]or 0)+1
end
end
end
local slist={}
for k,v in pairs(suitList)do
if v>1 then
table.insert(slist,{k,2})
end
end
local suit=slist[1]
if suit then
local suitId=suit[1]
local iconName=equipsHelper.getEquipSuitIconById(suitId)
presetItem:SetChildIcon(15,iconName,false)
presetItem:SetChildActive(15,true)
else
presetItem:SetChildActive(15,false)
end
local suit=slist[2]
if suit then
local suitId=suit[1]
local iconName=equipsHelper.getEquipSuitIconById(suitId)
presetItem:SetChildIcon(16,iconName,false)
presetItem:SetChildActive(16,true)
else
presetItem:SetChildActive(16,false)
end
end

function UIDiscipleEquipPresetWin:fillItem(widget,equip,presetIdx,presetType,ban,exist,otherUse)
if(equip and not ban)or otherUse then
self.enableError[presetIdx]=true
end
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
local showStage=stage~=nil
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local xmstageStr=''
local star=0
local reddot=false
local suitIconName=''
widget:SetChildActive(_itemWidgetIdx.xmicons,false)
if itemsConfig.isFabao(itemid)then
isFabao=true
local jinglianlv=equip.itemData and equip.itemData.jilianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=itemsModel.getIconName(equip)
elseif itemsConfig.isEquip(itemid)then
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=itemsModel.getIconName(equip)
suitIconName=equipsHelper.getEquipSuitIcon(equip)
local isxmEquip=equipsHelper.getEquipXMTypebyItemid(itemid)
local asset=""
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
stageStr=''
xmstageStr=showStage and FMT.fmt('仙·{0}{1}',stage,stageTitile)or''
asset="image_dzzb_jinlian1"
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
stageStr=''
xmstageStr=showStage and FMT.fmt('魔·{0}{1}',stage,stageTitile)or''
asset="image_dzzb_moyan1"
end
local ninglianStar=equipsModel.getNingLianStar(equip)
if asset~=""and ninglianStar and ninglianStar>0 then
widget:SetChildActive(_itemWidgetIdx.xmicons,true)
local xmWidget=widget:GetChildWidgetBase(_itemWidgetIdx.xmicons)
for i=1,3 do
if ninglianStar>=i then
xmWidget:SetChildActive(i-1,true)
xmWidget:SetChildCSImageSprite(i-1,abname,asset)
end
end
end
elseif itemsConfig.isDaoBing(itemid)then
star=daobingModel:getStarLv(itemguid)
local jinglianlv=daobingModel:getJilianLv(itemguid)
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
stageStr=''
iconName=iconHelper.getIconName(itemid)
elseif itemsConfig.isVocEquip(itemid)then
local jinglianlv=equip.itemData and equip.itemData.enhancelv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=iconHelper.getIconName(itemid)
else
iconName=iconHelper.getIconName(itemid)
end

widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildText(_itemWidgetIdx.xmstagetxt,xmstageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~=''or xmstageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,isFabao)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,isLD)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,star)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,star)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,suitIconName,false)
widget:SetChildActive(_itemWidgetIdx.ban,not ban or otherUse)
widget:SetChildImageExGray(_itemWidgetIdx.cmpItemQualityIdx,not ban or otherUse)
widget:SetChildImageExGray(_itemWidgetIdx.cmpItemIconIdx,not ban or otherUse)
widget:SetChildActive(_itemWidgetIdx.exist,false)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)
widget:SetBaseItemClickEvent(-1,function(id,idx,guid,attach)
if not ban then
UIManager.error("弟子境界等级不足")
elseif otherUse then
UIManager.error("配装正在被其他弟子穿戴")
end
tipsManager.showTips({itemid=id,itemguid=guid})
end)


if star>0 then
local starWidget=widget:GetChildWidgetBase(_itemWidgetIdx.cmpStar)
for i=1,5 do
if star>=i then
starWidget:SetChildAnimationStringID(i-1,'daobing',false)
end
end
end
else
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildText(_itemWidgetIdx.xmstagetxt,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,false)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,false)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,0)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,0)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,'',false)
widget:SetChildActive(_itemWidgetIdx.xmicons,false)
widget:SetChildActive(_itemWidgetIdx.ban,false)
widget:SetChildActive(_itemWidgetIdx.exist,not exist)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
widget:SetBaseItemClickEvent(-1,function(id,idx,guid,attach)
if not exist then
local screenPos=widget:GetChildUIScreenPos(_itemWidgetIdx.ban)
self:clickNotExistItem(screenPos,presetIdx,presetType)
end
end)
end
end

function UIDiscipleEquipPresetWin:renameDisciplePresetCallback(discipleguid,presetIdx,name)
if self.disciple_guid==discipleguid then
local presetItem=self.presetContent:getChildLayoutGroupGridItem(presetIdx-1)
presetItem:SetChildText(1,name)
end
end


function UIDiscipleEquipPresetWin:onRenamePreset(presetIdx)
self:showWindow("UIDiscipleEquipPresetRenameWin",{self.disciple_guid,presetIdx})
end

function UIDiscipleEquipPresetWin:onDeletePreset(presetIdx)
local show_data={
type='UIDialouge',
title='提示',
content="删除方案后无法找回，是否删除？",
oktext='确定',
canceltext='取消',
okcallback=function()
discipleEquipPresetController:removeDiscipleEquipPreset(self.disciple_guid,presetIdx)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

function UIDiscipleEquipPresetWin:onDetailPreset(presetIdx)
self:showWindow("UIDiscipleEquipPresetDetailWin",{self.disciple_guid,presetIdx})
end

function UIDiscipleEquipPresetWin:onUsePreset(presetIdx)

local isLDLock=UIDiscipleModel:checkDZClientState(self.disciple_guid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end
if self.enableError[presetIdx]then
self:showWindow("UIDiscipleEquipPresetEnableTipsWin",{self.disciple_guid,presetIdx})
else
discipleEquipPresetController:enableDiscipleEquipPreset(self.disciple_guid,presetIdx)
end
end

function UIDiscipleEquipPresetWin:refreshDisciplePresetByIdx(presetIdx)
self:refreshDisciplePresetItem(presetIdx)
end

function UIDiscipleEquipPresetWin:clickNotExistItem(screenPos,presetIdx,presetType)
self.emptyPresetIdx=presetIdx
self.emptyPresetType=presetType
local tips="装备已被移除，可启用配装后修改"
if presetType==eEquipPresetType.eGongFa1 or presetType==eEquipPresetType.eGongFa2 then
tips="功法已被遗忘，可启用配装后修改"
end
self.emptyTipsBg:setChildUIScreenPos(Vector2(screenPos.x,screenPos.y+25))
self.emptyTips:setText(tips)
self.emptyTipsMask:setActive(true)
self.emptyTipsBg:setActive(true)
end


function UIDiscipleEquipPresetWin:onCloseBtn()
self:closeSelf()
end

function UIDiscipleEquipPresetWin:onHelpBtn()
local d={}
d.title='规则'
d.mode=3
d.showBlack=true
d.name='discipleequippreset_help_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIDiscipleEquipPresetWin:onSaveBtn()
if self.usedIdx then
UIManager.error("弟子已有相同的配装方案")
return
end
local presetNum=discipleEquipPresetController:getDiscipleEquipPresetNum(self.disciple_guid)
local totalEquipPresetNum=discipleEquipPresetController:getTotalEquipPresetNum()
local _,totalPresetMax=discipleEquipPresetController:getEquipPresetMaxNum()
if presetNum<=0 and totalEquipPresetNum>=totalPresetMax then
UIManager.error("宗门总配装方案已达到上限")
return
end
if not discipleEquipPresetController:checkDiscipleEquipPresetAnyone(self.disciple_guid)then
UIManager.error("弟子未装备任何配装，请先给弟子配装")
return
end
self:showWindow("UIDiscipleEquipPresetSaveWin",self.disciple_guid)
end

function UIDiscipleEquipPresetWin:onEmptyTipsMask()
self.emptyTipsMask:setActive(false)
self.emptyTipsBg:setActive(false)
discipleEquipPresetController:setDiscipleEquipPresetEmpty(self.disciple_guid,self.emptyPresetIdx,self.emptyPresetType)
end