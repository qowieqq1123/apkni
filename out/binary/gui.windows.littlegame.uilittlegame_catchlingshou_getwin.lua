







def_class("UILittleGame_CatchLingShou_GetWin",UIWindowBase)









function UILittleGame_CatchLingShou_GetWin:bindComponents()

self.atitle=UIObject.get(self,0)
self.attrinfoLayout=UIObject.get(self,1)
self.attrInfoPart=UIObject.get(self,2)
self.baseinfoLayout=UIObject.get(self,3)
self.baseInfoPart=UIObject.get(self,4)
self.btitle=UIObject.get(self,5)
self.centerLayout=UIObject.get(self,6)
self.closeBtn=UIButton.get(self,7)
self.content=UIObject.get(self,8)
self.fightVal=UIText.get(self,9)
self.mask=UIObject.get(self,10)
self.modelRoot=UIObject.get(self,11)
self.Root=UIObject.get(self,12)
self.root1=UIObject.get(self,13)
self.root2=UIObject.get(self,14)
self.skillinfoLayout=UIObject.get(self,15)
self.skillInfoPart=UIObject.get(self,16)
self.stitle=UIObject.get(self,17)
self.texininfoLayout=UIObject.get(self,18)
self.texinInfoPart=UIObject.get(self,19)
self.tianfuInfoLayout=UIObject.get(self,20)
self.titleBack=UIObject.get(self,21)
self.txtitle=UIObject.get(self,22)
self.uiRoot=UIObject.get(self,23)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UILittleGame_CatchLingShou_GetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.atitle);self.atitle=nil;
_UIObject_release(self.attrinfoLayout);self.attrinfoLayout=nil;
_UIObject_release(self.attrInfoPart);self.attrInfoPart=nil;
_UIObject_release(self.baseinfoLayout);self.baseinfoLayout=nil;
_UIObject_release(self.baseInfoPart);self.baseInfoPart=nil;
_UIObject_release(self.btitle);self.btitle=nil;
_UIObject_release(self.centerLayout);self.centerLayout=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.fightVal);self.fightVal=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.root1);self.root1=nil;
_UIObject_release(self.root2);self.root2=nil;
_UIObject_release(self.skillinfoLayout);self.skillinfoLayout=nil;
_UIObject_release(self.skillInfoPart);self.skillInfoPart=nil;
_UIObject_release(self.stitle);self.stitle=nil;
_UIObject_release(self.texininfoLayout);self.texininfoLayout=nil;
_UIObject_release(self.texinInfoPart);self.texinInfoPart=nil;
_UIObject_release(self.tianfuInfoLayout);self.tianfuInfoLayout=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
_UIObject_release(self.txtitle);self.txtitle=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this

local _baseInfoItemCmpIndex={
layout=0,
info=1,
}

local _attrInfoItemCmpIndex={
layout=0,
info=1,
}

local _skillInfoItemCmpIndex={
layout=0,
skillitem=1,
}

local _texinInfoItemCmpIndex={
layout=0,
texinitem=1,
}

local _tianfuInfoItemCmpIndex={
layout=0,
skillitem=1,
}




function UILittleGame_CatchLingShou_GetWin:onLoaded(...)
self:bindComponents()

_this=self

self.baseInfoItemList=self.baseinfoLayout:getChildCommonLayoutGroupWidgetList()
self.attrInfoItemList=self.attrinfoLayout:getChildCommonLayoutGroupWidgetList()
self.skillInfoItemList=self.skillinfoLayout:getChildCommonLayoutGroupWidgetList()
self.texinInfoItemList=self.texininfoLayout:getChildCommonLayoutGroupWidgetList()

self.tianfuInfoItemList=self.tianfuInfoLayout:getChildCommonLayoutGroupWidgetList()
end


function UILittleGame_CatchLingShou_GetWin:__delete()
_this=nil

self:unbindComponents()
end




function UILittleGame_CatchLingShou_GetWin:onShow(argtable,afterOnloaded)


self.lsGuid=argtable.lsGuid
self.parent=argtable.parent

self.lsData=lingshouModel:getLingShouData2(self.lsGuid)
self.lsCfg=self.lsData.cfg

self:refreshAll()

if afterOnloaded then
self:playEnterAnimation()
end
end


function UILittleGame_CatchLingShou_GetWin:onHide()

end


function UILittleGame_CatchLingShou_GetWin:onCloseBtn()
local parent=self.parent
self:closeSelf()
parent:startShowLingShouInfoGetWin()
end



function UILittleGame_CatchLingShou_GetWin:refreshAll()

self:refrsehLeft()

self:refrsehRight()

end

function UILittleGame_CatchLingShou_GetWin:refrsehLeft()

local modelParams=lingshouModel.getModelParamsEx(self.lsCfg.model)
local scale=self.lsCfg.modelScale
if not scale then

scale=isometricMapSystem:getModelScale(self.lsCfg.model,true)
end
self.modelRoot:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,0,false,true)


local talentSkillList=lingshouModel:getTalentSkillList(self.lsGuid)or defaultT
for index=1,self.tianfuInfoItemList.Count do
local tfitem=self.tianfuInfoItemList[index-1]
local skillInfo=talentSkillList[index]
local isShow=skillInfo~=nil
tfitem:SetChildActive(-1,isShow)
if isShow then
local talentSkillId=skillInfo[1]
local talentSkillLv=skillInfo[2]
local talentSkillItem=tfitem:GetChildWidgetBase(_tianfuInfoItemCmpIndex.skillitem)
self:refreshSkillItem(talentSkillItem,talentSkillId,talentSkillLv,eSkillTipsType.eLSTalentSkill)
end
end


local fightVal=lingshouModel:getFightValue(self.lsGuid)
fightVal=mathHelper.formatNumber5(fightVal,2)
self.fightVal:setText(fightVal)
end

function UILittleGame_CatchLingShou_GetWin:refrsehRight()


local jjItem=self.baseInfoItemList[0]
local jjName=lingshouModel.getJJNameEx(self.lsData.jj_lvl,3)
jjItem:SetChildText(_baseInfoItemCmpIndex.info,FMT.fmt("境界：<color=#ffffff>{0}</color>",jjName))


local xmItem=self.baseInfoItemList[1]
local xmName=lingshouModel:switchLevelToStageName_XueMai(self.lsData.xuemai_val)
xmItem:SetChildText(_baseInfoItemCmpIndex.info,FMT.fmt("血脉：<color=#ffffff>{0}</color>",xmName))


local zzItem=self.baseInfoItemList[2]
zzItem:SetChildText(_baseInfoItemCmpIndex.info,FMT.fmt("资质：<color=#ffffff>{0}</color>",self.lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.ZIZHI)))


local qlItem=self.baseInfoItemList[3]
local ql_str=lingshouModel:getQianLiDesc(self.lsGuid)
qlItem:SetChildText(_baseInfoItemCmpIndex.info,FMT.fmt('潜力：<color=#ffffff>{0}</color>',ql_str))


local raceItem=self.baseInfoItemList[4]
local race_str=cfgHelper.get2(cfg_lingshouraceconfig_get,self.lsCfg.race,'name')
raceItem:SetChildText(_baseInfoItemCmpIndex.info,FMT.fmt('种族：<color=#ffffff>{0}</color>',race_str))


local sexItem=self.baseInfoItemList[5]
sexItem:SetChildText(_baseInfoItemCmpIndex.info,FMT.fmt('性别：<color=#ffffff>{0}</color>',SEX_TYPE.getName2(self.lsData.sex)))


local attrsShow=cfgHelper.getdef(cfg_attributesconfig,'attrsShow')
local attrlist=lingshouModel:getAttrListByType(self.lsGuid,attrsShow,true,1)
self.attrLen=#attrlist
for i=1,self.attrInfoItemList.Count do
local item=self.attrInfoItemList[i-1]
local attr=attrlist[i]
local isShow=attr~=nil
item:SetChildActive(-1,isShow)
if isShow then
local attrType=attr[1]
local value=attr[2]
if value<0 then
value=0
end
local color_str='{0}：<color=#ffffff>{1}</color>'
item:SetChildText(1,helper.getAttributeStr(attrType,value,nil,color_str))
end
end


local skillList=lingshouModel:getSkillList(self.lsGuid)
self.skillLen=#skillList
for i=1,self.skillInfoItemList.Count do
local item=self.skillInfoItemList[i-1]
local d=skillList[i]
local isShow=d~=nil
item:SetChildActive(-1,isShow)
if isShow then
local skillID=d[1]
local skillLv=d[4]
local skillitem=item:GetChildWidgetBase(_skillInfoItemCmpIndex.skillitem)
self:refreshSkillItem(skillitem,skillID,skillLv,eSkillTipsType.eLSSkill)
end
end


local desclist=self.lsData and self.lsData.wordList
self.txLen=#desclist
for index=1,self.texinInfoItemList.Count do
local item=self.texinInfoItemList[index-1]
local wordId=desclist[index]
local isShow=wordId~=nil
item:SetChildActive(-1,isShow)
if isShow then
local cfg=cfgHelper.get(cfg_lingshouwordconfig_get,wordId)
local isReal=cfg~=nil
item:SetChildActive(-1,isReal)
if isReal then
local txitem=item:GetChildWidgetBase(_texinInfoItemCmpIndex.texinitem)
lingshouModel.refreshSpecialityItem(txitem,cfg,function()
_this:onDescSlotClick(index)
end)
end
end
end
end

function UILittleGame_CatchLingShou_GetWin:refreshSkillItem(item,skillId,skillLv,st)
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
local islock=skillLv<=0

item:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)

local isgray=islock
item:SetChildImageExGray(0,isgray)

local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(1,is_bd)

local showLevel=not islock
if st==eSkillTipsType.eLSTalentSkill then

showLevel=false
end
item:SetChildActive(4,showLevel)
if showLevel then
item:SetChildText(2,skillModel:getSkillLvStr(skillLv))
end

item:SetChildActive(5,islock)

item:SetChildButtonClick(3,function()
_this:onSkillItemClick(st,skillId,skillLv)
end)
end

function UILittleGame_CatchLingShou_GetWin:onSkillItemClick(skillType,skillID,skillLv)
local args={skillID=skillID,skillLv=skillLv,attend=skillType}
self:showWindow('UIDiscipleJobSkillTipsWin',args)
end

function UILittleGame_CatchLingShou_GetWin:onDescSlotClick(idx)
local wordId=self.desclist[idx]
local cfg=cfgHelper.get(cfg_lingshouwordconfig_get,wordId)
local item=self.descListPanel:getChildLayoutGroupGridItem(idx-1)

self:showWindow('UILingShouSpecialityWin',{item=item,node='top',guid=self.ls_guid,config=cfg,pivot=Vector2(0.5,0)})
end


local _layoutOffsetY=-1000

local _titleFixedPosX=0
local _titleFixedPosY=-24

local _leftPlayDuration=1
local _rightItemDuration=0.1
function UILittleGame_CatchLingShou_GetWin:playEnterAnimation()


self.root2:setChildCanvasGroupAlpha(0)
self:delayDo(0.2,function()
if _this==nil then return end
_this.root2:setChildCanvasGroupDOFade(1,_leftPlayDuration)
end)


local ltime=_leftPlayDuration
self.btitle:setChildAnchoredPos(_titleFixedPosX,_layoutOffsetY)

self:delayDo(ltime,function()
if _this==nil then return end
_this.btitle:setChildDOLocalMoveY(_titleFixedPosY,_rightItemDuration)
end)
ltime=ltime+_rightItemDuration


for index=1,self.baseInfoItemList.Count,2 do
local item=self.baseInfoItemList[index-1]
item:SetChildAnchoredPos(_baseInfoItemCmpIndex.layout,0,_layoutOffsetY)
self:delayDo(ltime,function()
if _this==nil then return end
item:SetChildDOLocalMoveY(_baseInfoItemCmpIndex.layout,0,_rightItemDuration)
end)
local item2=self.baseInfoItemList[index]
item2:SetChildAnchoredPos(_baseInfoItemCmpIndex.layout,0,_layoutOffsetY)
self:delayDo(ltime,function()
if _this==nil then return end
item2:SetChildDOLocalMoveY(_baseInfoItemCmpIndex.layout,0,_rightItemDuration)
end)
ltime=ltime+_rightItemDuration
end

self.atitle:setChildAnchoredPos(_titleFixedPosX,_layoutOffsetY)
self:delayDo(ltime,function()
if _this==nil then return end
_this.atitle:setChildDOLocalMoveY(_titleFixedPosY,_rightItemDuration)
end)
ltime=ltime+_rightItemDuration

for index=1,self.attrLen do
local item=self.attrInfoItemList[index-1]
item:SetChildAnchoredPos(_attrInfoItemCmpIndex.layout,0,_layoutOffsetY)
self:delayDo(ltime,function()
if _this==nil then return end
item:SetChildDOLocalMoveY(_baseInfoItemCmpIndex.layout,0,_rightItemDuration)
end)
ltime=ltime+_rightItemDuration
end


self.stitle:setChildAnchoredPos(_titleFixedPosX,_layoutOffsetY)
self:delayDo(ltime,function()
if _this==nil then return end
_this.stitle:setChildDOLocalMoveY(_titleFixedPosY,_rightItemDuration)
end)
ltime=ltime+_rightItemDuration

for index=1,self.skillLen do
local item=self.skillInfoItemList[index-1]
item:SetChildAnchoredPos(_baseInfoItemCmpIndex.layout,0,_layoutOffsetY)
self:delayDo(ltime,function()
if _this==nil then return end
item:SetChildDOLocalMoveY(_baseInfoItemCmpIndex.layout,0,_rightItemDuration)
end)
end
ltime=ltime+_rightItemDuration


self.txtitle:setChildAnchoredPos(_titleFixedPosX,_layoutOffsetY)
self:delayDo(ltime,function()
if _this==nil then return end
_this.txtitle:setChildDOLocalMoveY(_titleFixedPosY,_rightItemDuration)
end)
ltime=ltime+_rightItemDuration

for index=1,self.txLen do
local item=self.texinInfoItemList[index-1]
item:SetChildAnchoredPos(_baseInfoItemCmpIndex.layout,0,_layoutOffsetY)
self:delayDo(ltime,function()
if _this==nil then return end
item:SetChildDOLocalMoveY(_baseInfoItemCmpIndex.layout,0,_rightItemDuration)
end)
ltime=ltime+_rightItemDuration
end
end