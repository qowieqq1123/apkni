







def_class("UISystemZongMenTaYinWin1",UIWindowBase)









function UISystemZongMenTaYinWin1:bindComponents()

self.npcModel=UIObject.get(self,0)
self.cageback=UIObject.get(self,1)
self.dzModel=UIObject.get(self,2)
self.lightRoot=UIObject.get(self,3)
self.bgEffect1=UIObject.get(self,4)
self.cagefore=UIObject.get(self,5)
self.wait=UIObject.get(self,6)
self.work=UIObject.get(self,7)
self.failure=UIObject.get(self,8)
self.success=UIObject.get(self,9)
self.zlct=UIObject.get(self,10)
self.kzlx=UIObject.get(self,11)
self.checkBg=UIObject.get(self,12)
self.light_2=UIObject.get(self,13)
self.light_1=UIObject.get(self,14)
self.shadow_1=UIObject.get(self,15)
self.shadow_2=UIObject.get(self,16)
self.cageCloud_2=UIObject.get(self,17)
self.cageCloud_1=UIObject.get(self,18)
self.startBtn=UIButton.get(self,19)
self.npcSpeak=UIObject.get(self,20)
self.helpBtn=UIButton.get(self,21)
self.closeBtn=UIButton.get(self,22)
self.cageShadow=UIObject.get(self,23)
self.lifeList=UIObject.get(self,24)
self.thunderEffect=UIObject.get(self,25)
self.dzSpeak=UIObject.get(self,26)
self.dzEffect=UIObject.get(self,27)
self.lifeItem=UIObject.get(self,28)
self.checkOverlay=UIObject.get(self,29)
self.baseProgress=UIProgressBarAni.get(self,30)
self.gameBtn=UIButton.get(self,31)
self.npcSpeakTx=UILinkImageText.get(self,32)
self.costRoot=UIObject.get(self,33)
self.leastTx=UIText.get(self,34)
self.baseProgressBg=UIImage.get(self,35)
self.baseProgressSp=UIImage.get(self,36)
self.costNum=UIText.get(self,37)
self.costIcon=UIImage.get(self,38)
self.baseProgressImage=UIObject.get(self,39)
self.checkList=UIObject.get(self,40)
self.chTx=UIText.get(self,41)

self.startBtn:setButtonClick(function()self:onStartBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.gameBtn:setButtonClick(function()self:onGameBtn()end)
self.light={
self.light_1,
self.light_2,
}
self.shadow={
self.shadow_1,
self.shadow_2,
}
self.cageCloud={
self.cageCloud_1,
self.cageCloud_2,
}



end


function UISystemZongMenTaYinWin1:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.cageback);self.cageback=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.lightRoot);self.lightRoot=nil;
_UIObject_release(self.bgEffect1);self.bgEffect1=nil;
_UIObject_release(self.cagefore);self.cagefore=nil;
_UIObject_release(self.wait);self.wait=nil;
_UIObject_release(self.work);self.work=nil;
_UIObject_release(self.failure);self.failure=nil;
_UIObject_release(self.success);self.success=nil;
_UIObject_release(self.zlct);self.zlct=nil;
_UIObject_release(self.kzlx);self.kzlx=nil;
_UIObject_release(self.checkBg);self.checkBg=nil;
_UIObject_release(self.light_2);self.light_2=nil;
_UIObject_release(self.light_1);self.light_1=nil;
_UIObject_release(self.shadow_1);self.shadow_1=nil;
_UIObject_release(self.shadow_2);self.shadow_2=nil;
_UIObject_release(self.cageCloud_2);self.cageCloud_2=nil;
_UIObject_release(self.cageCloud_1);self.cageCloud_1=nil;
_UIObject_release(self.startBtn);self.startBtn=nil;
_UIObject_release(self.npcSpeak);self.npcSpeak=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.cageShadow);self.cageShadow=nil;
_UIObject_release(self.lifeList);self.lifeList=nil;
_UIObject_release(self.thunderEffect);self.thunderEffect=nil;
_UIObject_release(self.dzSpeak);self.dzSpeak=nil;
_UIObject_release(self.dzEffect);self.dzEffect=nil;
_UIObject_release(self.lifeItem);self.lifeItem=nil;
_UIObject_release(self.checkOverlay);self.checkOverlay=nil;
_UIObject_release(self.baseProgress);self.baseProgress=nil;
_UIObject_release(self.gameBtn);self.gameBtn=nil;
_UIObject_release(self.npcSpeakTx);self.npcSpeakTx=nil;
_UIObject_release(self.costRoot);self.costRoot=nil;
_UIObject_release(self.leastTx);self.leastTx=nil;
_UIObject_release(self.baseProgressBg);self.baseProgressBg=nil;
_UIObject_release(self.baseProgressSp);self.baseProgressSp=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.baseProgressImage);self.baseProgressImage=nil;
_UIObject_release(self.checkList);self.checkList=nil;
_UIObject_release(self.chTx);self.chTx=nil;
self.light=nil;
self.shadow=nil;
self.cageCloud=nil;
end















local _this=nil
local _pointCmp={
item=-1,
progress=0,
right=1,
wrong=2,
effect=3,
}
local _dzState={
idle=0,
standby=1,
move=2,
expose=3,
result=4,
challenge=5,
}
local _npcState={
idle=0,
challenge=1,
catch=2,
}
local _tweens={}
local _abName="ui/windows/systemzongmen/systemzongmen_tayin_atlas_pak.ab"



function UISystemZongMenTaYinWin1:onLoaded(...)
self:bindComponents()
_this=self

notifySystem:listenNotify(notifyConfig.onSystemZMTaYinChange,self.onSystemZMTaYinChange)
notifySystem:listenNotify(notifyConfig.onSystemZMFunctionNumChange,self.onSystemZMFunctionNumChange)
notifySystem:listenNotify(notifyConfig.onSystemZMDiscipleChange,self.onSystemZMDiscipleChange)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:listenNotify(notifyConfig.inNewbie,self.onNewbieChange)
end


function UISystemZongMenTaYinWin1:__delete()



self:stopWaitSpeakTick()
self:removeAllBT()
self:unbindComponents()
_this=nil

notifySystem:removelistener(notifyConfig.onSystemZMTaYinChange,self.onSystemZMTaYinChange)
notifySystem:removelistener(notifyConfig.onSystemZMFunctionNumChange,self.onSystemZMFunctionNumChange)
notifySystem:removelistener(notifyConfig.onSystemZMDiscipleChange,self.onSystemZMDiscipleChange)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:removelistener(notifyConfig.inNewbie,self.onNewbieChange)
end




function UISystemZongMenTaYinWin1:onShow(argtable,afterOnloaded)
self.serial=argtable.serial
self.infoData=systemZongMenModel:getInfoData(self.serial)
self.zmCfg=cfgHelper.get1(cfg_syssectconfig_get,self.infoData.id)
self:initView()


if self.infoData.tayin==0 then
self:waitGameState()
else
self:startGameState()
end

end


function UISystemZongMenTaYinWin1:onHide()

end




function UISystemZongMenTaYinWin1:onGameBtn()
local state=self.dzBT:getSharedVar("stateId")
if state~=_dzState.idle then
return
end

if self.update>0 then
if not self.click[self.update]then
self.click[self.update]=true
self:switchBtState("dzBT",_dzState.challenge)
end
else
self:exposeDisciple()
end
end


function UISystemZongMenTaYinWin1:onStartBtn()
local cost=self.zmCfg.tayin[1]
local id=nil
for i,v in ipairs(cost)do
local count=itemsModel.getCount(v[1])
if count<v[2]then
id=v[1]
break
end
end
if id==nil then
local curr=systemZongMenModel:getGlobalNum(systemZongMenFuncType.eTaYin)
if curr<self.maxNum then
if not self.state and not self.ready then

local callback=function()
systemZongMenController:req_rubbing_start(self.serial)
self.ready=true
end
local args={
info=ruleTipsImageGroup.eTaYin,
callback=callback,
btntxt="开始拓印",
isShowCloseBtn=true
}
UIManager:showWindow("UIRuleTipsImageWin",args)
else

end
else
UIManager.error("剩余次数不足")
end
else
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(id)))
gainControl:showGainWin(id)
end
end


function UISystemZongMenTaYinWin1:onHelpBtn()
local d={}
d.mode=3
d.title="规则介绍"
d.name='systemZongMen_tayin_%d'
UIManager:showWindow('UIRuleWin',d)
end


function UISystemZongMenTaYinWin1:onCloseBtn()
self:closeSelf()
end

function UISystemZongMenTaYinWin1.onSystemZMTaYinChange(flag,serial)
if _this.serial==serial then
if flag==1 then
_this:startGameState()
end
end
end

function UISystemZongMenTaYinWin1.onSystemZMFunctionNumChange(funcType)
if funcType==systemZongMenFuncType.eTaYin then
if not _this.state then
local curr=systemZongMenModel:getGlobalNum(systemZongMenFuncType.eTaYin)
_this.leastTx:setText(FMT.fmt("剩余次数 : <color=F7F7F7>{0}</color>",_this.maxNum-curr))
end
end
end

function UISystemZongMenTaYinWin1.onSystemZMDiscipleChange(serial,discipleGuid,oldGuid)
if _this.serial==serial then
if discipleGuid>int64.zero then
_this.oldGuid=nil
_this:refreshDisciple()
elseif not systemZongMenController.resulting then
_this.oldGuid=nil
_this:closeSelf()
else
_this.oldGuid=oldGuid
end
end
end

function UISystemZongMenTaYinWin1.on_money_changed(mType,lastVal,val)
if mType==_this.cost[1]then
if _this.state==false then
_this.costNum:setText(FMT.fmt("{0}/{1}",val,_this.cost[2]))
_this.winlua:ForceLayoutRect(_this.costRoot:getID())
end
end
end

function UISystemZongMenTaYinWin1.on_item_changed(changeType,itemguid,itemid,lastcount,itemcount)
if itemid==_this.cost[1]then
if _this.state==false then
_this.costNum:setText(FMT.fmt("{0}/{1}",itemcount,_this.cost[2]))
_this.winlua:ForceLayoutRect(_this.costRoot:getID())
end
end
end

function UISystemZongMenTaYinWin1:initView()
self:refreshDisciple()
self.maxNum=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"tayin","day_num")
self.dzWalkCfg=cfgHelper.getdef(cfg_tayingamelibconfig,'dzWalk')
self.itemWidth=cfgHelper.getdef(cfg_tayingamelibconfig,'itemWidth')
self.checkScaleCfg=cfgHelper.getdef(cfg_tayingamelibconfig,'itemScale')
local cost=self.zmCfg.tayin[1]
self.cost=cost[1]
self.costIcon:setIcon(iconHelper.getIconName(self.cost[1]),false)
end

function UISystemZongMenTaYinWin1:refreshDisciple()
local discipleData=UIDiscipleModel:getDiscipleData(self.infoData.disciple_guid)
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(discipleData)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo,1)
local modelCmp=self.dzModel:getID()
self.canFace=spineHelper.enableChangeFace(modelParams.body)
self.winlua:SetChildUIModelShowTarget(modelCmp,modelParams.body,0.86,modelParams.componets,eAnimationID.stand,false,false,0)
self.winlua:SetChildUIModelShowFlipX(modelCmp,true)

local mlStr=FMT.fmt("<color=#7D3B17>聪慧：</color>{0}",discipleData.attrList[DISCIPLE_BASE_ATTR_TYPE.eCongHui])
self.chTx:setText(mlStr)
end

function UISystemZongMenTaYinWin1:waitGameState()
self:removeAllBT()
self.state=false
self.wait:setActive(true)
self.work:setActive(false)
self.dzModel:setChildAnchoredPos(-420,-200)
self.dzModel:setChildModelAnimationState(eAnimationID.stand)
self.lifeNum=0
self:refreshLife()
self:resetCage()
local num=itemsModel.getCount(self.cost[1])
self.costNum:setText(FMT.fmt("{0}/{1}",num,self.cost[2]))
self.winlua:ForceLayoutRect(self.costRoot:getID())
local curr=systemZongMenModel:getGlobalNum(systemZongMenFuncType.eTaYin)
self.leastTx:setText(FMT.fmt("剩余次数 : <color=F7F7F7>{0}</color>",self.maxNum-curr))

self:stopWaitSpeakTick()
self.npcSpeak:setActive(false)
self.waitSpeakTick=self:setTimer(5,0,function()
local show=self.winlua:GetChildActiveSelf(self.npcSpeak:getID())
if show then
self.npcSpeak:setActive(false)
else
local job=UIDiscipleModel:getDiscipleJob(self.infoData.disciple_guid)
local list=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,job,"tayin_unstart_speak")
local speak=list[math.random(1,#list)]
self.npcSpeak:setActive(true)



self.npcSpeakTx:setText(speak)
self.winlua:ForceLayoutRect(self.npcSpeak:getID())
end
end)

self:showLightAnimation(false)
end

function UISystemZongMenTaYinWin1:stopWaitSpeakTick()
if self.waitSpeakTick then
self:stopTimerByID(self.waitSpeakTick)
self.waitSpeakTick=nil





end
end

function UISystemZongMenTaYinWin1:startGameState(force)
if self.state then
return
end

self.needNewbie=false
if NEWBIE_LUA_FUNC_NAME.TaYinGameNewBie1 then
self.needNewbie=not newbieModel.isFinish(NEWBIE_LUA_FUNC_TYPE[NEWBIE_LUA_FUNC_NAME.TaYinGameNewBie1])
end

self.state=true
self.ready=false
self.wait:setActive(false)
self.work:setActive(true)


self.lifeNum=cfgHelper.getdef(cfg_tayingamelibconfig,'life')
self.lifeCnt=self.lifeNum
self.challengeNum=self.zmCfg.tayinGame[1]
self.challengeNum=math.random(self.challengeNum[1],self.challengeNum[2])
local temp={}
local tempX={}
self.challengePos={}
self.challenges={}
for i=self.dzWalkCfg[1]+self.dzWalkCfg[3],self.dzWalkCfg[2],self.dzWalkCfg[3]do
table.insert(temp,i)
end
local challengeLib=self.zmCfg.tayinGame[2]
for i=1,self.challengeNum do
local r=math.random(1,#temp)
local x=table.remove(temp,r)
table.insert(tempX,x)

local t=math.random(1,#challengeLib)
table.insert(self.challenges,challengeLib[t])
end
table.sort(tempX)
for i,v in ipairs(tempX)do
table.insert(self.challengePos,{v,-200})
end

local ch=UIDiscipleModel:getDiscipleBaseAttr(self.infoData.disciple_guid,DISCIPLE_BASE_ATTR_TYPE.eCongHui)
self.itemScale=1
for i,v in ipairs(self.checkScaleCfg)do
if ch>=v[1]then
self.itemScale=v[2]
else
break
end
end


self.lifeList:setChildLayoutGroupCreateItems(0)
self:resetCage()
self:endChallenge()
self:showLightAnimation(false)
self:stopWaitSpeakTick()


local args1={
stateId=_dzState.standby,
widget=self.winlua,
speak="",

result=-1,
dzCmp=self.dzModel:getID(),
speakCmp=self.dzSpeak:getID(),
shieldCmp=self.dzEffect:getID(),
thunderCmp=self.thunderEffect:getID(),
pos={self.dzWalkCfg[1],-200},
speed=self.dzWalkCfg[4],
cageBCmp=self.cageback:getID(),
cageFCmp=self.cagefore:getID(),
cageCloud1=self.cageCloud_1:getID(),
cageCloud2=self.cageCloud_2:getID(),
cageShadow=self.cageShadow:getID(),
canFace=self.canFace,
}
self.dzBT=behaviorManager:addBehaviorTree("bt_ui_systemzm_disciple",nil,true,args1,true)

local args2={
stateId=_npcState.idle,
widget=self.winlua,
speak="",
npcCmp=self.npcModel:getID(),
kzlxCmp=self.kzlx:getID(),
zlctCmp=self.zlct:getID(),
effectCmp=self.lightRoot:getID(),
bgCmp=self.bgEffect1:getID(),
}
self.npcBT=behaviorManager:addBehaviorTree("bt_ui_systemzm_npc",nil,true,args2,true)
end

function UISystemZongMenTaYinWin1:removeAllBT()
if self.dzBT then
behaviorManager:removeBehaviorTree(self.dzBT)
self.dzBT=nil
end
if self.npcBT then
behaviorManager:removeBehaviorTree(self.npcBT)
self.npcBT=nil
end
end

function UISystemZongMenTaYinWin1:switchBtState(btName,stateId)

local bt=self[btName]
bt:setSharedVar("stateId",stateId)
bt:broke()
bt:reset()
end

function UISystemZongMenTaYinWin1:setDZPos(bt)
local pos=table.remove(self.challengePos,1)

bt:setSharedVar("pos",pos)
end

function UISystemZongMenTaYinWin1:refreshLife()
self.lifeList:setChildLayoutGroupCreateItems(self.lifeNum,function(index)
local item=self.lifeList:getChildLayoutGroupGridItem(index-1)
item:SetChildCSImageIcon(0,iconHelper.getIconName(self.cost[1]),false)
end)
end

function UISystemZongMenTaYinWin1:burnLife()
local lifes=self.lifeList:getChildLayoutGroupGridList()
for i=1,lifes.Count do
if i>self.lifeNum then
local item=lifes[i-1]
item:SetChildActive(0,false)
item:SetChildShowEffect(1,10217,true)
end
end
end























function UISystemZongMenTaYinWin1:resetCage()
for i,v in ipairs(self.cageCloud)do
v:setActive(false)
end
self.cageShadow:setActive(false)
self.cagefore:setActive(false)
self.cageback:setActive(false)
end

function UISystemZongMenTaYinWin1:onResult(result)


self.dzBT:setSharedVar("result",result)
local dzSrate=self.dzBT:getSharedVar("stateId")

if dzSrate==_dzState.idle then
self:switchBtState("dzBT",_dzState.result)
end
end

function UISystemZongMenTaYinWin1:calculateCagePos(bt)
local dzPos2=self.dzModel:getChildAnchoredPosition()
local dzPos1=dzPos2+Vector2.up*200
dzPos2=dzPos2-Vector2.up*25

bt:setSharedVar("cagePos1",mathHelper.convertVectorToArray(dzPos1))
bt:setSharedVar("cagePos2",mathHelper.convertVectorToArray(dzPos2))
end

function UISystemZongMenTaYinWin1:calculateFocusPos(bt,cmp,keyR,keyS)
local dzPos=self.dzModel:getChildAnchoredPosition()
local lightPos=self.winlua:GetChildAnchoredPosition(cmp)
local dir=Vector2.Normalize(lightPos-dzPos)
local temp=dir.x<0 and-1 or 1
local angle0=(Vector2.Angle(Vector2.up*-1,dir)-180)
local angle1=angle0*temp

bt:setSharedVar(keyR,{0,0,angle1})
bt:setSharedVar(keyS,math.abs(angle0)/45+1)
end

function UISystemZongMenTaYinWin1:setBTSpeak(bt,col)
local guid=self.infoData.disciple_guid>int64.zero and self.infoData.disciple_guid or self.oldGuid

local job=UIDiscipleModel:getDiscipleJob(guid)
local list=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,job,col)
local speak=list[math.random(1,#list)]
bt:setSharedVar("speak",speak)
end

function UISystemZongMenTaYinWin1:startChallenge()





























self.checkOverlay:setActive(self.needNewbie)










self.challengeTimer=self:setTimer(0.02,0,function()
self:onChallengeTimerUpdate(0.02)
end)
end

function UISystemZongMenTaYinWin1:showChallenge()
local no=self.challengeNum-#self.challengePos
local challengeId=self.challenges[no]
local challengeCfg=cfgHelper.get1(cfg_tayingamelibconfig_get,challengeId)
local num=math.random(challengeCfg.num[1],challengeCfg.num[2])
local temp={}
for i=1,#challengeCfg.points do
table.insert(temp,i)
end
self.challengePoints={}
local pointSize=self.itemWidth*self.itemScale
for i=1,num do
local r=math.random(1,#temp)
r=table.remove(temp,r)
local pos=challengeCfg.points[r]
local progress={(pos[1]-pointSize/2)/challengeCfg.length,(pos[1]+pointSize/2)/challengeCfg.length}
local point={
pos=pos,
progress=progress,
}
table.insert(self.challengePoints,point)
end

table.sort(self.challengePoints,function(a,b)
return a.pos[1]<b.pos[1]
end)

self.checkBg:setActive(true)
self.checkOverlay:setActive(true)
self.checkList:setChildLayoutGroupCreateItems(#self.challengePoints,function(index)
local item=self.checkList:getChildLayoutGroupGridItem(index-1)
local pointData=self.challengePoints[index]
item:SetChildAnchoredPos(_pointCmp.item,pointData.pos[1],pointData.pos[2])
item:SetChildProgressValue(_pointCmp.progress,0,10000)
item:SetChildActive(_pointCmp.right,false)
item:SetChildActive(_pointCmp.wrong,false)
item:SetChildNewBieComponentId(_pointCmp.item,FMT.fmt("UISystemZongMenTaYinWin1.#checkList_item{0}",index))
end)

self.pTime=0
self.pDuration=challengeCfg.duration
self.pPause=0
self.update=0
self.click={}

self.winlua:SetChildWidgetMaterialFloat(self.baseProgressImage:getID(),"_GrowUp",0)
end

function UISystemZongMenTaYinWin1:onChallengeTimerUpdate(deltaTime)









local state=self.dzBT:getSharedVar("stateId")
if state~=_dzState.idle then
return
end

if self.pTime>=self.pDuration then

self:endChallenge()
self:stopChallengeTimer()

if#self.challengePos>0 then
self:switchBtState("dzBT",_dzState.move)
else

systemZongMenController:req_rubbing_end(self.serial,self.lifeNum)
end
end

local oPTime=self.pTime
local oProgress=Mathf.Clamp(oPTime/self.pDuration,0,1)

local nPTime=self.pTime+deltaTime
local progress=Mathf.Clamp(nPTime/self.pDuration,0,1)
local finish=progress>=1
local needStop=false
local update=0
local list=self.checkList:getChildLayoutGroupGridList()

for i=1,list.Count do
local item=list[i-1]
local pointData=self.challengePoints[i]
local range=pointData.progress
if progress>=range[1]and progress<=range[2]then
local value=math.floor((progress-range[1])/(range[2]-range[1])*10000)
item:SetChildProgressValue(_pointCmp.progress,value,10000)
update=i
elseif self.update==i and progress>range[2]then
item:SetChildProgressValue(_pointCmp.progress,10000,10000)
end

if self.needNewbie then
local midProgress=(range[1]+range[2])/2
if oProgress<midProgress and progress>=midProgress then
local triggerName=NEWBIE_LUA_FUNC_NAME[FMT.fmt('TaYinGameNewBie{0}',i)]
if triggerName then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,triggerName)
needStop=true

local value=math.floor((midProgress-range[1])/(range[2]-range[1])*10000)
item:SetChildProgressValue(_pointCmp.progress,value,10000)
nPTime=midProgress*self.pDuration
end
end
end
end
self.pTime=nPTime


self.winlua:SetChildWidgetMaterialFloat(self.baseProgressImage:getID(),"_GrowUp",progress)


if self.update>0 and update<=0 then
local click=self.click[self.update]
if not click then
local checkItem=list[self.update-1]
checkItem:SetChildImageExGray(4,true)
self:exposeDisciple()
end
end

self.update=update

if needStop then
self:stopChallengeTimer()
end
end

function UISystemZongMenTaYinWin1:fastProgressTimer()
local pointData=self.challengePoints[self.update]
self.pTime=pointData.progress[2]*self.pDuration
end

function UISystemZongMenTaYinWin1:startChallengeTimer()
if not self.challengeTimer then
self.challengeTimer=self:setTimer(0.02,0,function()
self:onChallengeTimerUpdate(0.02)
end)
end
end

function UISystemZongMenTaYinWin1:stopChallengeTimer()
if self.challengeTimer then
self:stopTimerByID(self.challengeTimer)
self.challengeTimer=nil
end
end

function UISystemZongMenTaYinWin1:exposeDisciple()
self.lifeNum=self.lifeNum-1
self:switchBtState("dzBT",_dzState.expose)
if self.lifeNum<=0 then
systemZongMenController:req_rubbing_end(self.serial,self.lifeNum)
self:stopChallengeTimer()
end
end

function UISystemZongMenTaYinWin1:lightChallengePoint()
local checkItem=self.checkList:getChildLayoutGroupGridItem(self.update-1)
checkItem:SetChildShowEffect(_pointCmp.effect,10219,true)
checkItem:SetChildProgressValue(_pointCmp.progress,10000,10000)
end

function UISystemZongMenTaYinWin1:endChallenge()

self.checkList:setChildLayoutGroupCreateItems(0,nil)
self.checkBg:setActive(false)
self:showLightAnimation(false)

self.winlua:SetChildActive(self.bgEffect1:getID(),true)
self.winlua:SetChildActive(self.zlct:getID(),false)
self.winlua:SetChildActive(self.kzlx:getID(),false)
end

function UISystemZongMenTaYinWin1:showLightAnimation(show)
for i,v in ipairs(self.light)do
v:setActive(show)
v:setScale(Vector3.New(0,0,1))
end
for i,v in ipairs(self.shadow)do
v:setActive(false)
end
self.lightRoot:setChildAnimatorParameter("show","bool",tostring(show))
self.lightRoot:setChildAnimatorParameter("tTrigger","trigger","")
end

function UISystemZongMenTaYinWin1.onNewbieChange(newbieid,flag)
local itemsList=_this.checkList:getChildLayoutGroupGridList()
if itemsList.Count>0 then
local lastId=nil
for i=1,itemsList.Count do
local triggerName=NEWBIE_LUA_FUNC_NAME[FMT.fmt('TaYinGameNewBie{0}',i)]
if triggerName then
local id=NEWBIE_LUA_FUNC_TYPE[triggerName]
lastId=id
if id==newbieid and flag==false then
_this:startChallengeTimer()
end
end
end

if lastId==newbieid and flag==false then
_this.needNewbie=false
_this.checkOverlay:setActive(false)
end
end
end
