







def_class("UITipsDaoBingModelWin",UIWindowBase)









function UITipsDaoBingModelWin:bindComponents()

self.root=UIObject.get(self,0)
self.effectBg=UIObject.get(self,1)
self.effect=UIObject.get(self,2)
self.liandon=UIObject.get(self,3)
self.liandonImage=UIImage.get(self,4)
self.liandonTimeBg=UIImage.get(self,5)
self.liandonTimeText=UIText.get(self,6)



end


function UITipsDaoBingModelWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.effectBg);self.effectBg=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.liandon);self.liandon=nil;
_UIObject_release(self.liandonImage);self.liandonImage=nil;
_UIObject_release(self.liandonTimeBg);self.liandonTimeBg=nil;
_UIObject_release(self.liandonTimeText);self.liandonTimeText=nil;
end

















local _bgEffectId=
{
[eQualityColor.ePurple]=10185,
[eQualityColor.eOrange]=10186,
[eQualityColor.eRed]=10187,
}

function UITipsDaoBingModelWin:onLoaded(...)
self:bindComponents()
end

function UITipsDaoBingModelWin:__delete()
self:unbindComponents()
end


function UITipsDaoBingModelWin:onShow(argtable,afterOnloaded)
local oitemid=argtable.itemid
local itemid=oitemid
if itemsConfig.isDaoBingMaterials(oitemid)then
itemid=itemsConfig.getConfig(oitemid).piece[1]
end
local attach=argtable.attach
local itemguid=argtable.itemguid
local modelArgs=argtable.args or{}
local isMaxStar
local maxlv=daobingConfig.getStarMaxLv(itemid)
if itemguid then
local starlv=daobingModel:getStarLv(itemguid)
isMaxStar=starlv==maxlv
else
local starlv=modelArgs.starlv or attach.starlv or 0
isMaxStar=starlv==maxlv
end
local itemCfg=itemsConfig.getConfig(itemid)
local color=itemCfg.color
self.winlua:SetChildDOTweenAnimation_DOPlay(self.root:getID(),1,0,3)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.root:getID(),2,0,3)

local modelParams=itemsConfig.getConfig(itemid).model
local effectInfo=isMaxStar and modelParams[2]or modelParams[1]
self.effect:setChildShowEffect(effectInfo[1],true)
self.effectBg:setChildShowEffect(_bgEffectId[color],true)

local linkageId=liandonModel:getLianDonLinkageIdByItemId(oitemid)
self:showLianDon(linkageId)
end

function UITipsDaoBingModelWin:showLianDon(linkageId)
self.liandon:setActive(linkageId>0)
if linkageId>0 then
self.winlua:SetChildDOTweenAnimation_DOPlay(self.liandon:getID(),1,0,3)
local liandonCfg=liandonModel:getLianDonConfig(linkageId or 1)
self.liandonImage:setSprite(globalABLookup.liandonLogin,liandonCfg.image)
self.liandonTimeBg:setActive(false)


end
end

function UITipsDaoBingModelWin:onHide()

end



function UITipsDaoBingModelWin:onAniComplete()
self.winlua:SetChildDOLocalMoveX(self.root:getID(),-300,0.3)
end
