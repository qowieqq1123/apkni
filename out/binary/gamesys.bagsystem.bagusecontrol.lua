bagUseControl=gameState.addListener({})
local _remove=table.remove

local _data={}
local _lookup={}
local _askGUID=nil
local _justFirstGetAskList={}
local _useCache={}
local _batchUse={}
local _batchUseNum=0
local _sellCache={}
local _batchSell={}


BAG_ITEM_USE_CALLBACK_BY_FUNCTION_TYPE=
{
[item_funtion_type.eFulu]=function(itemid,funcparam,num)






local args={itemId=itemid,funcparam=funcparam,showType=USE_FULU_TIPS_SHOW_TYPE.eBuffType,num=num}
jumpManager:jump({type=0,id=JUMP_TYPE.eFuLuUse,needJumpBack=true,args=args})
end,
[item_funtion_type.huiChunFu]=function(itemid,funcparam,num)






local args={itemId=itemid,funcparam=funcparam,showType=USE_FULU_TIPS_SHOW_TYPE.eEffectType}
jumpManager:jump({type=0,id=JUMP_TYPE.eFuLuUse,needJumpBack=true,args=args})
end,
[item_funtion_type.yinYaoFu]=function(itemid,funcparam,num)






local args={itemId=itemid,funcparam=funcparam,showType=USE_FULU_TIPS_SHOW_TYPE.eEffectType}
jumpManager:jump({type=0,id=JUMP_TYPE.eFuLuUse,needJumpBack=true,args=args})
end,
[item_funtion_type.disciple]=function(itemid,funcparam,num)
if not funcparam.isSpecial then

UIRecruitControl:showRecruitWindowByUseItem()
end
end,
[item_funtion_type.wuFangSpeedUpFu]=function(itemid,funcparam,num)

zongmenControl:useWuFangSpeedUpFu(itemid)
local name=itemsConfig.getColorName(itemid)
UIManager.info(FMT.fmt('使用{0}成功',name))
end,
[item_funtion_type.changShengFu]=function(itemid,funcparam,num)






local args={itemId=itemid,funcparam=funcparam,showType=USE_FULU_TIPS_SHOW_TYPE.eEffectType}
jumpManager:jump({type=0,id=JUMP_TYPE.eFuLuUse,needJumpBack=true,args=args})
end,
[item_funtion_type.playerimage]=function(itemid,funcparam,num)
UIManager:showWindow('UICommonShowPrizeFiveWin',{itemid=itemid})
end,
[item_funtion_type.eActiveMonthCard]=function(itemid,funcparam,num)
UIManager.info("使用成功")
end,
}


BAG_ITEM_CAN_SHOW_BATCH_SPECIAL_FUN=
{
[item_funtion_type.selectbox]=function(itemid,funcparam)

local selectNum=funcparam.num
if selectNum<=1 then

return false
end
return true
end
}


BAG_ITEM_CAN_BATCH_USE_MAX_NUM_FUN=
{
[item_funtion_type.eCatRecruit]=function(itemid,funcparam)
local maxNum=wanBaoXunBaoDuiModel:getEmployMaxNumber()
local employeeDatas=wanBaoXunBaoDuiModel:getEmployeeList()
local max=math.min(maxNum-#employeeDatas,3)
return max
end
}


function bagUseControl:onAppStart()

end

function bagUseControl:onEnterState()
_data={}
_lookup={}
_askGUID=nil
_useCache={}
_sellCache={}
_justFirstGetAskList=userActorSetting.get("justFirstGetAskList",{})
_batchUse={}
_batchUseNum=0
_batchSell={}
timeEventController.addQuickTimerHandler('bagUseControl',self)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.onNewWeek,self.onNewWeek)
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)
end

function bagUseControl:onLeaveState()
_data={}
_lookup={}
_askGUID=nil
_justFirstGetAskList={}
_useCache={}
_batchUse={}
_batchUseNum=0
_sellCache={}
_batchSell={}
timeEventController.removeQuickTimerHandler('bagUseControl')
notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)
notifySystem:removelistener(notifyConfig.onNewWeek,self.onNewWeek)
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.on_item_list_changed,self.on_item_list_changed)
end

function bagUseControl:onProtocolReq()
for i,v in ipairs(_useCache)do
bagUseControl:handleUseItem(v)
end
_useCache={}

for i,v in ipairs(_sellCache)do
bagUseControl:handleUseItem(v)
end
_sellCache={}
end

function bagUseControl:onQuickUpdate()
if MysteryModel:is_in_mystery()then return end
bagUseControl.dequeue()
end

local _useFunc=
{
[item_funtion_type.eShowDZ]=function(item)
bagProtocolControl.req_use_item_by_itemguid(item.itemguid,item.itemcount)
end,
}


local _checkCNDType=
{
eGF=1,
eDBHC=2,
eCBD=3,
}

local _checkCNDFunc=
{
[_checkCNDType.eGF]=function(params)
if not systemModel.isOpen(SYSTEM_DEFINE.eCangJingGe)then

return false
end
local gfid=params[2]
if UIGongFaModel:isGongFaActive(gfid)then return false end
return true
end,

[_checkCNDType.eDBHC]=function(params)
if not systemModel.isOpen(SYSTEM_DEFINE.eDaoBing)then

return false
end
local itemid=params[2]
local has=itemsModel.getCount(itemid)
local need=daobingConfig.getCombineCnt(itemid)
local cnt=math.floor(has/need)
if cnt<1 then return false end
return true
end,
[_checkCNDType.eCBD]=function(cnd,params)




local count=0
local max=cnd[2]
local len=type(params.mjAreaId)
local TreasureMapList=MysteryModel:getTreasureMapUseCount()
if TreasureMapList then
for k,v in pairs(TreasureMapList)do
if v then
count=count+1
end
end

if len=="number"then
local index=tostring(params.mjAreaId)

if TreasureMapList[index]==true then return false end
end

if count>=max then return false end
end

return true
end,
}

function bagUseControl.checkShowUseCND(getusetype,funcparam,item)
local useParams=getusetype[2]
if useParams==nil or useParams.cnd==nil then
local itemid=item.itemid
local isShowCDTime=bagUseControl.getItemShowCDTime(itemid)
if isShowCDTime then
local itemguid=item.itemguid
local lerp=bagUseControl.getItemCDTime(itemguid)
return lerp<=0
end
return true
end
local cnd=useParams.cnd
local checkType=cnd[1]
if checkType==nil then
logErr('getusetype判断类型不能为空')
return false
end
if _checkCNDFunc[checkType]==nil then
loggerUtil.logErrFMT('getusetype尚未支持使用类型判断：{0}',checkType)
return false
end
if checkType==3 then
return _checkCNDFunc[checkType](cnd,funcparam)
end
return _checkCNDFunc[checkType](cnd)
end


function bagUseControl.checkAutoItemUse(item)
if item==nil then return end

local itemid=item.itemid
local itemConfig=itemsConfig.getConfig(itemid)
if itemConfig==nil then return end

if itemConfig.expire and not initProControl.isDone()then
_sellCache[#_sellCache+1]=item
return
end

local getusetype=itemConfig.getusetype
if getusetype==nil then return end
local usetype=getusetype[1]
if usetype==nil then return end

if not initProControl.isDone()then
_useCache[#_useCache+1]=item
return
end

bagUseControl:handleUseItem(item)
end


function bagUseControl.checkWaitShowUseTipsItemList()
local itemList=bagModel:getWaitShowUseTipsItemList()
bagModel:clearWaitShowUseTipsItemList()
for _,item in ipairs(itemList)do
bagUseControl:handleUseItem(item)
end

local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eLogin,REPEAT_TYPE.eItemExpireSell)
if not flag then
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eLogin,REPEAT_TYPE.eItemExpireSell,true)

local itemList=bagModel:getWaitShowSellTipsExpireItemList()
bagModel:clearWaitShowSellTipsExpireItemList()
for _,item in ipairs(itemList)do
local itemguid=item.itemguid
bagUseControl.enqueue(itemguid)
end
end

end

function bagUseControl:handleUseItem(item)
if item==nil then return end
local itemid=item.itemid
local itemConfig=itemsConfig.getConfig(itemid)

if itemConfig==nil then return end

if bagUseControl.isItemExpire(item.itemguid)then
bagModel:addWaitShowSellTipsExpireItemList(item)
end

local getusetype=itemConfig.getusetype or{}
local usetype=getusetype[1]
if usetype==nil then return end
local funcparam=itemConfig.funcparam
if usetype==ITEM_GET_USE_TYPE.eAutoUse then
if funcparam and funcparam.type and _useFunc[funcparam.type]then
_useFunc[funcparam.type](item)
return
end
local count=item.itemcount
bagProtocolControl.req_use_item(itemid,count)
elseif usetype==ITEM_GET_USE_TYPE.eUseAsk or usetype==ITEM_GET_USE_TYPE.eHighAsk then
if not bagUseControl.checkShowUseCND(getusetype,funcparam,item)then

bagModel:addWaitShowUseTipsItemList(item)
return
end
if itemsConfig.isClothing(itemid)then
if systemModel.isOpen(SYSTEM_DEFINE.eClothing)then
local diziguid=ClothingHelper.findDizi(itemid,nil,true)
if diziguid then
local itemguid=item.itemguid
bagUseControl.enqueue(itemguid)
end
end
else
local itemguid=item.itemguid
bagUseControl.enqueue(itemguid)
end
elseif usetype==ITEM_GET_USE_TYPE.eJustFirstAsk then
if not bagUseControl.checkShowUseCND(getusetype,funcparam,item)then

bagModel:addWaitShowUseTipsItemList(item)
return
end
local isNotHas=true
for k,v in pairs(_justFirstGetAskList)do
if v==itemid then
isNotHas=false
end
end
if itemsConfig.isClothing(itemid)then
if systemModel.isOpen(SYSTEM_DEFINE.eClothing)then
local diziguid=ClothingHelper.findDizi(itemid,nil,true)
if isNotHas and diziguid then
table.insert(_justFirstGetAskList,itemid)
local itemguid=item.itemguid
bagUseControl.enqueue(itemguid)
userActorSetting.set("justFirstGetAskList",_justFirstGetAskList)
userActorSetting.flush(true)
end
end
else
local useParams=getusetype[2]
local isCanQuickUse=true
if useParams then
local jumpParam=useParams.jump
if jumpParam then
local jumpCfg=uiwindow_id_tips_callbacks[jumpParam.id]
local checkFunc=jumpCfg.check_can_jump
if checkFunc then
isCanQuickUse=checkFunc(itemConfig.jump.args)
end
end
end
if isNotHas and isCanQuickUse then
table.insert(_justFirstGetAskList,itemid)
local itemguid=item.itemguid
bagUseControl.enqueue(itemguid)
userActorSetting.set("justFirstGetAskList",_justFirstGetAskList)
userActorSetting.flush(true)
end
end

elseif usetype==ITEM_GET_USE_TYPE.eSpecialAutoUse then
if not bagUseControl.checkSpecialAutoUse(getusetype,funcparam,item)then
return
end
if funcparam and funcparam.type and _useFunc[funcparam.type]then
_useFunc[funcparam.type](item)
return
end
local count=item.itemcount
bagProtocolControl.req_use_item(itemid,count)

elseif usetype==ITEM_GET_USE_TYPE.eAutoUseKuang then
local jump=itemConfig.jump
if jump and jump.args and jump.args.tab then
local tab=jump.args.tab

local isActive,headId=UISettingController:checkUnlockByItemId(tab,itemid)
if not isActive then

bagUseControl.checkKuangAutoUse(tab,headId)
end
end
end
end

function bagUseControl.clearAskUse(itemguid,use)
if _askGUID==nil then return end
if tostring(itemguid)~=tostring(_askGUID)then

bagUseControl.useItem(_askGUID)
return
end
_askGUID=nil
end

function bagUseControl.noUseItem(itemguid)
local handle=tostring(itemguid)
if _lookup[handle]then
_lookup[handle]=nil
for i,v in ipairs(_data)do
if tostring(v)==handle then
_remove(_data,i)
break
end
end
end
if handle~=tostring(_askGUID)then

end
_askGUID=nil
end

function bagUseControl.enqueue(itemguid)
if not bagModel.hasItem(itemguid)then return end
local handle=tostring(itemguid)
if _lookup[handle]then return end
_lookup[handle]=true
_data[#_data+1]=itemguid
if not _batchUse[handle]and bagUseControl.checkBatchUseCnd(itemguid)then
_batchUse[handle]=true
_batchUseNum=_batchUseNum+1
end
if not _batchSell[handle]and bagUseControl.isItemExpire(itemguid)then
_batchSell[handle]=true
end
end

function bagUseControl.dequeue()
if _askGUID then return end
local len=#_data
if len<=0 then return end
if not mainControl:isInScene(eSceneType.eZongmen)then return end
local itemguid=_data[1]
_remove(_data,1)
_lookup[tostring(itemguid)]=nil
if not bagModel.hasItem(itemguid)then return end
bagUseControl.useItem(itemguid)
end

function bagUseControl.checkOpenWindow()
return _askGUID and mainViewsControl.isOpen()and
not MysteryModel:get_cur_fbid()
end

function bagUseControl.useItem(itemguid)
_askGUID=itemguid
if _askGUID==nil then return end
local item=bagModel.getItem(_askGUID)
if item==nil then
_askGUID=nil
return
end
if bagUseControl.checkOpenWindow()then
UIManager:showWindow('UIItemUseTipWin')
else
_askGUID=nil
bagModel:addWaitShowUseTipsItemList(item)
end
end

function bagUseControl.onUseItem(itemguid)
UIManager:callWindowFunc('UIItemUseTipWin','onUseItem',itemguid)
end

function bagUseControl.onUseItemid(itemid)
UIManager:callWindowFunc('UIItemUseTipWin','onUseItemid',itemid)
end

function bagUseControl.getAskGUID()
return _askGUID
end

function bagUseControl.openBatchUseHandle()
local new_data={}
for _,itemguid in ipairs(_data)do
if not _batchUse[tostring(itemguid)]then
table.insert(new_data,itemguid)
end
end
_data=new_data
for itemguidStr,_ in pairs(_batchUse)do
_lookup[itemguidStr]=nil
end
UIManager:callWindowFunc('UIItemUseTipWin','moveNext')
end

function bagUseControl.checkOpenBatchUseWin(itemguid)
return _batchUseNum>1 and _batchUse[tostring(itemguid)]
end

function bagUseControl.getBatchUseLookup()
return _batchUse
end

function bagUseControl.getBatchUseNum()
return _batchUseNum
end

function bagUseControl.checkBatchUseCnd(itemguid)
local item=bagModel.getItem(itemguid)
if not item then return end
local itemid=item.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local funcparam=itemConfig.funcparam
if not funcparam or funcparam.type~=item_funtion_type.eBaoXiang then
return false
end
if not itemConfig.batch then
return false
end
return true
end

function bagUseControl.openBatchSellHandle()
local new_data={}
for _,itemguid in ipairs(_data)do
if not _batchSell[tostring(itemguid)]then
table.insert(new_data,itemguid)
end
end
_data=new_data
for itemguidStr,_ in pairs(_batchSell)do
_lookup[itemguidStr]=nil
end
UIManager:callWindowFunc('UIItemUseTipWin','moveNext')
end

function bagUseControl.getBatchSellLookup()
return _batchSell
end


function bagUseControl.hasExpireTime(itemguid)
local itemData=bagModel.getItem(itemguid)
local hasExpireTime=itemData and mathHelper.getBitValue(itemData.itemflag,3-1)or false
local itemtime=hasExpireTime and itemData.itemtime or 0
return itemtime>0
end


function bagUseControl.isItemExpire(itemguid)
local isExpire=false
local itemData=bagModel.getItem(itemguid)
local hasExpireTime=itemData and mathHelper.getBitValue(itemData.itemflag,3-1)or false
local itemtime=hasExpireTime and itemData.itemtime or 0
if itemtime>0 then

local nowTime=timeHelper.getServerShortTime()
local lerp=itemtime-nowTime
if lerp<=0 then

isExpire=true
end
end

return isExpire
end


function bagUseControl.getItemExpireTime(itemguid)
local itemData=bagModel.getItem(itemguid)
local hasExpireTime=itemData and mathHelper.getBitValue(itemData.itemflag,3-1)or false
local itemtime=hasExpireTime and itemData.itemtime or 0
return itemtime
end


function bagUseControl.isItemInAuctionSellCd(itemguid)
if not itemguid or mathHelper.compareInt64(itemguid,int64.new("-1"))then

return false
end

local isInCd=false
local itemData=bagModel.getItem(itemguid)
local hasCdTime=itemData and mathHelper.getBitValue(itemData.itemflag,4-1)or false
local itemtime=hasCdTime and itemData.itemtime or 0
if itemtime>0 then

local nowTime=timeHelper.getServerShortTime()
local lerp=itemtime-nowTime
if lerp>0 then

isInCd=true
end
end

return isInCd
end


function bagUseControl.getItemAuctionSellCdTime(itemguid)
local itemData=bagModel.getItem(itemguid)
local hasCdTime=itemData and mathHelper.getBitValue(itemData.itemflag,4-1)or false
local itemtime=hasCdTime and itemData.itemtime or 0
return itemtime
end


function bagUseControl.getItemShowCDTime(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
local special_limit=itemConfig.special_limit or{}
local cd=special_limit[1]
return cd~=nil
end


function bagUseControl.getItemCDTime(itemguid)
local item=bagModel.getItem(itemguid)
if not item then
return 0
end
local itemData=item.itemData
local itemid=item.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local special_limit=itemConfig.special_limit or{}
local cd=special_limit[1]
local cdtime=itemData and itemData.cd_time or 0
if cdtime<=0 then
return 0
end
local now=timeHelper.getServerShortTime()
local nextCanUseTime=cdtime+cd*3600
if nextCanUseTime<=now then
return 0
end
local diff=nextCanUseTime-now
return diff
end


function bagUseControl.getItemLastUseTime(itemguid)
local item=bagModel.getItem(itemguid)
if not item then
return 0
end
local itemData=item.itemData
local cdtime=itemData and itemData.cd_time or 0
if cdtime<=0 then
return 0
end
return cdtime
end


function bagUseControl.getItemReuseCount(itemguid)
local item=bagModel.getItem(itemguid)
if not item then
return 0
end
local itemData=item.itemData
local itemid=item.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local use_times=itemData and itemData.use_times or 0
local special_limit=itemConfig.special_limit or{}
local maxCount=special_limit[2]
if not maxCount then
return 0
end
local left=maxCount-use_times
return left<0 and 0 or left
end

function bagUseControl.onNewDay()
local limitType=1
bagModel:clearItemUseCountByLimitType(limitType)
end

function bagUseControl.onNewWeek()
local limitType=2
bagModel:clearItemUseCountByLimitType(limitType)
end



local _paramFuncUseCfg=
{

[item_funtion_type.eFulu]=function(funcparam,itemid,num,call)
local id=funcparam.gsid
local cfg=cfg_guildstateconfig_get(id)
local sametype=cfg.sametype
if sametype==0 then
call(true)
return
end
local has=homeBuffModel.hasHigherLevelBuff(id)
if has then
local tips='已有更高等级的符箓效果'
UIManager.error(tips)
call(false)
return
end
local has=homeBuffModel.hasLowerLevelBuff(id)
if has then
local itemName=itemsModel.getName(itemid)
local tips=FMT.fmt('已有低阶的{0}效果，使用后低阶{0}效果将暂时失效，确定使用吗？',itemName)
bagUseControl.showDialogue('提示',tips,function()
call(true)
end)
return
end
call(true)
end,

[item_funtion_type.eItemEmotPackage]=function(funcparam,itemid,num,call)
chatProtocolControl.sendUnLockItemEmot(funcparam.tabid,funcparam.tabidx)
call(false)
end,
[item_funtion_type.eShangGuXianDi]=function(funcparam,itemid,num,call)
if not systemModel.isOpen(SYSTEM_DEFINE.eMiJingDangerMap)then
UIManager.error('上古险地功能未开启')
call(false)
return
end
if mysteryWeekActivityModel:getMysteryNum()>=2 then
local tips='当前世界已无法负载更多的上古险地'
UIManager.error(tips)
call(false)
return
end
call(true)
end,
[item_funtion_type.eActiveMonthCard]=function(funcparam,itemid,num,call)

jumpManager:jump({id=JUMP_TYPE.eReCharge,args={tabType=FULL_TAB_TYPE.eMonthInvestor}})
call(true)
end,
[item_funtion_type.eItemExchange]=function(funcparam,itemid,num,call)
if funcparam.act_type then
local actName=cfgHelper.get2(cfg_subactivitytypeconfig_get,funcparam.act_type,"name")
local itemNum=itemsModel.getCount(itemid)
local itemName=itemsConfig.getItemName(itemid)
local infos=activitiesModel:getActSubList_subType_open_doing(funcparam.act_type)
local count=#infos
local rewardStr=FMT.fmt("{0}",itemsConfig.getItemName(funcparam.reward_list[1]))

if funcparam.act_check==1 and count>0 then
UIManager:showWindow("UISubAct_xianjieqiyuan_AutoExchangeDialog",{itemData={{itemid,itemNum}}})
UIManager:closeWindow('UITipsWin')
call(false)
return
elseif funcparam.act_check==0 and count<=0 then
UIManager:showWindow("UISubAct_xianjieqiyuan_AutoExchangeDialog",{itemData={{itemid,itemNum}}})
UIManager:closeWindow('UITipsWin')
call(false)
return
end
if count>0 then
jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=funcparam.act_type}})
call(false)
else
call(false)
end
else
call(true)
end
end
}

function bagUseControl.useSingleItem(itemid,num,_call)
local call=function(ret)
local count=0
local max=3
local itemConfig=itemsConfig.getConfig(itemid)
local index=nil
local param=itemConfig.funcparam.mjAreaId
if type(param)=="number"then index=param end
if itemConfig.typename=="地图"then
local TreasureMapList=MysteryModel:getTreasureMapUseCount()
if TreasureMapList then
for k,v in pairs(TreasureMapList)do
if v then
count=count+1
end
end
if count>=max then
UIManager.info("大世界上藏宝图秘境已达到上限（3/3）")
_call(ret)
return
end
if index then
if TreasureMapList[tostring(index)]then
UIManager.info("该藏宝图生成的秘境已存在大世界中")
_call(ret)
return
end
end
end
end
if ret then
bagProtocolControl.req_use_item(itemid,num)
end
if _call then _call(ret)end
end

if not itemsLookup:checkUseItemCondition(itemid)then
call(false)
return
end

local itemCfg=itemsConfig.getConfig(itemid)
if itemCfg==nil then
call(false)
return false
end
local funcparam=itemCfg.funcparam
if funcparam then
local type=funcparam.type
local func=_paramFuncUseCfg[type]
if func then
func(funcparam,itemid,num,call)
return
end
end
if itemCfg.gain then
zongmenControl:checkAndUseMatItem({{itemid,num}},function()
call(true)
end)
else
call(true)
end
end

function bagUseControl.showDialogue(title,msg,call)
bagUseControl.dialogue=UIDialogManager.getConfirmDialog(bagUseControl.dialogue,title,msg)
bagUseControl.dialogue.okcallback=function()
if call then call()end
end
bagUseControl.dialogue:show()
end

function bagUseControl.on_home_event(etype)
if etype==homeEvent.eEnterHome then
bagUseControl:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
bagUseControl:onLeaveHome()
end
end

function bagUseControl.on_item_list_changed(args,lookup_guidStr,lookup_itemid,lookup_bag,lookup_change)
if _batchUseNum<=0 then return end
if not lookup_change[CHANGE_TYPE.eDelete]then return end

for i,v in ipairs(args)do
local changeType=v[1]
if changeType==CHANGE_TYPE.eDelete then
local itemguidStr=tostring(v[2])
if _batchUse[itemguidStr]then
_batchUse[itemguidStr]=nil
_batchUseNum=_batchUseNum-1

end
if _batchSell[itemguidStr]then
_batchSell[itemguidStr]=nil
end
end
end



end

function bagUseControl:onEnterHome()
bagUseControl.checkWaitShowUseTipsItemList()
end

function bagUseControl:onLeaveHome()

end


function bagUseControl.checkSpecialAutoUse(getusetype,funcparam,item)
local useParams=getusetype[2]
if useParams==nil then
return false
end
if useParams==1 then
local win=UIManager:findActiveWindow('UISubAct_NiuDanJiWin')
if win then
return false
end
win=UIManager:findActiveWindow('UISubAct_FeiJianDuoBaoWin')
if win then
return false
end
win=UIManager:findActiveWindow('UISubAct_YunHaiDiaoBaoWin')
if win then
return false
end
else
return false
end
return true
end


function bagUseControl.checkKuangAutoUse(tab,headId)
local curSelectCfg=nil
if tab==2 then

curSelectCfg=cfgHelper.get1(cfg_headportraitframeconfig_get,headId)

elseif tab==3 then

curSelectCfg=cfgHelper.get1(cfg_bubbleframeconfig_get,headId)
end

local unLock=UISettingModel:isUnlockHead(tab,headId)
if unLock then
UIManager.error('已解锁')
return
end
if curSelectCfg then
local unLockLimit=curSelectCfg.unlock
if unLockLimit then
local cost=unLockLimit.param
local itemid=cost[1]
if itemsLookup:checkUseItemCondition(itemid)then
UISettingController:req_unlock(tab,headId)
end
end
end
























end
