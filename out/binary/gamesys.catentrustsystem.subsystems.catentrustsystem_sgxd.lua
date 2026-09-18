






local catEntrustSystem_SGXD=catEntrustSystemBase.new({sysType=Entrust_Type.SGXD})

function catEntrustSystem_SGXD.getIcon(data)
local fbData=data.fbData
return fbData.icon
end

function catEntrustSystem_SGXD.getExInfoIcon(data)
local fbData=data.fbData
end

function catEntrustSystem_SGXD.getName(data)
return'上古险地'
end

function catEntrustSystem_SGXD.getRewardInfo(val,data)
local fbData=data.fbData
end

function catEntrustSystem_SGXD.doProgressNext(wtSlotData)
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


function catEntrustSystem_SGXD.getInitSliderData(wtInfo)
local data=wtInfo.data
local fbData=data.exclusiveData.fbData
local fbid=fbData.id
local cfg_fb=cfg_secretscenefubenconfig_get(fbid)

if cfg_fb then
local cost=cfg_fb.useResEnter
if cost then
cost=type(cost[1])=="number"and cost or cost[1]
end
if cost then
local have=itemsModel.getCount(cost[1])
local oneneed=mathHelper.formatNumber(cost[2])
local havenum=mathHelper.formatNumber(have)
local num=math.floor(havenum/oneneed)
return{min=1,max=1}
end
end
return{min=0,max=0}
end

function catEntrustSystem_SGXD.checkShowSlider(data)
return true
end

function catEntrustSystem_SGXD.checkShowWtCondition(data)
return true
end

function catEntrustSystem_SGXD.getWtConditionInfo(data)
local fbData=data.fbData
local fbid=fbData.id
local cfg_fb=cfg_secretscenefubenconfig_get(fbid)

if cfg_fb then
local cost=cfg_fb.useResEnter
if cost then
cost=type(cost[1])=="number"and cost or cost[1]
end
if cost then
local have=itemsModel.getCount(cost[1])
local oneneed=mathHelper.formatNumber(cost[2])
local havenum=mathHelper.formatNumber(have)
local enoughState=catEntrustModel:checkCatEntrustCostEnough(cost[1])
local valInfo=enoughState and havenum or toColorString(FONT_COLOR.eRedColor,havenum)
local info=FMT.fmt("{0}/{1}",valInfo,oneneed)
return info,cost[1]
end
end

end

function catEntrustSystem_SGXD.getSelectDesc(cnt)
return FMT.fmt("探索次数：{0}",cnt)
end

function catEntrustSystem_SGXD.getDoingWtInfo()
return"秘境探索中"
end

function catEntrustSystem_SGXD.checkWtCondition(wtSlotData)

local exclusiveData=wtSlotData.data.exclusiveData
local count=exclusiveData.count
local fbData=exclusiveData.fbData
local mjid=fbData.id
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

function catEntrustSystem_SGXD.getEntrustCost(wtSlotData)
local exclusiveData=wtSlotData.data.exclusiveData

if next(exclusiveData)then
local fbData=exclusiveData.fbData
local mjid=fbData.id
local fbConfig=cfgHelper.get(cfg_secretscenefubenconfig_get,mjid)
local cost=fbConfig.useResEnter
cost=type(cost[1])=="number"and cost or cost[1]
local costItemId=cost[1]
local singleVal=cost[2]
local totalNeedVal=singleVal*exclusiveData.count

return{{costItemId,totalNeedVal}}
end
end

function catEntrustSystem_SGXD.getToServerArgs(exclusiveData)
local fbData=exclusiveData.fbData
local mjid=fbData.id
return{mjid,1}
end

function catEntrustSystem_SGXD.getRewardInfo(val,data)
return FMT.fmt("宝箱+{0}",val)
end

function catEntrustSystem_SGXD.getDoingPlayTxt(wtSlotData)
local exclusiveData=wtSlotData.data.exclusiveData
local fbData=exclusiveData.fbData
local mjid=fbData.id
local fbConfig=cfgHelper.get(cfg_secretscenefubenconfig_get,mjid)
return FMT.fmt("猫猫正在{0}秘境探索",fbConfig.name)
end

function catEntrustSystem_SGXD.checkLocalizeOriginalData(exclusiveData)
local mjWtList=catEntrustModel:getResourceMiJingData()
local fbData=exclusiveData.fbData
local mjid=fbData.id
for index,wtData in ipairs(mjWtList)do

if wtData.data.mjid==mjid and(not wtData.isLock)then
return true
end
end
return false
end

function catEntrustSystem_SGXD.restockWtArgs(wtdata,args)
local mjid=args.param_1
local count=args.param_2

local fbConfig=cfgHelper.get(cfg_secretscenefubenconfig_get,mjid)


local exclusiveData=wtdata.data.exclusiveData

exclusiveData.count=count
exclusiveData.fbData={id=mjid,icon=fbConfig.image,name=fbConfig.name}




end

function catEntrustSystem_SGXD.checkComfireWt(wtSlotData)
if bagControl.checkShowFullEquipBagTips("无法继续探索")then
return false
end
return true
end