







def_class("UISubAct_XMHB_detailWin",UIWindowBase)









function UISubAct_XMHB_detailWin:bindComponents()

self.background=UIButton.get(self,0)
self.bottom=UIObject.get(self,1)
self.openRewardItem=UIObject.get(self,2)
self.openLeastTx=UIText.get(self,3)
self.myBig=UIObject.get(self,4)
self.myHead=UIObject.get(self,5)
self.myItem=UIBaseItem.get(self,6)
self.myName=UIText.get(self,7)
self.myRoot=UIObject.get(self,8)
self.openPlayerName=UIText.get(self,9)
self.recordList=UIEnhancedScrollerLua.get(self,10)
self.openTitleIcon=UIImage.get(self,11)
self.openPanel=UIObject.get(self,12)
self.notOpenPanel=UIObject.get(self,13)
self.notOpenRewardItem=UIObject.get(self,14)
self.notOpenLeastTx=UIText.get(self,15)
self.notOpenPlayerName=UIText.get(self,16)
self.openBtn=UIButton.get(self,17)
self.timeText=UIText.get(self,18)
self.notOpenTitleIcon=UIImage.get(self,19)
self.getLimitTipsText=UIText.get(self,20)

self.background:setButtonClick(function()self:onBackground()end)

self.openBtn:setButtonClick(function()self:onOpenBtn()end)



end


function UISubAct_XMHB_detailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.bottom);self.bottom=nil;
_UIObject_release(self.openRewardItem);self.openRewardItem=nil;
_UIObject_release(self.openLeastTx);self.openLeastTx=nil;
_UIObject_release(self.myBig);self.myBig=nil;
_UIObject_release(self.myHead);self.myHead=nil;
_UIObject_release(self.myItem);self.myItem=nil;
_UIObject_release(self.myName);self.myName=nil;
_UIObject_release(self.myRoot);self.myRoot=nil;
_UIObject_release(self.openPlayerName);self.openPlayerName=nil;
_UIObject_release(self.recordList);self.recordList=nil;
_UIObject_release(self.openTitleIcon);self.openTitleIcon=nil;
_UIObject_release(self.openPanel);self.openPanel=nil;
_UIObject_release(self.notOpenPanel);self.notOpenPanel=nil;
_UIObject_release(self.notOpenRewardItem);self.notOpenRewardItem=nil;
_UIObject_release(self.notOpenLeastTx);self.notOpenLeastTx=nil;
_UIObject_release(self.notOpenPlayerName);self.notOpenPlayerName=nil;
_UIObject_release(self.openBtn);self.openBtn=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.notOpenTitleIcon);self.notOpenTitleIcon=nil;
_UIObject_release(self.getLimitTipsText);self.getLimitTipsText=nil;
end
















local _this
local _recordCmp={
headBG=0,
headEmpty=1,
head=2,
item=3,
big=4,
name=5,
}
local _abName="ui/windows/activities/sub_caishenjiadao/caishenjiadao_atlas_pak.ab"
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)



function UISubAct_XMHB_detailWin:onLoaded(...)
self:bindComponents()
_this=self
self.listScript=UIPrepareEnScroller(self.recordList:getGameObject(),self.recordList:getCSharpObject(),nil,nil)
self.listScript.window=self

self.myItem:setBaseItemClickEvent(itemsComponentHelper.onItemClickEx)
playerController:setHeadIcon(self.winlua,self.myHead:getID(),{})

self:addNotify(notifyConfig.onXMHBGuildDataChange,self.onXMHBGuildDataChange)
end


function UISubAct_XMHB_detailWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_XMHB_detailWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end
self.key=argtable.key or tostring(argtable.guid)

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

self.guildData=self.info and self.info:getGuildDataEx(self.key)or nil
if self.guildData then
self:refresh()
else
UIManager.error("红包已过期")
self:onCloseBtn()
end
end


function UISubAct_XMHB_detailWin:onHide()

end

function UISubAct_XMHB_detailWin:refresh()
local info=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
if info==nil or not info:checkDoing()then

UIManager.error("红包已过期")
return self:onCloseBtn()
end

local nowTime=timeHelper.getServerShortTime()
local isExpire=nowTime>=self.guildData.endTime
local isCanOpen=not isExpire and self.guildData.status==eXMRedPacketStatus.eNormal
self.notOpenPanel:setActive(isCanOpen)
self.openPanel:setActive(not isCanOpen)
if isCanOpen then
self:refreshNotOpenPanel()
else
self:refreshOpenPanel()
end
end

function UISubAct_XMHB_detailWin:refreshNotOpenPanel()
self:clearExpireTimer()
local hbLv=self.guildData.level
local hbId=self.guildData.id
local showParamsCfgList=self.config.hongbaoShowParam
local showParam=showParamsCfgList[hbLv]



local hbSkinId=showParam.skinid
local hbSkinCfg=cfgHelper.get(cfg_guildhongbao2skinconfig_get,hbSkinId)
local titleIconName=hbSkinCfg.nameIcon1
local abName="ui/windows/activities/sub_xianmenghongbao/xmhb_icon_atlas_pak.ab"
self.notOpenTitleIcon:setSprite(abName,titleIconName)


local member=xianmengModel:getXMMemberData(self.guildData.dispatcher)
local nameStr=member and member.actorname or"不知名的盟友"
self.notOpenPlayerName:setText(FMT.fmt("来自<color=#efb150>【{0}】</color>的红包",nameStr))

local hbCfgList=self.config.hongbao_conf[hbLv]
local hbCfg=hbCfgList[hbId]
if hbCfg then
local itemWidget=self.notOpenRewardItem:getWidgetBase()
local itemId=hbCfg[1]
local itemCount=hbCfg[2]
local countStr=''
local showCountBG=false
if itemCount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemCount)
end

local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemWidget:SetChildActive(-1,true)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetBaseItemClickEvent(0,function(...)
if _this==nil or not _this.isVisible then return end
self:onClickRewardItem(...)
end)
end


self.notOpenLeastTx:setText(FMT.fmt("剩余：{0}",self.guildData.getMax-self.guildData.getCnt))


local maxCount=self.info:getMaxCanGetHbCount(hbLv)
if maxCount>0 then
local gotCount=self.info:getGotHbCount(hbLv)
self.getLimitTipsText:setText(FMT.fmt("领取上限：{0}/{1}",gotCount,maxCount))
else
self.getLimitTipsText:setText("")
end


self.endTime=self.guildData.endTime
local func=function()
if _this==nil or not _this.isVisible then return end
local nowTime=timeHelper.getServerShortTime()
local lerp=self.endTime-nowTime
if lerp>0 then
local timeStr=timeHelper.format_time_stamp(lerp)
self.timeText:setText(timeStr)
else

return self:refresh()
end
end

self.expireTimer=self:setTimer(1,0,func)
func()
end

function UISubAct_XMHB_detailWin:refreshOpenPanel()
self:clearExpireTimer()

self:refreshList()


self:refreshDispatch()
end

function UISubAct_XMHB_detailWin:refreshDispatch()
local hbLv=self.guildData.level
local hbId=self.guildData.id
local showParamsCfgList=self.config.hongbaoShowParam
local showParam=showParamsCfgList[hbLv]



local hbSkinId=showParam.skinid
local hbSkinCfg=cfgHelper.get(cfg_guildhongbao2skinconfig_get,hbSkinId)
local titleIconName=hbSkinCfg.nameIcon1
local abName="ui/windows/activities/sub_xianmenghongbao/xmhb_icon_atlas_pak.ab"
self.openTitleIcon:setSprite(abName,titleIconName)


local member=xianmengModel:getXMMemberData(self.guildData.dispatcher)
local nameStr=member and member.actorname or"不知名的盟友"
self.openPlayerName:setText(FMT.fmt("来自【{0}】的红包",nameStr))

local gotItemCount=0
local receiverList=self.guildData.receiverList or{}
for i,v in ipairs(receiverList)do
gotItemCount=gotItemCount+v.cnt
end


local hbCfgList=self.config.hongbao_conf[hbLv]
local hbCfg=hbCfgList[hbId]
if hbCfg then
local itemWidget=self.openRewardItem:getWidgetBase()
local itemId=hbCfg[1]
local itemCount=hbCfg[2]
local remainingCount=itemCount-gotItemCount
if remainingCount<=0 then
remainingCount=0
end
local countStr=''
local showCountBG=false
if remainingCount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(remainingCount)
end

local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemWidget:SetChildActive(-1,true)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetBaseItemClickEvent(0,function(...)
if _this==nil or not _this.isVisible then return end
self:onClickRewardItem(...)
end)
end
end

function UISubAct_XMHB_detailWin:refreshList()
self.openLeastTx:setText(FMT.fmt("剩余：{0}",self.guildData.getMax-self.guildData.getCnt))

local key=tostring(playerModel:getActorID())
local receiverData=self.guildData.receiverLookup[key]
self.myRoot:setActive(receiverData~=nil)
if receiverData then
local hbLv=self.guildData.level
local hbId=self.guildData.id
local hbCfgList=self.config.hongbao_conf[hbLv]
local hbCfg=hbCfgList and hbCfgList[hbId]
local isBig=false
local itemId=hbCfg[1]
local itemNum=receiverData.cnt or 0
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
self.myItem:setChildPropData(itemProp)
self.myBig:setActive(isBig)
self.myName:setText(playerModel:getActorName())
end
self.winlua:ForceLayoutRect(self.bottom:getID())

local receiverList=self.guildData.receiverList or{}
self.listScript:initData(receiverList,78,#receiverList)
end

function UISubAct_XMHB_detailWin:refreshItem(dataIndex,widget)
local receiverData=self.guildData.receiverList[dataIndex]


local hbLv=self.guildData.level
local hbId=self.guildData.id
local hbCfgList=self.config.hongbao_conf[hbLv]
local hbCfg=hbCfgList and hbCfgList[hbId]
local isBig=false
local itemId=hbCfg[1]
local itemNum=receiverData.cnt or 0
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
widget:SetChildPropData(_recordCmp.item,itemProp)
widget:SetBaseItemClickEvent(_recordCmp.item,itemsComponentHelper.onItemClickEx)
widget:SetChildActive(_recordCmp.big,isBig)
widget:SetChildButtonClick(_recordCmp.headBG,function()
self:onClickActor(dataIndex)
end)
widget:SetChildActive(_recordCmp.headEmpty,false)
widget:SetChildActive(_recordCmp.head,true)
widget:SetChildText(_recordCmp.name,receiverData.recv_name or"不知名的盟友")
playerController:setHeadIcon(widget,_recordCmp.head,{iconInfo=receiverData.iconInfo})
end


function UISubAct_XMHB_detailWin:clearExpireTimer()
if self.expireTimer then
self:stopTimerByID(self.expireTimer)
self.expireTimer=nil
end
end

function UISubAct_XMHB_detailWin.onXMHBGuildDataChange(actId,subType,subId,guid,reSort)
if _this==nil then
return
end
if _this.info and _this.info:compare(actId,subType,subId)and(guid==nil or guid==_this.guildData.guid)then
_this.guildData=_this.info:getGuildDataEx(_this.key)
if _this.guildData then
_this:refresh()
else
_this:onCloseBtn()
end
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




function UISubAct_XMHB_detailWin:onBackground()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UISubAct_XMHB_detailWin:onOpenBtn()
local nowTime=timeHelper.getServerShortTime()
local isExpire=nowTime>=self.guildData.endTime
local isCanOpen=not isExpire and self.guildData.status==eXMRedPacketStatus.eNormal
if not isCanOpen then
return self:refresh()
end


local hbLv=self.guildData.level
local canGetHbCount=self.info:getCanGetHbCount(hbLv)
if canGetHbCount<=0 then
UIManager.error("已达领取红包上限，无法打开")
return self:refresh()
end

call_activitiesHandle_func("activitiesHandle_xianmenghongbao","reqOpenRedPacket",self.info.act_id,self.info.sub_act_id,self.guildData.guid)
end

function UISubAct_XMHB_detailWin:onClickActor(dataIndex)
local receiverData=self.guildData.receiverList[dataIndex]
local member=xianmengModel:getXMMemberData(receiverData.recv_actor_id)
if member then
otherPlayerController:openOtherPlayerInfoWin(member.actorid)
end
end

function UISubAct_XMHB_detailWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end