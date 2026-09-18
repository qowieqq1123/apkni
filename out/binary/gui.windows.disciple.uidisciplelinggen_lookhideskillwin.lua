







def_class("UIDiscipleLinggen_LookHideSkillWin",UIWindowBase)









function UIDiscipleLinggen_LookHideSkillWin:bindComponents()

self.root=UIObject.get(self,0)
self.item=UIBaseItem.get(self,1)
self.preBtn=UIButton.get(self,2)
self.nextBtn=UIButton.get(self,3)
self.attrPreview=UIObject.get(self,4)
self.attrscorllview=UIScrollView.get(self,5)
self.skillItem=UIObject.get(self,6)
self.attrlist=UIObject.get(self,7)
self.rightPanel=UIObject.get(self,8)
self.colorframe=UIImage.get(self,9)
self.gfItem=UIObject.get(self,10)
self.skillItem1=UIObject.get(self,11)
self.skillItem2=UIObject.get(self,12)
self.gfDescText=UIText.get(self,13)

self.preBtn:setButtonClick(function()self:onPreBtn()end)

self.nextBtn:setButtonClick(function()self:onNextBtn()end)



end


function UIDiscipleLinggen_LookHideSkillWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.preBtn);self.preBtn=nil;
_UIObject_release(self.nextBtn);self.nextBtn=nil;
_UIObject_release(self.attrPreview);self.attrPreview=nil;
_UIObject_release(self.attrscorllview);self.attrscorllview=nil;
_UIObject_release(self.skillItem);self.skillItem=nil;
_UIObject_release(self.attrlist);self.attrlist=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.colorframe);self.colorframe=nil;
_UIObject_release(self.gfItem);self.gfItem=nil;
_UIObject_release(self.skillItem1);self.skillItem1=nil;
_UIObject_release(self.skillItem2);self.skillItem2=nil;
_UIObject_release(self.gfDescText);self.gfDescText=nil;
end



















function UIDiscipleLinggen_LookHideSkillWin:onLoaded(...)
self:bindComponents()
end


function UIDiscipleLinggen_LookHideSkillWin:__delete()
self:unbindComponents()
end




function UIDiscipleLinggen_LookHideSkillWin:onShow(argtable,afterOnloaded)
self.boardList=argtable.boardList
self.index=argtable.index

self:refresh()

end


function UIDiscipleLinggen_LookHideSkillWin:onHide()

end

function UIDiscipleLinggen_LookHideSkillWin:refresh()
self:freshBtn()
self:refreshMain()
end

function UIDiscipleLinggen_LookHideSkillWin:refreshMain()
self:freshRecordItem()
self:freshAttrs()

self:freshGFInfo()
end


local CmpRecordItemIndex={
name=0,
type=1,
icon=2,
showAttrBtn=3,
desc=4,
quality=5,
}

function UIDiscipleLinggen_LookHideSkillWin:freshRecordItem()
local data=self.boardList[self.index]
local item=self.item:getWidgetBase()
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

function UIDiscipleLinggen_LookHideSkillWin:freshAttrs()
local data=self.boardList[self.index]
local attr=data.attr














self.attrlist:setChildLayoutGroupCreateItems(#attr,function(index)
local item=self.attrlist:getChildLayoutGroupGridItem(index-1)
local data=attr[index]
item:SetChildActive(-1,data~=nil)
if data then
local attrdata=data[1]
local attrname=helper.getAttributeName(attrdata[1])
local min=helper.getAttributeStrEx(attrdata[1],attrdata[2])
local max=helper.getAttributeStrEx(attrdata[1],attrdata[3])
local info=FMT.fmt("{0} +{1}~{2}",attrname,min*attrdata[4],max*attrdata[4])
item:SetChildText(0,info)
end
end)
end

function UIDiscipleLinggen_LookHideSkillWin:freshSkillPart()
local data=self.boardList[self.index]
self.skillItem:setActive(data.skillid~=nil or(data.gongfaid~=nil and next(data.gongfa or{})~=nil))

if data.additionskillid~=nil then
local skillID,addSkillLv
if next(data.gongfa or{})~=nil then
skillID,addSkillLv=next(data.gongfa)
else
skillID=data.skillid
addSkillLv=0
end
local hasSkill=skillID~=nil
local item=self.skillItem
item:setActive(hasSkill)
local maxGFLv=UIGongFaModel:getGFMaxLevel(data.gongfaid)
local itemWidget=item:getChildWidgetBase()
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
itemWidget:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
itemWidget:SetChildActive(1,is_bd)
itemWidget:SetChildText(2,skillCfg.name)

local skillLv=UIGongFaModel:getSkillLvInGongFa(data.gongfaid,maxGFLv,skillID)
if skillLv==nil then

skillLv=1
else
if skillLv>0 then
skillLv=skillModel:getSkillLv(skillID,skillLv)
end
end
skillLv=skillLv+addSkillLv
local lv_str=''
local lock_str=nil
if skillLv>0 then
lv_str=FMT.fmt('{0}级',skillLv)
else
if data.gongfa~=nil then
local skillActiveGfLv=UIGongFaModel:getGongFaLvBySkillLv(skillID,1,data.gongfa)
lock_str=FMT.fmt('功法{0}级解锁',skillActiveGfLv)
end
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

local descExList=skillModel:getSkillDescEx(skillID,skillLv)
local zmDescList={data.mz_desc}
for k,v in ipairs(zmDescList)do
zmDescList[k]=toColorStringX('#aae252',v)
end
descExList=table.concatTable(descExList,zmDescList)
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

function UIDiscipleLinggen_LookHideSkillWin:freshGFInfo()
local hiddenCfg=self.boardList[self.index]
local skillid,gfUpValue=next(hiddenCfg.gongfa or{})

if skillid and gfUpValue and hiddenCfg.gongfaid then
self.skillid=skillid
self.addSkillLv=gfUpValue
self.gfID=hiddenCfg.gongfaid
self:refreshSkillView()
self.colorframe:setActive(true)
elseif hiddenCfg.skillid and hiddenCfg.gongfaid then
self.gfID=hiddenCfg.gongfaid
self:refreshSkillView()
self.colorframe:setActive(true)
else
self.colorframe:setActive(false)
end
end

function UIDiscipleLinggen_LookHideSkillWin:getSkillItem(idx)
if idx==1 then
return self.skillItem1
else
return self.skillItem2
end
end

function UIDiscipleLinggen_LookHideSkillWin:refreshSkillView()
local hiddenCfg=self.boardList[self.index]
if self.skillid then
self.skills={self.skillid}
else
local gfCfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.gfID)
self.skills=gfCfg.skill
end

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












self.gfDescText:setText(cfg.desc)


for i=1,2 do
local maxGFLv=UIGongFaModel:getGFMaxLevel(self.gfID)
local skillID=self.skills[i]
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
skillLv=skillLv+(self.addSkillLv or 0)
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
if hiddenCfg.additionskillid and hiddenCfg.additionskillid==skillID then
local zmDesc=FMT.fmt("秘藏·{0}：{1}",hiddenCfg.name,hiddenCfg.mz_desc)
zmDesc=toColorStringX('#aae252',zmDesc)
table.insert(descExList,zmDesc)
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



function UIDiscipleLinggen_LookHideSkillWin:freshBtn()
self.preBtn:setActive(self.index~=1)
self.nextBtn:setActive(self.index~=#self.boardList)
end





function UIDiscipleLinggen_LookHideSkillWin:onPreBtn()
self.index=self.index-1
self:refresh()
end



function UIDiscipleLinggen_LookHideSkillWin:onNextBtn()
self.index=self.index+1
self:refresh()
end

