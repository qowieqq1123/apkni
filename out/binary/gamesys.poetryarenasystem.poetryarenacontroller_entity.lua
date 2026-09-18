function poetryArenaController:createEntity(data)
local serial=data.guid
local cfg=cfgHelper.get1(cfg_wendouleitaiconfig_get,data.id)
local unitKey=poetryArenaModel:convertUnitKey(serial)
local position=data.position
local luaData={eWorldUnitTpye.POETRYARENA,serial}
local modelSetting=worldModel:getModelSettings(cfg.model,eWorldUnitTpye.POETRYARENA)
local hudSettings=worldModel:getHUDSetting(cfg.hud,eWorldUnitTpye.POETRYARENA)
worldController:pushUnit(unitKey,position,luaData,modelSetting,hudSettings,nil,true)
worldController:setUnitFlipX(unitKey,data.flip or false)
end

function poetryArenaController:deleteEntity(guid)
local unitKey=poetryArenaModel:convertUnitKey(guid)
worldController:popUnit(unitKey)
end

function poetryArenaController:checkDeleteArena(guid)
local arena=poetryArenaModel:getArenaData(guid)
if not arena.valid then
local limit=cfgHelper.get2(cfg_wendouleitaibaseconfig_get,1,"world")
if worldController:isInWorld()and worldModel:isSameWorld(limit)then
poetryArenaController:deleteEntity(guid)
end
end
end

function poetryArenaController:onWorldEnter(world)
local actId=LIMIT_ACT_TYPE.eWenDouLeiTai
if limitActivitiesModel:checkActOpen(actId)and limitActivitiesModel:checkActDoing(actId)then
local limit=cfgHelper.get2(cfg_wendouleitaibaseconfig_get,1,"world")
if limit==world then
local datas=poetryArenaModel:getAllArenas()
for i,v in pairs(datas)do
if v.valid and worldBlockModel:checkBlockState(world,v.block,eWorldBlockState.OPEN)then
self:createEntity(v)
end
end
end
end
end

function poetryArenaController:deleteWorldEntity(world)
local limit=cfgHelper.get2(cfg_wendouleitaibaseconfig_get,1,"world")
if limit==world then
local datas=poetryArenaModel:getAllArenas()
for i,v in pairs(datas)do
if v.valid then
self:deleteEntity(v.guid)
end
end
end
end

function poetryArenaController.onClickEntity(args)
if args and args[1]==eWorldUnitTpye.POETRYARENA then
local guid=args[2]
if limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eWenDouLeiTai)then
if limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eWenDouLeiTai)then
UIFullPoetryArenaController:showMainWindow(guid)
end
end
end
end

function poetryArenaController.onClickUnitTab(guid)
if worldController:isInWorld()then
worldController:resetRightView()
end
local limit=cfgHelper.get2(cfg_wendouleitaibaseconfig_get,1,"world")
local unitKey=poetryArenaModel:convertUnitKey(guid)
if limit==worldModel.world then
local callback=function()
worldController:clickUnit(unitKey)
end

local arena=poetryArenaModel:getArenaData(guid)
if arena.started then
worldController:lookAtUnit(unitKey,nil,nil,callback)
else
local find=poetryArenaModel:findAStartArena()
if find then
local showdata=
{
type='UIDialouge',
title='提示',
content="当前有擂台进行中，是否仍要挑战其他擂台",
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
worldController:lookAtUnit(unitKey,nil,nil,callback)
end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
else
worldController:lookAtUnit(unitKey,nil,nil,callback)
end
end
else
local worldName=cfgHelper.get2(cfg_worldconfig_get,limit,'name')
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt('确认前往<color=#18a736>{0}</color>？',worldName),
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
local args={lookAtUnit=unitKey}
worldController:enterWorld(limit,args)
end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end
end

function poetryArenaController.onLimitActStateChange(actId,actState)
if actId==LIMIT_ACT_TYPE.eWenDouLeiTai and limitActivitiesModel:checkActOpen(actId)then
if actState==limitActivitiesModel.actDoingState then
if worldController:isInWorld()then
poetryArenaController:onWorldEnter(worldModel.world)
end
else
if worldController:isInWorld()then
poetryArenaController:deleteWorldEntity(worldModel.world)
end
if fullScreenUI.checkFull(UIFullPoetryArenaController)then
UIFullPoetryArenaController:closeUI()
end
end
end
end

function poetryArenaController.onLimitActOpen(actId,flag)
if actId==LIMIT_ACT_TYPE.eWenDouLeiTai then
if flag==1 then
local actInfo=limitActivitiesModel:getActInfo(actId)
if actInfo.state==limitActivitiesModel.actDoingState then
if worldController:isInWorld()then
poetryArenaController:onWorldEnter(worldModel.world)
end
end
else
if worldController:isInWorld()then
poetryArenaController:deleteWorldEntity(worldModel.world)
end
if fullScreenUI.checkFull(UIFullPoetryArenaController)then
UIFullPoetryArenaController:closeUI()
end
end
end
end

function poetryArenaController.onWorldBlockDataInited(reInit)
if initProControl.isDone()and worldController:isInWorld()then
poetryArenaController:deleteWorldEntity(worldModel.world)
poetryArenaController:onWorldEnter(worldModel.world)
UIManager:callWindowFunc("UIWeekUnitListWin","refreshList",LIMIT_ACT_TYPE.eWenDouLeiTai)
UIManager:invokeUIMethod('UILimitActStorageWin','refreshCondShow',LIMIT_ACT_TYPE.eWenDouLeiTai)
end
end

function poetryArenaController.onWorldBlockDataChanged(world,block,state)
if state==eWorldBlockState.OPEN then
local actId=LIMIT_ACT_TYPE.eWenDouLeiTai
if not limitActivitiesModel:checkActOpen(actId)or not limitActivitiesModel:checkActDoing(actId)then
return
end
local limit=cfgHelper.get2(cfg_wendouleitaibaseconfig_get,1,"world")
if limit==world then
local datas=poetryArenaModel:getAllArenas()
for i,v in pairs(datas)do
if v.block==block then
poetryArenaController:createEntity(v)
end
end
UIManager:callWindowFunc("UIWeekUnitListWin","refreshList",LIMIT_ACT_TYPE.eWenDouLeiTai)
UIManager:invokeUIMethod('UILimitActStorageWin','refreshCondShow',LIMIT_ACT_TYPE.eWenDouLeiTai)
end
end
end

function poetryArenaController:resetArenaPosition(arena,lib,world)
local check,temp=worldPositionLibrary:extract({lib})
if check then
local posData=temp[1]
local x=posData.x
local z=posData.z
local flip=posData.flip
local position,block=worldPositionConfig:getPosition(world,{posData.x,posData.z})
if position~=Vector3.zero then
arena.position=position
arena.flip=flip
arena.block=block
worldPositionLibrary:markData(world,x,z,flip,eWorldUnitTpye.POETRYARENA,arena.guid)

if worldController:isInWorld()and worldModel:isSameWorld(world)then
local unitKey=poetryArenaModel:convertUnitKey(arena.guid)
worldController:setUnitPosition(unitKey,arena.position)
end
return true
end
end
return false
end

function poetryArenaController.onWorldPositionReRandom(rData,aData)
if rData.unitType==eWorldUnitTpye.POETRYARENA then

local guid=int64.new(rData.key)
local arena=poetryArenaModel:getArenaData(guid)
if arena==nil then
loggerUtil.logErrFMT("文斗擂台坐标重新抽取坐标失败, 空数据 GUID：{0}",tostring(guid))
return
end
local baseCfg=cfgHelper.get1(cfg_wendouleitaibaseconfig_get,1)
local world=baseCfg.world
local posLib=baseCfg.posLib
local lib=baseCfg.posLib[arena.block]
worldPositionLibrary:eraseData(guid)
if lib then

if poetryArenaController:resetArenaPosition(arena,lib,world)then
return
end
loggerUtil.logErrFMT("文斗擂台坐标重新抽取坐标失败,GUID:{0},Lib:{1}",tostring(guid),lib)
end



local all=poetryArenaModel:getAllArenas()
local blockCnt={}
for i,v in pairs(all)do
if v.guid~=arena.guid then
blockCnt[v.block]=(blockCnt[v.block]or 0)+1
end
end
local valids={}
for i,v in pairs(baseCfg.ltNum)do
if blockCnt[i]<v then
local r=math.random(1,#valids+1)
table.insert(valids,i,r)
end
end

local validCnt=#valids
if validCnt>0 then
for i,v in ipairs(valids)do
local l=posLib[v]
if poetryArenaController:resetArenaPosition(arena,l,world)then
return
end
end
loggerUtil.logErrFMT("文斗擂台坐标重新抽取坐标失败, 所有库均不符合")
else
loggerUtil.logErrFMT("文斗擂台坐标重新抽取坐标失败, 数量超出上限")
end

arena.position=Vector3.zero
arena.flip=false
arena.block=0
if worldController:isInWorld()and worldModel:isSameWorld(world)then
local unitKey=poetryArenaModel:convertUnitKey(arena.guid)
worldController:setUnitPosition(unitKey,arena.position)
end
end
end
