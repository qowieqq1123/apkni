






local _MODULENAME="worldBlockModel"




def_table(_MODULENAME)
worldBlockModel.name=_MODULENAME


worldBlockModel.data={}


worldBlockModel.BLOCKSTATE=eWorldBlockState








local _block_data={}

local _config_data={}

local _select_cloud=-1
local _cloudChangeTime=0.5

local _check_stack={}

local _reddot_value=nil
local _reddot_key="worldMapReddot"

local function registerConfig(config,unitType,cfgName)
config[unitType]=cfgName
end

local function addConfig(config,data)
table.insert(config,data)
end


function worldBlockModel:onAppStart()
registerConfig(_config_data,worldModel.UNITTYPE.FOG,cfg_worldfogconfig_get)
registerConfig(_config_data,worldModel.UNITTYPE.MYSTERY,cfg_secretscenefubenconfig_get)
registerConfig(_config_data,worldModel.UNITTYPE.SCENERY,cfg_worldsceneryconfig_get)
registerConfig(_config_data,worldModel.UNITTYPE.MONSTER,cfg_worldmonstergroupconfig_get)
registerConfig(_config_data,worldModel.UNITTYPE.FAMILY,cfg_xiuzhenfamilydataconfig_get)
end


function worldBlockModel:onEnterState()

end


function worldBlockModel:onLeaveState()



end


function worldBlockModel:onServerDataInitFinish()

end



function worldBlockModel:getAllBlockData()
return _block_data
end


function worldBlockModel:resetAllBlockData()
_block_data={}
for i,v in pairs(cfg_worldblockconfig())do
_block_data[i]={}
for j,w in pairs(v)do
self:resetBlockData(i,j)
end
end
end




function worldBlockModel:resetBlockData(world,block)
_block_data[world][block]=eWorldBlockState.CLOSE
end




function worldBlockModel:initBlockStateByServerData(array)
self:resetAllBlockData()

local list=array or{}
for i,v in ipairs(list)do
local world=v.param_1
local fog=v.param_2
local shadow=v.param_3
local worldCfg=cfgHelper.get1(cfg_worldblockconfig_get,world)
local blockCnt=worldCfg and#worldCfg or 0

for i=1,blockCnt do
local fogBit=mathHelper.getBitValue(fog,i-1)
local shadowBit=mathHelper.getBitValue(shadow,i-1)
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,i)

if blockCfg.defaultUnlock then

if blockCfg.defaultOpen then
if shadowBit then
self:setBlockStateImp(world,i,self.BLOCKSTATE.OPEN)
else
self:setBlockStateImp(world,i,self.BLOCKSTATE.UNLOCK)
if not fogBit then


table.insert(_check_stack,{true,world,i})
end
end

else
self:setBlockStateImp(world,i,self.BLOCKSTATE.OPEN)
if not fogBit then


table.insert(_check_stack,{true,world,i})
end
if not shadowBit then


table.insert(_check_stack,{false,world,i})
end
end
else
if shadowBit then
self:setBlockStateImp(world,i,self.BLOCKSTATE.OPEN)
if not fogBit then


table.insert(_check_stack,{true,world,i})
end
elseif fogBit then
self:setBlockStateImp(world,i,self.BLOCKSTATE.UNLOCK)
else
self:setBlockStateImp(world,i,self.BLOCKSTATE.CLOSE)
end
end
end
end
end

function worldBlockModel:checkInitStack()
for i,v in ipairs(_check_stack)do
if v[1]then
worldBlockController:send_5_2(v[2],v[3])
else
worldBlockController:send_5_8(v[2],v[3])
end
end
_check_stack={}
end




function worldBlockModel:eachBlockData(world,doFunc)
for i,v in pairs(_block_data[world])do
doFunc(i)
end
end





function worldBlockModel:getBlockState(world,block)
if _block_data[world]==nil or _block_data[world][block]==nil then
loggerUtil.logErrFMT("获取错误的区块状态数据 {0}, {1}",world,block)
return eWorldBlockState.CLOSE
end
return _block_data[world][block]
end





function worldBlockModel:setBlockState(world,block,state,refreshCloud,refreshCloudCB)
local oState=_block_data[world][block]
_block_data[world][block]=state
if oState~=state then
notifySystem:postNotify(notifyConfig.onWorldBlockDataChanged,world,block,state,oState)
end
if worldController:isInWorld()and worldModel:isSameWorld(world)then
if refreshCloud then
worldBlockController:pushSingleCloud(world,block,_cloudChangeTime,refreshCloudCB)
end
end
end

function worldBlockModel:setBlockStateImp(world,block,state)
_block_data[world][block]=state
end




function worldBlockModel:getClouds(world)
local list={}
for block,state in pairs(_block_data[world])do
local cfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
local cloudIdx=cfg.cloud
local cloudState=mathHelper.lShiftNum(state,2)or 0
if worldExperienceModel:sameScene(world,block)then
cloudState=3
end
local cloudData=bit.lshift(cloudState,16)+cloudIdx
table.insert(list,cloudData)
end
return list
end

function worldBlockModel:getMasks(world)
local list={}
for block,state in pairs(_block_data[world])do
local cfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
local cloudIdx=cfg.cloud
local cloudState=mathHelper.lShiftNum(state,2)or 0
cloudState=math.floor(cloudState/2)*2
local cloudData=bit.lshift(cloudState,16)+cloudIdx
table.insert(list,cloudData)
end
return list
end





function worldBlockModel:getCloud(world,block)
local cfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
local cloudIdx=cfg.cloud
local cloudState=mathHelper.lShiftNum(self:getBlockState(world,block),2)or 0
local cloudData=bit.lshift(cloudState,16)+cloudIdx
return cloudData
end

function worldBlockModel:setSelectFog(cloudIdx)
_select_cloud=cloudIdx or-1
end

function worldBlockModel:getSelectFog()
return _select_cloud
end






function worldBlockModel:checkBlockState(world,block,state)
return self:getBlockState(world,block)==state
end






function worldBlockModel:canUnlockBlock(world,block)
if self:checkBlockState(world,block,self.BLOCKSTATE.CLOSE)then
local adjacents=cfgHelper.get3(cfg_worldblockconfig_get,world,block,"adjacentBlocks")
if adjacents and#adjacents>0 then
for i,v in ipairs(adjacents)do
if self:checkBlockState(v[1],v[2],self.BLOCKSTATE.OPEN)then
return true,0
end
end
return false,1
end
return true,0
end
return false,-1
end





function worldBlockModel:isShowFogEffect(world,block)
local can,code=worldBlockModel:canUnlockBlock(world,block)
if not can then

return false
end
local check=self:isUnLockEnoughCondition(world,block)
return check
end

function worldBlockModel:isUnLockEnoughCondition(world,block)
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
for i,v in ipairs(blockCfg.unlock)do
if v[1]==1 and zongmenModel:getLevel()<v[2]then
return false,v[1],v[2]
elseif v[1]==2 and not taskModel:checkTaskFinish(v[2])then
return false,v[1],v[2]
end
end
return true
end

function worldBlockModel:getUnlockConditionStr(world,block)
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
local str=nil
local temp=nil
local check=nil
for i,v in ipairs(blockCfg.unlock)do
if v[1]==1 then
temp=FMT.fmt("{0}级解锁",v[2])
check=zongmenModel:getLevel()<v[2]
elseif v[1]==2 then
temp=FMT.fmt("完成<color=#c82c2c>主线任务·{0}</color>解锁",cfgHelper.get2(cfg_taskconfig_get,v[2],"name"))
check=not taskModel:checkTaskFinish(v[2])
end
if temp then
local splite=str==nil and""or"\n"
temp=check and FMT.fmt("<color=#fffc00>{0}</color>",temp)or temp
str=FMT.fmt("{0}{1}{2}",str or"",splite,temp)
end
end
return str
end

function worldBlockModel:checkAllEnoughUnlock()
local cfg=cfg_worldblockconfig()
for i,v in pairs(cfg)do
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,i)
if worldCfg then
for j,w in pairs(v)do
if self:isShowFogEffect(i,j)then
return true
end
end
end
end
return false
end







function worldBlockModel:getUnitConfig(unitType,tableId)
local cfgName=_config_data[unitType]
if cfgName then
if unitType==worldModel.UNITTYPE.MONSTER then
local monster=worldMonsterModel:get_monster_by_posId(tableId)
if monster then
local cfgId=monster.worldMonsterId
return cfgHelper.get1(cfgName,cfgId)
else
loggerUtil.logErrFMT("没有大世界单位配置：{0}，{1}",unitType,tableId)
end
else
return cfgHelper.get1(cfgName,tableId)
end
else
loggerUtil.logErrFMT("没有大世界单位配置：{0}",unitType)
end
end


function worldBlockModel:nextState(state)
return state>0 and bit.rshift(state,1)or 1
end

function worldBlockModel:findExploreBlock(world)
if self:isWorldAllOpen(world)then
local filter=function(w,b)
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,w)
if world~=w and worldCfg~=nil then
local check=worldBlockModel:checkWorldEnterLimit(w)
return check
else
return false
end
end
local list=worldBlockModel:getAllStateBlock(self.BLOCKSTATE.UNLOCK,filter)
if#list>0 then
for i,v in ipairs(list)do
local task=worldExperienceModel:getTask()
if task then
return v[1],v[2]
end
end
local first=list[1]
return{first[1],first[2],self.BLOCKSTATE.UNLOCK}
end

list=worldBlockModel:getAllStateBlock(self.BLOCKSTATE.CLOSE,filter)
local check={}
for i,v in ipairs(list)do
local can=self:canUnlockBlock(v[1],v[2])
local enough=self:isUnLockEnoughCondition(v[1],v[2])
if can then
if enough then
return{v[1],v[2],self.BLOCKSTATE.CLOSE}
else
table.insert(check,v)
end
end
end
if#check>0 then
local first=check[1]
return{first[1],first[2],self.BLOCKSTATE.CLOSE}
end

if#list>0 then
local first=list[1]
return{first[1],first[2],self.BLOCKSTATE.CLOSE}
end
else
local unlock=worldBlockModel:findWorldStateBlock(world,self.BLOCKSTATE.UNLOCK)
if unlock then
return{world,unlock,self.BLOCKSTATE.UNLOCK}
else
local close=worldBlockModel:findWorldStateBlock(world,self.BLOCKSTATE.CLOSE)
if close then
return{world,close,self.BLOCKSTATE.CLOSE}
end
end
end
end

function worldBlockModel:findWorldStateBlock(world,state)
for i,v in pairs(_block_data[world])do
if self:checkBlockState(world,i,state)then
return i
end
end
end

function worldBlockModel:findStateBlock(state,filter)
for i,v in pairs(_block_data)do
for j,w in pairs(v)do
if self:checkBlockState(i,j,state)and(not filter or filter(i,j))then
return{i,j}
end
end
end
end

function worldBlockModel:isAllWorldAllOpen()
for i,v in pairs(_block_data)do
if not self:isWorldAllOpen(v)then
return false
end
end
return true
end




function worldBlockModel:isWorldAllOpen(world)
local list=_block_data[world]
if list then
for i,v in pairs(list)do
if v~=self.BLOCKSTATE.OPEN then
return false
end
end
return true
end
return false
end

function worldBlockModel:isAreaAllClose(area)
local areaCfg=cfgHelper.get1(cfg_worldareaconfig_get,area)
if areaCfg then
for i,v in ipairs(areaCfg.blocks)do
if not self:checkBlockState(areaCfg.world,v,self.BLOCKSTATE.CLOSE)then
return false
end
end
end
return true
end

function worldBlockModel:isAreaExistOpen(area)
local areaCfg=cfgHelper.get1(cfg_worldareaconfig_get,area)
if areaCfg then
for i,v in ipairs(areaCfg.blocks)do
if self:checkBlockState(areaCfg.world,v,self.BLOCKSTATE.OPEN)then
return true
end
end
end
return false
end

function worldBlockModel:isWorldExistOpen(world)
local list=_block_data[world]
if list then
for i,v in pairs(list)do
if v==self.BLOCKSTATE.OPEN then
return true
end
end
end
return false
end

function worldBlockModel:findOpenWorlds()
local list={}
for i,v in pairs(_block_data)do
for j,w in pairs(v)do
if w==self.BLOCKSTATE.OPEN then
table.insert(list,i)
break
end
end
end
return list
end

function worldBlockModel:getAreaStateCount(area,state)
local num=0
local areaCfg=cfgHelper.get1(cfg_worldareaconfig_get,area)
if areaCfg then
for i,v in ipairs(areaCfg.blocks)do
if self:checkBlockState(areaCfg.world,v,state)then
num=num+1
end
end
end
return num
end

function worldBlockModel:getWorldStateCount(world,state)
local num=0
if _block_data[world]then
for i,v in pairs(_block_data[world])do
if v==state then
num=num+1
end
end
end
return num
end

function worldBlockModel:getAreaNotStateCount(area,state)
local num=0
local areaCfg=cfgHelper.get1(cfg_worldareaconfig_get,area)
if areaCfg then
for i,v in ipairs(areaCfg.blocks)do
if not self:checkBlockState(areaCfg.world,v,state)then
num=num+1
end
end
end
return num
end


function worldBlockModel:getWorldNotStateCount(world,state)
local num=0
for i,v in pairs(_block_data[world])do
if v~=state then
num=num+1
end
end
return num
end

function worldBlockModel:getAllStateBlock(state,filter)
local list={}
for i,v in pairs(_block_data)do
for j,w in pairs(v)do
if w==state and(not filter or filter(i,j))then
table.insert(list,{i,j})
end
end
end
return list
end

function worldBlockModel:findBlockArea(world,block)
for i,v in pairs(cfg_worldareaconfig())do
if v.world==world then
for j,w in ipairs(v.blocks)do
if w==block then
return i
end
end
end
end
end

function worldBlockModel:isBlockAdjacent(world,block)
local cfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
if not cfg.adjacentBlocks or#cfg.adjacentBlocks<=0 then
return true
end
for i,v in ipairs(cfg.adjacentBlocks)do
if self:checkBlockState(v[1],v[2],eWorldBlockState.OPEN)then
return true
end
end
return false
end

function worldBlockModel:findPreBlocks(world,block)
local cfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
local list={}
if cfg.adjacentBlocks and#cfg.adjacentBlocks>0 then
if self:isBlockAdjacent(world,block)then
table.insert(list,{world,block,cfg.id})
else
for i,v in ipairs(cfg.adjacentBlocks)do
local children=self:findPreBlocks(v[1],v[2])
list=table.concatTableX(list,children)
end
end
else
table.insert(list,{world,block,cfg.id})
end

return list
end

function worldBlockModel:findSourceBlock(world,block)
local preBlocks=self:findPreBlocks(world,block)
if#preBlocks>1 then
table.sort(preBlocks,function(a,b)
if a[3]~=b[3]then
return a[3]<b[3]
elseif a[1]~=b[1]then
return a[1]<b[1]
else
return a[2]<b[2]
end
end)
end
return preBlocks[1]
end


function worldBlockModel:checkWorldEnterLimit(world)
local check2,eTpye,eValue=worldBlockModel:isUnLockEnoughCondition(world,1)
if not check2 then
local str="区块开启条件未满足"
if eTpye==1 then
str=FMT.fmt("{0}级解锁",eValue)
elseif eTpye==2 then
str=FMT.fmt("完成<color=#ca631d>主线任务·{0}</color>解锁",cfgHelper.get2(cfg_taskconfig_get,eValue,"name"))
end
return false,str
end
local check1=worldBlockModel:isBlockAdjacent(world,1)
if not check1 then
local preInfo=worldBlockModel:findSourceBlock(world,1)
local str="探索前置区块后开启"
if preInfo then
local preCfg=cfgHelper.get2(cfg_worldblockconfig_get,preInfo[1],preInfo[2])
str=FMT.fmt("探索{0}后开启",preCfg.name)
end
return false,str
end
return true
end

function worldBlockModel:checkWorldEnterLimitStr(world)
local str=self:getUnlockConditionStr(world,1)
return str or""
end

function worldBlockModel:checkWorldEnterLimitReddot(world)
local check1=not worldBlockModel:checkBlockState(world,1,eWorldBlockState.OPEN)
local check2=self:getWorldReddotFlag()
return check1 and check2
end

function worldBlockModel:checkAllWorldEnterReddot()
if worldBlockModel:getWorldReddotFlag()then
local cfg=cfg_worldconfig()
for world,wCfg in pairs(cfg)do
local check1=worldBlockModel:checkWorldEnterLimit(world)
local check2=not worldBlockModel:checkBlockState(world,1,eWorldBlockState.OPEN)
if check1 and check2 then
return true
end
end
end
return false
end

function worldBlockModel:getWorldReddotFlag()
if _reddot_value==nil then
_reddot_value=userActorSetting.get(_reddot_key,true)
end
return _reddot_value
end

function worldBlockModel:setWorldReddotFlag(flag)
_reddot_value=flag
userActorSetting.flushVal(_reddot_key,_reddot_value,true)
end

function worldBlockModel:checkWorldReddotReset()
for world,wCfg in pairs(cfg_worldconfig())do
local check1=self:checkWorldEnterLimit(world)
local check2=self:checkWorldEnterLimitReddot(world)
if check1 and check2 then
return true
end
end
return false
end

function worldBlockModel:getDefaultWorld()
local max=1
for world,wCfg in pairs(cfg_worldconfig())do
local check1=self:checkWorldEnterLimit(world)
local check2=self:checkBlockState(world,1,eWorldBlockState.OPEN)
if check1 and check2 then
max=math.max(max,world)
end
end
return max
end


