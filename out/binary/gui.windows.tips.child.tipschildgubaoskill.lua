







def_class("tipsChildGuBaoSkill",UICloneObject)





tipsChildGuBaoSkill.abName="ui/windows/tips/child/tipschildgubaoskill.ab"

tipsChildGuBaoSkill.assetName="tipsChildGuBaoSkill"


function tipsChildGuBaoSkill:bindComponents()

self.title=UIText.get(self,0)
self.desc=UIText.get(self,1)

end


function tipsChildGuBaoSkill:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.desc);self.desc=nil;
end







function tipsChildGuBaoSkill:onLoaded(...)
self:bindComponents()
end


function tipsChildGuBaoSkill:__delete()
self:unbindComponents()
end


function tipsChildGuBaoSkill:onHide()

end

function tipsChildGuBaoSkill:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local gbid
if data.tipsType==TIPS_TYPE.eCommonGubao then
gbid=data.itemid
else
gbid=gubaoLookup:good2GuBao(data.itemid)
end
local attach=data.attach

self.title:setText('被动效果')
local skilllv=1
local flag=false
if data.formType==TIPS_FORM_TYPE.eGubaoWin or data.formType==TIPS_FORM_TYPE.eGubaoCheck then
if gubaoModel:checkActive(gbid)then
skilllv=gubaoModel:getSkillLv(gbid)
flag=true
end
end
local skill_str,skill_str_2,skill_str_3=gubaoModel:getSkillDesc(gbid,skilllv)
if flag then
if skill_str_2 then
skill_str=FMT.fmt('{0}\n{1}',skill_str,skill_str_2)
end
if skill_str_3 then
skill_str=FMT.fmt('{0}\n{1}',skill_str,skill_str_3)
end
end
self.desc:setText(skill_str)
end

