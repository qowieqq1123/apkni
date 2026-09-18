















local _MODULENAME="UIDiscipleController"
gameState.addListener(def_table(_MODULENAME))
UIDiscipleController.name=_MODULENAME

local isInit=false
local initCheckFunctions=nil
local autoTakeDiscipleReward=false
local dzLianTiBrokeTempLookup
local fightReport=nil
local fightReportStr=nil

function UIDiscipleController:onAppStart()
socketManager:register_receiver(2,1,UIDiscipleController.do_protocol_2_1)
socketManager:register_receiver(2,2,UIDiscipleController.do_protocol_2_2)
socketManager:register_receiver(2,4,UIDiscipleController.do_protocol_2_4)
socketManager:register_receiver(2,5,UIDiscipleController.do_protocol_2_5)
socketManager:register_receiver(2,6,UIDiscipleController.do_protocol_2_6)
socketManager:register_receiver(2,7,UIDiscipleController.do_protocol_2_7)
socketManager:register_receiver(2,8,UIDiscipleController.do_protocol_2_8)
socketManager:register_receiver(2,9,UIDiscipleController.do_protocol_2_9)
socketManager:register_receiver(2,10,UIDiscipleController.do_protocol_2_10)
socketManager:register_receiver(2,11,UIDiscipleController.do_protocol_2_11)
socketManager:register_receiver(2,12,UIDiscipleController.do_protocol_2_12)
socketManager:register_receiver(2,13,UIDiscipleController.do_protocol_2_13)
socketManager:register_receiver(2,14,UIDiscipleController.do_protocol_2_14)
socketManager:register_receiver(2,15,UIDiscipleController.do_protocol_2_15)
socketManager:register_receiver(2,17,UIDiscipleController.do_protocol_2_17)
socketManager:register_receiver(2,20,UIDiscipleController.do_protocol_2_20)
socketManager:register_receiver(2,21,UIDiscipleController.do_protocol_2_21)
socketManager:register_receiver(2,22,UIDiscipleController.do_protocol_2_22)
socketManager:register_receiver(2,27,UIDiscipleController.do_protocol_2_27)
socketManager:register_receiver(2,24,UIDiscipleController.do_protocol_2_24)
socketManager:register_receiver(2,25,UIDiscipleController.do_protocol_2_25)


socketManager:register_receiver(2,41,UIDiscipleController.do_protocol_2_41)
socketManager:register_receiver(2,42,UIDiscipleController.do_protocol_2_42)

socketManager:register_receiver(2,69,UIDiscipleController.do_protocol_2_69)
socketManager:register_receiver(2,70,UIDiscipleController.do_protocol_2_70)
socketManager:register_receiver(2,71,UIDiscipleController.do_protocol_2_71)
socketManager:register_receiver(2,72,UIDiscipleController.do_protocol_2_72)

socketManager:register_receiver(2,100,UIDiscipleController.do_protocol_2_100)
socketManager:register_receiver(254,35,UIDiscipleController.do_protocol_254_35)


socketManager:register_receiver(2,106,UIDiscipleController.do_protocol_2_106)
socketManager:register_receiver(2,176,UIDiscipleController.do_protocol_2_176)

UIDiscipleController:onAppStart_tianming()
UIDiscipleController:onAppStart_qizhen()
UIDiscipleController:onAppStart_cuiti()
UIDiscipleController:onAppStart_linggen()
UIDiscipleController:onAppStart_shuwu()
UIDiscipleController:onAppStart_xianmo()
UIDiscipleController:onAppStart_daoyan()
UIDiscipleController:onAppStart_spDisciple()
end

function UIDiscipleController:onEnterState()
notifySystem:listenNotify(notifyConfig.onNewGameYear,self.onNewGameYear)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.onNewMonth5am,self.onNewMonth5am)
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
isInit=false
discipleLookup:initOtherLookup()
UIDiscipleController:loadTriggerChuiweiDisciple()
UIDiscipleController:onEnterState_tianming()
UIDiscipleController:onEnterState_qizhen()
UIDiscipleController:onEnterState_cuiti()
UIDiscipleController:onEnterState_linggen()
UIDiscipleController:onEnterState_shuwu()
UIDiscipleController:onEnterState_xianmo()
UIDiscipleController:onEnterState_daoyan()
UIDiscipleController:onEnterState_spDisciple()
end

function UIDiscipleController:onProtocolReq()

local all=UIDiscipleModel:getAllDiscipleDataX()
if all then
local reqLTLsit={}
for k,v in pairs(all)do
local netData=v.netData.net
if UIDiscipleModel:canDiscipleLTAutoUpX(netData)then
reqLTLsit[#reqLTLsit+1]=netData.discipleguid
end

end
if#reqLTLsit>0 then
UIDiscipleController:requireDiscipleUpLianTiList(reqLTLsit)
end
end
timeEventController.addNormalTimerHandler(5,UIDiscipleController.name,UIDiscipleController)


if fightReport then
local str2=''
for i,v in ipairs(fightReport)do
local dis_guid=v.param_1
local fight=UIDiscipleModel:getDiscipleFightValue(dis_guid)
local t_fight=mathHelper.int64_to_number(v.param_2)
local lerp=math.abs(fight-t_fight)
if lerp>0 then
local s=FMT.fmt('弟子{0}({1}),前端战力{2},后端战力{3},相差{4}',UIDiscipleModel:getDiscipleName(dis_guid),
tostring(dis_guid),fight,t_fight,lerp)
str2=FMT.fmt('{0}{1}\n',str2,s)
end
end
if str2~=''then
fightReportStr=FMT.fmt('前后端弟子战力对比报告:\n{0}',str2)
end
fightReport=nil
end

if TeZhiTuJianController:checkSysOpen()then
local sysId=SYSTEM_DEFINE.eSpecialityBook
TeZhiTuJianController.on_system_open(sysId)
end
end

function UIDiscipleController:onLeaveState()
isInit=false
initCheckFunctions=nil
autoTakeDiscipleReward=false
dzLianTiBrokeTempLookup=nil
fightReport=nil
fightReportStr=nil
UIDiscipleModel:clearData()
notifySystem:removelistener(notifyConfig.onNewGameYear,self.onNewGameYear)
notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
notifySystem:removelistener(notifyConfig.onNewMonth5am,self.onNewMonth5am)
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
UIDiscipleController:onLeaveState_tianming()
UIDiscipleController:onLeaveState_qizhen()
UIDiscipleController:onLeaveState_cuiti()
UIDiscipleController:onLeaveState_linggen()
UIDiscipleController:onLeaveState_shuwu()
UIDiscipleController:onLeaveState_xianmo()
UIDiscipleController:onLeaveState_daoyan()
UIDiscipleController:onLeaveState_spDisciple()

UIDiscipleModel:resetAllDiscipleSign()
UIDiscipleModel.clearSpecialityLove()
end

function UIDiscipleController:onOpenView(isReconnect)
if mainControl:isInScene(eSceneType.eZongmen)then
if fightReportStr then
UIManager.serverError(fightReportStr)
fightReportStr=nil
end
end
end

function UIDiscipleController:onPlayerCreate(...)


end

function UIDiscipleController:onLostConnection()


end

function UIDiscipleController:checkInit()
return isInit==true
end

function UIDiscipleController:setInit()
isInit=true
end

function UIDiscipleController:getTaskDiscipleRewardAuto()
return autoTakeDiscipleReward
end

function UIDiscipleController:setTaskDiscipleRewardAuto(auto)
autoTakeDiscipleReward=auto
end



function UIDiscipleController:onNormalUpdate(delay)
UIDiscipleController.checkTimeUpdate()
end

function UIDiscipleController.onNewGameYear(islogin)
if not islogin then

UIDiscipleModel:checkyear_increase()
end
end

function UIDiscipleController.onNewDay5am(islogin)

UIDiscipleModel:checkday_increase()

UIDiscipleModel:setShuWuDataZero()
end

function UIDiscipleController.on_system_open(sysid)
if sysid==SYSTEM_DEFINE.eQiZhen then
reddotControl.on_change_catch_type(CATCH_TYPE.eDZQiZhenSystemOpen)
end
if sysid==SYSTEM_DEFINE.eTianMingJueXing then
UIDiscipleModel:setDiscipelDaoYanInit()
end
end

function UIDiscipleController.onNewMonth5am(islogin)
UIDiscipleController.onNewMonth5am_XianMo(islogin)
UIDiscipleController.resetDaoYanResetCount_NewMonth5AM(islogin)
end

function UIDiscipleController.onShowPrize(prizeType,rewards,effectData)
UIDiscipleController:onShowPrize_daoyan(prizeType,rewards,effectData)
end






function UIDiscipleController:requireDiscipleList()
socketManager:send_2_1()
end


function UIDiscipleController:requireRefreshDiscipleInfo(discipleID)
socketManager:send_2_3(discipleID)
end


function UIDiscipleController:requireRefreshDiscipleInfoList(discipleIDList)
if discipleIDList==nil then return end
socketManager:send_2_16(#discipleIDList,discipleIDList)
end


function UIDiscipleController:reqKickout(discipleID,isShuWuKickOut)

local discipleList={discipleID}
UIDiscipleController:reqKickoutEx(discipleList,isShuWuKickOut)
end
function UIDiscipleController:reqKickoutEx(discipleList,isShuWuKickOut)

local len=#discipleList
if len>0 then
local kickOutType=0
if isShuWuKickOut then
kickOutType=1
end

socketManager:send_2_20(len,discipleList,kickOutType)
end
end


function UIDiscipleController:requireDiscipleChangeName(discipleID,name,modtype)



socketManager:send_2_21(discipleID,name,modtype)
end


function UIDiscipleController:requireDiscipleUpLianTi(discipleID)
socketManager:send_2_22(discipleID)
end


function UIDiscipleController:requireDiscipleUpLianTiList(discipleIDList)
if discipleIDList==nil then return end
socketManager:send_2_27(#discipleIDList,discipleIDList)
end


function UIDiscipleController:reqDZRefreshOrder(discipleID,order)
socketManager:send_2_24(discipleID,order)
end


function UIDiscipleController:reqDZRefreshOrderList(len,list)



socketManager:send_2_25(len,list)
end


function UIDiscipleController:requireDiscipleSetupGF(discipleguid,pos,gongfaid)



if gongfaid>0 then
local flag=UIDiscipleController:checkdiziFG(discipleguid,pos,gongfaid)
if flag then
socketManager:send_2_41(discipleguid,pos,gongfaid)
end
else
socketManager:send_2_41(discipleguid,pos,gongfaid)
end
end


function UIDiscipleController:requireDiscipleUpGFExp(discipleID,gongfaid,moneynum)



socketManager:send_2_43(discipleID,gongfaid,moneynum)
end


function UIDiscipleController:requireDiscipleUpGF(gongfaid,guidlistlen,guidList)



socketManager:send_2_44(gongfaid,guidlistlen,guidList)
end




function UIDiscipleController:requireGiveDiscipleReward(discipleID,itemIDs)
local len=#itemIDs
if len>0 then
socketManager:send_2_69(discipleID,len,itemIDs)
roleAudioController:playRoleSpeak(discipleID,roleAudioNodeType.ChuWuDai_ZengSong)
end
end




function UIDiscipleController:requireTaskDiscipleReward(discipleID,itemID)
socketManager:send_2_70(discipleID,itemID)
roleAudioController:playRoleSpeak(discipleID,roleAudioNodeType.ChuWuDai_MoShou)
end


function UIDiscipleController:req_setup_ls(dis_guid,ls_guid)
socketManager:send_2_71(dis_guid,ls_guid)
end


function UIDiscipleController:req_takeoff_ls(dis_guid)
socketManager:send_2_72(dis_guid)
end


function UIDiscipleController:req_story_reward(dis_guid,chapterid)
socketManager:send_2_106(dis_guid,chapterid)
end


function UIDiscipleController:send_2_176(discipleguid,discipleid)
socketManager:send_2_176(discipleguid,discipleid)
end










function UIDiscipleController.do_protocol_2_1(len,list)


















































































































list=list or{}
if len>0 then
for i,v in ipairs(list)do
UIDiscipleController.changeDiscipleNetData(v)
end
end

UIDiscipleModel:initDiscipleList(list)

if not reconnectState.waitResueGame then
zongmenModel:recordHomelessData()
end

UIDiscipleModel:resetFightDiscipleGuidList()



dataControl.onDiscipleCreate()
UIDiscipleModel:setDiscipelJJDirty()
UIDiscipleModel:setDiscipelLTDirty()
UIDiscipleModel:setDiscipelDaoYanInit()
notifySystem:postNotify(notifyConfig.onDiscipleInit,list)
reddotControl.on_change_catch_type(CATCH_TYPE.eDisciple)
end

function UIDiscipleController.changeDiscipleNetData(netData)
if netData then
netData.discipleguidStr=tostring(netData.discipleguid)

netData.notfix_attrList=table.deepCopy(netData.attrList)
for i,v in ipairs(netData.attrList)do
if netData.attrList[i]<=0 then
netData.attrList[i]=1
end
end

local list={}
local initlv=cfgHelper.getdef1(cfg_discipleproskillconfig,'initlv')
for k,v in pairs(DISCIPLE_PROSKILL_TYPE)do
local s={id=v,level=initlv,exp=0}
list[v]=s
end
local templist=netData.proskillList
netData.proskillList_=templist
if templist~=nil then
for i,v in ipairs(templist)do
local temp=list[v.param_1]
if temp then
temp.level=v.param_2
temp.exp=v.param_3
end
end
end
netData.proskillList=list

local gongfaListlookup={}
if netData.gongfaList~=nil then
for i,v in ipairs(netData.gongfaList)do
gongfaListlookup[v.param_1]=v
end
end
netData.gongfaListlookup=gongfaListlookup
local gongfaUsinglookup={}
for i,v in ipairs(netData.gongfaidList)do
if v>0 then
gongfaUsinglookup[v]=i
end
end
netData.gongfaUsinglookup=gongfaUsinglookup

UIDiscipleModel.refreshDiscipleSpecialityLookup(netData)

UIDiscipleModel:initDZQiZhenData(netData)

netData.check_in=function(self_)
return not zongmenModel:isHomeless(self_.discipleguid)
end

netData.getShouYuan=function(self_)
if self_.shouyuan~=-1 then
local speciallist=UIDiscipleModel:getDiscipleSpecialityConfigByData(self_,true)

if speciallist then
for k,v in ipairs(speciallist)do
if v.typo==2 then
if v.id==28 or v.id==29 then
return-1
end
end
end
end






if self_.jingjielv>90 then
return-1
end
end
return self_.shouyuan
end

local jjexp=netData.jingjieexp
if jjexp~=nil and type(jjexp)~='number'then
jjexp=mathHelper.int64_to_number(jjexp)
netData.jingjieexp=jjexp
end
end
end


function UIDiscipleController.changeDiscipleData2(dzData,actorId)
if dzData==nil then return end

UIDiscipleController.changeDiscipleNetData(dzData.base)
dzData.actorId=actorId
local baseData=dzData.base
local discipleguidStr=tostring(baseData.discipleguid)
dzData.discipleguidStr=discipleguidStr

local fightValNum=nil
for i,v in ipairs(dzData.attrList)do
if v.param_1==eAttributeTypeEx.eFight then
fightValNum=v.param_2
end
end
dzData.fightValNum=fightValNum
dzData.fightValNum_get=function(self_)
local disguid=self_.base.discipleguid
if UIDiscipleModel:isMyActorDZ(disguid)then
return UIDiscipleModel:getDiscipleFightValue(disguid)
else
return self_.fightValNum or mathHelper.int64_to_number(self_.base.fightvalue)
end
end

local post=UIDiscipleModel:getDisciplePostEX(baseData)
dzData.color=UIDiscipleModel:getDiscipleBaseAttrSum2ColorEx(post,baseData.attrList)

if dzData.lingshouList~=nil then
for i,lsData in ipairs(dzData.lingshouList)do
lingshouController.changeLSNetData(lsData)
lingshouModel:initAttrLookup(lsData)
end
end

local fightEquipList=baseData.fightEquipList
if fightEquipList then
local equipList={}
for i,v in pairs(fightEquipList)do
local equip=v
local itemconfig=itemsConfig.getConfig(equip.itemid)
if itemconfig then
local equipType=itemconfig.type1
equipList[equipType]=v
end
end
local fabaoList=baseData.fabaoList or{}
equipList[EQUIP_TYPE.eFabao]=fabaoList[1]

local daobingList=baseData.daobingList or{}
equipList[EQUIP_TYPE.eDaoBing]=daobingList[1]
dzData.fightEquipList=equipList
end

end


function UIDiscipleController.do_protocol_2_2(discipleInfo)


if discipleInfo==nil then return end


UIManager:callWindowFunc('UIRecruitSelectWin','finishReq')

local dzid_old=nil
local guid=discipleInfo.discipleguid
local netData_old=UIDiscipleModel:getMyDiscipleData2(guid)
if netData_old~=nil then
dzid_old=netData_old.id
end

UIDiscipleController.changeDiscipleNetData(discipleInfo)
local f=UIDiscipleModel:addDiscipleData(discipleInfo)

local isNew=not f
if isNew then
mountModel:addNewDZ(discipleInfo,true)
equipsModel.addNewDizi(discipleInfo)
fabaoModel.addNewDizi(discipleInfo,true)
UIFuLuFangModel:addFuBaoData(discipleInfo)
daobingModel:addNewDizi(discipleInfo,true)

ClothingModel:addNewDizi(discipleInfo)
vocEquipModel:addNewDizi(discipleInfo)

zongmenModel:setHomelessRecord(guid,true)



discipleStateManager:createRoleEx(guid,mapIdType.zhufeng)
UIDiscipleModel:setDiscipelJJDirty()
UIDiscipleModel:setDiscipelLTDirty()
dataControl.onDiscipleCreate()

notifySystem:postNotify(notifyConfig.onDiscipleCreate,guid)
reddotControl.on_change_catch_type(CATCH_TYPE.eDisciple)

webGLHelper:gameBehaviorReport('zqzs_game_zhaomu_every_1')
end
UIDiscipleModel:resetFightDiscipleGuidList()


local job=UIDiscipleModel:getDiscipleJobByData(discipleInfo)


if isNew and discipleSrcType:isItem(discipleInfo.srctype)then
local itemId=discipleInfo.srctype
local funcparam=itemsConfig.getConfig(itemId).funcparam
local itemType=funcparam.type
if itemType==item_funtion_type.disciple then

if funcparam.isSpecial then

local win2=UIManager:findActiveWindow('UISubAct_tujiandiziWin')
if win2 then
UIRecruitModel:addShowRecruitDiscipleQueue(guid,itemId)
UIRecruitControl:checkItemRecruitShowQueueAndShow(false)
else

local win=UIManager:findActiveWindow('UIItemRecruitDiscipleWin')
if win then

win:onRoot()
end

local win=UIManager:findActiveWindow('UISevenDaySignInWin')
if win then

local signInCfg=cfgHelper.get(cfg_sevendayqiandaoconfig_get,1)
local showStoryPram=signInCfg.showStoryPram
if showStoryPram and showStoryPram[2]then
local checkItemId=showStoryPram[1]
local storyBehaviorName=showStoryPram[2]
if itemId==checkItemId then

local callBack=function()
UIRecruitControl:showItemRecruitDiscipleWindow(itemId,guid)
end


return jumpManager:jump({type=0,id=JUMP_TYPE.eMain},function()

return storyAIManager:startStoryBehavior(storyBehaviorName,nil,callBack)
end)
end
end
end

if UIRecruitControl:checkAnimArgs(itemId)then

if not UIManager:findActiveWindow('UISubAct_xianshichouka_rewardWin')and
not UIManager:findActiveWindow('UIXianYuanXunFangRewardWin')and
not UIManager:findActiveWindow('UISubAct_ZMXiuXing_Win')and
not UIManager:findActiveWindow('UISubAct_ZMXX_HW_Win')and
not UIManager:findActiveWindow('UIXianYuanXunFangSelectWin')then

UIRecruitControl:showItemRecruitDiscipleWindow(itemId,guid)
end
else

UIRecruitControl:showItemRecruitDiscipleWindow(itemId,guid)
end
end
else

UIRecruitControl:itemRecruitRecord(discipleInfo,discipleInfo.srctype)
end
elseif itemType==item_funtion_type.selectDisciple then

UIRecruitModel:addShowRecruitDiscipleQueue(guid,itemId)
UIRecruitControl:checkItemRecruitShowQueueAndShow(false)
end
elseif discipleInfo.srctype==discipleSrcType.eAppointment then
local win=UIManager:findActiveWindow('UIItemRecruitDiscipleWin')
if win then
win:onRoot()
end
UIRecruitControl:showItemRecruitDiscipleWindow(nil,guid)
end

if dzid_old~=discipleInfo.id then
notifySystem:postNotify(notifyConfig.onDiscipleNewID,guid,discipleInfo.id,discipleInfo.srctype)
end


local type=addSpeType.item
TeZhiTuJianModel:checkIsHaveSpeCanActive(discipleInfo,type,1,nil,guid)
end


function UIDiscipleController.do_protocol_2_4(args)








if not isInit then return end
local discipleguid=args[1]
local jingjielv=args[2]
local jingjieexp=args[3]

jingjieexp=mathHelper.int64_to_number(jingjieexp)
local jingjierate=args[4]
local jingjietimes=args[5]
local dujiesoulnum=args[6]
local checktm=args[7]
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end
local old_jjlv,old_point=UIDiscipleModel:getDiscipleJJLevelAndPoint(discipleguid)
local old_jjexp=UIDiscipleModel:calculationJJExpByData(netData)
local old_jingjierate=netData.jingjierate
local old_jingjietimes=netData.jingjietimes
local old_changeRate
local checkRate=false
local checkRate2=false
for i,v in ipairs(old_jingjierate)do
if v~=jingjierate[i]then
checkRate2=true
end
end
if not UIDiscipleModel:checkJJFullFloorEx(discipleguid)then
if old_jingjietimes~=jingjietimes then
checkRate=true
else
checkRate=checkRate2
end
end
if checkRate then

old_changeRate=UIDiscipleModel:getDuJieFailRate(discipleguid)

end
netData.jingjielv=jingjielv
netData.jingjieexp=jingjieexp
netData.checktm=checktm
netData.jingjierate=jingjierate
netData.jingjietimes=jingjietimes
netData.dujiesoulnum=dujiesoulnum
if old_jjlv~=jingjielv then
UIDiscipleModel:setDiscipelJJDirty()
end
dataControl.onDiscipleJJChange()
local changeRate
if checkRate then

changeRate=UIDiscipleModel:getDuJieFailRate(discipleguid)

end

local jjlv,point=UIDiscipleModel:getDiscipleJJLevelAndPoint(discipleguid)
local oldFight=UIDiscipleModel:getFight(discipleguid)
if old_jjlv~=jingjielv or old_point~=point then
local showTips=UIDiscipleModel:checkNextJJNeedBroke(old_jjlv)and old_jjlv~=0
UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eJingJie,showTips)
end
if old_jjlv~=jingjielv then
if UIDiscipleModel:isShuWuDisciple(netData.id)then
UIDiscipleModel:recordShuWuLastFightValue(discipleguid)
UIDiscipleModel:setShuWuFightValueDirty(discipleguid)
end
end
local newFight=UIDiscipleModel:getFight(discipleguid)

if old_jjlv~=jingjielv or old_jjexp~=jingjieexp then

notifySystem:postNotify(notifyConfig.onDiscipleJJChange,discipleguid,old_jjlv,jingjielv,old_jjexp,jingjieexp,oldFight,newFight)
reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleJJ,discipleguid,old_jjlv,jingjielv,old_jjexp,jingjieexp)
end
if checkRate and old_changeRate~=changeRate then

notifySystem:postNotify(notifyConfig.onDiscipleJJRate,discipleguid,old_changeRate,changeRate)
end
if checkRate2 then
notifySystem:postNotify(notifyConfig.onDiscipleJJRate2,discipleguid,old_jingjierate,jingjierate)
end
end


function UIDiscipleController.do_protocol_2_5(discipleguid,proskillInfo)






local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData then
local temp=netData.proskillList[proskillInfo.param_1]
local oldlv=temp.level
local oldexp=temp.exp
temp.level=proskillInfo.param_2
temp.exp=proskillInfo.param_3
if oldlv~=temp.level then
UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eJingJie)
UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eLianTi)
end
if oldlv~=temp.level or oldexp~=temp.exp then
notifySystem:postNotify(notifyConfig.onDiscipleJobChange,discipleguid,proskillInfo.param_1,oldlv,temp.level,oldexp,temp.exp)
end
end
end


function UIDiscipleController.do_protocol_2_6(discipleguid,state)



local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData then
local old=netData.state
netData.state=state
UIDiscipleModel:onDiscipleStateChange(discipleguid,old,state)
end
end


function UIDiscipleController.do_protocol_2_7(discipleguid,injury)



local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData then
local old=netData.injury
netData.injury=injury

local old_injuryType=eInjuryType.getType(old)
local new_injuryType=eInjuryType.getType(injury)
if old_injuryType~=new_injuryType then
UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eInjury)
end
if old~=injury then
dzSpecialityEffectManager.onDiscipleInjuryChange(discipleguid)
notifySystem:postNotify(notifyConfig.onDiscipleInjuryChange,discipleguid,old,injury)
end
end
end


function UIDiscipleController.do_protocol_2_8(discipleguid,pos)



local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData then
local old=netData.pos
netData.pos=pos
UIDiscipleModel:refreshDiscipleZongMenPost(netData.discipleguidStr,old,pos)
if old~=eZongMenPostType.eWaiMen then
UIManager:invokeUIMethod('UISectPalacePostWin','rec_changepost',discipleguid,old)
end
if pos~=eZongMenPostType.eWaiMen then

AudioManager.playAudio(538)
UIManager:invokeUIMethod('UISectPalacePostWin','rec_changepost',discipleguid,pos)
end
dzSpecialityEffectManager.onDisciplePosChange(discipleguid)
notifySystem:postNotify(notifyConfig.onDisciplePosChange,discipleguid,old,pos)

local posCheck=cfgHelper.getdef2(cfg_guildposconfig,"checkPlot",pos)

if posCheck then




local talkList=posCheck
local randomIdx=math.random(#talkList)

UIFullStoryBoardControl:showPlotBoardWindow({dis_guid=discipleguid,groupid=talkList[randomIdx]},false)

end
end
end


function UIDiscipleController.do_protocol_2_9(discipleguid,liantilv,liantiexp)




local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end
local discipleguidStr=netData.discipleguidStr
local old_lv=netData.liantilv
local old_exp=netData.liantiexp
netData.liantilv=liantilv
netData.liantiexp=liantiexp
if liantilv~=old_lv then
UIDiscipleModel:setDiscipelLTDirty()
end

UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eLianTi,true)
if UIDiscipleModel:canDiscipleLTAutoUp(discipleguid)and tostring(discipleguid)~=UIDiscipleController.skipUpdataDiscipleAutoBroke then
local temp
if dzLianTiBrokeTempLookup and dzLianTiBrokeTempLookup[discipleguidStr]then
if dzLianTiBrokeTempLookup[discipleguidStr][liantilv]~=nil then
temp=true
end
end
if temp==nil then
if dzLianTiBrokeTempLookup==nil then
dzLianTiBrokeTempLookup={}
end
if dzLianTiBrokeTempLookup[discipleguidStr]==nil then
dzLianTiBrokeTempLookup[discipleguidStr]={}
end
dzLianTiBrokeTempLookup[discipleguidStr][liantilv]=true

UIDiscipleController:requireDiscipleUpLianTi(discipleguid)
end
end

if old_lv~=liantilv or old_exp~=liantiexp then

notifySystem:postNotify(notifyConfig.onDiscipleLTChange,discipleguid,old_lv,liantilv,old_exp,liantiexp)

reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleLT,discipleguid,old_lv,liantilv,old_exp,liantiexp)
end
UIManager:invokeUIMethod('UIDiscipleLianTiWin','rec_upback',old_lv,liantilv)
end


function UIDiscipleController.do_protocol_2_10(discipleguid,attrid,attrvalue)




local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end
if attrvalue==nil then return end
local old=netData.attrList[attrid]
local cur=attrvalue
if cur<=0 then
cur=1
end
netData.notfix_attrList[attrid]=attrvalue
netData.attrList[attrid]=cur

if old~=cur then
UIDiscipleModel:setBaseAttrBaseDirty(netData)
UIDiscipleModel:setDiscipleImageDirty(netData)
UIDiscipleModel:setDiscipleBaseAttrExDirty(netData)
if attrid==DISCIPLE_BASE_ATTR_TYPE.eQianLi then
UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eLianTi,true)
UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eJingJie,true)
end
if UIDiscipleModel:isShuWuDisciple(netData.id)then
UIDiscipleModel:setShuWuFightValueDirty(discipleguid)
end
notifySystem:postNotify(notifyConfig.onDiscipleSixAttrChange,discipleguid,attrid,old,cur)
end
end


function UIDiscipleController.do_protocol_2_11(discipleguid,loyalty)



local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end
local old=netData.loyalty
netData.loyalty=loyalty
if old~=loyalty then
notifySystem:postNotify(notifyConfig.onDiscipleLoyaltyChange,discipleguid,old,loyalty)
end
end


function UIDiscipleController.do_protocol_2_12(discipleguid,shouyuan)



local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end
local old=netData.shouyuan
netData.shouyuan=shouyuan
if old~=shouyuan then
notifySystem:postNotify(notifyConfig.onDiscipleShouYuanChange,discipleguid,old,shouyuan)
end
end


function UIDiscipleController.do_protocol_2_13(discipleguid,updatetype,specialitystruct)



local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end

local specialitytype=specialitystruct.specialitytype
local specialityinfo=specialitystruct.specialityInfo
local specialityid=specialityinfo.param_1



local change=UIDiscipleModel:updateSpeciality(netData,updatetype,specialitystruct)
if change then
UIDiscipleModel:updateDZSpeTimePass(netData)
UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eSpecial)
dzSpecialityEffectManager.onDiscipleSpecialityChange(discipleguid)
notifySystem:postNotify(notifyConfig.onDiscipleSpecialityChange,discipleguid,specialitytype,specialityid,updatetype)
end



end


function UIDiscipleController.do_protocol_2_14(discipleguid,jingjiesatiety)



local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end

local old=netData.jingjiesatiety
netData.jingjiesatiety=jingjiesatiety
notifySystem:postNotify(notifyConfig.onDiscipleSatietyChange,discipleguid,old,jingjiesatiety)
end


function UIDiscipleController.do_protocol_2_15(discipleguid,relationType,len,valueList)


UIDiscipleModel:onUpdateRelation(discipleguid,relationType,len,valueList)
end

function UIDiscipleController.do_protocol_2_17(discipleInfo,awakeLv)
local oldData=UIDiscipleModel:getDiscipleData(discipleInfo.discipleguid)
UIDiscipleController.do_protocol_2_2(discipleInfo)
notifySystem:postNotify(notifyConfig.onDiscipleAwake,discipleInfo.discipleguid,oldData)
end


function UIDiscipleController.do_protocol_2_20(len,discipleList)


if len>0 then
local showTips=len==1
for i,discipleguid in ipairs(discipleList)do
UIDiscipleController.do_protocol_2_20_ex(discipleguid,showTips)
end
if not showTips then
UIManager.info('弟子逐出成功')
end
UIManager:invokeUIMethod('UIShuWuKickoutWin','rec_kickout',discipleList)
reddotControl.on_change_catch_type(CATCH_TYPE.eDisciple)
else
UIManager.error('弟子不可逐出')
UIManager:invokeUIMethod('UIShuWuKickoutWin','rec_kickoutFail')
end
end

function UIDiscipleController.do_protocol_2_20_ex(discipleguid,showTips)
if showTips then
local state=UIDiscipleModel:getDiscipleState(discipleguid)
if state==DISCIPLE_STATE_TYPE.eChuiWei then
UIManager.info('弟子已坐化')
else
UIManager.info('弟子逐出成功')
end
end

UIDiscipleModel.deleDiziReleation(discipleguid)
mountModel:deleDZ(discipleguid)
equipsModel.deleDiziEquip(discipleguid)
fabaoModel.deleDizi(discipleguid)
daobingModel:deleDizi(discipleguid)
ClothingModel:deleDizi(discipleguid)
vocEquipModel:deleDizi(discipleguid)
UIDiscipleModel:setDiscipelJJDirty()
UIDiscipleModel:setDiscipelLTDirty()
UIDiscipleModel:resetFightDiscipleGuidList()

discipleStateManager:removeRole(discipleguid)

zongmenModel:setHomelessRecord(discipleguid,nil)

UIDiscipleModel:removeCheckXianMoDisciple(discipleguid)

dataControl.onDiscipleRemove()

local flag=UIDiscipleModel:removeDiscipleData(discipleguid)
UIManager:invokeUIMethod('UIRecruitSelectWin','SetRecruitState',discipleguid,-1)

notifySystem:postNotify(notifyConfig.onDiscipleRemove,discipleRemoveReason.eKickout,discipleguid)
end


function UIDiscipleController.do_protocol_2_21(discipleguid,name,modtype,ret)




UIManager:invokeUIMethod('UIDiscipleChangeNameWin','onChanageNameBack',ret)
if ret==0 then
UIManager.info('赐名成功')
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end
local oldName=netData.disciplename
netData.namemod=1
netData.disciplename=name
UIManager:closeWindow('UIDiscipleChangeNameWin')
notifySystem:postNotify(notifyConfig.onDiscipleNameChange,discipleguid,oldName,name)
else
local log_str=changeNameLog:getlog(ret)
UIManager.error(log_str)



end
end


function UIDiscipleController.do_protocol_2_22(discipleguid,liantilv,liantiexp)




local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end
local old_lv=netData.liantilv
local old_exp=netData.liantiexp
netData.liantilv=liantilv
netData.liantiexp=liantiexp

if old_lv~=liantilv then
UIDiscipleModel:setDiscipelLTDirty()
end
UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eLianTi,true)
if old_lv~=liantilv or old_exp~=liantiexp then

notifySystem:postNotify(notifyConfig.onDiscipleLTChange,discipleguid,old_lv,liantilv,old_exp,liantiexp)
end
UIManager:invokeUIMethod('UIDiscipleLianTiWin','rec_brokeback')
end


function UIDiscipleController.do_protocol_2_27(len,list)




if len>0 then
for i,v in ipairs(list)do
UIDiscipleController.do_protocol_2_22(v.param_1,v.param_2,v.param_3)
end
end
end


function UIDiscipleController.do_protocol_2_24(discipleguid,order)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end

local old=netData.order
netData.order=order
if old~=order then
notifySystem:postNotify(notifyConfig.onDiscipleOrderChange,discipleguid,old,order)
end
end


function UIDiscipleController.do_protocol_2_25(len,list)



if len>0 then
for i,v in ipairs(list)do
local netData=UIDiscipleModel:getDiscipleData(v.param_1)
if netData then
local order=v.param_2
local old=netData.order
netData.order=order
if old~=order then
notifySystem:postNotify(notifyConfig.onDiscipleOrderChange,discipleguid,old,order)
end
end
end
end
end


function UIDiscipleController.do_protocol_2_41(discipleguid,pos,gongfaid)




local oldpos=UIDiscipleModel:discipleSetupGongFa(discipleguid,pos,gongfaid)
dataControl.onDiscipleGFChange()
lingshouModel:setAttrListDirtyXByDzGuid(discipleguid,lingshouAttributeType.eDzGongFa,true)

UIManager:invokeUIMethod('UIDiscipleGFSetupWin','rec_setupGF',pos,gongfaid,oldpos)
UIManager:invokeUIMethod('UIDiscipleSkillInfoWin','rec_setupGF',pos,gongfaid,oldpos)
UIManager:invokeUIMethod('UIGongFaDiscipleInfoWin','rec_setupGF',pos,gongfaid,oldpos)
if oldpos~=nil and oldpos~=pos then
notifySystem:postNotify(notifyConfig.onDiscipleGongFaChange,discipleguid,oldpos,0)
end
notifySystem:postNotify(notifyConfig.onDiscipleGongFaChange,discipleguid,pos,gongfaid)
end


function UIDiscipleController.do_protocol_2_42(discipleguid,gongfaid,lv,exp)





local discipleGFNetData=UIDiscipleModel:getDiscipleGFData(discipleguid,gongfaid)
if discipleGFNetData==nil then



return
end

local oldlv=discipleGFNetData.param_2
discipleGFNetData.param_2=lv
discipleGFNetData.param_3=exp

if oldlv~=lv then
if UIGongFaModel:checkGFHasBDSkill(gongfaid)then
UIDiscipleModel:setDiscipleAttrListDirtyX(discipleguid,DISCIPLE_ATTRIBUTE_TYPE.eGongFa,true)
UIDiscipleModel:setSkillLvPlusLookupDirty(discipleguid,false)
end
notifySystem:postNotify(notifyConfig.onDiscipleGongFaLevelUp,discipleguid,gongfaid,oldlv,lv)
lingshouModel:setAttrListDirtyXByDzGuid(discipleguid,lingshouAttributeType.eDzGongFa,true)
end

UIManager:invokeUIMethod('UIGongFaDiscipleInfoWin','rec_upGF',gongfaid,oldlv,lv)
UIManager:invokeUIMethod('UIGongFaUpWin','rec_upGF',gongfaid,oldlv,lv)
UIManager:invokeUIMethod('UIGongFaTipsWin','rec_upGF',gongfaid,oldlv,lv)
UIManager:invokeUIMethod('UIDiscipleSkillInfoWin','rec_upGF',gongfaid,oldlv,lv)
UIManager:invokeUIMethod('UIDiscipleGFSetupWin','rec_upGF',gongfaid,oldlv,lv)
end


function UIDiscipleController.do_protocol_2_69(discipleguid,len,items)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end

if netData.disciplebag_len<=0 then
netData.disciplebagList={}
end

local lookup={}
local addValue=0
for i,v in ipairs(items or{})do
lookup[v]=(lookup[v]or 0)+1
local itemCfg=itemsConfig.getConfig(v)
if itemCfg and itemCfg.loyal_conf then
addValue=addValue+itemCfg.loyal_conf[1]
else
logErr(FMT.fmt("不应该被赏赐予弟子的物品：{0}",v))
end
end
for i,v in ipairs(netData.disciplebagList)do
if lookup[v.param_2]then
v.param_1=v.param_1+lookup[v.param_2]
lookup[v.param_2]=nil
end
end
for i,v in pairs(lookup)do
table.insert(netData.disciplebagList,{param_1=v,param_2=i})
netData.disciplebag_len=netData.disciplebag_len+1
end

notifySystem:postNotify(notifyConfig.onDiscipleBagAddItem,discipleguid,items)
lingshouModel:setAttrListDirtyXByDzGuid(discipleguid,lingshouAttributeType.eDzGongFa,true)
end


function UIDiscipleController.do_protocol_2_70(discipleguid,itemid)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end

for i=netData.disciplebag_len,1,-1 do
local v=netData.disciplebagList[i]

if v.param_2==itemid then
v.param_1=v.param_1-1

if v.param_1<=0 then
netData.disciplebag_len=netData.disciplebag_len-1
table.remove(netData.disciplebagList,i)
end
break
end
end

local itemCfg=itemsConfig.getConfig(itemid)
local deleteValue=0
if itemCfg and itemCfg.loyal_conf then
deleteValue=itemCfg.loyal_conf[2]
end

notifySystem:postNotify(notifyConfig.onDiscipleBagDeleteItem,discipleguid,itemid)
end


function UIDiscipleController.do_protocol_2_71(dizi_guid,ls_guid)
local netData=UIDiscipleModel:getDiscipleData(dizi_guid)
if netData==nil then return end

local lastVal=netData.calculationFight or 0
local o_ls_guid=netData.lingshou_guid
netData.lingshou_guid=ls_guid

local va=mathHelper.validInt64(o_ls_guid)
local vb=mathHelper.validInt64(ls_guid)

local attrTypeList={lingshouAttributeType.eDJob,lingshouAttributeType.eDzGongFa}
if va and vb then

lingshouModel:onTakeOffLingShou(dizi_guid)
lingshouModel:onDressLingShou(dizi_guid,ls_guid)
lingshouModel:setAttrListDirtyX2(ls_guid,attrTypeList,true)
lingshouModel:setAttrListDirtyX2(o_ls_guid,attrTypeList,true)
notifySystem:postNotify(notifyConfig.onDiscipleLingShouChange,dizi_guid,eEquipChangeType.eReplace,o_ls_guid,ls_guid)
elseif vb then

lingshouModel:onDressLingShou(dizi_guid,ls_guid)
lingshouModel:setAttrListDirtyX2(ls_guid,attrTypeList,true)
notifySystem:postNotify(notifyConfig.onDiscipleLingShouChange,dizi_guid,eEquipChangeType.eSetup,ls_guid)
elseif va then

lingshouModel:onTakeOffLingShou(dizi_guid)
lingshouModel:setAttrListDirtyX2(o_ls_guid,attrTypeList,true)
notifySystem:postNotify(notifyConfig.onDiscipleLingShouChange,dizi_guid,eEquipChangeType.eRemove,o_ls_guid)
end

local val=netData.calculationFight or 0
local isChanged=lastVal~=val
if isChanged then

notifySystem:postNotify(notifyConfig.onDiscipleFightChanged,netData.discipleguid,lastVal,val,DISCIPLE_ATTRIBUTE_TYPE.eEquip)
end
end


function UIDiscipleController.do_protocol_2_72(dizi_guid)
local netData=UIDiscipleModel:getDiscipleData(dizi_guid)
if netData==nil then return end
local o_ls_guid=netData.lingshou_guid
netData.lingshou_guid=int64.new('0')
local va=mathHelper.validInt64(o_ls_guid)
if va then

lingshouModel:onTakeOffLingShou(dizi_guid)
notifySystem:postNotify(notifyConfig.onDiscipleLingShouChange,dizi_guid,eEquipChangeType.eRemove,o_ls_guid)
lingshouModel:setAttrListDirtyX3(dizi_guid,o_ls_guid,{lingshouAttributeType.eDJob,lingshouAttributeType.eDzGongFa},true)
end
end


function UIDiscipleController.do_protocol_2_100(len,list)





if len>0 then
fightReport=list
else
fightReport=nil
end
end


function UIDiscipleController.do_protocol_2_106(dzguid,chapterid)
local netdata=UIDiscipleModel:getDiscipleData(dzguid)
netdata.bsflag=bitHelper.set_1(netdata.bsflag,chapterid-1)


end


function UIDiscipleController.do_protocol_2_176(args1,args2,args3)
UIDiscipleModel:changeDiscipleimageVoc(args1,args2,args3)
end

function UIDiscipleController:testttt(discipleguid)
local net=UIDiscipleModel:getDiscipleData(int64.new(discipleguid))

end







function UIDiscipleController:jumpToDiscipleStatePos(guid,closeUICallBack)
if MysteryModel:is_enter_Mystery()then

UIManager.error("当前正处于副本中")
return
end

local isCloseUI=false
local state=UIDiscipleModel:getDiscipleState(guid)
if state==DISCIPLE_STATE_TYPE.edsDispatch then

local taskKey=worldTaskModel:findTaskKey_ByDiscipleGUID(guid)
if taskKey then
local task=worldTaskModel:getTask(taskKey)
if task.target_type==eWorldUnitTpye.MYSTERY then


local fbId=task.target_id

local iscatmj=false
local cat_sysid=SYSTEM_DEFINE.eCatCatMiJing
if systemModel.isOpen(cat_sysid)then
local ptMiJing=cfg_catcatmijingbaseconfig_get(1).ptMiJing
for k,v in ipairs(ptMiJing)do
if v==fbId then
iscatmj=true
end
end
end
if iscatmj then
UIManager:showWindow("UIWanBaoXunBaoDui_MiJinWin")
else
local mysterySenceType=MysteryModel:get_mystery_sence_type(fbId)
local finishCallback=nil
local targetPram=nil
if mysterySenceType==MysterySenceType.ZongMen then

local cfg_fb=cfg_secretscenefubenconfig_get(fbId)
local sfId=cfg_fb.sceneParam[1]

local targetPos_x=cfg_fb.sceneParam[2]
local targetPos_y=cfg_fb.sceneParam[3]

targetPram={cameraMoveTargetType.eZongmeng_pos,{targetPos_x,targetPos_y}}
finishCallback=function(flag_)
if flag_ then
jumpManager:jump({id=JUMP_TYPE.eZongmenMystery,args={fbId=fbId}})
end
end
cameraMoveController:Begin({eSceneType.eZongmen,sfId},targetPram,finishCallback)
elseif mysterySenceType==MysterySenceType.World then

local posData=MysteryModel:get_mysteryFB_unit(fbId)
local wdId=posData[1]

finishCallback=function(flag_)
if flag_ then
if UIManager:isActive("UIMysteryEnterWin")then
UIManager:invokeUIMethod("UIMysteryEnterWin","onShow",{id=fbId})
else

MysteryController:openEnterWin(fbId)
end
if posData then
if worldModel:isSameWorld(posData[1])then
local key=worldModel:convertUnitKey({worldModel.UNITTYPE.MYSTERY,fbId})
if key then
worldController:lookAtUnit(key)
end
else
local position=worldPositionConfig:getPosition(posData[1],{posData[2],posData[3]})
local args={lookAt=position,}
worldController:enterWorld(posData[1],args)
end
end
end
end

isCloseUI=true
if closeUICallBack then
closeUICallBack()
end

cameraMoveController:Begin({eSceneType.eWorld,wdId},nil,finishCallback)
elseif mysterySenceType==MysterySenceType.ZiYuan then

local group=mysteryZiYuanFuBenModel:getZiYuanGroupByFbid(fbId)
if group then
local tagTable={group[1],group[2]}
local key=table.concat(tagTable,'-')
local posData=mysteryZiYuanFuBenModel:get_mysteryFB_unit(key)
local wdId=posData[1]

finishCallback=function(flag_)
if flag_ then
mysteryZiYuanFuBenController:jumpToMystery(group[1])
end
end

isCloseUI=true
if closeUICallBack then
closeUICallBack()
end

cameraMoveController:Begin({eSceneType.eWorld,wdId},nil,finishCallback)
end
end
end
elseif task.target_type==eWorldUnitTpye.TOURPOINT then

local sfId=mapIdType.zhufeng
local bdData=zongmenModel:findBuildingDataByType(sfId,SLG_SYSTEM_TYPE.eChuanSongZhen)
local callBack=function()
UIFullDiscipleMainControl:checkLinkRoadToOpenBuilding(sfId,bdData.un_build_id,{travel=task.target_id})
end
local targetPos_x=bdData.x
local targetPos_y=bdData.y
local sfCallBack=function(flag_)
if flag_ then

local temppos=_MapManager.ToVector3Int(targetPos_x,targetPos_y,0)
local mapId=zongmenModel:getMountainId()
local pos=_MapManager.GetCellCenterWorld(mapId,temppos,mapLayer.Data)
isometricMapSystem:moveCameraToPosition(pos,true,callBack)
end
end

cameraMoveController:Begin({eSceneType.eZongmen,sfId},nil,sfCallBack)
elseif task.target_type==eWorldUnitTpye.EXPERIENCE then

local finishCallback=function(flag_)
if flag_ then

local fogId=task.target_id
local fogCfg=cfgHelper.get1(cfg_worldfogconfig_get,fogId)
local world=fogCfg.world
local block=fogCfg.block
if task.progress_state==eWorldTripProgress.Work then
worldExperienceController:enterExperience()
elseif task.progress_state==eWorldTripProgress.Go then
UIManager.info("弟子正在前往")
elseif task.progress_state==eWorldTripProgress.Back then

worldExperienceController:readyTaskExperience(world,block)
end
end
end
cameraMoveController:Begin({eSceneType.eWorld,task.world},nil,finishCallback)
elseif task.target_type==eWorldUnitTpye.MONSTER or task.target_type==eWorldUnitTpye.RESPOINT or task.target_type==eWorldUnitTpye.FAMILY then

local pos={task.destination.x,task.destination.y}


if worldModel:isSameWorld(task.world)then
local position=Vector2.New(pos[1],pos[2])
worldController:lookAtPoint(position)
else
local position=worldPositionConfig:getPosition(task.world,{pos[1],pos[2]})
local args={lookAt=position,}
worldController:enterWorld(task.world,args)
end
elseif task.target_type==eWorldUnitTpye.HUNTMONSTERTEAM then
local finishCallback=function(flag_)
if flag_ then
local teamData=huntMonsterTeamModel:getTeamData(task.world)
if teamData then
if not huntMonsterTeamModel:isTeamComplete(teamData)then
local curMonster=huntMonsterTeamModel:getCurrentMonster(teamData)
worldController:lookAtUnit(curMonster)
return
end
end
worldController:changeLeftView("UIWorldUnitListWin2",{tab=2,extra={world=task.world,showhunt=true}})
end
end
cameraMoveController:Begin({eSceneType.eWorld,task.world},nil,finishCallback)
end
else
loggerUtil.logErrFMT("弟子在派遣状态但没有对应的派遣数据")
end
elseif state==DISCIPLE_STATE_TYPE.eQianRu or state==DISCIPLE_STATE_TYPE.eBeiBu then


local zmData=systemZongMenModel:findInfoDataByDisciple(guid)
if zmData then
local pos={zmData.position.x,zmData.position.y,zmData.position.z}

local finishCallback=function(flag_)
if flag_ then

local unitKey=systemZongMenModel:convertUnitKey(zmData.serial)
worldController:clickUnit(unitKey)
end
end

local targetPram={cameraMoveTargetType.eWorld_pos,pos}

cameraMoveController:Begin({eSceneType.eWorld,zmData.worldId},targetPram,finishCallback)
else
return
end
elseif state==DISCIPLE_STATE_TYPE.eWuDao or state==DISCIPLE_STATE_TYPE.eWuDaoRuMo then
UIFullWuDaoTangControl:showMyWindowEx()
else

local bdData=zongmenModel:getDiscipleWorkroom(guid)
if bdData then

local sfId=zongmenModel:getBuildingLocationMapId(bdData.un_build_id)


local callBack=function()
if bdData.build_id==SLG_SYSTEM_TYPE.eXianZhan then

if xianzhanModel:isBuildingModel()then return end
UIManager:showWindow('UIXianZhanManagerWin',{mapIdType.zhufeng,bdData,bdData.dizi_id})
else
UIFullDiscipleMainControl:checkLinkRoadToOpenBuilding(sfId,bdData.un_build_id)
end
end

local targetPos_x=bdData.x
local targetPos_y=bdData.y

if bdData.build_id==SLG_SYSTEM_TYPE.eXianZhan then

sfId=mapIdType.xianzhan

targetPos_x=-29
targetPos_y=0
end

local sfCallBack=function(flag_)
if flag_ then

local temppos=_MapManager.ToVector3Int(targetPos_x,targetPos_y,0)
local mapId=zongmenModel:getMountainId()
local pos=_MapManager.GetCellCenterWorld(mapId,temppos,mapLayer.Data)
isometricMapSystem:moveCameraToPosition(pos,true,callBack)
end
end

cameraMoveController:Begin({eSceneType.eZongmen,sfId},nil,sfCallBack)
else

return
end
end

if not isCloseUI and closeUICallBack then
closeUICallBack()
end
end



function UIDiscipleController:checkdiziFG(discipleguid,pos,gongfaid)
local gfCfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gongfaid)
if gfCfg and gfCfg.factionmax and gfCfg.faction then
local hasnum=1
local maxnum=gfCfg.factionmax
local faction=gfCfg.faction
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
local usingGFList=UIDiscipleModel:getDiscipleUsingGFList(netData)
for idx=1,2 do
local gfID=usingGFList[idx]
if gfID>0 then
local gfCfg2=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)
if gfCfg2.faction and gfCfg2.faction==faction then
hasnum=hasnum+1
end
end
end
if hasnum>maxnum then
local name=cfgHelper.get2(cfg_factiontypeconfig_get,faction,'name')
UIManager.info(FMT.fmt("{0}功法只能同时装备1个",name))
return false
end
end
return true
end
