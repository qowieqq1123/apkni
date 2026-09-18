
UIRecruitControl=gameState.addListener(fullScreenUI.create())

local initData=nil
function UIRecruitControl:onAppStart()
socketManager:register_receiver(3,141,self.recv_3_141)
socketManager:register_receiver(3,142,self.recv_3_142)
socketManager:register_receiver(3,143,self.recv_3_143)
socketManager:register_receiver(3,144,self.recv_3_144)
socketManager:register_receiver(3,145,self.recv_3_145)
socketManager:register_receiver(3,146,self.recv_3_146)
socketManager:register_receiver(3,147,self.recv_3_147)
socketManager:register_receiver(3,148,self.recv_3_148)

local args=
{
fullType=FULL_TYPE.eYinXianTai,
skinType=fullScreenSkinType.eSkin1,
}
self:initUI(args)
end

function UIRecruitControl:onEnterState(...)
UIRecruitModel:onEnterState(...)

self.recruitTipsFlags={}
self.giveUpTipsFlags={}
self.nextRecruitTime=0
local def=cfgHelper.getdef(cfg_yinxiantaizmconfig)
self.recruitItemId=def.itemid
self.markNotFullOpenItem={}


notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)

self.isSkipAnimation=userActorSetting.get("YXT_SkipAnimation",false)
self.storyPlayFlag=false
end

function UIRecruitControl:onLeaveState(...)
self.markNotFullOpenItem=nil
initData=nil
UIRecruitModel:onLeaveState(...)
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
end

function UIRecruitControl:onProtocolReq()
if initData then
UIRecruitControl.recv_3_141(initData)
initData=nil
end
end

function UIRecruitControl:onLostConnection()

end

function UIRecruitControl:getSkipAnimationState()
return self.isSkipAnimation and self:isOpenRecruitSkipAnimation()
end

function UIRecruitControl:isOpenRecruitSkipAnimation()
local skip_animation_lv=cfgHelper.get2(cfg_yinxiantaiconfig_get,1,"skip_animation_lv")
local skip_animation_count=cfgHelper.get2(cfg_yinxiantaiconfig_get,1,"skip_animation_count")
local curlv=playerModel:getActorLevel()
local isCanSkipAnimation=curlv>=skip_animation_lv
local recruitCount=gameUtilityModel:getData_counter(gameCounterType.eYinXianTaiZhaoMuNum)
isCanSkipAnimation=isCanSkipAnimation or recruitCount>=skip_animation_count
return isCanSkipAnimation
end

function UIRecruitControl:setSkipAnimationState(state)
self.isSkipAnimation=state
userActorSetting.set("YXT_SkipAnimation",self.isSkipAnimation)
userActorSetting.flush()
end

function UIRecruitControl:setRecruitTipsFlag(ftype,flag)
self.recruitTipsFlags[ftype]=flag
end

function UIRecruitControl:getRecruitTipsFlag(ftype)
return self.recruitTipsFlags[ftype]or false
end

function UIRecruitControl:setGiveUpTipsFlag(ftype,flag)
self.giveUpTipsFlags[ftype]=flag
end

function UIRecruitControl:getGiveUpTipsFlag(ftype)
return self.giveUpTipsFlags[ftype]or false
end

function UIRecruitControl:recordNotFullOpenItem(itemId,flag)
self.markNotFullOpenItem[itemId]=flag
end

function UIRecruitControl:showRecruitWindow(argstable)
if not UIRecruitModel:hasRecruitData()then
UIManager.error('请先建造引仙台')
return
end
local args=
{
showBg=false,
showFg=false,
viewNames={'UIRecruitMainWin'},
viewArgs={['UIRecruitMainWin']=argstable},
showMain=false,
}
if UIManager:isActive('UIRecruitMainWin')then
UIManager:invokeUIMethod("UIRecruitMainWin","onShow",argstable)
return
end
self:showUI(args)
end

function UIRecruitControl:itemRecruitRecord(info,item)
self.itemRecruitData={info,item}
end

function UIRecruitControl:showRecruitWindowByUseItem()
if not self.itemRecruitData then
return
end
local info=self.itemRecruitData[1]
local item=self.itemRecruitData[2]
self.itemRecruitData=nil
local data={
showAnim=true,
showList={{discipleInfo=info,state=1}},
specialItem=item,
}
local win=UIManager:findActiveWindow('UIRecruitSelectWin')
if win then
UIManager:invokeUIMethod('UIRecruitSelectWin','resetShowArgs',data)
UIManager:invokeUIMethod('UIRecruitSelectWin','Refresh',true)
else
local args={mode=1,data=data,}
self:showRecruitWindow(args)
end
end

function UIRecruitControl:showItemRecruitDiscipleWindow(itemId,guid,callback,isFullOpen)

if isFullOpen==nil then
isFullOpen=true
end
if not itemId or self.markNotFullOpenItem[itemId]==true then
isFullOpen=false
end



if not callback then
callback=eventOptionModel.getShowOptionEventResultFunc(true)
end

local viewArgs={
disciple=guid,
callback=callback,
isFullOpen=isFullOpen,
}
if isFullOpen then
local args=
{
showBg=false,
showFg=false,
viewNames={'UIItemRecruitDiscipleWin'},
viewArgs={['UIItemRecruitDiscipleWin']=viewArgs},
showMain=false,
}
self:showUI(args)
else
UIManager:showWindow('UIItemRecruitDiscipleWin',viewArgs)
end
UIRecruitModel:setItemRecruitDiscipleWindowState(true)
end


function UIRecruitControl:checkItemRecruitShowQueueAndShow(isFullOpen)
if UIRecruitModel:getShowRecruitDiscipleWindowState()then

return
end


if UIRecruitModel:getShowRecruitDiscipleQueueSize()>0 then

local data=UIRecruitModel:pushShowRecruitDiscipleQueue()

UIRecruitControl:showItemRecruitDiscipleWindow(data.itemId,data.guid,nil,isFullOpen)
end
end


function UIRecruitControl:showItemDiscipleInfoByItemId(itemId)
self:showWindow("UIItemRecruitDiscipleInfoWin",{itemId=itemId})
end

function UIRecruitControl:showItemDiscipleInfoByItemId2(itemId,dzItemIndex,closeCallBack)
self:showWindow("UIItemRecruitDiscipleInfoTwoWin",{itemId=itemId,dzItemIndex=dzItemIndex,closeCallBack=closeCallBack})
end

function UIRecruitControl:showItemDiscipleInfoByItemId3(dizi_guid)
self:showWindow("UIItemRecruitDiscipleInfoThreeWin",{dizi_guid=dizi_guid})
end

function UIRecruitControl.on_home_event(etype)
if etype==homeEvent.eEnterHome then
UIRecruitControl:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
UIRecruitControl:onLeaveHome()
end
end

function UIRecruitControl:onEnterHome()
timeEventController.addNormalTimerHandler(1,'UIRecruitControl',UIRecruitControl)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_change)
end

function UIRecruitControl:onLeaveHome()
timeEventController.removeNormalTimerHandler(1,'UIRecruitControl')
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_change)
end

function UIRecruitControl.on_item_change(ctype,guid,itemid)
if itemid==UIRecruitControl.recruitItemId then
UIRecruitControl.refreshBuildHud()
end
end

function UIRecruitControl:onNormalUpdate(delay)
if not UIRecruitModel:hasRecruitData()then
return
end
local curTime=timeHelper.getServerShortTime()
local have=UIRecruitModel:checkHaveZhaoMuZhong()
if have then
local endtime=UIRecruitModel:getFamilyMinEndTime()
if curTime==endtime then
self.refreshBuildHud()
end
end

local times=UIRecruitModel:getRecruitTimes()
local maxfree=cfgHelper.getdef1(cfg_yinxiantaizmconfig,'maxfree')
if curTime>self.nextRecruitTime and times<maxfree then
self.nextRecruitTime=curTime+10000
self:reqRefreshRecruitTimes()
end
end

function UIRecruitControl.refreshBuildHud()
local bdData=zongmenModel:findBuildingDataByType(zongmenModel:getMountainId(),SLG_SYSTEM_TYPE.eYinXianTai)
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end

function UIRecruitControl:getNextRecruitTime()
local lastTime=UIRecruitModel:getRecruitLastTime()
local ntime=lastTime+self:getRecruitDuration()
return ntime
end

function UIRecruitControl:getRecruitLastTime()
local ntime=self:getNextRecruitTime()
local ctime=gameUtilityModel.getServerShortTime()
local time=ntime-ctime
return time
end

function UIRecruitControl:getRecruitDuration()
local cfgs=cfg_yinxiantaizmadjustconfig()
local attrCfg=cfgHelper.getdef1(cfg_yinxiantaizmconfig,'attr6')
local dis_list=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eJieYin)
local index=1
if dis_list and#dis_list>0 then
local ddata=dis_list[1]
local count=0
for i,v in ipairs(attrCfg)do
count=count+ddata.attrList[v]
end
for i,v in ipairs(cfgs)do
if count>=v.minval and count<=v.maxval then
index=i
end
end
if not index then
index=#cfgs
end
end
return cfgs[index].duration
end

function UIRecruitControl.on_item_changed(changeType,itemguid,itemid,oldVal,newVal)
if changeType==CHANGE_TYPE.eDelete or newVal<=oldVal then
return
end

local funcparam=itemsConfig.getConfig(itemid).funcparam
if funcparam then
local ftype=funcparam.type
if ftype==item_funtion_type.disciple then

if funcparam.autoActive then


local cur=UIDiscipleModel:checkDiscipleCount()
local max=UIRecruitModel:getZongMenPeopleMax()
if cur>=max then
return
end


local itemCount=bagModel.getItemCountById(itemid)
local use=funcparam.num or 1
if itemCount<use then
return
end


local getItemCount=newVal-oldVal
if getItemCount<use then

return
end

if not itemsLookup:checkUseItemCondition(itemid)then
return
end


local maxCount=max-cur
local canCount=math.floor(getItemCount/use)
if canCount>maxCount then
canCount=maxCount
end
local useCount=canCount*use
bagProtocolControl.req_use_item(itemid,useCount)
end
end
end
end


function UIRecruitControl:reqGetRecruitData()
socketManager:send_3_141()
end

function UIRecruitControl:reqRefreshRecruitTimes()
socketManager:send_3_142()
end

function UIRecruitControl:reqRecruit(way,ignore)
socketManager:send_3_143(way,ignore)
end

function UIRecruitControl:reqSelectDisciple(guid)
socketManager:send_3_144(guid)
end

function UIRecruitControl:reqGiveUpDisciple(guid)
socketManager:send_3_145(guid)
end

function UIRecruitControl:reqRecruitJZ(pos,wId,fguid,zy,lg)
socketManager:send_3_146(pos,wId,fguid,zy,lg)
end

function UIRecruitControl:reqSelectDiscipleJZ(fid,dzguid)
socketManager:send_3_147(fid,dzguid)
end

function UIRecruitControl:reqGiveUpDiscipleJZ(fid,dzguid)
socketManager:send_3_148(fid,dzguid)
end



function UIRecruitControl.recv_3_141(datas)
if initProControl.isDone()then
UIRecruitModel:setRecruitData(datas[1],datas[2],datas[3],datas[4],datas[5],datas[6],datas[10])

UIRecruitControl.refreshBuildHud()

if datas[3]>0 then

local dataRecruit=datas[4]
local len=#dataRecruit

local type=addSpeType.normal
TeZhiTuJianModel:checkIsHaveSpeCanActive(dataRecruit,type,len)
end

UIRecruitModel:setDzSeverPos(datas[6])
else
initData=datas
end
end

function UIRecruitControl.recv_3_142(times,lasttime)
local lastNum=UIRecruitModel:getRecruitTimes()
UIRecruitModel:setRecruitTimes(times,lasttime)
UIManager:invokeUIMethod('UIRecruitMainWin','Refresh')
UIManager:invokeUIMethod('UIRecruitSelectWin','RefreshTimes')
UIRecruitControl.nextRecruitTime=UIRecruitControl:getNextRecruitTime()

UIRecruitControl.refreshBuildHud()
if lastNum~=times then
chatGGControl.onYinXianTaiNumFresh(lastNum,times)
end
end

function UIRecruitControl.recv_3_143(way,len,arr,rlen,roundTimes)
UIRecruitModel:setRecruitDisciple(way,len,arr,roundTimes)
UIManager:invokeUIMethod('UIRecruitMainWin','Refresh')
local isSkipAnimation=UIRecruitControl:getSkipAnimationState()
local isShowAnimation=not isSkipAnimation
if isSkipAnimation then
for i=1,len do
local rcdata=arr[i]
local color=UIDiscipleModel:getDiscipleColor(rcdata.discipleInfo.discipleguid)
if color>eQualityColor.ePurple then
isShowAnimation=true
break
end


end
end

local win=UIManager:findActiveWindow('UIRecruitSelectWin')
if win then
UIManager:invokeUIMethod('UIRecruitSelectWin','Refresh',isShowAnimation)
UIManager:callWindowFunc('UIRecruitSelectWin','finishReq')
else
UIManager:invokeUIMethod('UIRecruitMainWin','ShowSelectUI')
end

UIRecruitControl.refreshBuildHud()

guildOrderController:checkAddAI_delay(GUILD_ORDER_TYPE.eQuicklyZhaoMu,1.2,true)


local type=addSpeType.normal
TeZhiTuJianModel:checkIsHaveSpeCanActive(arr,type,len)
webGLHelper:checkSubscribe(4)
end

function UIRecruitControl.recv_3_144(guid)
UIRecruitModel:setRecruitState(guid,1)
UIManager:invokeUIMethod('UIRecruitSelectWin','SetRecruitState',guid)
UIManager:invokeUIMethod('UIRecruitInfoWin','refreshWin',guid)
UIManager:invokeUIMethod('UIRecruitInfoWin','toNext',0)

AudioManager.playAudio(533)
end

function UIRecruitControl.recv_3_145(guid)
UIRecruitModel:setRecruitState(guid,-1)
UIManager:invokeUIMethod('UIRecruitSelectWin','SetRecruitState',guid)
UIManager:invokeUIMethod('UIRecruitInfoWin','refreshWin',guid)
UIManager:invokeUIMethod('UIRecruitInfoWin','toNext',0)
end

function UIRecruitControl.recv_3_146(datas)
UIRecruitModel:setFamilyData(datas[6])

local pos,world,guid,zy,lg=unpack(datas)
local jiazuzhaomuAgain=userActorSetting.get("jiazuzhaomuAgain",{})
jiazuzhaomuAgain[pos]={pos,world,tostring(guid),zy,lg}
userActorSetting.set("jiazuzhaomuAgain",jiazuzhaomuAgain)
userActorSetting.flush()

UIManager:invokeUIMethod('UIRecruitJZWin','resetPos',datas[1],true)
UIManager:invokeUIMethod('UIRecruitJZWin','refreshAgainBtn')
UIRecruitControl.refreshBuildHud()







end

function UIRecruitControl.recv_3_147(fid,dzguid)


UIRecruitModel:setFamilyDiscipleState(fid,dzguid,1)
local data=UIRecruitModel:getFamilyData(fid)
UIManager:invokeUIMethod('UIRecruitJZWin','resetPos',data.pos,true,true)
UIManager:invokeUIMethod('UIRecruitJZWin','refreshAgainBtn')
UIManager:invokeUIMethod('UIRecruitSelectWin','SetRecruitState',dzguid)
UIManager:invokeUIMethod('UIRecruitInfoWin','refreshWin',dzguid)
UIManager:invokeUIMethod('UIRecruitInfoWin','toNext',0)


UIRecruitModel:checkAndResetPos(dzguid)
end

function UIRecruitControl.recv_3_148(fid,dzguid)

UIRecruitModel:checkAndResetPos(dzguid)

UIRecruitModel:setFamilyDiscipleState(fid,dzguid,-1)
local data=UIRecruitModel:getFamilyData(fid)
UIManager:invokeUIMethod('UIRecruitJZWin','resetPos',data.pos,true,true)
UIManager:invokeUIMethod('UIRecruitJZWin','refreshAgainBtn')
UIManager:invokeUIMethod('UIRecruitSelectWin','SetRecruitState',dzguid)
UIManager:invokeUIMethod('UIRecruitInfoWin','refreshWin',dzguid)
UIManager:invokeUIMethod('UIRecruitInfoWin','toNext',0)
end

function UIRecruitControl:checkAnimArgs(itemId)
local itemCfg=itemsConfig.getConfig(itemId)
local animArgs=itemCfg.animArgs
if not animArgs then
return false
end
local playCdn=animArgs.playCdn
if not playCdn then
return false
end
local storyBehaviorName=animArgs.storyName
if not storyBehaviorName then
return false
end
return true,playCdn,storyBehaviorName
end

function UIRecruitControl:checkStartStory(itemId,backArgs)
local checkflag,playCdn,storyBehaviorName=self:checkAnimArgs(itemId)
if not checkflag then
return false
end
for i,v in ipairs(playCdn)do
local diziId=v
if not UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(diziId)then
return false
end
end









self.BackArgs=backArgs
storyAIManager:startStoryBehavior(storyBehaviorName,nil,nil)
return true
end

function UIRecruitControl:curStoryEndindCallBack(curItemId)



if self.BackArgs then
jumpManager:jump(self.BackArgs)
end
self.BackArgs=nil
end

function UIRecruitControl:nextStartStory(nextItemId)
if not nextItemId then
return false
end
local itemCfg=itemsConfig.getConfig(nextItemId)
local animArgs=itemCfg.animArgs
if not animArgs then
return false
end
local playCdn=animArgs.playCdn
if not playCdn then
return false
end
for i,v in ipairs(playCdn)do
local diziId=v
if not UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(diziId)then
return false
end
end
local storyBehaviorName=animArgs.storyName

storyAIManager:startStoryBehavior(storyBehaviorName,nil,nil)
return true
end


function UIRecruitControl:checkNextStartStory(curItemId,nextItemId)


local callback=function()
if self:nextStartStory(nextItemId)then
self.storyPlayFlag=true
else
self.storyPlayFlag=false
self:curStoryEndindCallBack(curItemId)
end
end
callback()

end

function UIRecruitControl:setBackArgs(backArgs)
self.BackArgs=backArgs
end

