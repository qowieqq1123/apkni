




Cat_Entrust_State_Type={
Lock=0,
Stand=1,
Prepare=2,
Doing=3,
Finish=4,
End=5,
}

Cat_Entrust_Condition_Error_Type={
catTiliLess=1,
itemLess=2,
noDispatchCat=3,
noSelectWtType=4,
noSelectZM=5,
catTiliMaxLess=6,
yyhyCountLess=7,
limitActivityFinish=8,
}

catEntrustConfig={}

local defaultEntrustSlotItemName='CatEntrustItem'

Cat_Entrust_Unlock_Type={
YearCard=1,
Money=2,
}

Entrust_Type={
ZMMJ=1,
YYHY=2,
WDLT=3,
ZMTY=4,
EZMJ=5,
SGXD=6,
LSMJ=7,
}

catEntrustConfig.sortStateList={
[Cat_Entrust_State_Type.Prepare]=9,
[Cat_Entrust_State_Type.Stand]=6,
[Cat_Entrust_State_Type.Doing]=10,
[Cat_Entrust_State_Type.Finish]=2,
[Cat_Entrust_State_Type.End]=1,
[Cat_Entrust_State_Type.Lock]=5,
}

local transServerEntrustList={
[Entrust_Type.EZMJ]=Entrust_Type.ZMMJ,
}

local CatEntrustLimitActivityList={
LIMIT_ACT_TYPE.eYiYuHuiYou,
LIMIT_ACT_TYPE.eWenDouLeiTai,
}

local Entrust_Type_Func={}

local Entrust_Type_Open_CheckFuncType={
eZongMenLevel=1,
eZheXianLing=2,
eServerDay=3,
}

local Entrust_Type_Open_CheckFuncs={
[Entrust_Type_Open_CheckFuncType.eZongMenLevel]=function(condition)
local needLevel=condition[2]
local curLevel=zongmenModel:getLevel()
local state=curLevel>=needLevel
return state
end,
[Entrust_Type_Open_CheckFuncType.eZheXianLing]=function(condition)
local fit=true
local w_str=nil
local book_id=condition[2]
local index=condition[3]
if index and index>0 then
local chapterid=zheXianLingConfig.getChapterId(book_id,index)
fit=zheXianLingModel:isRewardChapter(chapterid)
else
fit=zheXianLingModel:isRewardBook(book_id)
end
if not fit then
local bookStr=mathHelper.numberToChinese(book_id)
if index and index>0 then
local chapterStr=mathHelper.numberToChinese(index)
w_str=FMT.fmt('完成谪仙令{0}卷{1}章',bookStr,chapterStr)
else
w_str=FMT.fmt('完成谪仙令{0}卷',bookStr)
end
end
return fit,w_str
end,
[Entrust_Type_Open_CheckFuncType.eServerDay]=function(condition)
local needServerDay=condition[2]
local curServerDay=timeHelper.getServerOpenDay()
return curServerDay>=needServerDay
end,
}



function catEntrustConfig.bindSubClass(funcObj)
Entrust_Type_Func[funcObj.sysType]=funcObj
end

function catEntrustConfig.getBaseInfo(name)
return cfgHelper.get2(cfg_catentrustbaseconfig_get,1,name)
end

function catEntrustConfig.getTotalSlotLen()
local pos_num=catEntrustConfig.getBaseInfo('pos_num')
local ex_pos_config=catEntrustConfig.getBaseInfo('ex_pos_config')
return pos_num+#ex_pos_config
end

function catEntrustConfig.getUnlockEntrustSlotTip(unlockCost)
local type=unlockCost[1]

if type==Cat_Entrust_Unlock_Type.YearCard then
if rechargeModel:checkIsHasMonthCardCanRenewal()then
return'荣誉执事\n特权已过期','前往激活'
end
return'荣誉执事\n特权解锁','前往激活'
else
local itemId=unlockCost[2]
local needNum=unlockCost[3]
local hasNum=itemsModel.getCount(itemId)


local iconname=iconHelper.getIconName(itemId)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,30)
local numStrInfo=hasNum>=needNum and needNum or toColorString(FONT_COLOR.eRedColor,needNum)
local btnStr=FMT.fmt('{0} {1}解锁',iconStr,numStrInfo)
local itemName=itemsConfig.getItemName(itemId)
local lockStr=FMT.fmt("{0}解锁",itemName)
return lockStr,btnStr
end
end

function catEntrustConfig.getEntrustFuncObj(entrustType)
return Entrust_Type_Func[entrustType]
end

function catEntrustConfig.transServerEntrustType(wtSlotData)
local type=wtSlotData.data.entrustType
local transType=transServerEntrustList[type]
if transType~=nil then
wtSlotData.data.entrustType=transType
end
end


function catEntrustConfig.toUnlockWtSlot(wtSlotData)
local cost=wtSlotData.unlockCost
local type=cost[1]

if type==Cat_Entrust_Unlock_Type.YearCard then
jumpManager:jump({id=JUMP_TYPE.eReCharge,args={tabType=FULL_TAB_TYPE.eMonthInvestor}})
elseif type==Cat_Entrust_Unlock_Type.Money then
local moneyType=cost[2]
local needNum=cost[3]
local cb=function()
catEntrustController:reqUnlockSlot(wtSlotData.id)
end

moneySystem:useMoney(moneyType,needNum,cb,WARNING_TYPE.eWarning)
end
end

function catEntrustConfig.doNextProgress(wtSlotData)
local type=wtSlotData.data.entrustType
local funcs=Entrust_Type_Func[type]
if funcs.doProgressNext(wtSlotData)then
catEntrustModel:tempFillToWt()

UIManager:invokeUIMethod("UICatEntrustWin",'refreshAll')
end
end


function catEntrustConfig.checkCatEntrustTypeOpen(entrustType)
local openArgs=cfgHelper.get2(cfg_catentrusttypeconfig_get,entrustType,'open_args')
local state=true
if openArgs then
for index,condition in ipairs(openArgs)do
local type=condition[1]
local checkFunc=Entrust_Type_Open_CheckFuncs[type]
if checkFunc then
state=checkFunc(condition)
if not state then
break
end
else
logErr(FMT.fmt("cat entrust lose type :: {0} ,check func",type))
end
end
end
return state
end

function catEntrustConfig.checkLisenerLimitAct(limieActType)
return table.findValue(CatEntrustLimitActivityList,limieActType)
end


function catEntrustConfig.getWeakAndHourInfoToLeftTime(leftTime)
local serverTime=timeHelper.getServerLongTime()
local toTime=serverTime+leftTime
local toWeekIdx=timeHelper.getWeakDateEx2(toTime)
local toWeekIdxName=timeHelper.format_week_chinese(toWeekIdx)

local toDayLeftTime=timeHelper.getServerTodayLeft()
local toNextLeftTime=leftTime<=toDayLeftTime and leftTime or((leftTime-toDayLeftTime)%86400)
local showTime=toNextLeftTime%86400
local leftTimeName=timeHelper.format_time_stamp3(showTime)

if timeHelper.isTodayStamp(toTime)then
return FMT.fmt("{0}后开启",leftTimeName)
else
return FMT.fmt("{0}{1}开启",toWeekIdxName,leftTimeName)
end
end


local mjTypeNameList={"灵石","灵矿","灵木","灵草","装备","古宝","灵兽"}
function catEntrustConfig.getMJTypeName(mjShowType)
return mjTypeNameList[mjShowType]
end



local entrustSlotDataTemplate={
id=0,
isUnlock=false,

state=Cat_Entrust_State_Type.Lock,

stamp=0,

data={

entrustType=0,

dispatchCatGuid=0,

exclusiveData={},

dispatchCount=0,

rewardUpRate=0,
},
unlockCost={},
sortWight=0,
prefabName=defaultEntrustSlotItemName,
}

function catEntrustConfig.getEmptyEntrustSlotData()
local o=table.deepCopy(entrustSlotDataTemplate)
return o
end