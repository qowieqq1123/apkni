







def_class("tipsChildCSJDWeaponSkill",UICloneObject)





tipsChildCSJDWeaponSkill.abName="ui/windows/tips/child/tipschildcsjdweaponskill.ab"

tipsChildCSJDWeaponSkill.assetName="tipsChildCSJDWeaponSkill"


function tipsChildCSJDWeaponSkill:bindComponents()

self.creater=UIObject.get(self,0)
self.line=UIObject.get(self,1)
self.title=UIText.get(self,2)

end


function tipsChildCSJDWeaponSkill:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.creater);self.creater=nil;
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildCSJDWeaponSkill:onLoaded(...)
self:bindComponents()
end


function tipsChildCSJDWeaponSkill:__delete()
self:unbindComponents()
end




function tipsChildCSJDWeaponSkill:onShow(argtable,afterOnloaded)
local args=argtable.argtable
local id=args.itemid
local attach=args.attach
self.id=id
self.actId=attach.actId
self.subType=attach.subType
self.subId=attach.subId
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self:refreshView()
end


function tipsChildCSJDWeaponSkill:onHide()

end



function tipsChildCSJDWeaponSkill:refreshView()
local treasureServer=self.config.treasure[self.id]
local skillid=treasureServer[2]
local skilllv=treasureServer[3]
self.creater:setChildLayoutGroupCreateItems(1)
local item=self.creater:getChildLayoutGroupGridItem(0)
local cfg=cfgHelper.get1(cfg_skillconfig_get,skillid)
local name=cfg.name
local nameTitle=""
local desc=skillModel:getSkillDesc(skillid,skilllv)
local descEx=skillModel:getSkillDescEx(skillid,skilllv)or{}
desc=FMT.fmt('{0}{1}',nameTitle,desc)
for i,v in ipairs(descEx)do
local str=FMT.fmt('<color=#ffff99>{0}</color>',v)
desc=FMT.fmt('{0}\n{1}',desc,str)
end
desc=comHelper.getCheckLayoutStr(item:GetChildGameObject(1),332,desc,true)
item:SetChildText(0,desc)
end