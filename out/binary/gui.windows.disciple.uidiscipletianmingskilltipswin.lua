







def_class("UIDiscipleTianMingSkillTipsWin",UIWindowBase)









function UIDiscipleTianMingSkillTipsWin:bindComponents()

self.root=UIObject.get(self,0)
self.btnspinelist=UIObject.get(self,1)
self.top=UIObject.get(self,2)
self.btnnamelist=UIObject.get(self,3)
self.skillIcon=UIObject.get(self,4)
self.skillName=UIText.get(self,5)
self.stateInfo=UIText.get(self,6)
self.attrListPanel=UIObject.get(self,7)
self.jjUpValue=UIText.get(self,8)
self.attrUpRoot=UIObject.get(self,9)
self.bottom=UIObject.get(self,10)
self.skillDesc=UIText.get(self,11)
self.conditiontxt=UIText.get(self,12)
self.changeroot=UIObject.get(self,13)
self.changeScrollView=UIObject.get(self,14)
self.bg=UIImage.get(self,15)
self.spSkillFlag=UIObject.get(self,16)
self.bottomTitleText=UIText.get(self,17)



end


function UIDiscipleTianMingSkillTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.btnspinelist);self.btnspinelist=nil;
_UIObject_release(self.top);self.top=nil;
_UIObject_release(self.btnnamelist);self.btnnamelist=nil;
_UIObject_release(self.skillIcon);self.skillIcon=nil;
_UIObject_release(self.skillName);self.skillName=nil;
_UIObject_release(self.stateInfo);self.stateInfo=nil;
_UIObject_release(self.attrListPanel);self.attrListPanel=nil;
_UIObject_release(self.jjUpValue);self.jjUpValue=nil;
_UIObject_release(self.attrUpRoot);self.attrUpRoot=nil;
_UIObject_release(self.bottom);self.bottom=nil;
_UIObject_release(self.skillDesc);self.skillDesc=nil;
_UIObject_release(self.conditiontxt);self.conditiontxt=nil;
_UIObject_release(self.changeroot);self.changeroot=nil;
_UIObject_release(self.changeScrollView);self.changeScrollView=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.spSkillFlag);self.spSkillFlag=nil;
_UIObject_release(self.bottomTitleText);self.bottomTitleText=nil;
end
















local btnCfg={
{
name="激活",
spine=2017
}
}




function UIDiscipleTianMingSkillTipsWin:onLoaded(...)
self:bindComponents()
end


function UIDiscipleTianMingSkillTipsWin:__delete()
self:unbindComponents()
end




function UIDiscipleTianMingSkillTipsWin:onShow(argtable,afterOnloaded)
self.tmId=argtable.tmId or 0
self.tmState=argtable.tmState
self.needFloor=argtable.needFloor or 0
self.tmLv=argtable.tmLv or 0
self.guid=argtable.guid
self.skillIconId=argtable.skillIconId
self.isNotShowButton=argtable.isNotShowButton
self.tmIndex=argtable.tmIndex

local jobid=argtable.jobId or UIDiscipleModel:getDiscipleJob(self.guid)
local tmCfg=cfgHelper.get1(cfg_discipletianmingconfig_get,self.tmId)
local isSpSkill=tmCfg.isSpSkill
local bgIconAb
local bgIconName
if isSpSkill then
bgIconAb="ui/windows/disciple/spdisciple_atlas_pak.ab"
bgIconName="image_shenhuadizixinxi_3"
else
bgIconAb="ui/windows/qianjige/skill_tips_atlas_pak.ab"
bgIconName="frame_tyjntipskuang_1"
end
self.bg:setSprite(bgIconAb,bgIconName)
self.spSkillFlag:setActive(isSpSkill)

local netData=UIDiscipleModel:getDiscipleData(self.guid)
local skillIconId=self.skillIconId or UIDiscipleModel.getTianMingSkillIconId(tmCfg,jobid,netData)
local skillIconName=iconHelper.getSkillIcon(skillIconId)
self.skillIcon:setChildIcon(skillIconName,false)
local skillNameStr=tmCfg.name
local strTable=string.toTable(skillNameStr)
local newStrTable={}

if pfwindowslController:checkIsGameVersion_yuenan()or pfwindowslController:checkIsGameVersion_oumei()then
if#strTable>25 then
skillNameStr=FMT.fmt("{0}...",utf8.sub(skillNameStr,1,25))
end
else
if#strTable>5 then
for i=1,4 do
newStrTable[i]=strTable[i]
end
skillNameStr=table.concat(newStrTable,"")
skillNameStr=FMT.fmt("{0}...",skillNameStr)
end
end

self.skillName:setText(skillNameStr)

if self.tmIndex then
local isActive,need_tmlv
if self.tmIndex==6 then
isActive,need_tmlv=UIDiscipleModel.checkTiamMingCiFuPosOpenX(self.tmLv,1)
elseif self.tmIndex>6 then
isActive,need_tmlv=UIDiscipleModel:checkTianMingFloorActive(self.tmLv,self.tmIndex-1)
else
isActive,need_tmlv=UIDiscipleModel:checkTianMingFloorActive(self.tmLv,self.tmIndex)
end
if self.tmState==nil then
self.tmState=isActive
end
self.needTmLv=need_tmlv
end

local stateStr
local isMaxSpSkillLevel=true
local skillLevel
if self.tmState then
if isSpSkill then
skillLevel=UIDiscipleModel:getSpSkillLevel(self.tmLv)
stateStr=FMT.fmt("<color=#cacaca>{0}级</color>",skillLevel)
local maxSpSkillLevel=UIDiscipleModel.getMaxSpSkillLevel()
isMaxSpSkillLevel=skillLevel>=maxSpSkillLevel
else
stateStr=FMT.fmt("<color={0}>已激活</color>","#aae252")
end
else
stateStr=FMT.fmt("<color={0}>未激活</color>","#cacaca")
end
self.stateInfo:setText(FMT.fmt(stateStr))


local desc
local skillId=tmCfg.skill
if isSpSkill and skillId then

desc=skillModel:getSkillDesc(skillId,skillLevel)
else
desc=UIDiscipleModel.getTianMingDesc(tmCfg,jobid)
end
self.skillDesc:setText(desc)


local lvcfg
local percent=0
if self.needTmLv then
local cfg=cfgHelper.get(cfg_discipletianminglevelconfig_get,self.needTmLv)
percent=cfg.percent
lvcfg=cfg
else
local tmAllLvCfg=cfg_discipletianminglevelconfig()
for k,v in pairs(tmAllLvCfg)do
if v.floor==self.needFloor then
percent=v.percent
lvcfg=v
break
end
end
end
self.attrUpRoot:setActive(percent>0)
if percent>0 then
self.jjUpValue:setText(FMT.fmt("+{0}%",percent))
end

local attrList={}
if lvcfg then
local lv_attrs=lvcfg.attr[jobid]
if lv_attrs~=nil and#lv_attrs>0 then
for i,v in ipairs(lv_attrs)do
local str=helper.getAttributeStr(v[1],v[2],2,'{0} + {1}')
table.insert(attrList,str)
end
end
end
local attrNum=#attrList
self.attrListPanel:setChildLayoutGroupCreateItems(attrNum)
if attrNum>0 then
local grids=self.attrListPanel:getChildLayoutGroupGridList()
for i=1,attrNum do
local item=grids[i-1]
local str=attrList[i]
item:SetChildText(0,str)
end
end

local isShowBottom=not self.tmState or not isMaxSpSkillLevel
self.bottom:setActive(isShowBottom)
if isShowBottom then
if not self.tmState then
local needLv
local floorName
local chong
local showFloor
if self.needTmLv then
needLv=self.needTmLv
showFloor=UIDiscipleModel.getTianMingLevelFloor(needLv)
chong=UIDiscipleModel.getTianMingLevelChong(needLv)
else
local allLvCfg=cfg_discipletianminglevelconfig()
needLv=0
for k,v in pairs(allLvCfg)do
if v.floor==self.needFloor then
needLv=k
break
end
end
showFloor=self.needFloor
chong=1
end
floorName=cfgHelper.get2(cfg_discipletianmingfloorconfig_get,showFloor,"name")
self.bottomTitleText:setText("激活要求")
self.conditiontxt:setText(FMT.fmt("弟子天命：{0}天命{1}重（{2}/{3}）",floorName,chong,self.tmLv,needLv))
elseif not isMaxSpSkillLevel then
local nextSpSkillLv,needLv=UIDiscipleModel:getNextSpSkillLevelAndNeedTmLv(self.tmLv)
local chong=UIDiscipleModel.getTianMingLevelChong(needLv)
local showFloor=UIDiscipleModel.getTianMingLevelFloor(needLv)
local floorName=cfgHelper.get2(cfg_discipletianmingfloorconfig_get,showFloor,"name")
self.bottomTitleText:setText("升级要求")
self.conditiontxt:setText(FMT.fmt("弟子天命：{0}天命{1}重（{2}/{3}）",floorName,chong,self.tmLv,needLv))
end
end

self.btnspinelist:setActive(not self.tmState)
self.btnnamelist:setActive(not self.tmState)
if not self.tmState and not self.isNotShowButton then
self.btnspinelist:setChildLayoutGroupCreateItems(#btnCfg,function(index)
local item=self.btnspinelist:getChildLayoutGroupGridItem(index-1)
local data=btnCfg[index]
item:SetChildUIModelShowTarget(-1,data.spine,1,{},eAnimationID.common_window_enter,false,false,0,nil)
end)

self.btnnamelist:setChildLayoutGroupCreateItems(#btnCfg,function(index)
local item=self.btnnamelist:getChildLayoutGroupGridItem(index-1)
local data=btnCfg[index]
item:SetChildText(0,data.name)
item:SetBaseItemClickEvent(-1,function()
UIFullDiscipleMainControl:showWindowTianMing({guid=self.guid,dis_guid=self.guid})
self:closeSelf()
end)
end)
end



local changeStateList
if isSpSkill and skillId then
changeStateList=skillModel:getSkillGiveStateList(skillId,skillLevel)
if self.guid then
local boradStateList=UIDiscipleModel:getDiscipleHoardEffectBySkillId(self.guid,skillId)
changeStateList=table.concatTable(changeStateList,boradStateList)
end
else
changeStateList={}
local descEx=tmCfg.descEx
if descEx~=nil or#(descEx or{})>0 then
for idx,data in ipairs(descEx)do
local temp={}
local topStr=string.match(data[1],"【(.-)】")
if topStr then
temp.stateName=topStr
temp.stateIconId=data[2]
temp.stateType=data[3]
local _,el=string.find(data[1],FMT.fmt('【{0}】',topStr))
temp.desc=string.sub(data[1],el+1)
local nameColor=data[3]==1 and"#5ac0e2"or"#f36666"
temp.stateName=FMT.fmt("<color={0}>{1}</color>",nameColor,temp.stateName)
temp.gongFaTypeIcon=data[4]
table.insert(changeStateList,temp)
end
end
end
end

self.changeScrollView:setChildScrollRectEnable(false)
self:delayDo(0.25,function()
self.changeScrollView:setChildScrollRectEnable(true)
end)
local isHasFT=changeStateList~=nil and#(changeStateList or{})>0
self.changeScrollView:setActive(isHasFT)
self.root:setChildAnchoredPos(isHasFT and-200 or 0,-10.0807)
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


function UIDiscipleTianMingSkillTipsWin:onHide()

end



