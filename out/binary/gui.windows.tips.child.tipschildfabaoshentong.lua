







def_class("tipsChildFabaoShentong",UICloneObject)





tipsChildFabaoShentong.abName="ui/windows/tips/child/tipschildfabaoshentong.ab"

tipsChildFabaoShentong.assetName="tipsChildFabaoShentong"


function tipsChildFabaoShentong:bindComponents()

self.desc=UIText.get(self,0)
self.Icon=UIImage.get(self,1)
self.title=UIText.get(self,2)
self.cd=UIText.get(self,3)
self.level=UIText.get(self,4)
self.name=UIText.get(self,5)
self.info=UIObject.get(self,6)
self.descExGrid=UIObject.get(self,7)
self.coolDown=UIObject.get(self,8)
self.skillCoolDownTxt=UIText.get(self,9)
self.gemPower=UIObject.get(self,10)
self.gemPowerText=UIText.get(self,11)
self.wuxing=UIObject.get(self,12)
self.wuxingText=UIText.get(self,13)
self.wuxingText2=UIText.get(self,14)
self.shanghai=UIObject.get(self,15)
self.shanghaiText=UIText.get(self,16)
self.shanghaiText2=UIText.get(self,17)

end


function tipsChildFabaoShentong:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.cd);self.cd=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.info);self.info=nil;
_UIObject_release(self.descExGrid);self.descExGrid=nil;
_UIObject_release(self.coolDown);self.coolDown=nil;
_UIObject_release(self.skillCoolDownTxt);self.skillCoolDownTxt=nil;
_UIObject_release(self.gemPower);self.gemPower=nil;
_UIObject_release(self.gemPowerText);self.gemPowerText=nil;
_UIObject_release(self.wuxing);self.wuxing=nil;
_UIObject_release(self.wuxingText);self.wuxingText=nil;
_UIObject_release(self.wuxingText2);self.wuxingText2=nil;
_UIObject_release(self.shanghai);self.shanghai=nil;
_UIObject_release(self.shanghaiText);self.shanghaiText=nil;
_UIObject_release(self.shanghaiText2);self.shanghaiText2=nil;
end






function tipsChildFabaoShentong:onLoaded()
self:bindComponents()
end

function tipsChildFabaoShentong:__delete()
self:unbindComponents()
end

function tipsChildFabaoShentong:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local item=equipsHelper.getEquip(itemguid)
local isShowShentongInfo=attach and attach.isShowShentongInfo or false

local shentongid,shentongLv
if item then
shentongid,shentongLv=fabaoHelper.getShentongid(item)
elseif itemid then

shentongid,shentongLv=fabaoHelper.getShentongidByMainItemId(itemid)
end

if shentongid==nil or fabaoConfig.isBenMingFabao(itemid)then
self:recycleSelf()
return
end
local isMakeByEquip=itemsConfig.isEquip(itemid)
local stage=itemConfig.stage or 0
stage=isMakeByEquip and fabaoConfig.getFabaoStageByEquipStage(stage)or stage
local shentongConfig=fabaoConfig.getShentongConfig(shentongid)
local shentongIcon=iconHelper.getSkillIcon(shentongConfig.icon)
local shentongName=shentongConfig.name
local shentonglvStr=FMT.fmt('{0}级',shentongLv)
local desc=skillModel:getSkillDesc(shentongid,shentongLv)

self.Icon:setImageIcon(shentongIcon)
self.name:setText(shentongName)
self.desc:setText(desc)
self.level:setText(shentonglvStr)

self:showShentongInfo(isShowShentongInfo,item,shentongid,shentongLv)
end

function tipsChildFabaoShentong:showShentongInfo(isShowShentongInfo,item,shentongid,shentongLv)
self.info:setActive(isShowShentongInfo)
if not isShowShentongInfo or not item then
return
end

local shentongConfig=fabaoConfig.getShentongConfig(shentongid)


local descExList=skillModel:getSkillDescEx(shentongid,shentongLv)
local descExNum=0
if descExList~=nil then
descExNum=#descExList
end
local showDescEx=descExNum>0
self.descExGrid:setActive(showDescEx)
if showDescEx then
self.descExGrid:setChildLayoutGroupCreateItems(descExNum)
local descExGrid=self.descExGrid:getChildLayoutGroupGridList(1)
for i=1,descExNum do
local descItem=descExGrid[i-1]
local txt=descExList[i]
descItem:SetChildText(0,txt)
end
end

local coolDown=skillModel:getSkillCooldownTime(shentongid,shentongLv)
local itemData=item and item.itemData or nil
local discipleguid=itemData and itemData.discipleguid or nil
if discipleguid~=nil and UIDiscipleModel:isMyActorDZ(discipleguid)then
coolDown=UIDiscipleModel:getSkillCoolDown(discipleguid,shentongid,coolDown)
end
local isCoolDown=coolDown>0
self.coolDown:setActive(isCoolDown)
if isCoolDown then
local cooldown_str=FMT.fmt('冷却：{0}回合',coolDown)
self.skillCoolDownTxt:setText(cooldown_str)
end

local maxGemPower=shentongConfig.maxGemPower
local showGemPower=maxGemPower~=nil and maxGemPower>0
self.gemPower:setActive(showGemPower)
if showGemPower then
local gemPower_str=FMT.fmt('神通蓄力值：{0}',maxGemPower)
self.gemPowerText:setText(gemPower_str)
end

local skillYuanSu=shentongConfig.skillYuanSu
local showYuanSu=skillYuanSu~=nil
self.wuxing:setActive(showYuanSu)
if showYuanSu then
local yuansu_str=FMT.fmt('五行系别：{0}',ELEMENT_TYPE.getName(skillYuanSu))
local attrType=elementAttrLookup[skillYuanSu][1]
local attrValue
if discipleguid~=nil and UIDiscipleModel:isMyActorDZ(discipleguid)then
local dzAttrLookup=UIDiscipleModel:getDiscipleMultipleAttrLookup(discipleguid)or{}
attrValue=dzAttrLookup[attrType]
end
local yuansu_str2=''
if attrValue~=nil and attrValue>0 then
local str=elementAttrLookup.getDesc(skillYuanSu)
local str2=helper.getAttributeStrEx(attrType,attrValue)
yuansu_str2=FMT.fmt('({0}+{1})',str,str2)
end
self.wuxingText:setText(yuansu_str)
self.wuxingText2:setText(yuansu_str2)
end

local hurtType=shentongConfig.hurtType
local showHurt=hurtType~=nil
self.shanghai:setActive(showHurt)
if showHurt then
local hurt_str=FMT.fmt('伤害类型：{0}',eSkillHurtLookup[hurtType].name)
local hurt_str2=''
if hurtType~=eSkillHurtType.eNone then
local attrType=eSkillHurtLookup[hurtType].attr[1]
local attrValue
if discipleguid~=nil and UIDiscipleModel:isMyActorDZ(discipleguid)then
local dzAttrLookup=UIDiscipleModel:getDiscipleMultipleAttrLookup(discipleguid)or{}
attrValue=dzAttrLookup[attrType]
end
if attrValue~=nil and attrValue>0 then
local str=eSkillHurtLookup[hurtType].desc
local str2=helper.getAttributeStrEx(attrType,attrValue)
hurt_str2=FMT.fmt('({0}+{1})',str,str2)
end
end
self.shanghaiText:setText(hurt_str)
self.shanghaiText2:setText(hurt_str2)
end
end
