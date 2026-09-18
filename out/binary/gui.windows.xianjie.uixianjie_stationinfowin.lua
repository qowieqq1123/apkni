







def_class("UIXianJie_stationInfoWin",UIWindowBase)









function UIXianJie_stationInfoWin:bindComponents()

self.costTimeItem=UIObject.get(self,0)
self.costTimeTxt=UIText.get(self,1)
self.fightValueItem=UIObject.get(self,2)
self.headIconCreater=UIObject.get(self,3)
self.mask=UIButton.get(self,4)
self.playerItem=UIObject.get(self,5)
self.playerName=UIText.get(self,6)
self.posTxt=UIText.get(self,7)
self.qiangZhanBtn=UIButton.get(self,8)
self.recordBtn=UIButton.get(self,9)
self.root=UIObject.get(self,10)
self.ruleBtn=UIButton.get(self,11)
self.shareBtn=UIButton.get(self,12)
self.tanChaBtn=UIButton.get(self,13)
self.xmItem=UIObject.get(self,14)
self.zhaoHuiBtn=UIButton.get(self,15)

self.mask:setButtonClick(function()self:onMask()end)

self.qiangZhanBtn:setButtonClick(function()self:onQiangZhanBtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.tanChaBtn:setButtonClick(function()self:onTanChaBtn()end)

self.zhaoHuiBtn:setButtonClick(function()self:onZhaoHuiBtn()end)



end


function UIXianJie_stationInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.costTimeItem);self.costTimeItem=nil;
_UIObject_release(self.costTimeTxt);self.costTimeTxt=nil;
_UIObject_release(self.fightValueItem);self.fightValueItem=nil;
_UIObject_release(self.headIconCreater);self.headIconCreater=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.playerItem);self.playerItem=nil;
_UIObject_release(self.playerName);self.playerName=nil;
_UIObject_release(self.posTxt);self.posTxt=nil;
_UIObject_release(self.qiangZhanBtn);self.qiangZhanBtn=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.tanChaBtn);self.tanChaBtn=nil;
_UIObject_release(self.xmItem);self.xmItem=nil;
_UIObject_release(self.zhaoHuiBtn);self.zhaoHuiBtn=nil;
end



















function UIXianJie_stationInfoWin:onLoaded(...)
self:bindComponents()
end


function UIXianJie_stationInfoWin:__delete()
self:unbindComponents()

local stationData=xianjieModel:getStationData(self.infoguid)
if stationData then
stationData:selectEntity(false)
end
end




function UIXianJie_stationInfoWin:onShow(argtable,afterOnloaded)
self.infoguid=argtable.infoguid






local stationData=xianjieModel:getStationData(self.infoguid)
if stationData==nil then
self:closeSelf()
else
self:refreshInfo(stationData)
end

if afterOnloaded and stationData then
stationData:selectEntity(true)
end
end


function UIXianJie_stationInfoWin:onHide()

end

function UIXianJie_stationInfoWin:onShowArgRecv(argtable)
local oldGuid=self.infoguid
if oldGuid and not mathHelper.compareInt64(oldGuid,argtable.infoguid)then
local data=xianjieModel:getStationData(oldGuid)
if data then
data:selectEntity(false)
end
data=xianjieModel:getStationData(argtable.infoguid)
if data then
data:selectEntity(true)
end
end
self:refreshView(argtable.infoguid)
end

function UIXianJie_stationInfoWin:refreshView(infoguid)
if mathHelper.compareInt64(self.infoguid,infoguid)then return end
local stationData=xianjieModel:getStationData(self.infoguid)
if stationData==nil then
self:closeSelf()
return
end

self.infoguid=infoguid
self:refreshInfo()
end

function UIXianJie_stationInfoWin:checkPK(actorId)
local sceneidx=xianjieModel:getSceneIndex()
local mode=cfgHelper.get2(cfg_fairylandsceneidxconfig_get,sceneidx,'mode')
if mode>0 then
local data1=xianjieModel:getZongMenData(actorId)
local data2=xianjieModel:getZongMenData(playerModel:getActorID())
return data1.ownersceneidx~=data2.ownersceneidx
else
return false
end
end

function UIXianJie_stationInfoWin:refreshInfo(targetData)
if targetData==nil then
targetData=xianjieModel:getStationData(self.infoguid)
end
if targetData==nil then return end

self.targetData=targetData

local isMine=playerModel:getActorID()==targetData.actorid
self.isMine=isMine
local isOther=xianjienSceneIndexType:isOhterXianYu(targetData.sceneidx)

local isAlly=self:isAlly(isMine,targetData.actorid)

self.tanChaBtn:setActive(not isMine and not isOther)
self.qiangZhanBtn:setActive(not(isMine or isAlly)and self:checkPK(targetData.actorid)and not isOther)
self.zhaoHuiBtn:setActive(isMine)

self.playerName:setText('驻地')


local gridX_c,gridZ_c=targetData:getCenterGridPosFloor()
local pos_str=FMT.fmt('（X:{0},Y:{1}）',gridX_c,gridZ_c)
self.posTxt:setText(pos_str)
self.sharex=gridX_c
self.sharez=gridZ_c


if isMine or isOther then

self.costTimeItem:setActive(false)
else
self.costTimeItem:setActive(true)
self:setWayTimeItem(targetData)
end
if isMine then

self:setPlayerIcon(isMine,targetData.actorid)

self:setFightValue()


self:setPlayerName(isMine,targetData.actorid)

self:setXianMengItem(isMine,targetData.actorid)
else
self.fightValueItem:setActive(false)


self:setPlayerIcon(isMine,targetData.actorid)


self:setPlayerName(isMine,targetData.actorid)

self:setXianMengItem(isMine,targetData.actorid)
end
end

function UIXianJie_stationInfoWin:setPlayerIcon(isMine,actorId)
if isMine then
playerController:setHeadIcon(self.winlua,self.headIconCreater:getID(),{iconInfo=nil,scale=0.82})
else
local data=xianjieModel:getZongMenData(actorId)
playerController:setHeadIcon(self.winlua,self.headIconCreater:getID(),{iconInfo=data.iconInfo,scale=0.82})
end
end

function UIXianJie_stationInfoWin:setFightValue()
local waiPaiData=xianjieModel:getWaiPaiData(xjWaiPiaBaseType.eStation,self.infoguid)
local fval=0
for i,v in ipairs(waiPaiData.guidList)do
if tostring(v)~='0'then
local val=UIDiscipleModel:getFight(v)
fval=fval+val
end
end

local widget=self.fightValueItem:getChildWidgetBase()
widget:SetChildText(0,mathHelper.formatNumber7(fval,1,2))

widget:SetChildButtonClick(1,function()

xianjieController:showMarchTeamDetailWin(xjWaiPiaBaseType.eStation,self.infoguid)
end)
end

function UIXianJie_stationInfoWin:getWayTimeStr(stationData)
local wayTime=stationData:getBaseWayTime()
wayTime=math.ceil(wayTime)
local time_str=timeHelper.format_time_stamp3(wayTime)
return time_str
end

function UIXianJie_stationInfoWin:setWayTimeItem(stationData)
local costTimeWidget=self.costTimeItem:getWidgetBase()
costTimeWidget:SetChildText(0,self:getWayTimeStr(stationData))
end

function UIXianJie_stationInfoWin:getActorName(isMine,actorId)
if isMine then
return playerModel:getActorName()
end
local data=xianjieModel:getZongMenData(actorId)
return data.actorname
end

function UIXianJie_stationInfoWin:setPlayerName(isMine,actorId)
local widget=self.playerItem:getChildWidgetBase()
local name=self:getActorName(isMine,actorId)
widget:SetChildText(0,name)
widget:SetChildActive(1,false)
end

function UIXianJie_stationInfoWin:isAlly(isMine,actorId)
if isMine then
return false
end
local myData=xianmengModel:getMyXMDetialData()
local data=xianjieModel:getZongMenData(actorId)
local tarData=xianjieModel:getXianMengData(data.guildid)
return tarData and myData and(myData.guildname==tarData.guildname)
end

function UIXianJie_stationInfoWin:setXianMengItem(isMine,actorId)
local detailData
local image
if isMine then
detailData=xianmengModel:getMyXMDetialData()
if detailData then
image=xianmengModel:getGuildImage()
end
else
local data=xianjieModel:getZongMenData(actorId)
detailData=xianjieModel:getXianMengData(data.guildid)
if detailData then
image=xianmengModel.splitGuildIcon(detailData.guildicon)
end
end

local widget=self.xmItem:getChildWidgetBase()

if not detailData then
widget:SetChildText(0,'无')

widget:SetChildButtonClick(4,function()
UIManager.info('该祖师暂无仙盟')
end)
return
end

widget:SetChildText(0,detailData.guildname)

local abname=globalABLookup.xianmengicons

widget:SetChildCSImageSprite(3,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

widget:SetChildButtonClick(4,function()
local data1=xianjieModel:getZongMenData(actorId)
local data2=xianjieModel:getZongMenData(playerModel:getActorID())
if data1.ownersceneidx==data2.ownersceneidx then
xianmengController:openXMDetailInfoWin(data1.guildid)
else
UIManager.error('不同仙域的仙盟，无法探知其信息')
end
end)
end

function UIXianJie_stationInfoWin:showDialogue(content,callback)
local dialogue=UIDialogManager.getConfirmDialogEx(nil,{
content=content,
okcb=callback
})
dialogue:show()
end

function UIXianJie_stationInfoWin:selectTeam(ordertype,params)
params=params or{}
local infoguid=self.infoguid
local stationData=self.targetData
local flag,g_list,errorParams=stationData:checkMovePathCondition(true,true)
if not flag then
if errorParams then
local errStr=""
local isSelfInNeutralArea=errorParams.isSelfInNeutralArea
local isTargetInNeutralArea=errorParams.isTargetInNeutralArea
local isBornAreaPath=errorParams.isBornAreaPath
if isSelfInNeutralArea then

errStr="处于阵外无法抢占本阵内的空地"
elseif isTargetInNeutralArea then

errStr="处于本阵内无法抢占阵外的空地"
else
if isBornAreaPath then

errStr="处于本阵内无法抢占空地"
else

errStr="处于本阵内无法抢占其他本阵内的空地"
end
end
UIManager.error(errStr)
end
return
end
local wayTime=stationData:getBaseWayTime()

local extraCost={}
local isChuZheng,isCanChuZheng=xianjieModel:checkXJIsChuZheng(ordertype,true)
if not isChuZheng or not isCanChuZheng then
local orderCfg=xianjieModel:getOrderConfig(ordertype)
local needYzType=orderCfg[1]
if needYzType==1 then
UIManager.error("当前没有可用云舟")
end

return
end

local func=function(selectDzList,selectMoneyList,boatId)
local guid=int64.new(tostring(infoguid))
local pstr=jsonHelper.encode(params)
xianjieController:reqOrder(guid,ordertype,selectDzList,selectMoneyList,pstr,boatId,nil,g_list)
end
UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({callback=func,extraCost=extraCost,wayTime=wayTime,orderType=ordertype})
end




function UIXianJie_stationInfoWin:onCloseClick()
xianjieController:closeWin('UIXianJie_stationInfoWin')
end

function UIXianJie_stationInfoWin:onMask()
self:onCloseClick()
end

function UIXianJie_stationInfoWin:onRecordBtn()
local nameStr=self:getActorName(self.isMine,self.targetData.actorid)
nameStr=FMT.fmt('{0}的驻地',nameStr)
local temp=
{
gridX=self.sharex,
gridZ=self.sharez,
Point_Share=xianjie_Point_Share.kongdi,
nameStr=nameStr,
sharename=nameStr,
}
UIManager:showWindow("UIXianJieRecAddWin",temp)
end

function UIXianJie_stationInfoWin:onRuleBtn()
local ruleLangIdList=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'ruleLangIdList')
local ruleType=xjRuleTipsType.eStation
local langId=ruleLangIdList and ruleLangIdList[ruleType]or''








local screenPos=self.ruleBtn:getChildUIScreenPos(false)
screenPos.x=screenPos.x-50
local winParams={
parentWin=self,
lang=langId,
num=nil,
screenPos=screenPos,
}
self:showWindow("UIXianJie_commonRuleWin",winParams)
end

function UIXianJie_stationInfoWin:onShareBtn()
local nameStr=self:getActorName(self.isMine,self.targetData.actorid)
nameStr=FMT.fmt('{0}的驻地',nameStr)

local _sceneType=xianjieModel:getScenceType()
local data=
{
x=self.sharex,
y=self.sharez,
icon1="icon_sjgdbiaoshi_1",
msgName=nameStr,
shareType=xianjie_Point_Share.kongdi,
scenceType=_sceneType,
name=nameStr,
shareName=nameStr,
}
local str=xianjieController:getShareStr(data)
str=chatLinkHelper.clearLink(str)
local sceneidx=xianjieModel:getSceneIndex(_sceneType)
local jsonStr=jsonHelper.encode({data.shareType,data.shareName,sceneidx,data.x,data.y})
local args={
channels={CHAT_CHANNNEL.eWorld,CHAT_CHANNNEL.eKuafu,CHAT_CHANNNEL.eXianmeng},
counterType=gameCounterType.eXianjiePointShareNum,
regexType=CHAT_REGEX_TYPE.csFairyLand,
descStr=str,
jsonStr=jsonStr,
title='坐标分享',
shareName=data.msgName,
sharePosStr=FMT.fmt('X <color=#171311>{0},</color> Y <color=#171311>{1}</color>',data.x,data.y)
}
UIManager:showWindow("UICommonShareTwoWin",args)
end

function UIXianJie_stationInfoWin:onTanChaBtn()
local targetData=xianjieModel:getStationData(self.infoguid)






UIManager:showWindow('UIXianJie_zmSearchTipsWin',{
actorId=targetData.actorid,
targetId=self.infoguid,
tipsText='侦查空地驻扎，获取对方驻守兵力情况'
})
end

function UIXianJie_stationInfoWin:onQiangZhanBtn()
local func=function()
local sceneidx=xianjieModel:getSceneIndex()
local params={sceneidx,self.targetData.gridX,self.targetData.gridZ}
self:selectTeam(xjOrderType.eStation,params)
end
if not tianshudazhenModel:isDisableOpenFHZ()then
self:showDialogue('抢占空地将触发煞气入侵，是否抢占？',function()
func()
end)
else
func()
end
end

function UIXianJie_stationInfoWin:onZhaoHuiBtn()
self:showDialogue('该部队驻扎中，您确定要召回队伍吗？',function()
xianjieController:reqOrder(int64.new(tostring(self.infoguid)),4,{},{},"");
self:onCloseClick()
end)
end
