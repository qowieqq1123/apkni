local rewards={}






function worldExperienceModel:getAreaProgress(area,filterblock)
local areaCfg=cfgHelper.get1(cfg_worldareaconfig_get,area)
local sum=0
local cur=0
local next=0
for i,v in ipairs(areaCfg.blocks)do
sum=sum+(areaCfg.weight and areaCfg.weight[i]or 1)
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,areaCfg.world,v)
if v==filterblock then
next=areaCfg.weight and areaCfg.weight[i]or 1
elseif worldBlockModel:checkBlockState(areaCfg.world,v,eWorldBlockState.OPEN)then
cur=cur+(areaCfg.weight and areaCfg.weight[i]or 1)
end
end
if sum==0 then
return 100,100
else
return math.floor(cur/sum*100),math.floor((cur+next)/sum*100)
end
end

function worldExperienceModel:checkAreaReddot(world)
local areaCfg=cfg_worldareaconfig()
for i,v in ipairs(areaCfg)do
if v.world==world then
if not self:getReward(i)and self:getAreaProgress(i)>=100 then
return true
end
end
end
return false
end

function worldExperienceModel:checkAllWorldProgress()
local areaCfg=cfg_worldareaconfig()
for i,v in ipairs(areaCfg)do
local progress=self:getAreaProgress(i)

if not self:getReward(i)and progress>=100 then
return true
end
end
return false
end




function worldExperienceModel:getWorldProgress(world)
local sum=0
local cur=0
for i,v in pairs(cfg_worldareaconfig())do
if v.world==world then
sum=sum+100
cur=cur+self:getAreaProgress(i)
end
end
return sum==0 and 100 or math.floor(cur/sum*100)
end

function worldExperienceModel:getCompleteWinArgs(world,block,callback)
local area=worldBlockModel:findBlockArea(world,block)
local areaCfg=cfgHelper.get1(cfg_worldareaconfig_get,area)
local oldV,newV=worldExperienceModel:getAreaProgress(area,block)
local tips=""
if areaCfg.tips then
for i,v in ipairs(areaCfg.tips)do
if oldV<v[1]and newV>=v[1]then
tips=v[2]
break
end
if newV<v[1]then
tips=v[3]
break
end
end
end
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
local unlockCfg=areaCfg.unlock and cfgHelper.get1(cfg_systemopenconfig_get,areaCfg.unlock)
local winParams={
name=blockCfg.name,
oldValue=oldV,
newValue=newV,
tips=tips,
unlock=newV>=100 and unlockCfg and unlockCfg.name or nil,
callback=callback,
}
return winParams
end



function worldExperienceModel:initReward(symbol)
rewards={}
local cfg=cfg_worldareaconfig()
for i=1,#cfg do
local status=mathHelper.getBitValue(symbol,i-1)
self:setReward(i,status)
if status then
notifySystem:postNotify(notifyConfig.onWorldAreaReward,i)
end
end
end




function worldExperienceModel:setReward(area,getted)
rewards[area]=getted
end




function worldExperienceModel:getReward(area)
return rewards[area]==true
end

function worldExperienceModel:isAllReward()
for i,v in pairs(cfg_worldareaconfig())do
if not self:getReward(i)then
return false
end
end
return true
end