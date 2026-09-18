







def_class("tipsChildVocEquipVocAttr",UICloneObject)





tipsChildVocEquipVocAttr.abName="ui/windows/tips/child/tipschildvocequipvocattr.ab"

tipsChildVocEquipVocAttr.assetName="tipsChildVocEquipVocAttr"


function tipsChildVocEquipVocAttr:bindComponents()

self.line=UIObject.get(self,0)
self.title=UIText.get(self,1)

end


function tipsChildVocEquipVocAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
end





local _this




function tipsChildVocEquipVocAttr:onLoaded(...)
_this=self
self:bindComponents()
end


function tipsChildVocEquipVocAttr:__delete()
_this=nil
self:unbindComponents()
end




function tipsChildVocEquipVocAttr:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local itemConfig=itemsConfig.getConfig(itemid)
local equip=equipsHelper.getEquip(itemguid)
self.showEnhancelv=attach and attach.showEnhancelv

local diziguid
local jobSkillList
local vocId=itemConfig.type1
local vocAttrList=vocEquipHelper.getVocEquipAllVocAttrsByVocId(vocId,itemid)
local strengthenlv=equip and equip.itemData and equip.itemData.enhancelv or 0
if self.showEnhancelv and self.showEnhancelv>0 then
strengthenlv=self.showEnhancelv
end
local nextBreakLv=vocEquipHelper.getStrengthenNextBreakLvByItemid(itemid,strengthenlv)
if equip then
diziguid=vocEquipModel:getDiziguidByItemguid(itemguid)
jobSkillList=diziguid and UIDiscipleModel:getDiscipleJobSkillList(diziguid)or nil
end

self.widget:SetChildLayoutGroupCreateItems(-1,#vocAttrList,function(i)
if not _this then return end
local attrItem=_this.widget:GetChildLayoutGroupGridItem(-1,i-1)
local attrData=vocAttrList[i]
if attrData then
attrItem:SetChildActive(-1,true)
local attrName=attrData.attrName
local attrValueStr=attrData.attrValueStr
local level=attrData.level
local isActive=strengthenlv>=level
local isNext=level==nextBreakLv+1
local skillPosIndex=attrData.skillPosIndex
if skillPosIndex then
local skillData=jobSkillList and jobSkillList[skillPosIndex+2]or nil
if skillData then
local skillId=skillData[1]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
local skillName=skillCfg.name
if isActive then
attrName=FMT.fmt("<color=#fff600>[{0}]</color>等级",skillName)
else
attrName=FMT.fmt("[{0}]等级",skillName)
end
end
end

if not attrName or not attrValueStr then
local attrId=attrData.attrId
local attrValue=attrData.attrValue
attrName,attrValueStr=equipsHelper.getAttr(attrId,attrValue)
if attrValue>0 then
attrValueStr=string.format("+%s",attrValueStr)
end
end

local str=string.format("%s：%s",attrName,attrValueStr)
if isActive then
str=FMT.cfmt2("#ffba00",str)
end
attrItem:SetChildText(0,str)

attrItem:SetChildActive(1,isNext)
if isNext then
local activeCntStr
activeCntStr=FMT.fmt("<color=#fd8950>[突破{0}级激活]</color>",level)
attrItem:SetChildText(1,activeCntStr)
end
else
attrItem:SetChildActive(-1,false)
end
end)
self.line:setActive(not self:isLastItem())
end


function tipsChildVocEquipVocAttr:onHide()

end

function tipsChildVocEquipVocAttr:onRecycle()
self.line:setActive(not self:isLastItem())
end

