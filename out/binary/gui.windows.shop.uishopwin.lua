







def_class("UIShopWin",UIWindowBase)









function UIShopWin:bindComponents()

self.root=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.sbg=UIImage.get(self,2)
self.waichu=UIObject.get(self,3)
self.qiantai=UIObject.get(self,4)
self.rightArrowImg=UIObject.get(self,5)
self.leftArrowImg=UIObject.get(self,6)
self.dzName=UIText.get(self,7)
self.jobLevel=UIText.get(self,8)
self.txtSelect=UIText.get(self,9)
self.btnSelectReddot=UIObject.get(self,10)
self.xinqing=UIText.get(self,11)
self.btnUpgradeText=UIText.get(self,12)
self.leftArrow=UIButton.get(self,13)
self.rightArrow=UIButton.get(self,14)
self.infoText=UIText.get(self,15)
self.scrollView=UIObject.get(self,16)
self.state=UIToggleButton.get(self,17)
self.diziInfo=UIObject.get(self,18)
self.spName=UIText.get(self,19)
self.sCount=UIText.get(self,20)
self.sIcon=UIObject.get(self,21)
self.cIcon=UIObject.get(self,22)
self.teding=UIObject.get(self,23)
self.replaceBtn=UIButton.get(self,24)
self.countBtn=UIButton.get(self,25)
self.btnSelect=UIObject.get(self,26)
self.selectBtn=UIButton.get(self,27)
self.paizi=UIButton.get(self,28)
self.settingBtn=UIButton.get(self,29)
self.closeplane=UIObject.get(self,30)
self.txtCurLevel=UIText.get(self,31)
self.btnUpgrade=UIButton.get(self,32)
self.proroot=UIObject.get(self,33)
self.progressbar=UIObject.get(self,34)
self.progressValue=UIObject.get(self,35)
self.timeProgressText=UIText.get(self,36)
self.receiveBtn=UIButton.get(self,37)
self.recvTimetxt=UIText.get(self,38)
self.pauseTimeImg=UIObject.get(self,39)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)

self.replaceBtn:setButtonClick(function()self:onReplaceBtn()end)

self.countBtn:setButtonClick(function()self:onCountBtn()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.paizi:setButtonClick(function()self:onPaizi()end)

self.settingBtn:setButtonClick(function()self:onSettingBtn()end)

self.btnUpgrade:setButtonClick(function()self:onBtnUpgrade()end)

self.receiveBtn:setButtonClick(function()self:onReceiveBtn()end)



end


function UIShopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.sbg);self.sbg=nil;
_UIObject_release(self.waichu);self.waichu=nil;
_UIObject_release(self.qiantai);self.qiantai=nil;
_UIObject_release(self.rightArrowImg);self.rightArrowImg=nil;
_UIObject_release(self.leftArrowImg);self.leftArrowImg=nil;
_UIObject_release(self.dzName);self.dzName=nil;
_UIObject_release(self.jobLevel);self.jobLevel=nil;
_UIObject_release(self.txtSelect);self.txtSelect=nil;
_UIObject_release(self.btnSelectReddot);self.btnSelectReddot=nil;
_UIObject_release(self.xinqing);self.xinqing=nil;
_UIObject_release(self.btnUpgradeText);self.btnUpgradeText=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.infoText);self.infoText=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.state);self.state=nil;
_UIObject_release(self.diziInfo);self.diziInfo=nil;
_UIObject_release(self.spName);self.spName=nil;
_UIObject_release(self.sCount);self.sCount=nil;
_UIObject_release(self.sIcon);self.sIcon=nil;
_UIObject_release(self.cIcon);self.cIcon=nil;
_UIObject_release(self.teding);self.teding=nil;
_UIObject_release(self.replaceBtn);self.replaceBtn=nil;
_UIObject_release(self.countBtn);self.countBtn=nil;
_UIObject_release(self.btnSelect);self.btnSelect=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.paizi);self.paizi=nil;
_UIObject_release(self.settingBtn);self.settingBtn=nil;
_UIObject_release(self.closeplane);self.closeplane=nil;
_UIObject_release(self.txtCurLevel);self.txtCurLevel=nil;
_UIObject_release(self.btnUpgrade);self.btnUpgrade=nil;
_UIObject_release(self.proroot);self.proroot=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.progressValue);self.progressValue=nil;
_UIObject_release(self.timeProgressText);self.timeProgressText=nil;
_UIObject_release(self.receiveBtn);self.receiveBtn=nil;
_UIObject_release(self.recvTimetxt);self.recvTimetxt=nil;
_UIObject_release(self.pauseTimeImg);self.pauseTimeImg=nil;
end
















local _format=string.format

local _this


local sixAttrType=DISCIPLE_BASE_ATTR_TYPE.eCongHui




function UIShopWin:onLoaded(...)
self:bindComponents()

self.loadingST={}




_this=self

self.shope_bg_ab='ui/windows/shop/sharedtextures/{0}.ab'

self.enterPosL={-450,-300}
self.enterPosR={450,-300}
self.leavePosL={self.enterPosL[1]-50,-300}
self.leavePosR={self.enterPosR[1]+50,-300}
self.askPos={-213,-300}
self.watchPos={225,-300}

self.leftPos={-350,-235}
self.rightPos={-110,-235}

self.jumpPos={-435,-300}

self.width=self.enterPosR[1]-self.enterPosL[1]

self.aiDiscipleList=aiManager:getAIDiscipleList(eAIDZType.eDefault)
self.currDZList={}
self.dzIndex=math.random(1,#self.aiDiscipleList)
self.buyerBTList={}

self.state:setToggleChange(function(name,isOn,data)
if isOn then
self:onState()
end
end)

self.waichu:setActive(false)

self.scrollView:setChildScrollViewInit(0.5,true,function(clicknum,i)
self:onClickSpeciality(i)
end,nil)

notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end

function UIShopWin:onState()
UIManager:showWindow('UIShopStateWin',self.bdData)
end

function UIShopWin:setStateButton(bActive)
self.state:setToggle(bActive)
end

function UIShopWin:showBuffState()
if not self.bdData or tostring(self.bdData.dizi_id)=='0'then
self.state:setActive(false)
return
end

local edatas=zongmenModel:getShopEffect(self.bdData)
self.state:setActive(#edatas>0)
end

function UIShopWin:onClickSpeciality(i)
local data=self.dizi_speciality[i+1]
local item=self.scrollView:getChildScrollViewItemWidget(i)
UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=self.bdData.dizi_id,config=data})
end


function UIShopWin:__delete()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)

self:clear()

self:unbindComponents()
_this=nil
end

function UIShopWin:clear()
roleAudioController:stopRoleSpeak()
if self.manager then
behaviorManager:removeBehaviorTree(self.manager)
self.manager=nil
end

if self.eventTipsRCID then
_InstantiateManager.RemoveInstance(self.eventTipsRCID)
end

for k,v in pairs(self.loadingST)do
_InstantiateManager.RemoveInstance(v)
end

uiAIManager:clearUIWinData('UIShopWin')
self.isInitAI=false

self.currDZ=nil

self.lastDZ=nil

self.workCheck1=nil
self.workCheck2=nil




self.buyerBTList=nil
self:stopHandleTimer()
end

function UIShopWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if _this.bdData.un_build_id~=bdId then
return
end
if etype==buildingEvent.replaceDisciple then
_this:refreshLeftPanel()
_this:refreshAI(arg1,arg2)
elseif etype==buildingEvent.levelUpComplete
or etype==buildingEvent.levelUpStart then
_this:refreshRightPanel()
_this:refresProbar()
elseif etype==buildingEvent.speedUpComplete then
_this:refreshRightPanel()
end
end

function UIShopWin:initAI(dzId)
local cfg=cfgHelper.get1(cfg_selleraiconfig_get,1)
local initData={
entercd=cfg.ui_enter_cd,
enterrate=cfg.ui_enter_rate,
maxnum=cfg.ui_max_num,
UIStateId=1,
}
self.manager=behaviorManager:addBehaviorTree('bt_ui_shop_manager',nil,true,initData)

self.winlua:SetChildCanvasEx(self.qiantai:getID(),'',1001)
self.winlua:SetChildSimulateDepth(self.qiantai:getID(),-300,1100,0.5,0,0)

dzId=tostring(dzId)
if dzId=='0'then
return
end

local state=UIDiscipleModel:getDiscipleState(dzId)
local waichu=state==DISCIPLE_STATE_TYPE.edsDispatch
self.waichu:setActive(waichu)
if waichu then
return
end

self.hasManager=true

if state==DISCIPLE_STATE_TYPE.eChuiWei then
self.hasManager=false
end

self:createDZ(self.bdData.dizi_id,self.rightPos,function(bt)
self.currDZ=bt
self.currDZ:setSharedVar('UIstateId',4)
self:setDZDepth(bt)
end)
end

function UIShopWin:addAByuer()
local dz=self:getADisciple()
if not dz then
return
end
self:createBuyer(dz,self.rightPos,function(bt)
bt:tick(0)
self.buyerBTList[dz]=bt
self:setDZDepth(bt)

local stWidget=bt:getSharedVar('dzWidget')
stWidget:SetChildActive(2,false)
end)
end

function UIShopWin:setDZDepth(bt)
local dzWidget=bt:getSharedVar('dzWidget')
local dzIndex=bt:getSharedVar('dzIndex')
dzWidget:SetChildSimulateDepth(dzIndex,-300,1100,0.5,0.001,0.001)
dzWidget:SetChildSimulateDepthActiveUpdate(dzIndex,true)
end

function UIShopWin:getADisciple()
local len=#self.aiDiscipleList
local count=0
while(count<5)do
local dz=self.aiDiscipleList[self.dzIndex]
if not self.currDZList[dz]and tostring(self.bdData.dizi_id)~=tostring(dz)then
return dz
end
self.dzIndex=self.dzIndex+1
if self.dzIndex>len then
self.dzIndex=1
end
count=count+1
end
return nil
end

function UIShopWin:createDZ(dzId,pos,callback)
local cfg=cfgHelper.get1(cfg_selleraiconfig_get,1)
local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
offset={0,0},
standPos=1,
leftPos=self.leftPos,
rightPos=self.rightPos,
enterPos=self.enterPosL,
jumpPos=self.jumpPos,
minSpeakCD=cfg.ui_s_speak_cd[1],
maxSpeakCD=cfg.ui_s_speak_cd[2],

}
self.speakRate=cfg.ui_b_speak_rate
self.currDZList[dzId]=true
local tran=self.root:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])
local dzstr=tostring(dzId)





local otherData={
order=1001,
cwCallback=function(bt,ov,cv)
self.hasManager=not cv
self.closeplane:setActive(cv)
self:refresProbar()
end,
}
self.loadingST[dzstr]=uiAIManager:createUIDisciple('UIShopWin','bt_ui_shop_work',dzId,tran,vpos,initData,otherData,function(bt)
self.loadingST[dzstr]=nil
callback(bt)
end)
end

function UIShopWin:createBuyer(dzId,pos,callback)
local cfg=cfgHelper.get1(cfg_selleraiconfig_get,1)
local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
offset={0,0},
standPos=1,
enterPos=self.enterPosL,
minSpeakCD=cfg.ui_b_speak_cd[1],
maxSpeakCD=cfg.ui_b_speak_cd[2],
speakRate=cfg.ui_b_speak_rate,
}
self.currDZList[dzId]=true
local tran=self.root:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])
local dzstr=tostring(dzId)





local otherData={
order=1002
}
self.loadingST[dzstr]=uiAIManager:createUIDisciple('UIShopWin','bt_ui_shop_buyer',dzId,tran,vpos,initData,otherData,function(bt)
self.loadingST[dzstr]=nil
callback(bt)
end)
end









function UIShopWin:startWork(bt)
self.workCheck1=false
self:showEventTips(bt)
end

function UIShopWin:endWork()

uiAIManager:removeUIInstance(self.lastDZ)
self.lastDZ=nil
self.workCheck2=false
end

function UIShopWin:dzLeave(bt)
local dzId=bt:getSharedVar('dzId')

uiAIManager:removeUIInstance(bt)
self.currDZList[dzId]=nil
self.buyerBTList[dzId]=nil
end

















function UIShopWin:extractDZEnter(pnum)
if not self.hasManager then
return
end
local rlist={}
for k,v in pairs(self.buyerBTList)do
rlist[#rlist+1]=v
end
local len=#rlist
if len>=pnum then
return
end
self:addAByuer()
end















function UIShopWin:getPassInfo(bt,ipkey,opkey,tkey,dkey,spkey)
local mspeed=50+math.random()*20
local etime=0.5
local rv=math.random(1,2)==1
local ep=rv and self.leavePosL or self.leavePosR
local lp=rv and self.leavePosR or self.leavePosL
local yp=ep[2]+(math.random()*40-20)
local dis=math.abs(lp[1]-ep[1])
local ptime=dis/mspeed
bt:setSharedVar(ipkey,{ep[1],yp})
bt:setSharedVar(opkey,{lp[1],yp})
bt:setSharedVar(tkey,etime)
bt:setSharedVar(dkey,ptime-etime)
bt:setSharedVar(spkey,mspeed)
end

function UIShopWin:getDZSpeakRate(bt,key)
local rate=self.speakRate
if self.eventTipsHUD then
rate=0
end
bt:setSharedVar(key,rate)
end

function UIShopWin:refreshEventTips()
if self.currDZ then
self:showEventTips(self.currDZ)
end
end


function UIShopWin:showEventTips(bt)
if self.eventTipsHUD then
return
end
local sdata=UIShopModel:getShopData(self.bdData.un_build_id)
if sdata.is_in_event then
local widget=bt:getSharedVar('dzWidget')
local index=bt:getSharedVar('dzIndex')
local parent=widget:GetCommonComponent(index,'Transform')
self.eventTipsRCID=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDiscipleTipsHUD,parent,function(hudId)
local hudWidget=_InstantiateManager.GetComponent(hudId,'CSGUIWidgetBase')
hudWidget:SetChildAnchoredPosition(0,Vector2.New(-25,120))
hudWidget:SetChildButtonClick(0,function()
UIShopControl:handleEvent(self.bdData)
_InstantiateManager.RemoveInstance(hudId)
self.eventTipsHUD=nil
end)
hudWidget:SetChildWeakGuideComponentId(0,'UIShopWin.root.UIDisciple.UIDiscipleTipsHUD')
self.eventTipsHUD=hudId
end)
end
end

function UIShopWin:refreshAI(newDzId,oldDzId)
local newDzIdStr=tostring(newDzId)
local oldDzIdStr=tostring(oldDzId)
if oldDzIdStr~='0'and self.currDZ then
if self.eventTipsHUD then
_InstantiateManager.RemoveInstance(self.eventTipsHUD)
self.eventTipsHUD=nil
end
self.currDZList[oldDzIdStr]=nil
self.lastDZ=self.currDZ
self.currDZ=nil
self.lastDZ:setSharedVar('UIstateId',2)
self.lastDZ:broke()
self.lastDZ:reset()
self.lastDZ:tick(0.5)

self.workCheck2=true
self.hasManager=false
end
if newDzIdStr~='0'and not self.currDZ and not self.isHide then
self.currDZList[newDzIdStr]=true
self:createDZ(self.bdData.dizi_id,self.enterPosL,function(bt)
self.currDZ=bt
self.currDZ:setSharedVar('UIstateId',1)
self.currDZ:tick(0.5)
end)

self.workCheck1=true
self.hasManager=true
end

self.closeplane:setActive(not self.hasManager)
self:showBuffState()
self:refresProbar()
end


function UIShopWin:getSpeakText(bt,tkey,stype)
local id=self.speakArgs[1]
local name=self.speakArgs[2]
local cfg=cfgHelper.get1(cfg_shangpuconfig_get,id)
local speakList=cfg[string.format('ui_speak%d',stype)]
local txt=speakList[math.random(#speakList)]
local rstr=FMT.fmt(txt,name)
bt:setSharedVar(tkey,rstr)
end




function UIShopWin:onShow(argtable,afterOnloaded)
self.isHide=false
self:refresh(argtable)
end

function UIShopWin:onShowArgRecv(argtable)
self.isHide=false
self:refresh(argtable)
end

function UIShopWin:refresh(argtable)
local bdData=argtable
self.bdData=bdData
self.sfId=zongmenModel:getMountainId()
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
self.title:setText(cfg.name)

local scfg=cfgHelper.get1(cfg_shangpuconfig_get,bdData.build_id)
local bfname=scfg.bg_image
local abName=FMT.fmt(self.shope_bg_ab,bfname)
self.sbg:setSprite(abName,bfname)

self.config=cfg
self.bdType=self.config.id
UIShopControl:setTitle(cfg.name)

self:refreshLeftPanel()
self:refreshRightPanel()

self:showBuffState()

if not self.isInitAI then
self.isInitAI=true
self:initAI(self.bdData.dizi_id)
end

self.closeplane:setActive(not self.hasManager)
self:refresProbar()
self:checkAndShowArrowBtn()
end

function UIShopWin:checkAndShowArrowBtn()

local bdDatas=zongmenModel:getAllBuildingData(self.sfId)
local list={}
for k,v in pairs(bdDatas)do
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
if cfg.build_type==24 and v.isLinkRoad then
table.insert(list,v)
end
end
local len=#list
local showArrow=len>1
self.otherBDData=list
self.leftArrow:setActive(showArrow)
self.rightArrow:setActive(showArrow)
if showArrow and not self.showArrowAnim then
self.showArrowAnim=true
local tween1=self.leftArrowImg:setChildDOLocalMoveX(-15,0.75,nil)
tween1:SetEase(_Ease.InOutSine)
tween1:SetLoops(-1,_LoopType.Yoyo)
local tween2=self.rightArrowImg:setChildDOLocalMoveX(-15,0.75,nil)
tween2:SetEase(_Ease.InOutSine)
tween2:SetLoops(-1,_LoopType.Yoyo)
end
end

function UIShopWin:toNextWin(arrow)
local ubdId=self.bdData.un_build_id
local index
for i,v in ipairs(self.otherBDData)do
if v.un_build_id==ubdId then
index=i
break
end
end

if not index then
return
end

index=index+arrow
local len=#self.otherBDData
if index>len then
index=index-len
elseif index<1 then
index=index+len
end

self.leftArrow:setActive(false)
self.rightArrow:setActive(false)

local bdData=self.otherBDData[index]
self:clear()
self.buyerBTList={}
self.hasManager=false

UIShopControl:showShopWindow(bdData)
end


function UIShopWin:onHide()
self.isHide=true
self:clear()
self.buyerBTList={}
self.hasManager=false
end

function UIShopWin:refreshLeftPanel()
local dzId=self.bdData.dizi_id
if tostring(dzId)~='0'then
self.diziInfo:setActive(true)
local name=UIDiscipleModel:getDiscipleName(dzId)
self.dzName:setText(_format('执事弟子：<color=%s>%s</color>','#7d3b17',name))
local skill_id=self.config.pro_skill_id
local skill_cfg=cfgHelper.get1(cfg_discipleproskillconfig_get,skill_id)
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
local effect=nil
if skill_cfg.shangpu_effects then
effect=skill_cfg.shangpu_effects[level]
end




local sixAttrCfg=cfgHelper.getglobal1('discipleattr')
local sixAttrName=sixAttrCfg[sixAttrType].name
local sixAttrValue=UIDiscipleModel:getDiscipleBaseAttr(dzId,sixAttrType)
self.jobLevel:setText(_format('%s：%s级（%s %s）',skill_cfg.name,level,sixAttrName,sixAttrValue))

self.dizi_speciality=discipleSelectController.getSpeciallistByBuild(dzId,self.bdType)
if self.dizi_speciality then
self.scrollView:setActive(true)
self.scrollView:setChildScrollViewCreateGrids(#self.dizi_speciality,3)
local grids=self.scrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.dizi_speciality[i]
UIDiscipleModel.refreshSpecialityItemEx(item,data)
end
else
self.scrollView:setActive(false)
end

self.txtSelect:setText('更替')
self.infoText:setText('')

local shake=changeManagerCheckModel:getBuildingReddot(self.bdData.un_build_id)
self.btnSelectReddot:setActive(shake)
if shake then
self.winlua:SetChildDOTweenAnimation_DOPlay(self.btnSelect:getID())
else
self.winlua:SetChildDOTweenAnimation_DOPause(self.btnSelect:getID())
self.btnSelect:setRotation(0,0,0)
end
else
self.scrollView:setActive(false)
self.diziInfo:setActive(false)
self.txtSelect:setText('安排')
self.infoText:setText('<color=red>未安排弟子，无法进行生产</color>')

local reddot=changeManagerCheckModel:getBuildingReddot(self.bdData.un_build_id)
self.btnSelectReddot:setActive(reddot)
self.winlua:SetChildDOTweenAnimation_DOPause(self.btnSelect:getID())
self.btnSelect:setRotation(0,0,0)
end
self:refresEventInfo()
end

function UIShopWin:refresEventInfo()
self.xinqing:setText(UIShopModel:getMoodValue())
end

function UIShopWin:refresProbar()
self.proroot:setActive(self.hasManager)
if self.hasManager then
local bdData=self.bdData
local data=UIShopModel:getShopData(bdData.un_build_id)
local cur=UIShopControl:getClientCurReward(data)
local max=UIShopControl:getRewardMax(bdData)
self.progressbar:setChildUIProgressbar(cur,max,false)
self.timeProgressText:setText(FMT.fmt("{0}/{1}",mathHelper.formatNumber(cur),mathHelper.formatNumber(max)))
local rcv,errCode=UIShopControl:checkRcvState(bdData)
self.receiveBtn:setActive(rcv)
self.pauseTimeImg:setActive(errCode==2)

if errCode==2 then
local func=function()
local curTime=timeHelper.getServerShortTime()
local data=UIShopModel:getShopData(bdData.un_build_id)
local get_rewards_cd=cfgHelper.get(cfg_shangpubasicconfig_get,1,"get_rewards_cd")
local lastrecvtime=data.last_getautorewards_times or 0
local finishInterval=curTime-lastrecvtime
if finishInterval<get_rewards_cd then
local showTime=get_rewards_cd-finishInterval
self.recvTimetxt:setText(FMT.fmt("{0}后可领取灵石",timeHelper.format_time_stamp11(showTime)))
else
self:stopHandleTimer()
self.receiveBtn:setActive(true)
self.pauseTimeImg:setActive(false)
return
end
end
self:startHandleTimer(func)
func()
end
else
self:stopHandleTimer()
self.receiveBtn:setActive(false)
end

end

function UIShopWin:startHandleTimer(func)
if not self.HandleTimer then
self.HandleTimer=self:setTimer(1,0,func)
end
end

function UIShopWin:stopHandleTimer()
if self.HandleTimer then
self:stopTimerByID(self.HandleTimer)
self.HandleTimer=nil
end
end

function UIShopWin:refreshRightPanel()
local bdData=self.bdData
local id=bdData.build_id
local level=bdData.level
local cfg=cfgHelper.get2(cfg_shangpulevelconfig_get,id,level)
local shopData=UIShopModel:getShopData(bdData.un_build_id)
local data=cfg.item_create_conf[shopData.create_item_idx]
local icon=data.shop_item.icon
self.cIcon:setChildIcon(iconHelper.getItemIconName(icon),true)
local price=data.price[1]
self.sIcon:setChildIcon(iconHelper.getIconName(price[1]),true)
self.sCount:setText(price[2])
self.teding:setActive(data.sepcial_effects~=nil)

self.txtCurLevel:setText(FMT.fmt('{0}级{1}',bdData.level,self.config.name))
self.spName:setText(data.shop_item.name)

self.speakArgs={id,data.shop_item.name}

local cddata=buildingCDControl:getCDData(buildingCDType.build,bdData.un_build_id,true)
if cddata and cddata.complete then
self.btnUpgradeText:setText('完成升级')
return
end
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level+1)
self.btnUpgradeText:setText(nextLvCfg~=nil and'升级'or'建筑信息')
end




function UIShopWin:onClickSelect()
if self.workCheck1 or self.workCheck2 then
UIManager.error('工作交接中')
return
end
if UIShopControl:checkCreating(self.bdData)then
UIManager.error('当前商铺正在生产，不能更换弟子')
return
end
if tostring(self.bdData.dizi_id)~='0'then
if self.bdData.flag==buildingStateType.eBuilding then
UIManager.error('建筑正在建造中, 不能更换弟子')
return
elseif self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error('建筑正在升级中, 不能更换弟子')
return
end
if self.bdData.plant_id>0 then
UIManager.error('建筑执行生产中, 不能更换弟子')
return
end
else
if self.bdData.flag==buildingStateType.eBuilding then
UIManager.error('建筑正在建造中, 不能安排弟子')
return
elseif self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error('建筑正在升级中, 不能安排弟子')
return
end
end
zongmenControl:showSelectManagerWin(self.sfId,self.bdData,dzSelectWinOpenType.eManager,dzSelectEffectType.eShangPu)
end

function UIShopWin:onSettingBtn()
UIManager:showWindow('UIShopSettingWin')
end

function UIShopWin:onBtnUpgrade()
if UIShopControl:checkCreating(self.bdData)then
UIManager.error('商铺正在生产中无法升级')
return
end
UIManager:showWindow('UIBuildingInfoWin',self.bdData)
end

function UIShopWin:onReplaceBtn()
UIManager:showWindow('UICommodityReplaceWin',self.bdData)
end

function UIShopWin:onSelectBtn()
if self.bdData.flag~=0 then
UIManager.error('商铺升级中无法转型')
return
end
if UIShopControl:checkCreating(self.bdData)then
UIManager.error('当前商铺正在生产，不可转型')
return
end
local sdata=UIShopModel:getShopData(self.bdData.un_build_id)
if not sdata.is_in_event then
UIManager:showWindow('UIShopSelectWin',{self.bdData})
else
UIManager.error('当前商铺存在事件，不可转型')
end
end

function UIShopWin:onPaizi()
local cfg=cfgHelper.get1(cfg_shangpubasicconfig_get,1)
UIManager:showWindow('UICommonHelpWin',{x=-420,y=35,htype=3,content=cfg.xqtips})
end

function UIShopWin:onCountBtn()
UIShopControl:reqSellCount()
end

function UIShopWin:onClickClose()

AudioManager.playBtnClick()
fullScreenUI.closeActiveUI()
end

function UIShopWin:onLeftArrow()
self:toNextWin(-1)
end

function UIShopWin:onRightArrow()
self:toNextWin(1)
end

function UIShopWin:onReceiveBtn()
local bdData=self.bdData
local rcv=UIShopControl:checkRcvState(bdData)
if rcv then
UIShopControl:reqAutoCreateRecv(bdData.un_build_id)
end
end

