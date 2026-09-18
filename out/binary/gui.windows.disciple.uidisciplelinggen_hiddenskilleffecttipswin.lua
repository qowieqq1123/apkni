







def_class("UIDiscipleLinggen_HiddenSkillEffectTipsWin",UIWindowBase)









function UIDiscipleLinggen_HiddenSkillEffectTipsWin:bindComponents()

self.blackImg=UIObject.get(self,0)
self.rightPanel=UIObject.get(self,1)
self.colorframe=UIImage.get(self,2)
self.gfItem=UIObject.get(self,3)
self.title5=UIObject.get(self,4)
self.pageCollect=UIObject.get(self,5)
self.title3=UIObject.get(self,6)
self.skillCondition=UIObject.get(self,7)
self.title2=UIObject.get(self,8)
self.skillItem2=UIObject.get(self,9)
self.skillItem1=UIObject.get(self,10)
self.title1=UIObject.get(self,11)
self.studyDesc=UIObject.get(self,12)
self.gfDescText=UIText.get(self,13)
self.fadeouttContent=UIObject.get(self,14)



end


function UIDiscipleLinggen_HiddenSkillEffectTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.colorframe);self.colorframe=nil;
_UIObject_release(self.gfItem);self.gfItem=nil;
_UIObject_release(self.title5);self.title5=nil;
_UIObject_release(self.pageCollect);self.pageCollect=nil;
_UIObject_release(self.title3);self.title3=nil;
_UIObject_release(self.skillCondition);self.skillCondition=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.skillItem2);self.skillItem2=nil;
_UIObject_release(self.skillItem1);self.skillItem1=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.studyDesc);self.studyDesc=nil;
_UIObject_release(self.gfDescText);self.gfDescText=nil;
_UIObject_release(self.fadeouttContent);self.fadeouttContent=nil;
end



















function UIDiscipleLinggen_HiddenSkillEffectTipsWin:onLoaded(...)
self:bindComponents()
end


function UIDiscipleLinggen_HiddenSkillEffectTipsWin:__delete()
self:unbindComponents()
end




function UIDiscipleLinggen_HiddenSkillEffectTipsWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.disciple_guid
self.skillid=argtable.skillid
self.addSkillLv=argtable.addSkillLv
self.gfID=argtable.gfID
self.item=argtable.item
self.offset=argtable.offset
self.isHasBackNumber=argtable.isHasBackNumber or 1

local directionType=argtable.directionType

self.blackImg:setActive(self.isHasBackNumber==1)

if self.skillid then
self.skills={self.skillid}
else
local gfCfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.gfID)
self.skills=gfCfg.skill
end

self.winlua:SetChildIconAlpha(self.blackImg:getID(),argtable.isAdapter and 0 or 255)
if argtable.isAdapter then
self:showPosition(self.item,directionType)
end

self:refreshSkillView()
end


function UIDiscipleLinggen_HiddenSkillEffectTipsWin:onHide()

end

function UIDiscipleLinggen_HiddenSkillEffectTipsWin:refreshSkillView()
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

local descExList=skillModel:getSkillDescEx(skillID,skillLv)
local zmDescList=UIDiscipleModel:getDiscipleHoardDescBySkillId(self.disciple_guid,skillID)

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


















































































end

function UIDiscipleLinggen_HiddenSkillEffectTipsWin:showPosition(item,directionType)
local screenPoint=item:GetChildScreenPointToLocalPointRectangle(-1)
local itemTrans=item.transform
local itemSize=itemTrans.sizeDelta
local itemPivot=itemTrans.pivot

local selfTrans=self.colorframe:getTransform()
local selfSize=selfTrans.sizeDelta

local _screen=UnityEngine.Screen
local screenWidth=_screen.width
local screenHeight=_screen.height

if directionType==nil then
if screenPoint.x>0 then
if screenPoint.x+itemSize.x/2+selfSize.x<screenWidth/4 then
directionType=eDirectionType.eRight
else
directionType=eDirectionType.eLeft
end
else
if screenPoint.x-itemSize.x/2-selfSize.x>-screenWidth/4 then
directionType=eDirectionType.eLeft
else
directionType=eDirectionType.eRight
end
end
end


local itemOffx=0
local itemOffy=0
local offsetX=0
local offsetY=0
directionType=directionType or eDirectionType.eLeft
if directionType==eDirectionType.eBottom or directionType==eDirectionType.eTop then
if itemPivot.x~=0.5 then
itemOffx=itemPivot.x==0 and itemSize.x/2 or-itemSize.x/2
end
offsetX=itemOffx
elseif directionType==eDirectionType.eLeft or directionType==eDirectionType.eRight then
if itemPivot.y~=0.5 then
itemOffy=itemPivot.y==0 and itemSize.y/2 or-itemSize.y/2
end
offsetY=itemOffy
end

if directionType==eDirectionType.eBottom then
if itemPivot.y~=0 then
itemOffy=itemPivot.y==0.5 and-itemSize.y/2 or-itemSize.y
end
offsetY=-selfSize.y/2+itemOffy
elseif directionType==eDirectionType.eTop then
if itemPivot.y~=1 then
itemOffy=itemPivot.y==0.5 and itemSize.y/2 or itemSize.y
end
offsetY=selfSize.y/2+itemOffy
elseif directionType==eDirectionType.eLeft then
if itemPivot.x~=0 then
itemOffx=itemPivot.x==0.5 and-itemSize.x/2 or-itemSize.x
end
offsetX=-selfSize.x/2+itemOffx
elseif directionType==eDirectionType.eRight then
if itemPivot.x~=1 then
itemOffx=itemPivot.x==0.5 and itemSize.x/2 or itemSize.x
end
offsetX=selfSize.x/2+itemOffx
end
local rootPosX=screenPoint.x+offsetX+self.offset.x
local rootPosY=screenPoint.y+offsetY+self.offset.y

self.winlua:SetChildLocalPosition(self.colorframe:getID(),Vector3(rootPosX,rootPosY,0))
end

function UIDiscipleLinggen_HiddenSkillEffectTipsWin:getSkillItem(idx)
if idx==1 then
return self.skillItem1
else
return self.skillItem2
end
end



