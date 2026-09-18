







def_class("UIChatRedPacketListWin",UIWindowBase)









function UIChatRedPacketListWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.numTx=UIText.get(self,1)
self.redpacketBtn=UIButton.get(self,2)
self.redpacketList=UIEnhancedScrollerLua.get(self,3)
self.titleImage=UIImage.get(self,4)
self.numTipsBtn=UIButton.get(self,5)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.redpacketBtn:setButtonClick(function()self:onRedpacketBtn()end)

self.numTipsBtn:setButtonClick(function()self:onNumTipsBtn()end)



end


function UIChatRedPacketListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.numTx);self.numTx=nil;
_UIObject_release(self.redpacketBtn);self.redpacketBtn=nil;
_UIObject_release(self.redpacketList);self.redpacketList=nil;
_UIObject_release(self.titleImage);self.titleImage=nil;
_UIObject_release(self.numTipsBtn);self.numTipsBtn=nil;
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
titleIcon=10,
}
local _abName="ui/windows/activities/sub_caishenjiadao/caishenjiadao_atlas_pak.ab"
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)
local _getSubActRedPacketListFunc={
[SUB_ACTIVITY_TYPE.eCaiShenJiaDao]=function(subActType,subActInfo)
return _this:getRedPacketList_CSJD(subActType,subActInfo)
end,
[SUB_ACTIVITY_TYPE.eXianMengHongBao]=function(subActType,subActInfo)
return _this:getRedPacketList_XMHB(subActType,subActInfo)
end,

}
local _commonOverStrList_CSJD={
[eCSJDRedPacketStatus.eGetted]="已领取",
[eCSJDRedPacketStatus.eNotTimes]="已达到上限",
[eCSJDRedPacketStatus.eNotLeast]="已领完",
}
local _commonOverStrList_XMHB={
[eXMRedPacketStatus.eGetted]="已领取",
[eXMRedPacketStatus.eNotTimes]="已达到上限",
[eXMRedPacketStatus.eNotLeast]="已领完",
}




function UIChatRedPacketListWin:onLoaded(...)
self:bindComponents()
_this=self
self.rpListScript=UIPrepareEnScroller(self.redpacketList:getGameObject(),self.redpacketList:getCSharpObject(),nil,nil)
self.rpListScript.window=self

self:addNotify(notifyConfig.onCSJDGuildDataChange,self.onCSJDGuildDataChange)
self:addNotify(notifyConfig.onCSJDPlayerDataChange,self.onCSJDPlayerDataChange)
self:addNotify(notifyConfig.onXMHBGuildDataChange,self.onXMHBGuildDataChange)
self:addNotify(notifyConfig.onXMHBPlayerDataChange,self.onXMHBPlayerDataChange)
self:addNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
end


function UIChatRedPacketListWin:__delete()
self:unbindComponents()
_this=nil
self:stopCDTick()
end




function UIChatRedPacketListWin:onShow(argtable,afterOnloaded)
self.callback=argtable.callback
self.parentWin=argtable.parentWin


self:findAndSetRedPacketActInfo()


self:refresh()
end


function UIChatRedPacketListWin:onHide()

end

function UIChatRedPacketListWin:findAndSetRedPacketActInfo()
local subActInfoList={}
local subActInfoList_lookup={}


local sub_actList_xmhb=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eXianMengHongBao)
if#sub_actList_xmhb>0 then
for i,sub_actInfo in ipairs(sub_actList_xmhb)do

local idx=#subActInfoList+1
subActInfoList[idx]=sub_actInfo
local _key=FMT.fmt('actid{0}_subtype{1}_subid{2}',sub_actInfo.act_id,sub_actInfo.sub_act_type,sub_actInfo.sub_act_id)
subActInfoList_lookup[_key]={index=idx,subActInfo=sub_actInfo}

if not self.xmhbSubInfo then
self.xmhbSubInfo=sub_actInfo
end
end
end


local sub_actList_csjd=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eCaiShenJiaDao)
if#sub_actList_csjd>0 then
for i,sub_actInfo in ipairs(sub_actList_csjd)do

local idx=#subActInfoList+1
subActInfoList[idx]=sub_actInfo
local _key=FMT.fmt('actid{0}_subtype{1}_subid{2}',sub_actInfo.act_id,sub_actInfo.sub_act_type,sub_actInfo.sub_act_id)
subActInfoList_lookup[_key]={index=idx,subActInfo=sub_actInfo}

if not self.csjdSubInfo then
self.csjdSubInfo=sub_actInfo
end
end
end

self.subActInfoList=subActInfoList
self.subActInfoList_lookup=subActInfoList_lookup
end

function UIChatRedPacketListWin:refresh()
self.redPacketSortList=self:getRedPacketSortList()
local dataCnt=#self.redPacketSortList
self.rpListScript:initData(self.redPacketSortList,214,math.ceil(dataCnt/_colomn))
if dataCnt>0 then
self:startCDTick()
else
self:stopCDTick()
end

local titleIconName="image_caishenjiadao_wz8"
local abName="ui/windows/activities/sub_caishenjiadao/caishenjiadao_atlas_pak.ab"
if not self.csjdSubInfo then
titleIconName="image_xmhb_honbao_15"
abName="ui/windows/activities/sub_xianmenghongbao/xmhb_icon_atlas_pak.ab"
end
self.titleImage:setSprite(abName,titleIconName)

self:refreshNum()
end

function UIChatRedPacketListWin:refreshNum()
self.numTipsBtn:setActive(false)
if self.csjdSubInfo then
local playerData=self.csjdSubInfo:getPlayerData(self.csjdSubInfo.freeHBIndex)
local numStr=FMT.fmt("本日可领取红包：{0}/{1}",playerData.getCnt,playerData.getMax)
self.numTx:setText(numStr)
elseif self.xmhbSubInfo then
local numStr="每个档次红包均设有领取上限"
self.numTx:setText(numStr)
else
self.numTx:setText("")
end
end


function UIChatRedPacketListWin:refreshItem(itemIndex,itemWidget)
local maxNum=itemIndex*_colomn
local dataCnt=#self.redPacketSortList
local subCnt=dataCnt>=maxNum and _colomn or(_colomn-maxNum+dataCnt)
local nowTime=timeHelper.getServerShortTime()
itemWidget:SetChildLayoutGroupCreateItems(0,subCnt,function(index)
local subItem=itemWidget:GetChildLayoutGroupGridItem(0,index-1)
local dataIndex=(itemIndex-1)*_colomn+index
local data=self.redPacketSortList[dataIndex]
local guildData=data.data
local subActType=data.subActType
local subActKey=data.subActKey
local subActInfo=self.subActInfoList_lookup[subActKey]and self.subActInfoList_lookup[subActKey].subActInfo
local subCfg=subActInfo:getSubActConfig()
local memberName
local titleStr
local leastTime=guildData.endTime-nowTime
local isShowOpenBtn=false
local isShowOpenBg=false
local isShowTime=false
local overStr=""
local numStr=""
local timeStr=""
local isExpire=leastTime<=0
local isShowTitleIcon=false
local titleIconName
local titleIconAbName

if subActType==SUB_ACTIVITY_TYPE.eCaiShenJiaDao then
local hb_conf=subCfg.hb_conf[guildData.id]
memberName=xianmengModel:getXMMemberName(guildData.dispatcher)or"不知名的盟友"
titleStr=hb_conf.blessing[guildData.bless][5]
local status=guildData.status
isShowOpenBtn=not isExpire and(status==eCSJDRedPacketStatus.eNormal or status==eCSJDRedPacketStatus.eNotTimes)
isShowOpenBg=isShowOpenBtn

isShowTime=not isExpire and status==eCSJDRedPacketStatus.eNormal
if not isShowTime then
overStr=_commonOverStrList_CSJD[status]or"已过期"
else
numStr=FMT.fmt("剩余：{0}",guildData.getMax-guildData.getCnt)
timeStr=timeHelper.format_time_stamp(leastTime)
end
elseif subActType==SUB_ACTIVITY_TYPE.eXianMengHongBao then
local hbLv=guildData.level
local hbId=guildData.id

memberName=guildData.dispatcherName or"不知名的盟友"
local showParamsCfgList=subCfg.hongbaoShowParam
local showParam=showParamsCfgList[hbLv]


titleStr=""
isShowTitleIcon=true
titleIconAbName="ui/windows/activities/sub_caishenjiadao/caishenjiadao_atlas_pak.ab"
local hbSkinId=showParam.skinid
local hbSkinCfg=cfgHelper.get(cfg_guildhongbao2skinconfig_get,hbSkinId)
titleIconName=hbSkinCfg.nameIcon3
titleIconAbName="ui/windows/activities/sub_xianmenghongbao/xmhb_icon_atlas_pak.ab"

local status=guildData.status
isShowOpenBtn=not isExpire and(status==eXMRedPacketStatus.eNormal or status==eXMRedPacketStatus.eNotTimes)
isShowOpenBg=isShowOpenBtn

isShowTime=not isExpire and status==eXMRedPacketStatus.eNormal
if not isShowTime then
overStr=_commonOverStrList_XMHB[status]or"已过期"
else
numStr=FMT.fmt("剩余：{0}",guildData.getMax-guildData.getCnt)
timeStr=timeHelper.format_time_stamp(leastTime)
end

end

subItem:SetChildText(_itemCmp.titleTx,titleStr)
subItem:SetChildText(_itemCmp.actorTx,memberName)
subItem:SetChildButtonClick(_itemCmp.openBtn,function()
self:onClickItemOpen(dataIndex)
end)
subItem:SetChildButtonClick(_itemCmp.lookBtn,function()
self:onClickItemLook(dataIndex)
end)


subItem:SetChildActive(_itemCmp.openBtn,isShowOpenBtn)
subItem:SetChildActive(_itemCmp.lookBtn,not isShowOpenBtn)
subItem:SetChildText(_itemCmp.numTx,numStr)
subItem:SetChildActive(_itemCmp.timeTx,isShowTime)
subItem:SetChildActive(_itemCmp.timeIcon,isShowTime)
subItem:SetChildText(_itemCmp.timeTx,timeStr)
subItem:SetChildActive(_itemCmp.overTx,not isShowTime)
subItem:SetChildText(_itemCmp.overTx,overStr)
subItem:SetChildActive(_itemCmp.bg1,isShowOpenBg)
subItem:SetChildActive(_itemCmp.bg2,not isShowOpenBg)
subItem:SetChildActive(_itemCmp.bg2,not isShowOpenBg)
subItem:SetChildActive(_itemCmp.titleIcon,isShowTitleIcon)
subItem:SetChildCSImageSprite(_itemCmp.titleIcon,titleIconAbName,titleIconName)
end)
end

function UIChatRedPacketListWin:refreshSubItemNum(guid,subActKey)
local subActInfo=_this.subActInfoList_lookup[subActKey]and _this.subActInfoList_lookup[subActKey].subActInfo or nil
if not subActInfo then
return
end
local data=subActInfo:getGuildData(guid)
local nowTime=timeHelper.getServerShortTime()
if(data.status~=eCSJDRedPacketStatus.eNormal and data.status~=eXMRedPacketStatus.eNormal)or data.endTime<=nowTime then
return
end

local startIdx=self.rpListScript:getStartCellViewIndex()
local endIdx=self.rpListScript:getEndCellViewIndex()
local dataCnt=#self.redPacketSortList
for itemIdx=startIdx,endIdx do
local widget=self.rpListScript:GetCell(itemIdx)
if widget then
local subItems=widget:GetChildLayoutGroupGridList(0)
for i=1,subItems.Count do
local dataIndex=itemIdx*_colomn+i
if dataIndex<=dataCnt then
local data=self.redPacketSortList[dataIndex]
local guildData=data.data
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


function UIChatRedPacketListWin:getRedPacketSortList()
local list={}


for _,subActInfo in ipairs(self.subActInfoList)do
local subActType=subActInfo.sub_act_type
local getRedPacketListFunc=_getSubActRedPacketListFunc[subActType]
if getRedPacketListFunc then
local redPacketList=getRedPacketListFunc(subActType,subActInfo)
if redPacketList and next(redPacketList)~=nil then
for i,v in ipairs(redPacketList)do
table.insert(list,v)
end
end
end
end


table.sort(list,function(a,b)
if a.sortWeight==b.sortWeight then
return a.time>b.time
else
return a.sortWeight>b.sortWeight
end
end)

return list
end

function UIChatRedPacketListWin:getRedPacketList_CSJD(subActType,subActInfo)

local redPacketList={}
local list=subActInfo:getGuildList()
local nowTime=timeHelper.getServerShortTime()
if list and next(list)~=nil then
for i,v in ipairs(list)do
local sortWeight=0
local time=v.time
local status=v.status
local leastTime=v.endTime-nowTime
local isExpire=leastTime<=0
if not isExpire then
if status==eCSJDRedPacketStatus.eNormal then

sortWeight=sortWeight+10000
elseif status==eCSJDRedPacketStatus.eNotTimes then

sortWeight=sortWeight+1000
elseif status==eCSJDRedPacketStatus.eGetted then

sortWeight=sortWeight+100
elseif status==eCSJDRedPacketStatus.eNotLeast then

sortWeight=sortWeight+10
end
end

local subActKey=FMT.fmt('actid{0}_subtype{1}_subid{2}',subActInfo.act_id,subActInfo.sub_act_type,subActInfo.sub_act_id)
local temp={
data=v,
subActType=subActType,
sortWeight=sortWeight,
time=time,
subActKey=subActKey,
}
table.insert(redPacketList,temp)
end
end

return redPacketList
end

function UIChatRedPacketListWin:getRedPacketList_XMHB(subActType,subActInfo)

local redPacketList={}
local list=subActInfo:getGuildList()
local nowTime=timeHelper.getServerShortTime()
if list and next(list)~=nil then
for i,v in ipairs(list)do
local sortWeight=0
local time=v.time
local status=v.status
local leastTime=v.endTime-nowTime
local isExpire=leastTime<=0
if not isExpire then
if status==eXMRedPacketStatus.eNormal then

sortWeight=sortWeight+10000
elseif status==eXMRedPacketStatus.eNotTimes then

sortWeight=sortWeight+1000
elseif status==eXMRedPacketStatus.eGetted then

sortWeight=sortWeight+100
elseif status==eXMRedPacketStatus.eNotLeast then

sortWeight=sortWeight+10
end
end

local subActKey=FMT.fmt('actid{0}_subtype{1}_subid{2}',subActInfo.act_id,subActInfo.sub_act_type,subActInfo.sub_act_id)
local temp={
data=v,
subActType=subActType,
sortWeight=sortWeight,
time=time,
subActKey=subActKey,
}
table.insert(redPacketList,temp)
end
end

return redPacketList
end

function UIChatRedPacketListWin:startCDTick()
if not self.cdTick then
self.lastTime=timeHelper.getServerShortTime()
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UIChatRedPacketListWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
self.lastTime=nil
end
end

function UIChatRedPacketListWin:updateCDTick()
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
local data=self.redPacketSortList[dataIndex]
local guildData=data.data
local subActType=data.subActType
local leastTime=guildData.endTime-nowTime
if leastTime>0 then
if guildData.status==eCSJDRedPacketStatus.eNormal or guildData.status==eXMRedPacketStatus.eNormal then
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

function UIChatRedPacketListWin:openRedPacketInfoWin_XMHB(dataIndex)
local data=self.redPacketSortList[dataIndex]
local guildData=data.data
local subActType=data.subActType
local subActKey=data.subActKey
local subActInfo=self.subActInfoList_lookup[subActKey]and self.subActInfoList_lookup[subActKey].subActInfo

if not subActInfo:checkDoing()then
UIManager.error("太晚了，红包已过期")
return
end
local nowGuildData=subActInfo:getGuildData(guildData.guid)
if nowGuildData==nil then
UIManager.error("太晚了，红包已过期")
return
end
local nowTime=timeHelper.getServerShortTime()
if nowTime>=guildData.endTime then
UIManager.error("太晚了，红包已过期")
return
end

local args={
act_id=subActInfo.act_id,
sub_act_type=subActInfo.sub_act_type,
sub_act_id=subActInfo.sub_act_id,
guid=guildData.guid,
parentWin=self,
}
self:showWindow("UISubAct_XMHB_detailWin",args)
end

function UIChatRedPacketListWin.onCSJDGuildDataChange(actId,subType,subId,guid,reSort)
local subActKey=FMT.fmt('actid{0}_subtype{1}_subid{2}',actId,subType,subId)
local subActInfo=_this.subActInfoList_lookup[subActKey]and _this.subActInfoList_lookup[subActKey].subActInfo or nil
if subActInfo and subActInfo:compare(actId,subType,subId)then
if reSort then
_this:refresh()
else
_this:refreshSubItemNum(guid,subActKey)
end
end
end

function UIChatRedPacketListWin.onCSJDPlayerDataChange(actId,subType,subId)
local subActKey=FMT.fmt('actid{0}_subtype{1}_subid{2}',actId,subType,subId)
local subActInfo=_this.subActInfoList_lookup[subActKey]and _this.subActInfoList_lookup[subActKey].subActInfo or nil
if subActInfo and subActInfo:compare(actId,subType,subId)then
_this:refreshNum()
end
end

function UIChatRedPacketListWin.onXMHBGuildDataChange(actId,subType,subId,guid,reSort)
local subActKey=FMT.fmt('actid{0}_subtype{1}_subid{2}',actId,subType,subId)
local subActInfo=_this.subActInfoList_lookup[subActKey]and _this.subActInfoList_lookup[subActKey].subActInfo or nil
if subActInfo and subActInfo:compare(actId,subType,subId)then
if reSort then
_this:refresh()
else
_this:refreshSubItemNum(guid,subActKey)
end
end
end

function UIChatRedPacketListWin.onXMHBPlayerDataChange(actId,subType,subId)
local subActKey=FMT.fmt('actid{0}_subtype{1}_subid{2}',actId,subType,subId)
local subActInfo=_this.subActInfoList_lookup[subActKey]and _this.subActInfoList_lookup[subActKey].subActInfo or nil
if subActInfo and subActInfo:compare(actId,subType,subId)then
_this:refreshNum()
end
end

function UIChatRedPacketListWin.onSubActivityStateChange(actId,subType,subId,state)
local subActKey=FMT.fmt('actid{0}_subtype{1}_subid{2}',actId,subType,subId)
local subActInfo=_this.subActInfoList_lookup[subActKey]and _this.subActInfoList_lookup[subActKey].subActInfo or nil
if subActInfo and subActInfo:compare(actId,subType,subId)and state~=activitiesModel.activityDoingState then

_this:refresh()
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




function UIChatRedPacketListWin:onCloseBtn()
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



function UIChatRedPacketListWin:onRedpacketBtn()
end

function UIChatRedPacketListWin:onClickItemOpen(dataIndex)
local nowTime=timeHelper.getServerShortTime()
local data=self.redPacketSortList[dataIndex]
local guildData=data.data
local subActType=data.subActType
local subActKey=data.subActKey
local subActInfo=self.subActInfoList_lookup[subActKey]and self.subActInfoList_lookup[subActKey].subActInfo
if subActType==SUB_ACTIVITY_TYPE.eCaiShenJiaDao then
if guildData.status==eCSJDRedPacketStatus.eNormal then
if guildData.endTime>nowTime then
call_activitiesHandle_func("activitiesHandle_caishenjiadao","reqReceiveRedPacket",subActInfo.act_id,subActInfo.sub_act_id,guildData.guid)
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
elseif subActType==SUB_ACTIVITY_TYPE.eXianMengHongBao then
return self:openRedPacketInfoWin_XMHB(dataIndex)
end
end

function UIChatRedPacketListWin:onClickItemLook(dataIndex)
local nowTime=timeHelper.getServerShortTime()
local data=self.redPacketSortList[dataIndex]
local guildData=data.data
local subActType=data.subActType
local subActKey=data.subActKey
local subActInfo=self.subActInfoList_lookup[subActKey]and self.subActInfoList_lookup[subActKey].subActInfo
if subActType==SUB_ACTIVITY_TYPE.eCaiShenJiaDao then
if guildData.endTime>nowTime then
local args={
info=subActInfo,
guid=guildData.guid,
}
UIManager:showWindow("UICaiShenJiaDaoRedPacketDetailWin",args)
else
UIManager.info("红包已过期")
end
elseif subActType==SUB_ACTIVITY_TYPE.eXianMengHongBao then
return self:openRedPacketInfoWin_XMHB(dataIndex)
end
end

function UIChatRedPacketListWin:onNumTipsBtn()












end