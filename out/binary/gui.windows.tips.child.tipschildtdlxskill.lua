







def_class("tipsChildTDLXSkill",UICloneObject)





tipsChildTDLXSkill.abName="ui/windows/tips/child/tipschildtdlxskill.ab"

tipsChildTDLXSkill.assetName="tipsChildTDLXSkill"


function tipsChildTDLXSkill:bindComponents()

self.desc=UIText.get(self,0)
self.title=UIText.get(self,1)

end


function tipsChildTDLXSkill:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildTDLXSkill:onLoaded(...)
self:bindComponents()
end


function tipsChildTDLXSkill:__delete()
self:unbindComponents()
end




function tipsChildTDLXSkill:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local tjId=wanLingTaModel:good2TDLX(data.itemid)
local tjCfg=wanLingTaModel:getTuJianConfig(tjId)
local attach=data.attach
local tjData=wanLingTaModel:getTuJianData(tjId)
local level=math.max(tjData.level,1)

self.title:setText('被动效果')
local propRewardsDesc=tjCfg.propRewardsDesc[level]
local skill_str
for i,v in ipairs(propRewardsDesc)do
if i==1 then
skill_str=v
else
skill_str=string.format("%s\n%s",skill_str,v)
end
end
self.desc:setText(skill_str)
end