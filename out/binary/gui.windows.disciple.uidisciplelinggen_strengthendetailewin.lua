







def_class("UIDiscipleLinggen_StrengthenDetaileWin",UIWindowBase)









function UIDiscipleLinggen_StrengthenDetaileWin:bindComponents()

self.leftBgSpine=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.leftroot=UIObject.get(self,2)
self.rightroot=UIObject.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.skillicon=UIObject.get(self,5)
self.skillname=UIText.get(self,6)
self.skilldesc=UIText.get(self,7)
self.hiddenSkillList=UIObject.get(self,8)
self.baseAttrList=UIObject.get(self,9)
self.spAttrList=UIObject.get(self,10)
self.skillroot=UIObject.get(self,11)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIDiscipleLinggen_StrengthenDetaileWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftBgSpine);self.leftBgSpine=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.leftroot);self.leftroot=nil;
_UIObject_release(self.rightroot);self.rightroot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.skillicon);self.skillicon=nil;
_UIObject_release(self.skillname);self.skillname=nil;
_UIObject_release(self.skilldesc);self.skilldesc=nil;
_UIObject_release(self.hiddenSkillList);self.hiddenSkillList=nil;
_UIObject_release(self.baseAttrList);self.baseAttrList=nil;
_UIObject_release(self.spAttrList);self.spAttrList=nil;
_UIObject_release(self.skillroot);self.skillroot=nil;
end
















local _this




function UIDiscipleLinggen_StrengthenDetaileWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIDiscipleLinggen_StrengthenDetaileWin:__delete()
self:unbindComponents()
_this=nil
end




function UIDiscipleLinggen_StrengthenDetaileWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.disciple_guid

self:statisticsData()
self:refresh()

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.leftBgSpine:setChildUIModelShowTarget(3037,1,{},eAnimationID.bd_stand,false,false,0,function()
self.root:setChildCanvasGroupDOFade(1,1,nil)
end)
end

end


function UIDiscipleLinggen_StrengthenDetaileWin:onHide()

end


function UIDiscipleLinggen_StrengthenDetaileWin:statisticsData()

local lglist,lglist_lookup,lglen=UIDiscipleModel:getDiscipleRealLevelLinggenData(self.disciple_guid)


local disciple_job=UIDiscipleModel:getDiscipleJob(self.disciple_guid)


local varySrid=UIDiscipleModel:getDiscipleVarysrid(self.disciple_guid)


self.baseAttrData={}

self.specialAttrData={}

local tjAttrFunc=function(attrData)
if attrData[1]<100 then
if self.baseAttrData[attrData[1]]then
self.baseAttrData[attrData[1]]=attrData[2]+self.baseAttrData[attrData[1]]
else
self.baseAttrData[attrData[1]]=attrData[2]
end
else
if self.specialAttrData[attrData[1]]then
self.specialAttrData[attrData[1]]=attrData[2]+self.specialAttrData[attrData[1]]
else
self.specialAttrData[attrData[1]]=attrData[2]
end
end
end


for k,lgdata in pairs(lglist)do
local lgLvCfg=cfgHelper.get3(cfg_disciplespiritrootlevelconfig_get,lglen,lgdata.type,lgdata.lv)

for _,attrData in pairs(lgLvCfg.attr or{})do
tjAttrFunc(attrData)
end
end


if varySrid>0 and UIDiscipleModel:checkDiscipleAssertVary(self.disciple_guid)then
local varyLgCfg=cfgHelper.get2(cfg_disciplespiritrootvaryconfig_get,lglen,varySrid)
for _,attrData in pairs(varyLgCfg.attr)do
tjAttrFunc(attrData)
end
end

self.hoardDatas={}
local hoardDatasTemp=UIDiscipleModel:getDiscipleHoardEx(self.disciple_guid)
for k,hoardData in pairs(hoardDatasTemp)do
if hoardData.activelistlen>0 then
table.insert(self.hoardDatas,hoardData)

local pdata=hoardData.activeList[1]
local hoardCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,pdata.hoardid)
local isAssert=UIDiscipleModel:checkHiddenSkillAssert(self.disciple_guid,pdata.hoardid)
if hoardCfg.skillid and isAssert then
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,hoardCfg.skillid)
if skillCfg.attr then
local attrs=skillCfg.attr[pdata.skilllv]or{}
for k,attrData in pairs(attrs)do
tjAttrFunc(attrData)
end
end

if pdata.len1>0 then
for k,v in pairs(pdata.list1)do
local attrData={v.param_1,v.param_2}
tjAttrFunc(attrData)
end
end

if pdata.len2>0 then
for k,v in pairs(pdata.list2)do
local attrData={v.param_1,v.param_2}
tjAttrFunc(attrData)
end
end
end
end
end


local tempbase={}
for k,v in pairs(self.baseAttrData)do
table.insert(tempbase,{k,v})
end
self.baseAttrData=tempbase

local attrStrList={}

for k,v in pairs(self.specialAttrData)do
local typeName=helper.getAttributeName(k)
local value=helper.getAttributeStrEx(k,v)
table.insert(attrStrList,{typeName,value})
end

for k,lgdata in pairs(lglist)do
local lgLvCfg=cfgHelper.get3(cfg_disciplespiritrootlevelconfig_get,lglen,lgdata.type,lgdata.lv)
if lgLvCfg.effects_dvalue_desc then
for _,desc in pairs(lgLvCfg.effects_dvalue_desc[lglen])do
local dlist=string.split(desc,'+')
local typeName=dlist[1]
local value=dlist[2]
table.insert(attrStrList,{typeName,value})
end
end
end
self.specialAttrData=attrStrList

end

function UIDiscipleLinggen_StrengthenDetaileWin:refresh()


self.baseAttrList:setChildLayoutGroupCreateItems(#self.baseAttrData,function(index)
local item=self.baseAttrList:getChildLayoutGroupGridItem(index-1)
local data=self.baseAttrData[index]
item:SetChildActive(-1,data~=nil)
if data then
local typeName=helper.getAttributeName(data[1])
local value=helper.getAttributeStrEx(data[1],data[2])
item:SetChildText(0,typeName)
item:SetChildText(1,value)
end
end)


self.spAttrList:setChildLayoutGroupCreateItems(#self.specialAttrData,function(index)
local item=self.spAttrList:getChildLayoutGroupGridItem(index-1)
local data=self.specialAttrData[index]
item:SetChildActive(-1,data~=nil)
if data then
local typeName=data[1]
local value=data[2]
value=FMT.fmt("+{0}",value)

item:SetChildText(0,typeName)
item:SetChildText(1,value)
end
end)



local lglist,lglist_lookup,lglen=UIDiscipleModel:getDiscipleLingGenData(self.disciple_guid)
local varySrid=UIDiscipleModel:getDiscipleVarysrid(self.disciple_guid)


if false then
local varySkill=cfgHelper.get3(cfg_disciplespiritrootvaryconfig_get,lglen,varySrid,'skill')
local varySkillId=varySkill[1]
local varySkillLevel=varySkill[2]

local skillCfg=cfgHelper.get1(cfg_skillconfig_get,varySkillId)
local skillIconName=iconHelper.getSkillIcon(skillCfg.icon)
local skillDesc=skillModel:getSkillDesc(varySkillId,varySkillLevel)
self.skillicon:setChildIcon(skillIconName,false)
self.skillname:setText(skillCfg.name)
self.skilldesc:setText(skillDesc)
end


self.hiddenSkillList:setChildLayoutGroupCreateItems(#self.hoardDatas,function(index)
local item=self.hiddenSkillList:getChildLayoutGroupGridItem(index-1)
local hoardData=self.hoardDatas[index]
local data=hoardData.activeList[1]

item:SetChildActive(-1,data~=nil)
if data then
local hoardCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,data.hoardid)

local color=UIDiscipleModel:getHoardNameColor(hoardCfg.color)
item:SetChildText(0,toColorStringX(color,hoardCfg.name))

local elementIconName,ab=ELEMENT_TYPE.getVaryIcon(hoardCfg.element)
item:SetChildCSImageSprite(1,ab,elementIconName)

local skillIconName=iconHelper.getSkillIcon(hoardCfg.icon)
item:SetChildIcon(2,skillIconName,false)

local qualityName,qab=UIDiscipleModel:getHoardRecordQualityIcon(hoardCfg.color)
item:SetChildCSImageSprite(6,qab,qualityName)

item:SetChildLayoutGroupCreateItems(3,data.len1,function(aindex)
local aitem=item:GetChildLayoutGroupGridItem(3,aindex-1)
local adata=data.list1[aindex]

aitem:SetChildActive(-1,adata~=nil)
if adata then
local desc=helper.getAttributeStr(adata.param_1,adata.param_2,1,"{0}+{1}")
aitem:SetChildText(-1,desc)
end
end)

local desc=UIDiscipleModel:getDiscipleHoardDesc(data)
item:SetChildText(4,desc)
item:SetChildActive(5,hoardCfg.additionskillid~=nil)
item:SetChildButtonClick(5,function()
local hiddenCfg=hoardCfg
local skillid,gfUpValue=next(hiddenCfg.gongfa or{})
if skillid and gfUpValue then
self:showWindow("UIDiscipleLinggen_HiddenSkillEffectTipsWin",{
disciple_guid=self.disciple_guid,
skillid=skillid,
addSkillLv=gfUpValue,
gfID=hiddenCfg.gongfaid,
item=item,
offset=Vector2(0,0),
isAdapter=false
})
elseif hiddenCfg.skillid then
self:showWindow("UIDiscipleLinggen_HiddenSkillEffectTipsWin",{
disciple_guid=self.disciple_guid,
gfID=hiddenCfg.gongfaid,
item=item,
offset=Vector2(0,0),
isAdapter=false
})
end
end)
end
end)
end




function UIDiscipleLinggen_StrengthenDetaileWin:onCloseBtn()
self:closeSelf()
end