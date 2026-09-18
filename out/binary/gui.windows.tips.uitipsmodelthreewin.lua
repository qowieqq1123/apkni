







def_class("UITipsModelThreeWin",UIWindowBase)









function UITipsModelThreeWin:bindComponents()

self.root=UIObject.get(self,0)
self.iconImg=UIImage.get(self,1)
self.iconEffect=UIObject.get(self,2)
self.iconImg1=UIImage.get(self,3)
self.liandon=UIObject.get(self,4)
self.liandonImage=UIImage.get(self,5)
self.liandonTimeBg=UIImage.get(self,6)
self.liandonTimeText=UIText.get(self,7)



end


function UITipsModelThreeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.iconImg);self.iconImg=nil;
_UIObject_release(self.iconEffect);self.iconEffect=nil;
_UIObject_release(self.iconImg1);self.iconImg1=nil;
_UIObject_release(self.liandon);self.liandon=nil;
_UIObject_release(self.liandonImage);self.liandonImage=nil;
_UIObject_release(self.liandonTimeBg);self.liandonTimeBg=nil;
_UIObject_release(self.liandonTimeText);self.liandonTimeText=nil;
end
















local _movePosX=
{
[TIPS_MOVE_POS.eRight]=280,
[TIPS_MOVE_POS.eLeft]=-280,
[TIPS_MOVE_POS.eCenter]=0,
[TIPS_MOVE_POS.eRightTwo]=330,
}


function UITipsModelThreeWin:onLoaded(...)
self:bindComponents()
end


function UITipsModelThreeWin:__delete()
self:unbindComponents()
end


function UITipsModelThreeWin:onHide()

end




function UITipsModelThreeWin:onShow(argtable,afterOnloaded)
local itemid=argtable and argtable.itemid
local itemConfigType=argtable and argtable.itemConfigType
self.relevantPram=argtable and argtable.relevantPram
self.moveType=argtable and argtable.moveType

local pram=self.relevantPram.pram
local moveAni=pram.moveAni
if moveAni==nil then moveAni=true end

self.moveAni=moveAni
self.offset=pram.offset

if not moveAni then
local x=0
if self.offset then
if self.offset[1]then
x=self.offset[1]
end
end
self.winlua:SetChildLocalPosX(self.root:getID(),_movePosX[self.moveType]+x)
end



self.isDotween=pram.isDotween
if not self.isDotween then
self.winlua:SetChildActive(3,false)
self.winlua:SetChildActive(1,true)
else
self.winlua:SetChildActive(1,false)
self.winlua:SetChildActive(3,true)
end

self.winlua:SetChildDOTweenAnimation_DOPlay(self.root:getID(),1,0,3)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.root:getID(),2,0,3)

self:updateView()

local linkageId=itemid and liandonModel:getLianDonLinkageIdByItemId(itemid,itemConfigType)or 0
self:showLianDon(linkageId,itemConfigType)
end

function UITipsModelThreeWin:showLianDon(linkageId,type)
self.liandon:setActive(linkageId>0)
if linkageId>0 then
self.winlua:SetChildDOTweenAnimation_DOPlay(self.liandon:getID(),1,0,3)
local liandonCfg=liandonModel:getLianDonConfig(linkageId or 1)
self.liandonImage:setSprite(globalABLookup.liandonLogin,liandonCfg.image)
self.liandonTimeBg:setActive(false)


end
end

function UITipsModelThreeWin:updateView()
local pram=self.relevantPram.pram
local icon=pram.icon or''
local effectid=pram.effectid
local playAni=pram.playAni
local pos=self:getChildCanvas(-1)

if not self.isDotween then
self.iconImg:setImageIcon(icon,true)
self.iconImg:setChildCanvas(pos[1],pos[2]+2)
else
self.iconImg1:setImageIcon(icon,true)
self.iconImg1:setChildCanvas(pos[1],pos[2]+2)
end

if effectid then
self.effectid=effectid
self.iconEffect:setChildShowEffect(effectid,true)
else
if self.effectid then
self.iconEffect:setChildShowEffect(0,false)
end
end
end

function UITipsModelThreeWin:onAniComplete()
if not self.moveAni then return end
if self.moveType then
local x=0
if self.offset then
if self.offset[1]then
x=self.offset[1]
end
end
self.winlua:SetChildDOLocalMoveX(self.root:getID(),_movePosX[self.moveType]+x,0.3)
end
end
