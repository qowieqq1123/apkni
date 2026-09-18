function YiYuHuiYouController:createEntity(data)
local serial=data.guid
local cfg=cfgHelper.get1(cfg_yiyuhuiyounpcconfig_get,data.npcid)
local unitKey=YiYuHuiYouModel:convertUnitKey(serial)
local position=data.position
local luaData={eWorldUnitTpye.YIYUHUIYOU,serial}
local modelSetting=worldModel:getModelSettings(cfg.model,eWorldUnitTpye.YIYUHUIYOU)
local hudSettings=worldModel:getHUDSetting(cfg.hud,eWorldUnitTpye.YIYUHUIYOU)

worldController:pushUnit(unitKey,position,luaData,modelSetting,hudSettings,nil,true)
worldController:setUnitFlipX(unitKey,data.flip or false)
end


function YiYuHuiYouController:deleteEntity(guid)
local unitKey=YiYuHuiYouModel:convertUnitKey(guid)
worldController:popUnit(unitKey)
end


function YiYuHuiYouController:checkDeleteArena(guid)









end


function YiYuHuiYouController:onWorldEnter(world)
local actId=LIMIT_ACT_TYPE.eYiYuHuiYou

if limitActivitiesModel:checkActOpen(actId)and limitActivitiesModel:checkActDoing(actId)then


local npcdatas=YiYuHuiYouModel:getNPCIdlist()

if npcdatas and#npcdatas>0 then

for i,v in pairs(npcdatas)do
if v.world==world then



if worldBlockModel:checkBlockState(world,v.block,eWorldBlockState.OPEN)then
self:createEntity(v)
end
end
end
end
end
end


function YiYuHuiYouController:deleteWorldEntity(world)

local npcdatas=YiYuHuiYouModel:getNPCIdlist()or{}
if npcdatas and#npcdatas>0 then
for i,v in pairs(npcdatas)do
if v.world==world then
if v then
self:deleteEntity(v.guid)
end
end
end
end
end


function YiYuHuiYouController.test_openYYHYZhiYin()
local npcdatas=YiYuHuiYouModel:getNPCIdlist()
if npcdatas and#npcdatas>0 then
local guid=npcdatas[1].guid
UIFullYiYuHuiYouController:showMainWindowZhiYin(guid)
end
end


function YiYuHuiYouController.onClickEntity(args)

if args and args[1]==eWorldUnitTpye.YIYUHUIYOU then
local guid=args[2]


if limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eYiYuHuiYou)then

if limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eYiYuHuiYou)then

local isFirst=userActorSetting.get('YiYuHuiYouGame_first',false)
local isgetguid=YiYuHuiYouModel:getGuid_reward_flag()
local npcdata=YiYuHuiYouModel:getNPCIdlistbyGuid(guid)
local yujulevel=cfg_yiyuhuiyounpcconfig_get(npcdata.npcid).yuju_level
local now_yujulevel=YiYuHuiYouController:getYuJuAllLevel()
local isopen=now_yujulevel>=yujulevel

if isopen then
if isFirst==true or isgetguid==1 then
UIFullYiYuHuiYouController:showMainWindow(guid)
elseif isFirst==false or isgetguid==0 then
local npcdata={}
if args and args[2]then
npcdata=YiYuHuiYouModel:getNPCIdlistbyGuid(args[2])
end
local zhiyinid=npcdata.npcid or 1
YiYuHuiYouModel:setnpczhiyinid(zhiyinid)

local callback=function()
UIFullYiYuHuiYouController:showMainWindowZhiYin(guid)
end
worldStoryController:showStoryTree(2220,callback)
end
else

local callback=function()

end
local juqintree=cfg_yiyuhuiyounpcconfig_get(npcdata.npcid).treeid or 2220
worldStoryController:showStoryTree(juqintree,callback)
end
end
end
end
end


function YiYuHuiYouController.onClickUnitTab(guid)

local npcdata=guid

if worldController:isInWorld()then
worldController:resetRightView()
end



local unitKey=YiYuHuiYouModel:convertUnitKey(npcdata.guid)


if npcdata.world==worldModel.world then



if true then
worldController:lookAtUnit(unitKey)
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
worldController:lookAtUnit(unitKey)
end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
else
worldController:lookAtUnit(unitKey)
end
end
else

local worldName=cfgHelper.get2(cfg_worldconfig_get,npcdata.world,'name')
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
worldController:enterWorld(npcdata.world,args)
end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end
end


function YiYuHuiYouController.onLimitActStateChange(actId,actState)

if actId==LIMIT_ACT_TYPE.eYiYuHuiYou and limitActivitiesModel:checkActOpen(actId)then

if actState==limitActivitiesModel.actDoingState then

if worldController:isInWorld()then
YiYuHuiYouController:onWorldEnter(worldModel.world)
end
else

if worldController:isInWorld()then
YiYuHuiYouController:deleteWorldEntity(worldModel.world)
end




local isgamegoing=YiYuHuiYouController:getGameDoingState()
if isgamegoing~=YYHYGameState.execute then
if fullScreenUI.checkFull(UIFullYiYuHuiYouController)then
UIFullYiYuHuiYouController:closeUI()
end
end
end
end
end


function YiYuHuiYouController.onLimitActOpen(actId,flag)

if actId==LIMIT_ACT_TYPE.eYiYuHuiYou then
if flag==1 then
local actInfo=limitActivitiesModel:getActInfo(actId)

if actInfo.state==limitActivitiesModel.actDoingState then
if worldController:isInWorld()then
YiYuHuiYouController:onWorldEnter(worldModel.world)
end
end
else

if worldController:isInWorld()then
YiYuHuiYouController:deleteWorldEntity(worldModel.world)
end


if fullScreenUI.checkFull(UIFullYiYuHuiYouController)then
UIFullYiYuHuiYouController:closeUI()
end
end
end
end


function YiYuHuiYouController.onWorldBlockDataInited(reInit)

if initProControl.isDone()and worldController:isInWorld()then
YiYuHuiYouController:deleteWorldEntity(worldModel.world)
YiYuHuiYouController:onWorldEnter(worldModel.world)
UIManager:callWindowFunc("UIWeekUnitListWin","refreshList",LIMIT_ACT_TYPE.eYiYuHuiYou)
end
end


function YiYuHuiYouController.onWorldBlockDataChanged(world,block,state)

if state==eWorldBlockState.OPEN then
local limit=cfgHelper.get2(cfg_wendouleitaibaseconfig_get,1,"world")
local npcdatas=YiYuHuiYouModel:getNPCIdlist()
if npcdatas and#npcdatas>0 then

for i,v in pairs(npcdatas)do
if v.world==world then



if v.block==block then
YiYuHuiYouController:createEntity(v)
end
end
UIManager:callWindowFunc("UIWeekUnitListWin","refreshList",LIMIT_ACT_TYPE.eYiYuHuiYou)
end
end
end
end


function YiYuHuiYouController:resetArenaPosition(arena,lib,world)
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
worldPositionLibrary:markData(world,x,z,flip,eWorldUnitTpye.YIYUHUIYOU,arena.guid)


if worldController:isInWorld()and worldModel:isSameWorld(world)then
local unitKey=YiYuHuiYouModel:convertUnitKey(arena.guid)
worldController:setUnitPosition(unitKey,arena.position)
end
return true
end
end
return false
end


function YiYuHuiYouController.onWorldPositionReRandom(rData,aData)
if rData.unitType==eWorldUnitTpye.YIYUHUIYOU then

local guid=int64.new(rData.key)



local npcdata_single=YiYuHuiYouModel:getNPCIdlistbyGuid(guid)
if not npcdata_single then
return
end








local world=npcdata_single.world



worldPositionLibrary:eraseData(guid)

if npcdata_single.posIdx then

if YiYuHuiYouController:resetArenaPosition(npcdata_single,npcdata_single.posIdx,world)then
return
end
loggerUtil.logErrFMT("以渔会友坐标重新抽取坐标失败,GUID:{0},Lib:{1}",tostring(guid),npcdata_single.posIdx)
end











































end
end
