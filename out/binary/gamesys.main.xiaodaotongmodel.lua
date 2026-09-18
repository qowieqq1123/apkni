







xiaodaotongModel={}


local buildOpenLookup=nil

local systemOpenLookup=nil

local typsLookup=nil
local typesNum=nil
local resultLookup=nil
xiaodaotongModel.refreshTime=5
local refreshNum=5
local reddotNum=0
local talksLookup=nil
local talksLookup2=nil
local zhahuopucallbackpage=3
local repairLookup={
[SLG_SYSTEM_TYPE.eHouShanMiJing]=true,
[SLG_SYSTEM_TYPE.eYueLongChi]=true,
[SLG_SYSTEM_TYPE.eBaoLingShu]=true,
[SLG_SYSTEM_TYPE.eXianZhan]=true,
[SLG_SYSTEM_TYPE.eFeiShengTai2]=true,
[SLG_SYSTEM_TYPE.eDuJieZhiBaoHuo]=true,
[SLG_SYSTEM_TYPE.eDuJieZhiBaoJin]=true,
[SLG_SYSTEM_TYPE.eDuJieZhiBaoMu]=true,
[SLG_SYSTEM_TYPE.eDuJieZhiBaoShui]=true,
[SLG_SYSTEM_TYPE.eDuJieZhiBaoTu]=true,
}
local repairLookupSysOpen=
{
[SLG_SYSTEM_TYPE.eFeiShengTai2]=function()
return systemModel.isOpen(SYSTEM_DEFINE.eFeiShengTai)
end,
[SLG_SYSTEM_TYPE.eDuJieZhiBaoHuo]=function()
return systemModel.isOpen(SYSTEM_DEFINE.eDuJieZhiBao)
end,
[SLG_SYSTEM_TYPE.eDuJieZhiBaoJin]=function()
return systemModel.isOpen(SYSTEM_DEFINE.eDuJieZhiBao)
end,
[SLG_SYSTEM_TYPE.eDuJieZhiBaoMu]=function()
return systemModel.isOpen(SYSTEM_DEFINE.eDuJieZhiBao)
end,
[SLG_SYSTEM_TYPE.eDuJieZhiBaoShui]=function()
return systemModel.isOpen(SYSTEM_DEFINE.eDuJieZhiBao)
end,
[SLG_SYSTEM_TYPE.eDuJieZhiBaoTu]=function()
return systemModel.isOpen(SYSTEM_DEFINE.eDuJieZhiBao)
end,
}

local checkOpenLookup={

[0]=function(cfg)
local buildType=cfg.buildType
local flag=buildOpenLookup[buildType]
if flag==nil then
if zongmenModel:haveBuildByBuildType(buildType)then
flag=true
end
buildOpenLookup[buildType]=flag
end
return flag==true
end,

[1]=function(cfg,isOnlyCheckOpen)
if isOnlyCheckOpen then
local isOpen=limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eXianMengDiGong)
if not isOpen then
return isOpen
end

return xianmengdigongController:checkOpen()
end
return limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eXianMengDiGong)
end,

[2]=function(cfg,isOnlyCheckOpen)
if isOnlyCheckOpen then
return limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eShangGuXianDi)
end
return limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eShangGuXianDi)
end,

[3]=function(cfg,isOnlyCheckOpen)
if isOnlyCheckOpen then
return limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eWenDouLeiTai)
end
return limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eWenDouLeiTai)
end,

[4]=function(cfg,isOnlyCheckOpen)
if isOnlyCheckOpen then
return limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eTianYuanShouChao)
end
return limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eTianYuanShouChao)
end,

[5]=function(cfg,isOnlyCheckOpen)
if isOnlyCheckOpen then
return limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eYiYuHuiYou)
end
return limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eYiYuHuiYou)
end,

[6]=function(cfg,isOnlyCheckOpen)
if isOnlyCheckOpen then
return limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eShiJieShouLing)
end
return limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eShiJieShouLing)
end,

[7]=function()
local sysid=SYSTEM_DEFINE.eCatSalesMan
local flag=systemOpenLookup[sysid]
if flag==nil then
if systemModel.isOpen(sysid)then
flag=true
end
systemOpenLookup[sysid]=flag
end
return flag==true
end,

[8]=function()
local buildType=24
local flag=buildOpenLookup[buildType]
if flag==nil then
if zongmenModel:haveBuildByBuildType(buildType)then
flag=true
end
buildOpenLookup[buildType]=flag
end
return flag==true
end,

[9]=function(cfg,isOnlyCheckOpen)
if isOnlyCheckOpen then
return limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eLingXuWenJian)
end
return limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eLingXuWenJian)
end,

[10]=function()
local sysid=SYSTEM_DEFINE.eXiTongZongMen
local flag=systemOpenLookup[sysid]
if flag==nil then
if systemModel.isOpen(sysid)then
flag=true
end
systemOpenLookup[sysid]=flag
end
return flag
end,

[11]=function()
local buildType=SLG_SYSTEM_TYPE.eBaoLingShu
local d=isometricMapSystem:getAllUnlockRepairDataByID(buildType)
return d~=nil
end,

[12]=function()
local buildType=SLG_SYSTEM_TYPE.eHouShanMiJing
local d=isometricMapSystem:getAllUnlockRepairDataByID(buildType)
return d~=nil
end,

[13]=function()
local sysid=SYSTEM_DEFINE.eCatCatMiJing
local flag=systemOpenLookup[sysid]
if flag==nil then
if systemModel.isOpen(sysid)then
flag=true
end
systemOpenLookup[sysid]=flag
end
return flag
end,

[14]=function()
if not xiangongpingdingModel:isOpenSys()then return false end
if xiangongpingdingModel:hasAnyPrize()then
return false
end
return xiangongpingdingModel:isReady()
end,

[15]=function()
if not xiangongpingdingModel:isOpenSys()then return false end
if xiangongpingdingModel:hasLjPrize()then
return true
end
return false
end,
[16]=function()
return systemModel.isOpen(SYSTEM_DEFINE.eProsperity)
end,

[17]=function()
if not xiangongpingdingModel:isOpenSys()then return false end
if xiangongpingdingModel:hasAnyPrize()then
return false
end
return xiangongpingdingModel:isDoing()
end,

[18]=function()
if not xiangongpingdingModel:isOpenSys()then return false end
if xiangongpingdingModel:isCanPrize()then
return true
end
return false
end,

[19]=function(cfg,isOnlyCheckOpen)
if limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eZhengZhanShanHai)then
if zhengzhanshanhaiModel:checkJoin()then
local raceState=zhengzhanshanhaiModel:getLunState()
if raceState==eZZSH_State.ePVEFight then
return true
end
end
end
return false
end,

[20]=function(cfg,isOnlyCheckOpen)
if limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eZhengZhanShanHai)then
if zhengzhanshanhaiModel:checkJoin()then
return true
end
end
return false
end,

[21]=function(cfg,isOnlyCheckOpen)
if limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eZhengZhanShanHai)then
if zhengzhanshanhaiModel:checkJoin()then
return true
end
end
return false
end,

[22]=function()
if systemModel.isOpen(SYSTEM_DEFINE.eXianFaWenDao)and UIXianFaWenDaoControl:checkUnlock()then
return true
end
return false
end,

[23]=function()
if systemModel.isOpen(SYSTEM_DEFINE.eVisitor)and zmvisitchallengeModel:checkFirstClickReddot()then
return true
end
return false
end,

[24]=function()
if systemModel.isOpen(SYSTEM_DEFINE.eVisitor)and zmvisitchallengeModel:checkBigRewardReddot()then
return true
end
return false
end,

[25]=function()
if systemModel.isOpen(SYSTEM_DEFINE.eXianFaWenDao)and UIXianFaWenDaoControl:checkUnlock()then
local cfg=cfgHelper.get1(cfg_xianfawendaoconfig_get,1)
local btime,etime=UIXianFaWenDaoControl:getSessionTime()
local currtime=gameUtilityModel.getServerShortTime()
if cfg.signup and btime and etime then
local regEndTime=btime+cfg.signup*86400
if currtime<regEndTime then
local isReg=UIXianFaWenDaoControl:getRegister()
if not isReg then
return true
end
end
end
end
return false
end,

[26]=function(cfg,isOnlyCheckOpen)
if limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eZhengZhanShanHai)then
if zhengzhanshanhaiModel:checkJoin()then
return true
end
end
return false
end,

[27]=function(cfg,isOnlyCheckOpen)
return true
end,

[28]=function(cfg,isOnlyCheckOpen)
local isComplete=JiuChongTianJieEnterModel:isJiuChongTianJieComplete()
local zmLevel=zongmenModel:getLevel()or 1
local state=JiuChongTianJieEnterModel:getState()
if not isComplete and zmLevel>=44 and state==eJiuChongTianJieStateType.eDoing then
local param=cfgHelper.get2(cfg_jctjsubsysconfig_get,JIUCHONGTIANJIE_SUB_SYS_TYPE.eHongChenJie,'param')
return hongChenJieModel:checkHasGameIdData(param[1])~=nil
end
return false
end,

[29]=function()














return false
end,

[30]=function()
return tianshudazhenModel:getLevel()>0
end,

[31]=function()
return tianshudazhenModel:getLevel()>0
end,

[32]=function(cfg,isOnlyCheckOpen)
if isOnlyCheckOpen then
return limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eXianJieFuMo)
end
return limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eXianJieFuMo)
end,

[33]=function(cfg,isOnlyCheckOpen)
if isOnlyCheckOpen then
return limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eXianJieFuMo)
end
return limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eXianJieFuMo)
end,

[34]=function(cfg,isOnlyCheckOpen)
return tianshudazhenModel:isUnlock()
end,

[35]=function(cfg,isOnlyCheckOpen)
return XingYuController.checkCanPaiQian()
end,

[36]=function(cfg,isOnlyCheckOpen)
return shouhundingController:isOpen()
end,

[37]=function(cfg,isOnlyCheckOpen)
return true
end,

[38]=function(cfg,isOnlyCheckOpen)
if isOnlyCheckOpen then
return limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eMiaoXingShangLv)
end
return limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eMiaoXingShangLv)
end,

[39]=function(cfg,isOnlyCheckOpen)
if isOnlyCheckOpen then
return limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eMiaoXingShangLv)
end
return limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eMiaoXingShangLv)
end,

[40]=function(cfg,isOnlyCheckOpen)
local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eMingYuanZhuSha)
if isOnlyCheckOpen then
return isOpen
end

if not isOpen then
return false
end
local state=myzsModel:getSettlementState()

return state~=MYZSSettlementStateEnum.eStop
end,

[41]=function(cfg,isOnlyCheckOpen)
return YunZhouZhenTuController:checkYunZhouZhenTuSystem()
end,
}

local funcsLookup={

[XDT_TIPS_TYPE.eYinXianTai_1]={
checkReddot=function()
local times=UIRecruitModel:getRecruitTimes()
local num=xiaodaotongModel:getSetup_sliderCnt(XDT_TIPS_TYPE.eYinXianTai_1)
return times>=num
end,
getTotalNum=function()
local times=UIRecruitModel:getRecruitTimes()
return times
end,
},

[XDT_TIPS_TYPE.eYinXianTai_2]={
checkReddot=function()
return UIRecruitModel:checkFamilyReddot2()
end,
},

[XDT_TIPS_TYPE.eYinXianTai_3]={
checkReddot=function()
return UIRecruitModel:checkFamilyReddot3()
end,
},

[XDT_TIPS_TYPE.eYinXianTai_4]={
checkReddot=function()
return TeZhiTuJianController:checkSysRedddot()
end,
},

[XDT_TIPS_TYPE.eWuDaoTang_1]={
checkReddot=function()
local state=wudaotangModel:getwdSatet()
return state==-1
end,
},

[XDT_TIPS_TYPE.eWuDaoTang_2]={
checkReddot=function()
local state=wudaotangModel:getwdSatet()
return state==1
end,
},

[XDT_TIPS_TYPE.eWuDaoTang_3]={
checkReddot=function()
local state=wudaotangModel:getwdSatet()
return state==2
end,
},

[XDT_TIPS_TYPE.eKeZhan_1]={
checkReddot=function()
return xianzhanModel:hasYingBinRoom()
end,
},

[XDT_TIPS_TYPE.eKeZhan_2]={
checkReddot=function()
return xianzhanModel:checkTuiFangReward()
end,
},

[XDT_TIPS_TYPE.eHouShan_1]={
checkReddot=function()
return UIHuanJingControl:checkDayChallengeReddot2()
end,
},

[XDT_TIPS_TYPE.eHouShan_2]={
checkReddot=function()
return UIHuanJingControl:checkReddot()
end,
},

[XDT_TIPS_TYPE.eHouShan_3]={
checkReddot=function()
return xiaodaotongModel:check_daily_reddot('daily_hssl_time')and UIHuanJingControl:isCanChallengeNext()
end,
},

[XDT_TIPS_TYPE.eHouShan_4]={
checkReddot=function()
return UIHuanJingControl:isZhengLingReddot()
end,
},

[XDT_TIPS_TYPE.eHouShan_5]={
checkReddot=function()
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eHouShanZhenLingCanChalleng)
local isTips=not check
return isTips and UIHuanJingControl:isCanChallengeZhengLing()
end,
},

[XDT_TIPS_TYPE.eFuLuFang_1]={
checkReddot=function()
local reward=UIFuLuFangModel:checkHaveReward()
return reward
end,
},

[XDT_TIPS_TYPE.eFuLuFang_2]={
checkReddot=function(cfg)
local list=zongmenModel:getAllBuildByBuildType(cfg.buildType)
if list~=nil and#list>0 then
for i,bdData in ipairs(list)do
local pdata=UIFuLuFangModel:getProduceData(bdData.un_build_id)
if pdata~=nil and pdata.is_stop==1 then
if buildingCDControl:isComplete(buildingCDType.zhifu,bdData.un_build_id)then
return true,{bdData=bdData}
end
end
end
end
return false
end,
},

[XDT_TIPS_TYPE.eFangShi_1]={
checkReddot=function()
local freeCount=fairModel:get_free_flush_count()
local num=xiaodaotongModel:getSetup_sliderCnt(XDT_TIPS_TYPE.eFangShi_1)
return freeCount>=num
end,
getTotalNum=function()
local freeCount=fairModel:get_free_flush_count()
return freeCount
end,
},

[XDT_TIPS_TYPE.eFangShi_2]={
checkReddot=function()
local flag=not fairModel:is_open_guishi()and fairModel:getRecordGuiShi()==true
return flag
end,
},

[XDT_TIPS_TYPE.eChuanSongZhen_1]={
checkReddot=function()
local num=xiaodaotongModel:getSetup_sliderCnt(XDT_TIPS_TYPE.eChuanSongZhen_1)
return chuanSongZhenModel:checkReward2(num)
end,
getTotalNum=function()
local time=chuanSongZhenModel:getRewardTimeCurrentMoney()
time=math.floor(time/3600)
return time
end,
},

[XDT_TIPS_TYPE.eChuanSongZhen_2]={
checkReddot=function(cfg)
local list=zongmenModel:getAllBuildByBuildType(cfg.buildType)
if list~=nil and#list>0 then
local bdData=list[1]
if chuanSongZhenModel:checkPeople(bdData)then
return true,{bdData=bdData}
end
end
return false
end,
},

[XDT_TIPS_TYPE.eCangJingGe_1]={
checkReddot=function()
return UIGongFaModel:checkAllActiveReddot()
end,
},

[XDT_TIPS_TYPE.eCangJingGe_2]={
checkReddot=function()
return UIGongFaModel:checkAllStudyReddot()
end,
},

[XDT_TIPS_TYPE.eCangJingGe_3]={
checkReddot=function()
return UIDiscipleModel:checkXinFaBranchActiveReddot()or UIDiscipleModel:checkXinFaActiveReddot()
end,
},

[XDT_TIPS_TYPE.eXueYuan_1]={
checkReddot=function()
local remain=UISchoolModel:get_study_remainNum()
return remain>0
end,
},

[XDT_TIPS_TYPE.eXueYuan_2]={
checkReddot=function()
local checkReward=UISchoolModel:checkReward()
return checkReward
end,
},

[XDT_TIPS_TYPE.eLianQiGe_1]={
checkReddot=function(cfg)
local list=zongmenModel:getAllBuildByBuildType(cfg.buildType)
if list~=nil and#list>0 then
for i,bdData in ipairs(list)do
local infoIndex=1
if fabaoModel.getLianzhiInfoByIdx(bdData.un_build_id,infoIndex)then
if buildingCDControl:isComplete(buildingCDType.lianqi,bdData.un_build_id)then
return true,{bdData=bdData}
end
end
end
end
return false
end,
},

[XDT_TIPS_TYPE.eXuanShangTai_1]={
checkReddot=function()
local isXJsystem=XianjieXuanShangController:changeXJXSsystm()
if isXJsystem then
return false
else
local freeNum=UIXuanShangControl:getFreeDispatchNum()
local num=xiaodaotongModel:getSetup_sliderCnt(XDT_TIPS_TYPE.eXuanShangTai_1)
return freeNum>=num
end
end,
getTotalNum=function()
local freeNum=UIXuanShangControl:getFreeDispatchNum()
return freeNum
end,
},

[XDT_TIPS_TYPE.eXuanShangTai_2]={
checkReddot=function()
return UIXuanShangControl:hasTaskFinish()
end,
},

[XDT_TIPS_TYPE.eXuanShangTai_3]={
checkReddot=function()
local isXJsystem=XianjieXuanShangController:changeXJXSsystm()
if isXJsystem then
local xjxstFreeNum=cfg_zongmenxuanshangtaskbaseconfig_get(1).xjxstFreeNum or 0
local freeNum=xjxstFreeNum-XianjieXuanShangModel:getfreeNumUse()
if freeNum<0 then freeNum=0 end
local num=xiaodaotongModel:getSetup_sliderCnt(XDT_TIPS_TYPE.eXuanShangTai_3)
return freeNum>=num
end
end,
getTotalNum=function()
local xjxstFreeNum=cfg_zongmenxuanshangtaskbaseconfig_get(1).xjxstFreeNum or 0
local freeNum=xjxstFreeNum-XianjieXuanShangModel:getfreeNumUse()
if freeNum<0 then freeNum=0 end
return freeNum
end,
},

[XDT_TIPS_TYPE.eXianWuLou_1]={
checkReddot=function()
return xianmengModel:getXWL_tjNum()>0
end,
},

[XDT_TIPS_TYPE.eXianWuLou_2]={
checkReddot=function()
return xianmengModel:checkXWLHasReward()
end,
},

[XDT_TIPS_TYPE.eGongXunBang_1]={
checkReddot=function()
return xianmengModel:getGXBRewardReddot()
end,
},

[XDT_TIPS_TYPE.eTianDaoDing_1]={
checkReddot=function()
local moneyNun=moneyModel.getMoney(eMoneyType.mtRongLian)
local num=xiaodaotongModel:getSetup_sliderCnt(XDT_TIPS_TYPE.eTianDaoDing_1)
return moneyNun>=num
end,
getTotalNum=function()
local moneyNun=moneyModel.getMoney(eMoneyType.mtRongLian)
return moneyNun
end,
},







[XDT_TIPS_TYPE.eDouFaTai_1]={
checkReddot=function()
return douFaTaiModel:checkFreeCount()
end,
},

[XDT_TIPS_TYPE.eBaoLingShu_1]={
checkReddot=function()
return baoLingShuModel:check_baolingshu_reddot()
end,
},

[XDT_TIPS_TYPE.eBaoLingShu_2]={
checkReddot=function()
return baoLingShuModel:checkBLSPickUpTargetReddot()
end,
},

[XDT_TIPS_TYPE.eBaoLingShu_3]={
checkReddot=function()
return baoLingShuModel:checkBLSPickUpLiBaoReddot()
end,
},

[XDT_TIPS_TYPE.eBaoLingShu_4]={
checkReddot=function()
return xunBaoShiLianModel:checkCanTiaoZhanReddot()
end,
},

[XDT_TIPS_TYPE.eYuGang_1]={
checkReddot=function()
return UIAquariumControl:checkHandleBookPageReddot()
end,
},

[XDT_TIPS_TYPE.eYuGang_2]={
checkReddot=function()
return UIAquariumControl:checkFishManagerReddot()
end,
},

[XDT_TIPS_TYPE.eYuGang_3]={
checkReddot=function()
return UIAquariumControl:checkSaiQianBoxReddot()
end,
},

[XDT_TIPS_TYPE.eYanTianBei_1]={
checkReddot=function()
return wuJiBeiModel:getAllReddot()
end,
},

[XDT_TIPS_TYPE.eWuXingTa_1]={
checkReddot=function()
local flag=wuXingDianModel:isCanSaoDang()
return flag
end,
},








[XDT_TIPS_TYPE.eWuXingTa_3]={
checkReddot=function()
local flag=wuXingDianModel:isSDCanFight()
return flag
end,
},



[XDT_TIPS_TYPE.eXianMengDiGong_1]={
checkReddot=function()
local moneyNun=moneyModel.getMoney(eMoneyType.mtDiGongXingDongLi)
local num=xiaodaotongModel:getSetup_sliderCnt(XDT_TIPS_TYPE.eXianMengDiGong_1)
return moneyNun>=num
end,
getTotalNum=function()
local moneyNun=moneyModel.getMoney(eMoneyType.mtDiGongXingDongLi)
return moneyNun
end,
},

[XDT_TIPS_TYPE.eShangGuXianDi_1]={
checkReddot=function()
return mysteryWeekActivityModel:getFBReddot()
end,
},

[XDT_TIPS_TYPE.eWenDouLeiTai_1]={
checkReddot=function()
return poetryArenaModel:findAValidArena()~=nil
end,
},

[XDT_TIPS_TYPE.eTianYuanShouChao_1]={
checkReddot=function()
local curNum=xianmengModel:getChallengeNum1_TYSC()
return curNum>0
end,
},

[XDT_TIPS_TYPE.eDiaoYu_1]={
checkReddot=function()
return YiYuHuiYouController:tiaozhanNumReddot2()
end,
},

[XDT_TIPS_TYPE.eDiaoYu_2]={
checkReddot=function()
return YiYuHuiYouController:yyhyRankReddot()
end,
},

[XDT_TIPS_TYPE.eTaiYueChuYao_1]={
checkReddot=function()
return worldLeaderModel:getReddot()
end,
},

[XDT_TIPS_TYPE.eMaoHuoLang_1]={
checkReddot=function()
return UICatShopControl:checkReddot()
end,
},

[XDT_TIPS_TYPE.eDianPu_1]={
checkReddot=function()
local list=zongmenModel:getAllBuildByBuildType(24)
if list~=nil and#list>0 then
for i,bdData in ipairs(list)do
if UIShopModel:getEventState(bdData.un_build_id)then
return true,{bdData=bdData}
end
end
end
return false
end,
},

[XDT_TIPS_TYPE.eXianMengZhan_1]={
checkReddot=function()
return lingxuwenjianModel:checkDayRedot()
end,
},

[XDT_TIPS_TYPE.eZongMenTaYin_1]={
checkReddot=function()
return systemZongMenModel:checkTanYinTips()
end,
},

[XDT_TIPS_TYPE.eBaoLingShuRepair]={
checkReddot=function()
local buildType=SLG_SYSTEM_TYPE.eBaoLingShu
local d=isometricMapSystem:getAllUnlockRepairDataByID(buildType)
if d then
if isometricMapSystem:readyBuildRepair(d)then
return true
end
end
return false
end,
},

[XDT_TIPS_TYPE.eHouShanRepair]={
checkReddot=function()
local buildType=SLG_SYSTEM_TYPE.eHouShanMiJing
local d=isometricMapSystem:getAllUnlockRepairDataByID(buildType)
if d then
if isometricMapSystem:readyBuildRepair(d)then
return true
end
end
return false
end,
},


[XDT_TIPS_TYPE.eCatMiJin]={
checkReddot=function()
return wanBaoXunBaoDuiController:checkCatMijinTanShuo()
end,
},


[XDT_TIPS_TYPE.eCatTanXian_1]={
checkReddot=function()
return wanBaoXunBaoDuiModel:checkChannelIdle()
end
},


[XDT_TIPS_TYPE.eCatTanXian_2]={
checkReddot=function()
return UIFullWanBaoXunBaoDuiController:checkChannelReddot()
end
},


[XDT_TIPS_TYPE.eXianGongPingDing]={
checkReddot=function()
return xiangongpingdingModel:isReady()
end
},


[XDT_TIPS_TYPE.eXianGongPingDingPrize]={
checkReddot=function()
return true
end
},
[XDT_TIPS_TYPE.eFanRongDu_1]={
checkReddot=function()
return prosperityModel:isCanUpLevel()
end
},

[XDT_TIPS_TYPE.eXianGongPingDing_2]={
checkReddot=function()
return xiangongpingdingModel:isDoing()
end
},

[XDT_TIPS_TYPE.eXianGongPingDingPrize_2]={
checkReddot=function()
return true
end
},

[XDT_TIPS_TYPE.elaoyu_1]={
checkReddot=function()
local iskw=UIPrisonModel:existEmptyRoom()
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXDTNaoYuTiXing)
local istips=not check
return istips and iskw
end
},

[XDT_TIPS_TYPE.elaoyu_2]={
checkReddot=function()
return UIPrisonModel:checkCanShenWen()
end
},

[XDT_TIPS_TYPE.elaoyu_3]={
checkReddot=function()
return UIPrisonModel:checkFinishShenWen()
end
},

[XDT_TIPS_TYPE.eShanHaiShiJie_1]={
checkReddot=function()

local seasonState=zhengzhanshanhaiModel:getSeasonState()
if seasonState~=1 then
return false
end

local moneyNun=moneyModel.getMoney(eMoneyType.mtXuKongLing)
local num=xiaodaotongModel:getSetup_sliderCnt(XDT_TIPS_TYPE.eShanHaiShiJie_1)
return moneyNun>=num
end,
getTotalNum=function()
local moneyNun=moneyModel.getMoney(eMoneyType.mtXuKongLing)
return moneyNun
end,
},

[XDT_TIPS_TYPE.eShanHaiShiJie_2]={
checkReddot=function()
return false
end
},

[XDT_TIPS_TYPE.eShanHaiShiJie_3]={
checkReddot=function()
local seasonState=zhengzhanshanhaiModel:getSeasonState()
if seasonState==eZZSH_Season_State.eOffSeason then
return false
end

return zhengzhanshanhaiModel:jude_zhengzhanshanhailog_reddot()
end
},

[XDT_TIPS_TYPE.eShanHaiShiJie_4]={
checkReddot=function()

local seasonState=zhengzhanshanhaiModel:getSeasonState()
if seasonState~=1 then
return false
end
return zhengzhanshanhaiModel:checkEmptyDefTeam()
end
},

[XDT_TIPS_TYPE.eTianJiGe_1]={
checkReddot=function()
return false
end
},

[XDT_TIPS_TYPE.eTianJiGe_2]={
checkReddot=function()
return mysteryWeekActivityModel:checkAllReddot()or false
end
},

[XDT_TIPS_TYPE.eXianFaWenDao_1]={
checkReddot=function()
return UIXianFaWenDaoControl:checkFreeReddot()
end
},

[XDT_TIPS_TYPE.eShangShi_1]={
checkReddot=function()
return shangHangModel:getActorMoneyToday()~=0
end
},

[XDT_TIPS_TYPE.eShangShi_2]={
checkReddot=function()
return shangHangModel:checkLikeOrHateReddot()
end
},

[XDT_TIPS_TYPE.e_FangKeShiLian_1]={
checkReddot=function()
return zmvisitchallengeModel:checkFirstClickReddot()
end
},

[XDT_TIPS_TYPE.e_FangKeShiLian_2]={
checkReddot=function()
return zmvisitchallengeModel:checkBigRewardReddot()
end
},

[XDT_TIPS_TYPE.eXianFaWenDao_2]={
checkReddot=function()
if systemModel.isOpen(SYSTEM_DEFINE.eXianFaWenDao)and UIXianFaWenDaoControl:checkUnlock()then
local isReg=UIXianFaWenDaoControl:getRegister()
if not isReg then
return true
end
end
return false
end
},

[XDT_TIPS_TYPE.eXianFaWenDao_3]={
checkReddot=function()
if systemModel.isOpen(SYSTEM_DEFINE.eXianFaWenDao)and UIXianFaWenDaoControl:checkUnlock()then
local isReg=UIXianFaWenDaoControl:getRegister()
local times,ft,pt=UIXianFaWenDaoControl:getAllChallengeTimes()
if isReg and ft>0 then
return true
end
end
return false
end
},

[XDT_TIPS_TYPE.eTianGongGe_1]={
checkReddot=function()
if not systemModel.isOpen(SYSTEM_DEFINE.eLingZhenDiaoKe)then
return false
end
return LZDiaoKeModel:checkDayRedot()
end
},

[XDT_TIPS_TYPE.eTianGongGe_2]={
checkReddot=function()
if not systemModel.isOpen(SYSTEM_DEFINE.eLingZhenDiaoKe)then
return false
end
return LZDiaoKeModel:hasHoldDKReward()
end
},

[XDT_TIPS_TYPE.eShanMenDaZhen_1]={
checkReddot=function()
if not systemModel.isOpen(SYSTEM_DEFINE.eShanMenDaZhen)then
return false
end


local hasTeamEmpty=shanMenDaZhenModel:checkDaZhenIsHasEmptyTeam()
if hasTeamEmpty then
return true
end
return false
end
},

[XDT_TIPS_TYPE.eShanMenDaZhen_2]={
checkReddot=function()
if not systemModel.isOpen(SYSTEM_DEFINE.eShanMenDaZhen)or not shanMenDaZhenModel:checkHaveShanmenDaZhen()then
return false
end


local state=shanMenDaZhenModel:getDaZhenState()
if state==3 then
return true
end
return false
end
},

[XDT_TIPS_TYPE.eYiFangLingTian_1]={
checkReddot=function()
if not systemModel.isOpen(SYSTEM_DEFINE.eYiFangLingTian)then
return false
end

return YiFangLingTianModel:GetMaxPlant()
end
},

[XDT_TIPS_TYPE.eYiFangLingTian_2]={
checkReddot=function()
if not systemModel.isOpen(SYSTEM_DEFINE.eYiFangLingTian)then
return false
end

return YiFangLingTianController:checkAnySeedPlantMatched()
end
},

[XDT_TIPS_TYPE.eYiFangLingTian_3]={
checkReddot=function()
if not systemModel.isOpen(SYSTEM_DEFINE.eYiFangLingTian)then
return false
end
return false

end
},

[XDT_TIPS_TYPE.eWorldDailyEvent_1]={
checkReddot=function()
local num=worldDailyEventModel:get_unit_count()
return num>0
end
},

[XDT_TIPS_TYPE.eHongChenJie_1]={
checkReddot=function()
local param=cfgHelper.get2(cfg_jctjsubsysconfig_get,JIUCHONGTIANJIE_SUB_SYS_TYPE.eHongChenJie,'param')
local id=param[1]
local data=hongChenJieModel:getGameHandle(id)
if not data then return false end
local freeCount=hongChenJieConfig.getBaseInfo(id,'free_num')
local usedNum=data:getTimes()
local hasFree=freeCount>usedNum

local passParm=UITYTongXingZhengController.getBaseInfo(passportDefine.eHCJ,'passParm')
local passporttype=passParm[1]
local sys_id=passParm[2]
local sub_sys_id=passParm[3]
local passport_guid=UITYTongXingZhengModel:getGuidBySysID(passporttype,sys_id,sub_sys_id)
local num=UITYTongXingZhengModel:getProgress(passport_guid)
local txzId=UITYTongXingZhengModel:getTXZId(passport_guid)
if not txzId then return false end
local config=cfgHelper.get1(cfg_passportconfig_get,txzId)
if config.jifen_reduce then
num=math.floor(num/config.jifen_reduce)
end

if num<2000 then
return hasFree
else
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eHongChenJieFreeTips)
local hasNotFinish=data:checkRankingSelfNotFinish()
if not flag and hasNotFinish and hasFree then
return true
end
end
return false
end
},

[XDT_TIPS_TYPE.eArriveAttacker]={
checkReddot=function()
local flag=xianjieModel:isUnderAttack_Type(ATTACKTYPE.eMJActor)or
xianjieModel:isUnderAttack_Type(ATTACKTYPE.eMJActor)or
xianjieModel:isUnderAttack_Type(ATTACKTYPE.eMoJun)
return flag
end
},


[XDT_TIPS_TYPE.eTianShuDaZhenUp]={
checkReddot=function()
return false
end
},

[XDT_TIPS_TYPE.eXianJieFuMo]={
checkReddot=function()
return XianJieFuMoController:getFightReddot()
end,
},

[XDT_TIPS_TYPE.eXianJieFuMo_1]={
checkReddot=function()
return XianJieFuMoController:checkTargetReddot()
end,
},

[XDT_TIPS_TYPE.eXianBang]={
checkReddot=function()
return xianjiexianbangModel:XBXDThavetasksReddot()
end,
},

[XDT_TIPS_TYPE.eTianShuDaZhenWeiZhuShou]={
checkReddot=function()
return tianshudazhenModel:getBuildData()and not tianshudazhenModel:isZhuShouTeam()
end,
},

[XDT_TIPS_TYPE.eYunJiaYing]={
checkReddot=function()
return yunjiayingModel:checkYunJiaYingBdHasFreeReddot()
end,
},

[XDT_TIPS_TYPE.eYunJiaYing_2]={
checkReddot=function()
return yunjiayingModel:checkYunJiaYingBdAllFinishReddot()
end,
},

[XDT_TIPS_TYPE.eLittleWorld]={
checkReddot=function()
return LittleWorldModel:checkXiangHuoEnough()
end,
},

[XDT_TIPS_TYPE.eLittleWorld_xingchen]={
checkReddot=function()
return xingChenHelper.isHaveSlotCanEquip()
end,
},

[XDT_TIPS_TYPE.eBaGuaLu]={
checkReddot=function()
return bagHelper.isBagFull(BAG_TYPE.eEquipBag)
end,
},

[XDT_TIPS_TYPE.eBaGuaLu_2]={
checkReddot=function()
local item=cfgHelper.get(cfg_bagualuaconfig_get,1,"xdt_tianjingshi")
local have=bagModel.getItemCountById(item[1])
return have>=item[2]
end,
},

[XDT_TIPS_TYPE.eBaGuaLu_3]={
checkReddot=function()
local item=cfgHelper.get(cfg_bagualuaconfig_get,1,"xdt_jinglianshi")
local have=bagModel.getItemCountById(item[1])
return have>=item[2]
end,
},

[XDT_TIPS_TYPE.eXingYu]={
checkReddot=function()
return XingYuController.checkCanPaiQian()
end,
},
[XDT_TIPS_TYPE.eShouHunDing]={
checkReddot=function()
return shouhundingController:getReddot()
end,
},

[XDT_TIPS_TYPE.eWDCQguess]={
checkReddot=function()
return WDCQController:checkGuessState()
end,
getTotalNum=function()

return 2
end,
},

[XDT_TIPS_TYPE.eXuMiTa_1]={
checkReddot=function()
if not systemModel.isOpen(SYSTEM_DEFINE.eiXuMiTa)then
return false
end
return wanLingTaModel:checkAllTypeTuJianReddot()
end
},

[XDT_TIPS_TYPE.eXuMiTa_2]={
checkReddot=function()
if not systemModel.isOpen(SYSTEM_DEFINE.eiXuMiTa)then
return false
end
return wanLingTaModel:checkAllTypeCollectTargetReddot()
end
},

[XDT_TIPS_TYPE.eXuMiTa_3]={
checkReddot=function()
if not systemModel.isOpen(SYSTEM_DEFINE.eiXuMiTa)then
return false
end
local cfgs=cfg_xumitatllevelconfig()
local taLingLevel=wanLingTaModel:getTaLingLevel()
local rewardLevel=wanLingTaModel:getTaLingRewardLevel()
local exp=wanLingTaModel:getTaLingExp()
local needExp=wanLingTaModel:getTaLingNeedExp()
if taLingLevel<#cfgs and exp>=needExp then
return true
end
return false
end
},

[XDT_TIPS_TYPE.eMiaoXingShangLv]={
checkReddot=function()
return xianJieCaravanEscortModel:checkCaravanEscortHasNotGoShipReddot()
end
},

[XDT_TIPS_TYPE.eMiaoXingShangLv_1]={
checkReddot=function()
return xianJieCaravanEscortModel:checkCaravanEscortHasRewardReddot()
end
},

[XDT_TIPS_TYPE.eWuXingTa_4]={
checkReddot=function()
return JiuYouTaModel:getDayChallengeReddot()
end
},

[XDT_TIPS_TYPE.eMingYuanZhuSha]={
checkReddot=function()

return not myzsModel:checkPassOpenAllLayer()
end
},

[XDT_TIPS_TYPE.eYunZhouZhenTu]={
checkReddot=function()
return YunZhouZhenTuModel:getYZZTAllReddot()
end
},
}

function xiaodaotongModel:initData()
buildOpenLookup={}
systemOpenLookup={}

local temp={}
local cfgs=cfg_xiaodaotongtipsconfig()
for id,v in pairs(funcsLookup)do
local cfg=cfgs[id]
local funcType=nil
if cfg.buildType then
funcType=cfg.buildType
elseif cfg.funcType then
funcType=-cfg.funcType
end
if funcType then
if temp[funcType]==nil then
temp[funcType]={list={},time=0,funcType=funcType}
end
table.insert(temp[funcType].list,cfg)
end
end
typsLookup={}
for k,v in pairs(temp)do
if#v.list>1 then
table.sort(v.list,function(a,b)
return a.weight>b.weight
end)
end
table.insert(typsLookup,v)
end
typesNum=#typsLookup
if refreshNum>typesNum then
refreshNum=typesNum
end

talksLookup={}
talksLookup2={}
local cfgs2=cfg_xiaodaotongspeakconfig()
for k,v in pairs(cfgs2)do
if v.tipsID~=nil then
talksLookup[v.tipsID]=v.speaks
elseif v.buildType~=nil then
talksLookup2[v.buildType]=v.speaks
end
end
end

function xiaodaotongModel:clearData()
buildOpenLookup=nil
systemOpenLookup=nil
typsLookup=nil
typesNum=nil
resultLookup=nil
reddotNum=0
talksLookup=nil
talksLookup2=nil
end

function xiaodaotongModel:refreshTipsList(isInit,isAll)
local rNum=0
if resultLookup~=nil then
if isAll==true then
rNum=typesNum
else
rNum=refreshNum
end
else
rNum=typesNum
resultLookup={}
end

if rNum==nil then return end

local isChange=false
for i=1,rNum do
local typeData=typsLookup[i]
local time=typeData.time
local checkTime=false
if time==0 or Time.realtimeSinceStartup-time>=xiaodaotongModel.refreshTime then
checkTime=true
end
if checkTime then
local funcType=typeData.funcType
local result=resultLookup[funcType]
local show_result=nil
local red_result=nil
for i,cfg in ipairs(typeData.list)do
local isShow,isReddot,args=xiaodaotongModel:checkShow(cfg)
if isShow then
if isReddot then
red_result={cfg=cfg,isReddot=isReddot,args=args}
break
end
if show_result==nil then
show_result={cfg=cfg,isReddot=isReddot,args=args}
end
end
end
local cur_result=nil
if red_result~=nil then
cur_result=red_result
elseif show_result~=nil then
cur_result=show_result
end
if cur_result==nil then
if result~=nil then
isChange=true
resultLookup[funcType]=nil
end
elseif result==nil then
isChange=true
resultLookup[funcType]=cur_result
else
if cur_result.cfg.id~=result.cfg.id or cur_result.isReddot~=result.isReddot then
isChange=true
end
result.cfg=cur_result.cfg
result.isReddot=cur_result.isReddot
result.args=cur_result.args
end
typeData.time=Time.realtimeSinceStartup
end
end
table.sort(typsLookup,function(a,b)
return a.time<b.time
end)

local old_reddotNum=reddotNum or 0
reddotNum=0
for k,v in pairs(resultLookup)do
if v.isReddot and xiaodaotongModel:checkShowReddot(v.cfg)then
reddotNum=reddotNum+1
end
end
if not isInit then
if old_reddotNum~=reddotNum then
UIManager:invokeUIMethod('UIFuncStorageWin','refreshFastManagerBtn')
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','refreshMenuReddot',3)
end
if isChange then
UIManager:invokeUIMethod('UIXiaoDaoTongTipsWin','onTipsChange')
end
end
return isChange
end

function xiaodaotongModel:getTipsList_sort()
if resultLookup==nil then
xiaodaotongModel:refreshTipsList(true)
end
local list={}
local num=0
for k,v in pairs(resultLookup)do
if xiaodaotongModel:checkShowReddot(v.cfg)then
local flag,args=xiaodaotongModel:checkReddot(v.cfg)
if flag then
num=num+1
list[num]=v
v.weight=v.cfg.weight
end
end
end
if num>1 then
table.sort(list,function(a,b)
return a.weight>b.weight
end)
end
return list
end

function xiaodaotongModel:getSetupList()
local cfgs=cfg_xiaodaotongtipsconfig()
local list={}
for id,v in pairs(funcsLookup)do
local cfg=cfgs[id]
if cfg.canset and xiaodaotongModel:checkOpen(cfg,true)then
table.insert(list,{cfg=cfg})
end
end
return list
end


function xiaodaotongModel:getReddotNum()
if resultLookup==nil then
xiaodaotongModel:refreshTipsList(true)
end
return reddotNum
end

function xiaodaotongModel:getReddot()
if resultLookup==nil then
xiaodaotongModel:refreshTipsList(true)
end
return reddotNum>0
end

function xiaodaotongModel:checkOpen(cfg,isOnlyCheckOpen)
local typo=cfg.funcType
if typo==nil then
typo=0
end
local func=checkOpenLookup[typo]
if func then
return func(cfg,isOnlyCheckOpen)
else



return false
end
end

function xiaodaotongModel:checkShow(cfg)
if xiaodaotongModel:checkOpen(cfg)and xiaodaotongModel:checkShowReddot(cfg)then
local flag,args=xiaodaotongModel:checkReddot(cfg)
if cfg.range then

local num=xiaodaotongModel:getTotalNum(cfg.id)
return num>=cfg.range[1],flag,args
else
return flag,flag,args
end
end
return false,nil,nil
end


function xiaodaotongModel:checkReddot(cfg)
local lp=funcsLookup[cfg.id]
local func=lp.checkReddot
if func then
return func(cfg)
end
return false
end


function xiaodaotongModel:checkShowReddot(cfg)
local isShowReddot=true
if cfg.canset then
local setupData=xiaodaotongModel:getSetup(cfg.id)
if not setupData.isSetup then
isShowReddot=false
end
end
return isShowReddot
end

function xiaodaotongModel:getDesc(cfg)
local desc2=cfg.desc2
if desc2 then
local num=xiaodaotongModel:getTotalNum(cfg.id)
if num~=nil then
desc2=FMT.fmt(desc2,num)
end




return FMT.fmt('{0}\n{1}',cfg.desc,desc2)
else
return cfg.desc
end
end

function xiaodaotongModel:getTotalNum(id)
local lp=funcsLookup[id]
local func=lp.getTotalNum
if func then
return func()
end
return nil
end

function xiaodaotongModel:getSliderValues(cfg)
if cfg.range then
return cfg.range[1],cfg.range[2]
end
return nil,nil
end

function xiaodaotongModel:getSliderValuesEx(id)
local cfg=cfgHelper.get1(cfg_xiaodaotongtipsconfig_get,id)
if cfg.range then
return cfg.range[1],cfg.range[2],cfg.range[3]
end
return nil,nil
end

function xiaodaotongModel:getSetupDesc(cfg)
if cfg.range~=nil then
local setupData=xiaodaotongModel:getSetup(cfg.id)
return FMT.fmt(cfg.setDesc,setupData.sliderCnt)
else
return cfg.setDesc
end
end

function xiaodaotongModel:getSetup(id)
local id_str=tostring(id)
local datas=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXiaoDaoTong,'tipsSetting',{})
local setupData=datas[id_str]
if setupData==nil then
setupData={}
setupData.id=id
setupData.isSetup=true
local min,max,def=xiaodaotongModel:getSliderValuesEx(id)
if def~=nil then
setupData.sliderCnt=def
elseif max~=nil then
setupData.sliderCnt=max
end
end
return setupData
end

function xiaodaotongModel:getSetup_sliderCnt(id)
local setupData=xiaodaotongModel:getSetup(id)
return setupData.sliderCnt
end

function xiaodaotongModel:refreshSetup(setupData)
local id_str=tostring(setupData.id)
local datas=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXiaoDaoTong,'tipsSetting',{})
datas[id_str]=setupData
userActorArraySetting.set(ACTOR_SETTING_TYPE.eXiaoDaoTong,'tipsSetting',datas)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXiaoDaoTong)
xiaodaotongModel:refreshTipsList()
end

function xiaodaotongModel:set_daily_time(key)
local time=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXiaoDaoTong,key,nil)
if time==nil or not timeHelper.checkInSameDay(time,gameUtilityModel.getServerLongTime())then
time=gameUtilityModel.getServerLongTime()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eXiaoDaoTong,key,time)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXiaoDaoTong)
end
end

function xiaodaotongModel:check_daily_reddot(key)
local time=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXiaoDaoTong,key,nil)
if time~=nil then
if not timeHelper.checkInSameDay(time,gameUtilityModel.getServerLongTime())then
return true
else
return false
end
else
return true
end
end

function xiaodaotongModel:getTalkList_1(id)
return talksLookup[id]
end

function xiaodaotongModel:getTalkList_2(buildType,state)
talksLookup2[buildType]=talksLookup2[buildType]
if talksLookup2[buildType]then
return talksLookup2[buildType][state]
end
return nil
end

function xiaodaotongModel:needCheckRepair(buildType)
local check=false
if repairLookup[buildType]then
check=true
local func=repairLookupSysOpen[buildType]
if func then
if func()then
check=true
else
check=false
end
end
end
return check
end

function xiaodaotongModel:canRepairNum()
local num=0
local temp=isometricMapSystem:getAllRepairData()
if temp~=nil then
for k,v in pairs(temp)do
if xiaodaotongModel:needCheckRepair(v.type)then
if zongmenModel:isAreaUnlock(v.areaId)then
if isometricMapSystem:canBuildRepair(v)then
num=num+1
end
end
end
end
end
return num
end

function xiaodaotongModel:canRepairReddot()
local temp=isometricMapSystem:getAllRepairData()
if temp~=nil then
for k,v in pairs(temp)do
if xiaodaotongModel:needCheckRepair(v.type)then
if zongmenModel:isAreaUnlock(v.areaId)then
if isometricMapSystem:canBuildRepair(v)then
return true
end
end
end
end
end
return false
end

function xiaodaotongModel:checkBuild(bdData)






if bdData.flag>0 then
local ftype=zongmenModel:getBDFlagType(bdData.flag)
if ftype==bdFlagType.sectionBuildComplete then
if xiaodaotongModel:needCheckRepair(bdData.build_id)then
local idx=bdData.flag-20+1
if isometricMapSystem:checkRepairCostEx(bdData.build_id,idx)then
return true
end
end
return false
else
return true
end
end
local lcfg=cfg_monijybuilduplvlconfig_get(bdData.build_id)[bdData.level+1]
if lcfg then
local flag=zongmenControl:checkLevelUp(lcfg,false)
return flag
end
return false
end

function xiaodaotongModel:getBuildFinishNum()
return xiaodaotongModel_update:getBuildCnt(XDT_TYPE.eBuildFinishNum)
end
function xiaodaotongModel:getBuildFinishNum1()
local datas=zongmenModel:getAllBuildingData(zongmenModel:getMountainId())
local num=0
for k,v in pairs(datas)do
if xiaodaotongModel:checkBuild(v)then
local cd=buildingCDControl:getCD(buildingCDType.build,v.un_build_id)
if cd==0 then
num=num+1
end
end
end
return num
end

function xiaodaotongModel:getBuildFinishReddot()
return xiaodaotongModel_update:hasBuildCnt(XDT_TYPE.eBuildFinishNum)
end

function xiaodaotongModel:getBuildFinishReddot1()
local datas=zongmenModel:getAllBuildingData(zongmenModel:getMountainId())
for k,v in pairs(datas)do
if xiaodaotongModel:checkBuild(v)then
local cd=buildingCDControl:getCD(buildingCDType.build,v.un_build_id)
if cd==0 then
return true
end
end
end
return false
end


function xiaodaotongModel:getManufatureFinishNum()
return xiaodaotongModel_update:getBuildCnt(XDT_TYPE.eManufatureFinishNum)
end

function xiaodaotongModel:getManufatureFinishNum1()
local datas=zongmenModel:getAllBuildingData(zongmenModel:getMountainId())
local num=0
for k,v in pairs(datas)do
if v.flag==0 then
local cfg=cfg_monijybuildconfig_get(v.build_id)
local cd
if cfg.win_type==sysWinType.eFangAn then
cd=buildingCDControl:getCD(buildingCDType.plan,v.un_build_id)
elseif cfg.id==SLG_SYSTEM_TYPE.eLianDanFang then
cd=buildingCDControl:getCD(buildingCDType.liandan,v.un_build_id)
elseif cfg.win_type==sysWinType.eShangPu then
cd=buildingCDControl:getCD(buildingCDType.shangpu,v.un_build_id)
end
if cd==0 then
num=num+1
end
end
end
return num
end

function xiaodaotongModel:getManufatureFinishNumReddot1()
local datas=zongmenModel:getAllBuildingData(zongmenModel:getMountainId())
for k,v in pairs(datas)do
if v.flag==0 then
local cfg=cfg_monijybuildconfig_get(v.build_id)
local cd
if cfg.win_type==sysWinType.eFangAn then
cd=buildingCDControl:getCD(buildingCDType.plan,v.un_build_id)
elseif cfg.id==SLG_SYSTEM_TYPE.eLianDanFang then
cd=buildingCDControl:getCD(buildingCDType.liandan,v.un_build_id)
elseif cfg.win_type==sysWinType.eShangPu then
cd=buildingCDControl:getCD(buildingCDType.shangpu,v.un_build_id)
end
if cd==0 then
return true
end
end
end
return false

end

function xiaodaotongModel:getManufatureFinishNumReddot()
return xiaodaotongModel_update:hasBuildCnt(XDT_TYPE.eManufatureFinishNum)
end

function xiaodaotongModel:getManufactureReddot()
return xiaodaotongModel:getManufatureFinishNumReddot()or zongmenModel:checkFreeManufactureBuildingReddot()
end

function xiaodaotongModel:getBuildingReddot()
return xiaodaotongModel:getBuildFinishReddot()or xiaodaotongModel:canRepairReddot()
end

function xiaodaotongModel:getManufactureReddotNum()
local num=xiaodaotongModel:getManufatureFinishNum()+zongmenModel:getFreeManufactureBuildingReddotNum()
return num
end

function xiaodaotongModel:getBuildingReddotNum()
local num=xiaodaotongModel:getBuildFinishNum()+xiaodaotongModel:canRepairNum()
return num
end

function xiaodaotongModel:setBuildCallbackPage(page)
zhahuopucallbackpage=page
end
function xiaodaotongModel:getBuildCallbackPage()
return zhahuopucallbackpage
end
