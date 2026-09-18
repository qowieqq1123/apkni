







def_class("UIOtherDiscipleInfoWin_SystemZongMen",UIWindowBase)









function UIOtherDiscipleInfoWin_SystemZongMen:bindComponents()

self.root=UIObject.get(self,0)
self.jingjieText=UIText.get(self,1)
self.liantiText=UIText.get(self,2)
self.jobText=UIText.get(self,3)
self.jobSkillGrid=UIObject.get(self,4)
self.discipleModelRoot=UIObject.get(self,5)
self.posImg=UIImage.get(self,6)
self.attrGrid=UIObject.get(self,7)
self.gfSlot1=UIObject.get(self,8)
self.gfSlot2=UIObject.get(self,9)
self.discipleNameText=UIText.get(self,10)
self.discipleJobIcon=UIImage.get(self,11)
self.descListPanel=UIObject.get(self,12)



end


function UIOtherDiscipleInfoWin_SystemZongMen:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.jingjieText);self.jingjieText=nil;
_UIObject_release(self.liantiText);self.liantiText=nil;
_UIObject_release(self.jobText);self.jobText=nil;
_UIObject_release(self.jobSkillGrid);self.jobSkillGrid=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.posImg);self.posImg=nil;
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.gfSlot1);self.gfSlot1=nil;
_UIObject_release(self.gfSlot2);self.gfSlot2=nil;
_UIObject_release(self.discipleNameText);self.discipleNameText=nil;
_UIObject_release(self.discipleJobIcon);self.discipleJobIcon=nil;
_UIObject_release(self.descListPanel);self.descListPanel=nil;
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
}

local equipSlotIndex={
[EQUIP_TYPE.eWeapon]=0,
[EQUIP_TYPE.eClothes]=1,
[EQUIP_TYPE.eCap]=2,
[EQUIP_TYPE.eShoot]=3,
[EQUIP_TYPE.eFabao]=4,
[EQUIP_TYPE.eZhuZhan]=5,
}


function UIOtherDiscipleInfoWin_SystemZongMen:onLoaded(...)
self:bindComponents()
end


function UIOtherDiscipleInfoWin_SystemZongMen:__delete()
self:unbindComponents()
end


function UIOtherDiscipleInfoWin_SystemZongMen:onHide()

end




function UIOtherDiscipleInfoWin_SystemZongMen:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid
self.disciple_data=argtable.data
self:refreshInfo()
end

function UIOtherDiscipleInfoWin_SystemZongMen:onChangeDisciple(dis_guid,dis_data)
self:onShow({guid=dis_guid,data=dis_data})
end

function UIOtherDiscipleInfoWin_SystemZongMen:refreshInfo()
local disguid=self.disciple_guid
local dzData=self.disciple_data
local image=UIDiscipleModel.calculationDiscipleImageBase(dzData)


self.discipleNameText:setText(dzData.disciplename)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
self.discipleJobIcon:setSprite(globalABLookup.global,jobicon)

self.discipleModelRoot:setChildUIModelRemoveTarget()
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildInSideModelEx(self.discipleModelRoot,modelParams,0.85,nil,0,0,false,true)

local jjstr=FMT.fmt('境界：<color=#171311>{0}</color>',UIDiscipleModel.getJJNameCommon(dzData.jingjielv,3))
self.jingjieText:setText(jjstr)

local ltstr=FMT.fmt('炼体：<color=#171311>{0}</color>',UIDiscipleModel.getLTNameCommon(dzData.liantilv,3))
self.liantiText:setText(ltstr)

local jobname=FMT.fmt('职业：<color=#171311>{0}</color>',UIDiscipleModel:getJobName(image.job))
self.jobText:setText(jobname)

local groupid=dzData.vocsgidx
local jobSkillList=UIDiscipleModel:getDiscipleJobSkillListEx(groupid,image.job,dzData.jingjielv,dzData)
self.jobSkillGrid:setChildLayoutGroupCreateItems(#jobSkillList)
local gridlist=self.jobSkillGrid:getChildLayoutGroupGridList()
local c=gridlist.Count

local posType=UIDiscipleModel:getDisciplePostEX(dzData)
local posIconName=UISectPalaceModel:getPostIcon(posType)
self.posImg:setSprite(globalABLookup.diciplemain,posIconName)

if c>0 then
for i=1,c do
local item=gridlist[i-1]
local d=jobSkillList[i]
local skillID=d[1]
local skillLv=d[2]
local skillCfg
skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
local islock=skillLv<=0

local icon=skillModel.getSkillIconChange(skillCfg,dzData)
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
for i,v in ipairs(dzData.gongfaidList)do
local gfid=v
local gflv=0
if gfid>0 then
for j,w in ipairs(dzData.gongfaList)do
if w.param_1==gfid then
gflv=w.param_2
break
end
end
end
gflist[i]={gfid,gflv}
end
self:refreshGFSkillSlot(gflist)

self.desclist=UIDiscipleModel:getDiscipleSpecialityConfigByData(dzData)
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



self.attrGrid:setChildLayoutGroupCreateItems(4)
local item=self.attrGrid:getChildLayoutGroupGridItem(0)
item:SetChildText(0,FMT.fmt("<color=#7D3B17>立场</color>  {0}",cfgHelper.get2(cfg_disciplestandconfig_get,dzData.stand,'name')))
local item=self.attrGrid:getChildLayoutGroupGridItem(1)
item:SetChildText(0,FMT.fmt("<color=#7D3B17>负伤</color>  {0}",dzData.injury))
local item=self.attrGrid:getChildLayoutGroupGridItem(2)
item:SetChildText(0,FMT.fmt("<color=#7D3B17>性别</color>  {0}",SEX_TYPE.getName(image.sex)))
local item=self.attrGrid:getChildLayoutGroupGridItem(3)
item:SetChildText(0,FMT.fmt("<color=#7D3B17>忠诚</color>  {0}",dzData.loyalty))
end


function UIOtherDiscipleInfoWin_SystemZongMen:onDescSlotClick(idx)
local disguid=self.disciple_guid
local dzData=self.disciple_data
local cfg=self.desclist[idx]
local item=self.descListPanel:getChildLayoutGroupGridItem(idx-1)
UIDiscipleModel.refreshDiscipleSpecialityLookup(dzData)
UIManager:showWindow('UISpecialityWin',{item=item,node='top',guidNetData=dzData,config=cfg,pivot=Vector2(0.5,0)})
end

function UIOtherDiscipleInfoWin_SystemZongMen:getGFSkillSlot(idx)
if idx==1 then
return self.gfSlot1
else
return self.gfSlot2
end
end

function UIOtherDiscipleInfoWin_SystemZongMen:refreshGFSkillSlot(gflist)
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
end
slotItem:SetChildButtonClick(5,function()
self:onGfItemClick(gfID,gflv)
end)
end
end

function UIOtherDiscipleInfoWin_SystemZongMen:onSkillItemClick(skillType,skillID,skillLv)
if skillType==eSkillTipsType.eDZSkill then

local args={skillID=skillID,skillLv=skillLv,attend=skillType,dis_guid=nil,changLv=false}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end
end

function UIOtherDiscipleInfoWin_SystemZongMen:onGfItemClick(gfID,gflv)
if gfID<=0 then return end
UIManager:showWindow('UIGongFaTipsTwoWin',{guid=nil,gfID=gfID,gfLevel=gflv})
end

function UIOtherDiscipleInfoWin_SystemZongMen:onDetailClick()
local disguid=self.disciple_guid
local dzData=self.disciple_data
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