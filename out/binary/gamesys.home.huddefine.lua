



local _iconIndexs={
root=0,
icon=1,
click=2,
progressbar=3,
progressbarbg=4,
iconbg=5,
natural_root=3,
}

local _hudAtlasAB='ui/windows/hud/hud_sprite_atlas_pak.ab'
local _hudysfAB='ui/sharedtextures/uiglobalspriteatlas_1.ab'
local _hudysfAB2='ui/windows/lingshou/lingshouxuemai_atlas_pak.ab'

local _condition_repair=
{
[sysWinType.eMiZhen]=function(bdData)
local c1,c2=zongmenControl:getZhenYanCount(bdData.build_id,true)
if c1>=c2 then
return hudType.mizhen
end
end,
[sysWinType.eZhenYan]=function(bdData)
if isometricMapSystem:isInUnlockArea(bdData.entityId)then
return hudType.zhenyan
end
end,
[sysWinType.eXianMeng]=function(bdData)
if isometricMapSystem:isInUnlockArea(bdData.entityId)then
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)

local repairData=isometricMapSystem:getRepairDataByEID(bdData.entityId)
if zongmenControl:checkMinNeedLevel(bdCfg,repairData.mapId)then
local collectCfg=cfgHelper.get2(cfg_guildbuildgatherconfig_get,bdData.build_id,0)
if collectCfg then
return hudType.xmcollect
else
return hudType.xmlock
end
else
return hudType.xmlock
end
end
end,
[sysWinType.eFeiShengTai]=function(bdData)
if FeiShengTaiModel:judeCanRepairFST()then
return hudType.feishengtai
end
end,
[sysWinType.efujiezhibao]=function(bdData)
if DuJieZhiBaoController:checklianhuaSingleReddot(bdData.build_id)then
return hudType.feishengtai
end
end,
[sysWinType.eAutoBuild]=function(bdData)
if AutoBuildController:checkAutoBuildingGetRewards(bdData.un_build_id)then
return hudType.autobuilding
end
end,
}


local _condition_wt=
{
[sysWinType.eFangAn]=function(bdData)
if tostring(bdData.dizi_id)=='0'then
return hudType.kongque
else
if bdData.plant_id>0 then






local canReceive=buildingCDControl:isCanReceive(buildingCDType.plan,bdData.un_build_id)
if canReceive then
return hudSortType.plan_complete,2
else



return hudSortType.plan_start,2
end
else



end
end
end,
[sysWinType.eZiRan]=function(bdData)
return hudType.natural
end,
[sysWinType.eShangPu]=function(bdData)
if tostring(bdData.dizi_id)=='0'then
return hudType.kongque
end
if UIShopModel:getEventState(bdData.un_build_id)then
return hudType.event
end
if UIShopControl:checkReddot(bdData)then
return hudType.shopCreate
end
if UIShopControl:checkRcvState(bdData)then
return hudType.shopAutoCreate
end



end,
[sysWinType.eZhenYan]=function(bdData)
if isometricMapSystem:isInUnlockArea(bdData.entityId)then
return hudType.zhenyan
end
end,
[sysWinType.eShouLan]=function(bdData)
if UIShouLanModel:hasRewardCanReceive(bdData.un_build_id)then
return hudType.shoulan
end
end,
}


local _condition_bt=
{
[SLG_SYSTEM_TYPE.eLianDanFang]=function(bdData)
local check=UIDanYaoModel:checkZhaLu(bdData.un_build_id,DANYAO_ZHALU_SEASON.eDiscipleSpecial)
if check then
return hudType.repair
end


if tostring(bdData.dizi_id)=='0'then
return hudType.kongque
end




if buildingCDControl:getCDData(buildingCDType.liandan,bdData.un_build_id,true)then
return hudType.liandan
end
local haveNew=UIDanYaoModel:checkHaveDanFangNew()
if haveNew then
return hudType.danfang
end

if buildingCDControl:getCDData(buildingCDType.dujiexiandan,bdData.un_build_id,true)then
return hudType.dujiexiandan
end

local canGetReddot=UIDanYaoModel.checkUpLevelUnlockReddot()
if canGetReddot then
return hudType.danfangget
end




end,

[SLG_SYSTEM_TYPE.eLianQiGe]=function(bdData)
if tostring(bdData.dizi_id)=='0'then
return hudType.kongque
end


local infoIndex=1
if fabaoModel.getLianzhiInfoByIdx(bdData.un_build_id,infoIndex)then

if buildingCDControl:isComplete(buildingCDType.lianqi,bdData.un_build_id)then
return hudSortType.lianqi_complete,2
else
return hudSortType.lianqi_start,2
end
end



end,

[SLG_SYSTEM_TYPE.eTianDaoRongLu]=function(bdData)
if tianDaoRongDingModel:hasPeiFang()then
return hudType.tianDaoRongLu
end
end,

[SLG_SYSTEM_TYPE.eTianGongGe]=function(bdData)

local check=zhenfaModel:isBuilding_CanActive(bdData)
if check then
return hudType.zhenfaActive
end

if LZDiaoKeModel:hasReward(bdData.un_build_id)then
return hudSortType.diaoke_reward,2
end

if tostring(bdData.dizi_id)=='0'then
return hudType.kongque
end

if zhenfaModel:isStartStudying(bdData.un_build_id)then
return hudType.zhenfaStudying
end





if bdData.plant_id>0 then
return hudType.plan
end

check=zhenfaModel:isBuilding_CanLevelUp(bdData)
if check then
return hudType.zhenfaLevelUp
end
end,
[SLG_SYSTEM_TYPE.eChuanSongZhen]=function(bdData)
if chuanSongZhenModel:checkReward()then
return hudType.chuansongzhen
end
if chuanSongZhenModel:checkBuildLevelUp(bdData)then
return hudType.canLevelup
end
if chuanSongZhenModel:checkPeople(bdData)then
return hudType.yinxiantai
end

if airController:api_Available()then

if airGameEnterModel:checkRewardReddot()then
return hudType.airgame
end
end
end,
[SLG_SYSTEM_TYPE.eYuShouFang]=function(bdData)
local ubdId=bdData.un_build_id
local data=yushoufangModel:getData(ubdId)
if yushoufangModel:isStartMating(data)and yushoufangModel:isFinishMating(data)then
return hudType.lingshoufanyan
end
end,
[SLG_SYSTEM_TYPE.eFangShi]=function(bdData)
if tostring(bdData.dizi_id)=='0'then
return hudType.kongque
end
if fairModel:checkFangShiReddot()then
return hudType.fangshi
end



end,
[SLG_SYSTEM_TYPE.eWuDaoTang]=function(bdData)
local state=wudaotangModel:getwdSatet(bdData)
if state~=0 then
return hudType.wudao
end
end,
[SLG_SYSTEM_TYPE.eZongMen]=function(bdData)
local reddot=UISectPalaceModel:checkReddot()
if reddot then
return hudType.zongmengdadian
end
end,
[SLG_SYSTEM_TYPE.eYinXianTai]=function(bdData)
local tezhiReddot=TeZhiTuJianController:checkSysRedddot2()
if tezhiReddot then
return hudType.tezhitujian
end
if UIRecruitModel:isCanNormalRecruit()then
return hudType.yinxiantai
end
local reddot=UIRecruitModel:checkFamilyReddot()
if reddot then
return hudType.yinxiantai
end
end,
[SLG_SYSTEM_TYPE.eXueShiShuYuan]=function(bdData)
local remain=UISchoolModel:get_study_remainNum()
local checkReward=UISchoolModel:checkReward()
if remain>0 or checkReward then
return hudType.xueyuan
end




end,
[SLG_SYSTEM_TYPE.eLaoYu]=function(bdData)
if UIPrisonModel:isCanGetReward()then
return hudType.laoyu
elseif UIPrisonModel:getMoYuLockReddotState()and not UIPrisonModel:getMoYuLockState()then
return hudType.laoyu
end
end,
[SLG_SYSTEM_TYPE.eCangJingGe]=function(bdData)
local state=UIGongFaModel:chackAllGongFaState(bdData)
if state>0 then
return hudType.gongfa
end
if UIDiscipleModel:checkXinFaBranchActiveReddot()or UIDiscipleModel:checkXinFaActiveReddot()then
return hudType.gongfa
end
end,
[SLG_SYSTEM_TYPE.eFuLuFang]=function(bdData)
local pdata=UIFuLuFangModel:getProduceData(bdData.un_build_id)
local isComplete=buildingCDControl:isComplete(buildingCDType.zhifu,bdData.un_build_id)
local isStop=pdata~=nil and pdata.is_stop==1
if isStop and isComplete then
return hudSortType.zhifu_complete,2
end
local reward=UIFuLuFangModel:checkHaveReward()
if reward then
return hudType.fulu
end
if UIFuLuFangModel:haveNewUnlock(FULU_TAB_TYPE.eFuBao)or UIFuLuFangModel:haveNewUnlock(FULU_TAB_TYPE.eXianLu)then
return hudType.fuluUnlock
end
if isStop and not isComplete then
return hudSortType.zhifu_start,2
end
end,
[SLG_SYSTEM_TYPE.eXianZhan]=function(bdData)
local haveNew=xianzhanModel:checkXianZhanReddot()
if haveNew then
return hudType.xianzhan
end
end,
[SLG_SYSTEM_TYPE.eDanRen]=function(bdData)
local haveDz=zongmenModel:checkRoomHaveDeadDz(bdData)
if haveDz then
return hudType.room
end
end,
[SLG_SYSTEM_TYPE.eDuoRen]=function(bdData)
local haveDz=zongmenModel:checkRoomHaveDeadDz(bdData)
if haveDz then
return hudType.room
end
end,
[SLG_SYSTEM_TYPE.eDaoLv]=function(bdData)
local haveDz=true
local coupleList=DiscipleCoupleModel:getCoupleLiveId(bdData.un_build_id)
if coupleList then
if tostring(coupleList.dizi_id_1)~="0"and
tostring(coupleList.dizi_id_2)~="0"and
coupleList.promote_cnt>0 then
haveDz=false
end

local flag1=DiscipleCoupleModel:getPromoteList(coupleList.dizi_id_1)
local flag2=DiscipleCoupleModel:getPromoteList(coupleList.dizi_id_2)
if flag1 or flag2 then
haveDz=false
end

if UIDiscipleModel:checkDiscipleState2(coupleList.dizi_id_1,DISCIPLE_STATE_TYPE.eChuiWei)then
haveDz=true
end
if UIDiscipleModel:checkDiscipleState2(coupleList.dizi_id_2,DISCIPLE_STATE_TYPE.eChuiWei)then
haveDz=true
end
end

if haveDz then
return hudType.eDaoLv
end
end,
[SLG_SYSTEM_TYPE.eBaoLingShu]=function(bdData)
local checkFree=baoLingShuModel:check_baolingshu_free()and not baoLingShuModel:check_baolingshu_limit()
local reddot=baoLingShuModel:checkBLSPickUpEnterReddot()
if checkFree or reddot then
return hudType.baolingshu
end
end,
[SLG_SYSTEM_TYPE.ePaiHangBang]=function(bdData)
local reddot=wuJiBeiModel:getAllReddot()
if reddot then
return hudType.fulu
end
end,
[SLG_SYSTEM_TYPE.eXuanShangTai]=function(bdData)
if UIXuanShangControl:checkFreeOrTaskReddot()or XianjieXuanShangModel:hasTaskFinish()then
return hudType.xuanshang
end
end,
[SLG_SYSTEM_TYPE.eXianWuLou]=function(bdData)
if xianmengModel:checkXWLHasReward()or FeiShengTaiModel:ShowHelpReddot()or xianMengBaoXiangModel:getGiftReddot(0)then
return hudType.xianwulou
end
end,
[SLG_SYSTEM_TYPE.eDouFaTai]=function(bdData)
if lundaodahuiModel:checkRongYuTangReddot()or UIXianFaWenDaoControl:checkReddot()or douFaTaiModel:checkRewardReddot()then
return hudType.doufatai
end
end,
[SLG_SYSTEM_TYPE.eHouShanMiJing]=function(bdData)
if UIHuanJingControl:isShowRewardReddot()or UIHuanJingControl:isShowDayChallengeRewardReddot()then
return hudType.fulu
elseif UIHuanJingControl:checkDayChallengeReddot()then
return hudType.houShanShiLian

elseif UIHuanJingControl:isZhengLingReddot()then
return hudType.fulu
end
end,
[SLG_SYSTEM_TYPE.eChengYuanHeJu]=function(bdData)
local actorid=xianmengModel:getHeJuActor(bdData.un_build_id)
if actorid and actorid==playerModel:getActorID()then
return hudType.heju
end
end,
[SLG_SYSTEM_TYPE.eQianJiGe]=function(bdData)
if mysteryWeekActivityModel:checkAllReddot()then
return hudType.qianjige
end
end,
[SLG_SYSTEM_TYPE.eXianXunBang]=function(bdData)
if xianmengModel:getGXBRewardReddot()then
return hudType.gongxunbang
end
end,
[SLG_SYSTEM_TYPE.eWanBaoShangHui]=function(bdData)
if bdData.flag==buildingStateType.eBuilding then
local cddata=buildingCDControl:getCDData(buildingCDType.build,bdData.un_build_id,true)
if cddata==nil then return end
local lerp=cddata and cddata.cd or 0
if lerp>0 then
local reddot=not wanBaoShangHuiModel:getWBSHGetQuestionRewardFlag()
if reddot then
return hudType.wanbaoshanghui
end
end
end
end,
[SLG_SYSTEM_TYPE.eYueLongChi]=function(bdData)
local check=UIAquariumControl:checkYueLongChiReddot()
if check then
return hudType.yuelongchi
end
end,
[SLG_SYSTEM_TYPE.eBingGongFang]=function(bdData)
local state=bingGongChangModel:lianZhiState()
local check=bingGongChangController.checkLianLingValReddot()or state==2 or bingGongChangModel:getLianZhiRecviveOne()==0
if check then
return hudType.doufatai
end
end,
[SLG_SYSTEM_TYPE.eShiLianTa]=function(bdData)
local reddot=shiLianTaModel:checkFirstClearRewardReddot()or
wuXingDianController:getReddot()or
myzsModel:getTxzReddot()or
JiuYouTaModel:getDayChallengeReddot()or false
local check=not shiLianTaModel:getSectionRewardState()or reddot
if check then
return hudType.doufatai
end
end,
[SLG_SYSTEM_TYPE.eTanXianDui]=function(bdData)
local check=UIFullWanBaoXunBaoDuiController:checkReddot()or false
if check then
return hudType.tanxiandui
end
end,
[SLG_SYSTEM_TYPE.eShanMen]=function(bdData)

if not systemModel.isOpen(SYSTEM_DEFINE.eShanMenDaZhen)then
return
end


local hasTeamEmpty=shanMenDaZhenModel:checkDaZhenIsHasEmptyTeam()
if hasTeamEmpty then
return hudType.daZhen
end


if shanMenDaZhenModel:checkHaveShanmenDaZhen()then

if systemZongMenModel:checkValidNewFightReport()then

return hudType.daZhen
end


local state=shanMenDaZhenModel:getDaZhenState()
if state==3 then
return hudType.daZhen
elseif state==2 then
local nowShieldValue=shanMenDaZhenModel:getShanMenDaZhenShieldValue()
local daZhenLv=bdData.level-1
local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLv)
local maxShieldValue=daZhenLvCfg.shield

local checkPatchRate=cfgHelper.getdef1(cfg_shanmendazhenconfig,'checkPatch')
local checkPatchValue=math.floor(maxShieldValue*checkPatchRate/100)
if nowShieldValue<=checkPatchValue then
return hudType.daZhen
end
end
end


if shanMenDaZhenModel:checkDaZhenCanLevelUp()then
return hudType.canLevelup
end
end,
[SLG_SYSTEM_TYPE.eYiFangLingTian]=function(bdData)




if YiFangLingTianModel:GetMaxPlant()or tostring(YiFangLingTianModel:GetNowDzID())=='0'or YiFangLingTianController:checkAnyPlantMatched()then
return hudType.yifanglingtian
else
local gezinum=YiFangLingTianController:getGridUnlockCondNum()
if gezinum>0 then
return hudType.yifanglingtian
end
end
end,
[SLG_SYSTEM_TYPE.eFeiShengTai2]=function(bdData)
if FeiShengTaiModel:GetFSTreddot()or FeiShengTaiModel:judeCanRepairFST()then
return hudType.feishengtai
end
end,
[SLG_SYSTEM_TYPE.eDuJieZhiBaoJin]=function(bdData)
if DuJieZhiBaoController:checklianhuaSingleReddot(82)then
return hudType.feishengtai
end
end,
[SLG_SYSTEM_TYPE.eDuJieZhiBaoShui]=function(bdData)
if DuJieZhiBaoController:checklianhuaSingleReddot(83)then
return hudType.feishengtai
end
end,
[SLG_SYSTEM_TYPE.eDuJieZhiBaoMu]=function(bdData)
if DuJieZhiBaoController:checklianhuaSingleReddot(84)then
return hudType.feishengtai
end
end,
[SLG_SYSTEM_TYPE.eDuJieZhiBaoHuo]=function(bdData)
if DuJieZhiBaoController:checklianhuaSingleReddot(85)then
return hudType.feishengtai
end
end,
[SLG_SYSTEM_TYPE.eDuJieZhiBaoTu]=function(bdData)
if DuJieZhiBaoController:checklianhuaSingleReddot(86)then
return hudType.feishengtai
end
end,
[SLG_SYSTEM_TYPE.eTaiXuCang]=function(bdData)
local state=TaiXuCangModel:getNum()>0
if state then
return hudType.taixucang
end
end,
[SLG_SYSTEM_TYPE.eJuTianYi]=function(bdData)
if tostring(bdData.dizi_id)=='0'then
return hudType.kongque
end
end,
[SLG_SYSTEM_TYPE.eYingXianGe]=function(bdData)
if xianjieModel:checkHasHuZhu()then
return hudType.yingxiangeHuZhu
end
end,
[SLG_SYSTEM_TYPE.eYunJiaYing]=function(bdData)
if yunjiayingModel:checkHasQiuZhu()then
return hudType.yingxiangeHuZhu
end
end,
[SLG_SYSTEM_TYPE.eYuLingZhai]=function(bdData)



if YuLingZhaiModel:getHealType()==1 then
return hudType.yulingzhaispeed
elseif YuLingZhaiModel:getHealType()==2 then
return hudType.yulingzhai
end
end,
[SLG_SYSTEM_TYPE.eLittleWorld]=function(bdData)
local state=LittleWorldModel:canGetReward()
if state then
return hudType.littleworld
end
end,
[SLG_SYSTEM_TYPE.eTianShuDaZhen]=function(bdData)
if not tianshudazhenModel:isUnlock()then
return
end
if tianshudazhenModel:isCanUpLevel()then
return hudType.canLevelup
elseif tianshudazhenModel:getBuildData()and not tianshudazhenModel:isZhuShouTeam()then
return hudType.yinxiantai
end
end,
[SLG_SYSTEM_TYPE.eTianShuDian]=function(bdData)
local isCanUpLevel=tianShuDianController:checkCanLevelUp()
if isCanUpLevel then
return hudType.canLevelup
end
end,
[SLG_SYSTEM_TYPE.eZaoWuGe]=function(bdData)
local isShow=zaoWuGeController:checkCanShowHud()
if isShow then
return hudType.zaoWuGe
end
end,
[SLG_SYSTEM_TYPE.eYanDaoTai]=function(bdData)
local isFinishUpLevel=yandaotaiController:checkLevelUpFinish()
local isCanStudy=yandaotaiController:checkIsCanStudy()
if isFinishUpLevel or isCanStudy then
return hudType.eYanDaoTai
end

local isCanUpLevel=yandaotaiController:checkCanLevelUp()
if isCanUpLevel then
return hudType.canLevelup
end
end,
[SLG_SYSTEM_TYPE.eYunJiaYing]=function(bdData)
if yunjiayingModel:checkHasFinishTrain()then
return hudType.yunjiaying
end
end,
[SLG_SYSTEM_TYPE.eXianBang]=function(bdData)
local isreddot,flag=xianjiexianbangModel:XBhavetasksReddot()
if isreddot then
return hudType.xianbang
end
end,
[SLG_SYSTEM_TYPE.eShenShouTa]=function(bdData)
if wanLingTaModel:checkTaLingLevelRewardReddot()then
return hudType.fulu
end
if wanLingTaModel:checkWanLingBaoKuNewLevelReddot()then
return hudType.fulu
end
if wanLingTaModel:checkAllTypeCollectTargetReddot()then
return hudType.fulu
end
if wanLingTaModel:checkAllTypeTuJianReddot()then
return hudType.fulu
end
end,







[SLG_SYSTEM_TYPE.eYuShouFang]=function(bdData)
local isreddot,flag=yushoufangModel.hasReddotInfo(bdData.un_build_id)
if isreddot then









return hudType.yushoufang
end
end,
}





local _state_hud_function=
{
[hudType.unlinkRoad]=
{
showInLayoutMode=true,
init=function(sw,data)

end,
update=function(data,time)

end,
},
[hudType.discipleGoOut]=
{
init=function(sw,data)
sw:SetChildButtonClick(_iconIndexs.root,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
end,
update=function(data,time)

end,
},
[hudType.kongque]=
{
init=function(sw,data)
sw:SetChildButtonClick(_iconIndexs.root,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
end,
update=function(data,time)

end,
},
[hudType.build]=
{
activeUpdate=true,
init=function(sw,data)

local complete=buildingCDControl:isComplete(buildingCDType.build,data.bdData.un_build_id)
if not complete then
sw:SetChildAnimationStringID(_iconIndexs.icon,'chuizi')
sw:SetChildAnimationStatus(_iconIndexs.icon,1)
else
hudControl:doPunchRotation(data,sw)
sw:SetChildNewBieComponentId(_iconIndexs.click,FMT.fmt('buildingStatusHud.build_{0}_{1}',data.bdData.build_id,data.bdData.entityId))
end
sw:SetChildActive(4,not complete)
sw:SetChildActive(5,complete)

sw:SetChildButtonClick(_iconIndexs.click,function()
local isComplete=buildingCDControl:isComplete(buildingCDType.build,data.bdData.un_build_id)
if isComplete then
zongmenControl:receiveAllManufacture(data)
end
end)

data.showProgressBar=true
data.complete=complete
data.progress=0
end,
reset=function(sw,data)
local complete=buildingCDControl:isComplete(buildingCDType.build,data.bdData.un_build_id)
sw:SetChildActive(4,not complete)
sw:SetChildActive(5,complete)
if complete then
hudControl:doPunchRotation(data,sw)
end
data.showProgressBar=not complete
data.complete=complete
end,
update=function(data,time)
if data.showProgressBar and not data.complete then
local sw=hudControl:getSubWidget(data)
local cddata=buildingCDControl:getCDData(buildingCDType.build,data.bdData.un_build_id,true)
if cddata==nil then return end
local dt=cddata.dtime
local needtime=cddata.ntime
if dt>=needtime then
data.complete=true



sw:SetChildNewBieComponentId(_iconIndexs.click,FMT.fmt('buildingStatusHud.build_{0}_{1}',data.bdData.build_id,data.bdData.entityId))

sw:SetChildActive(4,false)
sw:SetChildActive(5,true)
hudControl:doPunchRotation(data,sw)
end


dt=dt+1

local cp=dt/needtime
local dv=cp-data.progress

if dv>=0.01 or cp>=1 then
sw:SetChildUIProgressbar(_iconIndexs.progressbar,dt,needtime)
data.progress=cp
end
end
end,
},
[hudType.levelUp]=
{
activeUpdate=true,
init=function(sw,data)

local complete=buildingCDControl:isComplete(buildingCDType.build,data.bdData.un_build_id)
if not complete then
sw:SetChildAnimationStringID(_iconIndexs.icon,'chuizi')
sw:SetChildAnimationStatus(_iconIndexs.icon,1)
else
hudControl:doPunchRotation(data,sw)
end
sw:SetChildActive(4,not complete)
sw:SetChildActive(5,complete)

sw:SetChildButtonClick(_iconIndexs.click,function()
local isComplete=buildingCDControl:isComplete(buildingCDType.build,data.bdData.un_build_id)
if isComplete then
zongmenControl:receiveAllManufacture(data)
else
isometricMapSystem:openBuildingWin(data.bdData)
end
end)

data.showProgressBar=true
data.complete=complete
data.progress=0
end,
reset=function(sw,data)
local complete=buildingCDControl:isComplete(buildingCDType.build,data.bdData.un_build_id)
sw:SetChildActive(4,not complete)
sw:SetChildActive(5,complete)
if complete then
hudControl:doPunchRotation(data,sw)
end
data.showProgressBar=not complete
data.complete=complete
end,
update=function(data,time)
if data.showProgressBar and not data.complete then
local sw=hudControl:getSubWidget(data)


local cddata=buildingCDControl:getCDData(buildingCDType.build,data.bdData.un_build_id,true)
if cddata==nil then return end
local dt=cddata.dtime
local needtime=cddata.ntime
if dt>=needtime then
data.complete=true




sw:SetChildActive(4,false)
sw:SetChildActive(5,true)
hudControl:doPunchRotation(data,sw)
end


dt=dt+1

local cp=dt/needtime
local dv=cp-data.progress

if dv>=0.01 or cp>=1 then
sw:SetChildUIProgressbar(_iconIndexs.progressbar,dt,needtime)
data.progress=cp
end
end
end,
},
[hudType.plan]=
{
activeUpdate=true,
init=function(sw,data)
local bdData=data.bdData
local lcfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level)
if bdData.plant_id<=0 then
logErr('方案生产对应方案ID已不存在')
return
end
local rtype=lcfg.produce_plans[bdData.plant_id].rewards[1][1]
hudControl.setHUDIcon(sw,_iconIndexs.icon,rtype,true)
hudControl.setHUDIcon(sw,7,rtype,true)
sw:SetChildButtonClick(_iconIndexs.click,function()
local canReceive=buildingCDControl:isCanReceive(buildingCDType.plan,data.bdData.un_build_id)
if canReceive then
zongmenControl:receiveAllManufactureEx(bdData)
UIShopControl:reqAutoCreateRecv(0)
else
isometricMapSystem:openBuildingWin(bdData)
end
end)

sw:SetChildNewBieComponentId(_iconIndexs.click,FMT.fmt('buildingStatusHud.build_{0}_{1}',data.bdData.build_id,data.bdData.entityId))

local canReceive=buildingCDControl:isCanReceive(buildingCDType.plan,data.bdData.un_build_id)
sw:SetChildActive(_iconIndexs.natural_root,canReceive)
if canReceive then
hudControl:doPunchRotation(data,sw)
end

data.showProgressBar=true
data.complete=canReceive
data.progress=0
end,
reset=function(sw,data)
local canReceive=buildingCDControl:isCanReceive(buildingCDType.plan,data.bdData.un_build_id)
sw:SetChildActive(_iconIndexs.natural_root,canReceive)
if canReceive then
hudControl:doPunchRotation(data,sw)
end
data.complete=canReceive
end,
update=function(data,time)
if data.showProgressBar and not data.complete then
local sw=hudControl:getSubWidget(data)
local cddata=buildingCDControl:getCDData(buildingCDType.plan,data.bdData.un_build_id,true)
if cddata==nil then return end
local dt=cddata.stepDTime
local needtime=cddata.stepNeedTime
if cddata.complete or dt>=needtime then
sw:SetChildActive(_iconIndexs.natural_root,true)
data.complete=true



sw:SetChildNewBieComponentId(_iconIndexs.click,FMT.fmt('buildingStatusHud.build_{0}_{1}',data.bdData.build_id,data.bdData.entityId))
hudControl:doPunchRotation(data,sw)
end

dt=dt+1

local cp=dt/needtime
local dv=cp-data.progress

if dv>=0.01 or cp>=1 then
data.progress=cp
end
end
end,
},
[hudType.natural]=
{
activeUpdate=true,
init=function(sw,data)
local bdData=data.bdData
local lcfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level)
local rtype=lcfg.normal_produce.rewards[1][1]
sw:SetChildActive(_iconIndexs.natural_root,false)
hudControl.setHUDIcon(sw,_iconIndexs.icon,rtype,true)

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
data.needPercent=cfg.receive_percent or 1
data.showProgressBar=true
data.complete=false
end,
reset=function(sw,data)
local cddata=buildingCDControl:getCDData(buildingCDType.natural,data.bdData.un_build_id,true)
if cddata==nil then return end
data.complete=cddata.percent>=data.needPercent
data.showProgressBar=not data.complete
sw:SetChildActive(_iconIndexs.natural_root,data.complete)
end,
update=function(data,time)
if data.showProgressBar and not data.complete then
local cddata=buildingCDControl:getCDData(buildingCDType.natural,data.bdData.un_build_id,true)
if cddata==nil then return end
if cddata.percent>=data.needPercent then
data.complete=true
local sw=hudControl:getSubWidget(data)
sw:SetChildActive(_iconIndexs.natural_root,true)
sw:SetChildButtonClick(_iconIndexs.click,function()
zongmenControl:receiveAllManufactureEx(data.bdData)
UIShopControl:reqAutoCreateRecv(0)
end)
hudControl:doPunchRotation(data,sw)
end
end
end,
},
[hudType.event]=
{
init=function(sw,data)
sw:SetChildButtonClick(2,function()
UIShopControl:handleEvent(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.zhenfaActive]=
{
init=function(sw,data)
local can,zfId=zhenfaModel:isBuilding_CanActive(data.bdData)
if can then
local zfCfg=cfgHelper.get1(cfg_zhenfaconfig_get,zfId)
local activeCfg=zfCfg.level[0]
local costCfg=activeCfg[1]
local costItem=costCfg[1]
sw:SetChildActive(_iconIndexs.natural_root,true)

hudControl.setHUDIcon(sw,_iconIndexs.icon,costItem[1],false)
sw:SetChildButtonClick(_iconIndexs.click,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
else
loggerUtil.logErrFMT("阵法激活HUD状态有误，没有可激活阵法 {0}",data.bdData.un_build_id)
hudControl:refreshBuildingStatusHUD(data.bdData.un_build_id)
end
end,
update=function(data,time)

end,
},

[hudType.tianDaoRongLu]=
{
activeUpdate=true,
init=function(sw,data)
local build_id=data.bdData.build_id
if build_id==SLG_SYSTEM_TYPE.eTianDaoRongLu and tianDaoRongDingModel:hasPeiFang()then
local itemid=tianDaoRongDingModel:getFanganItemid()



hudControl.setHUDIcon(sw,_iconIndexs.icon,itemid,false)
hudControl.setHUDIcon(sw,7,itemid,false)

local person=buildingCDControl:getPercent(buildingCDType.tiandaohecheng,data.bdData.un_build_id)or 0
sw:SetChildIconFillAmount(_iconIndexs.progressbar,person)

data.showProgressBar=true
data.complete=false
data.progress=0
end
end,
update=function(data,time)
if data.showProgressBar and not data.complete then
local sw=hudControl:getSubWidget(data)

local cddata=buildingCDControl:getCDData(buildingCDType.tiandaohecheng,data.bdData.un_build_id,true)
if cddata==nil then return end
local dt=cddata.dtime
local needtime=cddata.ntime

if dt>=needtime then
data.complete=true
sw:SetChildButtonClick(_iconIndexs.click,function()
tianDaoRongDingController.reqPrize()
end)

hudControl:doPunchRotation(data,sw)
end

dt=dt+1
local cp=dt/needtime
local dv=cp-data.progress

if dv>=0.01 or cp>=1 then
data.progress=cp
sw:SetChildUIProgressbar(_iconIndexs.progressbar,dt,needtime)
end
end
end,
},

[hudType.zhenfaLevelUp]=
{
init=function(sw,data)
sw:SetChildActive(_iconIndexs.natural_root,true)
sw:SetChildIcon(_iconIndexs.icon,'icon_item_11401',false)
sw:SetChildButtonClick(_iconIndexs.click,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.zhenfaStudying]=
{
activeUpdate=true,
init=function(sw,data)
local studying=zhenfaModel:getStudyingData(data.bdData.un_build_id)
if studying then
local zfCfg=cfgHelper.get1(cfg_zhenfaconfig_get,studying.zfId)

sw:SetChildCSImageIcon(_iconIndexs.icon,zfCfg.icon,false)
sw:SetChildButtonClick(_iconIndexs.click,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)






data.progress=0
data.complete=false
data.showProgressBar=true
else
loggerUtil.logErrFMT("阵法研究HUD状态有误，没有研究中的阵法 {0}",data.bdData.un_build_id)
data.progress=1
data.complete=true
data.showProgressBar=false
sw:SetChildUIProgressbar(_iconIndexs.progressbar,100,100)

hudControl:refreshBuildingStatusHUD(data.bdData.un_build_id)
end

end,
update=function(data,time)
if data.showProgressBar and not data.complete then
local sw=hudControl:getSubWidget(data)
local studying=zhenfaModel:getStudyingData(data.bdData.un_build_id)
if studying then
local least=math.max(zhenfaModel.calculateLeastTime(studying))
local pTime=studying.duration-least
local progress=pTime/studying.duration
if(progress-data.progress)>0.01 then
data.progress=math.floor(progress*100+0.5)/100
sw:SetChildUIProgressbar(_iconIndexs.progressbar,pTime,studying.duration)
end
else
data.progress=1
sw:SetChildUIProgressbar(_iconIndexs.progressbar,100,100)
data.complete=true
end
end

end,
},
[hudType.danfang]=
{
init=function(sw,data)
local bdData=data.bdData
local dyData=UIDanYaoModel:get_danYaodata(bdData.un_build_id)
if dyData then
local haveNew,newDfId=UIDanYaoModel:checkHaveDanFangNew()
if haveNew then
sw:SetChildActive(_iconIndexs.natural_root,true)
local newDfCfg=cfgHelper.get1(cfg_danfangconfig_get,newDfId)
local unlock=newDfCfg.unlock
if unlock then
local unLockType=unlock[1]
if unLockType==1 then
local itemid=unlock[2]

hudControl.setHUDIcon(sw,_iconIndexs.icon,itemid,false)
sw:SetChildButtonClick(_iconIndexs.click,function()
isometricMapSystem:openBuildingWin(bdData)
end)
end
end
data.showProgressBar=false
hudControl:doPunchRotation(data,sw)
else
logErr('未找到新丹方')
end

data.complete=false
else
logErr('未找到该建筑炼丹数据')
end
end,
update=function(data,time)

end,
},
[hudType.liandan]=
{
activeUpdate=true,
init=function(sw,data)
local bdData=data.bdData
local dyData=UIDanYaoModel:get_danYaodata(bdData.un_build_id)
if dyData then

local danFangCfg=cfgHelper.get1(cfg_danfangconfig_get,dyData.dfId)





hudControl.setHUDIcon(sw,_iconIndexs.icon,danFangCfg.itemid,false)
hudControl.setHUDIcon(sw,7,danFangCfg.itemid,false)

local cddata=buildingCDControl:getCDData(buildingCDType.liandan,bdData.un_build_id,true)
if cddata==nil then return end
sw:SetChildIconFillAmount(_iconIndexs.progressbar,cddata.stepPercent or 0)

data.showProgressBar=true
data.complete=false
data.progress=0
else
logErr('未找到该建筑炼丹数据')
end
end,
reset=function(sw,data)

data.showProgressBar=true
data.complete=false
data.progress=0
hudControl:removeStateHUDTweener(data)

local bdData=data.bdData
local dyData=UIDanYaoModel:get_danYaodata(bdData.un_build_id)
local danFangCfg=cfgHelper.get1(cfg_danfangconfig_get,dyData.dfId)



hudControl.setHUDIcon(sw,_iconIndexs.icon,danFangCfg.itemid,false)
hudControl.setHUDIcon(sw,7,danFangCfg.itemid,false)

local cddata=buildingCDControl:getCDData(buildingCDType.liandan,data.bdData.un_build_id,true)
if cddata==nil then return end
local dt=cddata.stepDTime+1
local st=cddata.dfTime
sw:SetChildUIProgressbar(_iconIndexs.progressbar,dt,st,false)
end,
update=function(data,time)
if data.showProgressBar and not data.complete then
local sw=hudControl:getSubWidget(data)
local bdData=data.bdData
local cddata=buildingCDControl:getCDData(buildingCDType.liandan,bdData.un_build_id,true)

if cddata==nil then return end

if cddata.complete or cddata.fCount>cddata.rCount then
data.complete=true
sw:SetChildButtonClick(_iconIndexs.click,function()
local sfId=zongmenModel:getMountainId()

UIDanYaoController:reqOneKeyPrize()
end)

sw:SetChildUIProgressbar(_iconIndexs.progressbar,1,1,false)

hudControl:doPunchRotation(data,sw)
else
local cp=cddata.stepPercent
local dv=cp-data.progress
if dv>=0.01 or cp>=1 then
data.progress=cp
local dt=cddata.stepDTime+1
local st=cddata.dfTime
sw:SetChildUIProgressbar(_iconIndexs.progressbar,dt,st)
end
end
end
end,
},
[hudType.dujiexiandan]=
{
activeUpdate=true,
init=function(sw,data)
local bdData=data.bdData




hudControl.setHUDIcon(sw,_iconIndexs.icon,11789,false)
hudControl.setHUDIcon(sw,7,11789,false)

local cddata=buildingCDControl:getCDData(buildingCDType.dujiexiandan,bdData.un_build_id,true)
if cddata==nil then return end
sw:SetChildIconFillAmount(_iconIndexs.progressbar,cddata.stepPercent or 0)

data.showProgressBar=true
data.complete=false
data.progress=0
end,
reset=function(sw,data)

data.showProgressBar=true
data.complete=false
data.progress=0
hudControl:removeStateHUDTweener(data)




hudControl.setHUDIcon(sw,_iconIndexs.icon,11789,false)
hudControl.setHUDIcon(sw,7,11789,false)

local cddata=buildingCDControl:getCDData(buildingCDType.dujiexiandan,data.bdData.un_build_id,true)
if cddata==nil then return end
local dt=0
local st=cddata.cd
data.max=cddata.cd
sw:SetChildUIProgressbar(_iconIndexs.progressbar,dt,st,false)
end,
update=function(data,time)
if data.showProgressBar and not data.complete then
local sw=hudControl:getSubWidget(data)
local bdData=data.bdData
local cddata=buildingCDControl:getCDData(buildingCDType.dujiexiandan,bdData.un_build_id,true)
if cddata==nil then return end

if cddata.complete then
data.complete=true
sw:SetChildButtonClick(_iconIndexs.click,function()
UIFullLianDanFangControl:showDuJieXianDan()
end)

sw:SetChildUIProgressbar(_iconIndexs.progressbar,1,1,false)

hudControl:doPunchRotation(data,sw)
else
local cp=cddata.stepPercent
local dv=cp-data.progress
if dv>=0.01 or cp>=1 then
data.progress=cp
local dt=cddata.cd
local max=data.max
sw:SetChildUIProgressbar(_iconIndexs.progressbar,max-dt,max)
end
end
end
end,
},

[hudType.lianqi]=
{
activeUpdate=true,
init=function(sw,data)
local ubdId=data.bdData.un_build_id
if fabaoModel.hasLianzhiInfo(ubdId)then
local iconname=fabaoModel.getLianqiMainidIconName(ubdId)
sw:SetChildIcon(_iconIndexs.icon,iconname,false)
sw:SetChildIcon(7,iconname,false)

local person=buildingCDControl:getPercent(buildingCDType.lianqi,data.bdData.un_build_id)or 0
sw:SetChildIconFillAmount(_iconIndexs.progressbar,person)

data.showProgressBar=true
data.complete=false
data.progress=0
end
end,
update=function(data,time)
if data.showProgressBar and not data.complete then
local sw=hudControl:getSubWidget(data)

local cddata=buildingCDControl:getCDData(buildingCDType.lianqi,data.bdData.un_build_id,true)
if cddata==nil then return end
local dt=cddata.dtime
local needtime=cddata.ntime

if dt>=needtime then
data.complete=true
sw:SetChildButtonClick(_iconIndexs.click,function()


fabaoProtocolControl.reqOneKeyPrizeFabao()
end)

hudControl:doPunchRotation(data,sw)
end

dt=dt+1
local cp=dt/needtime
local dv=cp-data.progress

if dv>=0.01 or cp>=1 then
data.progress=cp
sw:SetChildUIProgressbar(_iconIndexs.progressbar,dt,needtime)
end
end
end,
},
[hudType.wudao]=
{
init=function(sw,data)
local state=wudaotangModel:getwdSatet(data.bdData)
local iconName
if state==1 then
iconName='icon_wudaowc'
elseif state==2 then
iconName='icon_dizirumo'
elseif state==-1 then
iconName='icon_zhaomucs'
end
sw:SetChildCSImageSprite(1,_hudAtlasAB,iconName)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
reset=function(sw,data)
local state=wudaotangModel:getwdSatet(data.bdData)
local iconName
if state==1 then
iconName='icon_wudaowc'
elseif state==2 then
iconName='icon_dizirumo'
elseif state==-1 then
iconName='icon_zhaomucs'
end
sw:SetChildCSImageSprite(1,_hudAtlasAB,iconName)
end,
update=function(data,time)

end,
},
[hudType.xianwulou]=
{
init=function(sw,data)
local iconName='icon_fangshigx'
sw:SetChildCSImageSprite(1,_hudAtlasAB,iconName)
sw:SetChildButtonClick(2,function()
xianmengController:openXianWuLouWin()
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.zongmengdadian]=
{
init=function(sw,data)
local flag,state=UISectPalaceModel:checkReddot()
local iconName=''
if state==1 then
iconName='icon_zhaomucs'
elseif state==2 then
iconName='icon_wudaowc'
elseif state==3 then
iconName='icon_jiantou_4'
elseif state==4 then
iconName='icon_jianzhu_1'
end
sw:SetChildCSImageSprite(1,_hudAtlasAB,iconName)
sw:SetChildButtonClick(2,function()
if state==4 then
buildSkinController:showBuildSkinListWin(data.bdData.build_id,data.bdData.un_build_id)
else
isometricMapSystem:openBuildingWin(data.bdData)
end
end)
hudControl:doPunchRotation(data,sw)
end,
reset=function(sw,data)
local flag,state=UISectPalaceModel:checkReddot()
local iconName=''
if state==1 then
iconName='icon_zhaomucs'
elseif state==2 then
iconName='icon_wudaowc'
elseif state==3 then
iconName='icon_jiantou_4'
elseif state==4 then
iconName='icon_jianzhu_1'
end
sw:SetChildCSImageSprite(1,_hudAtlasAB,iconName)
sw:SetChildButtonClick(2,function()
if state==4 then
buildSkinController:showBuildSkinListWin(data.bdData.build_id,data.bdData.un_build_id)
else
isometricMapSystem:openBuildingWin(data.bdData)
end
end)
end,
update=function(data,time)

end,
},
[hudType.gongfa]=
{
init=function(sw,data)
local state=UIGongFaModel:chackAllGongFaState(data.bdData)
local iconName='icon_wudaowc'
sw:SetChildCSImageSprite(1,_hudAtlasAB,iconName)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.mieHuo]=
{
init=function(sw,data)
sw:SetChildButtonClick(0,function()
if emergenciesControl:toExtinguishing(data.bdData)then
sw:SetChildCSImageSprite(1,_hudAtlasAB,'icon_jipao')
end
end)
sw:SetChildCSImageSprite(1,_hudAtlasAB,'icon_jiangyu_1')
hudControl:doPunchRotation(data,sw)
end,
reset=function(sw,data)
if emergenciesControl:checkIsExtinguishing(data.bdData)then
sw:SetChildCSImageSprite(1,_hudAtlasAB,'icon_jipao')
else
sw:SetChildCSImageSprite(1,_hudAtlasAB,'icon_jiangyu_1')
end
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.repair]=
{
activeUpdate=true,
init=function(sw,data)



local cd=buildingCDControl:getCD(buildingCDType.xiufu,data.bdData.un_build_id)
cd=cd or buildingCDControl:getCD(buildingCDType.lianDanXiuFu,data.bdData.un_build_id)
cd=cd or buildingCDControl:getCD(buildingCDType.zhalu,data.bdData.un_build_id)
if cd and cd>=0 then
sw:SetChildText(1,FMT.fmt('修复：{0}',timeHelper.format_time_stamp11(cd)))
end



end,
update=function(data,time)










local cd=buildingCDControl:getCD(buildingCDType.xiufu,data.bdData.un_build_id)
cd=cd or buildingCDControl:getCD(buildingCDType.lianDanXiuFu,data.bdData.un_build_id)
cd=cd or buildingCDControl:getCD(buildingCDType.zhalu,data.bdData.un_build_id)
if cd and cd>=0 then
local sw=hudControl:getSubWidget(data)
sw:SetChildText(1,FMT.fmt('修复：{0}',timeHelper.format_time_stamp11(cd)))
end
end,
},
[hudType.creeper]=
{
activeUpdate=true,
init=function(sw,data)
sw:SetChildActive(0,not isometricMapSystem:isInGroundModel())
sw:SetChildCSImageSprite(2,globalABLookup.hud_atlas,"icon_sjtishitp_2")
if emergenciesModel:isCreeper(data.bdData.un_build_id)then
local cd=buildingCDControl:getCD(buildingCDType.chanrao,data.bdData.un_build_id)or 0
sw:SetChildText(1,FMT.fmt('缠绕：{0}',timeHelper.format_time_stamp11(cd)))
else
hudControl:refreshBuildingStatusHUD(data.bdData.un_build_id)
end
end,
update=function(data,time)
if emergenciesModel:isCreeper(data.bdData.un_build_id)then
local cd=buildingCDControl:getCD(buildingCDType.chanrao,data.bdData.un_build_id)or 0
local sw=hudControl:getSubWidget(data)
sw:SetChildText(1,FMT.fmt('缠绕：{0}',timeHelper.format_time_stamp11(cd)))
else
hudControl:refreshBuildingStatusHUD(data.bdData.un_build_id)
end
end,
reset=function(sw,data)
sw:SetChildActive(0,not isometricMapSystem:isInGroundModel())
end
},
[hudType.yinxiantai]=
{
init=function(sw,data)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)
end,
},
[hudType.tezhitujian]=
{
init=function(sw,data)
local iconName=''
local showBg=false
if TeZhiTuJianController:checkSysRedddot()then
iconName='icon_tezhitujian_1'
else
showBg=true
iconName='icon_wudaowc'
end
sw:SetChildActive(3,showBg)
sw:SetChildCSImageSprite(1,_hudAtlasAB,iconName)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData,{showTeZhi=true})
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)
end,
},
[hudType.planreward]=
{
init=function(sw,data)
end,
update=function(data,time)
end,
},
[hudType.xueyuan]=
{
init=function(sw,data)
local checkReward=UISchoolModel:checkReward()
local iconName=''
if checkReward then
iconName='icon_fangshigx'
else
iconName='icon_xueyuansk'
end




sw:SetChildCSImageSprite(1,_hudAtlasAB,iconName)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
reset=function(sw,data)
local checkReward=UISchoolModel:checkReward()
local iconName=''
if checkReward then
iconName='icon_fangshigx'
else
iconName='icon_xueyuansk'
end




sw:SetChildCSImageSprite(1,_hudAtlasAB,iconName)
end,
update=function(data,time)
end,
},
[hudType.fangshi]=
{
init=function(sw,data)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)
end,
},
[hudType.laoyu]=
{
init=function(sw,data)
local iconName=''
local abName=globalABLookup.hud_atlas

if UIPrisonModel:isCanGetReward()then
iconName='icon_fangshigx'
elseif UIPrisonModel:getMoYuLockReddotState()and not UIPrisonModel:getMoYuLockState()then
iconName='icon_konglaoyu'
end

sw:SetChildCSImageSprite(1,abName,iconName)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)
end,
},
[hudType.room]=
{
init=function(sw,data)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.chuiwei]=
{
init=function(sw,data)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.fulu]=
{
init=function(sw,data)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.zhifu]=
{
activeUpdate=true,
init=function(sw,data)
local bdData=data.bdData
local pdata=UIFuLuFangModel:getProduceData(bdData.un_build_id)
local itemId=cfgHelper.get2(cfg_yufufangconfig_get,pdata.yufu_id,'itemId')



hudControl.setHUDIcon(sw,_iconIndexs.icon,itemId,false)
hudControl.setHUDIcon(sw,7,itemId,false)

local cddata=buildingCDControl:getCDData(buildingCDType.zhifu,bdData.un_build_id,true)
if cddata==nil then return end
sw:SetChildIconFillAmount(_iconIndexs.progressbar,cddata.stepPercent or 0)

data.showProgressBar=true
data.complete=false
data.progress=0
end,
reset=function(sw,data)
data.showProgressBar=true
data.complete=false
data.progress=0
hudControl:removeStateHUDTweener(data)
local cddata=buildingCDControl:getCDData(buildingCDType.zhifu,data.bdData.un_build_id,true)
if cddata==nil then return end
local dt=cddata.stepDTime+1
local st=cddata.stepTime
sw:SetChildUIProgressbar(_iconIndexs.progressbar,dt,st)
end,
update=function(data,time)
if data.showProgressBar and not data.complete then
local sw=hudControl:getSubWidget(data)

local bdData=data.bdData
local pdata=UIFuLuFangModel:getProduceData(bdData.un_build_id)
local cddata=buildingCDControl:getCDData(buildingCDType.zhifu,bdData.un_build_id,true)
if cddata==nil then return end

if cddata.complete or cddata.currStep>pdata.rec_cnt then
data.complete=true
sw:SetChildButtonClick(_iconIndexs.click,function()


UIFullFuLuFangControl.reqOneKeyPrizeYuFu()
end)

sw:SetChildUIProgressbar(_iconIndexs.progressbar,1,1,false)

hudControl:doPunchRotation(data,sw)
else
local cp=cddata.stepPercent
local dv=cp-data.progress
if dv>=0.01 or cp>=1 then
data.progress=cp
local dt=cddata.stepDTime+1
local st=cddata.stepTime
sw:SetChildUIProgressbar(_iconIndexs.progressbar,dt,st)
end
end
end
end,
},
[hudType.fuluUnlock]=
{
init=function(sw,data)
local bdData=data.bdData
local id,ftype=UIFuLuFangModel:getANewUnlockData(FULU_TAB_TYPE.eFuBao)
if not id then
id,ftype=UIFuLuFangModel:getANewUnlockData(FULU_TAB_TYPE.eXianLu)
end
if id then
sw:SetChildActive(_iconIndexs.natural_root,true)
local cfg=UIFuLuFangModel:getConfig(ftype,id)
local unlockItem=cfg.unlock[2][1][1]

hudControl.setHUDIcon(sw,_iconIndexs.icon,unlockItem,false)
sw:SetChildButtonClick(_iconIndexs.click,function()
isometricMapSystem:openBuildingWin(bdData)
end)
hudControl:doPunchRotation(data,sw)
else
logErr('无符箓解锁数据')
end
end,
update=function(data,time)

end,
},
[hudType.xianzhan]=
{
init=function(sw,data)
local flag,num=xianzhanModel:checkXianZhanReddot()
local abName
local iconName=''
if num==1 then
abName=globalABLookup.hud_atlas
iconName='icon_fangshigx'
elseif num==2 then
abName=globalABLookup.global
iconName='icon_jzxzxingeren_1'
elseif num==3 then
abName=globalABLookup.global
iconName='icon_sjgantanhao'
elseif num==4 then
abName=globalABLookup.global
iconName='icon_jzxzxingeren_1'
end
sw:SetChildCSImageSprite(1,abName,iconName)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.baolingshu]=
{
init=function(sw,data)
local abName=globalABLookup.hud_atlas
local iconName='icon_fangshigx'
sw:SetChildCSImageSprite(1,abName,iconName)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.mizhen]=
{
init=function(sw,data)
sw:SetChildButtonClick(2,function()
local rpdata=isometricMapSystem:getRepairDataByEID(data.bdData.entityId)

local sfId=zongmenModel:getMountainId()
zongmenControl:reqBuild(sfId,rpdata.id,rpdata.x,rpdata.y,0)
end)
end,
update=function(data,time)

end,
},
[hudType.zhenyan]=
{
init=function(sw,data)
sw:SetChildButtonClick(2,function()
if data.bdData.flag<0 then
local rpdata=isometricMapSystem:getRepairDataByEID(data.bdData.entityId)
UIManager:showWindow('UIZhenYanWin',{1,rpdata})
else
isometricMapSystem:openBuildingWin(data.bdData)
end
end)
end,
update=function(data,time)

end,
},
[hudType.shoulan]=
{
init=function(sw,data)
sw:SetChildActive(_iconIndexs.natural_root,true)
local itemId=UIShouLanModel:getCanReceiveRewardFirstItemId(data.bdData.un_build_id)
hudControl.setHUDIcon(sw,_iconIndexs.icon,itemId,false)
sw:SetChildButtonClick(_iconIndexs.click,function()
UIShouLanControl:receiveSLReward(data.bdData.un_build_id)
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.lingshoufanyan]=
{
init=function(sw,data)
sw:SetChildButtonClick(2,function()
yushoufangController:send_3_227(data.bdData.un_build_id)

end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)
end,
},
[hudType.xuanshang]=
{
init=function(sw,data)
local hasReward=UIXuanShangControl:hasTaskFinish()
local iconName=hasReward and'icon_fangshigx'or'icon_zhaomucs'
sw:SetChildCSImageSprite(1,_hudAtlasAB,iconName)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
reset=function(sw,data)
local hasReward=UIXuanShangControl:hasTaskFinish()
local iconName=hasReward and'icon_fangshigx'or'icon_zhaomucs'
sw:SetChildCSImageSprite(1,_hudAtlasAB,iconName)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.xmlock]=
{
init=function(sw,data)
local entityId=data.bdData.entityId
sw:SetChildCSImageSprite(0,_hudAtlasAB,"icon_xiufujiesuo")

sw:SetChildButtonClick(0,function()
local inUnlockArea=isometricMapSystem:isInUnlockArea(entityId)
isometricMapSystem:checkTouchRepairBuilding(entityId,inUnlockArea)

end)
end,
update=function(data,time)

end,
},
[hudType.xmcollect]=
{
init=function(sw,data)
local entityId=data.bdData.entityId
local repairData=isometricMapSystem:getRepairDataByEID(entityId)
local posIdx=repairData.pos_idx
local collectData=xianmengModel:getRepairCollect(posIdx)
local gatherCfg=cfgHelper.get2(cfg_guildbuildgatherconfig_get,data.bdData.build_id,0)
local daily=collectData and collectData.daily or 0
local cur=collectData and collectData.collect_num or 0
local max=gatherCfg.times
sw:SetChildUIProgressbar(_iconIndexs.progressbar,cur,max)
sw:SetChildButtonClick(_iconIndexs.click,function()
local inUnlockArea=isometricMapSystem:isInUnlockArea(entityId)
isometricMapSystem:checkTouchRepairBuilding(entityId,inUnlockArea)
end)
if daily<gatherCfg.daily then
sw:SetChildActive(_iconIndexs.progressbarbg,false)
sw:SetChildActive(_iconIndexs.iconbg,true)
hudControl:doPunchRotation(data,sw)
else
sw:SetChildActive(_iconIndexs.progressbarbg,true)
sw:SetChildActive(_iconIndexs.iconbg,false)
hudControl:removeStateHUDTweener(data,sw)
sw:SetChildRotation(_iconIndexs.root,0,0,0)
end
end,
reset=function(sw,data)
local entityId=data.bdData.entityId
local repairData=isometricMapSystem:getRepairDataByEID(entityId)
local posIdx=repairData.pos_idx
local collectData=xianmengModel:getRepairCollect(posIdx)
local gatherCfg=cfgHelper.get2(cfg_guildbuildgatherconfig_get,data.bdData.build_id,0)
local daily=collectData and collectData.daily or 0
local cur=collectData and collectData.collect_num or 0
local max=gatherCfg.times
sw:SetChildUIProgressbar(_iconIndexs.progressbar,cur,max)




if daily<gatherCfg.daily then
sw:SetChildActive(_iconIndexs.progressbarbg,false)
sw:SetChildActive(_iconIndexs.iconbg,true)
hudControl:doPunchRotation(data,sw)
else
sw:SetChildActive(_iconIndexs.progressbarbg,true)
sw:SetChildActive(_iconIndexs.iconbg,false)
hudControl:removeStateHUDTweener(data,sw)
sw:SetChildRotation(_iconIndexs.root,0,0,0)
end
end,
update=function(data,time)

end,
},
[hudType.doufatai]=
{
init=function(sw,data)
sw:SetChildActive(0,true)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
reset=function(sw,data)
sw:SetChildActive(0,true)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)
end,
},
[hudType.houShanShiLian]=
{
init=function(sw,data)
sw:SetChildButtonClick(0,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
sw:SetChildCSImageSprite(1,_hudAtlasAB,'icon_meiritiaozhan_1')
hudControl:doPunchRotation(data,sw)
end,
reset=function(sw,data)
sw:SetChildButtonClick(0,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
sw:SetChildCSImageSprite(1,_hudAtlasAB,'icon_meiritiaozhan_1')
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.heju]=
{
init=function(sw,data)
local actorid=xianmengModel:getHeJuActor(data.bdData.un_build_id)
if actorid then
local name=xianmengModel:getXMMemberName(actorid)
if actorid==playerModel:getActorID()then
name=FMT.fmt("<color=#FFF63B>{0}</color>",name)
end
sw:SetChildText(1,name)
end
sw:SetChildButtonClick(0,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
end,
},
[hudType.qianjige]=
{
init=function(sw,data)
sw:SetChildActive(0,true)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
reset=function(sw,data)
sw:SetChildActive(0,true)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)
end,
},
[hudType.gongxunbang]=
{
init=function(sw,data)
sw:SetChildCSImageSprite(1,_hudAtlasAB,'icon_fangshigx')
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
reset=function(sw,data)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)
end,
},
[hudType.wanbaoshanghui]=
{
activeUpdate=true,
init=function(sw,data)
sw:SetChildCSImageSprite(1,_hudAtlasAB,'icon_fangshigx')
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
reset=function(sw,data)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)
local cddata=buildingCDControl:getCDData(buildingCDType.build,data.bdData.un_build_id,true)
if cddata==nil then return end
local lerp=cddata and cddata.cd or 0
if lerp<=0 then
return hudControl:refreshBuildingStatusHUD(data.bdData.un_build_id)
end
end,
},
[hudType.canLevelup]=
{
init=function(sw,data)
sw:SetChildActive(_iconIndexs.natural_root,true)
sw:SetChildCSImageSprite(_iconIndexs.icon,_hudAtlasAB,'icon_jiantou_4')
sw:SetChildButtonClick(_iconIndexs.click,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
reset=function(sw,data)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)
end,
},
[hudType.yuelongchi]=
{
init=function(sw,data)
sw:SetChildButtonClick(1,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
reset=function(sw,data)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)
end,
},
[hudType.bettermanager]=
{
init=function(sw,data)
local sfId=zongmenModel:getBuildingLocationMapId(data.bdData.un_build_id)
sw:SetChildCSImageSprite(1,_hudAtlasAB,'icon_zhaomucs')
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
zongmenControl:showSelectManagerWin(sfId,data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
reset=function(sw,data)
sw:SetChildCSImageSprite(1,_hudAtlasAB,'icon_zhaomucs')
end,
update=function(data,time)

end,
},
[hudType.canUnlockSkin]=
{
init=function(sw,data)
sw:SetChildActive(_iconIndexs.natural_root,true)
sw:SetChildCSImageSprite(_iconIndexs.icon,_hudAtlasAB,'icon_jianzhu_1')
sw:SetChildButtonClick(_iconIndexs.click,function()
buildSkinController:showBuildSkinListWin(data.bdData.build_id,data.bdData.un_build_id)
end)
hudControl:doPunchRotation(data,sw)
end,
reset=function(sw,data)
sw:SetChildButtonClick(2,function()
buildSkinController:showBuildSkinListWin(data.bdData.build_id,data.bdData.un_build_id)
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)
end,
},
[hudType.tanxiandui]=
{
init=function(sw,data)
local flag,num=UIFullWanBaoXunBaoDuiController:checkReddot()
local abName
local iconName=''
if num==1 then
abName=globalABLookup.hud_atlas
iconName='icon_fangshigx'
elseif num==2 then
abName=globalABLookup.global
iconName='icon_jzxzxingeren_1'
elseif num==3 then
abName=globalABLookup.global
iconName='icon_sjgantanhao'
end
sw:SetChildCSImageSprite(1,abName,iconName)
sw:SetChildButtonClick(2,function()
if num==1 or num==3 then
wanBaoXunBaoDuiController.quickReceiveAllChannel()
else
isometricMapSystem:openBuildingWin(data.bdData)
end
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.lzdiaokeing]=
{
activeUpdate=true,
init=function(sw,data)
if LZDiaoKeModel:isDKing(data.bdData.un_build_id)then
sw:SetChildActive(_iconIndexs.natural_root,true)

local sfid,un_build_id=zongmenModel:getMountainId(),data.bdData.un_build_id
local dkItemList=LZDiaoKeModel:getJZData_DkItemList(sfid,un_build_id)
local itemId=dkItemList[1]and dkItemList[1].param_1 or nil
data.IconFlag=false
if itemId then


hudControl.setHUDIcon(sw,_iconIndexs.icon,itemId,false)
data.IconFlag=true
end
sw:SetChildButtonClick(_iconIndexs.click,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
data.progress=0
data.complete=false
data.showProgressBar=true
else
loggerUtil.logErrFMT("灵阵雕刻HUD状态有误，不在雕刻中 {0}",data.bdData.un_build_id)
data.progress=1
data.complete=true
data.showProgressBar=false
sw:SetChildUIProgressbar(_iconIndexs.progressbar,100,100)
hudControl:refreshBuildingStatusHUD(data.bdData.un_build_id)
end
end,
update=function(data,time)
if data.showProgressBar and not data.complete then

local sfid,un_build_id=zongmenModel:getMountainId(),data.bdData.un_build_id
local dkState,curNum,sumNum=LZDiaoKeModel:CheckDKState(sfid,un_build_id)
local startTime=LZDiaoKeModel:getJZData_StartTime(sfid,un_build_id)
local needTime=cfgHelper.get(cfg_lingzhendiaokebaseconfig_get,1,"dktime")
local curTime=timeHelper.getServerShortTime()
local sw=hudControl:getSubWidget(data)
if not data.IconFlag then
local dkItemList=LZDiaoKeModel:getJZData_DkItemList(sfid,un_build_id)
local itemId=dkItemList[1]and dkItemList[1].param_1 or nil
if itemId then


hudControl.setHUDIcon(sw,_iconIndexs.icon,itemId,false)
data.IconFlag=true
end
end


local progressValue=curTime-startTime-curNum*needTime

if curNum==0 then
sw:SetChildUIProgressbar(_iconIndexs.progressbar,progressValue,needTime)
else
data.progress=1
sw:SetChildUIProgressbar(_iconIndexs.progressbar,100,100)
data.complete=true
hudControl:refreshBuildingStatusHUD(data.bdData.un_build_id)
end
end

end,
},
[hudType.lzdiaokeReward]=
{
activeUpdate=true,
init=function(sw,data)
if LZDiaoKeModel:hasReward(data.bdData.un_build_id)then

local isReddot=LZDiaoKeModel:checkReddot(data.bdData.un_build_id)
local sfid=zongmenModel:getMountainId()
local ubId=data.bdData.un_build_id


if isReddot then
sw:SetChildCSImageSprite(_iconIndexs.icon,_hudAtlasAB,"icon_fangshigx")
else
local dkItemList=LZDiaoKeModel:getJZData_DkItemList(sfid,ubId)
local itemId=dkItemList[1]and dkItemList[1].param_1 or 72001

hudControl.setHUDIcon(sw,_iconIndexs.icon,itemId,false)
end
local _fun=isReddot and function()LZDiaoKeController:req_LingGanReward(sfid,ubId)end or function()LZDiaoKeController:req_StopDK(sfid,ubId,2)end
sw:SetChildButtonClick(_iconIndexs.click,_fun)
hudControl:doPunchRotation(data,sw)
else
loggerUtil.logErrFMT("灵阵雕刻HUD状态有误，没有可领取的奖励 {0}",data.bdData.un_build_id)
hudControl:refreshBuildingStatusHUD(data.bdData.un_build_id)
end
end,
update=function(data,time)

end,
reset=function(sw,data)
if LZDiaoKeModel:hasReward(data.bdData.un_build_id)then

local isReddot=LZDiaoKeModel:checkReddot(data.bdData.un_build_id)
local sfid=zongmenModel:getMountainId()
local ubId=data.bdData.un_build_id


if isReddot then
sw:SetChildCSImageSprite(_iconIndexs.icon,_hudAtlasAB,"icon_fangshigx")
else
local dkItemList=LZDiaoKeModel:getJZData_DkItemList(sfid,ubId)
local itemId=dkItemList[1]and dkItemList[1].param_1 or 72001

hudControl.setHUDIcon(sw,_iconIndexs.icon,itemId,false)
end
local _fun=isReddot and function()LZDiaoKeController:req_LingGanReward(sfid,ubId)end or function()LZDiaoKeController:req_StopDK(sfid,ubId,2)end
sw:SetChildButtonClick(_iconIndexs.click,_fun)
hudControl:doPunchRotation(data,sw)
else
loggerUtil.logErrFMT("灵阵雕刻HUD状态有误，没有可领取的奖励 {0}",data.bdData.un_build_id)
hudControl:refreshBuildingStatusHUD(data.bdData.un_build_id)
end
end,
},
[hudType.shopCreate]=
{
activeUpdate=true,
init=function(sw,data)
if UIShopControl:checkReddot(data.bdData)then

local ubdId=data.bdData.un_build_id
sw:SetChildCSImageSprite(_iconIndexs.icon,_hudAtlasAB,"icon_fangshigx")


local _fun=function()UIShopControl.Req_9_16(0)end
sw:SetChildButtonClick(_iconIndexs.click,_fun)
hudControl:doPunchRotation(data,sw)
else
loggerUtil.logErrFMT("商铺HUD状态有误，没有可领取的奖励 {0}",data.bdData.un_build_id)
hudControl:refreshBuildingStatusHUD(data.bdData.un_build_id)
end
end,
update=function(data,time)

end,
reset=function(sw,data)
if UIShopControl:checkReddot(data.bdData)then

local ubdId=data.bdData.un_build_id
sw:SetChildCSImageSprite(_iconIndexs.icon,_hudAtlasAB,"icon_fangshigx")


local _fun=function()UIShopControl.Req_9_16(0)end
sw:SetChildButtonClick(_iconIndexs.click,_fun)
hudControl:doPunchRotation(data,sw)
else
loggerUtil.logErrFMT("商铺HUD状态有误，没有可领取的奖励 {0}",data.bdData.un_build_id)
hudControl:refreshBuildingStatusHUD(data.bdData.un_build_id)
end
end,
},
[hudType.shopAutoCreate]=
{
activeUpdate=true,
init=function(sw,data)
if UIShopControl:checkRcvState(data.bdData)then
sw:SetChildActive(_iconIndexs.natural_root,true)

hudControl.setHUDIcon(sw,_iconIndexs.icon,1,false)
local _fun=function()
UIShopControl:reqAutoCreateRecv(0)
zongmenControl:receiveAllManufactureEx()
end
sw:SetChildButtonClick(_iconIndexs.click,_fun)
hudControl:doPunchRotation(data,sw)
else
loggerUtil.logErrFMT("商铺HUD状态有误，没有可领取的奖励 {0}",data.bdData.un_build_id)
hudControl:refreshBuildingStatusHUD(data.bdData.un_build_id)
end
end,
update=function(data,time)

end,
reset=function(sw,data)
if UIShopControl:checkRcvState(data.bdData)then
sw:SetChildActive(_iconIndexs.natural_root,true)

hudControl.setHUDIcon(sw,_iconIndexs.icon,1,false)
local _fun=function()
UIShopControl:reqAutoCreateRecv(0)
zongmenControl:receiveAllManufactureEx()
end
sw:SetChildButtonClick(_iconIndexs.click,_fun)
hudControl:doPunchRotation(data,sw)
else
loggerUtil.logErrFMT("商铺HUD状态有误，没有可领取的奖励 {0}",data.bdData.un_build_id)
hudControl:refreshBuildingStatusHUD(data.bdData.un_build_id)
end
end,
},
[hudType.eDaoLv]=
{
init=function(sw,data)
local abname
local state=DiscipleCoupleModel:getBuildState(data.bdData.un_build_id)
local iconName=''
if state==0 then
iconName='icon_linghun_1'
abname=globalABLookup.hud_atlas
elseif state==1 then
iconName='icon_zhaomucs'
abname=globalABLookup.hud_atlas
elseif state==2 then
iconName='icon_dizishuangxiu_1'
abname=globalABLookup.hud_atlas
end
sw:SetChildCSImageSprite(1,abname,iconName)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
reset=function(sw,data)
local abname
local state=DiscipleCoupleModel:getBuildState(data.bdData.un_build_id)
local iconName=''
if state==0 then
iconName='icon_linghun_1'
abname=globalABLookup.hud_atlas
elseif state==1 then
iconName='icon_zhaomucs'
abname=globalABLookup.hud_atlas
elseif state==2 then
iconName='icon_dizishuangxiu_1'
abname=globalABLookup.hud_atlas
end
sw:SetChildCSImageSprite(1,abname,iconName)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
end,
update=function(data,time)

end,
},
[hudType.daZhen]=
{
init=function(sw,data)
sw:SetChildActive(3,true)
local isShowSpBg=false
local isShowNewFlag=false
local isSetIcon=false

local hasTeamEmpty=shanMenDaZhenModel:checkDaZhenIsHasEmptyTeam()
if hasTeamEmpty then
sw:SetChildCSImageSprite(_iconIndexs.icon,_hudAtlasAB,'icon_zhaomucs')
isSetIcon=true
end


if not isSetIcon and shanMenDaZhenModel:checkHaveShanmenDaZhen()then

if systemZongMenModel:checkValidNewFightReport()then

isShowSpBg=true
isShowNewFlag=true
sw:SetChildCSImageSprite(_iconIndexs.icon,globalABLookup.hud_atlas,'icon_zmtiaozhanxx_1')
isSetIcon=true
end


local state=shanMenDaZhenModel:getDaZhenState()
if not isSetIcon then
if state==3 then
sw:SetChildCSImageSprite(_iconIndexs.icon,_hudAtlasAB,'icon_sjtishitp_1')
isSetIcon=true
elseif state==2 then
local nowShieldValue=shanMenDaZhenModel:getShanMenDaZhenShieldValue()
local daZhenLv=data.bdData.level-1
local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLv)
local maxShieldValue=daZhenLvCfg.shield

local checkPatchRate=cfgHelper.getdef1(cfg_shanmendazhenconfig,'checkPatch')
local checkPatchValue=math.floor(maxShieldValue*checkPatchRate/100)
if nowShieldValue<=checkPatchValue then
sw:SetChildCSImageSprite(_iconIndexs.icon,_hudAtlasAB,'icon_sjtishitp_1')
isSetIcon=true
end
end
end
end

sw:SetChildActive(4,not isShowSpBg)
sw:SetChildActive(5,isShowSpBg)
sw:SetChildActive(6,isShowNewFlag)
sw:SetChildButtonClick(_iconIndexs.click,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
reset=function(sw,data)
sw:SetChildActive(3,true)
local isShowSpBg=false
local isShowNewFlag=false
local isSetIcon=false

local hasTeamEmpty=shanMenDaZhenModel:checkDaZhenIsHasEmptyTeam()
if hasTeamEmpty then
sw:SetChildCSImageSprite(_iconIndexs.icon,_hudAtlasAB,'icon_zhaomucs')
isSetIcon=true
end


if not isSetIcon and shanMenDaZhenModel:checkHaveShanmenDaZhen()then

if systemZongMenModel:checkValidNewFightReport()then

isShowSpBg=true
isShowNewFlag=true
sw:SetChildCSImageSprite(_iconIndexs.icon,globalABLookup.hud_atlas,'icon_zmtiaozhanxx_1')
isSetIcon=true
end


local state=shanMenDaZhenModel:getDaZhenState()
if not isSetIcon then
if state==3 then
sw:SetChildCSImageSprite(_iconIndexs.icon,_hudAtlasAB,'icon_sjtishitp_1')
isSetIcon=true
elseif state==2 then
local nowShieldValue=shanMenDaZhenModel:getShanMenDaZhenShieldValue()
local daZhenLv=data.bdData.level-1
local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLv)
local maxShieldValue=daZhenLvCfg.shield

local checkPatchRate=cfgHelper.getdef1(cfg_shanmendazhenconfig,'checkPatch')
local checkPatchValue=math.floor(maxShieldValue*checkPatchRate/100)
if nowShieldValue<=checkPatchValue then
sw:SetChildCSImageSprite(_iconIndexs.icon,_hudAtlasAB,'icon_sjtishitp_1')
isSetIcon=true
end
end
end
end

sw:SetChildActive(4,not isShowSpBg)
sw:SetChildActive(5,isShowSpBg)
sw:SetChildActive(6,isShowNewFlag)
sw:SetChildButtonClick(_iconIndexs.click,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)
end,
},
[hudType.konxian]=
{
init=function(sw,data)
local iconName='icon_zmkongxian_1'
sw:SetChildCSImageSprite(1,_hudAtlasAB,iconName)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.yifanglingtian]=
{
init=function(sw,data)

local iconName="icon_zmkongxian_1"
local _hudAtlasAB='ui/windows/hud/hud_sprite_atlas_pak.ab'


if YiFangLingTianModel:GetMaxPlant()then
iconName=YiFangLingTianModel:GetMaturePlantSmallIcon()

sw:SetChildIcon(_iconIndexs.icon,iconName,true)

elseif tostring(YiFangLingTianModel:GetNowDzID())=='0'then
iconName='icon_jztingdun'
_hudAtlasAB='ui/windows/hud/hud_sprite_atlas_pak.ab'
sw:SetChildCSImageSprite(1,_hudAtlasAB,iconName)
elseif YiFangLingTianController:checkAnyPlantMatched()then

iconName='icon_bozhong_1'
_hudAtlasAB="ui/windows/yifanglingtian/yifanglingtian_atlas_pak.ab"
sw:SetChildCSImageSprite(1,_hudAtlasAB,iconName)
else
local gezinum=YiFangLingTianController:getGridUnlockCondNum()
if gezinum>0 then

iconName='icon_kaiken_1'
_hudAtlasAB="ui/windows/yifanglingtian/yifanglingtian_atlas_pak.ab"
sw:SetChildCSImageSprite(1,_hudAtlasAB,iconName)
end

end

sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)

hudControl:doPunchRotation(data,sw)
end,
reset=function(sw,data)

local iconName="icon_zmkongxian_1"
local _hudAtlasAB='ui/windows/hud/hud_sprite_atlas_pak.ab'

if YiFangLingTianModel:GetMaxPlant()then
iconName=YiFangLingTianModel:GetMaturePlantSmallIcon()

sw:SetChildIcon(_iconIndexs.icon,iconName,true)

elseif tostring(YiFangLingTianModel:GetNowDzID())=='0'then
iconName='icon_jztingdun'
_hudAtlasAB='ui/windows/hud/hud_sprite_atlas_pak.ab'
sw:SetChildCSImageSprite(1,_hudAtlasAB,iconName)
elseif YiFangLingTianController:checkAnyPlantMatched()then

iconName='icon_bozhong_1'
_hudAtlasAB="ui/windows/yifanglingtian/yifanglingtian_atlas_pak.ab"
sw:SetChildCSImageSprite(1,_hudAtlasAB,iconName)
else
local gezinum=YiFangLingTianController:getGridUnlockCondNum()
if gezinum>0 then

iconName='icon_kaiken_1'
_hudAtlasAB="ui/windows/yifanglingtian/yifanglingtian_atlas_pak.ab"
sw:SetChildCSImageSprite(1,_hudAtlasAB,iconName)
end
end
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)

hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.chuansongzhen]=
{
init=function(sw,data)
sw:SetChildButtonClick(2,function()
UIManager:showWindow('UIChuanSongZhenWaitRewardWin')
chuanSongZhenController:send_5_96()
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.feishengtai]=
{
init=function(sw,data)
local _hudAtlasAB_2='ui/windows/main/main_sprite_atlas_pak.ab'
local build_id=data.bdData.build_id
local iconName='icon_fangshigx'

if build_id==81 then
if FeiShengTaiModel:judeCanRepairFST()then
iconName='icon_jianzaotishi_1'
end
if FeiShengTaiModel:GetFSTreddot()then
iconName='icon_fangshigx'
end
sw:SetChildButtonClick(2,function()
FeiShengTaiModel:jumptoFST()
end)
else
if DuJieZhiBaoController:checklianhuaSingleReddot(build_id)then
iconName='icon_jianzaotishi_1'
end
sw:SetChildButtonClick(2,function()


DuJieZhiBaoController:JCTJjumpHudBuild(build_id)
end)
end
sw:SetChildCSImageSprite(1,_hudAtlasAB_2,iconName)

hudControl:doPunchRotation(data,sw)
end,
reset=function(sw,data)
local _hudAtlasAB_2='ui/windows/main/main_sprite_atlas_pak.ab'
local build_id=data.bdData.build_id
local iconName='icon_fangshigx'

if build_id==81 then
if FeiShengTaiModel:judeCanRepairFST()then
iconName='icon_jianzaotishi_1'
end
if FeiShengTaiModel:GetFSTreddot()then
iconName='icon_fangshigx'
end
sw:SetChildButtonClick(2,function()
FeiShengTaiModel:jumptoFST()
end)
else
if DuJieZhiBaoController:checklianhuaSingleReddot(build_id)then
iconName='icon_jianzaotishi_1'
end
sw:SetChildButtonClick(2,function()


DuJieZhiBaoController:JCTJjumpHudBuild(build_id)
end)
end
sw:SetChildCSImageSprite(1,_hudAtlasAB_2,iconName)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.airgame]=
{
init=function(sw,data)
sw:SetChildButtonClick(2,function()
UIFullAirGameEnterController:showMainWindow()
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.taixucang]=
{
init=function(sw,data)
local iconName='image_taixucang_1'

sw:SetChildCSImageSprite(1,"ui/windows/taixucang/taixucang_atlas_pak.ab",iconName)
sw:SetChildScale(1,Vector3.New(0.25,0.25,0.25))
sw:SetChildButtonClick(2,function()
if not TaiXuCangModel:checkGetItem()then
return
end
TaiXuCangController:send_6_142()
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.yingxiangeHuZhu]=
{
init=function(sw,data)
local iconName
if data.bdData.build_id==SLG_SYSTEM_TYPE.eYingXianGe then
iconName='icon_xianmenghuzhu_1'
sw:SetChildActive(4,true)
local num=xianjieModel:getHuZhuNum()
sw:SetChildText(5,num)
else
iconName='icon_xianmenghuzhu_1'
sw:SetChildActive(4,false)
end
sw:SetChildCSImageSprite(3,"ui/windows/main/main_sprite_atlas_pak.ab","button_jzshijiantishi_2")
sw:SetChildCSImageSprite(1,"ui/windows/main/main_sprite_atlas_pak.ab",iconName)
sw:SetChildButtonClick(2,function()
if data.bdData.build_id==SLG_SYSTEM_TYPE.eYingXianGe then
xianjieController:reqHelpAll()
elseif data.bdData.build_id==SLG_SYSTEM_TYPE.eYunJiaYing then
local flag,id=yunjiayingModel:checkHasQiuZhu()
local params={tostring(id)}
local pstr=jsonHelper.encode(params)
xianjieController.reqQiuZhu(speedUpType.eYunJiaYingTrain,speedUpMode.eAskHelp,pstr)
elseif data.bdData.build_id==SLG_SYSTEM_TYPE.eYuLingZhai then


xianjieController.reqQiuZhu(speedUpType.eYuLingZhai,speedUpMode.eAskHelp,nil)
end
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.littleworld]=
{
init=function(sw,data)
local abName=globalABLookup.hud_atlas
local iconName='icon_fangshigx'
sw:SetChildCSImageSprite(3,"ui/windows/main/main_sprite_atlas_pak.ab","button_jzshijiantishi_2")
sw:SetChildCSImageSprite(1,abName,iconName)
sw:SetChildButtonClick(2,function()
LittleWorldController.req_37_68()
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.zaoWuGe]=
{
activeUpdate=true,
init=function(sw,data)
local clickFunc=function()end

local isFinishFirstBuild=zaoWuGeModel:checkFinishFirstBuild()

local barPercent=zaoWuGeModel:getHudCDProgressPercent()
sw:SetChildIconFillAmount(_iconIndexs.progressbar,barPercent)

if isFinishFirstBuild then
clickFunc=function()
zaoWuGeController:req_ReceiveBuild()
end
hudControl:doPunchRotation(data,sw)
end

local progressInfo=zaoWuGeModel:getBuildingProgressInfo()
local singleBuildDuration=cfgHelper.get2(cfg_zaowugebaseconfig_get,1,'needTime')

data.startTime=progressInfo.startTime
data.endTime=progressInfo.startTime+singleBuildDuration
data.accTime=singleBuildDuration
data.showProgressBar=not isFinishFirstBuild
data.complete=zaoWuGeModel:checkFinishBuild()
data.progress=barPercent

local suitId=zaoWuGeModel:getBuildSuitId()
local icon=cfgHelper.get2(cfg_zaowugesuitconfig_get,suitId,'icon')

sw:SetChildCSImageSprite(1,"ui/windows/zaowuge/zaowuge_atlas_pak.ab",icon)
sw:SetChildScale(1,Vector3.one*0.4)

sw:SetChildActive(4,true)

sw:SetChildButtonClick(2,function()
clickFunc()
end,true)
end,
reset=function(sw,data)
hudControl:removeStateHUDTweener(data)

local clickFunc=function()end

local suitId=zaoWuGeModel:getBuildSuitId()
local icon=cfgHelper.get2(cfg_zaowugesuitconfig_get,suitId,'icon')

sw:SetChildCSImageSprite(1,"ui/windows/zaowuge/zaowuge_atlas_pak.ab",icon)
sw:SetChildScale(1,Vector3.one*0.4)
local barPercent=zaoWuGeModel:getHudCDProgressPercent()
sw:SetChildIconFillAmount(_iconIndexs.progressbar,barPercent)

local isFinishFirstBuild=zaoWuGeModel:checkFinishFirstBuild()
if isFinishFirstBuild then
clickFunc=function()
zaoWuGeController:req_ReceiveBuild()
end
hudControl:doPunchRotation(data,sw)
end

local progressInfo=zaoWuGeModel:getBuildingProgressInfo()
local singleBuildDuration=cfgHelper.get2(cfg_zaowugebaseconfig_get,1,'needTime')

data.startTime=progressInfo.startTime
data.endTime=progressInfo.startTime+singleBuildDuration
data.accTime=singleBuildDuration
data.showProgressBar=not isFinishFirstBuild
data.complete=zaoWuGeModel:checkFinishBuild()
data.progress=barPercent

sw:SetChildActive(4,true)

sw:SetChildButtonClick(2,function()
clickFunc()
end,true)
end,
update=function(data,time)
if data.complete then return end
if not data.showProgressBar then return end

local sw=hudControl:getSubWidget(data)
local barPercent=zaoWuGeModel:getHudCDProgressPercent()
sw:SetChildIconFillAmount(_iconIndexs.progressbar,barPercent)

if time>=data.endTime then
zaoWuGeController.refreshHud()
end
end,
},
[hudType.eYanDaoTai]=
{
activeUpdate=true,
init=function(sw,data)
local isShowBar=false
local scale=Vector3(1,1,1)
local iconName=''
local animationId=eAnimationID.stand
local entityId=data.bdData.entityId
local state,icon,id=yandaotaiController:checkHudState()

if state==1 then
isShowBar=true
scale=Vector3(0.8,0.8,0.8)
iconName=icon

sw:SetChildIcon(1,iconName,false)
sw:SetChildButtonClick(2,function()
yandaotaiController.send_6_178(1,{id})
buildingEffectControl:playEffectByEID(entityId,SLG_SYSTEM_TYPE.eYanDaoTai,buildEffectType.eYanDaoTai)
end)
hudControl:doPunchRotation(data,sw)
sw:SetChildIconFillAmount(_iconIndexs.progressbar,1)
elseif state==2 then
iconName='icon_kejiyanjiu_01'
local abname=globalABLookup.hud_atlas

hudControl:doPunchRotation(data,sw)
sw:SetChildCSImageSprite(1,abname,iconName)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
elseif state==3 then
animationId=2920
local canQiuZhu=xianjieModel:getIsCanQiuzhu(speedUpMode.eAskHelp,9)
if canQiuZhu then
iconName='icon_xianmenghuzhu_1'
local abname=globalABLookup.hud_atlas

sw:SetChildCSImageSprite(1,abname,iconName)
sw:SetChildButtonClick(2,function()
local level=yandaotaiModel:getTechnologyListLevel(id)or 0
local params={tostring(id),tostring(level+1)}
local pstr=jsonHelper.encode(params)
xianjieController.reqQiuZhu(speedUpType.eYanDaoTai,speedUpMode.eAskHelp,pstr)
end)
hudControl:doPunchRotation(data,sw)
else
isShowBar=true
scale=Vector3(0.8,0.8,0.8)
iconName=icon
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)

local level=yandaotaiModel:getTechnologyListLevel(id)or 0
local config=cfgHelper.get2(cfg_technologyconfig_get,id,level+1)
local value2=DianFengLevelModel:getDFXianBaoBuildPercent(3)
local study_time=yandaotaiController.getchangeSpeed(config.study_time,value2)
local isComplete,curTime,cdTime,startTime=yandaotaiModel:checkStudyisFinishTime(id,study_time)
local person=curTime/study_time

sw:SetChildIcon(1,iconName,false)
sw:SetChildIconFillAmount(_iconIndexs.progressbar,person)

data.startTime=startTime
data.endTime=startTime+study_time
data.accTime=cdTime
data.showProgressBar=true
data.complete=isComplete
data.progress=person
end
end

sw:SetChildScale(1,scale)
sw:SetChildActive(4,isShowBar)

_MapManager.RunAnimator(entityId,animationId)
end,
reset=function(sw,data)
hudControl:removeStateHUDTweener(data)

local isShowBar=false
local scale=Vector3(1,1,1)
local iconName=''
local animationId=eAnimationID.stand
local entityId=data.bdData.entityId
local state,icon,id=yandaotaiController:checkHudState()

if state==1 then
isShowBar=true
scale=Vector3(0.8,0.8,0.8)
iconName=icon
hudControl:doPunchRotation(data,sw)
sw:SetChildIcon(1,iconName,false)
sw:SetChildButtonClick(2,function()
yandaotaiController.send_6_178(1,{id})
buildingEffectControl:playEffectByEID(entityId,SLG_SYSTEM_TYPE.eYanDaoTai,buildEffectType.eYanDaoTai)
end)
sw:SetChildIconFillAmount(_iconIndexs.progressbar,1)
elseif state==2 then
iconName='icon_kejiyanjiu_01'
local abname=globalABLookup.hud_atlas

hudControl:doPunchRotation(data,sw)
sw:SetChildCSImageSprite(1,abname,iconName)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)
elseif state==3 then
animationId=2920
local canQiuZhu=xianjieModel:getIsCanQiuzhu(speedUpMode.eAskHelp,9)
if canQiuZhu then
iconName='icon_xianmenghuzhu_1'
local abname=globalABLookup.hud_atlas

hudControl:doPunchRotation(data,sw)
sw:SetChildCSImageSprite(1,abname,iconName)
sw:SetChildButtonClick(2,function()
local level=yandaotaiModel:getTechnologyListLevel(id)or 0
local params={tostring(id),tostring(level+1)}
local pstr=jsonHelper.encode(params)
xianjieController.reqQiuZhu(speedUpType.eYanDaoTai,speedUpMode.eAskHelp,pstr)
end)
else
isShowBar=true
scale=Vector3(0.8,0.8,0.8)
iconName=icon

sw:SetChildIcon(1,iconName,false)
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)

local level=yandaotaiModel:getTechnologyListLevel(id)or 0
local config=cfgHelper.get2(cfg_technologyconfig_get,id,level+1)
local value2=DianFengLevelModel:getDFXianBaoBuildPercent(3)
local study_time=yandaotaiController.getchangeSpeed(config.study_time,value2)
local isComplete,curTime,cdTime,startTime=yandaotaiModel:checkStudyisFinishTime(id,study_time)
local person=curTime/study_time

sw:SetChildIcon(1,iconName,false)
sw:SetChildIconFillAmount(_iconIndexs.progressbar,person)

data.startTime=startTime
data.endTime=startTime+study_time
data.accTime=cdTime
data.showProgressBar=true
data.complete=isComplete
data.progress=person
end
end

sw:SetChildScale(1,scale)
sw:SetChildActive(4,isShowBar)

_MapManager.RunAnimator(entityId,animationId)
end,
update=function(data,time)
local isShowBar=false
local scale=Vector3(1,1,1)
local iconName=''
local sw=hudControl:getSubWidget(data)
local state,icon,id=yandaotaiController:checkHudState()

if not data.complete and state~=2 then
isShowBar=true
iconName=icon
sw:SetChildButtonClick(2,function()
isometricMapSystem:openBuildingWin(data.bdData)
end)

if state==3 then
local canQiuZhu=xianjieModel:getIsCanQiuzhu(speedUpMode.eAskHelp,9)
if canQiuZhu then
iconName='icon_xianmenghuzhu_1'
local abname=globalABLookup.hud_atlas

hudControl:doPunchRotation(data,sw)
sw:SetChildCSImageSprite(1,abname,iconName)
sw:SetChildButtonClick(2,function()
local level=yandaotaiModel:getTechnologyListLevel(id)or 0
local params={tostring(id),tostring(level+1)}
local pstr=jsonHelper.encode(params)
xianjieController.reqQiuZhu(speedUpType.eYanDaoTai,speedUpMode.eAskHelp,pstr)
end)
else
local level=yandaotaiModel:getTechnologyListLevel(id)or 0
local config=cfgHelper.get2(cfg_technologyconfig_get,id,level+1)
local value2=DianFengLevelModel:getDFXianBaoBuildPercent(3)
local study_time=yandaotaiController.getchangeSpeed(config.study_time,value2)
local isComplete,curTime,cdTime,startTime=yandaotaiModel:checkStudyisFinishTime(id,study_time)
local person=curTime/study_time

data.startTime=startTime
data.endTime=startTime+study_time
data.accTime=cdTime
data.showProgressBar=true
data.complete=isComplete
data.progress=person

sw:SetChildIconFillAmount(_iconIndexs.progressbar,person)
end
else
data.complete=true
data.showProgressBar=false
hudControl:doPunchRotation(data,sw)
end
end
end,
},
[hudType.yulingzhai]=
{
activeUpdate=true,
init=function(sw,data)

local state=YuLingZhaiModel:getHealType()
if state>1 then
local iconName='icon_ylzkuaisuzhiliaozhong_1'
local abName=globalABLookup.hud_atlas
sw:SetChildCSImageSprite(_iconIndexs.icon,abName,iconName)

local stamp=timeHelper.getServerShortTime()

data.startTime=YuLingZhaiModel:getHealStartTime()
data.endTime=YuLingZhaiModel:getEndStamp()

local person=math.min(1,(stamp-data.startTime)/(data.endTime-data.startTime))or 0
sw:SetChildIconFillAmount(_iconIndexs.progressbar,person)

sw:SetChildButtonClick(_iconIndexs.click,function()
UIFullYuLingZhaiControl:showMainWindow()
end)

data.showProgressBar=true
data.complete=stamp>=data.endTime
data.progress=person
data.healstate=state
data.accTime=YuLingZhaiModel:getServerAccTime()
end
end,
update=function(data,time)
if data.showProgressBar and not data.complete then

local state=YuLingZhaiModel:getHealType()
local acctime=YuLingZhaiModel:getServerAccTime()
if data.healstate~=state or acctime~=data.accTime then
data.startTime=YuLingZhaiModel:getHealStartTime()
data.endTime=YuLingZhaiModel:getEndStamp()
data.healstate=state
data.accTime=acctime
end
local sw=hudControl:getSubWidget(data)

local stamp=timeHelper.getServerShortTime()
local person=math.min(1,(stamp-data.startTime)/(data.endTime-data.startTime))or 0


if person==1 then
data.complete=true


hudControl:doPunchRotation(data,sw)
end
data.progress=person
sw:SetChildUIProgressbar(_iconIndexs.progressbar,person,1)
end
end,
},
[hudType.yulingzhaispeed]=
{
init=function(sw,data)
local flag,num=UIFullWanBaoXunBaoDuiController:checkReddot()
local abName=globalABLookup.hud_atlas
local iconName='icon_ylzkuaisuzhiliao_1'
sw:SetChildCSImageSprite(3,abName,"button_jzshijiantishi_2")
sw:SetChildCSImageSprite(1,globalABLookup.mainwin,iconName)
sw:SetChildButtonClick(2,function()
UIFullYuLingZhaiControl:showMainWindow()
end)
hudControl:doPunchRotation(data,sw)
end,
update=function(data,time)

end,
},
[hudType.yunjiaying]=
{
activeUpdate=true,
init=function(sw,data)
local bdData=data.bdData
local iconname="icon_yjyxunlianzhong_1"
local abname=globalABLookup.hud_atlas
sw:SetChildCSImageSprite(_iconIndexs.icon,abname,iconname)


local cddata=buildingCDControl:getCDData(buildingCDType.xjtrain,bdData.un_build_id,true)
if cddata==nil then return end
local nTime=cddata.ntime
local leftTime=cddata.leftTime
local detlaTime=nTime-leftTime
local percent=nTime<=0 and 0 or detlaTime/nTime
sw:SetChildIconFillAmount(_iconIndexs.progressbar,percent)

sw:SetChildButtonClick(_iconIndexs.click,function()
UIFullYunJiaYingControl:showYunJiaYingWindow({entityId=bdData.entityId})
end)

data.showProgressBar=true
data.complete=false
data.progress=0
end,
reset=function(sw,data)

data.showProgressBar=true
data.complete=false
data.progress=0
hudControl:removeStateHUDTweener(data)

local iconname="icon_yjyxunlianzhong_1"
local abname=globalABLookup.hud_atlas
sw:SetChildCSImageSprite(_iconIndexs.icon,abname,iconname)


local cddata=buildingCDControl:getCDData(buildingCDType.xjtrain,data.bdData.un_build_id,true)
if cddata==nil then return end
local dt=cddata.dtime
local nt=cddata.ntime
local percent=nt<=0 and 0 or dt/nt*10000
sw:SetChildUIProgressbar(_iconIndexs.progressbar,percent,10000,false)
end,
update=function(data,time)
if data.showProgressBar and not data.complete then
local sw=hudControl:getSubWidget(data)
local bdData=data.bdData
local cddata=buildingCDControl:getCDData(buildingCDType.xjtrain,bdData.un_build_id,true)
if cddata==nil then return end

if cddata.complete then
data.complete=true
sw:SetChildUIProgressbar(_iconIndexs.progressbar,1,1,false)
hudControl:doPunchRotation(data,sw)
else
local dt=cddata.dtime
local nt=cddata.ntime
local percent=nt<=0 and 0 or dt/nt*10000
sw:SetChildUIProgressbar(_iconIndexs.progressbar,percent,10000,false)
end
end
end,
},
[hudType.xianbang]=
{
init=function(sw,data)
local isreddot,flag=xianjiexianbangModel:XBhavetasksReddot()
if isreddot then
local iconName
if flag==1 then
iconName='icon_fangshigx'
elseif flag==2 then
iconName='icon_zhaomucs'
end
if iconName then
sw:SetChildCSImageSprite(1,_hudAtlasAB,iconName)
sw:SetChildButtonClick(2,function()
if flag==1 then
xianjiexianbangController:send_37_82()
elseif flag==2 then
isometricMapSystem:openBuildingWin(data.bdData)
end
end)
hudControl:doPunchRotation(data,sw)
end
end
end,
reset=function(sw,data)
local isreddot,flag=xianjiexianbangModel:XBhavetasksReddot()
if isreddot then
local iconName
if flag==1 then
iconName='icon_fangshigx'
elseif flag==2 then
iconName='icon_zhaomucs'
end
if iconName then
sw:SetChildCSImageSprite(1,_hudAtlasAB,iconName)
sw:SetChildButtonClick(2,function()
if flag==1 then
xianjiexianbangController:send_37_82()
elseif flag==2 then
isometricMapSystem:openBuildingWin(data.bdData)
end
end)
hudControl:doPunchRotation(data,sw)
end
end
end,
update=function(data,time)

end,
},
[hudType.danfangget]=
{
init=function(sw,data)
local bdData=data.bdData
sw:SetChildActive(_iconIndexs.natural_root,true)
sw:SetChildIcon(_iconIndexs.icon,"icon_item_12001",false)
sw:SetChildButtonClick(_iconIndexs.click,function()
isometricMapSystem:openBuildingWin(bdData)
end)
data.showProgressBar=false
hudControl:doPunchRotation(data,sw)

data.complete=false
end,
update=function(data,time)

end,
},
[hudType.autobuilding]=
{
init=function(sw,data)
local un_build_id=data.bdData.un_build_id or 1
if AutoBuildController:checkAutoBuildingGetRewards(un_build_id)then
local sfId=AutoBuildModel:getAutoBuildingSfid(un_build_id)
local iconname=iconHelper.getIconName(1)
sw:SetChildButtonClick(2,function()
XianMengBaoXiaController:send_6_198(sfId,un_build_id)
end)
sw:SetChildIcon(1,iconname,false)
hudControl:doPunchRotation(data,sw)
end
end,
reset=function(sw,data)
local un_build_id=data.bdData.un_build_id or 1
if AutoBuildController:checkAutoBuildingGetRewards(un_build_id)then
local sfId=AutoBuildModel:getAutoBuildingSfid(un_build_id)
local iconname=iconHelper.getIconName(1)
sw:SetChildButtonClick(2,function()
XianMengBaoXiaController:send_6_198(sfId,un_build_id)
end)
sw:SetChildIcon(1,iconname,false)
end
end,
update=function(data,time)

end,
},
[hudType.yushoufang]=
{
activeUpdate=true,
init=function(sw,data)
local un_build_id=data.bdData.un_build_id
local isreddot,flag=yushoufangModel.hasReddotInfo(un_build_id)
if isreddot then
if flag==1 then

data.showProgressBar=false
sw:SetChildActive(10,true)
sw:SetChildActive(9,false)
sw:SetChildActive(4,false)
sw:SetChildActive(5,false)
sw:SetChildButtonClick(2,function()
yushoufangController:send_3_227(un_build_id)
end)
hudControl:doPunchRotation(data,sw)
elseif flag==2 then

sw:SetChildActive(10,false)
sw:SetChildActive(9,true)
sw:SetChildActive(4,false)
sw:SetChildActive(5,false)
sw:SetChildButtonClick(2,function()
yushoufangController:send_3_226(un_build_id)
end)
hudControl:doPunchRotation(data,sw)
elseif flag==3 then

sw:SetChildActive(10,false)
sw:SetChildActive(9,false)
sw:SetChildActive(4,true)
sw:SetChildActive(5,true)
local new_lsdatas=yushoufangModel:getLSNewDataByBuildID(un_build_id)
if new_lsdatas then
local new_lsdata=new_lsdatas[1]
comHelper.setChildModelRawImage_lingshou(sw,new_lsdata.id,11,0,eHeadCenterType.eHead,1)
end

hudControl:removeStateHUDTweener(data)
local person=buildingCDControl:getPercent(buildingCDType.yushoufang,data.bdData.un_build_id)or 0
sw:SetChildIconFillAmount(_iconIndexs.progressbar,person)
sw:SetChildButtonClick(2,function()
UIManager.info('灵兽繁育中')
end)
data.showProgressBar=true
data.complete=false
data.progress=0
end
end
end,
reset=function(sw,data)
local un_build_id=data.bdData.un_build_id
local isreddot,flag=yushoufangModel.hasReddotInfo(un_build_id)
if isreddot then
if flag==1 then

data.showProgressBar=false
sw:SetChildActive(10,true)
sw:SetChildActive(9,false)
sw:SetChildActive(4,false)
sw:SetChildActive(5,false)
sw:SetChildButtonClick(2,function()
yushoufangController:send_3_227(un_build_id)
end)
hudControl:doPunchRotation(data,sw)
elseif flag==2 then


sw:SetChildActive(10,false)
sw:SetChildActive(9,true)
sw:SetChildActive(4,false)
sw:SetChildActive(5,false)
sw:SetChildButtonClick(2,function()
yushoufangController:send_3_226(un_build_id)
end)
hudControl:doPunchRotation(data,sw)
elseif flag==3 then

sw:SetChildActive(10,false)
sw:SetChildActive(9,false)
sw:SetChildActive(4,true)
sw:SetChildActive(5,true)
local new_lsdatas=yushoufangModel:getLSNewDataByBuildID(un_build_id)
if new_lsdatas then
local new_lsdata=new_lsdatas[1]
comHelper.setChildModelRawImage_lingshou(sw,new_lsdata.id,11,0,eHeadCenterType.eHead,1)
end
hudControl:removeStateHUDTweener(data)

local person=buildingCDControl:getPercent(buildingCDType.yushoufang,data.bdData.un_build_id)or 0
sw:SetChildIconFillAmount(_iconIndexs.progressbar,person)
sw:SetChildButtonClick(2,function()
UIManager.info('灵兽繁育中')
end)
data.showProgressBar=true
data.complete=false
data.progress=0
end
end
end,
update=function(data,time)

if data.showProgressBar then
local sw=hudControl:getSubWidget(data)
local un_build_id=data.bdData.un_build_id
local isreddot,flag=yushoufangModel.hasReddotInfo(un_build_id)

if isreddot then
if flag==1 then

data.showProgressBar=false
sw:SetChildActive(10,true)
sw:SetChildActive(9,false)
sw:SetChildActive(4,false)
sw:SetChildActive(5,false)
sw:SetChildButtonClick(2,function()
yushoufangController:send_3_227(un_build_id)
end)
hudControl:doPunchRotation(data,sw)
elseif flag==2 then

sw:SetChildActive(10,false)
sw:SetChildActive(9,true)
sw:SetChildActive(4,false)
sw:SetChildActive(5,false)
sw:SetChildButtonClick(2,function()
yushoufangController:send_3_226(un_build_id)
end)
hudControl:doPunchRotation(data,sw)
elseif flag==3 then

sw:SetChildActive(10,false)
sw:SetChildActive(9,false)
sw:SetChildActive(4,true)
sw:SetChildActive(5,true)
local new_lsdatas=yushoufangModel:getLSNewDataByBuildID(un_build_id)
if new_lsdatas then
local new_lsdata=new_lsdatas[1]
comHelper.setChildModelRawImage_lingshou(sw,new_lsdata.id,11,0,eHeadCenterType.eHead,1)
end
hudControl:removeStateHUDTweener(data)
data.showProgressBar=true
data.complete=false
data.progress=0

local cddata=buildingCDControl:getCDData(buildingCDType.yushoufang,data.bdData.un_build_id,true)
if cddata==nil then return end
local dt=cddata.dtime
local needtime=cddata.ntime
if dt>=needtime then
data.complete=true
sw:SetChildButtonClick(_iconIndexs.click,function()

yushoufangController:send_3_227(data.bdData.un_build_id)
end)
hudControl:doPunchRotation(data,sw)
end

dt=dt+1
local cp=dt/needtime
local dv=cp-data.progress

if dv>=0.01 or cp>=1 then
data.progress=cp
sw:SetChildUIProgressbar(_iconIndexs.progressbar,dt,needtime)
end
end
end
end
end,
},
[hudType.yushoufang_kefumo]=
{
activeUpdate=true,
init=function(sw,data)
local un_build_id=data.bdData.un_build_id
local isreddot,flag=yushoufangModel.hasReddotInfo(un_build_id)
if isreddot then
if flag==2 then

sw:SetChildCSImageSprite(1,_hudysfAB,"icon_sjgantanhao")
sw:SetChildButtonClick(2,function()
yushoufangController:send_3_226(un_build_id)
end)
hudControl:doPunchRotation(data,sw)
end
end
end,
reset=function(sw,data)
local un_build_id=data.bdData.un_build_id
local isreddot,flag=yushoufangModel.hasReddotInfo(un_build_id)
if isreddot then
if flag==2 then

sw:SetChildCSImageSprite(1,_hudysfAB,"icon_sjgantanhao")
sw:SetChildButtonClick(2,function()
yushoufangController:send_3_226(un_build_id)
end)
hudControl:doPunchRotation(data,sw)
end
end
end,
update=function(data,time)

end,
},
[hudType.yushoufang_lingqu]=
{
activeUpdate=true,
init=function(sw,data)
local un_build_id=data.bdData.un_build_id
local isreddot,flag=yushoufangModel.hasReddotInfo(un_build_id)
if isreddot then
if flag==1 then

sw:SetChildCSImageSprite(1,_hudysfAB2,"icon_linshou1")
sw:SetChildButtonClick(2,function()
yushoufangController:send_3_227(un_build_id)
end)
hudControl:doPunchRotation(data,sw)
end
end
end,
reset=function(sw,data)
local un_build_id=data.bdData.un_build_id
local isreddot,flag=yushoufangModel.hasReddotInfo(un_build_id)
if isreddot then
if flag==1 then

sw:SetChildCSImageSprite(1,_hudysfAB2,"icon_linshou1")
sw:SetChildButtonClick(2,function()
yushoufangController:send_3_227(un_build_id)
end)
hudControl:doPunchRotation(data,sw)
end
end
end,
update=function(data,time)

end,
},
}

function hudControl:doPunchRotation(data,sw)
if webGLHelper:isHidePunchAni()then return end
self:removeStateHUDTweener(data)
sw:SetChildRotation(_iconIndexs.root,0,0,0)
local tweener=sw:SetChildDOPunchRotation(_iconIndexs.root,Vector3(0,0,15),2,6,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
data.tweener=tweener
end

function hudControl:removeStateHUD(data)
if data.hud then
local hudid=data.hud

data.hud=nil
data.status=nil
data.type=nil
data.firstUpdate=nil
self:removeHUD(hudid)
end
end

function hudControl:removeStateHUDTweener(data)
if data.tweener then
data.tweener:Rewind()
data.tweener:Kill()
data.tweener=nil
end
end

function hudControl:getSubWidget(data)
local widget=self:getHUDWidget(data.hud)





local sw=widget:GetWidget(data.status)
return sw
end

function hudControl:getConditionFunction(cfg)
local ptype=cfg.win_type
local func=_condition_wt[ptype]
if not func then
func=_condition_bt[cfg.build_type]
end
return func
end

function hudControl:getHudTypeByConditionFunction(cfg,bdData)














local htype1
local sortValue1=0
local func=_condition_wt[cfg.win_type]
if func then
local stype1,rtype1=func(bdData)
if stype1 then
if rtype1==2 then
sortValue1=cfgHelper.get2(cfg_buildinghudsortconfig_get,stype1,'sort_value')
local htn=cfgHelper.get2(cfg_buildinghudsortconfig_get,stype1,'hud_type')
htype1=hudType[htn]
else
htype1=stype1
end
end
end

local htype2
local sortValue2=0
func=_condition_bt[cfg.build_type]
if func then
local stype2,rtype2
xpcall(function()
stype2,rtype2=func(bdData)
end,function(err)
logErr(err)
end)
if stype2 then
if rtype2==2 then
sortValue2=cfgHelper.get2(cfg_buildinghudsortconfig_get,stype2,'sort_value')
local htn=cfgHelper.get2(cfg_buildinghudsortconfig_get,stype2,'hud_type')
htype2=hudType[htn]
else
htype2=stype2
end
end
end

if htype1 then
if htype2 then
return sortValue2>sortValue1 and htype2 or htype1
else
return htype1
end
else
return htype2
end
end

function hudControl:getHudTypeByRCFunction(cfg,bdData)
local ptype=cfg.win_type
local func=_condition_repair[ptype]
local htype
if func then
htype=func(bdData)
end
return htype
end

function hudControl:hideHUD(sw,data)
if data.status then
sw:SetChildActive(_iconIndexs.root,false)
end
end

function hudControl:showHUD(sw)
sw:SetChildActive(_iconIndexs.root,true)
end

function hudControl:setHUDShow(bdId,bShow)
local data=self.progressData[bdId]
if data and data.hud then
local widget=self:getHUDWidget(data.hud)
widget:SetChildActive(_iconIndexs.root,bShow)
end
end

function hudControl:getHudDefineData(htype)
return _state_hud_function[htype]
end

local _batch_icon_list=
{
eMoneyType.mtLingShi,
eMoneyType.mtLingYu,
eMoneyType.mtXianYu,
eMoneyType.mtLingCao,
eMoneyType.mtLingMu,
eMoneyType.mtTieKuang,
eMoneyType.mtLingDan,
eMoneyType.mtFuZhi,
eMoneyType.mtXuanTie,
eMoneyType.mtZhenShi
}
local _batch_icon_lookup={}
for k,v in pairs(_batch_icon_list)do
_batch_icon_lookup[k]=true
end



function hudControl.getIconName(itemid)
return iconHelper.getIconName(itemid),_batch_icon_lookup[itemid]==true
end

function hudControl.setHUDIcon(widget,index,itemid,native)
if api_Available_SetChildCSImage()then
local iconName,flag=hudControl.getIconName(itemid)
if flag then
widget:SetChildCSImage(index,globalABLookup.hud_atlas,iconName,native)
else
widget:SetChildIcon(index,iconName,native)
end
else
local iconName=iconHelper.getIconName(itemid)
widget:SetChildIcon(index,iconName,native)
end
end
