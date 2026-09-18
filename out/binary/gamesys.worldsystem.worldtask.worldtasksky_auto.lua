









worldTaskSky_Auto=simple_class(worldTaskSky)

function worldTaskSky_Auto:__init(data)
worldTaskSky.__init(self,data)
end

function worldTaskSky_Auto:start(serverTime)
worldTaskSky.start(self,serverTime)

if not self.corners then return end
local flyHeight=cfgHelper.get2(cfg_worldconfig_get,worldModel.world,"maxAltitude")
local horizontalLine=cfgHelper.get2(cfg_worldconfig_get,worldModel.world,"horizontalLine")
local cloudHigher=cfgHelper.get2(cfg_worldconfig_get,worldModel.world,"cloudHigher")
local ways={CS.WorldFlyWay.New(self.corners,self.speed,flyHeight,horizontalLine,cloudHigher,Vector3Int(0,11,0))}
local path={CS.WorldMovePath.New(ways,CS.WorldLoopType.Yoyo,2)}

self.move=CS.WorldOffsetTeam.New(self.key,path,self.objects,self.sky_offset[self:getShowDiscipleCnt()])
self.move.onComplete=function()
self:onComplete()
end
local now=timeHelper.getServerShortTime()
self.endTime=self.endTime>0 and self.endTime or(now+self.move.Duration)
local fast=Mathf.Clamp(self.move.Duration-(self.endTime-now),0,self.move.Duration)

self.move:Goto(fast)
worldController:pushMove(self.move)
end

function worldTaskSky_Auto:onComplete()
self.move:SetRunning(false)
end
