worldTripProgress_AttackSystemZongMen=simple_class(worldTripProgress_Base)
worldTripProgress_AttackSystemZongMen.name="worldTripProgress_AttackSystemZongMen"

local bodyId=4609
local hudId=34
local effectId=worldDispatchFactory.fightEffect
local effectBody=4608
local interval=6

function worldTripProgress_AttackSystemZongMen:__init(trip)
worldTripProgress_Base.__init(self,trip)
self.totalDuration=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"teamMoveTime",1)
self.prepareDuration=5
end

function worldTripProgress_AttackSystemZongMen:start(time)
self.flipX=self.trip.corners[#self.trip.corners].x<self.trip.corners[1].x
self.flyHeight=cfgHelper.get2(cfg_worldconfig_get,worldModel.world,"maxAltitude")
self.horizontalLine=cfgHelper.get2(cfg_worldconfig_get,worldModel.world,"horizontalLine")
self.cloudHigher=cfgHelper.get2(cfg_worldconfig_get,worldModel.world,"cloudHigher")

local sPos=self.trip.corners[1]
local ePos=self.trip.corners[#self.trip.corners]

self:showObject(0,Vector3.zero,bodyId,hudId)
self:showObject(-1,ePos+Vector3.up*3,effectBody)
self:checkEffectShow()

local startPos=sPos+Vector3.up*self.flyHeight
local endPos=ePos+Vector3.up*self.flyHeight+Vector3.left*(self.flipX and-interval or interval)
local corners={startPos,endPos}
local obj=self.objects[0]
local distance=worldDispatchFactory:getDistance(eWorldTripType.Fly,corners)
local moveDuration=self.totalDuration-self.prepareDuration
local moveList=worldTripMoveList.New()
moveList:addMove(worldTripMove_JumpShow.New(obj,sPos,self.flyHeight,self.flipX,true,true,-1,0,nil,nil,self.prepareDuration))
moveList:addMove(worldTripMove_FlyMove.New(obj,corners,distance/moveDuration,moveDuration,self.flyHeight,self.horizontalLine,self.cloudHigher,-1,0))
moveList:addTrigger(function(o,n)
if n>2 then
self.objects[0]:SetPosition(endPos)
self.objects[0]:SetFlipX(self.flipX)
self:checkEffectShow()
end
end)
self.moves[0]=moveList
worldTripProgress_Base.start(self,time)
end

function worldTripProgress_AttackSystemZongMen:showObject(index,position,bodyId,hudId)
local unitKey=worldTaskModel:convertTaskUnitKey(self.trip.id,index)
local bodyCfg=cfgHelper.get1(cfg_dbbodyconfig_get,bodyId)
local height=bodyCfg.size and bodyCfg.size[2]or 0
local scale=bodyCfg.worldScales and bodyCfg.worldScales[1]or 0.4
local modelSettings=CS.WorldEntitySetting.New(
mathHelper.convertArrayToVector(cfgHelper.get2(cfg_worldglobalconfig_get,"taskDiscipleLOD","value")),
height*scale,nil,
bodyId,{},
"Entity",scale,Vector3.zero
)
local hudSettings=hudId and worldModel:getHUDSetting(hudId)or nil
local luaData={worldModel.UNITTYPE.MISSION,self.trip.id,index}
worldController:pushUnit(unitKey,position,luaData,modelSettings,hudSettings)
self.objects[index]=worldController:getUnit(unitKey)
end

function worldTripProgress_AttackSystemZongMen:checkEffectShow()
local check=systemZongMenModel:checkWaitNotifyResult(self.trip.target_guid)
local obj=self.objects[-1]
if obj then
worldController:showUnitModel(obj.Key,check)
end
end