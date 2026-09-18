






local catEntrustSystem_ZMMJ=catEntrustSystemBase.new({sysType=Entrust_Type.ZMMJ})

function catEntrustSystem_ZMMJ.getIcon(data)
return cfgHelper.get3(cfg_secretsceneziyuanfubenconfig_get,data.tagId,data.curId,'image')
end

function catEntrustSystem_ZMMJ.getExInfoIcon(data)
local config=cfgHelper.get2(cfg_secretsceneziyuanfubenconfig_get,data.tagId,data.curId)
return FMT.fmt("icon_dsjmijingtp_{0}",config.mjShowType),"ui/windows/mystery/sharedtextures/mysterylistsprite.ab"
end

function catEntrustSystem_ZMMJ.getName(data)
local config=cfgHelper.get2(cfg_secretsceneziyuanfubenconfig_get,data.tagId,data.curId)
local curLayer=data.diff
return FMT.fmt("{0}阶{1}",curLayer,config.name)
end

function catEntrustSystem_ZMMJ.getRewardInfo(val,data)
local exclusiveData=data.exclusiveData
local config=cfgHelper.get2(cfg_secretsceneziyuanfubenconfig_get,exclusiveData.tagId,exclusiveData.curId)
local typeName=mysteryZiYuanFuBenModel:getMjShowTypeStr(config.mjShowType)
return FMT.fmt("{0}+{1}%",typeName,val)
end

function catEntrustSystem_ZMMJ.checkShowWtCondition(data)
return true
end

function catEntrustSystem_ZMMJ.getWtConditionInfo(data)
local fbConfig=cfgHelper.get(cfg_secretscenefubenconfig_get,data.mjid)
local cost=fbConfig.useResEnter
cost=type(cost[1])=="number"and cost or cost[1]
local costItemId=cost[1]
local singleVal=cost[2]
local hasVal=itemsModel.getCount(costItemId)
local totalNeedVal=singleVal*data.count
local enoughState=catEntrustModel:checkCatEntrustCostEnough(costItemId)
local valInfo=enoughState and hasVal or toColorString(FONT_COLOR.eRedColor,hasVal)
local info=FMT.fmt("{0}/{1}",valInfo,totalNeedVal)
return info,costItemId
end

function catEntrustSystem_ZMMJ.getDoingWtInfo()
return"秘境探索中"
end

function catEntrustSystem_ZMMJ.checkShowSlider(data)
return true
end

function catEntrustSystem_ZMMJ.getInitSliderData(wtInfo)
local cfg=cfgHelper.get2(cfg_catentrusttypeconfig_get,Entrust_Type.ZMMJ)
local data=wtInfo.data.exclusiveData
local fbConfig=cfgHelper.get(cfg_secretscenefubenconfig_get,data.mjid)
local cost=fbConfig.useResEnter
cost=type(cost[1])=="number"and cost or cost[1]
local costItemId=cost[1]
local singleVal=cost[2]
local hasVal=itemsModel.getCount(costItemId)
hasVal=Mathf.Max(hasVal,1)
local canNum=Mathf.Floor(hasVal/singleVal)
local max=Mathf.Min(cfg.count_max,canNum)

return{min=1,max=max}
end

function catEntrustSystem_ZMMJ.restockWtArgs(wtdata,args)
local mjid=args.param_1
local count=args.param_2

local infoData=mysteryZiYuanFuBenModel:getZiYuanGroupByFbid(mjid)

local exclusiveData=wtdata.data.exclusiveData

exclusiveData.count=count
exclusiveData.mjid=mjid
exclusiveData.tagId=infoData[1]
exclusiveData.curId=infoData[2]
exclusiveData.diff=infoData[3]
exclusiveData.isCanMultiple=true
end

function catEntrustSystem_ZMMJ.getToServerArgs(exclusiveData)
return{exclusiveData.mjid,exclusiveData.count}
end

function catEntrustSystem_ZMMJ.getDoingPlayTxt(wtSlotData)
local exclusiveData=wtSlotData.data.exclusiveData
local fbConfig=cfgHelper.get(cfg_secretscenefubenconfig_get,exclusiveData.mjid)
local typeName=mysteryZiYuanFuBenModel:getMjShowTypeStr(fbConfig.mjShowType)
return FMT.fmt("猫猫正在{0}秘境采集{1}",fbConfig.name,typeName)
end

function catEntrustSystem_ZMMJ.checkWtCondition(wtSlotData)

local exclusiveData=wtSlotData.data.exclusiveData
local count=exclusiveData.count
local mjid=exclusiveData.mjid
local fbConfig=cfgHelper.get(cfg_secretscenefubenconfig_get,mjid)

local cost=fbConfig.useResEnter
cost=type(cost[1])=="number"and cost or cost[1]
local costItemId=cost[1]
local singleVal=cost[2]

local hasItemCount=itemsModel.getCount(costItemId)
local needTotalCount=singleVal*count
local state=catEntrustModel:checkCatEntrustCostEnough(costItemId)
return state,Cat_Entrust_Condition_Error_Type.itemLess,{itemid=costItemId}
end

function catEntrustSystem_ZMMJ.finishCallBack(wtSlotData)

end

function catEntrustSystem_ZMMJ.doProgressNext(wtSlotData)
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

function catEntrustSystem_ZMMJ.getSelectDesc(cnt)
return FMT.fmt("探索次数：{0}",cnt)
end

function catEntrustSystem_ZMMJ.checkLocalizeOriginalData(exclusiveData)
local mjWtList=catEntrustModel:getResourceMiJingData()
for index,wtData in ipairs(mjWtList)do
if wtData.data.mjid==exclusiveData.mjid and(not wtData.isLock)then
return true
end
end
return false
end

function catEntrustSystem_ZMMJ.transEntrustTypeServer(wtSlotData)
local data=wtSlotData.data.exclusiveData
local config=cfgHelper.get2(cfg_secretsceneziyuanfubenconfig_get,data.tagId,data.curId)

if config.mjShowType==5 then
return Entrust_Type.EZMJ
end
end

function catEntrustSystem_ZMMJ.checkPrepareNoOpenPass(wtSlotData)
local noPass=true

if catEntrustConfig.checkCatEntrustTypeOpen(Entrust_Type.ZMMJ)then
local exclusiveData=wtSlotData.data.exclusiveData
local data=mysteryZiYuanFuBenModel:getZiYuanGroupByFbid(exclusiveData.mjid)
if data~=nil then
noPass=false
end
end
return noPass
end

function catEntrustSystem_ZMMJ.getEntrustCost(wtSlotData)
local exclusiveData=wtSlotData.data.exclusiveData

if next(exclusiveData)then
local fbConfig=cfgHelper.get(cfg_secretscenefubenconfig_get,exclusiveData.mjid)
local cost=fbConfig.useResEnter
cost=type(cost[1])=="number"and cost or cost[1]
local costItemId=cost[1]
local singleVal=cost[2]
local totalNeedVal=singleVal*exclusiveData.count

return{{costItemId,totalNeedVal}}
end
end

function catEntrustSystem_ZMMJ.checkSelectWtIsCanNext(wtSlotData)
return wtSlotData.canMaxDiff>wtSlotData.diff
end

function catEntrustSystem_ZMMJ.checkShowGoUnlockNextDialouge(wtSlotData,callback)

local content="{0}秘境解锁了新的阶数，完成挑战后将可以委托更高阶数的{0}秘境，是否前往挑战？"
local config=cfgHelper.get2(cfg_secretsceneziyuanfubenconfig_get,wtSlotData.tagId,wtSlotData.curId)
local cname=toColorString(FONT_COLOR.eOrangeColor,catEntrustConfig.getMJTypeName(config.mjShowType))
content=FMT.fmt(content,cname)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='继续委托',
allowclickBG='false',
okcallback=function()
mysteryZiYuanFuBenController:jumpToMysteryNoDialouge(wtSlotData.tagId)
end,
cancelcallback=function()
if callback then callback()end
end,
showclosebtn=true,
}
local dialog=UIDialogManager.newDialog(showdata)
dialog:show()
end
