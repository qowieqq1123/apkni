






local catEntrustSystem_LSMJ=catEntrustSystemBase.new({sysType=Entrust_Type.LSMJ})

function catEntrustSystem_LSMJ.getIcon(data)
return cfgHelper.get3(cfg_secretsceneziyuanfubenconfig_get,data.tagId,data.curId,'image')
end

function catEntrustSystem_LSMJ.getExInfoIcon(data)
local config=cfgHelper.get2(cfg_secretsceneziyuanfubenconfig_get,data.tagId,data.curId)
return FMT.fmt("icon_dsjmijingtp_{0}",config.mjShowType),"ui/windows/mystery/sharedtextures/mysterylistsprite.ab"
end

function catEntrustSystem_LSMJ.getName(data)
local config=cfgHelper.get2(cfg_secretsceneziyuanfubenconfig_get,data.tagId,data.curId)
local curLayer=data.diff
return FMT.fmt("{0}阶{1}",curLayer,config.name)
end

function catEntrustSystem_LSMJ.getProbenum(data)
local probeNum=mysteryZiYuanFuBenModel:getprobeNum(data.tagId)
local probeNumtext=FMT.fmt("（还可以探索{0}次）",probeNum)
if probeNum==0 then
probeNumtext="（已无探索次数）"
end
return probeNum,probeNumtext
end


function catEntrustSystem_LSMJ.getRewardInfo(val,data)
return FMT.fmt("宝箱+{0}",val)
end

function catEntrustSystem_LSMJ.checkShowWtCondition(data)
return false
end

function catEntrustSystem_LSMJ.getWtConditionInfo(data)
local fbConfig=cfgHelper.get(cfg_secretscenefubenconfig_get,data.mjid)

local cost=fbConfig.useResEnter
cost=type(cost[1])=="number"and cost or cost[1]
if not cost or next(cost)==nil then
return
end
local costItemId=cost[1]
local singleVal=cost[2]
local hasVal=itemsModel.getCount(costItemId)
local totalNeedVal=singleVal*data.count
local enoughState=catEntrustModel:checkCatEntrustCostEnough(costItemId)
local valInfo=enoughState and hasVal or toColorString(FONT_COLOR.eRedColor,hasVal)
local info=FMT.fmt("{0}/{1}",valInfo,totalNeedVal)
return info,costItemId
end

function catEntrustSystem_LSMJ.getDoingWtInfo()
return"秘境探索中"
end

function catEntrustSystem_LSMJ.checkShowSlider(data)
return true
end

function catEntrustSystem_LSMJ.getInitSliderData(wtInfo)
local cfg=cfgHelper.get2(cfg_catentrusttypeconfig_get,Entrust_Type.ZMMJ)
local data=wtInfo.data.exclusiveData
local fbConfig=cfgHelper.get(cfg_secretscenefubenconfig_get,data.mjid)









local probeNum=mysteryZiYuanFuBenModel:getprobeNum(data.tagId)




return{min=1,max=probeNum}
end

function catEntrustSystem_LSMJ.restockWtArgs(wtdata,args)
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

function catEntrustSystem_LSMJ.getToServerArgs(exclusiveData)
return{exclusiveData.mjid,exclusiveData.count}
end

function catEntrustSystem_LSMJ.getDoingPlayTxt(wtSlotData)
local exclusiveData=wtSlotData.data.exclusiveData
local fbConfig=cfgHelper.get(cfg_secretscenefubenconfig_get,exclusiveData.mjid)
local typeName=mysteryZiYuanFuBenModel:getMjShowTypeStr(fbConfig.mjShowType)
return FMT.fmt("猫猫正在{0}秘境抓捕{1}",fbConfig.name,typeName)
end

function catEntrustSystem_LSMJ.checkWtCondition(wtSlotData)

local exclusiveData=wtSlotData.data.exclusiveData
local count=exclusiveData.count
local mjid=exclusiveData.mjid
local fbConfig=cfgHelper.get(cfg_secretscenefubenconfig_get,mjid)

local cost=fbConfig.useResEnter
cost=type(cost[1])=="number"and cost or cost[1]
if not cost or next(cost)==nil then
return true
end
local costItemId=cost[1]
local singleVal=cost[2]

local hasItemCount=itemsModel.getCount(costItemId)
local needTotalCount=singleVal*count
local state=catEntrustModel:checkCatEntrustCostEnough(costItemId)
return state,Cat_Entrust_Condition_Error_Type.itemLess,{itemid=costItemId}

end

function catEntrustSystem_LSMJ.finishCallBack(wtSlotData)

end

function catEntrustSystem_LSMJ.doProgressNext(wtSlotData)
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

function catEntrustSystem_LSMJ.getSelectDesc(cnt,wtInfo)
local data=wtInfo.data.exclusiveData
local probeNum=mysteryZiYuanFuBenModel:getprobeNum(data.tagId)
if probeNum~=-1 then
return FMT.fmt("剩余可探索次数：{0}",probeNum)
end
return FMT.fmt("探索次数：{0}",cnt)
end

function catEntrustSystem_LSMJ.checkLocalizeOriginalData(exclusiveData)
local mjWtList=catEntrustModel:getResourceMiJingData()
for index,wtData in ipairs(mjWtList)do
if wtData.data.mjid==exclusiveData.mjid and(not wtData.isLock)then
return true
end
end
return false
end

function catEntrustSystem_LSMJ.transEntrustTypeServer(wtSlotData)
local data=wtSlotData.data.exclusiveData
local config=cfgHelper.get2(cfg_secretsceneziyuanfubenconfig_get,data.tagId,data.curId)

if config.mjShowType==5 then
return Entrust_Type.EZMJ
end
end

function catEntrustSystem_LSMJ.checkPrepareNoOpenPass(wtSlotData)
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

function catEntrustSystem_LSMJ.getEntrustCost(wtSlotData)
local exclusiveData=wtSlotData.data.exclusiveData

if next(exclusiveData)then
local fbConfig=cfgHelper.get(cfg_secretscenefubenconfig_get,exclusiveData.mjid)
local cost=fbConfig.useResEnter
cost=type(cost[1])=="number"and cost or cost[1]
if not cost or next(cost)==nil then
return
end
local costItemId=cost[1]
local singleVal=cost[2]
local totalNeedVal=singleVal*exclusiveData.count

return{{costItemId,totalNeedVal}}
end
end

function catEntrustSystem_LSMJ.checkSelectWtIsCanNext(wtSlotData)
return wtSlotData.canMaxDiff>wtSlotData.diff
end

function catEntrustSystem_LSMJ.checkShowGoUnlockNextDialouge(wtSlotData,callback)

local content="{0}秘境解锁了新的阶数，完成挑战后将可以委托更高阶数的{0}秘境，是否前往挑战？"
local config=cfgHelper.get2(cfg_secretsceneziyuanfubenconfig_get,wtSlotData.tagId,wtSlotData.curId)
local cname=toColorString(FONT_COLOR.eOrangeColor,catEntrustConfig.getMJTypeName(config.mjShowType))
if config.mjShowType==9 then
cname=toColorString(FONT_COLOR.eOrangeColor,catEntrustConfig.getMJTypeName(7))
end
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

function catEntrustSystem_LSMJ.checkComfireWt(wtSlotData)
if bagControl.checkShowFullEquipBagTips("无法继续探索")then
return false
end
return true
end
