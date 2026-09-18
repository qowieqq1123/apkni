







def_class("UIDiscipleJingJieBrokeWin",UIWindowBase)









function UIDiscipleJingJieBrokeWin:bindComponents()

self.doingRoot=UIObject.get(self,0)
self.successRoot=UIObject.get(self,1)
self.failRoot=UIObject.get(self,2)
self.closeTips=UIText.get(self,3)
self.talkObj=UIObject.get(self,4)
self.successEffect1=UIObject.get(self,5)
self.successEffect2=UIObject.get(self,6)
self.chiyaoEffect=UIObject.get(self,7)
self.bloodProgress=UIProgress.get(self,8)
self.prepareRoot=UIObject.get(self,9)
self.attrGrid=UIObject.get(self,10)
self.talkDesc=UIText.get(self,11)
self.thunderHurt=UIText.get(self,12)
self.fuLuItemPanel=UIObject.get(self,13)
self.fuLuItem=UIBaseItem.get(self,14)



end


function UIDiscipleJingJieBrokeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.doingRoot);self.doingRoot=nil;
_UIObject_release(self.successRoot);self.successRoot=nil;
_UIObject_release(self.failRoot);self.failRoot=nil;
_UIObject_release(self.closeTips);self.closeTips=nil;
_UIObject_release(self.talkObj);self.talkObj=nil;
_UIObject_release(self.successEffect1);self.successEffect1=nil;
_UIObject_release(self.successEffect2);self.successEffect2=nil;
_UIObject_release(self.chiyaoEffect);self.chiyaoEffect=nil;
_UIObject_release(self.bloodProgress);self.bloodProgress=nil;
_UIObject_release(self.prepareRoot);self.prepareRoot=nil;
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.talkDesc);self.talkDesc=nil;
_UIObject_release(self.thunderHurt);self.thunderHurt=nil;
_UIObject_release(self.fuLuItemPanel);self.fuLuItemPanel=nil;
_UIObject_release(self.fuLuItem);self.fuLuItem=nil;
end
















local brokeState={
ePrepare=1,
eDoing=2,
eResult=3,
}
local randomEmo={2,4,5,6,9,10}
local speed=1
local _this=nil
local _Ease=DG.Tweening.Ease

local stopEffect=CS.GameInterface.StopEffect
















function UIDiscipleJingJieBrokeWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:listenNotify(notifyConfig.onDiscipleJJBroke,self.onDiscipleJJBroke)
notifySystem:listenNotify(notifyConfig.onShowDiscipleChanged,self.onShowDiscipleChanged)

self.fuLuItem:setBaseItemClickEvent(function(...)self:onFuLuItemClick(...)end)
end


function UIDiscipleJingJieBrokeWin:__delete()
roleAudioController:stopRoleSpeak()
self.successEffect1:setChildShowEffect(10010,false)
self.successEffect2:setChildShowEffect(10061,false)
self.failRootWidget:SetChildShowEffect(0,10011,false)
if self.modelsmoke~=nil then
_stopEffect(self.modelsmoke)
self.modelsmoke=nil
end
self:closeStage()

local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
if UIDiscipleModel:checkOpenDaoYan(netData)then
UIDiscipleController:reqDaoYanUnlock(self.disciple_guid)
end
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:removelistener(notifyConfig.onDiscipleJJBroke,self.onDiscipleJJBroke)
notifySystem:removelistener(notifyConfig.onShowDiscipleChanged,self.onShowDiscipleChanged)

UIManager:showWindow('UIBuildingMsgWin')
end


function UIDiscipleJingJieBrokeWin:onHide()

end

function UIDiscipleJingJieBrokeWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if _this==nil then return end
local change=false
if _this.items_lookup[itemid]then
change=true
_this:updataGoodListView()
_this:updateJJRateView()
end

if change then
if oldcount>newcount then
_this:showUseExpression(itemid)
end
end
end

function UIDiscipleJingJieBrokeWin.onDiscipleJJBroke(disguid,res)
if _this==nil then return end
if mathHelper.compareInt64(disguid,_this.disciple_guid)then
_this:rec_result(res)
end
end

function UIDiscipleJingJieBrokeWin.onShowDiscipleChanged(effectType,allData,effectData)
if _this==nil then return end
if effectType==ePrizeType.eFeiShengTai then
local guid_str=tostring(_this.disciple_guid)
local temp1
local temp2
local temp3

temp1=allData[eDiscipleChangeType.eJJRate]
if temp1 then
temp2=temp1[guid_str]
if temp2 then
temp3=temp2[#temp2]
_this.jjratechange=temp3[2]-temp3[1]
end
end

temp1=allData[eDiscipleChangeType.eInjuryChange]
if temp1 then
temp2=temp1[guid_str]
if temp2 then
temp3=temp2[#temp2]
_this.injurychange=temp3[2]-temp3[1]
end
end
end
end




function UIDiscipleJingJieBrokeWin:onShow(argtable,afterOnloaded)
self.fightStage=argtable.fightStage
self.disciple_guid=argtable.guid

self.openTest=argtable.openTest
self.testResult=argtable.testResult
self.testNum=argtable.testNum

self.oldAttrList=UIDiscipleModel:getDiscipleAttrLookupX(self.disciple_guid,DISCIPLE_ATTRIBUTE_TYPE.eJingJie)
local attrlist=UIDiscipleModel:getDiscipleAttrListByType(self.disciple_guid,{eAttributeType.eHP},true)
self.maxBlood=attrlist[1][2]

if afterOnloaded then
self:initStage()
end
UIManager:hideWindow('UIBuildingMsgWin')

FeiShengTaiModel:setSelectHuDaoFuItemId(nil)

self.curState=brokeState.ePrepare

self.jjlv=UIDiscipleModel:getDiscipleJJLevel(self.disciple_guid)
self.floor=UIDiscipleModel:getJJFloor(self.jjlv)

self.prepareRootWidget=self.prepareRoot:getChildWidgetBase()
self.doingRootWidget=self.doingRoot:getChildWidgetBase()
self.successRootWidget=self.successRoot:getChildWidgetBase()
self.failRootWidget=self.failRoot:getChildWidgetBase()
self.bloodProgress:setChildCanvasGroupAlpha(0)


self:updatePrepareRoot()
end

function UIDiscipleJingJieBrokeWin:initStage()

self.fightStage:addEntity(100,fightEntityType.diZi,self.disciple_guid,fightModel.getWorldCenter(),true)
self.modelEntity=self.fightStage:getEntity(100)
end

function UIDiscipleJingJieBrokeWin:setModelColor()
if self.curResult==1 then

if self.curThunderIndex>=self.maxThunderNum then

self.modelEntity:setSlotInheritColor('tou2','biaoqing',false)
self.modelEntity:fadeToColor(Color.New(0,0,0,1),1)
self.modelEntity:setExpression(10)
self.modelsmoke=self.modelEntity:playEffect(10012,Vector3.New(0,0.6,0),true,true)
else
local emo=self:getRandomEmo()
self.modelEntity:setExpression(emo)
end
else

if self.curThunderIndex>=self.maxThunderNum then

local sex=UIDiscipleModel:getDiscipleSex(self.disciple_guid)
local emo=sex==SEX_TYPE.eMale and 8 or 7
self.modelEntity:setExpression(emo)
else
local emo=self:getRandomEmo()
self.modelEntity:setExpression(emo)
end
end
end

function UIDiscipleJingJieBrokeWin:getRandomEmo()
local rad=math.random(1,#randomEmo)
return randomEmo[rad]
end

function UIDiscipleJingJieBrokeWin:closeStage()
self.fightStage:close()
end

function UIDiscipleJingJieBrokeWin:initModel()





end


function UIDiscipleJingJieBrokeWin:getGoodDataList()
self.goodDataList={}
self.items_lookup={}
local list=itemsLookup:get_function_items(item_funtion_type.jj_tupodan)or{}
for k,v in pairs(list)do
local fix,nonfix=itemsLookup:checkDicipleUseItemCondition(self.disciple_guid,v.id)
if fix then
local weight=v.stage*10+v.color
table.insert(self.goodDataList,{v,fix,weight})
self.items_lookup[v.id]=true
end
end
if#self.goodDataList>0 then
table.sort(self.goodDataList,function(a,b)
return a[3]<b[3]
end)
end
end

function UIDiscipleJingJieBrokeWin:updatePrepareRoot()

local tips2=cfgHelper.get2(cfg_disciplejjthunderconfig_get,1,'tips2')
self.prepareRootWidget:SetChildText(2,tips2)
self:updateJJRateView()

self.prepareRootWidget:SetChildCanvasGroupAlpha(9,0)
local tween=self.prepareRootWidget:SetChildCanvasGroupDOFade(9,1,0.2,nil)
tween:SetDelay(0.4)


self.prepareRootWidget:SetChildAnimationStringID(8,'dujiehezi')

self.prepareRootWidget:SetChildText(3,FMT.fmt('{0}期',UIDiscipleModel:getJJFloorName(self.floor+1)))

self:updataGoodListView()

self:resetProgressBar()


self:refreshFuLuItemPanel()
end

function UIDiscipleJingJieBrokeWin:updateJJRateView()
local guid=self.disciple_guid
local rate,ratelist=FeiShengTaiModel:getDiscipleBrokeSuccessRate(guid)
self.oldTestRate=rate
self.oldTestRateList=ratelist
local tips3=cfgHelper.get2(cfg_disciplejjthunderconfig_get,1,'tips3')
self.prepareRootWidget:SetChildText(1,FMT.fmt(tips3,UIDiscipleModel:getJJFloorName(self.floor+1),rate))
end

function UIDiscipleJingJieBrokeWin:updataGoodListView()
self:getGoodDataList()
local grid=self.prepareRootWidget:GetChildCommonLayoutGroupWidgetList(4)
for i=1,3 do
local item=grid[i-1]
local isshow=self.goodDataList[i]~=nil
item:SetChildActive(1,isshow)
if isshow then
local cfg=self.goodDataList[i][1]
local itemID=cfg.id

local itemNum=itemBagModel:getItemCountByItemID(itemID)
local itemcount=tostring(itemNum)
local grayNum=0
if itemNum<=0 then
grayNum=mathHelper.setbit(grayNum,eGrayType.eGray-1)
end
local conf={itemid=itemID,itemcount=itemcount,showname=false,showCountBG=true,showStage=false,itemIndex=i,gray=grayNum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(...)end)

local funcparam=cfg.funcparam
local desc_str=FMT.fmt('+{0}%',funcparam.rate)
item:SetChildText(2,desc_str)


local reddot=itemNum>0
if reddot then
local rate=FeiShengTaiModel:getDiscipleBrokeSuccessRate(self.disciple_guid)
if rate>=100 then
reddot=false
end
end
if reddot then
local useCnt=UIDiscipleModel:getTuPoDanUseCount(self.disciple_guid)
local limitCnt=FeiShengTaiModel.getTuPoDanUseCountLimit(self.floor)
if useCnt>=limitCnt then
reddot=false
end
end
item:SetChildActive(3,reddot)

end
end
end

function UIDiscipleJingJieBrokeWin:onGoodItemClick(itemid,index,itemguid,attach)

if itemid==-1 then return end

local itemNum=itemBagModel:getItemCountByItemID(itemid)
if itemNum<=0 then


gainControl:showGainWin(itemid)
return
end

local rate=FeiShengTaiModel:getDiscipleBrokeSuccessRate(self.disciple_guid)
if rate>=100 then
UIManager.error(FMT.fmt('{0}概率已达100%',UIDiscipleModel:getJJFloorName(self.floor+1)))
return
end

local useCnt=UIDiscipleModel:getTuPoDanUseCount(self.disciple_guid)
local limitCnt=FeiShengTaiModel.getTuPoDanUseCountLimit(self.floor)
if useCnt>=limitCnt then
UIManager.info('服用丹药次数已满')
return
end


local fix,cond=itemsLookup:checkDicipleUseItemCondition(self.disciple_guid,itemid)
if not fix then
if cond then
local item=self.prepareRootWidget:GetChildCommonLayoutGroupWidgetItem(4,index-1)
local pos=Vector2.New(-18,30)
local cond_str=UIDiscipleModel:getUseGoodStr(cond)
UIManager:showWindow('UIConditionTipsOne',{str=cond_str,posWidget=item,pos=pos})
end
return
end
bagProtocolControl.req_dizi_use_item(self.disciple_guid,itemid,1)
end

function UIDiscipleJingJieBrokeWin:onCommitClick()
self.curState=brokeState.doing


if self.openTest==true then
self:rec_result(self.testResult or 1)
else
FeiShengTaiController.sendJingJieBroke(self.disciple_guid,self.huDaoFuItemId)
end
end

function UIDiscipleJingJieBrokeWin:onCloseClick()
self:myClose()
end



function UIDiscipleJingJieBrokeWin:getIntergration(v)
local n=0
for i=1,v do
n=n+i
end
return n
end

function UIDiscipleJingJieBrokeWin:initDoingRoot()
local widget=self.doingRootWidget
self.curBlood=self.maxBlood
if self.curResult==0 then
local hurtRange=cfgHelper.get2(cfg_disciplejjthunderconfig_get,1,'hurtRange')
local r=math.random(hurtRange[1],hurtRange[2])
self.allHurtRate=r/100
end
self.bloodProgress:setChildCanvasGroupDOFade(1,0.15,nil)
self:updateBloodProgress()

self.firstBroke=userActorSetting.get('firstJingJieBroke',true)
local showskip=cfgHelper.get2(cfg_disciplejjthunderconfig_get,1,'skip')
if showskip then
if self.firstBroke then
showskip=false
end
end
widget:SetChildActive(3,showskip)

local rateRange=cfgHelper.get2(cfg_disciplejjthunderconfig_get,1,'rateRange')
local ratecfg
for i,v in ipairs(rateRange)do
if self.floor>=v[1]and self.floor<=v[2]then
ratecfg=v
break
end
end
if ratecfg==nil then
ratecfg=rateRange[#rateRange]
end
local tNum
if self.curResult==0 then
tNum=ratecfg[3]
else
local rate=self.oldTestRate
for i,v in ipairs(ratecfg[4])do
if rate>=v[1]and rate<=v[2]then
tNum=v[3]
break
end
end
if tNum==nil then
tNum=3
end
end

if self.testNum~=nil then
tNum=self.testNum
end

self.maxThunderNum=tNum
self.curThunderIndex=0


self.beforeBgm=AudioManager.getCurrentBgm()
local duJieBgmId=10031
AudioManager.playBgMusic(duJieBgmId)

self:castThunder()
end

function UIDiscipleJingJieBrokeWin:updateBloodProgress(playAnim)
local max=30
local cur=self.curBlood/self.maxBlood*max
if cur>max then
cur=max
end
if not playAnim then
self.bloodProgress:setProgressValue(cur,max)
else
self.bloodProgress:setProgress(cur,max)
end
self.bloodProgress:setChildProgressText(FMT.fmt('{0}/{1}',self.curBlood,self.maxBlood))
end

function UIDiscipleJingJieBrokeWin:castThunder()
if self.curState==brokeState.eResult then return end
self.curThunderIndex=self.curThunderIndex+1
if self.curThunderIndex>self.maxThunderNum then
self:castOver()
else
local func=function()
self:beginThunder()
end
if self.curThunderIndex==1 then
self:delayDo(0.2*speed,func)
else
func()
end

end
end

function UIDiscipleJingJieBrokeWin:beginThunder()
if self.curState==brokeState.eResult then return end
local widget=self.doingRootWidget

widget:SetChildActive(0,true)
widget:SetChildCanvasGroupAlpha(0,0)
local func=function()
local func2=function()
if _this==nil then return end
widget:SetChildActive(0,false)
end
widget:SetChildCanvasGroupDOFade(0,0,0.4*speed,func2)
end
widget:SetChildCanvasGroupDOFade(0,1,0.15*speed,nil)
self:delayDo(0.5*speed,func)
local namelist=cfgHelper.get2(cfg_disciplejjthunderconfig_get,1,'thunderName')
local t_name=namelist[self.curThunderIndex]
t_name=pfwindowslController:showDescLeiJie_ByIndex(t_name)
widget:SetChildText(1,t_name)
widget:SetChildScale(1,Vector3.New(8,8,8))
local t1=widget:SetChildDOScale(1,1,0.2*speed,nil)
t1:SetEase(_Ease.OutElastic)

local func3=function()
self:lightingThunder()
end
self:delayDo(0.5*speed,func3)
end

function UIDiscipleJingJieBrokeWin:lightingThunder()
if self.curState==brokeState.eResult then return end
local widget=self.doingRootWidget

local effectcfg=self:getThunderEffect()
widget:SetChildActive(2,true)
self.fightStage:runBehavior(100,effectcfg[3],nil)
local func=function()
widget:SetChildActive(2,false)
end

self:delayDo(effectcfg[4]/1000*speed,func)

local showHurtTime=effectcfg[5]/1000*speed


local func2=function()
self:doThunderHurt()
if self.curThunderIndex==self.maxThunderNum then
local func4=function()
self:castThunder()
end
self:delayDo(1*speed,func4)
end
end
self:delayDo(showHurtTime,func2)

local colorTime=effectcfg[6]/1000*speed
local func3=function()
self:setModelColor()
end
self:delayDo(colorTime,func3)
end

function UIDiscipleJingJieBrokeWin:getThunderEffect()
local effect=nil
local idx=self.curThunderIndex
local thundereffect=cfgHelper.get2(cfg_disciplejjthunderconfig_get,1,'thundereffect')
for i,v in ipairs(thundereffect)do
if idx>=v[1]and idx<=v[2]then
effect=v
break
end
end
if effect==nil then
effect=thundereffect[1]
end
return effect
end

function UIDiscipleJingJieBrokeWin:doThunderHurt()
if self.curState==brokeState.eResult then return end
local widget=self.doingRootWidget

self.thunderHurt:setActive(true)
self.thunderHurt:setChildCanvasGroupAlpha(1)
self.thunderHurt:setScale(Vector3.New(1,1,1))
self.thunderHurt:setChildLocalPosition(Vector3.New(0,-70,0))

local func=function()
self.thunderHurt:setChildDOScale(1,0.1*speed,nil)
end
self.thunderHurt:setChildDOScale(2,0.1*speed,func)
self.thunderHurt:setChildDOLocalMove(Vector3.New(0,0,0),0.8*speed,nil)
local func2=function()
local func3=function()
if _this==nil then return end
self.thunderHurt:setActive(false)
end
self.thunderHurt:setChildCanvasGroupDOFade(0,0.2*speed,func3)
if self.curThunderIndex<self.maxThunderNum then
local func4=function()
self:castThunder()
end
self:delayDo(0.2*speed,func4)
end
end
self:delayDo(0.8*speed,func2)

local allInter=self:getIntergration(self.maxThunderNum)
local hurtRate=self.curThunderIndex/allInter
local hurtNum
if self.curResult==0 then
local blood=self.maxBlood*self.allHurtRate
hurtNum=math.floor(blood*hurtRate)
if self.curThunderIndex>=self.maxThunderNum then
self.curBlood=math.floor(self.maxBlood-blood)
else
local rate=self:getIntergration(self.curThunderIndex)/allInter
self.curBlood=math.floor(self.maxBlood-blood*rate)
end
else
hurtNum=math.floor(self.maxBlood*hurtRate)
if self.curThunderIndex>=self.maxThunderNum then
self.curBlood=0
local lastHurtRange=cfgHelper.get2(cfg_disciplejjthunderconfig_get,1,'lastHurtRange')
local r=math.random(lastHurtRange[1],lastHurtRange[2])
local lastrate=r/100
hurtNum=hurtNum+math.floor(self.maxBlood*lastrate)
else
local rate=self:getIntergration(self.curThunderIndex)/allInter
self.curBlood=math.floor(self.maxBlood*(1-rate))
end
end
self.thunderHurt:setText(string.format('-%d',hurtNum))
self:updateBloodProgress(true)


if self.curThunderIndex<self.maxThunderNum then
self:showTalk()
end
end

function UIDiscipleJingJieBrokeWin:castOver()
self.curState=brokeState.eResult
self.doingRoot:setActive(false)
if self.curResult==0 then
self.successRoot:setActive(true)
self:updateSuccessRoot()
roleAudioController:playRoleSpeak(self.disciple_guid,roleAudioNodeType.JingJieTiSheng_succes)
_this.rolespeaktxt=roleAudioController:getplayRoleSpeakTxt(self.disciple_guid,roleAudioNodeType.JingJieTiSheng_succes)
else
self.failRoot:setActive(true)
self:updateFailRoot()

AudioManager.playAudio(453)
roleAudioController:playRoleSpeak(self.disciple_guid,roleAudioNodeType.JingJieTiSheng_defead)
_this.rolespeaktxt=roleAudioController:getplayRoleSpeakTxt(self.disciple_guid,roleAudioNodeType.JingJieTiSheng_defead)
end


self.closeTips:setActive(true)


self:showTalk()


self:clearHuDaoFuEffect()


if self.beforeBgm then
AudioManager.playBgMusic(self.beforeBgm)
self.beforeBgm=nil
end

notifySystem:postNotify(notifyConfig.onDiscipleDuJieFinish,self.disciple_guid,self.curResult==0)
end

function UIDiscipleJingJieBrokeWin:showTalk()
local jobid=UIDiscipleModel:getDiscipleJob(self.disciple_guid)
local talklist=nil
local talkTime=nil
if self.curThunderIndex<self.maxThunderNum then
local temp=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,jobid,'thunder')
talklist=temp[self.curThunderIndex]
talkTime=1
else
local tkey=self.curResult==0 and'dujieSuccess'or'dujiefail'
talklist=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,jobid,tkey)
talkTime=cfgHelper.get2(cfg_disciplejjthunderconfig_get,1,'talkTime')
end
talkTime=talkTime or 3

local talk_str=nil
if talklist~=nil and#talklist>0 then
local r=math.random(1,#talklist)
talk_str=talklist[r]
end
if _this.rolespeaktxt then
talk_str=_this.rolespeaktxt
_this.rolespeaktxt=nil
end
if talk_str==nil then return end

self.talkObj:setActive(true)
self.talkObj:setChildLocalPosition(Vector3.New(55,-97,0))
self.talkObj:setChildCanvasGroupAlpha(0)

self.talkDesc:setText(talk_str)
self.talkObj:setChildCanvasGroupDOFade(1,0.1,nil)
self.talkObj:setScale(Vector3.New(0,0,0))
local t1=self.talkObj:setChildDOScale(1,0.2*speed,nil)
t1:SetEase(_Ease.OutElastic)

if self.talkTimer~=nil then
self:stopTimerByID(self.talkTimer)
self.talkTimer=nil
end
if self.taklTween~=nil then
self.taklTween:Complete()
self.taklTween=nil
end
local func=function()
self.taklTween=self.talkObj:setChildCanvasGroupDOFade(0,0.2,nil)
end
self.talkTimer=self:delayDo(talkTime*speed,func)
end

function UIDiscipleJingJieBrokeWin:onSkipClick()
if self.curState==brokeState.eDoing then
self.curThunderIndex=self.maxThunderNum
if self.curResult==0 then
local blood=self.maxBlood*self.allHurtRate
self.curBlood=math.floor(self.maxBlood-blood)
else
self.curBlood=0
end
self:updateBloodProgress(true)
self:setModelColor()
self:castOver()
end
end


function UIDiscipleJingJieBrokeWin:getAttrList(lookup)
local result={}
for k,v in pairsBySortKey(lookup)do
result[#result+1]={k,v}
end
return result
end

function UIDiscipleJingJieBrokeWin:updateSuccessRoot()
self.successEffect1:setChildShowEffect(10010,true)
self.successEffect2:setChildShowEffect(10061,true)
local widget=self.successRootWidget
local oldAttrList=self.oldAttrList
local lookup=UIDiscipleModel:getDiscipleAttrLookupX(self.disciple_guid,DISCIPLE_ATTRIBUTE_TYPE.eJingJie)
local curAttrList=UIDiscipleJingJieBrokeWin:getAttrList(lookup)
local oldJJLv=self.jjlv
local jjlv=UIDiscipleModel:getDiscipleJJLevel(self.disciple_guid)

widget:SetChildText(0,UIDiscipleModel:getJJNameEx(oldJJLv))
widget:SetChildText(1,UIDiscipleModel:getJJNameEx(jjlv))

local gridlist=widget:GetChildCommonLayoutGroupWidgetList(2)
local c=gridlist.Count
for i=1,c do
local item=gridlist[i-1]
local attr=curAttrList[i]
local show=attr~=nil
local attrType
local newAttrValue
local oldAttrValue
if show then
attrType=attr[1]
newAttrValue=attr[2]
oldAttrValue=oldAttrList[attrType]


end
item:SetChildActive(0,show)
if show then
local attrname=cfgHelper.get2(cfg_attributesconfig_get,attrType,'attrname')
item:SetChildText(1,helper.getAttributeStr(attrType,oldAttrValue,nil,'{0}：{1}'))
item:SetChildText(3,newAttrValue)
end
end


local delay=1

local sub0=0.3*speed
widget:SetChildCanvasGroupAlpha(3,0)
local func0=function()
widget:SetChildCanvasGroupDOFade(3,1,sub0,nil)
end
self:delayDo(delay,func0)
delay=delay+sub0

local pos1=widget:GetChildLocalPosition(0)
widget:SetChildLocalPosY(0,-55)
widget:SetChildActive(0,false)
local sub1=0.2*speed
local func1=function()
widget:SetChildActive(0,true)
widget:SetChildDOLocalMoveY(0,pos1.y,sub1,nil)
end
self:delayDo(delay,func1)
delay=delay+sub1

for i=1,c do
local item=gridlist[i-1]
local pos=item:GetChildLocalPosition(0)
local posy=pos.y
item:SetChildLocalPosY(0,-210)
item:SetChildActive(0,false)
local sub3=0.2*speed
local func2=function()
item:SetChildActive(0,true)
item:SetChildDOLocalMoveY(0,posy,sub3,nil)
end
self:delayDo(delay,func2)
delay=delay+sub3
end






end

function UIDiscipleJingJieBrokeWin:updateFailRoot()
local guid=self.disciple_guid
self.failRootWidget:SetChildShowEffect(0,10011,true)
self.bloodProgress:setChildCanvasGroupDOFade(0,0.2,nil)

local tips_str

local jjratechange=self.jjratechange
local rate_str
if jjratechange>0 then
rate_str=FMT.fmt('+{0}',jjratechange)
else
rate_str=tostring(jjratechange)
end
local tips_str=FMT.fmt('<color=#fd8950>弟子渡劫成功率  {0}%</color>',rate_str)

local injurychange=self.injurychange or 0
local injury_str
if injurychange>0 then
injury_str=FMT.fmt('+{0}',injurychange)
else
injury_str=tostring(injurychange)
end
if injurychange~=0 then
local tips_str_2=FMT.fmt('<color=#a18cfd>负伤值  {0}</color>',injury_str)
tips_str=FMT.fmt('{0}\n{1}',tips_str,tips_str_2)
end









self.failRootWidget:SetChildText(1,tips_str)
end


function UIDiscipleJingJieBrokeWin:refreshFuLuItemPanel()

local hasItem=FeiShengTaiModel:checkBagHasHuDaoFuByFloor(self.floor)
self.fuLuItemPanel:setActive(hasItem)
if not hasItem then
self.huDaoFuItemId=nil
return
end

self.huDaoFuItemId=FeiShengTaiModel:getSelectHuDaoFuItemId()
local count=itemBagModel:getItemCountByItemID(self.huDaoFuItemId)
if not count or count<=0 then

FeiShengTaiModel:setSelectHuDaoFuItemId(nil)
self.huDaoFuItemId=nil
end

local conf={showbg=true,showname=false,showCountBG=false,itemcount='',stage=''}
local item=self.huDaoFuItemId and{itemid=self.huDaoFuItemId}or nil
self.fuLuItem:setChildPropData(self:getSelectFillData(item,conf))
local thunderConfig=cfgHelper.get1(cfg_disciplejjthunderconfig_get,1)
self.fuLuItem:getWidgetBase():SetChildButtonClick(10,function(...)
self:cancelFuluItem()
end)

if self.huDaoFuItemId then

local itemConfig=itemsConfig.getConfig(self.huDaoFuItemId)
local color=itemConfig.color
local effectPram=thunderConfig.huDaoFuEffect[color]
if effectPram then
local effectId=effectPram[1]
local offset=effectPram[2]
self:setEntityPlayHuDaoFuEffect(effectId,offset)
else
logErr(FMT.fmt("找不到品质为{0}所对应的护道符特效id 请确认配置是否正确",color))
end
local funcparam=itemConfig.funcparam
local percent=funcparam and funcparam.percent
if percent then
self.prepareRootWidget:SetChildText(2,FMT.fmt(thunderConfig.huDaoFuTips,percent))
else
logErr(FMT.fmt("找不到道具Id为{0} 所对应的护道符保留经验百分比 请确认配置是否正确",self.huDaoFuItemId))
end
else
self:clearHuDaoFuEffect()
self.prepareRootWidget:SetChildText(2,thunderConfig.tips2)
end
end


function UIDiscipleJingJieBrokeWin:onQuestionBtn()
local pos=Vector2.New(16,10)
local rule_str=FeiShengTaiModel:DiscipleBrokeSuccessRateStr(self.disciple_guid)
UIManager:showWindow('UIConditionTipsOne',{str=rule_str,posWidget=self.prepareRootWidget,posWidgetIndex=5,pos=pos,showType=2})
end

function UIDiscipleJingJieBrokeWin:myClose()
local isUnlockDY=UIDiscipleModel:getDiscipleDaoYanUnLockReddot(self.disciple_guid)
if isUnlockDY then
UIManager:showWindow("UIDiscipleDaoYanUnlockWin",{discipleGuid=self.disciple_guid,isShowGotoBtn=true})
fullScreenUI.closeActiveUI()
else
fullScreenUI.closeActiveUI(true)
end
end

function UIDiscipleJingJieBrokeWin:onBackClick()
if self.curState==brokeState.eResult then
self:myClose()
end
end

function UIDiscipleJingJieBrokeWin:useGoodBack(itemid)
UIDiscipleModel:useJJGoodBack(self.disciple_guid,itemid,2)
end

function UIDiscipleJingJieBrokeWin:rec_result(res)
if self.curResult~=nil then return end
self.curResult=res
self.curState=brokeState.eDoing
self.prepareRoot:setActive(false)
self.doingRoot:setActive(true)
self:initDoingRoot()

userActorSetting.flushVal('firstJingJieBroke',false,true)
end

function UIDiscipleJingJieBrokeWin:onFuLuItemClick(itemid,index,itemguid,attach)

self:showWindow('UIHuDaoFuSelectWin',{discipleGuid=self.disciple_guid})









end



function UIDiscipleJingJieBrokeWin:resetProgressBar()
local useCnt=UIDiscipleModel:getTuPoDanUseCount(self.disciple_guid)
local limitCnt=FeiShengTaiModel.getTuPoDanUseCountLimit(self.floor)
self.prepareRootWidget:SetChildProgressValue(7,useCnt,limitCnt)
self.prepareRootWidget:SetChildProgressText(7,FMT.fmt('{0}/{1}',useCnt,limitCnt))
end

function UIDiscipleJingJieBrokeWin:showUseExpression(itemid)
local index=2
for i,v in ipairs(self.goodDataList)do
if v[1].id==itemid then
index=i
break
end
end
local posXList={-80,0,80}
local parent=self.prepareRootWidget:GetChildGameObject(6).transform
_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIFlyIcon,parent,function(id)
if _this==nil then return end
self:startFlyIcon(id,itemid,posXList[index])
end)
self:resetProgressBar()
end

function UIDiscipleJingJieBrokeWin:startFlyIcon(id,itemid,posX)
local widget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
widget:SetChildLocalPosition(0,Vector3(posX,0,0))
widget:SetChildIcon(1,iconHelper.getIconName(itemid),true)
widget:SetCurveAniPlay(1,1,Vector3(0,0,0),Vector3(500-posX,160,0),function(...)
_InstantiateManager.RemoveInstance(id)
if _this==nil then return end
self.modelEntity:runAnimator(eAnimationID.hit)
self:useGoodBack(itemid)
self.chiyaoEffect:setChildShowEffect(10087,true)
end)
end

function UIDiscipleJingJieBrokeWin:getSelectFillData(item,conf)
local prop
if item==nil then
prop=self:getSelectTempFillData()
prop[PropIndex(DataPropKey.eWidgetActive,8)]=false
prop[PropIndex(DataPropKey.eWidgetActive,9)]=true
prop[PropIndex(DataPropKey.eWidgetActive,10)]=false
prop[PropIndex(DataPropKey.eWidgetActive,11)]=true
else
prop=itemsComponentHelper.getCommonFillData(item,conf)
prop[PropIndex(DataPropKey.eWidgetActive,8)]=false
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
prop[PropIndex(DataPropKey.eWidgetActive,10)]=true
prop[PropIndex(DataPropKey.eWidgetActive,11)]=false
end
return prop
end


function UIDiscipleJingJieBrokeWin:getSelectTempFillData()
local conf={}

conf.showbg=true
return itemsComponentHelper.getTempFillData(conf)
end


function UIDiscipleJingJieBrokeWin:setEntityPlayHuDaoFuEffect(effectId,offset)
if not effectId or effectId==self.huDaoFuEffectId then
return
end

self:clearHuDaoFuEffect()
self.huDaoFuEffectId=effectId
local offset_x=0
local offset_y=0
local offset_z=0
if offset then
offset_x=offset[1]or 0
offset_y=offset[2]or 0
offset_z=offset[3]or 0
end
self.huDaoFuEffect=self.modelEntity:playEffect(effectId,Vector3.New(offset_x,offset_y,offset_z),true,true)
end

function UIDiscipleJingJieBrokeWin:clearHuDaoFuEffect()
if self.huDaoFuEffect~=nil then
_stopEffect(self.huDaoFuEffect)
self.huDaoFuEffect=nil
self.huDaoFuEffectId=nil
end
end

function UIDiscipleJingJieBrokeWin:cancelFuluItem()
FeiShengTaiModel:setSelectHuDaoFuItemId(nil)
self.huDaoFuItemId=nil
self:refreshFuLuItemPanel()
end
