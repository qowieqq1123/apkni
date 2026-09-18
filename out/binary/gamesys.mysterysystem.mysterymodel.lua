






local _MODULENAME="MysteryModel"


def_table(_MODULENAME)
MysteryModel.name=_MODULENAME



MysteryModel.MysteryTypeData=
{
[MysterySenceType.World]=
{
showInMysteryList=true,
},
[MysterySenceType.Lilian]=
{
showInMysteryList=false,
},
[MysterySenceType.ResPoint]=
{
showInMysteryList=true,
},
[MysterySenceType.ZongMen]=
{
showInMysteryList=true,
},
[MysterySenceType.ShangGuXianDi]=
{
showInMysteryList=false,
showInWeekAct=true,
},
[MysterySenceType.ZiYuan]=
{
showInMysteryList=true,
},
[MysterySenceType.qiyu]=
{
showInMysteryList=false,
},
[MysterySenceType.XianJieResPoint]=
{
showInMysteryList=true,
},
}

MysteryModel.selectFBid=nil

MysteryModel.data={}
MysteryModel.currentFBData={}
MysteryModel.configData={}

function MysteryModel:on_app_start()
MysteryModel.configData={}
MysteryModel.mapConfig={}
MysteryModel.roomMapConfig={}
end


function MysteryModel:on_enter_state()
self.data={}
self.currentFBData={}
self.data.tempSkillSelectSlot={}
self.data.ndLevel={}
self.loadingTile={}
self.data.fbInfoData={}
self.data.percentList={}
self:init_hide_in_same_pos_type()
MysteryLingshouModel:on_enter_state()
end


function MysteryModel:on_leave_state()

self.data={}
self.currentFBData={}
self.loadingTile={}

self.treasureMap=nil
MysteryLingshouModel:on_leave_state()
end


function MysteryModel:on_player_create(player,...)

end


function MysteryModel:get_mystery_sence_type(fbid)
local cfg_fb=cfgHelper.get(cfg_secretscenefubenconfig_get,fbid)
if cfg_fb and cfg_fb.practice then
return cfg_fb.practice
else
return MysterySenceType.World
end
end


function MysteryModel:set_Mystery_enter(flag)
self.data.isEnter=flag
end


function MysteryModel:is_enter_Mystery()
return self.data.isEnter
end


function MysteryModel:clear_fb_data()
self.loadingTile={}
self.currentFBData={}
self.lastPath={}
self.colorGridsEntity={}
self.data.mainSizeX=0
self.data.mainSizeY=0
self.data.subSizeX=0
self.data.subSizeY=0
self.currentFBData.linshiDisciple={}

self.currentFBData.mapTrap={}
self.currentFBData.trapMapList={}

self:set_select_zhenFa(0)
mysteryFogModel:init_data()
mysteryRoomModel:init_data()

mysteryTriggerManager.isInTrigger=false
mysteryTriggerManager:set_lock_trigger(nil)

mysteryEntityController.invokeAllModelsFunc("init_data")

mysteryFightModel:init_data()

mysterySkillModel:init_data()

mysteryDiscipleEffectModel:init_data()

mysteryEntityController:initTempData()

mysteryEnvironmentEffectModel:init_data()

mysteryTriggerManager.isInTrigger=nil
mysteryWeekActivityModel.mijingfazetujianLookUp={}
MysteryEventPart:initData()
mysteryTriggerGamePlot:setGamePlotData(nil)
mysteryTriggerManager:clearBanTri()
end




function MysteryModel:setTempSkillSelectSlot(skillData)
self.data.tempSkillSelectSlot=skillData
end

function MysteryModel:getTempSkillSelectSlot()
return self.data.tempSkillSelectSlot
end


function MysteryModel:setTempSkillData(fbid,skillData)
self.data.tempSkillData=self.data.tempSkillData or{}
self.data.tempSkillData[fbid]=skillData
end

function MysteryModel:getTempSkillData(fbid)
return self.data.tempSkillData and self.data.tempSkillData[fbid]
end

function MysteryModel:set_fb_finish(finishType)
self.currentFBData.isFBFinish=finishType
end

function MysteryModel:get_fb_finish()
return self.currentFBData.isFBFinish
end

function MysteryModel:set_fb_exit(exit)
self.data.exitFunc=exit
end

function MysteryModel:get_fb_exit()
return self.data.exitFunc
end

function MysteryModel:call_fb_exit(fbid,finishType,leaveState)
if self.data.exitFunc then
self.data.exitFunc(fbid,finishType,leaveState)
end
end

function MysteryModel:clear_fb_exit()
self.data.exitFunc=nil
end


function MysteryModel:set_mysteryFB_ndLevel(fbId,lv)
if not self.data.ndLevel then
self.data.ndLevel={}
end
self.data.ndLevel[fbId]=lv
end

function MysteryModel:get_mysteryFB_ndLevel(fbId)
if fbId then
local fixedJingJie=cfgHelper.get(cfg_secretscenefubenconfig_get,fbId,"fixedJingJie")
if fixedJingJie then
return fixedJingJie
end
end
return self.data.ndLevel[fbId]
end


function MysteryModel:setFBInfoData(fbId,data)
self.data.fbInfoData[fbId]=data
if data and data[2]then
self.data.percentList[fbId]=data[2]
end
end

function MysteryModel:updateFBInfoData(fbId,data)
local info=self.data.fbInfoData[fbId]
if info then
for k,v in pairs(data)do
info[k]=v
end
self.data.fbInfoData[fbId]=info
end
if data[2]then
self.data.percentList[fbId]=data[2]
end
end
function MysteryModel:setPercentListData(fbId,percent)
self.data.percentList[fbId]=percent
end

function MysteryModel:getPercentListData(fbId)
return self.data.percentList[fbId]or 0
end

function MysteryModel:getFBInfoData(fbId)
return self.data.fbInfoData[fbId]
end


function MysteryModel:set_mysteryFB_environmentEffect(fbid,envList)
self.data.envList=self.data.envList or{}
self.data.envList[fbid]=envList
end


function MysteryModel:get_mysteryFB_environmentEffect(fbid)
self.data.envList=self.data.envList or{}
return self.data.envList[fbid]
end

function MysteryModel:clearInfo(fbId)
MysteryModel:setFBInfoData(fbId,nil)
MysteryModel:set_mysteryFB_ndLevel(fbId,nil)
MysteryModel:set_mysteryFB_environmentEffect(fbId,nil)
MysteryModel:setTempSkillData(fbId,nil)
end




function MysteryModel:set_cur_fbid(fbid)
self.selectFBid=nil
self.data.fbid=fbid
end


function MysteryModel:get_cur_fbid()
return self.data.fbid
end


function MysteryModel:is_in_mystery()
return self.data.fbid~=nil
end


function MysteryModel:set_select_zhenFa(zhenFaId)
self.data.selectZF=zhenFaId
end

function MysteryModel:get_select_zhenFa()
return self.data.selectZF or 0
end


function MysteryModel:get_mysteryFB_zhenFa(fbid)
local data=self:get_mysteryFB_list_data_fbid(fbid)
if data then
return data.zhenfaid
end
return 0
end



function MysteryModel:initFB()
return self.data.fbinit or false
end

function MysteryModel:set_mysteryFB_list_data(createCD,currentFB,fbList)

self:set_mysteryFB_currentOutId(currentFB)
self.data.createCD=createCD
self.data.fbNum=0
self.data.FBList={}
self.data.fbinit=true
mysteryWeekActivityModel:initFbList()
if fbList then
for i,v in ipairs(fbList)do
local sence_type=MysteryModel:get_mystery_sence_type(v.id)
local senceData=MysteryModel.MysteryTypeData[sence_type]
if senceData then
if senceData.showInMysteryList then
self.data.fbNum=self.data.fbNum+1
self.data.FBList[v.id]=v
chatGGModel.changeMijingData(v.id,true)
end

if senceData.showInWeekAct then
mysteryWeekActivityModel:addWeekMystery(v)
end
end
end
end
end

function MysteryModel:add_mysteryFB_list_data(fbListItem)
local sence_type=MysteryModel:get_mystery_sence_type(fbListItem.id)
local senceData=MysteryModel.MysteryTypeData[sence_type]
if senceData.showInMysteryList then
self.data.fbNum=self.data.fbNum+1
self.data.FBList[fbListItem.id]=fbListItem
end
if senceData.showInWeekAct then
mysteryWeekActivityModel:addWeekMystery(fbListItem)
end
end


function MysteryModel:romove_mysteryFB_list_data(fbid)
if self.data.FBList[fbid]then
self.data.FBList[fbid]=nil
self.data.fbNum=self.data.fbNum-1
end
chatGGModel.changeMijingData(fbid,false)
end


function MysteryModel:set_mysteryFB_currentOutId(currentOutId)
self.data.currentOutId=currentOutId
end

function MysteryModel:get_mysteryFB_currentOutId()
return self.data.currentOutId or 0
end


function MysteryModel:get_mysteryFB_create_CD()
return self.data.createCD
end



function MysteryModel:get_mysteryFB_list_data()
return self.data.FBList or{}
end


function MysteryModel:get_mysteryFB_list_num()
return self.data.fbNum or 0
end


function MysteryModel:get_mysteryFB_list_sort_data()
local sortList={}
if self.data.FBList then
for k,v in pairs(self.data.FBList)do
local isOpen=true
local sence_type=MysteryModel:get_mystery_sence_type(v.id)
if sence_type==MysterySenceType.World or sence_type==MysterySenceType.ResPoint then
local areaId=v.quyuId
local arearCfg=cfgHelper.get1(cfg_secretsceneareaconfig_get,areaId)
if arearCfg then
local worldBlock=arearCfg.worldBlock
if worldBlock then
if worldBlock[2]then
isOpen=worldBlockModel:checkBlockState(worldBlock[1],worldBlock[2],eWorldBlockState.OPEN)
else
isOpen=worldBlockModel:getWorldStateCount(worldBlock[1],eWorldBlockState.OPEN)>0
end
end
end
end
if isOpen then
if v.id==MysteryModel:get_mysteryFB_currentOutId()then
v.sort=1
elseif MysteryModel:is_fixed_map(v.id)then
v.sort=100+v.id
else
v.sort=100000+v.bornTime
end
table.insert(sortList,v)
end
end
table.sort(sortList,function(a,b)return a.sort<b.sort end)
end
return sortList
end


function MysteryModel:get_mysteryFB_list_sort_data2()
local FBList=self.data.FBList
local currentID=self:get_mysteryFB_currentOutId()
local list={}
local curWorld=nil
local curWorldIndex=nil
local curIndex=nil
for i,v in pairs(FBList)do
local sence_type=MysteryModel:get_mystery_sence_type(v.id)
if sence_type==MysterySenceType.World or sence_type==MysterySenceType.ResPoint then
local isOpen=true
local areaId=v.quyuId
local arearCfg=cfgHelper.get1(cfg_secretsceneareaconfig_get,areaId)
if arearCfg then
local worldBlock=arearCfg.worldBlock
if worldBlock then

local worldId=worldBlock[1]
list[worldId]=list[worldId]or{}

if worldBlock[2]then
isOpen=worldBlockModel:checkBlockState(worldBlock[1],worldBlock[2],eWorldBlockState.OPEN)
else
isOpen=worldBlockModel:getWorldStateCount(worldBlock[1],eWorldBlockState.OPEN)>0
end
if isOpen then
if v.id==MysteryModel:get_mysteryFB_currentOutId()then
v.sort=1
elseif MysteryModel:is_fixed_map(v.id)then
v.sort=100+v.id
else
v.sort=100000+v.bornTime
end
table.insert(list[worldId],v)
if v.id==currentID then
curWorld=worldId
curIndex=#list[worldId]
end
end
end
end
end
end
local l={}
for i,v in pairs(list)do
table.sort(v,function(a,b)return a.sort<b.sort end)
table.insert(l,{world=i,list=v})
if i==curWorld then
curWorldIndex=#l
end
end

return l,curWorldIndex,curIndex
end


function MysteryModel:get_mysteryFB_list_sort_data3()
local FBList=self.data.FBList

local list={}
local cfg=cfg_secretscenetypeconfig()
for i,v in pairs(cfg)do
local l={}
local haveZiYuan=false
local haveSGXD=false
local sceneTypeList=v.sceneType
for _,t in ipairs(sceneTypeList)do
if t==MysterySenceType.ZiYuan then
haveZiYuan=true
elseif t==MysterySenceType.ShangGuXianDi then
haveSGXD=true
end
for _,fbV in pairs(FBList)do
local sence_type=MysteryModel:get_mystery_sence_type(fbV.id)
if sence_type==t then
if sence_type~=MysterySenceType.ZiYuan then
if sence_type==MysterySenceType.World or sence_type==MysterySenceType.ResPoint then
local areaId=fbV.quyuId
local arearCfg=cfgHelper.get1(cfg_secretsceneareaconfig_get,areaId)
local isOpen=true
if arearCfg then
local worldBlock=arearCfg.worldBlock
if worldBlock then
if worldBlock[2]then
isOpen=worldBlockModel:checkBlockState(worldBlock[1],worldBlock[2],eWorldBlockState.OPEN)
else
isOpen=worldBlockModel:getWorldStateCount(worldBlock[1],eWorldBlockState.OPEN)>0
end
end
end
if isOpen then
table.insert(l,fbV)
end
else
table.insert(l,fbV)
end
end
end
end
end
if haveZiYuan then
if systemModel.isOpen(SYSTEM_DEFINE.eMiJingRand)then
l=cfg_secretsceneziyuanfubenconfig()
local group={}
for i2,v2 in ipairs(l)do
local ZiYuanflag=true
if v2[1]and v2[1].sysId and not systemModel.isOpen(v2[1].sysId)then
ZiYuanflag=false
end
if mysteryZiYuanFuBenModel:getGroupFbData(i2)and ZiYuanflag then
table.insert(group,v2)
end
end
if next(group)then
table.insert(list,{id=i,config=v,list=group})
end
end
elseif haveSGXD then
l=mysteryWeekActivityModel:getMysteryUnitWinList()
if next(l)then
table.insert(list,{id=i,config=v,list=l})
end
else
if next(l)then

table.sort(l,function(a,b)
local configA=cfgHelper.get(cfg_secretscenefubenconfig_get,a.id)
local sortA=(configA.sort or 99999)*1000+a.id
local configB=cfgHelper.get(cfg_secretscenefubenconfig_get,b.id)
local sortB=(configB.sort or 99999)*1000+b.id
return sortA<sortB
end)
table.insert(list,{id=i,config=v,list=l})



end
end
end

return list
end


function MysteryModel:get_mysteryFB_list_data_fbid(fbid)
if not self.data.FBList then
self.data.FBList={}
end
return self.data.FBList[fbid]
end

function MysteryModel:updateMysteryFB_list_data(fbId,data)
local info=MysteryModel:get_mysteryFB_list_data_fbid(fbId)
if info then
for k,v in pairs(data)do
info[k]=v
end
self.data.FBList[fbId]=info
end
end


function MysteryModel:find_mysteryFBdata_byPosGuid(posGuid)
if self.data.FBList then
for i,v in pairs(self.data.FBList)do
if v.guidPos==posGuid then
return v
end
end
end
end





function MysteryModel:add_mysteryFB_unit(fbid,worldId,x,z,blockId,posGuid,flip)
if not self.FBUnitList then
self.FBUnitList={}
end
self.FBUnitList[fbid]={worldId,x,z,blockId,posGuid,flip}
end


function MysteryModel:remove_mysteryFB_unit(fbid)
if not self.FBUnitList then
self.FBUnitList={}
end
self.FBUnitList[fbid]=nil
end

function MysteryModel:get_all_mysteryFB_unit()
return self.FBUnitList
end


function MysteryModel:clear_all_mysteryFB_unit()
self.FBUnitList=nil
end


function MysteryModel:get_mysteryFB_unit(fbid)
if not self.FBUnitList then
self.FBUnitList={}
end
return self.FBUnitList[fbid]
end

function MysteryModel:find_mysteryFBId_unit_byPosGuid(posGuid)
if self.FBUnitList then
for i,v in pairs(self.FBUnitList)do
if v[5]==posGuid then
return i
end
end
end
end

function MysteryModel:set_mysteryFB_enter_world_data(worldData)
self.data.worldData=worldData
end

function MysteryModel:get_mysteryFB_enter_world_data()
return self.data.worldData
end



function MysteryModel:setQuitNoCloudFlag(flag)
self.quitNoCloudFlag=flag
end
function MysteryModel:getQuitNoCloudFlag()
return self.quitNoCloudFlag
end




function MysteryModel:init_hide_in_same_pos_type()
self.data.hideInSamePosTypeList={}
local etTypeConfig=cfg_ssentitytypeconfig()
for et,v in pairs(etTypeConfig)do
if v.hideInSamePos then
self.data.hideInSamePosTypeList[et]=true
end
end
end

function MysteryModel:get_hide_in_same_pos_type()
return self.data.hideInSamePosTypeList
end



function MysteryModel:is_fixed_map(fbid)
local cfg_fb=cfg_secretscenefubenconfig_get(fbid)
return cfg_fb and cfg_fb.template[1]==1
end


function MysteryModel:is_reset(fbid)
local cfg_fb=cfg_secretscenefubenconfig_get(fbid)
return cfg_fb.reset and cfg_fb.reset[2]==1
end


function MysteryModel:is_show_close(fbid)
local cfg_fb=cfg_secretscenefubenconfig_get(fbid)
return cfg_fb.reset and cfg_fb.reset[1]==1
end


function MysteryModel:is_border(roomID,targetPos)
return(roomID==0 and MysteryModel:get_main_grid_data(targetPos.x,targetPos.y)or mysteryRoomModel:get_room_grid_data(roomID,targetPos.x,targetPos.y))==nil
end


function MysteryModel:is_have_team()
return self.data.state and self.data.state==1
end


function MysteryModel:is_disciple_dead(unitType,guid)
local blood=MysteryModel:get_fb_probeTeam_blood(unitType,guid)or 0
return blood<=0
end

function MysteryModel:is_use_power(fbid)
if not fbid then
return
end
local cfg_fb=cfg_secretscenefubenconfig_get(fbid)
return cfg_fb and cfg_fb.usePower>0
end


function MysteryModel:is_practice_mystery(fbid)
return MysteryModel:get_mystery_sence_type(fbid)==MysterySenceType.Lilian
end

function MysteryModel:is_mystery_init()
return self.currentFBData.isMysteryInit
end


function MysteryModel:have_mystery_task(fbid)
local targetKey=worldModel:convertUnitKey({worldModel.UNITTYPE.MYSTERY,fbid})
local taskKey=worldTaskModel:findTaskKey_ByTarget(targetKey)

local check=taskKey==nil
if not check then
local task=worldTaskModel:getTask(taskKey)
check=task.progress_state>=eWorldTripProgress.Back
end
return not check
end

function MysteryModel:have_mystery_march(fbid)
local rpData=xianjieModel:findResPointDataByMysteryID(fbid)
if rpData then
local march=xianjieModel:getResPointMarch(rpData.rpGuid)
return march~=nil
end
return false
end

function MysteryModel:canUseAllDisciple(fbid)
local cfg=cfgHelper.get(cfg_secretscenefubenconfig_get,fbid)
return cfg.useAllDizi
end

function MysteryModel:setMoveAcc(accType)
self.data.accType=accType
end

function MysteryModel:getMoveAcc()
return self.data.accType or 1
end

local moveDur=
{
[1]=0.4,
[2]=0.3,
}
function MysteryModel:getMoveDur()
return moveDur[MysteryModel:getMoveAcc()]
end

local moveAnimSpeed=
{
[1]=1,
[2]=1.2,
}
function MysteryModel:getMoveAnimSpeed()
return moveAnimSpeed[MysteryModel:getMoveAcc()]
end


function MysteryModel:setWanBaoXunBaoDuiInit(list)

self.data.wanbaoxunbaodui={}
self.data.wanbaoxunbaodui=list

local _mijindata=userActorSetting.get('UIWanBaoXunBaoDui_MiJinTipsWin_openMiJin',{})
local temp={}
for k,v in ipairs(self.data.wanbaoxunbaodui)do
if v.ssId then
if v.percent>=100 and v.closeFlag==1 then
temp[#temp+1]=v.ssId
end
end
end
local isdoing=false
for k,v in ipairs(self.data.wanbaoxunbaodui)do
if v.ssId then
if v.percent>=0 and v.closeFlag==0 then
temp[#temp+1]=v.ssId
isdoing=true
end
end
end
if#temp>#_mijindata then
userActorSetting.set('UIWanBaoXunBaoDui_MiJinTipsWin_openMiJin',temp)
end
end

function MysteryModel:setWanBaoXunBaoDuiNewlist(list)
self.data.wanbaoxunbaodui={}
if self.data.wanbaoxunbaodui then
for k,v in ipairs(list)do
self.data.wanbaoxunbaodui[#self.data.wanbaoxunbaodui+1]=v
end
else
self.data.wanbaoxunbaodui={}
for k,v in ipairs(list)do
self.data.wanbaoxunbaodui[#self.data.wanbaoxunbaodui+1]=v
end
end


local _mijindata=userActorSetting.get('UIWanBaoXunBaoDui_MiJinTipsWin_openMiJin',{})
local temp={}
for k,v in ipairs(self.data.wanbaoxunbaodui)do
if v.ssId then
if v.percent>=100 and v.closeFlag==1 then
temp[#temp+1]=v.ssId
end
end
end
local isdoing=false
for k,v in ipairs(self.data.wanbaoxunbaodui)do
if v.ssId then
if v.percent>=0 and v.closeFlag==0 then
temp[#temp+1]=v.ssId
isdoing=true
end
end
end
if#temp>#_mijindata then
userActorSetting.set('UIWanBaoXunBaoDui_MiJinTipsWin_openMiJin',temp)
end
end

function MysteryModel:setWanBaoXunBaoDuiTESSS()
userActorSetting.set('UIWanBaoXunBaoDui_MiJinTipsWin_openMiJin',{})
end


function MysteryModel:setWanBaoXunBaoDuiReward(ccmjId)
local cfg_mj=cfg_catcatmijingconfig_get(ccmjId)
local mjId=cfg_mj.id
if self.data.wanbaoxunbaodui then
for k,v in ipairs(self.data.wanbaoxunbaodui)do
if v.ssId==mjId then
v.rwFlag=1
end
end
end
end

function MysteryModel:getWanBaoXunBaoDuiData()
return self.data.wanbaoxunbaodui or{}
end

function MysteryModel:setWanBaoXunBaoDuiTXNum(txNum)
self.data.wanbaoxunbaoduiNum=txNum
end

function MysteryModel:getWanBaoXunBaoDuiTXNum()
return self.data.wanbaoxunbaoduiNum or 0
end

function MysteryModel:addWanBaoXunBaoDuiTXNum()
if not self.data.wanbaoxunbaoduiNum then
self.data.wanbaoxunbaoduiNum=0
end
if self.data.wanbaoxunbaoduiNum then
self.data.wanbaoxunbaoduiNum=self.data.wanbaoxunbaoduiNum+1
end
end

function MysteryModel:setWanBaoXunBaoDuiCatModel(catguid)
self.data.wanbaoxunbaoduicatModel=catguid
end
function MysteryModel:getWanBaoXunBaoDuiCatModel()
return self.data.wanbaoxunbaoduicatModel
end

function MysteryModel:setWanBaoXunBaoDuichannel_state(channel_state)
self.data.wanbaoxunbaoduichannel_state=channel_state
end
function MysteryModel:getWanBaoXunBaoDuichannel_state()
return self.data.wanbaoxunbaoduichannel_state
end

function MysteryModel:handelWanBaoXunBaoDuiMiJinOpen()
local cat_sysid=SYSTEM_DEFINE.eCatCatMiJing
if systemModel.isOpen(cat_sysid)then
local channel_state=MysteryModel:getWanBaoXunBaoDuichannel_state()
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eCatMiJin)

if channel_state and channel_state==WBXBD_Channel_STATE.finish and not check then
self:addWanBaoXunBaoDuiTXNum()
self:setWanBaoXunBaoDuichannel_state(WBXBD_Channel_STATE.idle)
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eCatMiJin)
if not check then
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eCatMiJin,true)
end
local list=wanBaoXunBaoDuiController:getNewCatMiJin()
local mijindata=userActorSetting.get('UIWanBaoXunBaoDui_MiJinTipsWin_openMiJin',{})

local new_mijindata=mijindata
local havenewid=false
if#list>0 then
if#new_mijindata>0 then
for k,v in ipairs(list)do
local a=v
for i,j in ipairs(new_mijindata)do
if j==a then
a=nil
end
end
if a then
havenewid=a
break
end
end
else
havenewid=list[#list]
end
end
if havenewid then
local mjid=havenewid
new_mijindata[#new_mijindata+1]=mjid
userActorSetting.set('UIWanBaoXunBaoDui_MiJinTipsWin_openMiJin',new_mijindata)
self:setWanBaoXunBaoDuichannel_MiJinid(nil)
self:setWanBaoXunBaoDuichannel_MiJinid(mjid)

end
end
end
end

function MysteryModel:setWanBaoXunBaoDuichannel_MiJinid(MiJinid)
self.data.wanbaoxunbaoduichannel_MiJinid=MiJinid
end
function MysteryModel:getWanBaoXunBaoDuichannel_MiJinid()
return self.data.wanbaoxunbaoduichannel_MiJinid
end


function MysteryModel:setTreasureMapUseCount(id,flag)
if not self.treasureMap then self.treasureMap={}end
self.treasureMap[id]=flag

end

function MysteryModel:getTreasureMapUseCount()
return self.treasureMap
end


function MysteryModel:setMJbuffUseNum(useNum)
self.data.buffUseNum=useNum
end
function MysteryModel:getMJbuffUseNum()
return self.data.buffUseNum or 0
end
