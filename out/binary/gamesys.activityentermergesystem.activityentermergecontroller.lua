




activityEnterMergeController={}

function activityEnterMergeController:onEnterState()
self.popFlagList={}
notifySystem:listenNotify(notifyConfig.onActivityStateChange,self.onActivityStateChange)
end

function activityEnterMergeController:onLeaveState()
self.popFlagList=nil
notifySystem:removelistener(notifyConfig.onActivityStateChange,self.onActivityStateChange)
end

function activityEnterMergeController:initLookup()
if self.lookup then
return
end
self.lookup={}
local cfg=cfg_activityentermergeconfig()
for id,v in pairs(cfg)do
for i,actId in ipairs(v.activityIdList)do
if self.lookup[actId]then
logErr("活动id 重复整合",actId,self.lookup[actId])
else
self.lookup[actId]=id
end
end
end
end

function activityEnterMergeController:checkMergeActivity(actId)
if not self.lookup then
self:initLookup()
end
return self.lookup[actId]~=nil
end

function activityEnterMergeController:checkMergeActivityEx(actId,mergeId)
if not self.lookup then
self:initLookup()
end
return self.lookup[actId]==mergeId
end

function activityEnterMergeController:freshMergeActivityEnter(actId)

local id=self.lookup[actId]
if not self.enterGuidlookup then
self.enterGuidlookup={}
end
local enterCfg=cfg_activityentermergeconfig_get(id)
local removeFlag=activityEnterMergeController:checkMergeActivityRemove(id)

local guid=self.enterGuidlookup[id]
if removeFlag then
if guid then
enterManager:removeEnter(guid)
self.enterGuidlookup[id]=nil
end
else
self.enterGuidlookup[id]=enterManager:freshEnter({id=id,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eMergeActivity,
params={mergeId=id},getReddotFun=function()
return activityEnterMergeController:checkMergeActivityReddot(id)
end,_guid=guid})
if enterCfg.popWin and self.popFlagList and not self.popFlagList[id]then
self.popFlagList[id]=true
local msgType=enterCfg.popWin[1]
local _,_act_id=activityEnterMergeController:getMinActEndLeftTime(id)
local list=activitiesModel:getActSubList_open_doing(_act_id)
local firstSubData=list[1]
local name,argtable=activityEnterMergeController:getShowparams(firstSubData.act_id,firstSubData.sub_act_type,firstSubData.sub_act_id)
msgWinControl:addMsgWin(msgType,argtable,nil,true)
end

end

end

function activityEnterMergeController:checkMergeActivityRemove(mergeId)
local enterCfg=cfg_activityentermergeconfig_get(mergeId)
local removeFlag=true
for i,actId in ipairs(enterCfg.activityIdList)do
if activityEnterMergeController:checkShow(actId)then
removeFlag=false
break
end
end
return removeFlag
end

function activityEnterMergeController:checkMergeActivityReddot(mergeId)
local enterCfg=cfg_activityentermergeconfig_get(mergeId)
for i,actId in ipairs(enterCfg.activityIdList)do
if activityEnterMergeController:checkShow(actId)and activitiesModel:checkActReddot(actId)then
return true
end
end
return false
end

function activityEnterMergeController:getShowparams(actId,subType,subid,extraParams)
local winName,params,showBlur,id,showBg,skinType,showTopMask
local mid=self.lookup[actId]
local enterCfg=cfg_activityentermergeconfig_get(mid)
local mainWinArgs=enterCfg.mainWinArgs
winName=mainWinArgs[1]or"UI_activityMerge_main_Win"

params={}
params.mergeId=mid
params.moneytypes=enterCfg.moneytypes
params.bgname=enterCfg.bgname
params.select_act_id=actId
params.sub_act_type=subType
params.sub_act_id=subid
params.extraParams=extraParams
params.clickAnyClose=enterCfg.clickAnyClose
params.moneyWinType=fullTopMoneyType.eSkin2
if extraParams~=nil and extraParams.isFull~=nil then
params.isFull=extraParams.isFull
end

id=mid
return winName,params,showBlur,id,showBg,skinType,showTopMask
end



function activityEnterMergeController:getMinActEndLeftTime(mergeId)
local enterCfg=cfg_activityentermergeconfig_get(mergeId)
local minTime,id
for i,actId in ipairs(enterCfg.activityIdList)do
local time=activitiesModel:getActEndLeftTime(actId)
if activityEnterMergeController:checkShow(actId)and time~=0 and(not minTime or minTime>time)then
minTime=time
id=actId
end
end
return minTime or 0,id
end

function activityEnterMergeController:getMergeActSubList_open_doing(mergeId)
local enterCfg=cfg_activityentermergeconfig_get(mergeId)
local list={}
for i,actId in ipairs(enterCfg.activityIdList)do
local subList=activitiesModel:getActSubList_open_doing(actId)
if subList and next(subList)then
for i,subData in ipairs(subList)do
table.insert(list,subData)
end
end
end
return list
end

function activityEnterMergeController:findSubActInMergeAct(mergeId,actID,subType,subid)
local enterCfg=cfg_activityentermergeconfig_get(mergeId)
for i,tag_actID in ipairs(enterCfg.activityIdList)do
if activitiesModel:findSubActInAct(tag_actID,actID,subType,subid)then
return true
end
end
return false
end

function activityEnterMergeController:checkShow(actID)
local actObj=activitiesModel:getActInfo(actID)
if actObj and actObj:checkDoing()and actObj:checkOpen()and actObj:checkOneSubOpen()and activitiesModel:checkActInMerge(actID)==nil then
return true
end
end

function activityEnterMergeController.onActivityStateChange(actID,state)
if activityEnterMergeController:checkMergeActivity(actID)then

activityEnterMergeController:freshMergeActivityEnter(actID)
end
end

