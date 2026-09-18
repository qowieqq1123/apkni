worldTripProgress_FlyTour=simple_class(worldTripProgress_Base)
worldTripProgress_FlyTour.name="worldTripProgress_FlyTour"







function worldTripProgress_FlyTour:start(time)
if#self.trip.disciples<=0 then return end

local worldCfg=cfgHelper.get1(cfg_worldconfig_get,self.trip.world)
self.flyHeight=worldCfg.maxAltitude
self.horizontalLine=worldCfg.horizontalLine
self.cloudHigher=worldCfg.cloudHigher

local pos=worldPositionConfig:getPosition(self.trip.world,{self.trip.destination.x,self.trip.destination.y})
self:showDisciple(1,true,false,pos)
self:showTarget()


local id=self.trip.target_id
local firstJob=UIDiscipleModel:getDiscipleJob(self.trip.disciples[1])
local moveList=worldTripMoveList_FlyTour.New(id,firstJob,self.objects)

local obj=self.objects[1]
local discipleGuid=self.trip.disciples[1]
local mount=worldDispatchFactory:getFlyMount(discipleGuid)
local flyAnim=worldDispatchFactory:getFlyAnim(discipleGuid)
local flyMountOffset=worldDispatchFactory:getFlyMountOffset(discipleGuid)
local mountSlot=mountHelper.getMountNode(discipleGuid)

local move0=worldTripMove_JumpShow.New(obj,nil,self.flyHeight,false,true,true,mount,flyAnim,flyMountOffset,mountSlot)
moveList:setMove(worldTripMoveList_FlyTour.MoveType.Jump,move0)

local move1=worldTripMove_FlyMove.New(obj,{},self.trip.speed,0,self.flyHeight,self.horizontalLine,self.cloudHigher,mount,flyAnim,flyMountOffset,mountSlot)
moveList:setMove(worldTripMoveList_FlyTour.MoveType.Fly,move1)

local move2=worldTripMove_AnimationSitu.New(obj,nil,0.2,eAnimationID.stand)
moveList:setMove(worldTripMoveList_FlyTour.MoveType.Wait,move2)

local move3=worldTripMove_AnimationSitu.New(obj,Vector3.zero,0,0)
moveList:setMove(worldTripMoveList_FlyTour.MoveType.Animation,move3)

local move4=worldTripMove_EffectShow.New(obj,Vector3.zero,0,0)
moveList:setMove(worldTripMoveList_FlyTour.MoveType.Effect,move4)

self.moves[1]=moveList

moveList.trigger=function(o,n)
local MoveType=worldTripMoveList_FlyTour.MoveType
if(o<=MoveType.Animation or o>=MoveType.Jump)and n>MoveType.Animation and n<MoveType.Jump then
worldHUDModel:UpdateHUDByKey(self.objects[1].Key)
end
if o>MoveType.Animation and o<MoveType.Jump and(n<=MoveType.Animation or n>=MoveType.Jump)then
worldHUDModel:UpdateHUDByKey(self.objects[1].Key)
end
end

moveList:start(time)
end

function worldTripProgress_FlyTour:showTarget()
local id=tonumber(tostring(self.trip.target_id))
local subid=chuanSongZhenModel:findDiscipleSlot(self.trip.target_id,self.trip.disciples[1])
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.TOURPOINT,id,subid})
local modelSettings=nil
local hudSettings=worldModel:getHUDSetting(worldDispatchFactory.tourHUD)
local luaData={eWorldUnitTpye.TOURPOINT,id}
worldController:pushUnit(unitKey,Vector3.zero,luaData,modelSettings,hudSettings)
self.objects[0]=worldController:getUnit(unitKey)
end

function worldTripProgress_FlyTour:hideTarget()
local obj=self.objects[0]
if obj then
worldController:popUnit(obj.Key)
end
end