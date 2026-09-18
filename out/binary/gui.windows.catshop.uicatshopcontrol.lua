

UICatShopControl=gameState.addListener(fullScreenUI.create())

function UICatShopControl:onAppStart()
socketManager:register_receiver(3,229,self.recv_3_229)
socketManager:register_receiver(3,230,self.recv_3_230)
socketManager:register_receiver(3,231,self.recv_3_231)

socketManager:register_receiver(3,88,self.recv_3_88)

local menulist=
{
{tabType=FULL_TAB_TYPE.eCatShop,callback=function(...)self:showCatShopWindow(...)end,
sendCallback=function()end},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eCatShop,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)

local movecfg=cfgHelper.get2(cfg_catsalesmanbasicconfig_get,1,'move_pos')
self.enterPos=movecfg[1]
self.sellPos=movecfg[2]
self.leavePos=movecfg[3]

self.catShopState=0
end

function UICatShopControl:showCatShopWindow(argstable)
local args=
{
tabType=FULL_TAB_TYPE.eCatShop,
showBg=true,
viewNames={'UICatShopWin'},
viewArgs={['UICatShopWin']=argstable},
}
self:showUI(args)
end

function UICatShopControl:onEnterState(isReconnect)
if isReconnect then
return
end
self.data={items={}}
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
end

function UICatShopControl:onLeaveState(isReconnect)
if isReconnect then
return
end
self.data=nil
self.shopGUID=nil
self.currShopGUID=nil
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
end

function UICatShopControl.on_home_event(etype)
if etype==homeEvent.eEnterHome then
UICatShopControl:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
UICatShopControl:onLeaveHome()
end
end

function UICatShopControl:onEnterHome()
UICatShopControl:checkAndSetShowFlag()
if self:checkReveiveAll()then
return
end
if not self.showCatShopFlag then
self:checkAndShowEvent()
else
self:creatCatShop(self.sellPos,2)
self.currShopGUID=self.shopGUID
end

notifySystem:listenNotify(notifyConfig.onNewDay5am,self.on_new_day_5_am)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
end

function UICatShopControl:onLeaveHome()
if self.shopBT then
behaviorManager:removeBehaviorTree(self.shopBT)
self.shopBT=nil
end
self.shopGUID=nil
notifySystem:removelistener(notifyConfig.onNewDay5am,self.on_new_day_5_am)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
end

function UICatShopControl.on_new_day_5_am(is_login)
if not is_login then
UICatShopControl:closeCatShopWin()
UICatShopControl:catShopLeave()
UICatShopControl:setShowFlag(false)
UICatShopControl:checkAndShowEvent()
end
end

function UICatShopControl.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eCatSalesMan then
UICatShopControl:checkAndShowEvent()
end
end

function UICatShopControl:getCatShopState()
return self.catShopState
end

function UICatShopControl:checkAndSetShowFlag()
local time=userActorSetting.get('CAT_SHOT_FLAG_TIME',nil)
if not time then
self:setShowFlag(false)
return
end
local ctime=timeHelper.getServerLongTime()
local rtime=timeHelper.getTodayXXStamp(5,0,0)
if ctime>=rtime then
if time>=rtime then
self:setShowFlag(true)
return
end
else
local ltime=rtime-86400
if time>=ltime then
self:setShowFlag(true)
return
end
end
self:setShowFlag(false)
end

function UICatShopControl:recordFlagTime()
local ctime=timeHelper.getServerLongTime()
userActorSetting.set('CAT_SHOT_FLAG_TIME',ctime)
userActorSetting.flush()
end

function UICatShopControl:clearFlagTime()
self.showCatShopFlag=false
userActorSetting.set('CAT_SHOT_FLAG_TIME',nil)
userActorSetting.flush()
end

function UICatShopControl:setShowFlag(flag)
self.showCatShopFlag=flag
end

function UICatShopControl:checkAndShowEvent()
if not self.showCatShopFlag then
if self:isCanShowEventWin()then
self:setShowFlag(true)
self.catShopState=1
self:showEventWin()
end
end
end

function UICatShopControl:isCanShowEventWin()
if self:isReveive()then
return false
end
if not systemModel.isOpen(SYSTEM_DEFINE.eCatSalesMan)then
return false
end
if zongmenModel:getMountainId()~=mapIdType.zhufeng then
return false
end
return true
end

function UICatShopControl:showEventWin()
local cfg=cfgHelper.get1(cfg_catsalesmanbasicconfig_get,1)
local args={
iconName=cfg.tips_icon,
title=cfg.tips_name,
content=cfg.tips_content,
time=cfg.tips_time,
callback=function(isClick)
self:recordFlagTime()
if isClick then
self:showCatShop()
else
self:catShopEnter()
end
end,
}
msgWinControl:addMsgWin(msgWinType.eTopEventWin,args,{delay=cfg.event_time})
end

function UICatShopControl:showCatShop()
local cp=_MapManager.ToVector3Int(self.sellPos[1],self.sellPos[2],0)
local pos=_MapManager.GetCellCenterWorld(mapIdType.zhufeng,cp,mapLayer.Data)
isometricMapSystem:moveCameraToPositionEx(mapIdType.zhufeng,pos,true,function()
self:catShopEnter()
end)
end

function UICatShopControl:catShopEnter()
self:creatCatShop(self.enterPos,1)
end

function UICatShopControl:handleDock()
self.currShopGUID=self.shopGUID
end

function UICatShopControl:getCurrShopBody()
local check1=false
local check2=true
for k,v in pairs(self.data.items)do
if v.accept then
check1=true
else
check2=false
end
end
local cfg=cfgHelper.get1(cfg_catsalesmanbasicconfig_get,1)
local body=cfg.scene_model
if check2 then
return body[3]
end
if check1 then
return body[2]
end
return body[1]
end

function UICatShopControl:freshBody()
local body=self:getCurrShopBody()
if self.shopGUID and body~=self.shopBody then
self.shopBody=body


local escale=isometricMapSystem:getModelScale(body)
local ent=_EntityManager:GetEntity(self.shopGUID)
ent:Mount(body,nil,'guadian',escale,Vector3.New(0,0,2),nil)
end
end

function UICatShopControl:creatCatShop(pos,state)
self.catShopState=2
if self.shopGUID then



return
end
self.shopBody=self:getCurrShopBody()
local scfg=cfgHelper.get1(cfg_catsalesmanbasicconfig_get,1)
local catModel=scfg.scene_cat
local scale=isometricMapSystem:getModelScale(catModel)
local tpos=_MapManager.ToVector3Int(pos[1],pos[2],0)
local guid=isometricMapSystem:createRoleEntity(objectType.eCatShop,mapIdType.zhufeng,0,catModel,nil,SortingLayers.ITSky1,scale,tpos)
local ent=_EntityManager:GetEntity(guid)
local escale=isometricMapSystem:getModelScale(self.shopBody)
ent:Mount(self.shopBody,nil,'guadian',escale,Vector3.New(0,0,2),nil)
self.shopGUID=guid
local cfg=cfgHelper.get1(cfg_catshopaiconfig_get,1)
local initData={
sellPos=self.sellPos,
leavePos=self.leavePos,
sepaktime=cfg.speak_time,
speakrate=cfg.speak_rate,
enterSpeed=cfg.enter_speed,
leaveSpeed=cfg.leave_speed,
stateId=state,
stId=guid,
}
self.shopBT=behaviorManager:addBehaviorTree('bt_cat_shop',{stId=guid},true,initData)
UICatShopControl:addRewardHUD()
end

function UICatShopControl:catShopLeave()
self.currShopGUID=nil
self.shopGUID=nil
self.catShopState=3
if self.shopBT then
self.shopBT:broke()
self.shopBT:setSharedVar('stateId',3)
self.shopBT:reset()
end
UICatShopControl:removeRewardHUD()
end

function UICatShopControl:handleLeave(bt)
local stId=bt:getSharedVar('stId')
_MapManager.RemoveTilemapObject(stId)
behaviorManager:removeBehaviorTree(bt)
self.shopBT=nil
end

function UICatShopControl:getCatSpeakText(bt,tkey,ttype)
local cfg=cfgHelper.get1(cfg_catshopaiconfig_get,1)
local stype=self.data.isMul and 2 or 1
local speakArr
if ttype==1 then
speakArr=cfg.enter_speak[stype]
elseif ttype==2 then
speakArr=cfg.speak[stype]
elseif ttype==3 then
speakArr=cfg.leave_speak[stype]
elseif ttype==4 then
speakArr=cfg.ui_speak[stype]
end
if speakArr then
bt:setSharedVar(tkey,speakArr[math.random(1,#speakArr)])
end
end

function UICatShopControl:showCatShopWin(guid,isWarning)
guid=guid or self.shopGUID
if guid then

self:showCatShopWindow()
return true
end
if isWarning then
UIManager.error('猫货郎尚未到达宗门，请稍候')
end
return false
end

function UICatShopControl:closeCatShopWin()

if fullScreenUI.checkFull(UICatShopControl)then
UICatShopControl:closeUI()
end
end



function UICatShopControl:setDatas(datas,receive)
local items={}
local isMul=false
if datas then
for i,v in ipairs(datas)do
v.accept=v.is_accept==1
items[v.idx]=v
if v.times>1 then
isMul=true
end
end
end
self.data.items=items
self.data.isReveive=receive==1
self.data.isMul=isMul
end

function UICatShopControl:getDatas()
return self.data.items
end

function UICatShopControl:getData(index)
return self.data.items[index]
end

function UICatShopControl:isReveive()
return self.data.isReveive
end

function UICatShopControl:setReveiveState(state)
self.data.isReveive=state
end

function UICatShopControl:isComplete(checkAll)
for k,v in pairs(self.data.items)do
if(checkAll or v.extra_id==0)and not v.accept then
return false
end
end
return true
end

function UICatShopControl:isCanExchange(index,wraning)
local data=self:getData(index)
if data then
if itemsModel.getCount(data.item_id)>=data.item_num then
return true
else
if wraning then
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(data.item_id)))
end
end
end
return false
end

function UICatShopControl:getRewards()
local cfg=cfgHelper.get1(cfg_catsalesmanbasicconfig_get,1)
local level=zongmenModel:getLevel()
for i,v in ipairs(cfg.extra_gifts)do
if level>=v[1][1]and level<=v[1][2]then
return v[2]
end
end
return{}
end

function UICatShopControl:checkReddot()
if self.shopGUID~=nil then
local state=UICatShopControl:getCatShopState()
if state==2 then
local isOver=true
for k,v in pairs(self.data.items)do
if v.extra_id==0 and not v.accept then
isOver=false
if itemsModel.getCount(v.item_id)>=v.item_num then
return true
end
end
end
if isOver then
if not UICatShopControl:isReveive()then
return true
end
end
end
end
return false
end



function UICatShopControl:reqExchange(index)
socketManager:send_3_230(index)
end

function UICatShopControl:reqReceive()
socketManager:send_3_231()
end

function UICatShopControl:reqOneKeyReceive(len,arr,assistant)
socketManager:send_3_88(len,arr,assistant)
end



function UICatShopControl.recv_3_229(len,infos,level,receive)
UICatShopControl:setDatas(infos,receive)
end

function UICatShopControl.recv_3_230(index)
local data=UICatShopControl:getData(index)
if data then
data.accept=true
data.is_accept=1
end
UIManager:invokeUIMethod('UICatShopWin','refresh')
UICatShopControl:freshBody()

UICatShopControl:addRewardHUD()

AudioManager.playAudio(503)

UICatShopControl:checkReveiveFinish()
end

function UICatShopControl.recv_3_231()
UICatShopControl:setReveiveState(true)


UIManager:invokeUIMethod('UICatShopWin','refresh')
local rewards=UICatShopControl:getRewards()
if#rewards>0 then
local showRW={}
for i,v in ipairs(rewards)do
showPrizeControl.insertTemp(showRW,nil,v[1],v[2])
end
showPrizeControl.showWindow(showRW,function()

UICatShopControl:checkReveiveFinish()
end)
else

UICatShopControl:checkReveiveFinish()
logErr('未获取到猫货郎额外奖励')
end
UICatShopControl:removeRewardHUD()
end

function UICatShopControl.recv_3_88(len,arr,assistant,accept)
if len<=0 then
return
end

local costItemRecord={}
local func=function(data)
local count=costItemRecord[data.item_id]or 0
count=count+data.item_num
costItemRecord[data.item_id]=count
end
UICatShopControl.costItemRecord=costItemRecord

for i,v in ipairs(arr)do
local data=UICatShopControl:getData(v)
if data then
data.accept=true
data.is_accept=1

func(data)
end
end

local datas=UICatShopControl:getDatas()
local count=0
for k,v in pairs(datas)do
if not v.accept then
if v.extra_id>0 then
local excfg=cfgHelper.get1(cfg_catsalesmanextraconfig_get,v.extra_id)
if UICatShopControl:checkCatShopExtraCondition(excfg.condition)then
count=count+1
end
else
count=count+1
end
end
end
UICatShopControl.unFinishCount=count

UIManager:invokeUIMethod('UICatShopWin','refresh')
UICatShopControl:freshBody()

if accept==1 then
UICatShopControl:setReveiveState(true)
UICatShopControl:removeRewardHUD()
else
UICatShopControl:addRewardHUD()
end

UICatShopControl:checkReveiveFinish()
end

function UICatShopControl:getCatShopAutoBuyInfo()
local datas=UICatShopControl.costItemRecord
local list={}
if datas then
for k,v in pairs(datas)do
table.insert(list,{itemid=k,num=v})
end
end
local count=UICatShopControl.unFinishCount or 0
UICatShopControl.costItemRecord=nil
UICatShopControl.unFinishCount=nil
return list,count
end

function UICatShopControl:checkReveiveAll()
if not self:isReveive()then
return false
end
if not self:isComplete(true)then
return false
end
return true
end

function UICatShopControl:checkReveiveFinish()
if not self:checkReveiveAll()then
return
end
self:closeCatShopWin()
self:catShopLeave()
end



function UICatShopControl:addRewardHUD()
if not self.shopGUID then
return
end
if not UICatShopControl:isComplete()then
return
end
if self.data.isReveive then
return
end
local offset=_MapManager.GetObjectHeadOffset(self.shopGUID)
self.rewardHUD=hudControl:addHUD(INSTANCE_TYPE.eDiscipleState,self.shopGUID,offset,true,true,function(id)
if self.rewardHUD==id then
local widget=hudControl:getHUDWidget(id)
widget:SetChildCSImageSprite(0,globalABLookup.hud_atlas,'icon_fangshigx')
widget:SetChildButtonClick(1,function()
UICatShopControl:showCatShopWin(self.shopGUID)
end)
else
hudControl:removeHUD(id)
end
end)
end

function UICatShopControl:removeRewardHUD()
if self.rewardHUD then
hudControl:removeHUD(self.rewardHUD)
self.rewardHUD=nil
end
end



function UICatShopControl:checkCatShopExtraCondition(condition)
for i,v in ipairs(condition)do
if v[1]==1 then
if not rechargeModel:checkCardActive(v[2])then
return false
end
end
end
return true
end
