







def_class("UIPlanent",UIWindowBase)









function UIPlanent:bindComponents()

self.backEffect_1=UIObject.get(self,0)
self.backEffect_2=UIObject.get(self,1)
self.backEffect_3=UIObject.get(self,2)
self.backEffect_4=UIObject.get(self,3)
self.backEffectCenter=UIObject.get(self,4)
self.LittlePlanet=UIObject.get(self,5)
self.shou=UIObject.get(self,6)
self.xh772100_1=UIObject.get(self,7)
self.xh772100_2=UIObject.get(self,8)
self.xh772100_3=UIObject.get(self,9)
self.xh772100_4=UIObject.get(self,10)
self.backEffect={
self.backEffect_1,
self.backEffect_2,
self.backEffect_3,
self.backEffect_4,
}
self.xh772100={
self.xh772100_1,
self.xh772100_2,
self.xh772100_3,
self.xh772100_4,
}



end


function UIPlanent:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backEffect_1);self.backEffect_1=nil;
_UIObject_release(self.backEffect_2);self.backEffect_2=nil;
_UIObject_release(self.backEffect_3);self.backEffect_3=nil;
_UIObject_release(self.backEffect_4);self.backEffect_4=nil;
_UIObject_release(self.backEffectCenter);self.backEffectCenter=nil;
_UIObject_release(self.LittlePlanet);self.LittlePlanet=nil;
_UIObject_release(self.shou);self.shou=nil;
_UIObject_release(self.xh772100_1);self.xh772100_1=nil;
_UIObject_release(self.xh772100_2);self.xh772100_2=nil;
_UIObject_release(self.xh772100_3);self.xh772100_3=nil;
_UIObject_release(self.xh772100_4);self.xh772100_4=nil;
self.backEffect=nil;
self.xh772100=nil;
end


















local blockPos={{1.61,0,2.22},{-11.07,0,97.6},{-0.21,0,197.4},{-23.4,0,276.7}}

local autoSpeed=Vector3.New(5,0,0)

local _stopEffect=CS.GameInterface.StopEffect


function UIPlanent:onLoaded(...)
self:bindComponents()
self.starEntShowTreener={}
self.slotEnt={}
self.starEnt={}
self.isShowStar=true
self.starSlotShow={}
self.lvEffect={}
self.showTrans=self.shou:getTransform()
end


function UIPlanent:__delete()

self:unbindComponents()
self:enableTouch(false)
buildlightController:resume()
UIFullLittleWorldControl:setOpenPlanent()
self:removeBigOrbit()
end




function UIPlanent:onShow(argtable,afterOnloaded)

local tabType=argtable and argtable.tabType

buildlightController:pause()


if api_Available_GetChildLoop3DGround()then

self.loopGround=self.winlua:GetChildLoop3DGround(self.LittlePlanet:getID())

self.loopGround:SetSatelliteVisible(1,false)
self.loopGround:SetSatelliteVisible(2,false)
self.loopGround:SetSatelliteVisible(3,false)
self.loopGround:SetSatelliteVisible(4,false)
self:onTabOpen(tabType)


self:initZwSlot()
self:initStars()



UIFullLittleWorldControl:setOpenPlanent(true)
end
end

function UIPlanent:onShowArgRecv(argtable)
local tabType=argtable and argtable.tabType
self:onTabOpen(tabType)
end

function UIPlanent:onTabOpen(tabType)
self:enableTouch(true)
if tabType==FULL_TAB_TYPE.eLittleWorld then
self:showStarAnim(true)
elseif tabType==FULL_TAB_TYPE.eLittleWorld_ZhenWu then
self:showStarAnim(false)
elseif tabType==FULL_TAB_TYPE.eLittleWorld_XingChen then
self:showStarHalo(true)
end

end

function UIPlanent:initStars()
self:showStar(true)
for i=1,4 do
self:refreshStar(i)
end
end

function UIPlanent:refreshStar(index)
if not api_Available_GetChildLoop3DGround()then return end
local posData=xingChenBagModel:getPosData()
local equip=posData[index]
if equip then

if self.starEnt[index]then
self:removeEntity(self.starEnt[index])
self:setTimer(0.06,1,function()
local itemCfg=itemsConfig.getConfig(equip.itemid)
self.starEnt[index]=self:addOrbit(index,itemCfg.star_model,36,25,-30,50,nil)
self:playOrbitEffect(index,20265)
self:playOrbitLevelEffect(index)
end)
else
local itemCfg=itemsConfig.getConfig(equip.itemid)
self.starEnt[index]=self:addOrbit(index,itemCfg.star_model,36,25,-30,50,nil)
self:playOrbitEffect(index,20265)
self:playOrbitLevelEffect(index)
end
else

if self.starEnt[index]then
self:removeEntity(self.starEnt[index])
end
end
end


function UIPlanent:removeStars()
for i=1,4 do
local guid=self.starEnt[i]
if guid then
self:removeEntity(guid)
end
end
end

function UIPlanent:showStarsEntity(flag)
for i=1,4 do
local guid=self.starEnt[i]
if guid then
local ent=_EntityManager:GetEntity(guid)
local tran=ent:GetActorRootTransform()
tran:SetActive(flag)
end
end
end

function UIPlanent:showStar(flag)
if not api_Available_GetChildLoop3DGround()then return end
self.isShowStar=flag
if flag then
for i=1,4 do
self.loopGround:SetSatelliteVisible(i,true)
end
else
for i=1,4 do
self.loopGround:SetSatelliteVisible(i,false)
end
end
end

function UIPlanent:showStarAnim(flag)
self.isShowStar=flag
if flag then
for i=1,4 do

if self.starEnt[i]then
local ent=_EntityManager:GetEntity(self.starEnt[i])
if ent then
local tran=ent.transform
if self.starEntShowTreener[i]then self.starEntShowTreener[i]:Complete()end
self.starEntShowTreener[i]=Lua.DOTweenProxyExtensions.DOScale(tran,1,0.3)
end
end
end
else
for i=1,4 do

if self.starEnt[i]then
local ent=_EntityManager:GetEntity(self.starEnt[i])
if ent then
local tran=ent.transform
tran.localScale=Vector3.New(1,1,1)
if self.starEntShowTreener[i]then self.starEntShowTreener[i]:Complete()end
self.starEntShowTreener[i]=Lua.DOTweenProxyExtensions.DOScale(tran,0,0.3)
end
end
end
end
end

function UIPlanent:showStarHalo(flag)
if flag then
for i,v in pairs(self.xh772100)do
if self.starSlotShow[i]~=0 then
v:setAnimatorInteger('nStateID',0,true)
self.starSlotShow[i]=0
end
end
else
for i,v in pairs(self.xh772100)do
if self.starSlotShow[i]~=1 then
v:setAnimatorInteger('nStateID',1,true)
self.starSlotShow[i]=1
end
end
end
end


function UIPlanent:showHaloIndex(index)
if index==0 then
self:showStar(true)
else
for i=1,4 do
if i==index then

if self.starSlotShow[i]~=0 then
self.xh772100[i]:setAnimatorInteger('nStateID',0,true)
self.starSlotShow[i]=0
end
if self.starEnt[i]then
local ent=_EntityManager:GetEntity(self.starEnt[i])
if ent then
local tran=ent.transform
if self.starEntShowTreener[i]then self.starEntShowTreener[i]:Complete()end
self.starEntShowTreener[i]=Lua.DOTweenProxyExtensions.DOScale(tran,1,0.1)
end
end
else

if self.starSlotShow[i]~=1 then
self.xh772100[i]:setAnimatorInteger('nStateID',1,true)
self.starSlotShow[i]=1
end
if self.starEnt[i]then
local ent=_EntityManager:GetEntity(self.starEnt[i])
if ent then
local tran=ent.transform
if self.starEntShowTreener[i]then self.starEntShowTreener[i]:Complete()end
self.starEntShowTreener[i]=Lua.DOTweenProxyExtensions.DOScale(tran,0,0.1)
end
end
end
end
end
end

function UIPlanent:playHaloUpEffect(id)
self.backEffect[id]:setChildShowEffect(20266,true)
end

function UIPlanent:playHaloBreakEffect()
self.backEffectCenter:setChildShowEffect(20267,true)
end



function UIPlanent:onHide()
self:enableTouch(false)
UnityEngine.Shader.DisableKeyword("_ENABLE_CURVED_WORLD_LITTLEPLANET_Y")
end

function UIPlanent:addOrbit(index,modelId,radius,rotSpeed,startAngle,selfRotSpeed,onLoadCall)
if not api_Available_GetChildLoop3DGround()then return end
if self.isShowStar then
self.loopGround:SetSatelliteVisible(index,true)
end
local guid=self.loopGround:AddOrbit(index,modelId,radius,rotSpeed,startAngle,selfRotSpeed,onLoadCall)
local ent=_EntityManager:GetEntity(guid)
if ent then
local tran=ent.transform
tran.localPosition=Vector3.New(15,-radius,0)

end
return guid
end

function UIPlanent:setSatelliteVisible(index,visible)
if not api_Available_GetChildLoop3DGround()then return end
self.loopGround:SetSatelliteVisible(index,visible)
end

function UIPlanent:setSatelliteListVisible(visList)
if not api_Available_GetChildLoop3DGround()then return end
for i,v in pairs(visList)do
self.loopGround:SetSatelliteVisible(i,v)
end
end

function UIPlanent:addEntity(bodyID,slots,sortingLayer,size,pos,scale,onLoadFinish)
if not api_Available_GetChildLoop3DGround()then return-1 end
return self.loopGround:AddEntity(bodyID,slots,sortingLayer,size,pos,scale,onLoadFinish)
end

function UIPlanent:addEntity3D(modelID,size,pos,scale,rot,onLoadFinish)
if not api_Available_GetChildLoop3DGround()then return-1 end
return self.loopGround:AddEntity3D(modelID,size,pos,scale,rot,onLoadFinish)
end


function UIPlanent:removeEntity(guid)
if not api_Available_GetChildLoop3DGround()then return end
self.loopGround:RemoveEntity(guid)
end

function UIPlanent:enableTouch(enable)
if not api_Available_GetChildLoop3DGround()or self.loopGround==nil then return end
self.loopGround:EnableTouch(enable)

if api_Available_SetAutoRotate()then
if enable then
self.loopGround:SetAutoRotate(autoSpeed)
else
self.loopGround:SetAutoRotate(Vector3.zero)
end
end
end

function UIPlanent:enableAutoRotate(enable)
if api_Available_SetAutoRotate()then
if enable then
self.loopGround:SetAutoRotate(autoSpeed)
else
self.loopGround:SetAutoRotate(Vector3.zero)
end
end
end

function UIPlanent:moveToPosition(dstPosition,smoothTime,maxSpeed,onFinish)
if not api_Available_GetChildLoop3DGround()or self.loopGround==nil then return end
self.loopGround:MoveToPosition(dstPosition,smoothTime,maxSpeed,onFinish,0.5)
end


function UIPlanent:moveToSlot(idx,onFinish)
if not api_Available_GetChildLoop3DGround()or self.loopGround==nil then return end
local pos=blockPos[idx]
self.loopGround:MoveToPosition(Vector3.New(pos[1],pos[2],pos[3]),0.05,1500,onFinish,0.5)
end

local ZhenWuPos={Vector3.New(283.4424,90,0),Vector3.New(17.43298,74.14798,0),Vector3.New(63.0184,282.7854,0),Vector3.New(339.2092,302.1034,0)}

function UIPlanent:refreshSlot(idx)
local slotZw=LittleWorldModel:getZhenWuIdxSlot(idx)
if slotZw then
local show_model=cfgHelper.get(cfg_smallworldtownconfig_get,slotZw,"show_model")
local pos=Vector3.New(ZhenWuPos[idx].x,ZhenWuPos[idx].y,20.8)
local rot=Vector3.New(show_model[2][1]or 0,0,0)
if self.slotEnt[idx]then
self:removeEntity(self.slotEnt[idx])
self:setTimer(0.02,1,function()
self.slotEnt[idx]=self:addEntity3D(show_model[1],Vector2.New(show_model[3],show_model[3]),pos,Vector3.one,rot,nil)
end)
else
self.slotEnt[idx]=self:addEntity3D(show_model[1],Vector2.New(show_model[3],show_model[3]),pos,Vector3.one,rot,nil)
end

else
if self.slotEnt[idx]then
self:removeEntity(self.slotEnt[idx])
self.slotEnt[idx]=nil
end
end
end

function UIPlanent:resetZuWuPos(guid,idx)
local ent=_EntityManager:GetEntity(guid)
if ent then
local tran=ent.transform
tran.localPosition=ZhenWuPos[idx]
end
end

function UIPlanent:initZwSlot()
for i=1,4 do
self:refreshSlot(i)
end
end


function UIPlanent:setAnimator(id)
self.shou:setAnimatorInteger('nStateID',id,true)
end


function UIPlanent:showBigOrbit(id)
local oribitId=itemsConfig.getConfig(id).star_model
if self.bagOrbit then
local bagOrbit=self.bagOrbit
local ent=_EntityManager:GetEntity(bagOrbit)
if ent then
ent:ChangeBody(oribitId,{},false,1)
end
else
local bagOrbit=self:addEntity3D(oribitId,Vector2.New(1,1),Vector3.zero,Vector3.New(8,8,8),Vector3.zero,nil)
if bagOrbit>0 then
local ent=_EntityManager:GetEntity(bagOrbit)
local tran=ent.transform
tran:SetParent(self.showTrans)
tran.localPosition=Vector3.New(0,-22,7)
tran.localScale=Vector3.New(8,8,8)


local duration=2.5

local actorTran=ent:GetActorRootTransform()
actorTran.localPosition=Vector3.New(0,0,0)
self.bigMove=Lua.DOTweenProxyExtensions.DOLocalMoveZ(actorTran,0.5,duration)
self.bigMove:SetLoops(-1,_LoopType.Yoyo)
actorTran.eulerAngles=Vector3.New(0,0,0)
self.bigRotate=Lua.DOTweenProxyExtensions.DOLocalRotate(actorTran,Vector3.New(0,0,-360),50,DG.Tweening.RotateMode.FastBeyond360)
self.bigRotate:SetLoops(-1,DG.Tweening.LoopType.Incremental)
self.bigRotate:SetEase(DG.Tweening.Ease.Linear)

end
self.bagOrbit=bagOrbit
end

end


function UIPlanent:removeBigOrbit()
if self.bagOrbit then
if self.bigRotate then
self.bigRotate:Kill()
end
if self.bigMove then
self.bigMove:Kill()
end
self:removeEntity(self.bagOrbit)
self.bagOrbit=nil
end
end

function UIPlanent:playOrbitEffect(id,effectId)
if self.starEnt[id]then
local ent=_EntityManager:GetEntity(self.starEnt[id])
if ent then
ent:PlayEffect(effectId,Vector3.zero,true,true)
end
end
end

function UIPlanent:playOrbitLevelEffect(id)
if self.starEnt[id]then
local equip=xingChenBagModel:getEquipDataByPos(id)
if equip then
local lv=xingChenBagModel:getOrbitLevel(id)
local colorId=itemsConfig.getConfig(equip.itemid).star_effect_color
local effect=self:getLevelColorEffect(colorId,lv)
if effect then
local ent=_EntityManager:GetEntity(self.starEnt[id])
if ent then
self:removeOrbitLevelEffect(id)
self.lvEffect[id]=ent:PlayEffect(effect,Vector3.zero,true,true)
end
else
self:removeOrbitLevelEffect(id)
end
end
end
end

function UIPlanent:removeOrbitLevelEffect(id)
if self.lvEffect[id]then
_stopEffect(self.lvEffect[id])
self.lvEffect[id]=nil
end
end


function UIPlanent:getLevelColorEffect(colorId,level)
local star_effect=cfgHelper.get(cfg_starsbasicconfig_get,1,"star_effect")
for i,v in ipairs(star_effect[colorId])do
if level>=v[1]and level<=v[2]then
return v[3]
end
end
end


