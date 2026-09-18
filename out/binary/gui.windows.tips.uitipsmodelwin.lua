







def_class("UITipsModelWin",UIWindowBase)









function UITipsModelWin:bindComponents()

self.model=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.liandon=UIObject.get(self,2)
self.liandonImage=UIImage.get(self,3)
self.liandonTimeBg=UIImage.get(self,4)
self.liandonTimeText=UIText.get(self,5)



end


function UITipsModelWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.liandon);self.liandon=nil;
_UIObject_release(self.liandonImage);self.liandonImage=nil;
_UIObject_release(self.liandonTimeBg);self.liandonTimeBg=nil;
_UIObject_release(self.liandonTimeText);self.liandonTimeText=nil;
end


















function UITipsModelWin:onLoaded(...)
self:bindComponents()
end

function UITipsModelWin:__delete()
self:unbindComponents()
end

function UITipsModelWin:onShow(argtable,afterOnloaded)
local itemid=argtable.itemid
local modelParams=argtable.model
local modelID=modelParams.model
local defsize=cfgHelper.get2(cfg_dbbodyconfig_get,modelID,'scales')or{}
local size=modelParams.scale or defsize[1]or 1
local componnets=modelParams.cmp or{}
local animationID=modelParams.ani or 0
local offset=modelParams.offset
self.winlua:SetChildDOTweenAnimation_DOPlay(self.root:getID(),1,0,3)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.root:getID(),2,0,3)
self.model:setChildUIModelEnableInitUISpinePara(false,true)
self.winlua:SetChildUIModelShowTarget(self.model:getID(),modelID,size,componnets,animationID)
if offset then
self.winlua:SetChildUIModelShowTargetOffset(self.model:getID(),offset[1],offset[2])
end

local linkageId=liandonModel:getLianDonLinkageIdByItemId(itemid)
self:showLianDon(linkageId,itemid)
end

function UITipsModelWin:showLianDon(linkageId,itemid)
self.liandon:setActive(linkageId>0)
if linkageId>0 then
self.winlua:SetChildDOTweenAnimation_DOPlay(self.liandon:getID(),1,0,3)
local liandonCfg=liandonModel:getLianDonConfig(linkageId or 1)
self.liandonImage:setSprite(globalABLookup.liandonLogin,liandonCfg.image)
self.liandonTimeBg:setActive(false)



local cfg=itemsConfig.getConfig(itemid)
if cfg.type1==3 and(cfg.type2==1 or cfg.type2==6)then
self.liandon:setLocalPosY(-250)
end
end
end

function UITipsModelWin:onHide()

end



function UITipsModelWin:onAniComplete()
self.winlua:SetChildDOLocalMoveX(self.root:getID(),-300,0.3)
end
