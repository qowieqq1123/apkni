







UILoadState={
eUnLoad=1,
eLoading=2,
eLoaded=3,
eFailed=4,
}

UICloseMode={
eDestroy=1,
eDisable=2,
}

uiwindow_id={}



























uiwindow_id['UILingZhenPengZhuang']={
id=JUMP_TYPE.eLingZhenPengZhuang,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
UILZPZControl:showMainWin()
return true
end
}


uiwindow_id['UIAquariumShopWin']={
id=JUMP_TYPE.eYueLongChiShop,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
local page=args and args.page or 1
if page==1 then
UIAquariumShopControl:showYuZhiGeShopWin()
elseif page==2 then
UIAquariumShopControl:showYuJuShengJiShopWin()
elseif page==3 then
UIAquariumShopControl:showLongChiShopWin()
else
return false
end
return true
end
}


uiwindow_id['UIAquariumWin']={
id=JUMP_TYPE.eYueLongChi,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
local bdData=UIAquariumControl:getAquariumBDData()
local offset={-0.5,1.5}
if bdData then
UIAquariumControl:showAquariumWin()
isometricMapSystem:moveCameraToObject(bdData.entityId,nil,nil,nil,nil,offset)
return true
else
UIManager.error('跃龙池建筑尚未修复')
local data=isometricMapSystem:getRepairDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eYueLongChi)
isometricMapSystem:moveCameraToObject(data.guid,nil,nil,nil,nil,offset)
return false
end
end
}


uiwindow_id[JUMP_TYPE.eYiYuHuiYouActivity]=
{
id=JUMP_TYPE.eYiYuHuiYouActivity,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
UIFullYiYuHuiYouController:jumpWorldYYHYWindowbyYuBi(args)
return true
end
}


uiwindow_id[JUMP_TYPE.eYiYuHuiYouActivityTuJian]=
{
id=JUMP_TYPE.eYiYuHuiYouActivityTuJian,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
UIFullYiYuHuiYouController:jumpWorldYYHYWindowbyTuJian(args)
return true
end
}



uiwindow_id['UIXianShuWin']={
id=JUMP_TYPE.eXianShu,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
local tab=args and args.tab or 1
if tab==1 then
UIXianShuControl:showXianShuWin()
elseif tab==2 then
UIXianShuControl:showXianShuTaskWin()
else
return false
end
return true
end
}


uiwindow_id['UICatShopWin']={
id=JUMP_TYPE.eCatShop,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
return UICatShopControl:showCatShopWin(nil,true)
end
}


uiwindow_id['UIFastManagerWin']={
id=JUMP_TYPE.eProduceBDManager,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
args=args or{}
UIManager:showWindow('UIXiaoDaoTongMainWin',{page=args.menuPageIndex})
return true
end
}


uiwindow_id['UIFabaoWin']={
id=JUMP_TYPE.eFabao,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
args=args or{}
args.entityId=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eLianQiGe,true,nil,true)
local can=systemModel.isOpen(SYSTEM_DEFINE.eFaBao1)
if args.entityId==nil then
return false
end
if can==false then

local openargs=cfg_systemopenconfig_get(SYSTEM_DEFINE.eFaBao1).openargs
if openargs then
local bookStr=2
if openargs[1][1][2]then
bookStr=mathHelper.numberToChinese(openargs[1][1][2])
end
local zhannum=1
if openargs[1][1][3]then
zhannum=openargs[1][1][3]
end
UIManager.info(FMT.fmt('完成谪仙令卷{0}·第{1}章解锁',bookStr,zhannum))
else
UIManager.info(FMT.fmt('完成谪仙令卷二·第1章解锁'))
end
return false
end
return UIFullLianQiGeControl:showFabaoWindow(args)
end
}


uiwindow_id['UIHeChengLianHuaWin']={
id=JUMP_TYPE.eFabaoHecheng,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
args=args or{}
args.entityId=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eLianQiGe,true,nil,true)
if args.entityId==nil then
return false
end
local argstable={
entityId=args.entityId
}
return UIFullBaGuaLuControl:showLianHuaWindow(argstable)
end
}


uiwindow_id['UISchoolMainWin']={
id=JUMP_TYPE.eSchoolMain,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
args=args or{}
args.entityId=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eXueShiShuYuan,true,nil,true)
if args.entityId==nil then
return false
end
return UIFullSchoolControl:showSchoolMainWindow(args)
end
}


uiwindow_id['UIFairWin']={
id=JUMP_TYPE.eFairShop,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
args=args or{}
args.entityId=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eFangShi,true,nil,true)
if args.entityId==nil then
return false
end
return UIFullFairControl:showFairWindow(args)
end
}


uiwindow_id['UIDanYaoWin']={
id=JUMP_TYPE.eDanYao,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
args=args or{}
local bdList=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eLianDanFang,true,true,true,true)
if bdList==nil or#bdList<=0 then return false end
local td
for i,v in ipairs(bdList)do
local flag=UIDanYaoModel:getLianDanFlag(v.un_build_id)
if not flag then
td=v
break
end
end
if not td then
td=bdList[1]
end
args.entityId=td.entityId
if args.entityId==nil then
return false
end
return UIFullLianDanFangControl:showProductionWindow(args)
end
}


uiwindow_id['UIDanFangWin']={
id=JUMP_TYPE.eDanFang,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
if not args.notGet then
return UIDanYaoController:jumpDanFangWindow(args)
else
return UIDanYaoController:jumpDanFangWindow2(args)
end
end
}


uiwindow_id['UIMain_funclist']={
id=JUMP_TYPE.eMain,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return mainControl:showWindow(args)
end
}


uiwindow_id['UIReChargeWin']={
id=JUMP_TYPE.eReCharge,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
return UIFullRechargeController:showMyWindow(args)
end
}


uiwindow_id['UIReChargeWin2']={
id=JUMP_TYPE.eJumpReCharge,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
if systemModel.isOpen(SYSTEM_DEFINE.eDayDiscounts)then
return UIFullRechargeController:showMyWindow({tabType=FULL_TAB_TYPE.eRechargeDailyTeHui})
else
if firstRechargeModel:checkNotBought()then
return UIFullRechargeController:showMyWindow({tabType=FULL_TAB_TYPE.eRecharge})
else
return UIFullRechargeController:showMyWindow({tabType=FULL_TAB_TYPE.eReChargeLiBao})
end
end
end
}


uiwindow_id['UIBagWin']={
id=JUMP_TYPE.eBag,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return UIManager:showWindow("UIBagWin",args)
end
}


uiwindow_id['UILayoutWin']={
id=JUMP_TYPE.eLayout,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
return isometricMapSystem:enterLayoutModel(args,true)
end
}


uiwindow_id['UIBuildingWin']={
id=JUMP_TYPE.eBuilding,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local ret,isOpenLayout=zongmenControl:jumpBuildingWin(args)
if ret and not isOpenLayout then
UIManager:closeWindow('UILayoutWin')
end
return ret
end
}

uiwindow_id['UIXianZhanWin']={
id=JUMP_TYPE.eXianZhan,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local list=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eXianZhan,true,true,false)
if list~=nil and#list>0 then
cameraMoveController:Begin({eSceneType.eZongmen,mapIdType.xianzhan})
else

local func=function(flag,pos,backParams)

if flag then
local guid=backParams.guid
local inUnlockArea=isometricMapSystem:isInUnlockArea(guid)
if isometricMapSystem:checkTouchRepairBuilding(guid,inUnlockArea)then
elseif isometricMapSystem:checkTouchBuilding(guid)then
end
end
end
cameraMoveController:Begin({eSceneType.eZongmen,mapIdType.zhufeng},{cameraMoveTargetType.eZongmeng_build8,SLG_SYSTEM_TYPE.eXianZhan},func)
end
return true
end
}

uiwindow_id['UIXianMengWin']={
id=JUMP_TYPE.eXianMeng,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return true
end
}

uiwindow_id['UIXianMengCreateWin']={
id=JUMP_TYPE.eXianMengCreate,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
xianmengController:openJoinWin()
UIManager:showWindow("UIXianMengCreateWin")
return true
end
}

uiwindow_id['UIXianMengJoinWin']={
id=JUMP_TYPE.eXianMengJoin,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
xianmengController:openJoinWin()
return true
end
}


uiwindow_id['UIFangsheWin']={
id=JUMP_TYPE.eFangshe,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
return zongmenControl:openFangsheBuild(args)
end
}


uiwindow_id['UIZongmenInfoWin']={
id=JUMP_TYPE.eZongmenInfo,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return UIManager:showWindow('UIZongmenInfoWin',{showback=true})
end
}


uiwindow_id['UIChangeZMNameWin']={
id=JUMP_TYPE.eChangeZongmenName,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return UIManager:showWindow('UIChangeZMNameWin')
end
}


uiwindow_id['UIChangePlayerNameWin']={
id=JUMP_TYPE.eChangePlayerName,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return UIManager:showWindow('UIChangePlayerNameWin')
end
}


uiwindow_id['UIFuncItemUseWin']={
id=JUMP_TYPE.eFuncItemUse,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return UIFuncItemUseModel:openFuncItemUseWin(args)
end
}



uiwindow_id['UIZhiShengItemWin']={
id=JUMP_TYPE.eZhenshengItemUse,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
return UIFullCommonControl:openZhiShengItemUseWin(args)
end
}


uiwindow_id['UIDiscipleSelectWin']={
id=JUMP_TYPE.eDiscipleSelect,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
return UIFullDiscipleSelectControl:showDiscipleSelectWindow(args)
end
}


uiwindow_id['UIDiscipleMainWin']={
id=JUMP_TYPE.eDiscipleMain,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local disData=nil
if args.plotType~=nil then
disData=UIDiscipleModel:getPlotDiscipleByIndex(args.plotType)
elseif args.fightIndex~=nil then
disData=UIDiscipleModel:getDiscipleByFightIndex(args.fightIndex)
elseif args.equipjinglian~=nil then
local equipType=args.equipjinglian[1]
local index=args.equipjinglian[2]or 1
local dzlist=UIDiscipleModel:getDiscipleList_equipType(equipType)
local data=dzlist[index]
if data==nil then
data=dzlist[1]
end
if data==nil then
UIManager.error('暂无符合精炼要求的弟子')
else
disData=data[1]
end
end
local discipleguid=args.discipleguid or(disData and disData.discipleguid)
if discipleguid then
return UIFullCommonControl:jumpDiscipleMain(discipleguid,args.tabType,nil,args.subArgs)
end
return false
end
}


uiwindow_id['UIDiscipleShuWuWin']={
id=JUMP_TYPE.eShuWuDiZi,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local dzList=UIDiscipleModel:getAllDiscipleData()
local list={}
for k,v in pairs(dzList)do
local data=v.netData.net
if UIDiscipleModel:isShuWuDisciple(data.id)then
table.insert(list,data)
end
end
local len=#list
if len<=0 then
UIManager.error('暂无庶务弟子')
return false
end
table.sort(list,function(a,b)
local fv1=UIDiscipleModel:getShuWuFightValue(a.discipleguid)
local fv2=UIDiscipleModel:getShuWuFightValue(b.discipleguid)
return fv1>fv2
end)
local winType=args.winType
if winType==1 then
local dzData
local skillId
local skillLevel
for i,v in ipairs(list)do
local skills=cfgHelper.get2(cfg_discipleshuwuconfig_get,v.id,'skill')
for ii,vv in ipairs(skills)do
local level=v.swList[ii]
local cfg=cfgHelper.get2(cfg_discipleshuwuskillconfig_get,vv,level)
if UIDiscipleController:checkShuWuQJSkillLevelUp(v,cfg)then
skillId=vv
skillLevel=level
break
end
end
if skillId then
dzData=v
break
end
end
if not skillId then
for i,v in ipairs(list)do
local skills=cfgHelper.get2(cfg_discipleshuwuconfig_get,v.id,'skill')
for ii,vv in ipairs(skills)do
local level=v.swList[ii]
local nlcfg=cfgHelper.get2(cfg_discipleshuwuskillconfig_get,vv,level+1)
if nlcfg then
skillId=vv
skillLevel=level
break
end
end
if skillId then
dzData=v
break
end
end
end
if dzData then
local ret=UIFullCommonControl:jumpDiscipleMain(dzData.discipleguid,args.tabType)
if ret then
UIManager:showWindow('UIDiscipleShuWuSkillWin',dzData.discipleguid)
UIManager:showWindow('UIDiscipleShuWuSkillTipsWin',{id=skillId,level=skillLevel,dzId=dzData.discipleguid})
end
return ret
else
dzData=list[1]
return UIFullCommonControl:jumpDiscipleMain(dzData.discipleguid,args.tabType)
end
end

return false
end
}




uiwindow_id['UIDiscipleMainWin2']={
id=JUMP_TYPE.eDiscipleMain2,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local disguid=UIDiscipleModel:findClosestJingJieDZ(args.jjlevel)
if disguid~=nil then
if UIDiscipleModel:checkJJReddot(disguid)then
if args.weakguide1 then
weakGuideController:beginGuide(args.weakguide1)
end
else
if args.weakguide2 then
weakGuideController:beginGuide(args.weakguide2)
end
end
return UIFullCommonControl:jumpDiscipleMain(disguid)
else
return UIFullDiscipleSelectControl:showDiscipleSelectWindow()
end
end
}




uiwindow_id['UIDiscipleMainWin3']={
id=JUMP_TYPE.eDiscipleMain3,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local disguid=UIDiscipleModel:findClosestLianTiDZ(args.ltlevel)
if disguid~=nil then
if UIDiscipleModel:checkLTReddot(disguid)then
if args.weakguide1 then
weakGuideController:beginGuide(args.weakguide1)
end
else
if args.weakguide2 then
weakGuideController:beginGuide(args.weakguide2)
end
end
return UIFullCommonControl:jumpDiscipleMain(disguid)
else
return UIFullDiscipleSelectControl:showDiscipleSelectWindow()
end
end
}




uiwindow_id['UIDiscipleMainWin4']={
id=JUMP_TYPE.eDiscipleMain4,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local disguid=UIDiscipleModel:findClosestLinggenLvDZ(args.ltlevel)
if disguid~=nil then
if args.weakguide then
weakGuideController:beginGuide(args.weakguide)
end
return UIFullCommonControl:jumpDiscipleMain(disguid,args.tabType)
else
return UIFullDiscipleSelectControl:showDiscipleSelectWindow()
end
end
}




uiwindow_id[JUMP_TYPE.eDiscipleMain5]={
id=JUMP_TYPE.eDiscipleMain5,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local disguid=UIDiscipleModel:findClosestXinFaLvDZ()
if disguid~=nil then
if args.weakguide then
weakGuideController:beginGuide(args.weakguide)
end
return UIFullCommonControl:jumpDiscipleMain(disguid,args.tabType,nil,{isOpenSubJJWin=true})
else
return UIFullDiscipleSelectControl:showDiscipleSelectWindow()
end
end
}

uiwindow_id[JUMP_TYPE.eDiscipleMain6]={
id=JUMP_TYPE.eDiscipleMain6,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local discList=UIDiscipleModel:getSortList(function(data)
return data.jingjielv>=(args.level or 0)and not UIDiscipleModel:checkDiscipleXianMoVoc(data.discipleguid)
end,function(dataA,dataB)
if dataA.jingjielv~=dataB.jingjielv then
return dataA.jingjielv>dataB.jingjielv
else
return dataA.jingjieexp>dataB.jingjieexp
end
end)
if#discList>0 then
if args.weakguide then
weakGuideController:beginGuide(args.weakguide)
end
local data=discList[1]
return UIFullCommonControl:jumpDiscipleMain(data.discipleguid,FULL_TAB_TYPE.eDiscipleInfo,nil,{isOpenSubJJWin=true})
end

return UIFullDiscipleSelectControl:showDiscipleSelectWindow()
end
}



uiwindow_id['UICreateZMNameWin']={
id=JUMP_TYPE.eCreateZMName,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return UIManager:showWindow('UICreateZMNameWin')
end
}


uiwindow_id['UITaskMainWin']={
id=JUMP_TYPE.eTaskMain,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
return UIFullTaskMainControl:showWindowTask(args)
end
}


uiwindow_id['UIDailyTaskWin']={
id=JUMP_TYPE.eDailyTask,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
return UIFullTaskMainControl:showWindowDaily(args)
end
}


uiwindow_id['UIGuBaoCollectWin']={
id=JUMP_TYPE.eGuBaoCollect,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
return UIFullGuBaoControl:showWindowCollect(args)
end
}


uiwindow_id['UIGuBaoBagWin']={
id=JUMP_TYPE.eGuBaoBag,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
return UIFullGuBaoControl:showWindowBag(args)
end
}


uiwindow_id[JUMP_TYPE.eDaoBingCollect]={
id=JUMP_TYPE.eDaoBingCollect,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
return UIFullGuBaoControl:showWindowDaoBingCollect(args)
end
}


uiwindow_id[JUMP_TYPE.eDaoBingBag]={
id=JUMP_TYPE.eDaoBingBag,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
return UIFullGuBaoControl:showWindowDaoBingBag(args)
end
}


uiwindow_id['UIMysteryEnterWin']={
id=JUMP_TYPE.eMysteryEnter,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return MysteryController:jumpToMystery(args.fbId,args.worldId,args.blockId,args.pos)
end
}


uiwindow_id['UIEquipWin']={
id=JUMP_TYPE.eEquip,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
return false
end
}


uiwindow_id['UIEquipJinglianWin']={
id=JUMP_TYPE.eEquipJinglian,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return equipsControl.openJinglianWindow(args)
end
}

uiwindow_id['UIWorldTourWin']={
id=JUMP_TYPE.eWorldTour,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIManager:showWindow("UIWorldTourWin")
return true
end
}

uiwindow_id['UIMysteryListWin']={
id=JUMP_TYPE.eMysteryList,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
worldController:changeLeftView("UIWorldUnitListWin2",{tab=1,extra=args})

return true
end
}

uiwindow_id['UIMysteryEnterZiYuanWin']={
id=JUMP_TYPE.eMysteryEnterZiYuan,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
args=args or{}

mysteryZiYuanFuBenController:jumpToMystery(args.tagId)
return true
end
}


uiwindow_id['UIWorldXiuZhenJiaZuListWin']={
id=JUMP_TYPE.eWorldFamilyList,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
worldController:changeLeftView("UIWorldUnitListWin2",{tab=4})

return true
end
}

uiwindow_id['UIWorldNPCListWin']={
id=JUMP_TYPE.eWorldNPCList,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
worldController:changeLeftView("UIWorldUnitListWin2",{tab=5})

return true
end
}

uiwindow_id['UISystemZongMenListWin']={
id=JUMP_TYPE.eWorldSystemZongMenList,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
worldController:changeLeftView("UIWorldUnitListWin2",{tab=3})

return true
end
}

uiwindow_id['UIWorldWin']={
id=JUMP_TYPE.eWorld,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return true
end
}

uiwindow_id['UIXianJieWin']={
id=JUMP_TYPE.eXianJie,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eXianYu]={
id=JUMP_TYPE.eXianYu,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return true
end
}

uiwindow_id['UIFuLuMixWin']={
id=JUMP_TYPE.eFuLuMix,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
args=args or{}
args.entityId=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eFuLuFang,true,nil,true)
if args.entityId==nil then
return false
end
return UIFullFuLuFangControl:showFuLuWin(args)
end
}

uiwindow_id['UIFuLuFJWin']={
id=JUMP_TYPE.eFuLuFJ,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
args=args or{}
args.entityId=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eFuLuFang,true,nil,true)
if args.entityId==nil then
return false
end
return UIFullFuLuFangControl:showFuBaoFJWin(args)
end
}

uiwindow_id['UIAreaUnlockWin']={
id=JUMP_TYPE.eAreaUnlock,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
return isometricMapSystem:openAreaUnLockWin(nil,args[1])

end
}

uiwindow_id['UIWorldMonsterListWin']={
id=JUMP_TYPE.eWorldMonster,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
worldController:changeLeftView("UIWorldUnitListWin2",{tab=2})

return true
end
}

uiwindow_id['UILingShouRongHeWin']={
id=JUMP_TYPE.eLingShouRongHe,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
args=args or{}
local bdList=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eJiuLiDian,true,true,true,true)
if bdList==nil or#bdList<=0 then return false end
args.entityId=bdList[1].entityId
if args.entityId==nil then
return false
end
UIFullJiuLiDianControl:showRongHeWindow(args)
return true
end
}

uiwindow_id['UILingShouJueXingWin']={
id=JUMP_TYPE.eLingShouJueXing,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
args=args or{}
local bdList=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eJiuLiDian,true,true,true,true)
if bdList==nil or#bdList<=0 then return false end
args.entityId=bdList[1].entityId
if args.entityId==nil then
return false
end
UIFullJiuLiDianControl:showJueXingWindow(args)
return true
end
}

uiwindow_id['UILingShouDaoMainWin']={
id=JUMP_TYPE.eLingShouDao,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return true
end
}

uiwindow_id['UIShiLianTaMainWin']={
id=JUMP_TYPE.eShiLianTa,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local battleId=shiLianTaModel:getPlayingBattle()
if battleId and fightController:isBattlePlaying(battleId)then
local smData=zongmenModel:findBuildingDataByType(zongmenModel:getMountainId(),SLG_SYSTEM_TYPE.eShiLianTa)
if smData then
isometricMapSystem:moveCameraToObject(smData.entityId,false,nil)
end
UIManager:closeWindow('UILayoutWin')
return true
end

local ret,isOpenLayout=zongmenControl:jumpBuildingWin({type=29})
if ret and not isOpenLayout then
UIManager:closeWindow('UILayoutWin')
end
return ret
end
}

uiwindow_id[JUMP_TYPE.eJiuYouTa]={
id=JUMP_TYPE.eJiuYouTa,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local battleId=JiuYouTaModel:getPlayingBattle()
if battleId and fightController:isBattlePlaying(battleId)then
local smData=zongmenModel:findBuildingDataByType(zongmenModel:getMountainId(),SLG_SYSTEM_TYPE.eShiLianTa)
if smData then
isometricMapSystem:moveCameraToObject(smData.entityId,false,nil)
end
UIManager:closeWindow('UILayoutWin')
return true
end

local ret,isOpenLayout=zongmenControl:jumpBuildingWin({type=29,args={jumpIndex=3}})
if ret and not isOpenLayout then
UIManager:closeWindow('UILayoutWin')
end
return ret
end
}


uiwindow_id['UIDouFaTaiMainWin']={
id=JUMP_TYPE.eDouFaTai,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
local ret,isOpenLayout=zongmenControl:jumpBuildingWin({type=38})
if ret and not isOpenLayout then
UIManager:closeWindow('UILayoutWin')
end
return ret
end
}

uiwindow_id['UIFuncShopWin_DouFaTai']={
id=JUMP_TYPE.eDouFaTaiShop,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
local ret,isOpenLayout=zongmenControl:jumpBuildingWin({type=38,args={openShop=true}})
if ret and not isOpenLayout then
UIManager:closeWindow('UILayoutWin')
end
return ret
end
}

uiwindow_id["UIZhenFaStudyWin"]={
id=JUMP_TYPE.eZhenFaStudy,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
args=args or{}
local bdList=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eTianGongGe,true,true,true,true)
if bdList==nil or#bdList<=0 then return false end
args.entityId=bdList[1].entityId
if args.entityId==nil then
return false
end
UIFullTianGongGeControl:showZhenFaWindow(args)
return true
end
}

uiwindow_id["UIZhenFaLevelUpWin"]={
id=JUMP_TYPE.eZhenFaLevelUp,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
local zfId=args.zfId or 1
args=args or{}
local bdList=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eTianGongGe,true,true,true,true)
if bdList==nil or#bdList<=0 then return false end
for i,v in ipairs(bdList)do
if v.entityId and not zhenfaModel:isStartStudying(v.un_build_id)then
args.entityId=v.entityId
UIFullTianGongGeControl:showZhenFaWindow(args)
local param={
sfId=zongmenModel.buildingInMapData[v.un_build_id],
bdData=v,
zfId=args.zfId,
}
UIFullTianGongGeControl:showWindow("UIZhenFaLevelUpWin",param)
return true
end
end

for i,v in ipairs(bdList)do
if v.entityId then
args.entityId=v.entityId
UIFullTianGongGeControl:showZhenFaWindow(args)
return true
end
end

return false
end
}

uiwindow_id["UILZDKMainWin"]={
id=JUMP_TYPE.eZhenFaDiaoKe,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
args=args or{}
local bdList=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eTianGongGe,true,true,true,true)
if bdList==nil or#bdList<=0 then return false end

local sfid=zongmenModel:getMountainId()
local bestEntityId,bestLv=nil,0
for i,v in ipairs(bdList)do
if v.entityId then
local bdData=zongmenModel:findBuildingByEntityId(v.entityId)
local dzGuid=bdData and(bdData.dizi_id or bdData.dzIdStr)
if not mathHelper.validInt64(dzGuid)then
dzGuid=nil
end
if dzGuid then
local lv=UIDiscipleModel:getDiscipleJobLevel(dzGuid,DISCIPLE_PROSKILL_TYPE.eZhenFa)or 0
if lv>bestLv then
bestLv=lv
bestEntityId=v.entityId
end
end

if LZDiaoKeModel:CheckDKState(sfid,bdData.un_build_id)==LZDKSTATE.eHoldDKReward then
args.entityId=v.entityId
UIFullTianGongGeControl:showLingZhenDiaoKeWindow(args)
return true
end
end
end

args.entityId=bestEntityId or bdList[1].entityId
if args.entityId==nil then
return false
end
UIFullTianGongGeControl:showLingZhenDiaoKeWindow(args)
return true
end
}

uiwindow_id["UIMiJingWin"]={
id=JUMP_TYPE.eZongmenMystery,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
args=args or{}
local mjId=args.fbId
local cfg_fb=cfgHelper.get(cfg_secretscenefubenconfig_get,mjId)
if cfg_fb.practice~=MysterySenceType.ZongMen then
return false
end
if not cfg_fb.sceneParam then
return false
end

local mjEntity=isometricMapSystem:findNoServerData(cfg_fb.sceneParam[1],cfg_fb.sceneParam[2],cfg_fb.sceneParam[3],cfg_fb.sceneParam[4])
if mjEntity==nil then
return false
end
isometricMapSystem:checkTouchSundrise(mjEntity.guid,objectType.eStillPlaceObject)
return true
end
}

uiwindow_id["UIXianZhanInteractWin"]={
id=JUMP_TYPE.eXianZhanInteract,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
args=args or{}
local list=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eXianZhan,true,true,false)
if list~=nil and#list>0 then
local func=function(flag,pos,backParams)
if flag then
local roomId=args.roomId
if roomId~=nil then
if not xianzhanModel:isFirstIn()then
if UIManager:isActive('UIXianZhanMapWin')then
xianzhanController:onRoomClick(roomId)
else
timeEventController.delayDo(1.5,function()
xianzhanController:onRoomClick(roomId)
end)
end
end
end
end
end
cameraMoveController:Begin({eSceneType.eZongmen,mapIdType.xianzhan},nil,func)
else

local func=function(flag,pos,backParams)

if flag then
local guid=backParams.guid
local inUnlockArea=isometricMapSystem:isInUnlockArea(guid)
if isometricMapSystem:checkTouchRepairBuilding(guid,inUnlockArea)then
elseif isometricMapSystem:checkTouchBuilding(guid)then
end
end
end
cameraMoveController:Begin({eSceneType.eZongmen,mapIdType.zhufeng},{cameraMoveTargetType.eZongmeng_build8,SLG_SYSTEM_TYPE.eXianZhan},func)
end
return true
end
}

uiwindow_id["UIXianZhanInteractWin2"]={
id=JUMP_TYPE.eXianZhanInteract2,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
args=args or{}
local list=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eXianZhan,true,true,false)
if list~=nil and#list>0 then
local func=function(flag,pos,backParams)
if flag then

local flag,roomId=xianzhanModel:hasTaskRoom()
if roomId~=nil then
if not xianzhanModel:isFirstIn()then




if UIManager:isActive('UIFuncShopMenuWin')then
UIManager:closeWindow('UIFuncShopMenuWin')
end
local win=UIManager:findActiveWindow('UICommonMoneyGainWin')
if win then
win:onCloseClick()
end
if UIManager:isActive('UIXianZhanMapWin')then
xianzhanController:onRoomClick(roomId)
else
timeEventController.delayDo(1.5,function()
xianzhanController:onRoomClick(roomId)
end)
end
end
else
UIManager.error('当前的访客都没有委托')
end
end
end
cameraMoveController:Begin({eSceneType.eZongmen,mapIdType.xianzhan},nil,func)
else

local func=function(flag,pos,backParams)

if flag then
local guid=backParams.guid
local inUnlockArea=isometricMapSystem:isInUnlockArea(guid)
if isometricMapSystem:checkTouchRepairBuilding(guid,inUnlockArea)then
elseif isometricMapSystem:checkTouchBuilding(guid)then
end
end
end
cameraMoveController:Begin({eSceneType.eZongmen,mapIdType.zhufeng},{cameraMoveTargetType.eZongmeng_build8,SLG_SYSTEM_TYPE.eXianZhan},func)
end
return true
end
}

uiwindow_id[JUMP_TYPE.eXianZhanShop]={
id=JUMP_TYPE.eXianZhanShop,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
args=args or{}
local list=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eXianZhan,true,true,false)
if list~=nil and#list>0 then
local func=function(flag,pos,backParams)
if flag then
if not xianzhanModel:isFirstIn()then
xianzhanController:onCommonShopClick()
end
end
end
cameraMoveController:Begin({eSceneType.eZongmen,mapIdType.xianzhan},nil,func)
else
local func=function(flag,pos,backParams)

if flag then
local guid=backParams.guid
local inUnlockArea=isometricMapSystem:isInUnlockArea(guid)
if isometricMapSystem:checkTouchRepairBuilding(guid,inUnlockArea)then
elseif isometricMapSystem:checkTouchBuilding(guid)then
end
end
end
cameraMoveController:Begin({eSceneType.eZongmen,mapIdType.zhufeng},{cameraMoveTargetType.eZongmeng_build8,SLG_SYSTEM_TYPE.eXianZhan},func)
end
return true
end
}

uiwindow_id["moneybuy_jump"]={
id=JUMP_TYPE.eMoneyBuy,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)

local id=args.money
if id then
if id==eMoneyType.mtDiGongXingDongLi then
xianmengdigongController:onBuyXDL(true)

return false
elseif id==eMoneyType.mtXuKongLing then
moneySystem:showBuyTips(id)

return false
else
local check=moneySystem:showBuyTips(id)



return check
end
end
return false
end
}


uiwindow_id["unlockRepairBuild"]={
id=JUMP_TYPE.eUnlockRepairBuild,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local buildType=args.buildType
if buildType then
local rdata=isometricMapSystem:getAllUnlockRepairDataByID(buildType)
if rdata then
isometricMapSystem:moveCameraToObject(rdata.guid,false,nil)
isometricMapSystem:onTouchUp(nil,rdata.guid)

return true
end
end
return false
end
}

uiwindow_id[JUMP_TYPE.eUnlockRepairBuild2]={
id=JUMP_TYPE.eUnlockRepairBuild2,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local buildType=args.buildType
if buildType then
local rdata=isometricMapSystem:getAllUnlockRepairDataByID(buildType)
if rdata then
isometricMapSystem:moveCameraToObject(rdata.guid,false,nil)
if args.weakGuide then
weakGuideController:beginGuide(args.weakGuide)
end
return true
end
end
return false
end
}


uiwindow_id["UIWorldBossWin_Monster"]={
id=JUMP_TYPE.eWorldMonsterInfo,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local id=args.monId
if id then
local mon=worldMonsterModel:get_monster_by_worldMonsterId(id)
if mon then
local args={eWorldUnitTpye.MONSTER,mon.posId}
local func=function()
worldMonsterController.onClickObjectInWorld(args)
end
if worldController:checkEnterParam()then
worldController:pushMidwayHandle(func)
else
func()
end
return true









end
end
return false
end
}

uiwindow_id["UIWorldBossWin_ResPoint"]={
id=JUMP_TYPE.eWorldResInfo,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local unitParam=nil
if args.monId then
local mon=worldResPointDataModel:get_monster_data_by_id(args.monId)
if mon then
local info=string.split(mon.guid,'_')
local guid=int64.new(info[1])
local subIdx=tonumber(info[2])
unitParam={eWorldUnitTpye.RESPOINT,guid,subIdx,eWorldResPointUnitType.Monster,mon.id}
end
elseif args.taskId then
local data=worldResPointDataModel:findTaskData(args.taskId)
if data then
local subIndex=nil
for i,v in pairs(data.datas)do
if v[1]==eWorldResPointUnitType.Monster then
subIndex=i
break
end
end
subIndex=subIndex or next(data.datas)
local subData=data.datas[subIndex]
unitParam={eWorldUnitTpye.RESPOINT,data.guid,subIndex,subData[1],subData[2]}
end
end

if unitParam then
local func=function()
worldResPointController.onClickUnitEvent(unitParam)
end
if worldController:checkEnterParam()then
worldController:pushMidwayHandle(func)
else
func()
end
return true
end

return false
end
}

uiwindow_id[JUMP_TYPE.eZheXianLing]={
id=JUMP_TYPE.eZheXianLing,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
return UIFullZheXianControl:showZheXianLingWindow({winType=args.tab})
end

}

uiwindow_id[JUMP_TYPE.eFriend]={
id=JUMP_TYPE.eFriend,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local tab=args.tab or 1
local subtab=args.subtab or 1
if tab==1 then
return UIFullFriendMainControl:showWindowList({tabIndex=subtab})
elseif tab==2 then
return UIFullFriendMainControl:showWindowAdd()
elseif tab==3 then
return UIFullFriendMainControl:showWindowApply()
end
return false
end

}

uiwindow_id[JUMP_TYPE.eChuanSongZhen]={
id=JUMP_TYPE.eChuanSongZhen,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
args=args or{}
local bdList=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eChuanSongZhen,true,true,true,true)
if bdList==nil or#bdList<=0 then return false end
local td=bdList[1]
args.entityId=td.entityId
if args.entityId==nil then
return false
end
UIFullChuanSongZhenControl:showMainWindow(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eHeadSelect]={
id=JUMP_TYPE.eHeadSelect,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local tab=args.tab or 1
local itemid=args.itemid or-1
if tab~=1 and tab~=2 and tab~=3 and tab~=4 and tab~=5 and tab~=6 then
return false
end


local isActive,headId=UISettingController:checkUnlockByItemId(tab,itemid)
if isActive then

UISettingController:useItemUnlockHead(tab,headId)
return false
end

local secFullTab=UISettingController:getSecFullTabByTab(tab)
return oneTabScreenController:openTabUI(secFullTab,{itemId=itemid})
end

}

uiwindow_id[JUMP_TYPE.eActivity]={
id=JUMP_TYPE.eActivity,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
if args then
local actid=args.actId
local subType=args.subType
local subid=args.subid
local sublist=args.sublist
local extraParams=args.extraParams
if actid then
return activitiesController:jump(actid,subType,subid,extraParams)
elseif sublist then
return activitiesController:jump_list(sublist,extraParams)
elseif subid==nil then
return activitiesController:jump_subType(subType,extraParams)
else
return activitiesController:jump_subType_subid(subType,subid,extraParams)
end
end
return false
end,
check_can_jump=function(args)
local result=false
if args then
local subType=args.subType
local subid=args.subid
local sublist=args.sublist
local extraParams=args.extraParams
if sublist then
for i,v in ipairs(sublist)do
local subType=v[1]
local subid=v[2]
local sub_actList=activitiesModel:getActSubList_subType_subid_doing(subType,subid)
if#(sub_actList or{})>0 then
for i2,sub_actInfo_ in ipairs(sub_actList)do
if sub_actInfo_:checkOpen()and sub_actInfo_:getUnlock()and activitiesModel:checkActOpen(sub_actInfo_.act_id)then
result=true
break
end
end
end
end
elseif subid==nil then
local sub_actList=activitiesModel:getActSubList_subType_doing(subType)
if#(sub_actList or{})>0 then
for i,sub_actInfo in ipairs(sub_actList)do
if sub_actInfo:checkOpen()and sub_actInfo:getUnlock()and activitiesModel:checkActOpen(sub_actInfo.act_id)then
result=true
break
end
end
end
else
local sub_actList=activitiesModel:getActSubList_subType_subid_doing(subType,subid)
if#(sub_actList or{})>0 then
for i,sub_actInfo in ipairs(sub_actList)do
if sub_actInfo:checkOpen()and sub_actInfo:getUnlock()and activitiesModel:checkActOpen(sub_actInfo.act_id)then
result=true
break
end
end
end
end
end
return result
end
}

uiwindow_id[JUMP_TYPE.eLimitActivity]={
id=JUMP_TYPE.eLimitActivity,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
if args then
local actID=args.actID
local extraParams=args.extraParams
if actID==LIMIT_ACT_TYPE.eShiJieShouLing and not limitActivitiesController:jump(actID,extraParams)then
return limitActivitiesController:jump(LIMIT_ACT_TYPE.eXianJieFuMo,extraParams)
end
return limitActivitiesController:jump(actID,extraParams)
end
return false
end
}

uiwindow_id[JUMP_TYPE.eLunDaoDaHui]=
{
id=JUMP_TYPE.eLunDaoDaHui,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
if not lundaodahuiModel:checkUnlockEx(true)then
return false
end

UIFullLunDaoDaHuiControl:showLunDaoDaHui(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eXianFaWenDao]=
{
id=JUMP_TYPE.eXianFaWenDao,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local check=UIXianFaWenDaoControl:showXianFaWenDaoWin(args)
return check
end
}

uiwindow_id[JUMP_TYPE.eTianDaoShu]=
{
id=JUMP_TYPE.eTianDaoShu,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local check=tiandaoshuController:checkShowBuilding(true)
if check then
UIFullTianDaoShuController:showMainWindow()
return true
end
return false
end
}

uiwindow_id[JUMP_TYPE.eXianWuLou]=
{
id=JUMP_TYPE.eXianWuLou,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local check=zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eXianWuLou)
if check then
xianmengController:openXianWuLouWin(args.tabType)
return true
end
UIManager.error("仙务楼未修复")
return false
end
}

uiwindow_id[JUMP_TYPE.eXianMengDiGongShop]=
{
id=JUMP_TYPE.eXianMengDiGongShop,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
return limitActivitiesController:jump(LIMIT_ACT_TYPE.eXianMengDiGong,{openShop=true})
end
}

uiwindow_id[JUMP_TYPE.eXianMengDiGongNote]=
{
id=JUMP_TYPE.eXianMengDiGongNote,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
return limitActivitiesController:jump(LIMIT_ACT_TYPE.eXianMengDiGong,{openNote=args.page})
end
}

uiwindow_id[JUMP_TYPE.eXianMengDiGongGL]=
{
id=JUMP_TYPE.eXianMengDiGongGL,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
return xianmengdigongController:jumpGL()
end
}

uiwindow_id[JUMP_TYPE.eLingXuWenJianWJT]=
{
id=JUMP_TYPE.eLingXuWenJianWJT,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
return lingxuwenjianController:jumpWJT()
end
}

uiwindow_id[JUMP_TYPE.eXianTuChengJiu]=
{
id=JUMP_TYPE.eXianTuChengJiu,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local param={}
if args then
param['tab']=args.subTab
end
UIFullXianTuChengJiuControl:showMainWindow(args.tab,param)
return true
end
}

uiwindow_id[JUMP_TYPE.eBuildSuit]=
{
id=JUMP_TYPE.eBuildSuit,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
isometricMapSystem:enterLayoutModel({model=layoutMode.eBuild,sortType=BUILD_TAB_TYPE.eJingGuan})
UILayoutControl:showWindow("UIBuildingSuitWin",{suit=args.suit})
return true
end
}

uiwindow_id["fastbuy_jump"]=
{
id=JUMP_TYPE.eFastBuy,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
local itemid=args.item
local num=args.num or 1
if itemid then
local getDescFunc=function(uselist)
local itemName=itemsConfig.getColorName(itemid)
local cost=fastBuyController.getCostDescWithIcon(uselist)
local contentStr=FMT.fmt('{0}不足，是否花费{1}购买？',itemName,cost)
return contentStr
end
fastBuyController:checkBuy(itemid,num,function()
UIManager:closeWindow('UICommonPageWin')
end,getDescFunc)
return true
end
return false
end
}

uiwindow_id[JUMP_TYPE.eDailyEvent]=
{
id=JUMP_TYPE.eDailyEvent,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
if args.guid then
worldDailyEventController:jumpToEvent(args.guid)
else
return worldDailyEventController:jumpToOneEvent()
end
end
}

uiwindow_id[JUMP_TYPE.eGoodsGain]=
{
id=JUMP_TYPE.eGoodsGain,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
local itemid=args.itemid
gainControl:showGainWin(itemid)
return false
end
}

uiwindow_id["WeekList_PoetryArena"]=
{
id=JUMP_TYPE.ePeotryArena,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
worldController:changeLeftView("UIWorldUnitListWin2",{tab=6,extra={act=LIMIT_ACT_TYPE.eWenDouLeiTai}})
return true
end
}

uiwindow_id[JUMP_TYPE.eWorldWeekUnit]=
{
id=JUMP_TYPE.eWorldWeekUnit,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
worldController:changeLeftView("UIWorldUnitListWin2",{tab=6})
return true
end
}

uiwindow_id[JUMP_TYPE.ePlayerImage]=
{
id=JUMP_TYPE.ePlayerImage,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIManager:showWindow('UIPlayerChangeImageWin')
return true
end
}

uiwindow_id[JUMP_TYPE.ePlayerInfo]=
{
id=JUMP_TYPE.ePlayerInfo,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIManager:showWindow('UIPlayerInfoWin')
return true
end
}

uiwindow_id[JUMP_TYPE.eBenMingFaBao]=
{
id=JUMP_TYPE.eBenMingFaBao,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
local fbGuid=fabaoModel.findTopLingXingBenMingFaBao()
local secFullTabType=args.secFullTabType or SEC_FULL_TAB_TYPE.fabaoBenMingInfo
if fbGuid then
local discipleguid=fabaoModel.getDiziguidByItemguid(fbGuid)
if discipleguid then
UIFullCommonControl:jumpDiscipleMain(discipleguid,FULL_TAB_TYPE.eDiscipleEquip)
end
oneTabScreenController:openTabUI(secFullTabType,{itemguid=fbGuid})
return true
else
UIManager.error("尚未获得本命法宝")
end
return false
end
}

uiwindow_id[JUMP_TYPE.eBLSPickUpPage]=
{
id=JUMP_TYPE.eBLSPickUpPage,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)

local data,mountid,buildid=zongmenControl:getBuilding({type=SLG_SYSTEM_TYPE.eBaoLingShu})
if not data then
local ret=zongmenControl:jumpBuildingWin({type=SLG_SYSTEM_TYPE.eBaoLingShu})
return ret
end

local bdList=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eBaoLingShu,true,true,true,true)
if bdList==nil or#bdList<=0 then return false end
local page=args and args.tabType or FULL_TAB_TYPE.eBLS_XuYuanShop
local isInPickUpNow=baoLingShuModel:checkIsInPickUpNow()
local openPageIndex
if page==FULL_TAB_TYPE.eBLS_XuYuanTarget then
if isInPickUpNow then
openPageIndex=1
else
UIManager.error("许愿目标活动尚未开启")
return false
end
elseif page==FULL_TAB_TYPE.eBLS_XuYuanLiBao then
if isInPickUpNow then
openPageIndex=2
else
UIManager.error("许愿礼包活动尚未开启")
return false
end
elseif page==FULL_TAB_TYPE.eBLS_XuYuanShop then
if isInPickUpNow then
openPageIndex=3
else
openPageIndex=1
end
end
args.needOpenPickUpPage=true
args.openPageIndex=openPageIndex

if UIManager:isActive('UIBaoLingShuWin')then

UIManager:closeWindow('UICommonPageWin')
UIFullBaoLingShuControl:showBaoLingShuPickUpWindow({openPageIndex=openPageIndex,isJump=true})
return true
else
local ret=zongmenControl:jumpBuildingWin({type=SLG_SYSTEM_TYPE.eBaoLingShu,args=args})
return ret
end
end
}

uiwindow_id[JUMP_TYPE.eXianMengXiangZhu]=
{
id=JUMP_TYPE.eXianMengXiangZhu,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local check=zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eXianWuLou)
if check then
if not xianmengModel:checkXWLInit()then
xianmengController:reqXWLInfo()
xianmengController:setMarkOpenXWL(false)
end
UIFullXianMengXianWuLouControl:showFXZYWindow(args)
return true
end
UIManager.error("仙务楼未修复")
return false
end
}

uiwindow_id[JUMP_TYPE.eXianMengJuanXian]=
{
id=JUMP_TYPE.eXianMengJuanXian,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local check=zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eXianWuLou)
if check then
if not xianmengModel:checkXWLInit()then
xianmengController:reqXWLInfo()
xianmengController:setMarkOpenXWL(false)
end
UIFullXianMengXianWuLouControl:showKuFangWindow(args)
return true
end
UIManager.error("仙务楼未修复")
return false
end
}

uiwindow_id[JUMP_TYPE.eWuXingDian]=
{
id=JUMP_TYPE.eWuXingDian,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
return UIFullWuXingDianControl:showWuXingDian(args,true)
end
}

uiwindow_id[JUMP_TYPE.eXianMengShop]=
{
id=JUMP_TYPE.eXianMengShop,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return xianmengController:showXMShop()
end
}

uiwindow_id[JUMP_TYPE.eCatAccountBook]=
{
id=JUMP_TYPE.eCatAccountBook,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIFullRechargeController:showMonthInvestorCatAccountBookWin()
return true
end
}

uiwindow_id[JUMP_TYPE.eSelectLiBao]=
{
id=JUMP_TYPE.eSelectLiBao,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
local argstable=args or{}
argstable.tabType=FULL_TAB_TYPE.eSelfSelectGif
UIFullRechargeController:showMyWindow(argstable)
return true
end
}

uiwindow_id[JUMP_TYPE.eWBXBDAdventure]=
{
id=JUMP_TYPE.eWBXBDAdventure,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
if wanBaoXunBaoDuiController.isCanShowSystem(true)then
UIFullWanBaoXunBaoDuiController:showWanBaoXunBaoDuiMTWindow(args)
end
return true
end
}

uiwindow_id[JUMP_TYPE.eWBXBDEmployee]=
{
id=JUMP_TYPE.eWBXBDEmployee,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
if wanBaoXunBaoDuiController.isCanShowSystem(true)then
UIFullWanBaoXunBaoDuiController:showWanBaoXunBaoDuiGYWindow(args)
end
return true
end
}

uiwindow_id[JUMP_TYPE.eWBXBDCatMiJin]=
{
id=JUMP_TYPE.eWBXBDCatMiJin,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)

if wanBaoXunBaoDuiController.isCanShowSystem(true)then
UIManager:showWindow("UIWanBaoXunBaoDui_MiJinWin")
end
return true
end
}

uiwindow_id[JUMP_TYPE.eWBXBDRecruit]=
{
id=JUMP_TYPE.eWBXBDRecruit,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
if wanBaoXunBaoDuiController.isCanShowSystem(true)then
UIFullWanBaoXunBaoDuiController:showWanBaoXunBaoDuiRecruitWindow({noshowMap=true})
end
return true
end
}

uiwindow_id[JUMP_TYPE.eWBXBDEquipBuild]=
{
id=JUMP_TYPE.eWBXBDEquipBuild,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIFullWanBaoXunBaoDuiController:showWanBaoXunBaoDuiDZWindow(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eAllShop]=
{
id=JUMP_TYPE.eAllShop,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
funcShopController:openShopWin(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eInstructionBook]=
{
id=JUMP_TYPE.eInstructionBook,
JUMP_WINDOW_TYPE=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local subId=args.subId
if subId then
local mainId=instructionbookModel:getLookup(subId)
if instructionbookModel:isMainTabOpen(mainId)and instructionbookModel:isSubTabOpen(subId)then
UIManager:showWindow("UIGameInstructionBookWin",{subId=subId})
return true
end
end
local mainId=args.mainId
if mainId and instructionbookModel:isMainTabOpen(mainId)then
UIManager:showWindow("UIGameInstructionBookWin",{mainId=mainId})
return true
end
if subId or mainId then
return false
else
UIManager:showWindow("UIGameInstructionBookWin")
return true
end
end
}
uiwindow_id[JUMP_TYPE.eBuildSkin]=
{
id=JUMP_TYPE.eBuildSkin,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
check_win_type_func=function(args)
local jumpWinType=JUMP_WINDOW_TYPE.eFullScreen
if args and args.buildId then
local buildId=args.buildId
if buildId==SLG_SYSTEM_TYPE.eXianZhan then
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen
end
end
return jumpWinType
end,
bag_tips_callback=function(args)
local checkArgs={
type=args.buildId
}
local data,mountid,buildid=zongmenControl:getBuilding(checkArgs)
local ret=false
local isOpenLayout=false
if data then

local callBack=function()

local argstable=args.args or{}
local nowMountainId=zongmenModel:getMountainId()
if buildid~=SLG_SYSTEM_TYPE.eXianZhan and mountid and mountid==nowMountainId then
if buildid==SLG_SYSTEM_TYPE.eZongMen then
argstable.tabType=FULL_TAB_TYPE.eSectPalaceInfo
elseif buildid==SLG_SYSTEM_TYPE.eCangJingGe then
argstable.isjump=true
end
isometricMapSystem:openBuildingWin(data,argstable)
end
buildSkinController:showBuildSkinListWin(data.build_id,data.un_build_id,args.skinId)
end

local sfId=zongmenModel:getBuildingLocationMapId(data.un_build_id)
local targetPos_x=data.x
local targetPos_y=data.y
local sfCallBack=function(flag_)
if flag_ then

local temppos=_MapManager.ToVector3Int(targetPos_x,targetPos_y,0)
local mapId=zongmenModel:getMountainId()
local pos=_MapManager.GetCellCenterWorld(mapId,temppos,mapLayer.Data)
isometricMapSystem:moveCameraToPosition(pos,true,callBack)
end
end

cameraMoveController:Begin({eSceneType.eZongmen,sfId},nil,sfCallBack)
ret=true
else
ret,isOpenLayout=zongmenControl:jumpBuildingWin(checkArgs)
end

if ret and not isOpenLayout then
UIManager:closeWindow('UILayoutWin')
end
return ret
end
}

uiwindow_id[JUMP_TYPE.eXianGongPingDing]=
{
id=JUMP_TYPE.eXianGongPingDing,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
return xiangongpingdingController:jump(true)
end
}

uiwindow_id[JUMP_TYPE.eXianGongPingDingHis]=
{
id=JUMP_TYPE.eXianGongPingDingHis,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return xiangongpingdingController:OpenHisWin(true)
end
}

uiwindow_id[JUMP_TYPE.eProsperityMain]=
{
id=JUMP_TYPE.eProsperityMain,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIFullProsperityController:showMainWindow()
return true
end
}
uiwindow_id[JUMP_TYPE.eWorldSystemZongMen]=
{
id=JUMP_TYPE.eWorldSystemZongMen,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
if args.ZMID then
local infoData=systemZongMenModel:findInfoDataByWorldAndID(worldModel.world,args.ZMID)
if infoData then
local unitParam={eWorldUnitTpye.SYSTEMZM,infoData.serial}
local func=function()
worldController:lookAtPosition(infoData.position,nil,true)
systemZongMenController.onClickEntity(unitParam)
end
if worldController:checkEnterParam()then
worldController:pushMidwayHandle(func)
else
func()
end
return true
end
end
return true
end
}

uiwindow_id[JUMP_TYPE.eProsperityDetailsInfo]=
{
id=JUMP_TYPE.eProsperityDetailsInfo,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIFullProsperityController:showDetailsInfoWindow(args)
return true
end
}


uiwindow_id[JUMP_TYPE.eSevenDayGoal]=
{
id=JUMP_TYPE.eSevenDayGoal,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)

local isEnd=sevenDayGoalModel:checkIsEnd()
if isEnd==nil or isEnd then
UIManager.info("七日试炼已结束")
return false
end

local dayIndex
local goalTypeIndex
if args and next(args)then
dayIndex=args.dayIndex
goalTypeIndex=args.goalTypeIndex
end
if dayIndex then

if sevenDayGoalModel:checkDayLock(dayIndex)then
UIManager.info(FMT.fmt("需七日试炼第{0}天开放",mathHelper.numberToChinese(dayIndex)))
return false
end
end


sevenDayGoalModel:clearSevenDayGoalIndex()

UIFullSevenDayGoalController:showMainUI(dayIndex,goalTypeIndex)
return true
end
}

uiwindow_id[JUMP_TYPE.eHouShanShiLian]=
{
id=JUMP_TYPE.eHouShanShiLian,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local list=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eHouShanMiJing)
if list~=nil and#list>0 then
local bdData=list[1]
local index=(args and args.index)and args.index or 1
local isPlayedAnim=(args and args.isPlayedAnim)and args.isPlayedAnim or false
if index==2 then
if UIHuanJingControl:isDayChallengeOpen()then
UIHuanJingControl:showAndOpenHuanJingWin({data=bdData,index=2,isPlayedAnim=isPlayedAnim})
return true
else
UIManager.error('后山试炼通关第4层开启')
return false
end
elseif index==3 then
if UIHuanJingControl:isJinDiFuncOpen()then
UIHuanJingControl:showAndOpenHuanJingWin({data=bdData,index=3,})
return true
else
local open=cfgHelper.get2(cfg_backmountainareabasicconfig_get,1,"open")
UIManager.error(FMT.fmt('后山试炼通关关卡{0}开启',UIHuanJingControl:getLevelName("",open)))
return false
end
else
UIHuanJingControl:showAndOpenHuanJingWin({data=bdData,index=index,})
return true
end
else
zongmenModel:noBuildingTips(SLG_SYSTEM_TYPE.eHouShanMiJing)
return false
end
end
}

uiwindow_id[JUMP_TYPE.eShanHaiBaoXia]=
{
id=JUMP_TYPE.eShanHaiBaoXia,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
if systemModel.isOpen(SYSTEM_DEFINE.eXianMeng)then
UIManager:showWindow('UIXM_ZZSH_TreasureBoxWin')
return true
else
UIManager.info(FMT.fmt("仙盟系统未开启"))
return false
end
end
}

uiwindow_id[JUMP_TYPE.eShangHangTouZi]=
{
id=JUMP_TYPE.eShangHangTouZi,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local list=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eShangHang)
if list~=nil and#list>0 then
local index=(args and args.index)and args.index or 1
if index==1 then
UIFullShangHangController:showShangHangTouZiWindow()
elseif index==2 then
UIFullShangHangController:showhangHangPaiHangWindow()
elseif index==3 then
UIFullShangHangController:showShangHangMuBiaoWindow()
end
return true
else
zongmenModel:noBuildingTips(SLG_SYSTEM_TYPE.eShangHang)
return false
end
end
}

uiwindow_id[JUMP_TYPE.eShangHangShiJianKa]=
{
id=JUMP_TYPE.eShangHangShiJianKa,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local list=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eShangHang)
if list~=nil and#list>0 then
UIFullShangHangController:showShangHangTouZiWindow()
UIManager:showWindow("UIGuPiaoItemEventWin")
return true
else
zongmenModel:noBuildingTips(SLG_SYSTEM_TYPE.eShangHang)
return false
end
end
}


uiwindow_id['UIShopProductionWin']={
id=JUMP_TYPE.eShopCreate,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
args=args or{}
local curr=zongmenModel:getBuildingCount(args.shopType,mapIdType.zhufeng)
local max=zongmenModel:getBuildingMaxNum(args.shopType,mapIdType.zhufeng)
local list=zongmenModel:getAllBuildingDataByBdId(mapIdType.zhufeng,args.shopType)
if not list and curr>=max then
UIShopControl:jumpToRechangeShop(args.shopType)
return true
else
args.entityId=zongmenModel:haveBuildByBuildId(args.shopType,true,nil,true)
if args.entityId==nil then
return false
end
if systemModel.isOpen(SYSTEM_DEFINE.eShopCreate)then
UIShopControl:showShopProductionWindow(args)
return true
else
UIManager.info(FMT.fmt("商铺生产未开启"))
return false
end
end
end
}


uiwindow_id[JUMP_TYPE.eFKSLVisiting]={
id=JUMP_TYPE.eFKSLVisiting,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local challengeId=zmvisitchallengeModel:getOpenChallengeId()
zmvisitchallengeController:showStartByChallengeId(challengeId)
return true
end
}

uiwindow_id[JUMP_TYPE.eFKSLBigReward]={
id=JUMP_TYPE.eFKSLBigReward,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
return UIFullZMVisitChallengeControl:showZMVisitChallengeWin()
end
}


uiwindow_id[JUMP_TYPE.eYuFuLingZhen]={
id=JUMP_TYPE.eYuFuLingZhen,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)

args=args or{}
local bdList=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eTianGongGe,true,true,true,true)
if bdList==nil or#bdList<=0 then return false end
args.entityId=bdList[1].entityId
if args.entityId==nil then
return false
end
UIFullTianGongGeControl:showZhenTuYanJiuWindow(args)
return true
end
}


uiwindow_id[JUMP_TYPE.eFuLuUse]=
{
id=JUMP_TYPE.eFuLuUse,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIManager:showWindow("UIUseFuluTipsWin",args)
return true
end
}

uiwindow_id[JUMP_TYPE.eHouShanZhenLing]={
id=JUMP_TYPE.eHouShanZhenLing,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local list=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eHouShanMiJing)
if list~=nil and#list>0 then
UIHuanJingControl:showZhenLingWindow(args)
return true
else
zongmenModel:noBuildingTips(SLG_SYSTEM_TYPE.eHouShanMiJing)
return false
end
end
}

uiwindow_id[JUMP_TYPE.eDiscipleCouple]={
id=JUMP_TYPE.eDiscipleCouple,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local sortType=UIDiscipleModel:getSaveSortType()
local sortOrder=eSortOrder.eDown
local sortParams={true}
local list=discipleLookup:getSortDiscipleList(sortType,nil,sortOrder,sortParams)
local guid=list[1].netData.net.discipleguid
if UIFullCommonControl:jumpDiscipleMain(guid)then
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.discipleCouple,{guid=guid})
return true
end
return false
end
}

uiwindow_id[JUMP_TYPE.eLingZhenHeCheng]={
id=JUMP_TYPE.eLingZhenHeCheng,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIManager:showWindow("UIYFLZCombineWin")
return true
end
}
uiwindow_id[JUMP_TYPE.eLingZhenChongZhu]={
id=JUMP_TYPE.eLingZhenChongZhu,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIManager:showWindow("UILingzhenChongZhuWin")
return true
end
}
uiwindow_id[JUMP_TYPE.eHongChenJie]={
id=JUMP_TYPE.eHongChenJie,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
local param=cfgHelper.get2(cfg_jctjsubsysconfig_get,JIUCHONGTIANJIE_SUB_SYS_TYPE.eHongChenJie,'param')
local args={id=param[1]}
UIFullHongChenJieControl:showMainWinByCloud(args)
return true
end
}
uiwindow_id[JUMP_TYPE.eJiuChongTianJie]={
id=JUMP_TYPE.eJiuChongTianJie,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local state=JiuChongTianJieEnterModel:getState()

if state==eJiuChongTianJieStateType.eStart then
UIManager:showWindow("UIJiuChongTianJieBeginWin")
return true
elseif state==eJiuChongTianJieStateType.eDoing then
if args and args.sysType then
return UIFullJiuChongTianJieControl:showSubWindow(args)
else
return UIFullJiuChongTianJieControl:showFullWindow()
end
end
return false
end
}
uiwindow_id[JUMP_TYPE.eSiFangPingYao]={
id=JUMP_TYPE.eSiFangPingYao,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIFullSiFangPingYaoControl:showSiFangPingYaoMapWin(args)
return true
end
}
uiwindow_id[JUMP_TYPE.eZMDaoShi]={
id=JUMP_TYPE.eZMDaoShi,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
if ZongMenDaoShiController:isOpenZongMenDaoShi()then
ZongMenDaoShiController:showZongMenDaoShiWin()
return true
end
return false
end
}

uiwindow_id[JUMP_TYPE.eActivityCalendar]={
id=JUMP_TYPE.eActivityCalendar,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)

UIFullWelfareController:showWindowActivityCalendar(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eXBBag]={
id=JUMP_TYPE.eXBBag,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
if not xianbaoController:checkOpenXianBao()then
return false
end
UIFullGuBaoControl:showWindowXianBaoBag(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eXBTujian]={
id=JUMP_TYPE.eXBTujian,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
if not xianbaoController:checkOpenXianBao()then
return false
end
UIFullGuBaoControl:showWindowXianBaoTuJian(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eXBUpStar]={
id=JUMP_TYPE.eXBUpStar,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
if not xianbaoController:checkOpenXianBao()then
return false
end
UIFullGuBaoControl:showWindowXianBaoTuJian(args)
UIManager:showWindow("UIXianBaoUpStarWin",{xbid=args.xbid})
return true
end
}


uiwindow_id[JUMP_TYPE.eDuJieXianDan]={
id=JUMP_TYPE.eDuJieXianDan,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
if jctjDuJieXianDanModel:getLianZhiEndFlag()==1 then
UIManager.error("渡劫仙丹已炼制完成")
return false
end
return UIFullLianDanFangControl:showDuJieXianDan()
end
}
uiwindow_id[JUMP_TYPE.efeishengtai]={
id=JUMP_TYPE.efeishengtai,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
if not systemModel.isOpen(SYSTEM_DEFINE.eFeiShengTai)then
UIManager.info("九重天劫第二阶段开启后开启")
return false
end
FeiShengTaiModel:jumptoFST()
return true
end
}

uiwindow_id[JUMP_TYPE.eDuJieZhiBao]={
id=JUMP_TYPE.eDuJieZhiBao,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
if not systemModel.isOpen(SYSTEM_DEFINE.eDuJieZhiBao)then
local coldDay=DuJieZhiBaoController:getColdDay(SYSTEM_DEFINE.eDuJieZhiBao)
if coldDay>0 then
local _time=timeHelper.format_time_stamp8(coldDay)
local str=FMT.fmt("{0}后开启",_time)
UIManager.info(str)
else
UIManager.info("九重天劫第二阶段开启后开启")
end
return false
end
if args and args.buildid then
zongmenControl:jumpBuildingWin({type=args.buildid,isOpenRepairWin=true})
end
return true
end
}

uiwindow_id[JUMP_TYPE.eAirGameEnter]={
id=JUMP_TYPE.eAirGameEnter,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
if airController:api_Available()then
if not systemModel.isOpen(SYSTEM_DEFINE.eAirGame)then
return false
end
UIFullAirGameEnterController:showMainWindow({isNoShowCloud=true})
return true
end
return false
end
}

uiwindow_id[JUMP_TYPE.eTMJShare]={
id=JUMP_TYPE.eTMJShare,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local args={
actorId=playerModel:getActorID(),
}
UIManager:showWindow("UITianMoJieShareWin",args)
return false
end
}

uiwindow_id[JUMP_TYPE.eTMJJump]={
id=JUMP_TYPE.eTMJJump,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
if mainControl:isInScene(eSceneType.eZongmen)and zongmenModel:getMountainId()==mapIdType.zhufeng then
local ret=tianMoJieController:locateMinHPMonster(mapIdType.zhufeng)
if ret then
if fullScreenUI.isActiveFull()then
fullScreenUI.closeActiveUI(true,true)
end
end
return ret
else
return tianMoJieController:locateSelfMinHPMonsterAfterLoadMap()
end
end
}

uiwindow_id[JUMP_TYPE.eTMJMain]={
id=JUMP_TYPE.eTMJMain,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIFullTianMoJieControl:showMainWinByCloud()
return true
end
}

uiwindow_id[JUMP_TYPE.eWDCangQiong]={
id=JUMP_TYPE.eWDCangQiong,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
args=args or{}
if args.xiaozhushou then
local flag,cfglist=WDCQController:checkGuessState()
if flag then
args.showGuessWin=true
args.groupId=cfglist[1]
args.stageId=cfglist[2]
args.subGoupId=math.ceil(cfglist[3]/4)
args.idx=cfglist[4]
end
end
args.loading=true
UIFullWenDingCangQiongControl:showWin(args)

return false
end
}

uiwindow_id[JUMP_TYPE.eWenXinGuan]={
id=JUMP_TYPE.eWenXinGuan,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIFullWenXinGuanControl:showWenXinGuanEnterWin(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eWenXinGuan_Devli]={
id=JUMP_TYPE.eWenXinGuan_Devli,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIFullWenXinGuanDevilControl:showWenXinGuanDevilWin(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eWenXinGuan_Immortal]={
id=JUMP_TYPE.eWenXinGuan_Immortal,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIFullWenXinGuanImmortalControl:showWenXinGuanImmortalWin(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eWenXinGuan_Unknow]={
id=JUMP_TYPE.eWenXinGuan_Unknow,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIFullWenXinGuanUnknowControl:showWenXinGuanUnknowWin(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eWenXinGuan_Transfer]={
id=JUMP_TYPE.eWenXinGuan_Transfer,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIFullWenXinGuanTransferControl:showWenXinGuanTransferWin(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eWenXinGuan_Main]={
id=JUMP_TYPE.eWenXinGuan_Main,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIFullWenXinGuanMainControl:showWenXinGuanMainWin(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eXianJie_ResPoint_1]={
id=JUMP_TYPE.eXianJie_ResPoint_1,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local sceneidx=cfgHelper.get2(cfg_xianjiesceneconfig_get,args.mapid or 1,"mapIndex")
local rpData=xianjieModel:excuteResPointResourceHandle(xjResPointSourceType.ePlot,"findAData",sceneidx,args.cloudid,args.idx)
if rpData then
local pos=rpData:getWorldPos()
local callback=function()
local entity=xianjieController:getEntity(rpData.ent_key)
local boxParams=entity:handleBoxParams()
entity:onClick(boxParams)
end
xianjieController:lookAtPosition(pos,nil,0.2,args.autoclick and callback or nil,DG.Tweening.Ease.Linear)
return true
end
return false
end
}

uiwindow_id[JUMP_TYPE.eXianJie_ResPoint_2]={
id=JUMP_TYPE.eXianJie_ResPoint_2,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local sceneidx=cfgHelper.get2(cfg_xianjiesceneconfig_get,args.mapid or 1,"mapIndex")
local rpData=xianjieModel:excuteResPointResourceHandle(xjResPointSourceType.eTask,"findAData",sceneidx,args.taskid)
if rpData then
local pos=rpData:getWorldPos()
local callback=function()
local entity=xianjieController:getEntity(rpData.ent_key)
local boxParams=entity:handleBoxParams()
entity:onClick(boxParams)
end
xianjieController:lookAtPosition(pos,nil,0.2,args.autoclick and callback or nil,DG.Tweening.Ease.Linear)
return true
end
return false
end
}

uiwindow_id[JUMP_TYPE.eXianJieAttackerWin]={
id=JUMP_TYPE.eXianJieAttackerWin,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return UIManager:showWindow('UIXianJie_ZongMenAttackerWin',args)
end
}

uiwindow_id[JUMP_TYPE.eXianJie_ResPoint_3]={
id=JUMP_TYPE.eXianJie_ResPoint_3,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local sceneidx=cfgHelper.get2(cfg_xianjiesceneconfig_get,args.mapid or 1,"mapIndex")
local rpData=xianjieModel:excuteResPointResourceHandle(xjResPointSourceType.eExploration,"findAData",sceneidx)
if rpData then
local pos=rpData:getWorldPos()
local callback=function()
local entity=xianjieController:getEntity(rpData.ent_key)
local boxParams=entity:handleBoxParams()
entity:onClick(boxParams)
end
xianjieController:lookAtPosition(pos,nil,0.2,args.autoclick and callback or nil,DG.Tweening.Ease.Linear)
return true
end
return false
end
}

uiwindow_id[JUMP_TYPE.eXianJie_ResPoint_4]={
id=JUMP_TYPE.eXianJie_ResPoint_4,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local sceneidx=cfgHelper.get2(cfg_xianjiesceneconfig_get,args.mapid or 1,"mapIndex")
local rpData=xianjieModel:excuteResPointResourceHandle(xjResPointSourceType.eXianBangTask,"findAData",sceneidx,args.taskid)
if rpData then
local pos=rpData:getWorldPos()
local callback=function()
local entity=xianjieController:getEntity(rpData.ent_key)
local boxParams=entity:handleBoxParams()
entity:onClick(boxParams)
end
xianjieController:lookAtPosition(pos,nil,0.2,args.autoclick and callback or nil,DG.Tweening.Ease.Linear)
return true
else
if args.xtemp then
local func=function()
xianjieController:openWin('UIXianJieExplorationWin',{page=5})
end
xianjieController:jumpGrid(args.xtemp.sceneidx,args.xtemp.gridX,args.xtemp.gridZ,func,true)
return true
end
end
return false
end
}

uiwindow_id[JUMP_TYPE.eXianJie_ResPoint_5]={
id=JUMP_TYPE.eXianJie_ResPoint_5,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local sceneidx=cfgHelper.get2(cfg_xianjiesceneconfig_get,args.mapid or 1,"mapIndex")
local rpData=xianjieModel:excuteResPointResourceHandle(xjResPointSourceType.eQiYu,"findAData",sceneidx)
if rpData then
local pos=rpData:getWorldPos()
local callback=function()
local entity=xianjieController:getEntity(rpData.ent_key)
local boxParams=entity:handleBoxParams()
entity:onClick(boxParams)
end
xianjieController:lookAtPosition(pos,nil,0.2,args.autoclick and callback or nil,DG.Tweening.Ease.Linear)
return true
end
return false
end
}

uiwindow_id[JUMP_TYPE.etaskNpc]={
id=JUMP_TYPE.etaskNpc,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)

return xianjieModel:visitNPC(args.npcid,args.shownewbie)

end
}

uiwindow_id[JUMP_TYPE.eBehaviorJump]={
id=JUMP_TYPE.eBehaviorJump,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
if args.enterCallBack then
args.enterCallBack()
end

return true
end
}

uiwindow_id[JUMP_TYPE.eTianShuDaZhen]={
id=JUMP_TYPE.eTianShuDaZhen,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
return UIFullTianShuDaZhenControl:showMainWindow(args)
end
}

uiwindow_id[JUMP_TYPE.eChatWin]={
id=JUMP_TYPE.eChatWin,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return UIManager:showWindow('UIChatWin',args)
end
}

uiwindow_id[JUMP_TYPE.eXianJieCloudUnlockWin]={
id=JUMP_TYPE.eXianJieCloudUnlockWin,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
return UIFullCloudUnlockMapControl:showMainWindow()
end
}

uiwindow_id[JUMP_TYPE.eXianJieLeyLine]={
id=JUMP_TYPE.eXianJieLeyLine,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local data=xianjieModel:getLeyLineData()
if data then
local pos=data:getWorldPos()
local callback=function()
xianjieController:onClickLeyLine()
end
local _cb=args.autoclick and callback or nil
xianjieController:lookAtPosition(pos,nil,0.2,args.autoclick and callback or nil,DG.Tweening.Ease.Linear)
return true
end
return false
end
}

uiwindow_id[JUMP_TYPE.eXianJieSouXun1]={
id=JUMP_TYPE.eXianJieSouXun1,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIManager:showWindow('UIXianJieExplorationWin',{page=args.page,extra=args.extra})
return true
end
}

uiwindow_id[JUMP_TYPE.eXianJieSouXun2]={
id=JUMP_TYPE.eXianJieSouXun2,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIManager:showWindow('UIXianJieExplorationWin',{page=args.page,extra=args.extra})
return true
end
}

uiwindow_id[JUMP_TYPE.eChongJianXianYu]={
id=JUMP_TYPE.eChongJianXianYu,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
local season_id=0
local chapter_idx=args.chapter_idx
local funcIndex1=args.openRank and 2 or 1
return UIFullSeasonControl:openSeasonWindow(season_id,chapter_idx,funcIndex1)
end
}

uiwindow_id[JUMP_TYPE.eXianGongBaoKu]={
id=JUMP_TYPE.eXianGongBaoKu,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
xianjieModel:showForcewin(2)
UIFullXJForceControl:showWindow("UIXianGongBaoKuWin",{tab=args.tab,baoKuIdx=args.baoKuIdx})
return true
end,
}
uiwindow_id[JUMP_TYPE.eXianJieForce]={
id=JUMP_TYPE.eXianJieForce,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
xianjieModel:JumptoForce(args.id)

return true
end,
}


uiwindow_id[JUMP_TYPE.eXianJieBaoLei]={
id=JUMP_TYPE.eXianJieBaoLei,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eXianGongBangYu]={
id=JUMP_TYPE.eXianGongBangYu,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
xianjieModel:JumptoForce(2)
UIFullXJForceControl:showWindow("UIXianGongBangYuWin")
return true
end,
}

uiwindow_id[JUMP_TYPE.eXianJieZongMen]={
id=JUMP_TYPE.eXianJieZongMen,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
xianjieController:openZmInfoWin(true,playerModel:getActorID(),args.extra)
return true
end,
}

uiwindow_id[JUMP_TYPE.eXianGuan]={
id=JUMP_TYPE.eXianGuan,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIFullXJForceControl:showXianGongMainWindow()
UIFullXJForceControl:showWindow("UIXianGuanMainWin")
return true
end,
}

uiwindow_id[JUMP_TYPE.eXianJieClientBuild_arena]={
id=JUMP_TYPE.eXianJieClientBuild_arena,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local arenaId=args.arenaid or xjClientBuildType.flcbLeiTai1

local openWinFunc=function()
local arenaData=xianjieModel:getArenaDataByArenaId(arenaId)
if not arenaData then
return false
end
return xianjieController:openArenaInfoWin(arenaId)
end

local sceneidx
local gridX_c
local gridZ_c
local arenaData=xianjieModel:getArenaDataByArenaId(arenaId)
if not arenaData then

local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,arenaId)
if cfg then
local entityType=xjServerEnityType.eClientBuild
local typeCfg=cfgHelper.get1(cfg_fairylandentitytypeconfig_get,entityType)
local gridX,gridZ,gridWidth,gridHeight=xianjieModel:getClientPositionAndSize(cfg.x,cfg.y,typeCfg.size[1],typeCfg.size[2],cfg.size[1],cfg.size[2])
gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,gridWidth,gridHeight)
sceneidx=cfg.sceneidx
else
UIManager.error("找不到目标擂台")
return false
end
else
sceneidx=arenaData.sceneidx
gridX_c=arenaData.gridX_c
gridZ_c=arenaData.gridZ_c
end
xianjieController:jumpGrid(sceneidx,gridX_c,gridZ_c,openWinFunc,nil)
return true
end,
}


uiwindow_id['UIItemBuyGiftPackWin']={
id=JUMP_TYPE.eGiftPack,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
tipsManager.closeTips()
UIManager:showWindow('UIItemBuyGiftPackWin',args)
return false
end
}


uiwindow_id[JUMP_TYPE.eXianGuanWuXuan]={
id=JUMP_TYPE.eXianGuanWuXuan,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter)then
return false
end
if not xianguanModel:checkInitWuXuanData()then
return false
end
if not(xianguanModel:checkWuXuanActivityTime()or xianguanController:isInMatchStage_enter_WuXuan_BW())then
return false
end

UIFullXJForceControl:jumpJingXuanMainWindow(XianGuanCampaignType.eWuXuan)
return true
end
}

uiwindow_id[JUMP_TYPE.eXianGuanWenXuan]={
id=JUMP_TYPE.eXianGuanWenXuan,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
if not(xianguanModel:checkWenXuanActivityTime()or xianguanController:isInMatchStage_enter_WenXuan_BW())then
UIManager.info("活动未开启")
end
UIFullXJForceControl:jumpJingXuanMainWindow(XianGuanCampaignType.eWenXuan,args.jobId)
return true
end,
check=function(args)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter)then
UIManager.info("活动未开启")
return false
end
if not xianguanModel:checkInitWenXuanData()then
UIManager.info("活动未开启")
return false
end
return true
end
}

uiwindow_id[JUMP_TYPE.eXianJieJieYin_Support]={
id=JUMP_TYPE.eXianJieJieYin_Support,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
if not jiuchongtianjieGuideController:checkHasCanSupportActor()then
UIManager.info("无人申请援助")
return false
end

if jiuchongtianjieGuideController:checkShowSupportEnter()then
UIManager:showWindow("UIXianJieJieYin_SupportWin")
return true
end
return false
end
}

uiwindow_id[JUMP_TYPE.eXianGuanTeQuan_XZDS]={
id=JUMP_TYPE.eXianGuanTeQuan_XZDS,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIFullXJForceControl:jumpXGTQ_XZDS_Win(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eXianGuanTeQuan_ZYXS]={
id=JUMP_TYPE.eXianGuanTeQuan_ZYXS,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
local _fun=function()
UIManager:showWindow('UIXianJieExplorationWin',{page=1})
UIManager:invokeUIMethod('UIXianGongMainWin','onBtnClose')
UIManager:invokeUIMethod('UIXianGuanMainWin','onBackButton')

end

local check=false
local zmData=xianjieModel:getMyZongMenData()
if zmData~=nil and not zmData:checkInCurScene()then
check=true
end

if check then
UIManager:invokeUIMethod('UIXianJieExplorationWin',"onCloseBtn")
xianjieModel:jumpMyZongMen(_fun,false)
else
_fun()
end
return true
end
}

uiwindow_id[JUMP_TYPE.eXianGuanTeQuan_XYWJ]={
id=JUMP_TYPE.eXianGuanTeQuan_XYWJ,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIFullXJForceControl:jumpXGTQ_XYWJ_Win(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eXGTQ_Log_Fight_ScenePos]={
id=JUMP_TYPE.eXGTQ_Log_Fight_ScenePos,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
local jsonData
if args.logData then
jsonData=jsonHelper.decode(args.logData.params)
if jsonData==nil then return false end
local seceneIdx=jsonData[1]
local posX=jsonData[2]
local posZ=jsonData[3]

local callback=function()
UIManager:invokeUIMethod("UIXianGuanLogDetailWin","onCloseBtn")
if fullScreenUI.isActiveFull()then
UIFullXJForceControl:closeUI()
end
end
callback()

xianjieController:jumpGrid(seceneIdx,posX,posZ,nil,true)
end
return false
end
}


uiwindow_id[JUMP_TYPE.eXianGuanTeQuan_WSBX]={
id=JUMP_TYPE.eXianGuanTeQuan_WSBX,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
xianguanModel.ttmsjump()
return true
end
}

uiwindow_id[JUMP_TYPE.eXianGuanTeQuan_YJZZ]={
id=JUMP_TYPE.eXianGuanTeQuan_YJZZ,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
xianguanModel.ttms_yjzz_jump()
return false
end
}


uiwindow_id[JUMP_TYPE.elaoyu_moyu]={
id=JUMP_TYPE.elaoyu_moyu,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
if systemModel.isOpen(SYSTEM_DEFINE.eXianJieXianYu)then
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eLaoYu)
UIPrisonControl:showPrisonWindow({data=bdDatas[1],prisonLayer=2})
return true
else
UIManager.error('牢狱-魔狱系统未开启')
return false
end
end
}


uiwindow_id[JUMP_TYPE.eXianGuanTeQuan_YTYR]={
id=JUMP_TYPE.eXianGuanTeQuan_YTYR,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)


local cb=function()
UIManager.info("请神将选择要迁移的地点")
end

xianjieModel:jumpMyZongMen(cb)

return true
end
}

uiwindow_id[JUMP_TYPE.eXianGuanTeQuan_XSYW]={
id=JUMP_TYPE.eXianGuanTeQuan_XSYW,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIFullXJForceControl:jumpXGTQ_XSYW_Win(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eCangJingGeXinFa]={
id=JUMP_TYPE.eCangJingGeXinFa,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
local type=args and args.type or 1
local tabType=type==1 and FULL_TAB_TYPE.eCangJingGeXianShu or FULL_TAB_TYPE.eCangJingGeMoGong
UIFullCangJingGeXinFaControl:showXinFaWindow(tabType)
return true
end
}












































uiwindow_id[JUMP_TYPE.eXianGuanTeQuan_XGCFLOG]={
id=JUMP_TYPE.eXianGuanTeQuan_XGCFLOG,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
if args.baseData then
local xgid=args.baseData.xgid or nil
if xgid then
local xgtype=xianguanConfig.getJobConfig2(xgid,"type")
if xgtype==XIANGUAN_TYPE_ENUM.eFuLuXianShi then
local actorId
local datas=xianguanModel:getJobInfoByJobId(xgid)
if datas and datas.actorid then actorId=datas.actorid end

if actorId then
local zmData=xianjieModel:getZongMenData(actorId)
if zmData then
local gridX_c,gridZ_c=xianjieModel:getZongMenWorldGridCenterPos(zmData)
local cb=function()
UIManager:invokeUIMethod('UIChatWin','onCloseBtn')
UIManager:invokeUIMethod("UIXianGuanLogDetailWin","onCloseBtn")
if fullScreenUI.isActiveFull()then
UIFullXJForceControl:closeUI()
end
UIManager.info('跳转成功')
end

xianjieController:jumpGrid(zmData.sceneidx,gridX_c,gridZ_c,cb,true)
return true
end
end
end
end
end
return false
end
}

uiwindow_id[JUMP_TYPE.eXianYuanXunFang]=
{
id=JUMP_TYPE.eXianYuanXunFang,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)

if args then
local actid=args.actId
local subType=args.subType
local subid=args.subid
local sublist=args.sublist
local extraParams=args.extraParams
if actid~=nil then
if activitiesController:check_jump(actid,subType,subid)then
return activitiesController:jump(actid,subType,subid,extraParams)
end
elseif sublist~=nil then
local actid_,subType_,subid_=activitiesController:check_jump_list(sublist)
if actid_~=nil then
return activitiesController:jump(actid_,subType_,subid_,extraParams)
end
elseif subType~=nil then
if subid==nil then
local actid_,subType_,subid_=activitiesController:check_jump_subType(subType)
if actid_~=nil then
return activitiesController:jump(actid_,subType_,subid_,extraParams)
end
else
local actid_,subType_,subid_=activitiesController:check_jump_subType_subid(ubType,subid)
if actid_~=nil then
return activitiesController:jump(actid_,subType_,subid_,extraParams)
end
end
end
end
return xianyuanxunfangController:jumpWin2(args)
end
}

uiwindow_id[JUMP_TYPE.eTeQuanEditorUse]={
id=JUMP_TYPE.eTeQuanEditorUse,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local xgtype=args.xgtype
local tqid=args.tqid
local hasXG,xgid=xianguanController:checkSelfHasJobByType(xgtype)
if not hasXG then
local name=cfgHelper.get2(cfg_xianguanjobtypeconfig_get,xgtype,'name')
UIManager.error(FMT.fmt('祖师还不是{0}哦~',name))
return false
end
if not xianguanController:checkSelfHasTeQuanByType(tqid,xgtype)then
local name=cfgHelper.get2(cfg_xianguanprivilegeconfig_get,tqid,'name')
UIManager.error(FMT.fmt('祖师尚未拥有{0}特权哦~',name))
return false
end

local argstable={}
argstable.tqid=args.tqid
argstable.xgid=xgid
argstable.entityId=xianjieModel:getMyZongMenData():getID()
return UIFullTeQuanUseRangeEditorController:enterQuanXianEditor(argstable)
end
}

uiwindow_id[JUMP_TYPE.eXJTanChaPage]={
id=JUMP_TYPE.eXJTanChaPage,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local page=args.page
xianjieController:openWin('UIXianJieExplorationWin',{page=page})
return true
end,
check=function(args)
local page=args.page
local flag,tip=xianjieController:checkExplorationWinPageOpen(page)
if not flag and tip then
UIManager.info(tip)
end
return flag
end,
}

uiwindow_id[JUMP_TYPE.eShouHunDing]={
id=JUMP_TYPE.eShouHunDing,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
xianjieModel:JumptoForce(xianjieForceType.eJiuYuan,nil,nil,function()
UIFullXJForceControl:showWindow("UIShouHunDingWin")
end)

return true
end,
}

uiwindow_id[JUMP_TYPE.eXianJunYanZhen]={
id=JUMP_TYPE.eXianJunYanZhen,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local argstable={}
argstable.args=args
argstable.data={}
argstable.data.build_id=SLG_SYSTEM_TYPE.eXianYunGang
buildTiaoZhanControl:clickTiaoZhanBuild(argstable)
return true
end,
}

uiwindow_id[JUMP_TYPE.eMoJiang]={
id=JUMP_TYPE.eMoJiang,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
xianjieController:openMoJiangWin(args.seasonType,args.stageIndex,args.build_id)
return true
end,
}

uiwindow_id[JUMP_TYPE.eXianGongInfluenceNPC]={
id=JUMP_TYPE.eXianGongInfluenceNPC,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local npcId=args.id
local weakGuide=args.weakGuide
local faction=xjFactionNPCModel:findFactionByNpc(npcId)
xianjieModel:JumptoForce(faction,nil,nil,function()
local factionCfg=cfgHelper.get1(cfg_xianjieforceconfig_get,faction)
local args={
parentWin=UIFullXJForceControl,
select=faction,
clickNpc=table.findValue(factionCfg.npc_list,npcId),
weakGuide=weakGuide,
}
UIFullXJForceControl:showWindow("UIXianGongInfluenceMainWin",args)
end)
return true
end,
}

uiwindow_id[JUMP_TYPE.ePlayerChangeSex]={
id=JUMP_TYPE.ePlayerChangeSex,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIManager:showWindow('UIPlayerChangeSexWin')
return true
end,
}

uiwindow_id[JUMP_TYPE.eFindMoZong]={
id=JUMP_TYPE.eFindMoZong,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return xianjieModel:FindMoZong()
end,
}

uiwindow_id[JUMP_TYPE.eFindZhenYan]={
id=JUMP_TYPE.eFindZhenYan,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return xianjieModel:FindZhenYan()
end,
}

uiwindow_id[JUMP_TYPE.eMoJieGate]={
id=JUMP_TYPE.eMoJieGate,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local gateId=args and args.gateid
if not gateId then
local selfXyGateList=xianjieModel:getMoJieGateIdListWithSelfXianYu()
if selfXyGateList and next(selfXyGateList)then

gateId=selfXyGateList[1]
else
logErr("魔界关口跳转参数缺少关口id，无法跳转")
return false
end
end
return xianjieController:jumpMoJieGateByGateId(gateId,true)
end,
}

uiwindow_id[JUMP_TYPE.eMoJun]={
id=JUMP_TYPE.eMoJun,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return xianjieController:jumpMoJieMoJun()
end,
}

uiwindow_id[JUMP_TYPE.eXianGongInfluenceReputation]={
id=JUMP_TYPE.eXianGongInfluenceReputation,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local faction=args.id
local level=args.level or 1
xianjieModel:JumptoForce(faction,nil,nil,function()
local args={
parentWin=UIFullXJForceControl,
select=faction,
clickReputation=level,
}
UIFullXJForceControl:showWindow("UIXianGongInfluenceMainWin",args)
end)
return true
end,
}

uiwindow_id[JUMP_TYPE.eXuMiTa]=
{
id=JUMP_TYPE.eXuMiTa,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local bdDatas=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eShenShouTa)
if not bdDatas then
local name=cfgHelper.get2(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eShenShouTa,"name")
UIManager.error(string.format("%s未修复",name))
return false
end
args.jumpWin=true
UIFullWanLingTaControl:showMainWindow(args)
return true
end
}


uiwindow_id[JUMP_TYPE.eMJSouXunMonster]={
id=JUMP_TYPE.eMJSouXunMonster,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
xianjieController:jump_MjShouXun_hujian(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eMJSouXunShangGuMonster]={
id=JUMP_TYPE.eMJSouXunShangGuMonster,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
if args.itemid then
local sgitemId=xianjieController:get_MjJieDuanSan_ItemId()
if args.itemid~=sgitemId then
UIManager.error("当前赛季无法使用该道具")
return false
end
end

xianjieController:jump_MjShouXun_ShangGuMonster(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eMJShenYuanMiZang]={
id=JUMP_TYPE.eMJShenYuanMiZang,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
if args.itemid then
local isCostId=xianjieController:check_MjJieDuanSan_SYMZCostItemId(args.itemid)
if not isCostId then
UIManager.error("当前赛季无法使用该道具")
return false
end
end

xianjieController:jump_MjShenYuanMiZang(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eMJForeSkillUP]={
id=JUMP_TYPE.eMJForeSkillUP,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
xianjieController:jump_MjFore_SkillUP(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eMoJunYaoMo]={
id=JUMP_TYPE.eMoJunYaoMo,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
return xianjieController:jumpMoJieMoJunYaoMo()
end,
}

uiwindow_id[JUMP_TYPE.eWXBTBuy]=
{
id=JUMP_TYPE.eWXBTBuy,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)

local subType=SUB_ACTIVITY_TYPE.eWuXingBuTian
local actid_,subType_,subid_=activitiesController:check_jump_subType(subType)
if actid_~=nil then
bubbleShooterController:openBuyBallWinEx(actid_,subType,subid_)

UIManager:closeWindow('UICommonPageWin')
return true
else
local name=cfgHelper.get2(cfg_subactivitytypeconfig_get,subType,'name')
UIManager.error(FMT.fmt('{0}活动尚未开始',name))
end

return false
end
}

uiwindow_id[JUMP_TYPE.eMingYuanZhuSha]=
{
id=JUMP_TYPE.eMingYuanZhuSha,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local func=function()
myzsController:showFullWin()
loadingControl.closeCloud()
end
loadingControl.openCloud(func)
return true
end,
check=function(args)
return myzsModel:checkOpen()
end
}

uiwindow_id[JUMP_TYPE.eZhanMoLingBuy]={
id=JUMP_TYPE.eZhanMoLingBuy,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local config=cfgHelper.get1(cfg_limitedgiftconfig_get,args.libaoID)
if rechargeModel:checkXianGouLiBaoOpen(config.conditions)then
local rechargeid=config.rechargeid
local price=config.price
if not price and rechargeid then

local rechargeAmount=payControl:getRechargeAmount(rechargeid)
local twoTimeCostNum=rechargeAmount*2
local titemid,voucherCount=payControl.getVoucherId(twoTimeCostNum)
local buyFunc=function(count,isItem)
if isItem then
local pram=jsonHelper.encode({rechargeid})
bagProtocolControl.req_1_21(titemid,count*rechargeAmount,pram)
else
payControl.reqPay(rechargeid,count)
end
end
local buyFuncNoVoucher=function()
payControl.reqPayNoVoucher(rechargeid,1)
end
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(config.id)
if config.maxcount-buyNum>0 then
if config.maxcount-buyNum>1 and voucherCount>=twoTimeCostNum then
local rewards=rechargeModel:getXianGouLiBaoRewards(config.rewards)
local args={
rewards=rewards,
name=config.name,
price={titemid,rechargeAmount},
leftNum=buyNum,
maxcount=config.maxcount,
isCheckMaxSelectCount=true,
callback=function(num)
buyFunc(num,true)
end,
ReqPaycallback=buyFuncNoVoucher
}
UIManager:showWindow("UICommonBuyDialogWin",args)
else

UIManager:showWindow('UIXianGouBuyDialogWin',config)
end
else
UIManager.error('礼包已达购买上限')
end
end
else
UIManager.error('礼包未开放')
end
return true
end
}

uiwindow_id[JUMP_TYPE.eServerTransferShop]=
{
id=JUMP_TYPE.eServerTransferShop,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local open=ServerTransferController:checkServerTransferConditionOpen()and ServerTransferController:checkServerTransferTimeOpen()
if not open then
UIManager.error("跃迁商店尚未开放")
return false
end
args=args or{}
args.skipCloud=true
args.openShop=true
UIFullServerTransferControl:openServerTransferWindow(args)
return true
end
}

uiwindow_id[JUMP_TYPE.eMoJieBenYuanZhenJi]={
id=JUMP_TYPE.eMoJieBenYuanZhenJi,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local build_id=args and args.build_id
if not build_id then
build_id=xjClientBuildType.flcbZhenJi1
end
return xianjieController:jumpMoJieBenYuanZhenJiByBuildId(build_id,true)
end,
}

uiwindow_id[JUMP_TYPE.eMoJieWuXingZhenJi]={
id=JUMP_TYPE.eMoJieWuXingZhenJi,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
local list=xianjieController:getEntitysByEntityType(XJ_ENTITY_TYPE.ePuTongZhenJi)
if not next(list)then
UIManager.error("未发现五行阵基")
return false
end

return xianjieController:openPuTongZhenJiInfoWin(list[1].infoguid)
end,
}


uiwindow_id[JUMP_TYPE.eYunZhouZhenTu]={
id=JUMP_TYPE.eYunZhouZhenTu,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=true,
bag_tips_callback=function(args)
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eXianYunGang)
if bdData then
UIFullXianYunGangControl:showMainWindow(bdData)
YunZhouZhenTuController:OpenYunZhouZhenTuMainWin(true)
end
return false
end,
}


uiwindow_id[JUMP_TYPE.eLingShouListSelect]={
id=JUMP_TYPE.eLingShouListSelect,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
return UIFullDiscipleSelectControl:showLingShouSelectWindow(args)
end
}


uiwindow_id[JUMP_TYPE.eLingShouMain]={
id=JUMP_TYPE.eLingShouMain,
jumpWinType=JUMP_WINDOW_TYPE.eFullScreen,
addMain=false,
bag_tips_callback=function(args)
local lsData=nil
if args.fightIndex~=nil then
lsData=lingshouModel:getLingShouByFightIndex(args.fightIndex)
end

if lsData then
return UIFullCommonControl:jumpLingShouMain(lsData.guid,args.tabType,nil,args.subArgs)
end

if args.lsGuid then
return UIFullCommonControl:jumpLingShouMain(args.lsGuid,args.tabType,nil,args.subArgs)
end

return false
end
}


uiwindow_id[JUMP_TYPE.eZMWorldMap]={
id=JUMP_TYPE.eZMWorldMap,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
UIManager:showWindow("UIWorldMapWinEx",{showInfo=true,enter=function(index)
if not mainControl:isWaitSceneChange()then
worldController:enterWorld(index)
end
UIManager:closeWindow("UIWorldMapWinEx")
end})
return true
end
}









uiwindow_id['worldtourtips_jump']={
id=JUMP_TYPE.eWorldExplore,
jumpWinType=JUMP_WINDOW_TYPE.eBaseFullScreen,
addMain=true,
bag_tips_callback=function(args)
if worldModel.world and not worldBlockModel:isWorldAllOpen(worldModel.world)then
UIManager:invokeUIMethod("UIWorldFunctionButtonWin","onButtonExperience")
return true
end
return false
end
}











uiwindow_id_tips_callbacks={}
for k,v in pairs(uiwindow_id)do





uiwindow_id_tips_callbacks[v.id]=v
end
