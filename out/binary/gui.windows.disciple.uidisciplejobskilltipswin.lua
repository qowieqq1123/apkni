







def_class("UIDiscipleJobSkillTipsWin",UIWindowBase)









function UIDiscipleJobSkillTipsWin:bindComponents()

self.blackImg=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.skillItem=UIObject.get(self,2)
self.title1=UIObject.get(self,3)
self.skilDesc=UIObject.get(self,4)
self.title2=UIObject.get(self,5)
self.upgradeCondition=UIObject.get(self,6)
self.title3=UIObject.get(self,7)
self.extraGroup=UIObject.get(self,8)
self.changeroot=UIObject.get(self,9)
self.displayBtn=UIButton.get(self,10)
self.displayTx=UIText.get(self,11)

self.displayBtn:setButtonClick(function()self:onDisplayBtn()end)



end


function UIDiscipleJobSkillTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skillItem);self.skillItem=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.skilDesc);self.skilDesc=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.upgradeCondition);self.upgradeCondition=nil;
_UIObject_release(self.title3);self.title3=nil;
_UIObject_release(self.extraGroup);self.extraGroup=nil;
_UIObject_release(self.changeroot);self.changeroot=nil;
_UIObject_release(self.displayBtn);self.displayBtn=nil;
_UIObject_release(self.displayTx);self.displayTx=nil;
end

















function UIDiscipleJobSkillTipsWin:onLoaded(...)
self:bindComponents()
end


function UIDiscipleJobSkillTipsWin:__delete()
self:unbindComponents()
end


function UIDiscipleJobSkillTipsWin:onHide()

end




function UIDiscipleJobSkillTipsWin:onShow(argtable,afterOnloaded)
self.skillID=argtable.skillID
self.skillLv=argtable.skillLv
self.tipsType=argtable.attend
self.dis_guid=argtable.dis_guid
self.changLv=argtable.changLv
self.tdsLv=argtable.tdsLv
self.fromCfg=argtable.fromCfg
self.isShowSkill=argtable.isShowSkill
self.skillDesc=argtable.skillDesc
self.lsGuid=argtable.lsGuid
self.hideUpgrade=argtable.hideUpgrade
self.extraAddLevel=argtable.extraAddLevel
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,self.skillID)
self.vocEquipAddLv=argtable.vocEquipAddLv
self.notShowBuffDescRoot=argtable.notShowBuffDescRoot
local canvasIdx=argtable.canvasIdx
if canvasIdx then
self:setCanvasIndex(-1,canvasIdx)
end
self.c_skillLv=self.skillLv
self.hideReport=argtable.hideReport or false

if self.changLv==true and self.skillLv>0 then
if self.dis_guid~=nil then
self.c_skillLv=UIDiscipleModel:getSkillLv(self.dis_guid,self.skillID,self.skillLv)
else
self.c_skillLv=skillModel:getSkillLv(self.skillID,self.skillLv)
end
end


if argtable.pivot then
self.root:setChildPivot(argtable.pivot)
end

local item=argtable.item
if item then
self.customPos=true
self:showPosition(item,argtable.move_pos)
end

local showBlackBg=argtable.showBlackBg and 1 or 0
local isinit=afterOnloaded
if isinit then
self.root:setChildCanvasGroupAlpha(0)


self.root:setChildCanvasGroupDOFade(1,0.3,nil)
self.blackImg:setChildCanvasGroupAlpha(showBlackBg)

end
self:refreshSkillView(isinit)
self:refreshDisplayButton()
end

function UIDiscipleJobSkillTipsWin:refreshSkillView(isinit)
self.fadeList={}


local skillWidget=self.skillItem:getChildWidgetBase()
if isinit then
self.skillItem:setChildCanvasGroupAlpha(0)
table.insert(self.fadeList,self.skillItem)
end
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,self.skillID)
local isbd=skillModel.isSkillBD(skillCfg.skillType)

local name_str=skillCfg.name
local strTable=string.toTable(name_str)
local newStrTable={}

if pfwindowslController:checkIsGameVersion_yuenan()or pfwindowslController:checkIsGameVersion_oumei()then
if#strTable>32 then
name_str=FMT.fmt("{0}...",utf8.sub(name_str,1,32))
end
else
if#strTable>5 then
for i=1,4 do
newStrTable[i]=strTable[i]
end
name_str=table.concat(newStrTable,"")
name_str=FMT.fmt("{0}...",name_str)
end
end

if not self.isShowSkill then
if self.skillDesc then
skillWidget:SetChildText(4,self.skillDesc)
else
skillWidget:SetChildText(4,skillModel:getSkillLvStr(self.c_skillLv))
end
else
skillWidget:SetChildText(4,'')
end
skillWidget:SetChildText(0,FMT.fmt(FONT_COLOR_FMT[FONT_COLOR.eTitle2Color],name_str))
skillWidget:SetChildIcon(1,iconHelper.getSkillIcon(skillCfg.icon),false)
skillWidget:SetChildActive(2,isbd)

local faction=skillCfg.skillFaction or FACTION_TYPE.eNone
local showfaction=faction~=FACTION_TYPE.eNone
skillWidget:SetChildActive(3,showfaction)
if showfaction then
local faction_icon=UIGongFaModel:getGFFactionIcon(faction)
skillWidget:SetChildCSImageSprite(3,globalABLookup.global,faction_icon)
end


if isinit then
self.title1:setChildCanvasGroupAlpha(0)
table.insert(self.fadeList,self.title1)
end


local skillDescWidget=self.skilDesc:getChildWidgetBase()
if isinit then
self.skilDesc:setChildCanvasGroupAlpha(0)
table.insert(self.fadeList,self.skilDesc)
end
skillDescWidget:SetChildText(0,skillModel:getSkillDesc(self.skillID,self.c_skillLv))

local descExList=skillModel:getSkillDescEx(self.skillID,self.c_skillLv)
local descExNum=0
if descExList~=nil then
descExNum=#descExList
end
local showDescEx=descExNum>0

skillDescWidget:SetChildActive(1,false)

if false then
skillDescWidget:SetChildLayoutGroupCreateItems(1,descExNum)
local descExGrid=skillDescWidget:GetChildLayoutGroupGridList(1)
for i=1,descExNum do
local descItem=descExGrid[i-1]
local txt=descExList[i]
descItem:SetChildText(0,txt)
end
end

local coolDown=skillModel:getSkillCooldownTime(self.skillID,self.c_skillLv)
if self.dis_guid~=nil and UIDiscipleModel:isMyActorDZ(self.dis_guid)then
coolDown=UIDiscipleModel:getSkillCoolDown(self.dis_guid,self.skillID,coolDown)
end
local isCoolDown=coolDown>0
skillDescWidget:SetChildActive(2,isCoolDown)
if isCoolDown then
local cooldown_str=FMT.fmt('冷却：{0}回合',coolDown)
skillDescWidget:SetChildText(3,cooldown_str)
end

local maxGemPower=skillCfg.maxGemPower
local showGemPower=maxGemPower~=nil and maxGemPower>0
skillDescWidget:SetChildActive(4,showGemPower)
if showGemPower then
local gemPower_str=FMT.fmt('神通蓄力值：{0}',maxGemPower)
skillDescWidget:SetChildText(5,gemPower_str)
end

local skillYuanSu=skillCfg.skillYuanSu
local showYuanSu=skillYuanSu~=nil
skillDescWidget:SetChildActive(6,showYuanSu)
if showYuanSu then
local yuansu_str=FMT.fmt('五行系别：{0}',ELEMENT_TYPE.getName(skillYuanSu))
local attrType=elementAttrLookup[skillYuanSu][1]
local attrValue=self:getDZAttrValue(attrType)
local yuansu_str2=''
if attrValue~=nil and attrValue>0 then
local str=elementAttrLookup.getDesc2(skillYuanSu)
local str2=helper.getAttributeStrEx(attrType,attrValue)
yuansu_str2=FMT.fmt('({0}+{1})',str,str2)
end
skillDescWidget:SetChildText(7,yuansu_str)
skillDescWidget:SetChildText(8,yuansu_str2)
skillDescWidget:SetChildActive(8,not skillCfg.hideElementAttr)
end

local hurtType=skillCfg.hurtType
local showHurt=hurtType~=nil
skillDescWidget:SetChildActive(9,showHurt)
if showHurt then
local hurt_str=FMT.fmt('伤害类型：{0}',eSkillHurtLookup[hurtType].name)
local hurt_str2=''
if hurtType~=eSkillHurtType.eNone then
local attrType=eSkillHurtLookup[hurtType].attr[1]
local attrValue=self:getDZAttrValue(attrType)
if attrValue~=nil and attrValue>0 then
local str=eSkillHurtLookup[hurtType].desc
local str2=helper.getAttributeStrEx(attrType,attrValue)
hurt_str2=FMT.fmt('({0}+{1})',str,str2)
end
end
skillDescWidget:SetChildText(10,hurt_str)
skillDescWidget:SetChildText(11,hurt_str2)
end


local mzdescList=UIDiscipleModel:getDiscipleHoardDescBySkillId(self.dis_guid,self.skillID)
local isShowMZ=#mzdescList>0
skillDescWidget:SetChildActive(12,isShowMZ)
if isShowMZ then
skillDescWidget:SetChildLayoutGroupCreateItems(12,#mzdescList,function(index)
local zmItem=skillDescWidget:GetChildLayoutGroupGridItem(12,index-1)
local zmDesc=mzdescList[index]
zmItem:SetChildActive(-1,zmDesc~=nil)
if zmDesc~=nil then
zmItem:SetChildText(0,zmDesc)
end
end)
end

local tdsExtra=self.dis_guid and tiandaoshuModel:findSkillExtraLevel(self.dis_guid,self.skillID)or self.tdsLv or 0
local vocEquipExtra=0
if self.dis_guid then
local vocEquipExtraLevelList=vocEquipModel:getVocEquipAddDiscipleSkillLevelListEx(self.dis_guid)
vocEquipExtra=vocEquipExtraLevelList[self.skillID]or 0
else
vocEquipExtra=self.vocEquipAddLv or 0
end
local lsTraitEffectExtra=0
if self.lsGuid then
if lingshouModel:checkIsMainSkill(self.lsGuid,self.skillID)then
lsTraitEffectExtra=lingshouModel:getLingShouTraitEffectEx(self.lsGuid,lingshouTraitEffectEnum.LINGSHOU_SKILL_LEVEL_ADD,0)or 0
elseif lingshouModel:checkIsPassiveSkill(self.lsGuid,self.skillID)then
lsTraitEffectExtra=lingshouModel:getLingShouTraitEffectEx(self.lsGuid,lingshouTraitEffectEnum.LINGSHOU_SKILL_LEVEL_ADD,1)or 0
end
end

local allExtraLevel=tdsExtra+vocEquipExtra+lsTraitEffectExtra
local isActive=self.skillLv>0
local nextSkillLv=self.c_skillLv+1
if isActive and self.changLv then
nextSkillLv=nextSkillLv-allExtraLevel
end
local fromCfg=self.fromCfg
local maxGrowLv=skillCfg.maxGrowLv
local isFull=self.c_skillLv>=maxGrowLv
local showUpgradeCondition=not fromCfg and(not isActive or not isFull)and(not self.hideUpgrade)
showUpgradeCondition=showUpgradeCondition and self:checkShowUpgrade()
self.upgradeCondition:setActive(showUpgradeCondition)
self.title2:setActive(showUpgradeCondition)
local cond_str=''
local upgradeConditionWidget=self.upgradeCondition:getChildWidgetBase()
if showUpgradeCondition then

if isinit then
self.title2:setChildCanvasGroupAlpha(0)
table.insert(self.fadeList,self.title2)
end
local title2Widget=self.title2:getChildWidgetBase()
local str=''
if not isActive then
str='解锁条件'
else
str='升级要求'
end
title2Widget:SetChildText(0,str)


if isinit then
self.upgradeCondition:setChildCanvasGroupAlpha(0)
table.insert(self.fadeList,self.upgradeCondition)
end
if self.tipsType==eSkillTipsType.eDZSkill then
local c_skillId=self.skillID
if self.dis_guid~=nil then
local netData=UIDiscipleModel:getDiscipleData(self.dis_guid)
c_skillId=UIDiscipleModel:getSkillReplaceBack(netData,self.skillID)
end
local jjfloor=discipleLookup:getJJFloorByJobSkilLevel(c_skillId,nextSkillLv)
if jjfloor then
local jjlv=0
if jjfloor>0 then
jjlv=(jjfloor-1)*10+1
end
cond_str=FMT.fmt('境界：{0}',UIDiscipleModel:getJJNameXX(jjlv))
end
elseif self.tipsType==eSkillTipsType.eDZGFSkill then
local gfID=gongfaLookup:getGongFaIDBySkill(self.skillID)
local gfLv=UIGongFaModel:getGongFaLvBySkillLv(self.skillID,nextSkillLv,gfID)
if gfLv then
cond_str=FMT.fmt('功法：{0}{1}层',cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'name'),gfLv)
end
end
end
if self.tipsType==eSkillTipsType.eLSSkill then
local skillLvUpCfg=cfgHelper.get(cfg_lingshoupassiveskillconfig_get,self.skillID)
local mskillLvUpCfg=cfgHelper.get(cfg_lingshouskillconfig_get,self.skillID)
if skillLvUpCfg and skillLvUpCfg.up_level_conf then

nextSkillLv=self.lsGuid and lingshouModel:getPassiveSkillLevelEx(self.lsGuid)+1 or nextSkillLv
local lvCfg=skillLvUpCfg.up_level_conf[nextSkillLv]
self.winlua:SetChildActive(self.upgradeCondition:getID(),lvCfg~=nil and(not self.hideUpgrade))
self.winlua:SetChildActive(self.title2:getID(),lvCfg~=nil and(not self.hideUpgrade))
if lvCfg then
local needXueMaiLv=lvCfg[1]
local needJJLv=lvCfg[2]
local strList={}
if needXueMaiLv>0 then
local xieMaiStr=FMT.fmt('血脉：{0}',lingshouModel:switchLevelToStageName_XueMai(needXueMaiLv))
strList[#strList+1]=xieMaiStr
end

if needJJLv>0 then
local jjStr=FMT.fmt('境界：{0}',lingshouModel:getJJNameEx(needJJLv,2))
strList[#strList+1]=jjStr
end
cond_str=table.concat(strList,"；")
end
elseif mskillLvUpCfg and mskillLvUpCfg.up_level_cnd then

nextSkillLv=self.lsGuid and lingshouModel:getLingShouData2(self.lsGuid).skill_level or nextSkillLv
local strList={}
local cnds=mskillLvUpCfg.up_level_cnd[nextSkillLv]
self.winlua:SetChildActive(self.upgradeCondition:getID(),cnds~=nil and(not self.hideUpgrade))
self.winlua:SetChildActive(self.title2:getID(),cnds~=nil and(not self.hideUpgrade))
if cnds then
for index,cnd in ipairs(cnds)do
local cndt=cnd[1]
if cndt==1 then
local jjStr=FMT.fmt('境界：{0}',UIDiscipleModel:getJJNameEx(cnd[2]))
strList[#strList+1]=jjStr
end
end
cond_str=next(strList)and table.concat(strList,"；")or"暂无"
end
else
cond_str="暂无"
end
end
upgradeConditionWidget:SetChildText(0,cond_str)


local extraShow=allExtraLevel>0
self.extraGroup:setActive(extraShow)
self.title3:setActive(extraShow)
if extraShow then

if isinit then
self.title3:setChildCanvasGroupAlpha(0)
table.insert(self.fadeList,self.title3)
end

local extraList={}
if tdsExtra>0 then
local str=FMT.fmt("<color=#92D050>天道树额外提升{0}{1}级</color>",skillCfg.name,tdsExtra)
extraList[#extraList+1]=str
end
if vocEquipExtra>0 then
local str=FMT.fmt("<color=#92D050>职业装备额外提升{0}{1}级</color>",skillCfg.name,vocEquipExtra)
extraList[#extraList+1]=str
end
if lsTraitEffectExtra>0 then
local str=FMT.fmt("<color=#92D050>灵兽特性额外提升{0}级</color>",lsTraitEffectExtra)
extraList[#extraList+1]=str
end

if isinit then
self.extraGroup:setChildCanvasGroupAlpha(0)
table.insert(self.fadeList,self.extraGroup)
end
self.extraGroup:setChildLayoutGroupCreateItems(#extraList,function(index)
local widget=self.extraGroup:getChildLayoutGroupGridItem(index-1)
local cond_str=extraList[index]
widget:SetChildText(0,cond_str)
end)
end

if isinit then
local func=function()
self:doFadeList()
end
self:delayDo(0.01,func)
end


local changeStateList=skillModel:getSkillGiveStateList(self.skillID,self.c_skillLv)
if self.dis_guid then
local boradStateList=UIDiscipleModel:getDiscipleHoardEffectBySkillId(self.dis_guid,self.skillID)
changeStateList=table.concatTable(changeStateList,boradStateList)
end
local isHasFT=changeStateList~=nil and#(changeStateList or{})>0 and(not self.notShowBuffDescRoot)
self.changeroot:setActive(isHasFT)
if not self.customPos then
self.root:setChildAnchoredPos(isHasFT and-200 or 0,256)
end
if isHasFT then
self.changeroot:setChildLayoutGroupCreateItems(#changeStateList,function(index)
local item=self.changeroot:getChildLayoutGroupGridItem(index-1)
local data=changeStateList[index]
local stateIcon=data.stateType==1 and"icon_zengyi"or"icon_jianyi"
item:SetChildText(1,data.stateName)
item:SetChildIcon(0,iconHelper.getBuffIcon(data.stateIconId),false)
item:SetChildText(3,data.desc)
item:SetChildCSImageSprite(2,globalABLookup.global,stateIcon)

item:SetChildActive(4,data.gongFaTypeIcon~=nil)
if data.gongFaTypeIcon then
item:SetChildIcon(4,string.format('icon_gong_fa_type_%d',data.gongFaTypeIcon),true)
end
end)
end

end

function UIDiscipleJobSkillTipsWin:checkShowUpgrade()
return self.tipsType~=eSkillTipsType.eDZSTSkill and self.tipsType~=eSkillTipsType.eLSTalentSkill
end

function UIDiscipleJobSkillTipsWin:getDZAttrValue(attrType)
if self.dis_guid~=nil then
if self.dzAttrLookup==nil then
self.dzAttrLookup=UIDiscipleModel:getDiscipleMultipleAttrLookup(self.dis_guid)
end
return self.dzAttrLookup[attrType]
end
return nil
end

function UIDiscipleJobSkillTipsWin:doFadeList()
for i,v in ipairs(self.fadeList)do
v:setChildCanvasGroupDOFade(1,0.1,nil)
end
end

function UIDiscipleJobSkillTipsWin:refreshDisplayButton()
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,self.skillID)
local show=api_Available_SetChildFightRenderToImage()and fightModel:haveBattleShow()==nil and skillCfg.display~=nil and not self.hideReport
self.displayBtn:setActive(show)
if show then
local eType=skillCfg.display[3]
local str=reportDisplayConfig:getHandleName(eType)
self.displayTx:setText(str)
end
end

function UIDiscipleJobSkillTipsWin:onDisplayBtn()
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,self.skillID)
local reportCfg=skillCfg.display
if reportCfg[3]==eReportDisplayType.eFaBao then
reportDisplayController:displayReport(reportCfg[3],reportCfg[1],reportCfg[2],nil,{skillId=self.skillID})
elseif reportCfg[3]==eReportDisplayType.eGongFa then
reportDisplayController:displayReport(reportCfg[3],reportCfg[1],reportCfg[2],nil,{gongfa=reportCfg[4]})
end
end

function UIDiscipleJobSkillTipsWin:showPosition(item,move_pos)

local screenPoint=item:GetChildScreenPointToLocalPointRectangle(-1)
local itemTrans=item.transform
local itemSize=itemTrans.sizeDelta
local itemPivot=itemTrans.pivot

local selfTrans=self.root:getTransform()
local selfSize=selfTrans.sizeDelta
local selfPivot=selfTrans.pivot

local offsetX=0
local offsetY=0
move_pos=move_pos or'top'

if move_pos=='bottom'then
offsetY=-itemSize.y*itemPivot.y
offsetX=-(itemPivot.x-0.5)*itemSize.x
elseif move_pos=='top'then
offsetY=-(itemPivot.y-1)*itemSize.y
offsetX=-(itemPivot.x-0.5)*itemSize.x
elseif move_pos=='left'then
offsetY=-(itemPivot.y-0.5)*itemSize.y
offsetX=-itemPivot.x*itemSize.x

offsetX=offsetX-selfSize.x/2
offsetY=offsetY+selfSize.y/2
elseif move_pos=='right'then
offsetY=-(itemPivot.y-1)*itemSize.y
offsetX=-(itemPivot.x-1)*itemSize.x

offsetX=offsetX+selfSize.x/2
offsetY=offsetY+selfSize.y/2
end
local rootPosX=screenPoint.x+offsetX
local rootPosY=screenPoint.y+offsetY


local scaleFactor=CS.CSGUIManager.Instance.CanvasScaleValue
local itemWidth=selfSize.x
local itemHeight=selfSize.y
local halfWidth=UnityEngine.Screen.width/scaleFactor.x/2
local halfHeight=UnityEngine.Screen.height/scaleFactor.y/2

if rootPosX-itemWidth*(selfPivot.x)<-halfWidth then
rootPosX=-halfWidth+itemWidth*(selfPivot.x)
end

if rootPosX+itemWidth*(1-selfPivot.x)>halfWidth then
rootPosX=halfWidth-itemWidth*(1-selfPivot.x)
end

if rootPosY-itemHeight*(selfPivot.y)<-halfHeight then
rootPosY=-halfHeight+itemHeight*(selfPivot.y)
end

if rootPosY+itemHeight*(1-selfPivot.y)>halfHeight then
rootPosY=halfHeight-itemHeight*(1-selfPivot.y)
end

self.winlua:SetChildLocalPosition(self.root:getID(),Vector3(rootPosX,rootPosY,0))
end
