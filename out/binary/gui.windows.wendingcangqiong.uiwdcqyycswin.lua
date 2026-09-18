







def_class("UIWDCQYYCSWin",UIWindowBase)









function UIWDCQYYCSWin:bindComponents()

self.background=UIButton.get(self,0)
self.goBtn=UIButton.get(self,1)
self.leftHead=UIObject.get(self,2)
self.leftPlayer=UIText.get(self,3)
self.loseHead_1=UIObject.get(self,4)
self.loseHead_2=UIObject.get(self,5)
self.nameImg=UIImage.get(self,6)
self.readyImg=UIObject.get(self,7)
self.rightHead=UIObject.get(self,8)
self.rightPlayer=UIText.get(self,9)
self.startImg1=UIObject.get(self,10)
self.startImg2=UIObject.get(self,11)
self.timeTips=UIText.get(self,12)
self.uiRoot=UIObject.get(self,13)

self.background:setButtonClick(function()self:onBackground()end)

self.goBtn:setButtonClick(function()self:onGoBtn()end)
self.loseHead={
self.loseHead_1,
self.loseHead_2,
}



end


function UIWDCQYYCSWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.goBtn);self.goBtn=nil;
_UIObject_release(self.leftHead);self.leftHead=nil;
_UIObject_release(self.leftPlayer);self.leftPlayer=nil;
_UIObject_release(self.loseHead_1);self.loseHead_1=nil;
_UIObject_release(self.loseHead_2);self.loseHead_2=nil;
_UIObject_release(self.nameImg);self.nameImg=nil;
_UIObject_release(self.readyImg);self.readyImg=nil;
_UIObject_release(self.rightHead);self.rightHead=nil;
_UIObject_release(self.rightPlayer);self.rightPlayer=nil;
_UIObject_release(self.startImg1);self.startImg1=nil;
_UIObject_release(self.startImg2);self.startImg2=nil;
_UIObject_release(self.timeTips);self.timeTips=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
self.loseHead=nil;
end















local _this=nil
local _nonePlayerName="暂无对手"
local _abName="ui/windows/wendingcangqiong/wdcq_atlas_pak.ab"
local _nameImages={
[WDCQCGameStageEnum.eSemi]="image_wendingcqiong_05",
[WDCQCGameStageEnum.eThird]="image_wendingcqiong_04",
[WDCQCGameStageEnum.eChampion]="image_wendingcqiong_06",
}



function UIWDCQYYCSWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onRequestPhpServerNamesRecv,self.onRequestPhpServerNamesRecv)
end


function UIWDCQYYCSWin:__delete()
self:unbindComponents()
_this=nil
end




function UIWDCQYYCSWin:onShow(argtable,afterOnloaded)
self:showNextView()
end


function UIWDCQYYCSWin:onHide()

end




function UIWDCQYYCSWin:onGoBtn()
if self.showData then
wdcqLiveBroadcastRoomController:enterLiveRoom(self.showData.group,self.showData.phase,self.showData.order)
end


end

function UIWDCQYYCSWin:onBackground()
self:showNextView()
end

function UIWDCQYYCSWin:doCloseWin()
WDCQModel:refreshBookWin()

if WDCQModel:hasBookWin()then
msgWinControl:addMsgWin(msgWinType.eWDCQYYCS,nil,nil,true)
end

self:closeSelf()
end

function UIWDCQYYCSWin:showNextView()
self.showData=WDCQModel:getShowBookWin()
if self.showData then
local group=self.showData.group
local phase=self.showData.phase
local order=self.showData.order
local flag=self.showData.flag
local matchInfo=WDCQController.getMacthInfo(group,phase,order)
if matchInfo then
local matchCfg=cfgHelper.get2(cfg_wendingcangqiongmatchconfig_get,group,phase)
local roundCfg=WDCQController.getRoundCfg(group,phase,order)
for i=1,2 do
local nameCmp=i==1 and self.leftPlayer or self.rightPlayer
local headCmp=i==1 and self.leftHead:getID()or self.rightHead:getID()
local actor_id=matchInfo[FMT.fmt("actor_id_{0}",i)]
local name=matchInfo[FMT.fmt("name_{0}",i)]
local server_id=matchInfo[FMT.fmt("server_id_{0}",i)]
local iconInfo=matchInfo[FMT.fmt("iconInfo{0}",i)]
local isLose=mathHelper.validInt64(actor_id)and name==''
name=playerModel:getOtherActorName(name)
if mathHelper.validInt64(actor_id)or isLose then
local serverName=loginModel:getServerNameEx(server_id,"")
local strName=FMT.fmt("[{0}]\n{1}",serverName,name)
if playerModel:checkActorId(actor_id)then
strName=FMT.cfmt3("76D81E",strName)
end
nameCmp:setText(strName)
else
nameCmp:setText(_nonePlayerName)
end
if not isLose then
playerController:setHeadIcon(self.winlua,headCmp,{iconInfo=iconInfo})
end
self.loseHead[i]:setActive(isLose)
end

local tipsStr=""
if flag==1 then
local longstamp=timeHelper.convertLongStamp(roundCfg.startTime)
if roundCfg.startTime%3600==0 then
tipsStr=FMT.fmt("（{0}点进行对决）",timeHelper.dateServerStamp('%H',longstamp))
else
tipsStr=FMT.fmt("（{0}进行对决）",timeHelper.getTwoFormatByStamp(longstamp))
end
end
self.timeTips:setText(tipsStr)

self.nameImg:setSprite(_abName,_nameImages[phase]or"")

self.startImg1:setActive(flag==2)
self.startImg2:setActive(flag==1 and matchCfg.book==2)
self.readyImg:setActive(flag==1 and matchCfg.book==1)
end

WDCQModel:removeBookWin(group,phase,order,flag)
WDCQModel:finishBookData(group,phase,order,flag)
WDCQModel:saveBookData()
else
self:doCloseWin()
end
end

function UIWDCQYYCSWin.onRequestPhpServerNamesRecv(secFlag)
if secFlag then
local group=_this.showData.group
local phase=_this.showData.phase
local order=_this.showData.order
local flag=_this.showData.flag
local matchInfo=WDCQController.getMacthInfo(group,phase,order)
if matchInfo then
local matchCfg=cfgHelper.get2(cfg_wendingcangqiongmatchconfig_get,group,phase)
local roundCfg=WDCQController.getRoundCfg(group,phase,order)
for i=1,2 do
local nameCmp=i==1 and _this.leftPlayer or _this.rightPlayer
local actor_id=matchInfo[FMT.fmt("actor_id_{0}",i)]
local name=matchInfo[FMT.fmt("name_{0}",i)]
local server_id=matchInfo[FMT.fmt("server_id_{0}",i)]
local iconInfo=matchInfo[FMT.fmt("iconInfo{0}",i)]
local isLose=mathHelper.validInt64(actor_id)and name==''
if mathHelper.validInt64(actor_id)or isLose then
local serverName=loginModel:getServerNameEx(server_id,"")
local strName=FMT.fmt("[{0}]\n{1}",serverName,name)
if playerModel:checkActorId(actor_id)then
strName=FMT.cfmt3("76D81E",strName)
end
nameCmp:setText(strName)
else
nameCmp:setText(_nonePlayerName)
end
end
end
end
end