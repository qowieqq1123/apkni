







def_class("UICatEntrustWin",UIWindowBase)









function UICatEntrustWin:bindComponents()

self.catModelTemp=UIObject.get(self,0)
self.mainPart=UIObject.get(self,1)
self.playDoingAnimatPart=UIObject.get(self,2)
self.playDoingModelList=UIObject.get(self,3)
self.playDoingProgressBar=UIObject.get(self,4)
self.playDoingProgressKuang=UIProgressBarAni.get(self,5)
self.playDoingTipTxt=UIText.get(self,6)
self.progressWaitSpine=UIObject.get(self,7)
self.receiveBtn=UIButton.get(self,8)
self.receiveReddot=UIObject.get(self,9)
self.Root=UIObject.get(self,10)
self.startEntrustBtn=UIButton.get(self,11)
self.tipBtn=UIButton.get(self,12)
self.uiRoot=UIObject.get(self,13)
self.wtList=UIObject.get(self,14)
self.wtScrollView=UILoopListView.new(self,15)

self.receiveBtn:setButtonClick(function()self:onReceiveBtn()end)

self.startEntrustBtn:setButtonClick(function()self:onStartEntrustBtn()end)

self.tipBtn:setButtonClick(function()self:onTipBtn()end)

self.wtScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UICatEntrustWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.catModelTemp);self.catModelTemp=nil;
_UIObject_release(self.mainPart);self.mainPart=nil;
_UIObject_release(self.playDoingAnimatPart);self.playDoingAnimatPart=nil;
_UIObject_release(self.playDoingModelList);self.playDoingModelList=nil;
_UIObject_release(self.playDoingProgressBar);self.playDoingProgressBar=nil;
_UIObject_release(self.playDoingProgressKuang);self.playDoingProgressKuang=nil;
_UIObject_release(self.playDoingTipTxt);self.playDoingTipTxt=nil;
_UIObject_release(self.progressWaitSpine);self.progressWaitSpine=nil;
_UIObject_release(self.receiveBtn);self.receiveBtn=nil;
_UIObject_release(self.receiveReddot);self.receiveReddot=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.startEntrustBtn);self.startEntrustBtn=nil;
_UIObject_release(self.tipBtn);self.tipBtn=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.wtList);self.wtList=nil;
self.wtScrollView:deleteSelf();self.wtScrollView=nil;
end
















local _this

local defaultEntrustSlotItemName='CatEntrustItem'




function UICatEntrustWin:onLoaded(...)
self:bindComponents()


_this=self


self.wtLuaObjList={}


self.loopListView=self.winlua:GetChildUILoopListView(self.wtScrollView:getID())
self.loopListViewCmp=self.winlua:GetChildLoopListView2(self.wtScrollView:getID())
self.loopListView:SetAction(function(...)
self:bindWTWidget(...)
end,function(...)
self:onStartView(...)
end)

self:initPlayAnmation()

UIManager.setMoneyMsgShowState(true,true)

self:addNotify(notifyConfig.on_item_list_changed,function(...)self:on_item_list_changed(...)end)
self:addNotify(notifyConfig.onWanBaoXunBaoDuiCatTiLiChange,function(...)self:onWanBaoXunBaoDuiCatTiLiChange(...)end)
self:addNotify(notifyConfig.on_money_changed,function(...)self:on_money_changed(...)end)
end


function UICatEntrustWin:__delete()
self:unbindComponents()

self:resetAllCreateLuaObject()

UIManager.setMoneyMsgShowState(false,true)
end




function UICatEntrustWin:onShow(argtable,afterOnloaded)
catEntrustModel:refreshLocalizeCatEntrustDataListToCurrent()

catEntrustModel:updateCatEntrustListTOPrepareState()

self:refreshAll()

self:initPlayAnmation()

self:showWindow("UITopMoneyWin2",{{eMoneyType.mtLingPai}})
end


function UICatEntrustWin:onHide()

end


function UICatEntrustWin:refreshAll()
self:refreshEntrustList()
self:refreshBottomPart()
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','checkTalk')
end


function UICatEntrustWin:refreshEntrustList()

self.entrustSlotList=catEntrustModel:getSortEntrustSlotDataList()
local slotListLen=#self.entrustSlotList


self.wtList:setChildLayoutGroupCreateItems(slotListLen,function(index)
local item=self.wtList:getChildLayoutGroupGridItem(index-1)
self:bindWTWidget(index-1,item)
end)
end

function UICatEntrustWin:refreshBottomPart()
local isHasReceive=catEntrustModel:checkHasReceiveSlot()
self.startEntrustBtn:setActive(not isHasReceive)
self.receiveBtn:setActive(isHasReceive)
end

function UICatEntrustWin:refreshEntrustListItemData()
self.entrustSlotList=catEntrustModel:getEntrustSlotDataList()


local dataLen=#self.entrustSlotList
local objLen=#self.wtLuaObjList
if dataLen==objLen then
for index=1,dataLen do
local wtInfo=self.entrustSlotList[index]
local luaObject=self.wtLuaObjList[index]
luaObject:onShow({wtInfo=wtInfo,index=index,id=_this.id})
end
else
self:refreshEntrustList()
end
end



function UICatEntrustWin:onStartAction()
end
function UICatEntrustWin:onFreshAction()
end
function UICatEntrustWin:onStartView()
end


function UICatEntrustWin:bindWTWidget(index,widget)
index=index+1

local wtInfo=self.entrustSlotList[index]
local luaObject=self.wtLuaObjList[index]

if luaObject then
UICloneObject.release(luaObject)
end

luaObject=self:createLuaObject(index,widget)

local func=function()
luaObject:onShow({wtInfo=wtInfo,index=index})
end
xpcall(func,function(err)
logErr("UICatEntrustWin bindWTWidget err",err,wtInfo.wtType,wtInfo.guid)
end)
end

function UICatEntrustWin:createLuaObject(index,widget)
local wtInfo=self.entrustSlotList[index]
local compName=wtInfo.prefabName
local luaObject=UICloneObject.get(compName)
self.wtLuaObjList[index]=luaObject
luaObject:setWidget(widget)
luaObject:onLoaded()
return luaObject
end

function UICatEntrustWin:resetAllCreateLuaObject()
for k,luaObject in pairs(self.wtLuaObjList)do
UICloneObject.release(luaObject)
end

self.wtLuaObjList=nil
end

function UICatEntrustWin:refreshAllSlot()
if self.wtLuaObjList then
local slotListLen=#self.entrustSlotList
for index=1,slotListLen do
local wtInfo=self.entrustSlotList[index]
local luaObject=self.wtLuaObjList[index]

local func=function()
luaObject:onShow({wtInfo=wtInfo,index=index})
end
xpcall(func,function(err)
logErr("UICatEntrustWin bindWTWidget err",err,wtInfo.wtType,wtInfo.guid)
end)
end
end
end



function UICatEntrustWin:initPlayAnmation()
self.playDoingAnimatPart:setActive(false)
end

function UICatEntrustWin:preparePlayDoingAnimation(wtSlotDataList)

self.playDoingAnimatPart:setActive(true)


self:refreshAll()


local len=#wtSlotDataList
if len>0 then
self.playDoingModelList:setChildLayoutGroupCreateItems(len,function(index)
local item=self.playDoingModelList:getChildLayoutGroupGridItem(index-1)
local wtSlotData=wtSlotDataList[index]

local catGuid=wtSlotData.data.dispatchCatGuid
local catData=wanBaoXunBaoDuiModel:getCatData(catGuid)

local modelid,components=wanbaoXunBaoDuiHelper:getCatModelCaptureImageParam(catData)
item:SetChildUIModelShowTarget(-1,modelid,1.5,components,eAnimationID.run,false,false,0.2,nil)
item:SetChildUIModelShowFlipX(-1,true)
end)
end


self:playDoingAnimation(len,wtSlotDataList)
end

function UICatEntrustWin:playDoingAnimation(len,wtSlotDataList)
local _this=self

local timeList={}
local doing_time=catEntrustConfig.getBaseInfo('doing_time')
local totalDuration=0

local start_end_txt=catEntrustConfig.getBaseInfo('start_end_txt')
local txtList={string.toTable(start_end_txt[1])}

local caculTime=function(worlds,isShowWaitSpine)
local startWorldTime=#worlds*doing_time[1]
totalDuration=totalDuration+startWorldTime
if isShowWaitSpine then
totalDuration=totalDuration+doing_time[2]
end
timeList[#txtList]=totalDuration
end
caculTime(txtList[1],true)


local curTime=0

for index=1,len do
local wtSlotData=wtSlotDataList[index]
local wtType=wtSlotData.data.entrustType
local funcObj=catEntrustConfig.getEntrustFuncObj(wtType)
local txt=funcObj.getDoingPlayTxt(wtSlotData)
local worldT=string.toTable(txt)
txtList[#txtList+1]=worldT
caculTime(worldT,true)
end
txtList[#txtList+1]=string.toTable(start_end_txt[2])
caculTime(txtList[#txtList],true)

local getTxtTSubStr=function(txtT,sIndex,eIndex)
local strTemp=""
for index=sIndex,eIndex do
strTemp=strTemp..txtT[index]
end
return strTemp
end


local getTxt=function(index,time)
local txtT=txtList[index]
local charLen=#txtT

local preTime=timeList[index-1]or 0
local residueTime=time-preTime
local charIndex=Mathf.Ceil(residueTime/doing_time[1])
local isSplit=charLen>=charIndex
charIndex=isSplit and charIndex or charLen

return getTxtTSubStr(txtT,1,charIndex),isSplit
end


local curShowSpeakIndex=1
local isShowWaitSpine=false
local func=function()
curTime=curTime+Time.deltaTime
if curTime>=totalDuration then
_this:stopTimerByID(_this.playTimerID)
_this.playTimerID=nil

_this:finishPlayDoingAnimation(len,wtSlotDataList)
else

self.playDoingProgressBar:setChildIconFillAmount(curTime/totalDuration)


local txt,isSplit=getTxt(curShowSpeakIndex,curTime)
_this.playDoingTipTxt:setText(txt)
_this.progressWaitSpine:setActive(not isSplit)
if not isSplit and not isShowWaitSpine then
isShowWaitSpine=true
_this.progressWaitSpine:setChildUIModelShowTarget(5476,1,{},eAnimationID.stand,false,false,0.1)
end

if curTime>=timeList[curShowSpeakIndex]then
curShowSpeakIndex=curShowSpeakIndex+1
isShowWaitSpine=false
end
end
end

if self.playTimerID then
_this:stopTimerByID(self.playTimerID)
self.playTimerID=nil
end

self.playTimerID=self:setTimer(0.05,-1,func)
end

function UICatEntrustWin:finishPlayDoingAnimation(len,wtSlotDataList)
for index=1,len do
local wtSlotData=wtSlotDataList[index]
wtSlotData.state=Cat_Entrust_State_Type.End
wtSlotData.data.isFinish=true
end

catEntrustController.showPrize()

end
function UICatEntrustWin:showPrizeCallBack()
self:refreshAll()
self:initPlayAnmation()
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','refreshMenuReddot',4)
end


function UICatEntrustWin:updateItemsSlider(updateWtSlotIndexList)
local len=#updateWtSlotIndexList
if len>0 then
for index=1,len do
local wtIndex=updateWtSlotIndexList[index]
local obj=self.wtLuaObjList[wtIndex]
if obj then
obj:refreshSliderRoot()
end
end
end
end


local talkType={reward=1,dispatch=2,stand=3,endAll=4}
function UICatEntrustWin:getTalkList()
local talkList={}
if self.entrustSlotList then
local index=talkType.endAll
for k,wtSlotData in ipairs(self.entrustSlotList)do
if wtSlotData.state==Cat_Entrust_State_Type.Finish then
index=talkType.reward
end

if wtSlotData.state==Cat_Entrust_State_Type.Prepare then
index=index>talkType.dispatch and talkType.dispatch or index
end

if wtSlotData.state==Cat_Entrust_State_Type.Stand then
index=index>talkType.stand and talkType.stand or index
end
end
local dog_talk_info_list=catEntrustConfig.getBaseInfo('dog_talk_info_list')
return dog_talk_info_list[index]
end
return talkList
end


function UICatEntrustWin:on_item_list_changed(array)
local isRefreshAll=false
local fresh_win_itemid_list=catEntrustConfig.getBaseInfo('fresh_win_itemid_list')
for k,itemdata in ipairs(array or{})do
local itemid=itemdata[3]
if table.findValue(fresh_win_itemid_list,itemid)then
isRefreshAll=true
end
end
if isRefreshAll then
self:refreshAllSlot()
end
end

function UICatEntrustWin:onWanBaoXunBaoDuiCatTiLiChange(catGuid)
self:refreshAllSlot()

local wtIndex
for index,wtSlotData in ipairs(self.entrustSlotList)do
if wtSlotData.data.dispatchCatGuid==catGuid then
wtIndex=index
break
end
end

if wtIndex then
local obj=self.wtLuaObjList[wtIndex]
obj:startShowRestoreTiliSpine()
end
end


function UICatEntrustWin:on_money_changed(mtype,last,curr)
local fresh_win_itemid_list=catEntrustConfig.getBaseInfo('fresh_win_itemid_list')
if table.findValue(fresh_win_itemid_list,mtype)then
self:refreshAll()
end
end





function UICatEntrustWin:onStartEntrustBtn()
if catEntrustModel:checkWtListCondition()then
catEntrustController:reqStartCatEnstrust()
end
end


function UICatEntrustWin:onReceiveBtn()
catEntrustController:reqReceiveCatEntrustReward()
end




function UICatEntrustWin:onTipBtn()
local d={}
d.mode=3
d.title="说明"
d.name='cat_entrust_main_rule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

