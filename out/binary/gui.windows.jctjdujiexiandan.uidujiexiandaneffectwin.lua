







def_class("UIDuJieXianDanEffectWin",UIWindowBase)









function UIDuJieXianDanEffectWin:bindComponents()

self.building=UIObject.get(self,0)
self.effect=UIObject.get(self,1)
self.effect2=UIObject.get(self,2)
self.effect3=UIObject.get(self,3)
self.model=UIObject.get(self,4)
self.pos0=UIObject.get(self,5)
self.root=UIObject.get(self,6)



end


function UIDuJieXianDanEffectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.building);self.building=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.effect3);self.effect3=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.pos0);self.pos0=nil;
_UIObject_release(self.root);self.root=nil;
end


















local effectId={20379,20380,20381}

function UIDuJieXianDanEffectWin:onLoaded(...)
self:bindComponents()
end


function UIDuJieXianDanEffectWin:__delete()
self:unbindComponents()
end




function UIDuJieXianDanEffectWin:onShow(argtable,afterOnloaded)
local delay=argtable and argtable[1]or nil

local jdId=jctjDuJieXianDanModel:getLianZhiJieDuan()
local config=cfgHelper.get(cfg_dujiexiandanniliandanwenconfig_get,jdId)

local lightningColor=config.lightningColor or 1
local effect=effectId[lightningColor]

self.effect:setChildShowEffect(effect,true)

if delay then
self:delayDo(delay,function()
self:closeSelf()
end)
end

local bt=argtable and argtable.bt or nil
if bt then
local oriPos=bt:getSharedVar("bdpos")
local entPos=bt:getSharedVar("entitypos")

oriPos=Vector3(oriPos[1],oriPos[2],0)

local lianZhiEnt=jctjDuJieXianDanModel:getLianZhiBuild()
local bdData=zongmenModel:getBuildingData(lianZhiEnt)

local mdata=isometricMapSystem:getModelByData(bdData)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,5)
local bx=cfg.buid_size[1]
local by=cfg.buid_size[2]
local offset=isometricMapSystem:countOffset(bx,by)

local screenPos={0,-180}

self.building:setChildUIModelShowTarget(mdata.model,mdata.scale*0.7,nil,0,false,false,0,nil)
self.building:setChildAnchoredPos(screenPos[1],screenPos[2])
self:delayDo(2.5,function()
self.effect3:setChildShowEffect(10105,true)
self.winlua:SetChildUIModelShowFadeToColor(self.building:getID(),Color.New(0.65,0.65,0.65,1),1,0,nil)
end)



if entPos then

local danling=jctjDuJieXianDanModel:hasEntityConfig()
local cfg=cfgHelper.get1(cfg_djxddanlingconfig_get,danling)
local model=cfg.model[1]



self.entPos=entPos

local vecN=Vector3.Normalize(entPos-oriPos)

local qua=Quaternion.FromToRotation(Vector3.forward,vecN)

local euler2=qua.eulerAngles



local VecN3=(Quaternion.Euler(euler2.x,euler2.y,euler2.z)*Vector3.forward)

self:delayDo(4,function()
self.model:setChildUIModelShowTarget(model,cfg.model[3],{},0,false,false,0)
self.effect2:setChildShowEffect(20391,true)
local pos0=self.pos0:getChildPosition()
self.model:setChildPosition(pos0)


local effectPos=self.model:getChildPosition()

local x=VecN3.x>0 and 1 or-1
local y=VecN3.y>0 and 1 or-1

local pow=y>0 and 1 or-1


local speed=10

local dur0=Vector3.Distance(effectPos,pos0)/speed










local radius=4

local points={pos0}





for i=1,3 do
local a=i*Mathf.PI*2/4
table.insert(points,Vector3(pos0.x+x*(Mathf.Cos(a)*radius),pos0.y+y*Mathf.Sin(a)*radius,pos0.z))
end


local tar3=pos0+Vector3(vecN.x*20,vecN.y*20,0)
table.insert(points,tar3)



local duration=radius*4/speed

local trans=self.model:getTransform()
self.dropTweener=Lua.DOTweenProxyExtensions.DoPath(trans,
points,duration,DG.Tweening.PathType.CatmullRom,DG.Tweening.PathMode.Full3D)
self.dropTweener:SetEase(DG.Tweening.Ease.InOutSine)
end)

end
end
end

function UIDuJieXianDanEffectWin:getDirectionPosition(origin,angle,distance,clamp)
local angleRadius=angle*Mathf.Deg2Rad
local deltaX=distance*Mathf.Cos(angleRadius)
local deltaZ=distance*Mathf.Sin(angleRadius)
local posX=origin.x+deltaX
local posZ=origin.z+deltaZ
if clamp~=false then
posX,posZ=airMapSystem:clamp(posX,posZ)
end
return Vector3.New(posX,origin.y,posZ)
end

function UIDuJieXianDanEffectWin:moveToTarget()
if self.dropTweener then
self.dropTweener:Kill()

end
self.building:setActive(false)

self.winid:SetChildDOLocalJump(self.model:getID(),Vector3(0,0,0),-4,1,1,nil)

end



function UIDuJieXianDanEffectWin:onHide()

end



