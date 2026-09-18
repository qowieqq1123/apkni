







def_class("UIFightPrepareZMVCConditionWin",UIWindowBase)









function UIFightPrepareZMVCConditionWin:bindComponents()

self.Root=UIObject.get(self,0)
self.uiroot=UIObject.get(self,1)
self.conditionList=UIObject.get(self,2)



end


function UIFightPrepareZMVCConditionWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiroot);self.uiroot=nil;
_UIObject_release(self.conditionList);self.conditionList=nil;
end



















function UIFightPrepareZMVCConditionWin:onLoaded(...)
self:bindComponents()
end


function UIFightPrepareZMVCConditionWin:__delete()
self:unbindComponents()
end




function UIFightPrepareZMVCConditionWin:onShow(argtable,afterOnloaded)
local challengeId=argtable.challenge_id
local levelId=argtable.level_id

local levelCfg=cfgHelper.get2(cfg_visitorchallengelayerconfig_get,challengeId,levelId)

local conditionStrlist=levelCfg.targettrlist

self.conditionList:setChildLayoutGroupCreateItems(#conditionStrlist,function(index)
local item=self.conditionList:getChildLayoutGroupGridItem(index-1)
local condition=conditionStrlist[index][1]
item:SetChildActive(-1,condition~=nil)
if condition then
item:SetChildText(0,condition)
end
end)
end


function UIFightPrepareZMVCConditionWin:onHide()

end



