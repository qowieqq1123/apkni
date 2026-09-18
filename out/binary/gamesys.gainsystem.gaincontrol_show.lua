local _checkType=
{
ePushGift_v2=1,
eLimitGiftHasBuyCnt=2,
eOpenServerDay=3,
eLimitItemNum=4,
eZongMenLevel=5,
eSystemOpen=6,
eMainTaskType=7,
eMonthCardActive=8,
eActivityActive=9,
eSelectLiBao=10,
ePushGift_v1=11,
ePushGift_v3=12,
}


local _checkfunc=
{
[_checkType.ePushGift_v1]=function(args)
for i,v in ipairs(args or{})do
if pushGiftModel:getDoingData(v)~=nil then
return true
end
end
return false
end,
[_checkType.ePushGift_v2]=function(args)
for i,v in ipairs(args or{})do
if pushGiftTwoModel:getDoingData(v)~=nil then
return true
end
end
return false
end,
[_checkType.ePushGift_v3]=function(args)
for i,v in ipairs(args or{})do
if pushGiftThreeModel:getDoingData(v)~=nil then
return true
end
end
return false
end,
[_checkType.eLimitGiftHasBuyCnt]=function(args)
local giftid=args[1]
local cfg=cfg_limitedgiftconfig_get(giftid)
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(giftid)
local maxcount=cfg.maxcount
local left=maxcount-buyNum
return left>0
end,
[_checkType.eOpenServerDay]=function(args)
local min=args[1]
local max=args[2]
local openDay=timeHelper.getServerOpenDay()
if max then return openDay>=min and openDay<=max end
return openDay>=min
end,
[_checkType.eLimitItemNum]=function(args)
local itemlist=args[1]or{}
local limitnum=args[2]or 0
local haveItem=0
for k,v in ipairs(itemlist)do
local num=0
if moneyConfig.isMoney(v)then
num=moneyModel.getMoney(v)
else
num=bagControl.invokeFuncByItemId(v,'getItemCountByItemID',v)or 0
end
haveItem=haveItem+num
end
return haveItem<=limitnum
end,
[_checkType.eZongMenLevel]=function(args)
local targetLevel_min=args[1]
local targetLevel_max=args[2]
local zmLevel=zongmenModel:getLevel()
if targetLevel_max then
return zmLevel>=targetLevel_min and zmLevel<=targetLevel_max
else
return zmLevel>=targetLevel_min
end
end,
[_checkType.eSystemOpen]=function(args)
local systemId=args[1]
return systemModel.isOpen(systemId)
end,
[_checkType.eMainTaskType]=function(args)
local taskTypeList=args[1]or{}
local isIgnore=args[2]and args[2]==1 or false
local nowMainTaskData=taskModel:getTaskByLine(taskModel.lineMain)
local nowMainTaskType
if nowMainTaskData~=nil then
local taskCfg=nowMainTaskData.cfg
nowMainTaskType=taskCfg.tasktype
end
if nowMainTaskType then

for i,taskType in ipairs(taskTypeList)do
if nowMainTaskType==taskType then

return not isIgnore
end
end
end

return isIgnore
end,
[_checkType.eMonthCardActive]=function(args)
local checkMonthCardIdList=args[1]or{}
local isIgnore=args[2]and args[2]==1 or false
for i,cardId in ipairs(checkMonthCardIdList)do
if rechargeModel:checkCardActive(cardId)then
return not isIgnore
end
end
return isIgnore
end,
[_checkType.eActivityActive]=function(args)
local actId=args.actId
local subActType=args.subActType
local subActId=args.subActId
local subActList=args.sublist
if subActType and subActId then
local actList=activitiesModel:getActSubList_subType_subid_doing(subActType,subActId)
if actList and next(actList)then
if actId then
for _,subInfo in ipairs(actList)do
if subInfo.act_id==actId then
return true
end
end
else
return true
end
end
return false
elseif subActType then
local actList=activitiesModel:getActSubList_subType_open_doing(subActType)
if actList and next(actList)then
return true
else
return false
end
elseif actId then
local sublist=activitiesModel:getActSubList_open_doing(actId)
if sublist and next(sublist)then
return true
end
elseif subActList then
local checkActList_lookup={}
for _,v in ipairs(subActList)do
local sub_act_type=v[1]
local sub_act_id=v[2]
if not checkActList_lookup[sub_act_type]then
checkActList_lookup[sub_act_type]={}
end
checkActList_lookup[sub_act_type][sub_act_id]=true
end

for sub_act_type,v in pairs(checkActList_lookup)do
local actList=activitiesModel:getActSubList_subType_open_doing(sub_act_type)
if actList and next(actList)then
for _,subActInfo in ipairs(actList)do
if v[subActInfo.sub_act_id]then
return true
end
end
end
end

end

return false
end,
[_checkType.eSelectLiBao]=function(args)
for i,itemId in ipairs(args)do
if rechargeModel:checkSelectLiBaoHasItemId(itemId)then
return true
end
end
return false
end,
}

function gainControl.canShow(cfg)

if verifyManager:isHideBusinessActivity()then
if cfg.buy then
return false
end
end


if cfg.hidePf then
local isHideByPf=pfwindowsModel:getVersionAndPfCfg(cfg.hidePf)or false
if isHideByPf then
return false
end
end

local show=cfg.show
if show==nil then return true end
for i,v in ipairs(show)do
local checkType=v[1]
local checkArgs=v[2]
local func=_checkfunc[checkType]
if func then
if not func(checkArgs)then return false end
else
loggerUtil.logErrFMT('获取途径尚未支持检测显示类型：{0}',checkType)
end
end
return true
end


function gainControl.hasAnyShowById(itemid)
local config=itemsConfig.getConfig(itemid)
local produce=config.produce
return gainControl.hasAnyShow(produce)
end

function gainControl.hasAnyShow(produce)
if produce==nil then return false end
for i,v in ipairs(produce)do
if gainControl.canShow(v)then
return true
end
end
return false
end