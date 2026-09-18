worldTripProgress_RunTour=simple_class(worldTripProgress_Base)
worldTripProgress_RunTour.name="worldTripProgress_RunTour"







function worldTripProgress_RunTour:start(time)
if#self.trip.disciples<=0 then return end

local pos=worldPositionConfig:getPosition(self.trip.world,{self.trip.destination.x,self.trip.destination.y})
self:showDisciple(1,true,false,pos)
self:showTarget()


local id=self.trip.target_id
local firstJob=UIDiscipleModel:getDiscipleJob(self.trip.disciples[1])
local moveList=worldTripMoveList_RunTour.New(id,firstJob,self.objects)

local obj=self.objects[1]
local move0=worldTripMove_NavMove.New(obj,{},self.trip.speed,0)
moveList:setMove(worldTripMoveList_RunTour.MoveType.Move,move0)

local move1=worldTripMove_AnimationSitu.New(obj,Vector3.zero,0,0)
moveList:setMove(worldTripMoveList_RunTour.MoveType.Animation,move1)

local move2=worldTripMove_EffectShow.New(obj,Vector3.zero,0,0)
moveList:setMove(worldTripMoveList_RunTour.MoveType.Effect,move2)

self.moves[1]=moveList

moveList.trigger=function(o,n)
local MoveType=worldTripMoveList_RunTour.MoveType
if(o<=MoveType.Animation or o>=MoveType.Move)and n>MoveType.Animation and n<MoveType.Move then
worldHUDModel:UpdateHUDByKey(self.objects[1].Key)
end
if o>MoveType.Animation and o<MoveType.Move and(n<=MoveType.Animation or n>=MoveType.Move)then
worldHUDModel:UpdateHUDByKey(self.objects[1].Key)
end
end

moveList:start(time)
end

function worldTripProgress_RunTour:showTarget()
local id=tonumber(tostring(self.trip.target_id))
local subid=chuanSongZhenModel:findDiscipleSlot(self.trip.target_id,self.trip.disciples[1])
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.TOURPOINT,id,subid})
local modelSettings=nil
local hudSettings=worldModel:getHUDSetting(worldDispatchFactory.tourHUD)
local luaData={eWorldUnitTpye.TOURPOINT,id}
worldController:pushUnit(unitKey,Vector3.zero,luaData,modelSettings,hudSettings)
self.objects[0]=worldController:getUnit(unitKey)
end

function worldTripProgress_RunTour:hideTarget()
local obj=self.objects[0]
if obj then
worldController:popUnit(obj.Key)
end
end