







def_class("UIXianMoZhuanZhi_transferPreviewWin",UIWindowBase)









function UIXianMoZhuanZhi_transferPreviewWin:bindComponents()

self.attrTitle_1=UIText.get(self,0)
self.attrTitle_2=UIText.get(self,1)
self.attrTitle_3=UIText.get(self,2)
self.attrValue_1=UIText.get(self,3)
self.attrValue_2=UIText.get(self,4)
self.attrValue_3=UIText.get(self,5)
self.closeBtn=UIButton.get(self,6)
self.dzBg=UIImage.get(self,7)
self.dzModel=UIObject.get(self,8)
self.skill_1=UIImage.get(self,9)
self.skill_2=UIImage.get(self,10)
self.skill_3=UIImage.get(self,11)
self.skillDesc_1=UIText.get(self,12)
self.skillDesc_2=UIText.get(self,13)
self.skillDesc_3=UIText.get(self,14)
self.title=UIText.get(self,15)
self.totalAttr=UIText.get(self,16)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.attrTitle={
self.attrTitle_1,
self.attrTitle_2,
self.attrTitle_3,
}
self.attrValue={
self.attrValue_1,
self.attrValue_2,
self.attrValue_3,
}
self.skill={
self.skill_1,
self.skill_2,
self.skill_3,
}
self.skillDesc={
self.skillDesc_1,
self.skillDesc_2,
self.skillDesc_3,
}



end


function UIXianMoZhuanZhi_transferPreviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrTitle_1);self.attrTitle_1=nil;
_UIObject_release(self.attrTitle_2);self.attrTitle_2=nil;
_UIObject_release(self.attrTitle_3);self.attrTitle_3=nil;
_UIObject_release(self.attrValue_1);self.attrValue_1=nil;
_UIObject_release(self.attrValue_2);self.attrValue_2=nil;
_UIObject_release(self.attrValue_3);self.attrValue_3=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.dzBg);self.dzBg=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.skill_1);self.skill_1=nil;
_UIObject_release(self.skill_2);self.skill_2=nil;
_UIObject_release(self.skill_3);self.skill_3=nil;
_UIObject_release(self.skillDesc_1);self.skillDesc_1=nil;
_UIObject_release(self.skillDesc_2);self.skillDesc_2=nil;
_UIObject_release(self.skillDesc_3);self.skillDesc_3=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.totalAttr);self.totalAttr=nil;
self.attrTitle=nil;
self.attrValue=nil;
self.skill=nil;
self.skillDesc=nil;
end



















function UIXianMoZhuanZhi_transferPreviewWin:onLoaded(...)
self:bindComponents()
end


function UIXianMoZhuanZhi_transferPreviewWin:__delete()
self:unbindComponents()
end




function UIXianMoZhuanZhi_transferPreviewWin:onShow(argtable,afterOnloaded)
self.type,self.dis_guid=unpack(argtable)
self.voc=UIDiscipleModel:getDiscipleJob(self.dis_guid)
self.baseCfg=cfgHelper.get1(cfg_disciplevocconfig_get,1)
local vocCfg=cfgHelper.get1(cfg_disciplevocationconfig_get,self.voc)
local xm_name=vocCfg.xm_name[self.type]
self.title:setText(string.format('%s预览',xm_name))
self.totalAttr:setText(string.format("境界修为属性  <color=#549327>+%d%%</color>",self.baseCfg.jingjie_attr_add))
self.dzBg:setSprite("ui/windows/xianmozhuanzhi/xianmozhuanzhi_pak.ab",self.type==1 and"image_xianbeijing_1"or"image_mobeijing_1")

local attrList=self.type==1 and self.baseCfg.attr1[self.voc]or self.baseCfg.attr2[self.voc]
for i=1,3 do
local attr=attrList[i]
if attr then
local attrType,attrValue=unpack(attr)
local attrConfig=cfg_attributesconfig_get(attrType)
local name=attrConfig.attrname
local valStr=helper.getAttributeStrEx(attrType,attrValue)
self.attrTitle[i]:setText(name)
self.attrValue[i]:setText(string.format("+%s",valStr))
else
self.attrTitle[i]:setActive(false)
self.attrValue[i]:setActive(false)
end
end

local xianSkillList,moSkillList=WenXinGuanModel:getDzXMSkill(self.dis_guid,true)
local skillList=self.type==1 and xianSkillList or moSkillList
for i=1,3 do
if skillList[i]then
local skillid=skillList[i]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillid)
local icon=iconHelper.getSkillIcon(skillCfg.icon)
local desc=skillModel:getSkillDesc(skillid,1)
local descEx=nil
self.skill[i]:setChildIcon(icon,false)
if descEx then
self.skillDesc[i]:setText(string.format("<color=#171311>%s</color>\n%s",desc,table.concat(descEx,"\n")))
else
self.skillDesc[i]:setText(string.format("<color=#171311>%s</color>",desc))
end
end
end

local xianModel,moModel=WenXinGuanModel:getDzXMSuit(self.dis_guid)
local model=self.type==1 and xianModel or moModel
self.dzModel:setChildUIModelShowTarget(model,1.6,{},eAnimationID.stand)
self.dzModel:setChildUIModelShowFlipX(self.type==1)
end

function UIXianMoZhuanZhi_transferPreviewWin:onCloseBtn()
self:closeSelf()
end