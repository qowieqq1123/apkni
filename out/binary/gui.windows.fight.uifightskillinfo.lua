







def_class("UIFightSkillInfo",UIWindowBase)









function UIFightSkillInfo:bindComponents()

self.Root=UIObject.get(self,0)
self.model=UIObject.get(self,1)
self.tltle=UIObject.get(self,2)



end


function UIFightSkillInfo:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.tltle);self.tltle=nil;
end



















function UIFightSkillInfo:onLoaded(...)
self:bindComponents()
self.fadeList={}
end


function UIFightSkillInfo:__delete()





self:unbindComponents()
end




function UIFightSkillInfo:onShow(argtable,afterOnloaded)
self.Root:setActive(false)
local ent=argtable.ent
if ent~=nil then
local isLeft=ent:isLeft()
if isLeft then
self.Root:setRotation(0,0,0)
self.tltle:setRotation(0,0,0)
else
self.Root:setRotation(0,180,0)
self.tltle:setRotation(0,180,0)
end
local imageInfo=ent:getImageInfo()


AudioManager.playAudio(12000)
self:delayDo(0.3,function()
if imageInfo~=nil then
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo)
local onLoadFinish=function()
self.Root:setActive(true)
end
self.model:setChildUIModelShowTarget(modelParams.body,modelParams.scale,modelParams.componets,modelParams.anim,true,true,0.3,onLoadFinish)
self.model:setChildUIModelShowTargetOffset(0,-28)
else
if ent.baseInfo.typo>0 and ent.baseInfo.monsterID then
local npcId=cfgHelper.get(cfg_monsterconfig_get,ent.baseInfo.monsterID,"npcID")
if npcId then
local imageInfo=fightPreSelectModel.getNPCInSideModel(npcId)
local onLoadFinish=function()
self.Root:setActive(true)
end
self.model:setChildUIModelShowTarget(imageInfo.body,1,imageInfo.componets,eAnimationID.stand,true,true,0.3,onLoadFinish)
self.model:setChildUIModelShowTargetOffset(0,-28)
end
end
end

end)












end
end


function UIFightSkillInfo:onHide()

end



