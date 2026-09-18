




eventOptionAction=simple_class(eventBaseAction)

function eventOptionAction.create(...)
return refObject.getX('eventOptionAction',...)
end

function eventOptionAction:init(...)
self.leaveState=false
self:start(...)
end

function eventOptionAction:onRelease()
self.leaveState=false
end


function eventOptionAction:start(eventconfig,eventInfo)
local mainType=eventInfo.mainType
local subType=eventInfo.subType
local eventguid=eventInfo.eventguid
local eventid=eventInfo.eventid
local paramList=eventInfo.paramList
local optioncontent=eventconfig.optioncontent
local optionicon=eventconfig.optionicon
local rewards=eventconfig.rewards or{}
local lockobject=eventconfig.lockobject
local npcData=eventInfo.npcData

local title=optioncontent[1]
local content=optioncontent[2]
local icon=optionicon[1]
local btnTitleList=optioncontent[3]
local btnExtraTextList=optioncontent[4]or{}

local option=eventConfig.getEventConfig(eventid).option
local dispatch=eventConfig.getOptionDispatch(eventid)
local speak=eventConfig.getEventConfig(eventid).speak
local startStoryId=eventConfig.getEventConfig(eventid).startStoryId
local dizinum=dispatch and dispatch[1]or 0
local waitTime=dispatch and dispatch[2]or 0
local diziguid=paramList and paramList[2]
local sortArgs=dispatch and dispatch[3]
local limitArgs=dispatch and dispatch[4]
local iszhanglao=speak==1
local islockobject=lockobject==1
local speakguid=iszhanglao and eventOptionControl.getAnyZMZhanglao()or diziguid
if npcData then

speakguid=nil
end

if diziguid==nil and npcData==nil then
loggerUtil.logErrFMT('id={0}的事件没找到决策对象',eventid)
self.leaveState=true
return
end

local key=self:getkey()
local guid=self:getguid()
local args={}
local btnList={}
local len=#btnTitleList

local leaveFun=function()
if not self:isRelease(guid,key)then
self.leaveState=true
end

shanmenModel:hideOptionEventNPCClick(eventguid)

UIManager:closeWindow('UIEventOptionSelectWin')
end

local checkConsumeFun=function(selectIndex)
local selectConsume=eventConfig.getOptionConsume(eventid,selectIndex)
if selectConsume then
for _,v in ipairs(selectConsume)do
local errStr
local isEnough=true
if itemsConfig.isMoney(v[1])then
local moneyType=v[1]
if not moneyModel.checkEnoughMoney(v[1],v[2])then
local moneyName=moneyModel.getMoneyName(moneyType)
errStr=FMT.fmt('{0}不足',moneyName)
isEnough=false
end
else
local itemId=v[1]
local itemCount=bagControl.invokeFuncByItemId(v[1],'getItemCountByItemID',v[1])
if itemCount<v[2]then
errStr=FMT.fmt('{0}不足',itemsConfig.getItemName(itemId))
isEnough=false
end
end
if not isEnough then
UIManager.error(errStr)
gainControl:showGainWin(v[1])
return false
end
end
end
return true
end


local toSelectDiziFunc=function(i)
local selectDispatch=eventConfig.getOptionDispatch(eventid,i)
local selectDzNum=selectDispatch and selectDispatch[1]or 0
local selectWaitTime=selectDispatch and selectDispatch[2]or 0
local selectSortArgs=selectDispatch and selectDispatch[3]
local selectLimitArgs=selectDispatch and selectDispatch[4]
local func=function(dizilist)
dizilist=dizilist or{}
local dizilen=#dizilist
if dizilen<selectDzNum then
UIManager.error('派遣弟子数量不足')
return false
end
eventOptionControl.addDiziIntoEventInfo(eventguid,dizilist,selectWaitTime)
eventProtocolControl.reqOptionEvent(eventguid,i,dizilist)
leaveFun()
return true
end
local numFun=function(num)
return FMT.fmt('派遣人数{0}/{1}',num,selectDzNum)
end
local unSelectFun=function(guid,list)
if islockobject and tostring(guid)==tostring(diziguid)then
UIManager.error('此弟子无法取消派遣')
return false
end
return true
end

local selectFun=function(guid,list)
local len=#list
if selectDzNum>1 and len>=selectDzNum then
UIManager.error('派遣弟子已达最大数量')
return false
end
if not UIDiscipleModel:checkDZStateToDoSomething(guid,eCheckDiscipleStateOpType.eDispatch,true)then
return false
end

if selectDzNum==1 and len==selectDzNum then
return true,true
end

return true
end
local sortFun=function(list)
local temp={}
local temp1={}
local checkFirstDzIdList
if selectLimitArgs and selectLimitArgs then
local limitType=selectLimitArgs[1]
if limitType==3 then

checkFirstDzIdList=selectLimitArgs[2]
end
end

for i=#list,1,-1 do
local info=list[i]
local _diziguid=info.netData.net.discipleguid
local _diziId=info.netData.net.id




local isAddToFirst=false
if checkFirstDzIdList and next(checkFirstDzIdList)then
for _,targetDzId in ipairs(checkFirstDzIdList)do
if _diziId==targetDzId then
isAddToFirst=true
break
end
end
end

if isAddToFirst then
table.remove(list,i)
temp[#temp+1]=info
elseif not UIDiscipleModel:checkDZStateToDoSomething(_diziguid,eCheckDiscipleStateOpType.eDispatch,false)then
table.remove(list,i)
table.insert(temp1,1,info)
end
end
for i,v in ipairs(temp)do
table.insert(list,1,v)
end
for i,v in ipairs(temp1)do
list[#list+1]=v
end
return list
end
UIManager:showWindow('UICommonDragonBoneWin',{titleName='选择弟子',
extraWin='UIDiscipleSelectTwoWin',
extraParams={maxNum=1,
btnTxt='安排',
click=func,
sortArgs=selectSortArgs,
limitArgs=selectLimitArgs,
sortFun=sortFun,
unSelectFun=unSelectFun,
selectFun=selectFun,
selectdizi={diziguid}}})


end

for i=1,len do
btnList[#btnList+1]=
{
name=btnTitleList[i],
extraText=btnExtraTextList[i],
dispatch=option[i]and option[i].dispatch or nil,
click=function()
if not checkConsumeFun(i)then return false end
local selectDispatch=eventConfig.getOptionDispatch(eventid,i)
local selectDzNum=selectDispatch and selectDispatch[1]or 0
local selectWaitTime=selectDispatch and selectDispatch[2]or 0
if selectDzNum==0 then
eventOptionControl.addDiziIntoEventInfo(eventguid,nil,selectWaitTime)
eventProtocolControl.reqOptionEvent(eventguid,i)
leaveFun()
return true
elseif selectDzNum==1 and islockobject then
local dizilist={diziguid}
eventOptionControl.addDiziIntoEventInfo(eventguid,dizilist,selectWaitTime)
eventProtocolControl.reqOptionEvent(eventguid,i,dizilist)
leaveFun()
return true
else
toSelectDiziFunc(i)
end
end
}
end

local cancelBtnParam=eventConfig.getEventConfig(eventid).cancelBtnParam
if cancelBtnParam then

local storyId=cancelBtnParam.storyId
btnList[#btnList+1]=
{
name=cancelBtnParam.btnText,
click=function()
if storyId then
local storyArgs={

npcData=npcData,
eventguid=eventguid,
}


worldStoryController:showStoryTree(storyId,nil,nil,nil,storyArgs)
end
UIManager:invokeUIMethod("UIEventOptionSelectWin","onBtnClose")
end
}
end


local showRewards={}
for _,v in ipairs(rewards)do
local selectRewardList=v
for i,itemId in ipairs(selectRewardList)do
local item={itemId,-1}
table.insert(showRewards,item)
end
end

args.time=waitTime
args.dizinum=dizinum
args.diziguid=speakguid
args.content=content
args.rewards=showRewards
args.btnList=btnList
args.name=title
args.icon=icon

args.actionKey={guid,key}
args.npcData=npcData
args.startStoryId=startStoryId
args.eventguid=eventguid
args.eventid=eventid


eventOptionModel.setOpenEventWinParam(args,eventguid)


shanmenModel:addOptionEventNpcData(npcData)
end

function eventOptionAction:update()
return self.leaveState
end
