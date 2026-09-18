
surfaceControl=gameState.addListener({})



surfacePartIndex=
{
diaoxiang=0,
shiqiao1=1,
decorationLeft=5,
areaLeft=6,
oldFeiShenTaiLeft=7,
newFeiShenTaiLeft=8,
}

function surfaceControl:onAppStart()
end

function surfaceControl:onEnterState(...)
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
end

function surfaceControl:onLeaveState(...)
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
end

function surfaceControl.on_home_event(etype)
if etype==homeEvent.eEnterHome then
surfaceControl:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
surfaceControl:onLeaveHome()
end
end

function surfaceControl:onEnterHome()

end

function surfaceControl:onLeaveHome()
self.showFeiShengTai=false
end

function surfaceControl:hideScenery()

end

function surfaceControl:showScenery()
local level=zongmenModel:getLevel()
local cfgs=cfg_zongmensceneryconfig()
for k,v in pairs(cfgs)do
if level>=v.level then
for ii,vv in ipairs(v.scenery)do
self:setSurfacePartActive(vv,mapIdType.zhufeng,true)
end
end
end
end

function surfaceControl:setSurfacePartActive(index,map,isActive)
_MapManager.SetSurfacePartActive(index,map,isActive)
end

function surfaceControl:setAnimatorInteger(index,map,name,value)
_MapManager.SetAnimatorInteger(index,map,name,value)
end

function surfaceControl:setAreaObstacleActive(areaId,isActive)




end

function surfaceControl:checkFeiShengTai(bdData)







end