







def_class("UIFightJunZhenHUD",UICloneObject)





UIFightJunZhenHUD.abName="ui/windows/fight/uifightjunzhenhud.ab"

UIFightJunZhenHUD.assetName="UIFightJunZhenHUD"


function UIFightJunZhenHUD:bindComponents()

self.bar=UIProgress.get(self,0)
self.baseInfo=UIObject.get(self,1)
self.BuffRoot=UIScrollView.get(self,2)
self.BuffRoot2=UIObject.get(self,3)
self.CounterATKPointRoot=UIObject.get(self,4)
self.Energy=UIObject.get(self,5)
self.energyBar=UIProgress.get(self,6)
self.EntityName=UIText.get(self,7)
self.fullHPHuDunbar=UIProgress.get(self,8)
self.fullSubHPMaxbar=UIProgress.get(self,9)
self.huDunbar=UIProgress.get(self,10)
self.Root=UIObject.get(self,11)

end


function UIFightJunZhenHUD:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bar);self.bar=nil;
_UIObject_release(self.baseInfo);self.baseInfo=nil;
_UIObject_release(self.BuffRoot);self.BuffRoot=nil;
_UIObject_release(self.BuffRoot2);self.BuffRoot2=nil;
_UIObject_release(self.CounterATKPointRoot);self.CounterATKPointRoot=nil;
_UIObject_release(self.Energy);self.Energy=nil;
_UIObject_release(self.energyBar);self.energyBar=nil;
_UIObject_release(self.EntityName);self.EntityName=nil;
_UIObject_release(self.fullHPHuDunbar);self.fullHPHuDunbar=nil;
_UIObject_release(self.fullSubHPMaxbar);self.fullSubHPMaxbar=nil;
_UIObject_release(self.huDunbar);self.huDunbar=nil;
_UIObject_release(self.Root);self.Root=nil;
end









local fightab="ui/windows/fight/sharedtextures/fight.ab"
local hpImage=
{
[1]="image_zdxietiao_1",
[2]="image_zdxietiao_2",
[3]="image_zdxietiao_3",
}


function UIFightJunZhenHUD:onLoaded(...)
self:bindComponents()
end


function UIFightJunZhenHUD:__delete()
self:unbindComponents()

self.ent=nil
self:stopUpdateTimer()

self.entHUD:setHUDWin(nil)
end




function UIFightJunZhenHUD:onShow(args,afterOnloaded)
self.entHUD=args.entHUD
self.entHUD:setHUDWin(self)
self.ent=self.entHUD.entity
local show=args.show
self.isClose=nil

self:showRoot(false)
if show then
self.baseInfo:setChildCanvasGroupAlpha(0)
self:fade(0.5,1)
self:flushPosition()
self:initEnt()


local HPType=fightEntityHPType.left
if self.ent.battle and self.ent.battle.teamHpType then
HPType=self.ent.battle.teamHpType
end
self:setHPSprite(self.ent.posInfo.left and HPType[1]or HPType[2])
end
end


function UIFightJunZhenHUD:onHide()

end

function UIFightJunZhenHUD:setHPSprite(index)
self.bar:setCSImageSprite(fightab,hpImage[index])
end

function UIFightJunZhenHUD:onUpdate()
self:flushPosition()
end

function UIFightJunZhenHUD:flushPosition()
if self.ent and self.Root then
local uiWorldPos=self.ent:getHudPosition()+fBTHelper.posOffset
self:setChildPosition(self.Root:getID(),uiWorldPos)
end
end

function UIFightJunZhenHUD:initEnt()
local ent=self.ent
self.EntityName:setText('')

self:setHP(ent:getAttribute(entityAttr.hp),ent:getAttribute(entityAttr.max_hp))

end

function UIFightJunZhenHUD:setHP(cur,max)
self.bar:setProgress(cur,max)
end

function UIFightJunZhenHUD:showRoot(show)
if show then
self:initUpdateTimer()
else
self:stopUpdateTimer()
end
self.Root:setActive(show)
end

function UIFightJunZhenHUD:initUpdateTimer()
self:stopUpdateTimer()
self.updateTimer=self:setTimer(0.1,0,function()self:onUpdate()end)
end

function UIFightJunZhenHUD:stopUpdateTimer()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end

function UIFightJunZhenHUD:fade(duration,targetVlaue)
if self.fadeTween then
self.fadeTween:Kill(false)
self.fadeTween=nil
end

self.fadeTween=self.baseInfo:setChildCanvasGroupDOFade(targetVlaue,duration)
end

function UIFightJunZhenHUD:setHuDunValue()

end

function UIFightJunZhenHUD:setSubHPMax()

end

