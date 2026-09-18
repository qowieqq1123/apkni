







def_class("UIXianJie_plotMonsterWin",UIWindowBase)









function UIXianJie_plotMonsterWin:bindComponents()

self.commitBtn=UIButton.get(self,0)
self.lockPanel=UIObject.get(self,1)
self.lockTxt=UIText.get(self,2)
self.monsterInfo=UIObject.get(self,3)
self.rewardPanel=UIObject.get(self,4)
self.root=UIObject.get(self,5)
self.ruleBtn=UIButton.get(self,6)
self.showRewardBtn=UIButton.get(self,7)
self.stateTimeTxt=UIText.get(self,8)
self.stateTxt=UIText.get(self,9)
self.unlockPanel=UIObject.get(self,10)
self.recordBtn=UIButton.get(self,11)
self.shareBtn=UIButton.get(self,12)
self.costTimeItem=UIObject.get(self,13)
self.xmItem=UIObject.get(self,14)
self.teamItem=UIObject.get(self,15)
self.posTxt=UIText.get(self,16)
self.stateLayout=UIObject.get(self,17)
self.mask=UIButton.get(self,18)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.showRewardBtn:setButtonClick(function()self:onShowRewardBtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIXianJie_plotMonsterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.lockPanel);self.lockPanel=nil;
_UIObject_release(self.lockTxt);self.lockTxt=nil;
_UIObject_release(self.monsterInfo);self.monsterInfo=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.showRewardBtn);self.showRewardBtn=nil;
_UIObject_release(self.stateTimeTxt);self.stateTimeTxt=nil;
_UIObject_release(self.stateTxt);self.stateTxt=nil;
_UIObject_release(self.unlockPanel);self.unlockPanel=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.costTimeItem);self.costTimeItem=nil;
_UIObject_release(self.xmItem);self.xmItem=nil;
_UIObject_release(self.teamItem);self.teamItem=nil;
_UIObject_release(self.posTxt);self.posTxt=nil;
_UIObject_release(self.stateLayout);self.stateLayout=nil;
_UIObject_release(self.mask);self.mask=nil;
end
















local _this


function UIXianJie_plotMonsterWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onXianJieCameraMove,self.onXianJieCameraMove)
self:addNotify(notifyConfig.onXianJieCameraZoom,self.onXianJieCameraZoom)
self:addNotify(notifyConfig.onClickXianJiePlane,self.onClickXianJiePlane)
end


function UIXianJie_plotMonsterWin:__delete()
_this=nil
self:unbindComponents()
xianjieController:closeWin2('UIXianJie_plotMonsterWin')
end


function UIXianJie_plotMonsterWin:onHide()

end



function UIXianJie_plotMonsterWin.onXianJieCameraMove()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end

function UIXianJie_plotMonsterWin.onXianJieCameraZoom()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end

function UIXianJie_plotMonsterWin.onClickXianJiePlane(gridX,gridZ,worldX,worldZ)
if _this==nil or not _this.isVisible then return end
_this:onCloseClick()
end






function UIXianJie_plotMonsterWin:onShow(argtable,afterOnloaded)
self.cloudid=argtable.cloudid
self.plotIdx=argtable.plotIdx

if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
_this:updateTime()
end)
end
self:refreshState()
if self.mState<=0 then
self:closeSelf()
else
self:refreshInfo()
end
end

function UIXianJie_plotMonsterWin:onShowArgRecv(argtable)
self:refreshView(argtable.cloudid,argtable.plotIdx)
end

function UIXianJie_plotMonsterWin:updateTime()
self:refreshState()
if self.mState<=0 then
self:closeSelf()
else
self:refreshStateDesc()
end
end

function UIXianJie_plotMonsterWin:refreshState()
local cloudData=xianjieModel:getCloudData(self.cloudid)
local state,lerp=cloudData:checkCloudPlotState(self.plotIdx)
self.mState=state
self.mStateLerp=lerp
end

function UIXianJie_plotMonsterWin:refreshView(cloudid,plotIdx)
if self.cloudid==cloudid and self.plotIdx==plotIdx then return end
self.cloudid=cloudid
self.plotIdx=plotIdx
self:refreshState()
if self.mState<=0 then
self:closeSelf()
else
self:refreshInfo()
end
end

function UIXianJie_plotMonsterWin:onLoadFinish()
local func=function()
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
end
self:delayDo(0.3,func)
end

function UIXianJie_plotMonsterWin:refreshInfo()
local cloudPlotData=xianjieModel:getCloudPlotData(self.cloudid,self.plotIdx)
local cfg=cloudPlotData.cfg
self.sharecfg=cfg
self.rePlotData=cloudPlotData


local gridX_c,gridZ_c=cloudPlotData:getCenterGridPosFloor()
local pos_str=FMT.fmt('（X:{0},Y:{1}）',gridX_c,gridZ_c)
self.posTxt:setText(pos_str)
self.sharex=gridX_c
self.sharez=gridZ_c


local monsterInfoWidget=self.monsterInfo:getWidgetBase()
local groupid=cfg.data[2]
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,groupid)

local modelParams=comHelper.getMonsterGroupModelParams(groupid)
if modelParams then
local size=groupcfg.model[2]*0.4
monsterInfoWidget:SetChildUIModelShowTarget(0,modelParams.body,size,modelParams.componets,eAnimationID.stand)
else
monsterInfoWidget:SetChildUIModelRemoveTarget(0)
end


local stage=cfg.stage or 1
local nameStr=FMT.fmt("{0}阶 {1}",stage,groupcfg.name)



monsterInfoWidget:SetChildText(1,nameStr)


local costTimeWidget=self.costTimeItem:getWidgetBase()
local teamHandle=cloudPlotData:getTeamHandle()
local wayTime=teamHandle:getBaseWayTime()
wayTime=math.ceil(wayTime)
local time_str=timeHelper.format_time_stamp3(wayTime)
costTimeWidget:SetChildText(0,time_str)


local xmWidget=self.xmItem:getWidgetBase()
xmWidget:SetChildActive(1,false)
xmWidget:SetChildActive(4,true)
xmWidget:SetChildActive(5,true)
local zmName=UISettingModel:getZMName()
xmWidget:SetChildText(0,zmName)
local actorId=playerModel:getActorID()
xmWidget:SetChildButtonClick(4,function()

return otherPlayerController:openOtherPlayerInfoWin(actorId)
end,true)




local rewards=cfg.rewardShow or{}
local rnum=#rewards
self.rewardPanel:setChildLayoutGroupCreateItems(rnum)
local grids=self.rewardPanel:getChildLayoutGroupGridList()
for i=1,rnum do
local rwItem=grids[i-1]
local itemid=rewards[i][1]
local itemnum=rewards[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwItem:SetChildPropData(0,prop)
rwItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)

local showSign=itemnum<=0
rwItem:SetChildActive(1,showSign)
end

self:refreshStateDesc()
end

function UIXianJie_plotMonsterWin:refreshStateDesc()
local state=self.mState

local showBtn=state==xjCloudPlotStateType.eNone
self.commitBtn:setActive(showBtn)

local showState=state>xjCloudPlotStateType.eNone
self.stateLayout:setActive(showState)
if showState then
local time=self.mStateLerp
local desc=xjCloudPlotStateType:getDesc(state)or''
self.stateTxt:setText(desc)
local time_str
if time>0 then
time_str=timeHelper.format_time_stamp3(time)
else
time_str='--'
end
self.stateTimeTxt:setText(time_str)
end
end

function UIXianJie_plotMonsterWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UIXianJie_plotMonsterWin:onCloseClick(atOnce)
xianjieController:closeWin('UIXianJie_plotMonsterWin',atOnce)
end

function UIXianJie_plotMonsterWin:onCommitBtn()
local cloudid=self.cloudid
local plotIdx=self.plotIdx
local cloudData=xianjieModel:getCloudData(cloudid)

local mState=cloudData:checkCloudPlotState(plotIdx)
if mState==xjCloudPlotStateType.eNone then
if not xianjieModel:checkWaiPaiTeamNum(true)then
return
end
local cloudPlotData=cloudData:getCloudPlotData(plotIdx)
local teamHandle=cloudPlotData:getTeamHandle()
local wayTime=teamHandle:getBaseWayTime()

local cfg=cfgHelper.get2(cfg_fairylandclouddataconfig_get,cloudid,plotIdx)
local monsterGroupId=cfg.data[2]
local monsterList=cfgHelper.get2(cfg_monstergroup_get,monsterGroupId,"monList")
local winArgs=
{
enterCallBack=function(selectList,zfId,mapId)
local dzlist={}
for i,v in ipairs(selectList)do
table.insert(dzlist,tostring(v[2]))
end

xianjieController:reqFinishCloudPlot(cloudid,plotIdx,dzlist)
fightController:closeSelectStage()
UIFullFightPrepareControl:closeActiveUI()
xianjieController:handleEnterParam_plot({plotMonster={cloudid,plotIdx}})
end,
enterTxt="仙界",
cancelCallBack=function()
fightController:closeSelectStage()
xianjieController:handleEnterParam_plot({plotMonster={cloudid,plotIdx}})
end,
groupId=monsterGroupId,
monsterList=monsterList,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
isCheckXJOccupyType=true,
statePriorityCheck=false,
showZhenFa=false,





xjWayTime=wayTime,
}
local dzInfoFuncList={}
local dzlist=UIDiscipleModel:getSortList()
for i,netData in ipairs(dzlist)do
local d={guid=netData.discipleguid}
xianjieModel:initBattleDZ(d)
dzInfoFuncList[netData.discipleguidStr]=d
end
winArgs.dzInfoFuncList=dzInfoFuncList
winArgs.checkDZSortFunc=xianjieModel.checkDZSortFunc
fightController.showPrepareWin(fightPreSelectModel.fightType.xianjiePlotMonster,winArgs)
end
end

function UIXianJie_plotMonsterWin:onShowRewardBtn()

end

function UIXianJie_plotMonsterWin:onMask()
xianjieController:closeWin('UIXianJie_plotMonsterWin')
end

function UIXianJie_plotMonsterWin:onRuleBtn()
local ruleLangIdList=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'ruleLangIdList')
local ruleType=xjRuleTipsType.ePlotMonster
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

function UIXianJie_plotMonsterWin:onRecordBtn()

local groupid=self.sharecfg.data[2]
local stage=self.sharecfg.stage or 1
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,groupid)
local nameStr=FMT.fmt("{0}阶{1}",stage,groupcfg.name)
local temp=
{
gridX=self.sharex,
gridZ=self.sharez,
Point_Share=xianjie_Point_Share.mowu,
nameStr=nameStr,
sharename=nameStr,
ishujian=false,
}
UIManager:showWindow("UIXianJieRecAddWin",temp)
end
function UIXianJie_plotMonsterWin:onShareBtn()

local groupid=self.sharecfg.data[2]
local stage=self.sharecfg.stage or 1
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,groupid)
local nameStr=FMT.fmt("{0}阶{1}",stage,groupcfg.name)
local _sceneType=xianjieModel:getScenceType()
local data=
{
x=self.sharex,
y=self.sharez,
icon1="icon_sjgdbiaoshi_1",
msgName=nameStr,
shareType=xianjie_Point_Share.mowu,
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
