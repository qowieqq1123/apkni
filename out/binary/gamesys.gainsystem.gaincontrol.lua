gainControl=gameState.addListener({})

local _errType=
{
eSystem=1,
eLevel=2,
eDailyTask=3,
eXianGouLiBao=4,
eSchool=5,
eFair=6,
eWorldTour=7,
eMystery=8,
eMysteryList=9,
eCatShop=10,
eCustom=11,
}

local _unlockCheckfunc=
{

[JUMP_TYPE.eDailyTask]=function(v)
local findType=3
if v.jump and v.jump.args then
findType=v.jump.args.findType or 3
end

local isGotTaskReward=true
if findType==1 or findType==3 then


local taskList=taskModel:getSortDailyTaskData()
for k,task in ipairs(taskList)do
if task then

local isGot=taskModel:checkDailyTaskIsGotById(task)
if not isGot then

local config=task.cfg
local rewards=taskModel:GetDayTaskReward(config.id)
local rw=nil
local zmlv=zongmenModel:getLevel()
for i,v in ipairs(rewards)do
if zmlv>=v[1]and zmlv<=v[2]then
rw=v[3]
break
end
end
if rw==nil then
rw=rewards[#rewards][3]
end
local isBreak=false

for i=1,#rw do
if v.goodId and rw[i][1]==v.goodId then
isGotTaskReward=false
isBreak=true
break
end
end

if isBreak then
break
end
end
end
end
end

if findType==2 or findType==3 then

local isGotFinalTargetReward=taskModel:checkDailyTaskTargetisGot()
if not isGotFinalTargetReward then
local rewardIdx=taskModel:getDailyTaskTargetRewardIdx()
local targetReward=taskModel:GetDayTaskTargetReward(rewardIdx)

for i=1,#targetReward do
local reward=targetReward[i]
if v.goodId and reward[1]==v.goodId then
isGotTaskReward=false
end
end
end
end


if isGotTaskReward then
local errStr
if findType==1 or findType==3 then
errStr="您已完成所有相关日常任务"
elseif findType==2 then
errStr="您已经领取了每日目标奖励"
end

return false,{_errType.eDailyTask,errStr}
end
end,

[JUMP_TYPE.eReCharge]=function(v)
local isLibaoSellOut=true
local allLibaoList={}
if v.jump.args and v.jump.args.tabType then
if v.jump.args.tabType==FULL_TAB_TYPE.eReChargeLiBao then

table.insert(allLibaoList,rechargeModel:getSortXianGouLiBaoList(shopLibaoType.eDay))
elseif v.jump.args.tabType==FULL_TAB_TYPE.eReChargeWeekLiBao then

table.insert(allLibaoList,rechargeModel:getSortXianGouLiBaoList(shopLibaoType.eWeek))
end
else

table.insert(allLibaoList,rechargeModel:getSortXianGouLiBaoList(shopLibaoType.eDay))
table.insert(allLibaoList,rechargeModel:getSortXianGouLiBaoList(shopLibaoType.eWeek))
end
local checkLibaoIdList=v.jump.args and v.jump.args.libaoId
local checkLibaoIdList_lookup={}
if checkLibaoIdList then
for _,libaoId in ipairs(checkLibaoIdList)do
checkLibaoIdList_lookup[libaoId]=true
end
else

return true
end

if next(allLibaoList)then
for k,v in ipairs(allLibaoList)do
local libaoList=v
for i=1,#libaoList do
local libaoCfg=libaoList[i]
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(libaoCfg.id)
local isSellOut=buyNum>=libaoCfg.maxcount
if not isSellOut then
if checkLibaoIdList_lookup[libaoCfg.id]then
isLibaoSellOut=false
break
end
















end
end
end

if isLibaoSellOut then
if v.jump.args and v.jump.args.tabType then
if v.jump.args.tabType==FULL_TAB_TYPE.eReChargeLiBao then

return false,{_errType.eXianGouLiBao,"本日限购次数已用完"}

elseif v.jump.args.tabType==FULL_TAB_TYPE.eReChargeWeekLiBao then

return false,{_errType.eXianGouLiBao,"本周限购次数已用完"}
end
else

return false,{_errType.eXianGouLiBao,"对应礼包已售罄"}
end

end
end
end,

[JUMP_TYPE.eSchoolMain]=function(v)


if not zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eXueShiShuYuan)then
return
end
local remain=UISchoolModel:get_study_remainNum()
if remain<=0 then
return false,{_errType.eSchool}
end
end,

[JUMP_TYPE.eFairShop]=function(v)
local hasCount=false
if fairModel:has_free_flush_count()then

hasCount=true
elseif fairModel:has_Ad_flush_count()then

hasCount=true
else

local count=fairModel:enough_pay_flush_count()
local limitCount=fairModel.get_booth_pay_flush_times_limit()
if count<limitCount then
hasCount=true
end
end

if not hasCount then
return false,{_errType.eFair}
end
end,

[JUMP_TYPE.eMysteryEnter]=function(v)
if v.jump and v.jump.args then
local mysteryArgs=v.jump.args
local fbId=mysteryArgs.fbId
if fbId then
local posData=MysteryModel:get_mysteryFB_unit(fbId)
if not posData then
return false,{_errType.eMystery}
end
end
end
end,

[JUMP_TYPE.eMysteryList]=function(v)
local mysteryType=nil
if v.jump and v.jump.args then
mysteryType=v.jump.args.mjType
end


local mysteryList=MysteryModel:get_mysteryFB_list_data()
if next(mysteryList)then
if mysteryType then
local hasSameTypeMystery=false
for k,mystery in pairs(mysteryList)do
local mjId=mystery.id
local mjCfg=cfgHelper.get(cfg_secretscenefubenconfig_get,mjId)
if type(mysteryType)=="table"then
local isBreak=false
for i=1,#mysteryType do
if mjCfg.mjType==mysteryType[i]then
hasSameTypeMystery=true
isBreak=true
break
end
end

if isBreak then
break
end
else
if mjCfg.mjType==mysteryType then
hasSameTypeMystery=true
break
end
end
end

if not hasSameTypeMystery then
return false,{_errType.eMysteryList,'当前大世界中没有此类型的秘境'}
end
end
else
return false,{_errType.eMysteryList,'当前大世界中没有秘境'}
end
end,

[JUMP_TYPE.eCatShop]=function(v)
local state=UICatShopControl:getCatShopState()
if state~=2 then
return false,{_errType.eCatShop,state==1 and'猫货郎还未到来'or'猫货郎已离开，请明天再试'}
end
end,
[JUMP_TYPE.eFuLuMix]=function(v)
if not systemModel.isOpen(SYSTEM_DEFINE.eFuLuHuiZhi)then
return false,{_errType.eSystem,SYSTEM_DEFINE.eFuLuHuiZhi}
end
end,
[JUMP_TYPE.eMingYuanZhuSha]=function(v)
if not myzsModel:checkOpen()then
return false,{_errType.eCustom,'未开启'}
end
end
}

local _getSubActInfo=function(sublist)
local sub_actInfo
for i,v in ipairs(sublist)do
local subType=v[1]
local subid=v[2]
local sub_actList=activitiesModel:getActSubList_subType_subid_doing(subType,subid)
if#sub_actList>0 then
for i2,sub_actInfo_ in ipairs(sub_actList)do
if sub_actInfo_:checkOpen()then
sub_actInfo=sub_actInfo_
break
end
end
end
end
return sub_actInfo
end

local _jump_func=
{
[JUMP_TYPE.eSubActJump]=function(jump,jumpCB)
local sub_actInfo=_getSubActInfo(jump.args.sublist)
if sub_actInfo then
local base=sub_actInfo:getBaseData()
return activitiesController:jump(base.act_id,base.sub_act_type,base.sub_act_id)
else
UIManager.error('活动未在进行中')
end
end,
[JUMP_TYPE.eMoneyBuy]=function(jump,jumpCB)
if jump.args.keepPanel then
moneySystem:showBuyTips(jump.args.money)
return
end
return jumpManager:jump(jump)
end,
}

local _jump_desc_func=
{
[JUMP_TYPE.eSubActJump]=function(info)
local jump=info.jump
local sub_actInfo=_getSubActInfo(jump.args.sublist)
local check=sub_actInfo~=nil
local desc=FMT.cfmt(FONT_COLOR.eNomalBlackColor,info.desc)
local state=check and'[活动进行中]'or''
return desc,state
end
}

local _check_show_arrow=
{
[JUMP_TYPE.eSubActJump]=function(active,state)
return state~=''
end
}


function gainControl:onAppStart()
end

function gainControl:onEnterState()
end

function gainControl:onLeaveState()
end



function gainControl:showGainWin(itemid,need,exArgs,closeCB)
if verifyManager:isOpen()and webGLHelper:isRunMiniGame()then
UIManager.info('暂无其它获取途径')
return
end
if itemid==nil then

return
end

if need then
if itemsModel.getCount(itemid)>=need then return false end
end
return gainControl:showCommonGainWin_item(itemid,exArgs,closeCB)
end

function gainControl:showCommonGainWin_item(itemid,exArgs,closeCB)
local config=itemsConfig.getConfig(itemid)
local produce=config.produce
if produce then
local args={}
args.titleName='获取途径'
args.pos=2
args.extraWin='UICommonMoneyGainWin'
args.closeCB=closeCB

local extraParams={}
extraParams.goodName=config.name
local num=0
local expireCount=0
if moneyConfig.isMoney(itemid)then
num=moneyModel.getMoney(itemid)
else
num=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
local notExpireCount=bagModel.getNotExpireItemCountById(itemid)
expireCount=num-notExpireCount
end
extraParams.goodId=itemid
extraParams.goodNum=num
extraParams.expireCount=expireCount
extraParams.goodIconName=iconHelper.getIconName(itemid)
extraParams.goodColor=config.color
local colorPage=config.colorPage or 0
extraParams.goodColorPage=colorPage
extraParams.goodSignIcon=config.signIcon
extraParams.goodDesc=config.desc
extraParams.goodProduce=table.deepCopy(produce)

if exArgs then
for k,v in pairs(exArgs)do
extraParams[k]=v
end
end
args.extraParams=extraParams

UIManager:showWindow('UICommonPageWin',args)
return true
else


tipsManager.showTips({
itemid=itemid,
formType=TIPS_FORM_TYPE.eNone,
})
return false
end
end

function gainControl:showCommonGainWin_gubao(gbid)
local itemid=gubaoLookup:gubao2GoodActive(gbid)
gainControl:showCommonGainWin_item(itemid)
end

function gainControl:showGainWin_daoyan(itemid,need,exArgs,closeCB)
if verifyManager:isOpen()and webGLHelper:isRunMiniGame()then
UIManager.info('暂无其它获取途径')
return
end
if itemid==nil then

return
end

if need then
if itemsModel.getCount(itemid)>=need then return false end
end
return gainControl:showCommonGainWin_daoyan(itemid,exArgs,closeCB)
end

function gainControl:showCommonGainWin_daoyan(itemid,exArgs,closeCB)
local config=itemsConfig.getConfig(itemid)
local produce=config.produce
local produceList={}
for i,v in ipairs(produce)do
if v.desc~="    以“混沌天命灵魄”替代"then
table.insert(produceList,v)
end
end

if next(produceList)~=nil then
local args={}
args.titleName='获取途径'
args.pos=2
args.extraWin='UICommonMoneyGainWin'
args.closeCB=closeCB

local extraParams={}
extraParams.goodName=config.name
local num=0
local expireCount=0
if moneyConfig.isMoney(itemid)then
num=moneyModel.getMoney(itemid)
else
num=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
local notExpireCount=bagModel.getNotExpireItemCountById(itemid)
expireCount=num-notExpireCount
end
extraParams.goodId=itemid
extraParams.goodNum=num
extraParams.expireCount=expireCount
extraParams.goodIconName=iconHelper.getIconName(itemid)
extraParams.goodColor=config.color
local colorPage=config.colorPage or 0
extraParams.goodColorPage=colorPage
extraParams.goodSignIcon=config.signIcon
extraParams.goodDesc=config.desc
extraParams.goodProduce=table.deepCopy(produceList)

if exArgs then
for k,v in pairs(exArgs)do
extraParams[k]=v
end
end
args.extraParams=extraParams

UIManager:showWindow('UICommonPageWin',args)
return true
else

return false
end
end



function gainControl:getGainSortList(produce,goodId)
local list=table.deepCopy(produce)
local temp={}
local showBuyGainList={}
for i,v in ipairs(list)do
local sortTag=i
local hecheng=v.hecheng
local hasHeCheng=hecheng~=nil
local buy=v.buy
local hasBuy=buy~=nil
if hasHeCheng then
sortTag=sortTag+1000000
end

if goodId then
v.goodId=goodId
end
local unLock=gainControl:isUnlock(v)
if not unLock then
sortTag=sortTag+10000
end
if v.jump and v.jump.id==JUMP_TYPE.eSubActJump then
sortTag=sortTag-10000
end
v.sortTag=sortTag
if gainControl.canShow(v)then
if hasBuy then
showBuyGainList[#showBuyGainList+1]={data=v,sortTag=sortTag}
else
temp[#temp+1]=v
end
end
end

if showBuyGainList and next(showBuyGainList)then
local showBuyGain
for i,v in ipairs(showBuyGainList)do
local buyParam=v.data.buy
local buyArgs=buyParam.args
local giftid=buyArgs[1]
local cfg=cfg_limitedgiftconfig_get(giftid)
local buyNum=rechargeModel:getXianGouLiBaoBuyNum(giftid)
local maxcount=cfg.maxcount
local left=maxcount-buyNum
local isSellOut=left<=0

if not isSellOut then
v.sortTag=v.sortTag+100000
end

if not showBuyGain or v.sortTag<showBuyGain.sortTag then
showBuyGain=v
end
end

if showBuyGain then
temp[#temp+1]=showBuyGain.data
end
end
table.sort(temp,function(a,b)return a.sortTag<b.sortTag end)

return temp
end

function gainControl:isUnlock(info)
local sysid=info.sysid
local lv=info.lv
local jumpId=info.jump and info.jump.id or nil
if sysid then
if not systemModel.isOpen(sysid)then
return false,{_errType.eSystem,sysid}
end
end
if lv then
if playerModel:getActorLevel()<lv then
return false,{_errType.eLevel,lv}
end
end
local ret=true
local args
if _unlockCheckfunc[jumpId]then
ret,args=_unlockCheckfunc[jumpId](info)
end
if ret==nil then return true end
return ret,args
end

function gainControl:showTips(lockArgs)
local errType=lockArgs[1]
local errValue=lockArgs[2]
if errType==_errType.eSystem then
local desc=systemModel.getOpenTips(errValue)
UIManager.error(desc)
elseif errType==_errType.eLevel then
UIManager.error(FMT.fmt('宗门等级不足{0}级',errValue))
elseif errType==_errType.eDailyTask then
UIManager.error(errValue)
elseif errType==_errType.eXianGouLiBao then
UIManager.error(errValue)
elseif errType==_errType.eSchool then
UIManager.error('今日上课次数已用完')
elseif errType==_errType.eFair then
UIManager.error('坊市刷新次数已用完')
elseif errType==_errType.eMystery then
UIManager.error('大世界上未出现该秘境')
elseif errType==_errType.eMysteryList then
UIManager.error(errValue)
elseif errType==_errType.eWorldTour then
UIManager.error("当前游历弟子已达上限")
elseif errType==_errType.eCatShop then
UIManager.error(errValue)
elseif errType==_errType.eCustom then
UIManager.error(errValue)
end
end

function gainControl:handleJump(jump,jumpCB)
local func=_jump_func[jump.id]
if func then
func(jump,jumpCB)
else
jumpManager:jump(jump,jumpCB)
end
end

function gainControl:getJumpDesc(info,unLock,isGray)
local jump=info.jump
local jumpId=jump and jump.id or nil
if jumpId then
local func=_jump_desc_func[jumpId]
if func then
return func(info)
end
end
local desc=(not unLock or isGray)and FMT.cfmt(FONT_COLOR.eGrayColor,info.desc)or
FMT.cfmt(FONT_COLOR.eNomalBlackColor,info.desc)
return desc,''
end

function gainControl:checkShowArrow(jump,active,state)
local func=jump and _check_show_arrow[jump.id]or false
if func then
return func(active,state)
else
return active
end
end
