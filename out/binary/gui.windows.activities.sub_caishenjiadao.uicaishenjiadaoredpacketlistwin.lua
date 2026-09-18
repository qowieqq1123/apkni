







def_class("UICaiShenJiaDaoRedPacketListWin",UIWindowBase)









function UICaiShenJiaDaoRedPacketListWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.numTx=UIText.get(self,1)
self.redpacketBtn=UIButton.get(self,2)
self.redpacketList=UIEnhancedScrollerLua.get(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.redpacketBtn:setButtonClick(function()self:onRedpacketBtn()end)



end


function UICaiShenJiaDaoRedPacketListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.numTx);self.numTx=nil;
_UIObject_release(self.redpacketBtn);self.redpacketBtn=nil;
_UIObject_release(self.redpacketList);self.redpacketList=nil;
end















local _this=nil
local _colomn=3
local _itemCmp={
bg1=0,
bg2=1,
openBtn=2,
lookBtn=3,
actorTx=4,
timeTx=5,
numTx=6,
titleTx=7,
timeIcon=8,
overTx=9,
}
local _abName="ui/windows/activities/sub_caishenjiadao/caishenjiadao_atlas_pak.ab"
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)



function UICaiShenJiaDaoRedPacketListWin:onLoaded(...)
self:bindComponents()
_this=self
self.rpListScript=UIPrepareEnScroller(self.redpacketList:getGameObject(),self.redpacketList:getCSharpObject(),nil,nil)
self.rpListScript.window=self
self.subType=SUB_ACTIVITY_TYPE.eCaiShenJiaDao

self:addNotify(notifyConfig.onCSJDGuildDataChange,self.onCSJDGuildDataChange)
self:addNotify(notifyConfig.onCSJDPlayerDataChange,self.onCSJDPlayerDataChange)
self:addNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
end


function UICaiShenJiaDaoRedPacketListWin:__delete()
self:unbindComponents()
_this=nil
self:stopCDTick()
end




function UICaiShenJiaDaoRedPacketListWin:onShow(argtable,afterOnloaded)
self.callback=argtable.callback
self.parentWin=argtable.parentWin
self.info=argtable.info
self.config=self.info:getSubActConfig()
self:refreshNum()
self:refreshList()
end


function UICaiShenJiaDaoRedPacketListWin:onHide()

end




function UICaiShenJiaDaoRedPacketListWin:onCloseBtn()
local callback=self.callback
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
if callback then
callback()
end
end


function UICaiShenJiaDaoRedPacketListWin:onRedpacketBtn()
local info=self.info
if info:checkEntityTime()then
if not fullScreenUI.isActiveBaseFull()then
UIManager.error("当前情况无法发红包")
return
end

UIManager:closeWindow("UIChatWin")
local callback=function()
UIManager:showWindow("UICaiShenJiaDaoRedPacketShareWin",{info=info})
end
if info:checkDoing()and info:checkOpen()and info:checkEntityTime()then
if mainControl:isSceneType(eSceneType.eZongmen)then
if zongmenModel:getMountainId()==mapIdType.zhufeng then
callback()
else
mountainControl:loadAndswitchMapEx(mapIdType.zhufeng,true,callback)
end
else
mainControl:enterHome({mapIdType.zhufeng},callback)
end
end
else
UIManager.error("发红包的时间已过")
end
end

function UICaiShenJiaDaoRedPacketListWin:onClickItemOpen(dataIndex)
local nowTime=timeHelper.getServerShortTime()
local guildData=self.dataList[dataIndex]
if guildData.status==eCSJDRedPacketStatus.eNormal then
if guildData.endTime>nowTime then
call_activitiesHandle_func("activitiesHandle_caishenjiadao","reqReceiveRedPacket",self.info.act_id,self.info.sub_act_id,guildData.guid)
else
UIManager.error("红包已过期")
end
elseif guildData.status==eCSJDRedPacketStatus.eGetted then
UIManager.error("已领取")
elseif guildData.status==eCSJDRedPacketStatus.eNotTimes then
UIManager.error("本日领取次数不足")
elseif guildData.status==eCSJDRedPacketStatus.eNotLeast then
UIManager.error("红包已派完")
end
end

function UICaiShenJiaDaoRedPacketListWin:onClickItemLook(dataIndex)
local nowTime=timeHelper.getServerShortTime()
local guildData=self.dataList[dataIndex]
if guildData.endTime>nowTime then
local args={
info=self.info,
guid=guildData.guid,
}
UIManager:showWindow("UICaiShenJiaDaoRedPacketDetailWin",args)
else
UIManager.info("红包已过期")
end
end

function UICaiShenJiaDaoRedPacketListWin:refreshNum()
local playerData=self.info:getPlayerData(self.info.freeHBIndex)
local numStr=FMT.fmt("本日可领取红包：{0}/{1}",playerData.getCnt,playerData.getMax)
self.numTx:setText(numStr)
end

function UICaiShenJiaDaoRedPacketListWin:refreshList()
self.info:checkGuildSort()
self.dataList=self.info:getGuildList()or{}
local dataCnt=#self.dataList
self.rpListScript:initData(self.dataList,214,math.ceil(dataCnt/_colomn))
if dataCnt>0 then
self:startCDTick()
else
self:stopCDTick()
end
end

function UICaiShenJiaDaoRedPacketListWin:refreshItem(itemIndex,itemWidget)
local maxNum=itemIndex*_colomn
local dataCnt=#self.dataList
local subCnt=dataCnt>=maxNum and _colomn or(_colomn-maxNum+dataCnt)
local nowTime=timeHelper.getServerShortTime()
itemWidget:SetChildLayoutGroupCreateItems(0,subCnt,function(index)
local subItem=itemWidget:GetChildLayoutGroupGridItem(0,index-1)
local dataIndex=(itemIndex-1)*_colomn+index
local guildData=self.dataList[dataIndex]
local hb_conf=self.config.hb_conf[guildData.id]
local memberName=xianmengModel:getXMMemberName(guildData.dispatcher)or"不知名的盟友"
local leastTime=guildData.endTime-nowTime
subItem:SetChildText(_itemCmp.titleTx,hb_conf.blessing[guildData.bless][5])
subItem:SetChildText(_itemCmp.actorTx,memberName)
subItem:SetChildButtonClick(_itemCmp.openBtn,function()
self:onClickItemOpen(dataIndex)
end)
subItem:SetChildButtonClick(_itemCmp.lookBtn,function()
self:onClickItemLook(dataIndex)
end)

if leastTime>0 then
if guildData.status==eCSJDRedPacketStatus.eNormal then
subItem:SetChildActive(_itemCmp.openBtn,true)
subItem:SetChildGraphicGray(_itemCmp.openBtn,false)
subItem:SetChildActive(_itemCmp.lookBtn,false)
subItem:SetChildText(_itemCmp.numTx,FMT.fmt("剩余：{0}",guildData.getMax-guildData.getCnt))
subItem:SetChildActive(_itemCmp.timeTx,true)
subItem:SetChildActive(_itemCmp.timeIcon,true)
subItem:SetChildActive(_itemCmp.overTx,false)
subItem:SetChildText(_itemCmp.timeTx,timeHelper.format_time_stamp(leastTime))
subItem:SetChildActive(_itemCmp.bg1,true)
subItem:SetChildActive(_itemCmp.bg2,false)
elseif guildData.status==eCSJDRedPacketStatus.eGetted then
subItem:SetChildActive(_itemCmp.openBtn,false)
subItem:SetChildActive(_itemCmp.lookBtn,true)
subItem:SetChildText(_itemCmp.numTx,"")
subItem:SetChildActive(_itemCmp.timeTx,false)
subItem:SetChildActive(_itemCmp.timeIcon,false)
subItem:SetChildActive(_itemCmp.overTx,true)
subItem:SetChildText(_itemCmp.overTx,"已领取")
subItem:SetChildActive(_itemCmp.bg1,false)
subItem:SetChildActive(_itemCmp.bg2,true)
elseif guildData.status==eCSJDRedPacketStatus.eNotTimes then
subItem:SetChildActive(_itemCmp.openBtn,true)
subItem:SetChildGraphicGray(_itemCmp.openBtn,true)
subItem:SetChildActive(_itemCmp.lookBtn,false)
subItem:SetChildText(_itemCmp.numTx,"")
subItem:SetChildActive(_itemCmp.timeTx,false)
subItem:SetChildActive(_itemCmp.timeIcon,false)
subItem:SetChildActive(_itemCmp.overTx,true)
subItem:SetChildText(_itemCmp.overTx,"已达到上限")
subItem:SetChildActive(_itemCmp.bg1,true)
subItem:SetChildActive(_itemCmp.bg2,false)
elseif guildData.status==eCSJDRedPacketStatus.eNotLeast then
subItem:SetChildActive(_itemCmp.openBtn,false)
subItem:SetChildActive(_itemCmp.lookBtn,true)
subItem:SetChildText(_itemCmp.numTx,"")
subItem:SetChildActive(_itemCmp.timeTx,false)
subItem:SetChildActive(_itemCmp.timeIcon,false)
subItem:SetChildActive(_itemCmp.overTx,true)
subItem:SetChildText(_itemCmp.overTx,"已领完")
subItem:SetChildActive(_itemCmp.bg1,false)
subItem:SetChildActive(_itemCmp.bg2,true)
end
else
subItem:SetChildActive(_itemCmp.openBtn,false)
subItem:SetChildActive(_itemCmp.lookBtn,true)
subItem:SetChildText(_itemCmp.numTx,"")
subItem:SetChildActive(_itemCmp.timeTx,false)
subItem:SetChildActive(_itemCmp.timeIcon,false)
subItem:SetChildActive(_itemCmp.overTx,true)
subItem:SetChildText(_itemCmp.overTx,"已过期")
subItem:SetChildActive(_itemCmp.bg1,false)
subItem:SetChildActive(_itemCmp.bg2,true)
end
end)
end

function UICaiShenJiaDaoRedPacketListWin:refreshSubItemNum(guid)
local data=self.info:getGuildData(guid)
local nowTime=timeHelper.getServerShortTime()
if data.status~=eCSJDRedPacketStatus.eNormal or data.endTime<=nowTime then
return
end

local startIdx=self.rpListScript:getStartCellViewIndex()
local endIdx=self.rpListScript:getEndCellViewIndex()
local dataCnt=#self.dataList
for itemIdx=startIdx,endIdx do
local widget=self.rpListScript:GetCell(itemIdx)
if widget then
local subItems=widget:GetChildLayoutGroupGridList(0)
for i=1,subItems.Count do
local dataIndex=itemIdx*_colomn+i
if dataIndex<=dataCnt then
local guildData=self.dataList[dataIndex]
if guildData.guid==guid then
local subItem=subItems[i-1]
subItem:SetChildText(_itemCmp.numTx,FMT.fmt("剩余：{0}",guildData.getMax-guildData.getCnt))
return
end
else
return
end
end
end
end
end

function UICaiShenJiaDaoRedPacketListWin:startCDTick()
if not self.cdTick then
self.lastTime=timeHelper.getServerShortTime()
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UICaiShenJiaDaoRedPacketListWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
self.lastTime=nil
end
end

function UICaiShenJiaDaoRedPacketListWin:updateCDTick()
local startIdx=self.rpListScript:getStartCellViewIndex()
local endIdx=self.rpListScript:getEndCellViewIndex()
local nowTime=timeHelper.getServerShortTime()
for itemIdx=startIdx,endIdx do
local widget=self.rpListScript:GetCell(itemIdx)
if widget then
local subItems=widget:GetChildLayoutGroupGridList(0)
for i=1,subItems.Count do
local subItem=subItems[i-1]
local dataIndex=itemIdx*_colomn+i
local guildData=self.dataList[dataIndex]
local leastTime=guildData.endTime-nowTime
if leastTime>0 then
if guildData.status==eCSJDRedPacketStatus.eNormal then
subItem:SetChildText(_itemCmp.timeTx,timeHelper.format_time_stamp(leastTime))
end
elseif self.lastTime<guildData.endTime then
subItem:SetChildActive(_itemCmp.openBtn,false)
subItem:SetChildActive(_itemCmp.lookBtn,true)
subItem:SetChildText(_itemCmp.numTx,"")
subItem:SetChildActive(_itemCmp.timeTx,false)
subItem:SetChildActive(_itemCmp.timeIcon,false)
subItem:SetChildActive(_itemCmp.overTx,true)
subItem:SetChildText(_itemCmp.overTx,"已过期")
subItem:SetChildActive(_itemCmp.bg1,false)
subItem:SetChildActive(_itemCmp.bg2,true)
end
end
end
end
self.lastTime=nowTime
end

function UICaiShenJiaDaoRedPacketListWin.onCSJDGuildDataChange(actId,subType,subId,guid,reSort)
if _this.info:compare(actId,subType,subId)then
if reSort then
_this:refreshList()
else
_this:refreshSubItemNum(guid)
end
end
end

function UICaiShenJiaDaoRedPacketListWin.onCSJDPlayerDataChange(actId,subType,subId)
if _this.info:compare(actId,subType,subId)then
_this:refreshNum()
end
end

function UICaiShenJiaDaoRedPacketListWin.onSubActivityStateChange(actId,subType,subId,state)
if _this.info:compare(actId,subType,subId)and state~=activitiesModel.activityDoingState then
_this:onCloseBtn()
end
end

function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:RefreshCell(dataIndex,cellIndex,cell)
if self.window and self.window.isClose then
return
end
self.window:refreshItem(dataIndex,cell)
end