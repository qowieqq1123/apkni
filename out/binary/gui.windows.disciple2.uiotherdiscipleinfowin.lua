







def_class("UIOtherDiscipleInfoWin",UIWindowBase)









function UIOtherDiscipleInfoWin:bindComponents()

self.root=UIObject.get(self,0)
self.discipleModelRoot=UIObject.get(self,1)
self.discipleNameText=UIText.get(self,2)
self.discipleJobIcon=UIImage.get(self,3)
self.discipleFightTxt=UIText.get(self,4)
self.equipslist=UIObject.get(self,5)
self.jingjieText=UIText.get(self,6)
self.liantiText=UIText.get(self,7)
self.jobSkillGrid=UIObject.get(self,8)
self.gfSlot1=UIObject.get(self,9)
self.gfSlot2=UIObject.get(self,10)
self.descListPanel=UIObject.get(self,11)
self.attrGrid=UIObject.get(self,12)
self.jobText=UIText.get(self,13)
self.specialBg5=UIObject.get(self,14)



end


function UIOtherDiscipleInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.discipleNameText);self.discipleNameText=nil;
_UIObject_release(self.discipleJobIcon);self.discipleJobIcon=nil;
_UIObject_release(self.discipleFightTxt);self.discipleFightTxt=nil;
_UIObject_release(self.equipslist);self.equipslist=nil;
_UIObject_release(self.jingjieText);self.jingjieText=nil;
_UIObject_release(self.liantiText);self.liantiText=nil;
_UIObject_release(self.jobSkillGrid);self.jobSkillGrid=nil;
_UIObject_release(self.gfSlot1);self.gfSlot1=nil;
_UIObject_release(self.gfSlot2);self.gfSlot2=nil;
_UIObject_release(self.descListPanel);self.descListPanel=nil;
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.jobText);self.jobText=nil;
_UIObject_release(self.specialBg5);self.specialBg5=nil;
end
















local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemTxtCount=2,
cmpItemName=3,
cmpItemStage=4,
cmpItemStageBg=5,
cmpFabaoTag=6,
cmpCountBg=7,
cmpStar=8,
cmpSuitIcon=9,
cmpLiandon=10,
xmicons=11,
xmstagetxt=12,
}

local equipSlotIndex={
[EQUIP_TYPE.eWeapon]=0,
[EQUIP_TYPE.eClothes]=1,
[EQUIP_TYPE.eCap]=2,
[EQUIP_TYPE.eShoot]=3,
[EQUIP_TYPE.eFabao]=4,
[EQUIP_TYPE.eDaoBing]=5,
}
local abname="ui/windows/equip/chongzhu_atlas_pak.ab"

function UIOtherDiscipleInfoWin:onLoaded(...)
self:bindComponents()

self.equipListWidget=self.equipslist:getChildWidgetBase()
for equipType,idx in ipairs(equipSlotIndex)do
self.equipListWidget:SetBaseItemClickEvent(idx,function(...)self:onBaseItemClick(...)end)
self.equipListWidget:SetBaseItemChildIndex(idx,equipType)
end
end


function UIOtherDiscipleInfoWin:__delete()
self:unbindComponents()
end


function UIOtherDiscipleInfoWin:onHide()

end




function UIOtherDiscipleInfoWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid

self:refreshInfo()
end

function UIOtherDiscipleInfoWin:onChangeDisciple(dis_guid)
self:onShow({guid=dis_guid})
end

function UIOtherDiscipleInfoWin:refreshInfo()
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

local jjstr=FMT.fmt('境界：<color=#171311>{0}</color>',UIDiscipleModel.getJJNameCommon(baseData.jingjielv,3))
self.jingjieText:setText(jjstr)

local ltstr=FMT.fmt('炼体：<color=#171311>{0}</color>',UIDiscipleModel.getLTNameCommon(baseData.liantilv,3))
self.liantiText:setText(ltstr)

local jobname=FMT.fmt('职业：<color=#171311>{0}</color>',UIDiscipleModel:getJobName(image.job))
self.jobText:setText(jobname)

local groupid=baseData.vocsgidx
local jobSkillList=UIDiscipleModel:getDiscipleJobSkillListEx(groupid,image.job,baseData.jingjielv,baseData)
self.jobSkillGrid:setChildLayoutGroupCreateItems(#jobSkillList)
local gridlist=self.jobSkillGrid:getChildLayoutGroupGridList()
local c=gridlist.Count
if c>0 then
for i=1,c do
local item=gridlist[i-1]
local d=jobSkillList[i]
local skillID=d[1]
local skillLv=d[2]
local skillCfg
skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
local islock=skillLv<=0

local icon=skillModel.getSkillIconChange(skillCfg,baseData)
item:SetChildIcon(0,iconHelper.getSkillIcon(icon),false)

local isgray=islock
item:SetChildImageExGray(0,isgray)

local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(1,is_bd)

item:SetChildActive(4,not islock)
if not islock then
item:SetChildText(2,skillModel:getSkillLvStr(skillLv))
end

item:SetChildActive(5,islock)

item:SetChildButtonClick(3,function()
self:onSkillItemClick(eSkillTipsType.eDZSkill,skillID,skillLv)
end)
end
end

local gflist={}
for i,v in ipairs(baseData.gongfaidList)do
local gfid=v
local gflv=0
if gfid>0 then gflv=baseData.gongfaListlookup[gfid].param_2 end
gflist[i]={gfid,gflv}
end
self:refreshGFSkillSlot(gflist)

self.desclist=UIDiscipleModel:getDiscipleSpecialityConfigByData(baseData,true)
local dataNum=#self.desclist
self.descListPanel:setChildLayoutGroupCreateItems(dataNum)
local gridlist=self.descListPanel:getChildLayoutGroupGridList()
local count=gridlist.Count
if count>0 then
for i=1,count do
local cfg=self.desclist[i]
local item=gridlist[i-1]
UIDiscipleModel.refreshSpecialityItemExx(item,cfg)
item:SetChildButtonClick(1,function()
self:onDescSlotClick(i)
end)
end
end

local attrsShow=cfgHelper.getdef(cfg_attributesconfig,'attrsShow')
local attrlist=UIDiscipleModel.getAttrListByType2(dzData.attrList,attrsShow,true)
self.attrGrid:setChildLayoutGroupCreateItems(#attrlist)
local gridlist=self.attrGrid:getChildLayoutGroupGridList()
local c=gridlist.Count
if c>0 then
for i=1,c do
local item=gridlist[i-1]
local attr=attrlist[i]
local attrType=attr[1]
local value=attr[2]
if value<0 then
value=0
end
local color_str='<color=#7d3b17>{0}</color> {1}'
item:SetChildText(0,helper.getAttributeStr2(attrType,value,nil,color_str))
end
end

self:freshEquips()
end



function UIOtherDiscipleInfoWin:freshEquips()
local guid=self.disciple_guid
for equipType,idx in ipairs(equipSlotIndex)do
local equip=otherPlayerModel:getDZEquipData(guid,equipType)
self:fillItem(equip,idx)
self:freshFabaoBg(equipType,equip)
end
end

function UIOtherDiscipleInfoWin:fillItem(equip,equipSlotIdx)
local prop={}
local widget=self.equipListWidget:GetChildWidgetBase(equipSlotIdx)
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local jinglianStr=''
local iconName
local isFabao=false
local stage=itemConfig.stage
local showStage=stage~=nil
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local xmstageStr=''
local star=0
local suitIconName=''
local isLD=false
widget:SetChildActive(_itemWidgetIdx.xmicons,false)
if itemsConfig.isFabao(itemid)then
isFabao=true
local jinglianlv=equip.itemData and equip.itemData.jilianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=itemsModel.getIconName(equip)
elseif itemsConfig.isEquip(itemid)then
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=iconHelper.getIconName(itemid)
suitIconName=equipsHelper.getEquipSuitIcon(equip)
isLD=liandonModel:getIsLianDonItem(itemid)

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
iconName=iconHelper.getIconName(itemid)
star=equip.itemData and equip.itemData.star or 0
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
stageStr=''
isLD=liandonModel:getIsLianDonItem(itemid)
end

if star>0 then
local starWidget=widget:GetChildWidgetBase(_itemWidgetIdx.cmpStar)
for i=1,5 do
if star>=i then
starWidget:SetChildAnimationStringID(i-1,'daobing',false)
end
end
end

widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,true)
widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildText(_itemWidgetIdx.xmstagetxt,xmstageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~=''or xmstageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,isFabao)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,isLD)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,star)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,star)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,suitIconName,false)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)
else

widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildText(_itemWidgetIdx.xmstagetxt,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,false)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,false)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,0)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,0)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,'',false)
widget:SetChildActive(_itemWidgetIdx.xmicons,false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end
end

function UIOtherDiscipleInfoWin:fillLingShouItem(lsData,equipSlotIdx)
local prop={}
local widget=self.equipListWidget:GetChildWidgetBase(equipSlotIdx)
if lsData then
local ls_guid=lsData.guid
local color=lingshouModel.getColorEx(lsData)

prop[PropIndex(DataPropKey.eWidgetQuality,_itemWidgetIdx.cmpItemQualityIdx)]=color
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemIconIdx)]=true
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtCount)]=''
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemName)]=false
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemStage)]=''
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemStageBg)]=false
prop[DataPropKey.eItemID]=lsData.id
prop[DataPropKey.eItemSeries]=ls_guid
else
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemQualityIdx)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemIconIdx)]=false
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtCount)]=''
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemName)]=true
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemStage)]=''
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemStageBg)]=false
prop[DataPropKey.eItemID]=-1
prop[DataPropKey.eItemSeries]=-1
end
self.equipListWidget:SetChildPropData(equipSlotIdx,prop)
if lsData then
comHelper.setChildModelRawImage_lingshou(widget,lsData.id,_itemWidgetIdx.cmpItemIconIdx,0,eHeadCenterType.eHead,1)
end
end

function UIOtherDiscipleInfoWin:freshFabaoBg(equipType,equip)
if equipType~=EQUIP_TYPE.eFabao then return end
local vis=false
if equip then
vis=fabaoConfig.isBenMingFabao(equip.itemid)
end
self.specialBg5:setActive(vis)
end

function UIOtherDiscipleInfoWin:onBaseItemClick(id,equipType,guid,attach)
if id>0 then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchRoleItem,itemguid=guid,attach={diziguid=self.disciple_guid}})
end
end

function UIOtherDiscipleInfoWin:onLingShouItemClick(id,equipType,guid,attach)
if id>0 then
local lsData=otherPlayerModel:getDZLingShouData(self.disciple_guid)
UIManager:showWindow('UILingShouTipsWin',{ls_guid=nil,lsData=lsData})
end
end



function UIOtherDiscipleInfoWin:onDescSlotClick(idx)
local disguid=self.disciple_guid
local dzData=otherPlayerModel:getDZData(disguid)
local baseData=dzData.base
local cfg=self.desclist[idx]
local item=self.descListPanel:getChildLayoutGroupGridItem(idx-1)

if UIDiscipleModel.onClickClientSpeciality(item,baseData,cfg,eDirectionType.eLeft)then
return
end

UIManager:showWindow('UISpecialityWin',{item=item,node='top',guidNetData=baseData,config=cfg,pivot=Vector2(0.5,0)})
end

function UIOtherDiscipleInfoWin:getGFSkillSlot(idx)
if idx==1 then
return self.gfSlot1
else
return self.gfSlot2
end
end

function UIOtherDiscipleInfoWin:refreshGFSkillSlot(gflist)
for i,gfData in ipairs(gflist)do
local slot=self:getGFSkillSlot(i)
local slotItem=slot:getChildWidgetBase()
local gfID=gfData[1]
local gflv=gfData[2]
local hasGF=gfID>0

slotItem:SetChildActive(3,not hasGF)
slotItem:SetChildActive(4,hasGF)
if hasGF then
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)









local gfIcon=cfg.icon
slotItem:SetChildIcon(0,iconHelper.getGongFaIcon(gfIcon),false)

local gfName=cfg.name
slotItem:SetChildText(1,gfName)

slotItem:SetChildText(2,FMT.fmt('{0}级',gflv))

local isLD=liandonModel:getLianDonLinkageIdByGFId(gfID)>0
slotItem:SetChildActive(6,isLD)
else
slotItem:SetChildActive(6,false)
end
slotItem:SetChildButtonClick(5,function()
self:onGfItemClick(gfID,gflv)
end)
end
end

function UIOtherDiscipleInfoWin:onSkillItemClick(skillType,skillID,skillLv)
if skillType==eSkillTipsType.eDZSkill then
local lookup=otherPlayerModel:getSkillLvPlusLookupExtra(self.disciple_guid,"tiandaoshu")
local lookup2=otherPlayerModel:getSkillLvPlusLookupExtra(self.disciple_guid,"vocequip")
local tdsExtraLv=lookup[skillID]
local vocEquipExtraLv=lookup2[skillID]

local args={skillID=skillID,skillLv=skillLv,attend=skillType,dis_guid=nil,changLv=false,tdsLv=tdsExtraLv,vocEquipAddLv=vocEquipExtraLv}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end
end

function UIOtherDiscipleInfoWin:onGfItemClick(gfID,gflv)
if gfID<=0 then return end

UIManager:showWindow('UIGongFaTipsTwoWin',{guid=nil,gfID=gfID,gfLevel=gflv})
end

function UIOtherDiscipleInfoWin:onDetailClick()
local disguid=self.disciple_guid
local dzData=otherPlayerModel:getDZData(disguid)
local attrLookup=UIDiscipleModel.getAttrListLookup(dzData.attrList)

local args={}
args.titleName='详细属性'
args.pos=1
args.extraWin='UICommonAttrDetailWin'
local extraParams={}
extraParams.attrLookup=attrLookup
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end