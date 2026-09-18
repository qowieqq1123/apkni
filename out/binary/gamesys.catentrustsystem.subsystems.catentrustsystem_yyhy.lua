





local catEntrustSystem_YYHY=catEntrustSystemBase.new({sysType=Entrust_Type.YYHY})


function catEntrustSystem_YYHY.getIcon(data)
return 760011
end

function catEntrustSystem_YYHY.getExInfoIcon(data)
local cfg=cfgHelper.get1(cfg_yiyuhuiyounpcconfig_get,data.npcid)
local mode=cfg.nanduImg
local iconName=FMT.fmt('image_yiyuhuiyound_{0}',mode)
return iconName,'ui/windows/yiyuhuiyou/yyhyimage_atlas_pak.ab'
end

function catEntrustSystem_YYHY.getName(data)
local cfg=cfgHelper.get1(cfg_yiyuhuiyounpcconfig_get,data.npcid)
return cfg.name
end

function catEntrustSystem_YYHY.getRewardInfo(val,data)
return FMT.fmt("获胜鱼币+{0}%",val)
end

function catEntrustSystem_YYHY.checkShowWtCondition(data)
return false
end

function catEntrustSystem_YYHY.getWtConditionInfo(data)
end

function catEntrustSystem_YYHY.getDoingWtInfo()
return"前往钓鱼中"
end

function catEntrustSystem_YYHY.checkShowSlider(data)
return YiYuHuiYouModel:getTiaoZhanResidueCount()>0
end

function catEntrustSystem_YYHY.getInitSliderData(wtSlotData)
local num=catEntrustModel:getCoordinateResidueCount(Entrust_Type.YYHY,wtSlotData.id)
local maxNum=num
return{min=1,max=maxNum}
end

function catEntrustSystem_YYHY.restockWtArgs(wtdata,args)
local npcid=args.param_1
local count=args.param_2

local exclusiveData=wtdata.data.exclusiveData

exclusiveData.npcid=npcid
exclusiveData.count=count
end

function catEntrustSystem_YYHY.getToServerArgs(exclusiveData)
return{exclusiveData.npcid,exclusiveData.count}
end

function catEntrustSystem_YYHY.getDoingPlayTxt(wtSlotData)
local exclusiveData=wtSlotData.data.exclusiveData
local cfg=cfgHelper.get1(cfg_yiyuhuiyounpcconfig_get,exclusiveData.npcid)
return FMT.fmt("猫猫正在{0}渔场钓鱼",cfg.name)
end

function catEntrustSystem_YYHY.checkWtCondition(wtSlotData)

if not limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eYiYuHuiYou)then
catEntrustModel:resetAllWtSlotDataByEntrustType(Entrust_Type.YYHY)
return false,Cat_Entrust_Condition_Error_Type.limitActivityFinish,"以渔会友活动已结束"
end

local cnt=wtSlotData.data.exclusiveData.count
local battlenum=YiYuHuiYouModel:getEnter_cnt()
local tiaozhanmax=cfg_yiyuhuiyoubaseconfig_get(1).enter_cnt
local buy_enter_cost=cfg_yiyuhuiyoubaseconfig_get(1).buy_enter_cnt
local buy_enter_cnt=#buy_enter_cost
local battlenum_ed=YiYuHuiYouModel:getBuy_enter_cnt()

local totalNum=tiaozhanmax+buy_enter_cnt
local residuceTotalNum=totalNum-battlenum
local canNum=tiaozhanmax+battlenum_ed-battlenum

if residuceTotalNum<=0 then
return false
end

if canNum>=cnt then
return true
else

local cfg=cfg_yiyuhuiyoubaseconfig_get(1).buy_enter_cnt
local tz_buynum=YiYuHuiYouModel:getBuy_enter_cnt()or 0
local tz_peizi_num=#cfg
if(tz_peizi_num-tz_buynum)>0 then
local cost=cfg[tz_buynum+1]
local max=tz_peizi_num
local haveCnt=tz_buynum
local getCostNum=function(num)
local costItemNum=0
for i=1,num do
local costIndex=haveCnt+i
costIndex=costIndex>#cfg and#cfg or costIndex
local n=cfg[costIndex][2]
costItemNum=costItemNum+n
end
return costItemNum
end
local refresh=function(num)
local itemNum=getCostNum(num)
local have=itemsModel.getCount(cost[1])
local colorStr=have>=itemNum and"549327FF"or"FF0000FF"
local iconStr=iconHelper.getIconName(cost[1])
local costStr=FMT.fmt("quad-icon={2}-quad<color=#{0}>{1}</color>",colorStr,itemNum,iconStr)
local contentStr=FMT.fmt('是否花费{0}购买挑战次数',costStr)
return contentStr
end
local show_data={
type='UIDialougeNewBuyCount',
title='提示',
refreshcallback=refresh,
max=max-haveCnt,
tips=FMT.fmt("<color=#CA631D>（今日剩余次数：{0}）</color>",max-haveCnt),
oktext='购买',
canceltext='取消',
tipsPos=Vector2.New(152,-7),
okcallback=function(num)
local itemNum=getCostNum(num)
local func=function()
YiYuHuiYouController.send_248_52(num)
end
moneySystem:useMoney(cost[1],itemNum,func,WARNING_TYPE.eWarning)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
UIManager.error("今日购买次数已耗尽")
end
return false,Cat_Entrust_Condition_Error_Type.yyhyCountLess
end

return true
end

function catEntrustSystem_YYHY.finishCallBack(wtSlotData)

end

function catEntrustSystem_YYHY.doProgressNext(wtSlotData)
if wtSlotData.data.dispatchCatGuid==0 then
local tempWt=catEntrustModel:getTempWt()
catEntrustController.showSelectWin(
'选择猫猫',
'UICatEntrustSelectCatWin',
{wtSlotId=wtSlotData.id,tempWt=tempWt},
false)
return false
end
return true
end

function catEntrustSystem_YYHY.getSelectDesc(cnt)
return FMT.fmt("钓鱼次数：{0}",cnt)
end

function catEntrustSystem_YYHY.checkLocalizeOriginalData(exclusiveData)
local yyhyWtList=catEntrustModel:getYYHYListData()
for index,wtData in ipairs(yyhyWtList)do

if not wtData.isLock then
exclusiveData.npcid=wtData.data.npcid
return true
end
end
return false
end

function catEntrustSystem_YYHY.checkPrepareNoOpenPass(wtSlotData)
local noPass=true

if catEntrustConfig.checkCatEntrustTypeOpen(Entrust_Type.YYHY)then
if limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eYiYuHuiYou)then
local exclusiveData=wtSlotData.data.exclusiveData
local guid=int64.new(exclusiveData.guid)
local npcData=YiYuHuiYouModel:getNPCIdlistbyGuid(guid)

if npcData then
local isOpen=worldBlockModel:checkBlockState(npcData.world,npcData.block,eWorldBlockState.OPEN)
if isOpen then
noPass=false
end
end
end
end
return noPass
end

function catEntrustSystem_YYHY.checkPrepareNoCountPass(wtSlotData)
local entrustType=wtSlotData.data.entrustType
local totalCount=catEntrustModel:getCatEntrustTypePreateToalSelectCount(entrustType)
local residuceCount=YiYuHuiYouModel:getTiaoZhanResidueCount()

if totalCount>residuceCount then

catEntrustModel:resetAllWtSlotDataByEntrustType(entrustType)
end
end
