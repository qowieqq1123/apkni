







def_class("UITipsXianBaoModelWin",UIWindowBase)









function UITipsXianBaoModelWin:bindComponents()

self.root=UIObject.get(self,0)
self.effectBg=UIObject.get(self,1)
self.effect=UIObject.get(self,2)
self.liandon=UIObject.get(self,3)
self.liandonImage=UIImage.get(self,4)
self.liandonTimeBg=UIImage.get(self,5)
self.liandonTimeText=UIText.get(self,6)



end


function UITipsXianBaoModelWin:unbindComponents()
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

}


function UITipsXianBaoModelWin:onLoaded(...)
self:bindComponents()
end


function UITipsXianBaoModelWin:__delete()
self:unbindComponents()
end




function UITipsXianBaoModelWin:onShow(argtable,afterOnloaded)
local itemid=argtable.itemid
local attach=argtable.attach
local formType=argtable.formType
local modelArgs=argtable.args or{}
local itemConfigType=argtable and argtable.itemConfigType

local isMaxStar
local maxlv=1
local starlv=1
local dfxb=xianbaoModel:CheckDianfengXianbao(itemid)
if dfxb then
maxlv=#cfg_dianfenglevelconfig()
starlv=DianFengLevelModel:getLevel()
else
maxlv=xianbaoConfig.getXBMaxStar(itemid)
starlv=xianbaoModel:getXbStart(itemid)
end
if xianbaoModel:checkCanUpStar(itemid)and not xianbaoModel:checkActive(itemid)then
starlv=attach.starlv or 0
end
if formType==TIPS_FORM_TYPE.eXianBaoBag or formType==TIPS_FORM_TYPE.eXianBaoMaterial then
starlv=attach.starlv or 0
end
isMaxStar=starlv==maxlv

local itemCfg=itemsConfig.getConfig(itemid,itemConfigType)
local color=itemCfg.color
self.winlua:SetChildDOTweenAnimation_DOPlay(self.root:getID(),1,0,3)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.root:getID(),2,0,3)

local modelParams=itemsConfig.getConfig(itemid,itemConfigType).model
local effectInfo=isMaxStar and modelParams[2]or modelParams[1]
self.effect:setChildShowEffect(effectInfo[1],true)
if _bgEffectId[color]then
self.effectBg:setChildShowEffect(_bgEffectId[color],true)
end


local linkageId=liandonModel:getLianDonLinkageIdByItemId(itemid,itemConfigType)
self:showLianDon(linkageId)
end

function UITipsXianBaoModelWin:showLianDon(linkageId)
self.liandon:setActive(linkageId>0)
if linkageId>0 then
self.winlua:SetChildDOTweenAnimation_DOPlay(self.liandon:getID(),1,0,3)
local liandonCfg=liandonModel:getLianDonConfig(linkageId or 1)
self.liandonImage:setSprite(globalABLookup.liandonLogin,liandonCfg.image)
self.liandonTimeBg:setActive(false)


end
end


function UITipsXianBaoModelWin:onHide()

end




function UITipsXianBaoModelWin:onAniComplete()
self.winlua:SetChildDOLocalMoveX(self.root:getID(),-300,0.3)
end