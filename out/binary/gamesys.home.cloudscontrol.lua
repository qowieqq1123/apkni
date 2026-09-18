
cloudsControl=gameState.addListener({})

local _startPos=Vector3.New(0,0,0)
local _endPos=Vector3.New(0,0,0)


local _Ease=DG.Tweening.Ease

function cloudsControl:onAppStart()
local cfgs=cfg_cloudconfig()
self.cloudNum=#cfgs
local def=cfgs.const_def
self.minCreateTime=def.minCreateTime
self.maxCreateTime=def.maxCreateTime
self.initial=def.initial
self.fadeTime=def.fadeTime
self.minFlyTime=def.minFlyTime
self.maxFlyTime=def.maxFlyTime
self.minAlpha=def.minAlpha
self.maxAlpha=def.maxAlpha
end

function cloudsControl:getNextCreateTime()
return self.minCreateTime+(self.maxCreateTime-self.minCreateTime)*math.random()
end

function cloudsControl:onEnterState(...)
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
end

function cloudsControl:onLeaveState(...)
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
end

function cloudsControl.on_home_event(etype)
if etype==homeEvent.eEnterHome then
cloudsControl:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
cloudsControl:onLeaveHome()
end
end

function cloudsControl:onEnterHome()
local sfId=zongmenModel:getMountainId()
local cfg=cfgHelper.get1(cfg_monijysfconfig_get,sfId)
local border=cfg.border
self.cloudBorder={left=border[1]-10,top=border[2],right=border[3]+10,bottom=border[4]}
self.cloudBorder.width=self.cloudBorder.right-self.cloudBorder.left
self.cloudBorder.height=self.cloudBorder.top-self.cloudBorder.bottom

self.countdown=self:getNextCreateTime()
self.count=0
self.clouds={}

for i=1,self.initial do
self:createACloud(math.random(1,self.cloudNum))
end

timeEventController.addNormalTimerHandler(1,'cloudsControl',self)
end

function cloudsControl:onLeaveHome()
timeEventController.removeNormalTimerHandler(1,'cloudsControl')

if self.clouds then
for k,v in pairs(self.clouds)do
v:Kill()
_MapManager.RemoveTilemapObject(k)
end
end

self.clouds=nil
end

function cloudsControl:randowmAPos()
local x=self.cloudBorder.left+self.cloudBorder.width*math.random()
local y=self.cloudBorder.bottom+self.cloudBorder.height*math.random()
return Vector3.New(x,y,0)
end







function cloudsControl:randomAFlyTime()
return math.random(self.minFlyTime,self.maxFlyTime)
end

function cloudsControl:randomAAlphaValue()
return self.minAlpha+(self.maxAlpha-self.minAlpha)*math.random()
end

function cloudsControl:onNormalUpdate(delay)
self.count=self.count+1
if self.count>=self.countdown then
self:createACloud(math.random(1,self.cloudNum))
self.countdown=self:getNextCreateTime()
self.count=0
end
end

function cloudsControl:createACloud(ctype)
local cfgs=cfgHelper.get1(cfg_cloudconfig_get,ctype)
local cfg=cfgs[math.random(1,#cfgs)]
if cfg.path then
local pcfg=cfgHelper.get1(cfg_flypathconfig_get,cfg.path)
local path=pcfg.paths[math.random(1,#pcfg.paths)]

_startPos.x=path[1]
_startPos.y=path[2]
_startPos.z=0

_endPos.x=path[3]
_endPos.y=path[4]
_endPos.z=0
self:createACloudEx(ctype,cfg.type_id,_startPos,_endPos)
else

local x=self.cloudBorder.left+self.cloudBorder.width*math.random()*0.5
local y=self.cloudBorder.bottom+self.cloudBorder.height*math.random()
_startPos.x=x
_startPos.y=y
_startPos.z=0
self:createACloudEx(ctype,cfg.type_id,_startPos)
end
end

function cloudsControl:createACloudEx(ctype,type_id,startPos,endPos)
local cfg=cfgHelper.get2(cfg_cloudconfig_get,ctype,type_id)
local guid=_MapManager.CreateTilemapObject(objectType.eDefault,cfg.model,nil,SortingLayers.ITSky1,1,1)
_MapManager.RunAnimator(guid,eAnimationID.stand)
local tran=_MapManager.GetTilemapObjectTransform(guid)

local speed=cfg.minSpeed+(cfg.maxSpeed-cfg.minSpeed)*math.random()
local flyTime=self:randomAFlyTime()
local fadeTime=self.fadeTime
local spos=startPos
local epos=endPos
if not epos then
epos=Vector3.New(startPos.x+speed*flyTime,startPos.y,0)
end
tran.position=spos

local tweener=_DOTweenProxy.DOMove(tran,epos,flyTime)
tweener:SetEase(_Ease.Linear)
tweener:OnComplete(function()
self.clouds[guid]=nil
_MapManager.RemoveTilemapObject(guid)
end)
_MapManager.SetFadeToColor(guid,Color.New(1,1,1,0),-1,nil)
_MapManager.SetFadeToColor(guid,Color.New(1,1,1,self:randomAAlphaValue()),fadeTime,function()
_MapManager.SetFadeToColor(guid,Color.New(1,1,1,0),fadeTime,nil,flyTime-fadeTime*2)
end)

self.clouds[guid]=tweener
end