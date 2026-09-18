





catEntrustSystemBase={}
function catEntrustSystemBase.new(class)
local _clone={}
if class then
for i,v in pairs(class)do
_clone[i]=v
end
_clone._base=class

end
if class.sysType==nil then
logErr('没有传入类型 ')
end
local clone_mt={}
clone_mt.__index=catEntrustSystemBase
setmetatable(_clone,clone_mt)
catEntrustConfig.bindSubClass(_clone)
return _clone
end

function catEntrustSystemBase.getIcon(data)
end

function catEntrustSystemBase.getExInfoIcon(data)
end

function catEntrustSystemBase.getName(data)
end

function catEntrustSystemBase.getRewardInfo(val,data)
end

function catEntrustSystemBase.checkShowWtCondition(data)
end

function catEntrustSystemBase.getWtConditionInfo(data)
end

function catEntrustSystemBase.getDoingWtInfo()
end

function catEntrustSystemBase.checkShowSlider(data)
end

function catEntrustSystemBase.getInitSliderData()
end

function catEntrustSystemBase.restockWtArgs(wtdata,args)
end

function catEntrustSystemBase.getToServerArgs(exclusiveData)
end

function catEntrustSystemBase.getDoingPlayTxt(wtSlotData)
end

function catEntrustSystemBase.checkWtCondition(wtSlotData)
end

function catEntrustSystemBase.finishCallBack(wtSlotData)

end

function catEntrustSystemBase.doProgressNext(wtSlotData)
end

function catEntrustSystemBase.getSelectDesc(cnt)
end

function catEntrustSystemBase.checkLocalizeOriginalData(exclusiveData)
end

function catEntrustSystemBase.transEntrustTypeServer(wtSlotData)
end

function catEntrustSystemBase.checkPrepareNoOpenPass(wtSlotData)
end

function catEntrustSystemBase.checkPrepareNoCountPass(wtSlotData)
end

function catEntrustSystemBase.getCatEntrustRewardUpRate(wtSlotData,guid)
local catData=wanBaoXunBaoDuiModel:getCatData(guid)
if catData then
local wtType=wtSlotData.data.entrustType
local ex_reward_config=cfgHelper.get2(cfg_catentrusttypeconfig_get,wtType,'ex_reward_config')
local attrid=ex_reward_config[1]
local val=catData.propList[attrid]
if val>=ex_reward_config[2]then
local eVal=val-ex_reward_config[2]
local addVal=Mathf.Floor(eVal/ex_reward_config[4])*ex_reward_config[5]

local endAddVal=addVal+ex_reward_config[3]
endAddVal=Mathf.Min(endAddVal,ex_reward_config[6])

endAddVal=Mathf.Floor(endAddVal*10)/10

return endAddVal
end
end
return 0
end

function catEntrustSystemBase.getEntrustCost(wtSlotData)

end

function catEntrustSystemBase.checkSelectWtIsCanNext(wtSlotData)
return false
end

function catEntrustSystemBase.checkShowGoUnlockNextDialouge(wtSlotData,callback)
if callback then
callback()
end
end

function catEntrustSystemBase.checkComfireWt(wtSlotData)
return true
end

function catEntrustSystemBase.getProbenum(data)
return-1
end