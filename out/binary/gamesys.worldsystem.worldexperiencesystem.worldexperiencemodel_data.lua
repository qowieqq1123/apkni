
local _points={}

local _state=nil

local _block=nil

local _world=nil

local _follower={}

local _target=nil

local _valid=false

local _count=0



function worldExperienceModel:chekcValid()
return _valid
end




function worldExperienceModel:setData(list,state)
self:clearData()
_points=list or{}
_state=state

local cnt=#_points

for i=1,cnt do
if i<cnt then

local cfg=cfgHelper.get1(cfg_experienceconfig_get,_points[i])
self:handleFollower(cfg.followInfo)
end
end



local p=worldExperienceModel:getCurrentPoint()
if p then
local cfg=cfgHelper.get1(cfg_experienceconfig_get,p)
_world=cfg.worldid
_block=cfg.blockid
_count=self:calculateCount(_world,_block)
_valid=true
return
end

local cfg=cfg_worldblockconfig()
for w,wCfg in ipairs(cfg)do
for b,bCfg in ipairs(wCfg)do
if worldBlockModel:checkBlockState(w,b,eWorldBlockState.UNLOCK)then
_world=w
_block=b
table.insert(_points,bCfg.first)
_state=eExperiencePonitState.PreStory
_count=self:calculateCount(_world,_block)
_valid=true
return
end
end
end
end



function worldExperienceModel:getCurrentPoint()
local cnt=#_points
if cnt>0 then
return _points[cnt]
end
end



function worldExperienceModel:getStandPoint()
local cnt=#_points
local index=nil
if _state==eExperiencePonitState.Init then
index=cnt-1
else
index=cnt
end
return _points[index]
end



function worldExperienceModel:getAllPoint()
return _points
end



function worldExperienceModel:getCurrentState()
return _state
end

function worldExperienceModel:setState(state)
_state=state
end

function worldExperienceModel:checkState(state)
return _state==state
end


function worldExperienceModel:clearData()
_valid=false
_points={}
_state=nil
_block=nil
_world=nil
_follower={}
_target=nil
_count=0
end


function worldExperienceModel:setTarget(state)
_target=state
end


function worldExperienceModel:getTarget()
return _target
end




function worldExperienceModel:addPointState(point,state)
local p=self:getCurrentPoint()
if p==nil or p~=point then
table.insert(_points,point)
end
_state=state
end



function worldExperienceModel:getCurrentBlock()
return _block
end



function worldExperienceModel:getCurrentWorld()
return _world
end

function worldExperienceModel:checkCurrent(world,block)
return _world==world and _block==block
end



function worldExperienceModel:getAllFollower()
return _follower
end




function worldExperienceModel:getFollower(index)
return _follower[index]
end




function worldExperienceModel:handleFollower(handleList)

if handleList then
local index=nil
for i,v in ipairs(handleList)do
if v[1]==1 then
table.insert(_follower,v[2])
local temp=#_follower
index=index and math.min(index,temp)or temp

elseif v[1]==2 then
for r=#_follower,1,-1 do
if v[2]==_follower[r]then
table.remove(_follower,r)
index=index and math.min(index,r)or r

end
end
end

end
return index
end
end

function worldExperienceModel:calculateCount(world,block)
local cfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
local experienceCfg=cfgHelper.get1(cfg_experienceconfig_get,cfg.first)
local count=0
while(experienceCfg~=nil)do
count=count+1
local temp=experienceCfg.next and experienceCfg.next[1]or nil
if temp==nil then
experienceCfg=nil
else
experienceCfg=cfgHelper.get1(cfg_experienceconfig_get,experienceCfg.next[1])
end
end
return count
end

function worldExperienceModel:getCount()
return _count
end

function worldExperienceModel:getProgress()
local cnt=#_points
if not self:checkState(eExperiencePonitState.Finish)then
cnt=cnt-1
end
return math.max(cnt,0)
end
















function worldExperienceModel:getTaskKey()
if _world and _block then
local targetKey=worldExperienceModel:convertTaskTargetKey(_world,_block)
return worldTaskModel:findTaskKey_ByTargetProgress(targetKey,eWorldTripProgress.Work)
end
end

function worldExperienceModel:getTask()
local taskKey=self:getTaskKey()
if taskKey then
return worldTaskModel:getTask(taskKey)
end
end