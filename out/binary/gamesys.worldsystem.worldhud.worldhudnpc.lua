









worldHUDNPC=simple_class(worldHUDBase)
worldHUDNPC.name="worldHUDNPC"


function worldHUDNPC:onCreate()
local npcid=self.data[2]
local imagecfg=npcModel:getNPCImageCfg(npcid)

self.cmp:SetChildText(0,imagecfg.name)
self.cmp:SetChildButtonClick(1,function()
npcController:onClickNPC(npcid)
end)

local entity=worldController:getUnitModelEntity(self.key)
local camera=worldController:getCameraTransform()
local modelSetting=worldController:getUnitModelSetting(self.key)
local flipX=worldController:getUnitModelFlip(self.key)
if entity and camera and modelSetting.body then
local flipX=worldController:getUnitModelFlip(self.key)
local dbCfg=cfgHelper.get1(cfg_dbbodyconfig_get,modelSetting.body)
local lOffset=dbCfg.headPos and Vector3.New(dbCfg.headPos[1],dbCfg.headPos[2])or Vector3.zero
lOffset=lOffset*modelSetting.scale
lOffset.x=lOffset.x*(flipX and-1 or 1)
self.cmp:SetChildFollowPointUI(2,camera.gameObject,7,entity.transform,Vector3.zero,lOffset)
end

self:randomTalk()

worldHUDBase.onCreate(self)
end

function worldHUDNPC:onUpdate()

end

function worldHUDNPC:randomTalk()
self:clearRandomTalk()
local time=math.random(8,12)
self.randomTimer=timer.new()
self.randomTimer:start(time,function()
self:clearRandomTalk()
local r=math.random(0,1)
if r==1 then
local npcid=self.data[2]
local str=npcModel:getNPCStandTalk(npcid)
self:showTalk(str,3,function()
self:randomTalk()
end)
else
self:randomTalk()
end
end,1)
end

function worldHUDNPC:clearRandomTalk()
if self.randomTimer then
self.randomTimer:cancel()
self.randomTimer=nil
end
end

function worldHUDNPC:showTalk(str,cd,callback)
local flipX=worldController:getUnitModelFlip(self.key)
if flipX then
self.cmp:SetChildText(6,str)
self.cmp:SetChildActive(5,true)
else
self.cmp:SetChildText(4,str)
self.cmp:SetChildActive(3,true)
end
if self.talkTimer then
self.talkTimer:cancel()
self.talkTimer=nil
end
if cd then
self.talkTimer=timer.new()
self.talkTimer:start(cd,function()
self:hideTalk()
if callback then
callback()
end
end,1)
end
end

function worldHUDNPC:hideTalk()
self.cmp:SetChildActive(3,false)
self.cmp:SetChildActive(5,false)
if self.talkTimer then
self.talkTimer:cancel()
self.talkTimer=nil
end
end

function worldHUDNPC:onDestory()
self:hideTalk()
self:clearRandomTalk()
end