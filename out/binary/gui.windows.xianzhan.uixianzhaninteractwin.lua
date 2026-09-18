







def_class("UIXianZhanInteractWin",UIWindowBase)









function UIXianZhanInteractWin:bindComponents()

self.backBlock=UIObject.get(self,0)
self.bottomPanel=UIObject.get(self,1)
self.btnListPanel=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.descObj=UIObject.get(self,4)
self.descTxt=UIText.get(self,5)
self.hgdBtn=UIButton.get(self,6)
self.hgdEventBtn=UIButton.get(self,7)
self.hgdEventBtnRoot=UIObject.get(self,8)
self.hgdEventIcon=UIImage.get(self,9)
self.leftButton=UIButton.get(self,10)
self.leftPanel=UIObject.get(self,11)
self.mask=UIObject.get(self,12)
self.modelImage=UIObject.get(self,13)
self.modelObj=UIObject.get(self,14)
self.nextBtnRoot=UIObject.get(self,15)
self.progressName=UIText.get(self,16)
self.progressTxt=UIText.get(self,17)
self.progressValImg=UIObject.get(self,18)
self.progressValue=UIObject.get(self,19)
self.rightButton=UIButton.get(self,20)
self.rightPanel=UIObject.get(self,21)
self.speakObj=UIObject.get(self,22)
self.speakText=UIText.get(self,23)
self.visitorName=UIText.get(self,24)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.hgdBtn:setButtonClick(function()self:onHgdBtn()end)

self.hgdEventBtn:setButtonClick(function()self:onHgdEventBtn()end)

self.leftButton:setButtonClick(function()self:onLeftButton()end)

self.rightButton:setButtonClick(function()self:onRightButton()end)



end


function UIXianZhanInteractWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backBlock);self.backBlock=nil;
_UIObject_release(self.bottomPanel);self.bottomPanel=nil;
_UIObject_release(self.btnListPanel);self.btnListPanel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.descObj);self.descObj=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.hgdBtn);self.hgdBtn=nil;
_UIObject_release(self.hgdEventBtn);self.hgdEventBtn=nil;
_UIObject_release(self.hgdEventBtnRoot);self.hgdEventBtnRoot=nil;
_UIObject_release(self.hgdEventIcon);self.hgdEventIcon=nil;
_UIObject_release(self.leftButton);self.leftButton=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.modelImage);self.modelImage=nil;
_UIObject_release(self.modelObj);self.modelObj=nil;
_UIObject_release(self.nextBtnRoot);self.nextBtnRoot=nil;
_UIObject_release(self.progressName);self.progressName=nil;
_UIObject_release(self.progressTxt);self.progressTxt=nil;
_UIObject_release(self.progressValImg);self.progressValImg=nil;
_UIObject_release(self.progressValue);self.progressValue=nil;
_UIObject_release(self.rightButton);self.rightButton=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.visitorName);self.visitorName=nil;
end

















local winsList={
[XianZhanInteractType.eTalk]='UIXianZhanTalkWin',
[XianZhanInteractType.eTransaction]='UIXianZhanTransactionWin',
[XianZhanInteractType.eEntrust]='UIXianZhanEntrustWin',
}

local btnFunctions={

[1]={
refresh=function(win,item,index)
item:SetChildCSImageSprite(0,globalABLookup.xianzhanIcon,'icon_tanhua_1')
end,
onclick=function(win,index)
win:onTalkBtn()
end
},

[2]={
refresh=function(win,item,index)
item:SetChildCSImageSprite(0,globalABLookup.xianzhanIcon,'icon_jiaoyi_1')
end,
onclick=function(win,index)
win:onTransactionBtn()
end
},

[3]={
checkShow=function(roomData)
return roomData.wtTaskId>0
end,
refresh=function(win,item,index)
item:SetChildCSImageSprite(0,globalABLookup.xianzhanIcon,'icon_weituo_1')
win:refreshWeiTuoBtn()
end,
onclick=function(win,index)
win:onEntrustBtn()
end
},

[4]={
refresh=function(win,item,index)
item:SetChildCSImageSprite(0,globalABLookup.xianzhanIcon,'icon_zhuke_1')
end,
onclick=function(win,index)
win:onOutBtn()
end
},
}

local lookingTime=5
local _this=nil


function UIXianZhanInteractWin:onLoaded(...)
_this=self
self:bindComponents()
self.activeWin={}
end


function UIXianZhanInteractWin:__delete()
local roomId=self.roomId
_this=nil
self:closeAllWin()
self:unbindComponents()
xianzhanController:resetCameraToRoom(roomId)
end

function UIXianZhanInteractWin:myEnterAnim()















local func=function()
self:sayHello()
end
self:delayDo(0.5,func)
end




function UIXianZhanInteractWin:onShow(argtable,afterOnloaded)
if afterOnloaded or argtable.playAnim then
self:myEnterAnim()
end
self.roomId=argtable[1]
self.data=xianzhanModel:getRoomDataByRoomId(self.roomId)

self:initRoomList()
self:refreshNextBtn()





local openWinType=argtable[2]
if openWinType then
self:showWinEx(openWinType)
end

local config=cfgHelper.get1(cfg_xianzhanfangkeconfig_get,self.data.customerId)
self.config=config
self:initFangKeInfo()
self:refreshHaoGanDu(self.roomId)

local grid=self.btnListPanel:getChildCommonLayoutGroupWidgetList()
local count=grid.Count
for i=1,count do
local item=self.btnListPanel:getChildCommonLayoutGroupWidgetItem(i-1)
local check=btnFunctions[i]
local isShow=true
if check.checkShow then
isShow=check.checkShow(self.data)
end
item:SetChildActive(-1,isShow)
if isShow then
check.refresh(self,item,i)
item:SetChildButtonClick(-1,function()
check.onclick(self,i)
end)
end
end

if self.actTimer==nil then
local func=function()
self:refreshMyTimer()
end
self.actTimer=self:setTimer(1,0,func)
self:refreshMyTimer()
end
end

function UIXianZhanInteractWin:refreshMyTimer()
local lerp
local customerId=self.data.customerId
if customerId>0 then
if self.data.ybFlag==1 and self.data.leaveTime>0 then
local curTime=timeHelper.getServerShortTime()
lerp=self.data.leaveTime-curTime
if lerp<0 then
lerp=0
end
end
end
local showTime=lerp~=nil
self.descObj:setActive(showTime)
if showTime then
local time_str
if lerp>0 then
time_str=FMT.fmt('访客离店:<color=#76d81e>{0}</color>',timeHelper.format_time_stamp3(lerp))
else
time_str='访客已离开'
end
self.descTxt:setText(time_str)
end
end

function UIXianZhanInteractWin:activeRightPanel(isActive)
local val=isActive==true and 1 or 0
self.rightPanel:setChildCanvasGroupDOFade(val,0.3,nil)
end


function UIXianZhanInteractWin:onHide()

end

function UIXianZhanInteractWin:showWin(winType)
local win=winsList[winType]
if win then
UIManager:showWindow(win,self.roomId)
self.activeWin[win]=true
end
self.btnListPanel:setActive(false)
end

function UIXianZhanInteractWin:showWinEx(winType)
if winType==XianZhanInteractType.eTalk then
self:onTalkBtn()
elseif winType==XianZhanInteractType.eTransaction then
self:onTransactionBtn()
elseif winType==XianZhanInteractType.eEntrust then
self:onEntrustBtn()
end
end

function UIXianZhanInteractWin:closeWin(winType)
local win=winsList[winType]
if win then
UIManager:hideWindow(win)
end
self.btnListPanel:setActive(true)
end

function UIXianZhanInteractWin:closeAllWin()
for k,v in pairs(self.activeWin)do
UIManager:closeWindow(k)
end
end


function UIXianZhanInteractWin:initFangKeInfo()
local npcid=self.data.customerId
local jjlv=npcModel:getNPCJingJie(npcid)
local jjname=UIDiscipleModel.getJJNameCommon(jjlv,3)
local namestr=FMT.fmt('{0}　{1}',jjname,xianzhanModel.getFangKeName(self.config.id))
self.visitorName:setText(namestr)
local modelParams=xianzhanModel:getCustomerInSideModelInfo(self.config)
self.modelImage:setChildUIModelShowTarget(modelParams.body,1,modelParams.componets,eAnimationID.stand,false,true)

end

function UIXianZhanInteractWin:sayHello()
local speakList=self.config.interactContent
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
self:refreshSpeakStr(speakStr)
end

function UIXianZhanInteractWin:refreshSpeakStr(speakStr)
self:startTalk({speakStr},nil)
end


function UIXianZhanInteractWin:refreshHaoGanDu(roomId,animation)
if self.roomId==roomId then
local data=xianzhanModel:getRoomDataByRoomId(roomId)
local npcid=data.customerId
local hgd=npcModel:getNPCIntimacy(npcid)
self:refreshHaoGanDuEx(hgd,animation)

self:refreshHaoGanDuEevnt()
end
end

function UIXianZhanInteractWin:refreshHaoGanDuEx(hgd,animation)
local hgdname=npcModel.getHaoGanDuName(hgd)
local fontSize=22
local len=string.lenEx(hgdname)
if len>=4 then
fontSize=19
end
self.winlua:SetChildTextFontSize(self.progressName:getID(),fontSize)
self.progressName:setText(hgdname)
local lv,rate,cur,max,isFull=npcModel.getHaoGanDuLevel(hgd)
if isFull then
rate=1
end
if animation then
helper.playProgressAnim(self.progressValue,rate,0,nil,nil,nil,2)
else
self.progressValue:setChildIconFillAmount(rate)
end
local str
if not isFull then
str=tostring(cur)
else
str='已满'
end
self.progressTxt:setText(str)


local posY=rate*291
self.progressValImg:setChildAnchoredPosition(Vector2(0,posY))
end

function UIXianZhanInteractWin:kickOutRefreshHaoGanDu(oldhgd,curhgd)
self:refreshHaoGanDuEx(curhgd,true)
end


function UIXianZhanInteractWin:refreshWeiTuoBtn(roomId)
if roomId~=nil and roomId~=self.roomId then return end
local index=3
local item=self.btnListPanel:getChildCommonLayoutGroupWidgetItem(index-1)
local data=xianzhanModel:getRoomDataByRoomId(self.roomId)
local isshow=data.wtTaskId~=0
item:SetChildActive(-1,isshow)
if isshow then
local isComplete=data.wtTaskStaus==1
item:SetChildActive(1,isComplete)
end
end


function UIXianZhanInteractWin:fkOutSpeak(callback)
self.leftButton:setActive(false)
self.rightButton:setActive(false)
self.btnListPanel:setActive(false)
local speakStr=self.config.extrudeSpeak
self.mask:setActive(true)
self.isOutTalking=true
local func=function(...)
if _this==nil then return end
self.isOutTalking=false
self.mask:setActive(false)
if callback then
callback()
end
self:onCloseBtn()
end
self:startTalk({speakStr},func)
end



function UIXianZhanInteractWin:startTalk(speakList,callback,breakback)
if self.breakback~=nil then
self.breakback()
self.breakback=nil
end
self.speakList=speakList
self.speakNum=#self.speakList
self.callback=callback
self.breakback=breakback
self.speakIndex=0
self:doNext()
end

function UIXianZhanInteractWin:doNext()
self.speakIndex=self.speakIndex+1
if self.speakIndex<=self.speakNum then
self:showTalk()
else
self:finishTalk()
end
end

function UIXianZhanInteractWin:checkFinishTalk()
if self.speakIndex then
return self.speakIndex>self.speakNum
end
return true
end

function UIXianZhanInteractWin:showTalk()

local desc=self.speakList[self.speakIndex]

local speed=30
self.talking=true
local func=function()
if _this==nil then return end
_this:talkFinish()
end
self.speakText:setChildTrendsTextPlay(desc,speed,func)
self:doTalkAnim()
end

function UIXianZhanInteractWin:doTalkAnim()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
self.speakObj:setScale(Vector3.zero)
self:delayDo(0.2,function()
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
end)
end)
end)
end

function UIXianZhanInteractWin:talkFinish()
self.talking=false
self:clearLookingTimer()
self:setLookingTimer()
end

function UIXianZhanInteractWin:setLookingTimer()
local func=function()
self:doNext()
end
self.lookingTimer=self:setTimer(lookingTime,1,func)
end

function UIXianZhanInteractWin:clearLookingTimer()
if self.lookingTimer~=nil then
self:stopTimerByID(self.lookingTimer)
self.lookingTimer=nil
end
end

function UIXianZhanInteractWin:finishTalk()
self.breakback=nil
local cb=self.callback
if cb~=nil then
self.callback=nil
cb()
end
end

function UIXianZhanInteractWin:quicklyPlay()
if self.talking then
self.talking=false
self.speakText:setChildTrendsTextStop()
self:clearLookingTimer()
self:setLookingTimer()
else
self:clearLookingTimer()
self:doNext()
end
end

function UIXianZhanInteractWin:clickMask()
if self.isOutTalking then
self:quicklyPlay()
else
self.mask:setActive(false)
self:onCloseBtn()
end
end

function UIXianZhanInteractWin:onHgdBtn()
local npcid=self.data.customerId
self:showWindow('UINPCIntimacyRewardWin',{npcid=npcid})
end

function UIXianZhanInteractWin:refreshHaoGanDuEevnt()
local npcid=self.data.customerId
local reward=npcModel:checkIntimacyReward(npcid)
local showEvent=reward~=nil
self.hgdEventBtn:setActive(showEvent)
if showEvent then
local info=npcModel.getIntimacyRewardInfo(reward)
self.hgdEventIcon:setSprite(globalABLookup.npcCommonIcons,info[2])
end
self:doHgdEventBtnAnim(showEvent)
end

function UIXianZhanInteractWin:onHgdEventBtn()
local npcid=self.data.customerId
local rw,lv=npcModel:checkIntimacyReward(npcid)
if rw then
npcController:reqIntimacyReward(npcid,lv)
end
end

function UIXianZhanInteractWin:doHgdEventBtnAnim(flag)
if self.hgdEventBtnTween then
self.hgdEventBtnTween:Kill()
self.hgdEventBtnTween=nil
end
if self.hgdEventBtnTweenTimer then
self:stopTimerByID(self.hgdEventBtnTweenTimer)
self.hgdEventBtnTweenTimer=nil
end
if flag then
self.hgdEventBtnRoot:setRotation(0,0,0)
local func=function()
if _this==nil then return end
_this.hgdEventBtnTween=nil

_this.hgdEventBtnTweenTimer=_this:delayDo(3,function()
if _this==nil then return end
_this.hgdEventBtnTweenTimer=nil
_this:doHgdEventBtnAnim(true)
end)
end
local tweener=self.hgdEventBtnRoot:setChildDOPunchRotation(Vector3(0,0,15),2,6,1,func)
self.hgdEventBtnTween=tweener
end
end



function UIXianZhanInteractWin:onTalkBtn()
self:showWin(XianZhanInteractType.eTalk)
self:restChatSpeak()
end

function UIXianZhanInteractWin:restChatSpeak()
local chatContent=self.config.chatContent
local rand=math.random(1,#chatContent)
local speakStr=chatContent[rand]
self:refreshSpeakStr(speakStr)
end

function UIXianZhanInteractWin:onTransactionBtn()
self:showWin(XianZhanInteractType.eTransaction)
end

function UIXianZhanInteractWin:onEntrustBtn()
if self.data.wtTaskId==0 then
UIManager.info('访客没有委托任务')
return
end
self:showWin(XianZhanInteractType.eEntrust)
end

function UIXianZhanInteractWin:onOutBtn()
local npcid=self.data.customerId
local hgd=npcModel:getNPCIntimacy(npcid)
local level=npcModel.getHaoGanDuLevel(hgd)
local delhgd=xianzhanModel:getKickoutFKHanGanDu(self.data.customerId,level)
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt('确定驱逐该访客？\n（驱逐访客会降低<color=#549327>{0}点</color>亲密度）',delhgd),
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function(...)
if _this==nil then return end
local data=xianzhanModel:getRoomDataByRoomId(_this.roomId)
xianzhanModel:setBeforeKickOutData(data)
xianzhanController:req_fk_out(_this.roomId)
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end

function UIXianZhanInteractWin:onCloseBtn()
self:closeSelf()
end

function UIXianZhanInteractWin:onModelBtn()
local clickChatContent=self.config.clickChatContent
local maxnum=clickChatContent[1]
local index=self.clickModelTalkIndex or 1
local talklist
if index>maxnum then
index=maxnum
talklist=clickChatContent[2]
else
talklist=self.config.chatContent
end
local speakStr=table.randomIndex(talklist)
self:refreshSpeakStr(speakStr)
index=index+1
self.clickModelTalkIndex=index
end

function UIXianZhanInteractWin:recv_reward(npcid)
local npcid_=self.data.customerId
if npcid_==npcid then
self:refreshHaoGanDuEevnt()
end
end

function UIXianZhanInteractWin:initRoomList()
self.sortRoomList={}

local roomList=xianzhanModel:getRoomsData()or{}

for k,v in ipairs(roomList)do
if v.customerId and v.customerId>0 then
table.insert(self.sortRoomList,v)
end
end

for k,v in ipairs(self.sortRoomList)do
if v.roomId==self.roomId then
self.roomIndex=k
end
end
end

function UIXianZhanInteractWin:refreshNextBtn()
local len=#self.sortRoomList

self.leftButton:setActive(self.roomIndex>1)
self.rightButton:setActive(self.roomIndex<len)
self.nextBtnRoot:setActive(len>1)
end

function UIXianZhanInteractWin:onLeftButton()
local index=self.roomIndex-1
local roomId=self.sortRoomList[index]and self.sortRoomList[index].roomId

self.speakObj:setChildCanvasGroupAlpha(0)
self:talkFinish()
xianzhanController:showInteractWin({roomId,playAnim=true})
UIManager:invokeUIMethod('UIXianZhanTalkWin','onBackBtn')
UIManager:invokeUIMethod('UIXianZhanEntrustWin','onBtnClose')
end

function UIXianZhanInteractWin:onRightButton()
local index=self.roomIndex+1
local roomId=self.sortRoomList[index]and self.sortRoomList[index].roomId

self.speakObj:setChildCanvasGroupAlpha(0)
self:talkFinish()
xianzhanController:showInteractWin({roomId,playAnim=true})
UIManager:invokeUIMethod('UIXianZhanTalkWin','onBackBtn')
UIManager:invokeUIMethod('UIXianZhanEntrustWin','onBtnClose')
end