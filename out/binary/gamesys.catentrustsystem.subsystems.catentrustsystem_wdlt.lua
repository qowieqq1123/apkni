
local catEntrustSystem_WDLT=catEntrustSystemBase.new({sysType=Entrust_Type.WDLT})

function catEntrustSystem_WDLT.getIcon(data)
return'icon_zawubu_3',globalABLookup.zawubuicons
end

function catEntrustSystem_WDLT.getExInfoIcon(data)

end

function catEntrustSystem_WDLT.getName(data)
return'文斗擂台'
end

function catEntrustSystem_WDLT.getRewardInfo(val,data)
return FMT.fmt("奖励+{0}%",val)
end

function catEntrustSystem_WDLT.checkShowWtCondition(data)
return false
end

function catEntrustSystem_WDLT.getWtConditionInfo(data)
end

function catEntrustSystem_WDLT.getDoingWtInfo()
return"前往打擂中"
end

function catEntrustSystem_WDLT.checkShowSlider(data)
return false
end

function catEntrustSystem_WDLT.getInitSliderData()
end

function catEntrustSystem_WDLT.restockWtArgs(wtdata,args)
end

function catEntrustSystem_WDLT.getToServerArgs(exclusiveData)
return{0,0}
end

function catEntrustSystem_WDLT.getDoingPlayTxt(wtSlotData)
return'猫猫正在文斗擂台与墨客斗诗'
end

function catEntrustSystem_WDLT.checkWtCondition(wtSlotData)

if not limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eWenDouLeiTai)then
catEntrustModel:resetAllWtSlotDataByEntrustType(Entrust_Type.WDLT)
return false,Cat_Entrust_Condition_Error_Type.limitActivityFinish,"文斗擂台活动已结束"
end

return true
end

function catEntrustSystem_WDLT.finishCallBack(wtSlotData)

end

function catEntrustSystem_WDLT.doProgressNext(wtSlotData)
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

function catEntrustSystem_WDLT.getSelectDesc(cnt)
return FMT.fmt("斗擂次数：{0}",cnt)
end

function catEntrustSystem_WDLT.checkLocalizeOriginalData(exclusiveData)
local zmswWtList=catEntrustModel:getZMAffairListData()
for index,wtData in ipairs(zmswWtList)do
if wtData.type==Entrust_Type.WDLT then
if(not wtData.isLock)then
return true
end
end
end
return false
end

function catEntrustSystem_WDLT.checkPrepareNoOpenPass(wtSlotData)

local noPass=true

if catEntrustConfig.checkCatEntrustTypeOpen(Entrust_Type.WDLT)then
if limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eWenDouLeiTai)then
local data=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eWenDouLeiTai)
local unitList=poetryArenaModel:getUnitDataList()
if data~=nil and#unitList>0 then
noPass=false
end
end
end

return noPass
end