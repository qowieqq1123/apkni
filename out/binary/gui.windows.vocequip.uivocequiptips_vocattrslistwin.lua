







def_class("UIVocEquipTips_vocAttrsListWin",UIWindowBase)









function UIVocEquipTips_vocAttrsListWin:bindComponents()

self.root=UIObject.get(self,0)
self.mask=UIButton.get(self,1)
self.attrsScrollView=UIObject.get(self,2)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIVocEquipTips_vocAttrsListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.attrsScrollView);self.attrsScrollView=nil;
end
















local _this




function UIVocEquipTips_vocAttrsListWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIVocEquipTips_vocAttrsListWin:__delete()
_this=nil
self:unbindComponents()
end




function UIVocEquipTips_vocAttrsListWin:onShow(argtable,afterOnloaded)
local itemid=argtable.itemid
local itemguid=argtable.itemguid
local strengthenlv=argtable.level
local diziguid
local jobSkillList
if itemguid then
local equip=equipsHelper.getEquip(itemguid)
strengthenlv=equip and equip.itemData and equip.itemData.enhancelv or 0
diziguid=vocEquipModel:getDiziguidByItemguid(itemguid)
jobSkillList=diziguid and UIDiscipleModel:getDiscipleJobSkillList(diziguid)or nil
end
if not strengthenlv then
strengthenlv=0
end
local nextBreakLv=vocEquipHelper.getStrengthenNextBreakLvByItemid(itemid,strengthenlv)

local vocId=vocEquipHelper.getEquipVocId(itemid)
local vocAttrList=vocEquipHelper.getVocEquipAllVocAttrsByVocId(vocId,itemid)

self.attrsScrollView:setChildScrollViewCreateGrids(#vocAttrList,1)
local grids=self.attrsScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local attrItem=grids[i-1]
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
attrItem:SetChildActive(2,isNext)
if isNext then
local activeCntStr
activeCntStr=FMT.fmt("[突破{0}级激活]",level)
attrItem:SetChildText(1,activeCntStr)
end
else
attrItem:SetChildActive(-1,false)
end
end
end


function UIVocEquipTips_vocAttrsListWin:onHide()

end





function UIVocEquipTips_vocAttrsListWin:onMask()
self:closeSelf()
end

