worldTripProgress_Base=simple_class()
worldTripProgress_Base.name="worldTripProgress_Base"


function worldTripProgress_Base:__init(trip)
self.trip=trip
self.moves={}
self.objects={}
self.duration=-1
end


function worldTripProgress_Base:start(time)
for index,list in pairs(self.moves)do
list:start(time)
end
end


function worldTripProgress_Base:quit()
for i,v in pairs(self.objects)do
self:hideDisciple(i)
end
for i,v in pairs(self.moves)do
v:quit()
end
self.objects={}
self.moves={}
end


function worldTripProgress_Base:getDuration()
return self.duration
end


function worldTripProgress_Base:checkOver(fast)
if self.duration>=0 then
local over=fast-self.duration
if over>=0 then
return true,over
else
return false,fast
end
else
return false,fast
end
end


function worldTripProgress_Base:onDiscipleChange()

end

function worldTripProgress_Base:showDisciple(index,needHUD,click,pos)
local discipleGuid=self.trip.disciples[index]
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(discipleGuid)
local bodyCfg=cfgHelper.get1(cfg_dbbodyconfig_get,modelParams.body)
local height=bodyCfg.size and bodyCfg.size[2]or 0
local scale=bodyCfg.worldScales and bodyCfg.worldScales[1]or 0.4

local mSetting=CS.WorldEntitySetting.New(
mathHelper.convertArrayToVector(cfgHelper.get2(cfg_worldglobalconfig_get,"taskDiscipleLOD","value")),
height*scale,nil,
modelParams.body,modelParams.componets,
"Entity",scale,Vector3.zero)

if api_Available_SetWorldEntityUseSmall()then
mSetting:SetWorldEntityUseSmall(false)
end
local mHUDSetting=nil
if needHUD then
local hudData=cfgHelper.get2(cfg_worldglobalconfig_get,"taskDiscipleHUD","value")
mHUDSetting=worldModel:getHUDSetting(hudData[1])
end
local unitKey=worldTaskModel:convertTaskUnitKey(self.trip.id,index)
local luaData={worldModel.UNITTYPE.MISSION,self.trip.id,index}
worldController:pushUnit(unitKey,pos or Vector3.zero,luaData,mSetting,mHUDSetting,nil,click or false)
self.objects[index]=worldController:getUnit(unitKey)
end

function worldTripProgress_Base:hideDisciple(index)

local obj=self.objects[index]
if obj then
local unitKey=obj.Key
worldController:popUnit(unitKey)
self.objects[index]=nil
end
end

function worldTripProgress_Base:refreshDisclple(index)
local lod=mathHelper.convertArrayToVector(cfgHelper.get2(cfg_worldglobalconfig_get,"taskDiscipleLOD","value"))
local discipleParam=UIDiscipleModel:getDiscipleOutsideModelInfo(self.trip.disciples[index])
local bodyCfg=cfgHelper.get1(cfg_dbbodyconfig_get,discipleParam.body)
local height=bodyCfg.size and bodyCfg.size[2]or 0
local scale=bodyCfg.worldScales and bodyCfg.worldScales[1]or 0.4
local mSetting=CS.WorldEntitySetting.New(lod,height*scale,nil,discipleParam.body,discipleParam.componets,"Entity",scale,Vector3.zero)
if api_Available_SetWorldEntityUseSmall()then
mSetting:SetWorldEntityUseSmall(false)
end
worldController:changeUnitModel(self.objects[index].Key,mSetting)
end