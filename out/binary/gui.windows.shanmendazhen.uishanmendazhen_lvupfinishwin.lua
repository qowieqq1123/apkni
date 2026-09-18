







def_class("UIShanMenDaZhen_lvUpFinishWin",UIWindowBase)









function UIShanMenDaZhen_lvUpFinishWin:bindComponents()

self.mask=UIButton.get(self,0)
self.zhenName=UIText.get(self,1)
self.attrGridGroup=UIObject.get(self,2)
self.skillPanel=UIObject.get(self,3)
self.dazhenEffect=UIObject.get(self,4)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIShanMenDaZhen_lvUpFinishWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.zhenName);self.zhenName=nil;
_UIObject_release(self.attrGridGroup);self.attrGridGroup=nil;
_UIObject_release(self.skillPanel);self.skillPanel=nil;
_UIObject_release(self.dazhenEffect);self.dazhenEffect=nil;
end
















local _this




function UIShanMenDaZhen_lvUpFinishWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIShanMenDaZhen_lvUpFinishWin:__delete()
_this=nil
self:unbindComponents()
end




function UIShanMenDaZhen_lvUpFinishWin:onShow(argtable,afterOnloaded)
self.lastBuildLevel=argtable and argtable.lastBuildLevel or nil
self.bdData=shanMenDaZhenModel:getShanMenBdData()
self.buildLv=self.bdData.level
local daZhenLv=self.buildLv-1
local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLv)
local effectId=daZhenLvCfg.dazhenUIEffectId[1]
self.dazhenEffect:setChildShowEffect(effectId,true)
self:refresh()
end


function UIShanMenDaZhen_lvUpFinishWin:onHide()

end

function UIShanMenDaZhen_lvUpFinishWin:refresh()
local lastBuildLv=self.lastBuildLevel or self.buildLv-1

local allCfg=cfg_shanmendazhenconfig()

if lastBuildLv<=0 then

return self:onMask()
end

local showNowLevel=self.buildLv-1
local showLastLevel=lastBuildLv-1
local daZhenLevelCfg=allCfg[showNowLevel]
local daZhenLastLevelCfg=allCfg[showLastLevel]
local zhenNameStr="山门大阵"
self.zhenName:setText(FMT.fmt("{0}（{1}级）",zhenNameStr,showNowLevel))

local attrChangeList={}

local lastBaseAttrList_lookup={}
local lastBaseAttrList=daZhenLastLevelCfg.attr or{}

local lastAttrAddRate=daZhenLastLevelCfg.percent or 0
local lastAttrRate=1+lastAttrAddRate/100
for i,v in ipairs(lastBaseAttrList)do
local attrId=v[1]
local attrCfgVal=v[2]
local attrVal=math.floor(attrCfgVal*lastAttrRate)
lastBaseAttrList_lookup[attrId]=attrVal
end
local nowBaseAttrList=daZhenLevelCfg.attr or{}
local nowAttrAddRate=daZhenLevelCfg.percent or 0
local nowAttrRate=1+nowAttrAddRate/100
for i,v in ipairs(nowBaseAttrList)do
local attrId=v[1]
local attrCfgVal=v[2]
local attrVal=math.floor(attrCfgVal*nowAttrRate)
local lastAttrVal=lastBaseAttrList_lookup[attrId]
local isChange=false
if not lastAttrVal then
isChange=true
else
if lastAttrVal~=attrVal then
isChange=true
end
end
if isChange then
local name,valStr=equipsHelper.getAttr(attrId,attrVal)
lastAttrVal=lastAttrVal or 0
local _,lastValStr=equipsHelper.getAttr(attrId,lastAttrVal)
attrChangeList[#attrChangeList+1]={FMT.fmt("{0}：",name),lastAttrVal,valStr}
end
end

if daZhenLevelCfg.shield>daZhenLastLevelCfg.shield then
attrChangeList[#attrChangeList+1]={"护盾值上限：",daZhenLastLevelCfg.shield,daZhenLevelCfg.shield}
end
if daZhenLevelCfg.recover>daZhenLastLevelCfg.recover then
attrChangeList[#attrChangeList+1]={"每年回复护盾值：",daZhenLastLevelCfg.recover,daZhenLevelCfg.recover}
end
if daZhenLevelCfg.team>daZhenLastLevelCfg.team then
attrChangeList[#attrChangeList+1]={"可进驻队伍：",daZhenLastLevelCfg.team,daZhenLevelCfg.team}
end

self.attrGridGroup:setChildLayoutGroupCreateItems(#attrChangeList,function(idx)
if _this==nil then return end
local item=_this.attrGridGroup:getChildLayoutGroupGridItem(idx-1)
local attrStrList=attrChangeList[idx]
item:SetChildText(0,attrStrList[1])
item:SetChildText(3,attrStrList[2])
item:SetChildText(1,attrStrList[3])
end)


local isChangeSkill=false
local changeSkillList={}
local lastFazeList=daZhenLastLevelCfg.fazeShow or{}
local lastFazeList_lookup={}
for i,v in ipairs(lastFazeList)do
local fazeId=v[1]
local fazeLv=v[2]
lastFazeList_lookup[fazeId]=fazeLv
end
local nowFazeList=daZhenLevelCfg.fazeShow or{}
for i,v in ipairs(nowFazeList)do
local fazeId=v[1]
local fazeLv=v[2]
if lastFazeList_lookup[fazeId]then

local lastLevel=lastFazeList_lookup[fazeId]
if fazeLv>lastLevel then
changeSkillList[#changeSkillList+1]={id=fazeId,level=fazeLv}
isChangeSkill=true
end
else
changeSkillList[#changeSkillList+1]={id=fazeId,level=fazeLv}
isChangeSkill=true
end
end





















local lastBuffId=daZhenLastLevelCfg.buff
local nowBuffId=daZhenLevelCfg.buff
if nowBuffId and lastBuffId~=nowBuffId then
isChangeSkill=true
local buffLevel=cfgHelper.get2(cfg_guildstateconfig_get,nowBuffId,'level')
changeSkillList[#changeSkillList+1]={id=nowBuffId,level=buffLevel,isBuffSkill=true}
end

self.skillPanel:setActive(isChangeSkill)
if isChangeSkill then
self.skillPanel:setChildLayoutGroupCreateItems(#changeSkillList,function(index)
if _this==nil then return end
local item=_this.skillPanel:getChildLayoutGroupGridItem(index-1)
local skillData=changeSkillList[index]

local skillIcon
local skillName
local skillDescStr
local skillDescExList

if skillData.isBuffSkill then

local cfg=cfgHelper.get1(cfg_guildstateconfig_get,skillData.id)
skillIcon=iconHelper.getzmStateIcon(cfg.icon)
skillName=cfg.name
local txt=''
local effects=cfg.effects
for i,v in ipairs(effects)do
local effectid=effects[i]
local desc=homeBuffModel:getBuffDesc(effectid)
desc=string.replaceSpace(desc)
txt=txt~=''and FMT.fmt('{0}\n{1}',txt,desc)or desc
end
skillDescStr=txt
skillDescExList={}

















else

local cfg=cfgHelper.getSSlawRule(skillData.id)
skillIcon=cfg.image
skillName=cfg.name
local desc=cfg.desc
local attrdesc=cfg.attrdesc
local descparm=cfg.descparm
if descparm and descparm[skillData.level]and next(descparm[skillData.level])then
desc=string.format(desc,unpack(descparm[skillData.level]))
if attrdesc then
attrdesc=string.format(attrdesc,unpack(descparm[skillData.level]))
end
end
skillDescStr=desc
skillDescExList={attrdesc}
end

item:SetChildIcon(0,skillIcon,false)


local nameStr=skillName
item:SetChildText(1,nameStr)


local levelStr=FMT.fmt("[ {0}级 ]",skillData.level)
item:SetChildText(2,levelStr)


item:SetChildText(3,skillDescStr)

















end)
end

end





function UIShanMenDaZhen_lvUpFinishWin:onMask()
self:closeSelf()
end

