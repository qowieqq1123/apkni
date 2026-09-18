






local catEntrustSystem_ZMTY=catEntrustSystemBase.new({sysType=Entrust_Type.ZMTY})

function catEntrustSystem_ZMTY.getIcon(data)
return'icon_zawubu_9',globalABLookup.zawubuicons
end

function catEntrustSystem_ZMTY.getExInfoIcon(data)

end

function catEntrustSystem_ZMTY.getName(data)
return'宗门拓印'
end

function catEntrustSystem_ZMTY.getRewardInfo(val,data)
return FMT.fmt("拓印心得奖励+{0}",val)
end

function catEntrustSystem_ZMTY.checkShowWtCondition(data)
return data.exclusiveData.systemZmId~=nil
end

function catEntrustSystem_ZMTY.getWtConditionInfo(data)
if data.systemZmId then
local sdata=systemZongMenModel:getInfoData(data.systemZmId)
local zmCfg=cfgHelper.get1(cfg_syssectconfig_get,sdata.id)
local cost=zmCfg.tayin[1]
local costItemId=cost[1][1]
local singleVal=cost[1][2]

local hasVal=itemsModel.getCount(costItemId)
local totalNeedVal=singleVal*data.count
local enoughState=catEntrustModel:checkCatEntrustCostEnough(costItemId)
local valInfo=enoughState and hasVal or toColorString(FONT_COLOR.eRedColor,hasVal)
local info=FMT.fmt("{0}/{1}",valInfo,totalNeedVal)
return info,costItemId
end
end

function catEntrustSystem_ZMTY.getDoingWtInfo()
return"偷学功法中"
end

function catEntrustSystem_ZMTY.checkShowSlider(data)
return data.exclusiveData.systemZmId~=nil
end

function catEntrustSystem_ZMTY.getInitSliderData(wtSlotData)
local num=catEntrustModel:getCoordinateResidueCount(Entrust_Type.ZMTY,wtSlotData.id)
local maxNum=num
return{min=1,max=maxNum}
end

function catEntrustSystem_ZMTY.restockWtArgs(wtdata,args)
local systemZmId=args.param_1
local count=args.param_2

local exclusiveData=wtdata.data.exclusiveData

exclusiveData.systemZmId=systemZmId
exclusiveData.count=count
end

function catEntrustSystem_ZMTY.getToServerArgs(exclusiveData)
return{exclusiveData.systemZmId,exclusiveData.count}
end

function catEntrustSystem_ZMTY.getDoingPlayTxt(wtSlotData)
local exclusiveData=wtSlotData.data.exclusiveData
local name=systemZongMenModel:getInfoDataName(exclusiveData.systemZmId)
return FMT.fmt("猫猫正在{0}偷学功法",name)
end

function catEntrustSystem_ZMTY.checkWtCondition(wtSlotData)
local exclusiveData=wtSlotData.data.exclusiveData

if not exclusiveData.systemZmId then
return false,Cat_Entrust_Condition_Error_Type.noSelectZM
end

local sdata=systemZongMenModel:getInfoData(exclusiveData.systemZmId)
local zmCfg=cfgHelper.get1(cfg_syssectconfig_get,sdata.id)
local cost=zmCfg.tayin[1]
local costItemId=cost[1][1]
local singleVal=cost[1][2]

local hasVal=itemsModel.getCount(costItemId)
local totalNeedVal=singleVal*exclusiveData.count
local state=catEntrustModel:checkCatEntrustCostEnough(costItemId)
return state,Cat_Entrust_Condition_Error_Type.itemLess,{itemid=costItemId}
end

function catEntrustSystem_ZMTY.finishCallBack(wtSlotData)
local count=wtSlotData.data.exclusiveData.count
local num=systemZongMenModel:getGlobalNum(systemZongMenFuncType.eTaYin)
systemZongMenModel:setGlobalNum(systemZongMenFuncType.eTaYin,num+count)
notifySystem:postNotify(notifyConfig.onSystemZMFunctionNumChange,systemZongMenFuncType.eTaYin)
end

function catEntrustSystem_ZMTY.doProgressNext(wtSlotData)
if wtSlotData.data.exclusiveData.systemZmId==nil then
local tempWt=catEntrustModel:getTempWt()
catEntrustController.showSelectWin(
'选择宗门',
'UICatEntrustSelectSystemZMWin',
{wtSlotId=wtSlotData.id,tempWt=tempWt},
false)
return false
elseif wtSlotData.data.dispatchCatGuid==0 then
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

function catEntrustSystem_ZMTY.getSelectDesc(cnt,wtSlotData)
local sysZmId=wtSlotData.data.exclusiveData.systemZmId
local data=systemZongMenModel:getInfoData(sysZmId)
local name=systemZongMenModel:getNameStr(data.id,data.nameIdx)
return FMT.fmt("宗门：{0}",name)
end

function catEntrustSystem_ZMTY.checkLocalizeOriginalData(exclusiveData)
if exclusiveData.systemZmId==nil then return false end

local zmInfoData=systemZongMenModel:getInfoData(exclusiveData.systemZmId)
if zmInfoData==nil then return false end

if zmInfoData.flag==systemZongMenFightFlagType.eExpel then return false end

local zmswWtList=catEntrustModel:getZMAffairListData()
for index,wtData in ipairs(zmswWtList)do
if wtData.type==Entrust_Type.ZMTY then
if(not wtData.isLock)then
return true
end
end
end

return false
end

function catEntrustSystem_ZMTY.checkPrepareNoOpenPass(wtSlotData)
local noPass=true

if catEntrustConfig.checkCatEntrustTypeOpen(Entrust_Type.ZMTY)then
if systemModel.isOpen(SYSTEM_DEFINE.eSystemZongMenTaYin)then
local maxNum=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"tayin","day_num")
local usedNum=systemZongMenModel:getGlobalNum(systemZongMenFuncType.eTaYin)
if maxNum>usedNum then
noPass=false
end
end
end

return noPass
end

function catEntrustSystem_ZMTY.checkPrepareNoCountPass(wtSlotData)

local entrustType=wtSlotData.data.entrustType
local totalCount=catEntrustModel:getCatEntrustTypePreateToalSelectCount(entrustType)

local maxNum=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"tayin","day_num")
local usedNum=systemZongMenModel:getGlobalNum(systemZongMenFuncType.eTaYin)

local residueNum=maxNum-totalCount-usedNum
if residueNum<0 then

catEntrustModel:resetAllWtSlotDataByEntrustType(entrustType)
end

end

function catEntrustSystem_ZMTY.getEntrustCost(wtSlotData)
local exclusiveData=wtSlotData.data.exclusiveData

if next(exclusiveData)and exclusiveData.systemZmId~=nil then
local data=systemZongMenModel:getInfoData(exclusiveData.systemZmId)
local zmCfg=cfgHelper.get1(cfg_syssectconfig_get,data.id)
local cost=zmCfg.tayin[1]
local costItemId=cost[1][1]
local singleVal=cost[1][2]

local totalNeedVal=singleVal*exclusiveData.count

return{{costItemId,totalNeedVal}}
end
end