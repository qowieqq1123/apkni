









worldTaskGround_Auto=simple_class(worldTaskGround)

function worldTaskGround_Auto:__init(data)
worldTaskGround.__init(self,data)
end

function worldTaskGround_Auto:start(serverTime)

worldTaskGround.start(self,serverTime)

if not self.corners then return end

local ways={CS.WorldNavWay.New(self.corners,self.speed,Vector3Int(0,self.runAnimation,0))}
local path={CS.WorldMovePath.New(ways,CS.WorldLoopType.Yoyo,2)}

self.move=CS.WorldLineTeam.New(self.key,path,self.objects,self.ground_delay/self.speed)
self.move.onComplete=function()
self:onComplete()
end
local now=timeHelper.getServerShortTime()
self.endTime=self.endTime>0 and self.endTime or(now+self.move.Duration)
local fast=Mathf.Clamp(self.move.Duration-(self.endTime-now),0,self.move.Duration)

self.move:Goto(fast)
worldController:pushMove(self.move)
end

function worldTaskGround_Auto:onComplete()
self.move:SetRunning(false)
end
