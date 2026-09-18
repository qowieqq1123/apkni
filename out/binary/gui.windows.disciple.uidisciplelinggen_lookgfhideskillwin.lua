







def_class("UIDiscipleLinggen_LookGFHideSkillWin",UIWindowBase)









function UIDiscipleLinggen_LookGFHideSkillWin:bindComponents()

self.colorframe=UIImage.get(self,0)
self.fadeouttContent=UIObject.get(self,1)
self.gfDescText=UIText.get(self,2)
self.gfItem=UIObject.get(self,3)
self.item_1=UIBaseItem.get(self,4)
self.item_2=UIBaseItem.get(self,5)
self.item_3=UIBaseItem.get(self,6)
self.maxLevelTxt=UIText.get(self,7)
self.pageCollect=UIObject.get(self,8)
self.rightPanel=UIObject.get(self,9)
self.root=UIObject.get(self,10)
self.skillCondition=UIObject.get(self,11)
self.skillItem1=UIObject.get(self,12)
self.skillItem2=UIObject.get(self,13)
self.studyDesc=UIObject.get(self,14)
self.title1=UIObject.get(self,15)
self.title2=UIObject.get(self,16)
self.title3=UIObject.get(self,17)
self.title5=UIObject.get(self,18)
self.item={
self.item_1,
self.item_2,
self.item_3,
}



end


function UIDiscipleLinggen_LookGFHideSkillWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.colorframe);self.colorframe=nil;
_UIObject_release(self.fadeouttContent);self.fadeouttContent=nil;
_UIObject_release(self.gfDescText);self.gfDescText=nil;
_UIObject_release(self.gfItem);self.gfItem=nil;
_UIObject_release(self.item_1);self.item_1=nil;
_UIObject_release(self.item_2);self.item_2=nil;
_UIObject_release(self.item_3);self.item_3=nil;
_UIObject_release(self.maxLevelTxt);self.maxLevelTxt=nil;
_UIObject_release(self.pageCollect);self.pageCollect=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skillCondition);self.skillCondition=nil;
_UIObject_release(self.skillItem1);self.skillItem1=nil;
_UIObject_release(self.skillItem2);self.skillItem2=nil;
_UIObject_release(self.studyDesc);self.studyDesc=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.title3);self.title3=nil;
_UIObject_release(self.title5);self.title5=nil;
self.item=nil;
end



















function UIDiscipleLinggen_LookGFHideSkillWin:onLoaded(...)
self:bindComponents()
end


function UIDiscipleLinggen_LookGFHideSkillWin:__delete()
self:unbindComponents()
end




function UIDiscipleLinggen_LookGFHideSkillWin:onShow(argtable,afterOnloaded)
self.gfID=argtable.gfID
self.disciple_guid=argtable.disciple_guid
self.varyVal=argtable.varyVal

local gfSkills=cfgHelper.get2(cfg_disciplegongfaconfig_get,self.gfID,'skill')

self.hiddenSkills={}
self.hiddenSkillLookup={}


local additionGroup,hiddenCfg,_,lookup,varyVal
for index,skillid in ipairs(gfSkills)do
lookup={}
self.hiddenSkillLookup[skillid]=lookup
additionGroup=UIDiscipleModel:get_hiddenSkillGroup_AdditionSkill_SkillID(skillid)
if additionGroup then
for hindex,hiddeSkillnGroup in pairs(additionGroup)do
_,hiddenCfg=next(hiddeSkillnGroup)
if hiddenCfg then
varyVal=ELEMENT_TYPE:isVary(hiddenCfg.element[1])and 2 or 1
if self.varyVal==varyVal then
self.hiddenSkills[#self.hiddenSkills+1]=hiddenCfg
lookup[#lookup+1]=hiddenCfg
end
end
end
end
if#lookup>1 then
table.sort(lookup,function(a,b)
return a.id<b.id
end)
end
end
table.sort(self.hiddenSkills,function(a,b)
if a.color==b.color then
return a.id<b.id
else
return a.color>b.color
end
end)


self:refresh()
end


function UIDiscipleLinggen_LookGFHideSkillWin:onHide()

end

function UIDiscipleLinggen_LookGFHideSkillWin:refresh()
self:refreshMain()
end

function UIDiscipleLinggen_LookGFHideSkillWin:refreshMain()
self:freshRecordItems()

self:refreshSkillView()
end


function UIDiscipleLinggen_LookGFHideSkillWin:freshRecordItems()
for index,item in ipairs(self.item)do
local hSkillCfg=self.hiddenSkills[index]
local isShow=hSkillCfg~=nil
item:setActive(isShow)
if isShow then
local widget=item:getWidgetBase()
self:freshRecordItem(widget,hSkillCfg)
end
end
end

local CmpRecordItemIndex={
name=0,
type=1,
icon=2,
showAttrBtn=3,
desc=4,
quality=5,
}

function UIDiscipleLinggen_LookGFHideSkillWin:freshRecordItem(item,data)
local skillIconName=iconHelper.getSkillIcon(data.icon)
local desc=data.mz_desc or''

local elementIconName,ab=ELEMENT_TYPE.getVaryIcon(data.element)


local nameColor=UIDiscipleModel:getHoardNameColor(data.color)
item:SetChildText(CmpRecordItemIndex.name,toColorStringX(nameColor,data.name))
item:SetChildCSImageSprite(CmpRecordItemIndex.type,ab,elementIconName)
item:SetChildIcon(CmpRecordItemIndex.icon,skillIconName,false)
item:SetChildText(CmpRecordItemIndex.desc,desc)

local qualityName,qab=UIDiscipleModel:getHoardRecordQualityIcon(data.color)
item:SetChildCSImageSprite(CmpRecordItemIndex.quality,qab,qualityName)
end

































function UIDiscipleLinggen_LookGFHideSkillWin:getSkillItem(idx)
if idx==1 then
return self.skillItem1
else
return self.skillItem2
end
end

function UIDiscipleLinggen_LookGFHideSkillWin:refreshSkillView()
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.gfID)

self.colorframe:setSprite(globalABLookup.tipssprite,FMT.fmt('frame_tygftips_{0}',cfg.color))


local gfItemWidget=self.gfItem:getChildWidgetBase()
gfItemWidget:SetChildText(0,cfg.name)

local elements=UIGongFaModel:getGFElements(self.gfID)
local elementid=elements[1]
local elementIcon=ELEMENT_TYPE.getIcon(elementid)
gfItemWidget:SetChildCSImageSprite(1,globalABLookup.global,elementIcon)
gfItemWidget:SetChildText(2,ELEMENT_TYPE.getNameGF(elementid))

local faction=cfg.faction or FACTION_TYPE.eNone
local showfaction=faction~=FACTION_TYPE.eNone
gfItemWidget:SetChildActive(3,showfaction)
if showfaction then
local faction_icon=UIGongFaModel:getGFFactionIcon(faction)
gfItemWidget:SetChildCSImageSprite(3,globalABLookup.global,faction_icon)
end


local skils=cfg.skill
for i=1,2 do
local maxGFLv=UIGongFaModel:getGFMaxLevel(self.gfID)
local skillID=skils[i]
local hasSkill=skillID~=nil
local item=self:getSkillItem(i)
item:setActive(hasSkill)
if hasSkill then

local itemWidget=item:getChildWidgetBase()
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
itemWidget:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
itemWidget:SetChildActive(1,is_bd)
itemWidget:SetChildText(2,skillCfg.name)

local skillLv=UIGongFaModel:getSkillLvInGongFa(self.gfID,maxGFLv,skillID)
if skillLv==nil then

skillLv=1
else
if skillLv>0 then
skillLv=skillModel:getSkillLv(skillID,skillLv)
end
end
local lv_str=''
local lock_str=nil
if skillLv>0 then
lv_str=FMT.fmt('{0}级',skillLv)
else
local skillActiveGfLv=UIGongFaModel:getGongFaLvBySkillLv(skillID,1,self.gfID)
lock_str=FMT.fmt('功法{0}级解锁',skillActiveGfLv)
end
itemWidget:SetChildText(3,lv_str)

local isLock=lock_str~=nil
itemWidget:SetChildActive(8,isLock)
if isLock then
itemWidget:SetChildText(8,lock_str)
end

itemWidget:SetChildActive(7,isLock)

local desc_str=skillModel:getSkillDesc(skillID,skillLv)
itemWidget:SetChildText(4,desc_str)

local descExList=skillModel:getSkillDescEx(skillID,skillLv)or{}
local hgroup=self.hiddenSkillLookup[skillID]
if hgroup and next(hgroup)then
for index,hiddenCfg in ipairs(hgroup)do
local zmDesc=FMT.fmt("秘藏·{0}：{1}",hiddenCfg.name,hiddenCfg.mz_desc)
zmDesc=toColorStringX('#aae252',zmDesc)
table.insert(descExList,zmDesc)
end
end

local descExNum=0
if descExList~=nil then
descExNum=#descExList
end
local showDescEx=descExNum>0
itemWidget:SetChildActive(9,showDescEx)
if showDescEx then
itemWidget:SetChildLayoutGroupCreateItems(9,descExNum)
local descExGrid=itemWidget:GetChildLayoutGroupGridList(9)
for i=1,descExNum do
local descItem=descExGrid[i-1]
local txt=descExList[i]
descItem:SetChildText(0,txt)
end
end

local coolDown=skillModel:getSkillCooldownTime(skillID,skillLv)
local isCoolDown=coolDown>0
itemWidget:SetChildActive(5,isCoolDown)
if isCoolDown then
local cooldown_str=FMT.fmt('冷却：{0}回合',coolDown)
itemWidget:SetChildText(6,cooldown_str)
end
end
end

end





