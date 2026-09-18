







def_class("UIXianJie_RPXBCollectWin",UIWindowBase)









function UIXianJie_RPXBCollectWin:bindComponents()

self.cdBg=UIObject.get(self,0)
self.cdTx=UIText.get(self,1)
self.commitBtn=UIButton.get(self,2)
self.costBg=UIObject.get(self,3)
self.costIcon=UIImage.get(self,4)
self.costNum=UIText.get(self,5)
self.costTimeTxt=UIText.get(self,6)
self.mask=UIButton.get(self,7)
self.monsterIcon=UIObject.get(self,8)
self.monsterKuang=UIImage.get(self,9)
self.monsterLvBg=UIImage.get(self,10)
self.monsterLvTx=UIText.get(self,11)
self.monsterName=UIText.get(self,12)
self.posTxt=UIText.get(self,13)
self.recommendedTxt=UIText.get(self,14)
self.recordBtn=UIButton.get(self,15)
self.rewardPanel=UIObject.get(self,16)
self.rewardView=UIObject.get(self,17)
self.root=UIObject.get(self,18)
self.ruleBtn=UIButton.get(self,19)
self.showRewardBtn=UIButton.get(self,20)
self.source_1=UIObject.get(self,21)
self.stateLayout=UIObject.get(self,22)
self.stateTimeTxt=UIText.get(self,23)
self.stateTxt=UIText.get(self,24)
self.zydicon=UIImage.get(self,25)
self.stateimg=UIImage.get(self,26)
self.tsuoimg=UIImage.get(self,27)
self.costTimeTxt2=UIText.get(self,28)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.showRewardBtn:setButtonClick(function()self:onShowRewardBtn()end)
self.source={
self.source_1,
}



end


function UIXianJie_RPXBCollectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cdBg);self.cdBg=nil;
_UIObject_release(self.cdTx);self.cdTx=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.costBg);self.costBg=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.costTimeTxt);self.costTimeTxt=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.monsterIcon);self.monsterIcon=nil;
_UIObject_release(self.monsterKuang);self.monsterKuang=nil;
_UIObject_release(self.monsterLvBg);self.monsterLvBg=nil;
_UIObject_release(self.monsterLvTx);self.monsterLvTx=nil;
_UIObject_release(self.monsterName);self.monsterName=nil;
_UIObject_release(self.posTxt);self.posTxt=nil;
_UIObject_release(self.recommendedTxt);self.recommendedTxt=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.rewardView);self.rewardView=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.showRewardBtn);self.showRewardBtn=nil;
_UIObject_release(self.source_1);self.source_1=nil;
_UIObject_release(self.stateLayout);self.stateLayout=nil;
_UIObject_release(self.stateTimeTxt);self.stateTimeTxt=nil;
_UIObject_release(self.stateTxt);self.stateTxt=nil;
_UIObject_release(self.zydicon);self.zydicon=nil;
_UIObject_release(self.stateimg);self.stateimg=nil;
_UIObject_release(self.tsuoimg);self.tsuoimg=nil;
_UIObject_release(self.costTimeTxt2);self.costTimeTxt2=nil;
self.source=nil;
end

















local _this
local abname="ui/windows/xianbang/xianbang_atlas_pak.ab"



function UIXianJie_RPXBCollectWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onXianJieCameraMove,self.onXianJieCameraMove)
self:addNotify(notifyConfig.onXianJieCameraZoom,self.onXianJieCameraZoom)
self:addNotify(notifyConfig.onClickXianJiePlane,self.onClickXianJiePlane)
self:addNotify(notifyConfig.onXianJieResPointDataChange,self.onXianJieResPointDataChange)
self:addNotify(notifyConfig.onXianJieResPointMarchChange,self.onXianJieResPointMarchChange)
end


function UIXianJie_RPXBCollectWin:__delete()
self:unbindComponents()
_this=nil
self:stopCDTick()
self:stopMarchTick()
xianjieController:closeWin2(self.__name)
local rpData=xianjieModel:getResPointData(self.guid)
if rpData then
rpData:selectEntity(false)
end
end




function UIXianJie_RPXBCollectWin:onShow(argtable,afterOnloaded)
self.guid=argtable.guid
self:refreshView()
if afterOnloaded then
local rpData=xianjieModel:getResPointData(self.guid)
if rpData then
rpData:selectEntity(true)
end
end
end


function UIXianJie_RPXBCollectWin:onHide()

end

function UIXianJie_RPXBCollectWin:onShowArgRecv(argtable)
local oldGuid=self.guid
if oldGuid and oldGuid~=argtable.guid then
local data=xianjieModel:getResPointData(oldGuid)
if data then
data:selectEntity(false)
end
data=xianjieModel:getResPointData(argtable.guid)
if data then
data:selectEntity(true)
end
end
self:onShow(argtable,false)
end


function UIXianJie_RPXBCollectWin:onMask()
xianjieController:closeWin('UIXianJie_RPXBCollectWin')
end

function UIXianJie_RPXBCollectWin:onRuleBtn()



local d={}
d.title='规则'
d.mode=3
d.name='UIXianJie_RPXBCollectWin_help_%d'
d.showBlack=true
self:showWindow('UIRuleWin',d)
end

function UIXianJie_RPXBCollectWin:onRecordBtn()
local data=xianjieModel:getResPointData(self.guid)
if data then
local cfg=data:getCfg()
local _nameStr=cfg.name
local temp=
{
gridX=self.sharex,
gridZ=self.sharez,
Point_Share=xianjie_Point_Share.caijidian,
nameStr=_nameStr,
sharename=_nameStr,
ishujian=false,
}
UIManager:showWindow("UIXianJieRecAddWin",temp)
end
end

function UIXianJie_RPXBCollectWin:onCommitBtn()
local guid=self.guid
if xianjieModel:haveResPointMarch(guid)then
UIManager.info("已派遣队伍前往")
return
end
if not xianjieModel:checkWaiPaiTeamNum(true)then
return
end
local rpData=xianjieModel:getResPointData(guid)
if not rpData then
UIManager.info("目标已不存在")
return
elseif rpData.deadTime then
UIManager.info("目标已消失")
return
end


local wayTime=rpData:getBaseWayTime()
local nowTime=timeHelper.getServerShortTime()
if rpData.endTime>0 and rpData.endTime-nowTime<wayTime then
UIManager.info("剩余时间不足以前往目标")
return
end


if not xianjieModel:haveResPointMarch(guid)then
if self._taskId then
xianjiexianbangController:send_37_85(self._taskId,1)
end
local win=UIManager:findActiveWindow('UIXianJieExplorationWin')
if win then
win:onMaskBlock()
end
xianjieController:doResPointMarchCreate(rpData,{},xjResPointMarchTeamType.eCollectible)
xianjieController:closeWin('UIXianJie_RPXBCollectWin')
else
UIManager.info("已派遣队伍前往")
end
end


function UIXianJie_RPXBCollectWin.onXianJieCameraMove()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end
function UIXianJie_RPXBCollectWin.onXianJieCameraZoom()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end
function UIXianJie_RPXBCollectWin.onClickXianJiePlane(gridX,gridZ,worldX,worldZ)
if _this==nil or not _this.isVisible then return end
_this:onMask()
end
function UIXianJie_RPXBCollectWin.onXianJieResPointDataChange(etype,guid)
if _this.guid==guid then
if etype==xjResPointChangeEventType.eDelete then
_this:onMask()
end
end
end
function UIXianJie_RPXBCollectWin.onXianJieResPointMarchChange(etype,guid)
if _this.guid==guid then
_this:refreshMarchInfo()
end
end



function UIXianJie_RPXBCollectWin:refreshView()
local data=xianjieModel:getResPointData(self.guid)
local cfg=data:getCfg()


local xbzyname=cfg.xbzyname
self.winlua:SetChildCSImageSprite(self.zydicon:getID(),abname,xbzyname)

local taskid
if data.source and data.source.srctype==xjResPointSourceType.eXianBangTask then
taskid=data.source.taskid
self._taskId=taskid
end
if taskid then
local taskcfg=cfg_xianbangtaskconfig_get(taskid)
if taskcfg and taskcfg.color then
self.monsterKuang:setSprite(globalABLookup.global,FMT.fmt("image_gwtouxiangpjk_{0}",taskcfg.color))
end
end

self.monsterName:setText(cfg.name)


local gridX_c,gridZ_c=data:getCenterGridPosFloor()
local pos_str=FMT.fmt('（X:{0},Y:{1}）',gridX_c,gridZ_c)
self.posTxt:setText(pos_str)
self.sharex=gridX_c
self.sharez=gridZ_c


local duration=data:getBaseWayTime()
duration=math.ceil(duration)
self.costTimeTxt:setText(timeHelper.format_time_stamp3(duration))
local battleTime=cfg.battleTime or 1
self.costTimeTxt2:setText(timeHelper.format_time_stamp3(battleTime))


local dropCfg=cfgHelper.get(cfg_awardconfig_get,cfg.drop_id)
local rewardList=dropCfg.showItems or{}
self.rewardPanel:setChildLayoutGroupCreateItems(#rewardList,function(index)
local rewardItem=self.rewardPanel:getChildLayoutGroupGridItem(index-1)
local rewardData=rewardList[index]
local rewardId=rewardData[1]
local rewardNum=rewardData[2]
local showCountBG=rewardNum>1 or rewardData.range~=nil
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or""
local conf={itemid=rewardId,itemcount=countStr,showname=false,showCountBG=showCountBG,range=rewardData.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
rewardItem:SetChildActive(1,rewardNum<0)
end)
self.rewardView:setChildScrollRectEnable(#rewardList>=5)


self.tsuoimg:setActive(true)
self.stateimg:setActive(false)
self:refreshMarchInfo()


self.cdBg:setActive(data.endTime>0)
if data.endTime>0 then
self:updateCDTx()
self:startCDTick()
else
self:stopCDTick()
end
end


function UIXianJie_RPXBCollectWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end
function UIXianJie_RPXBCollectWin:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTx()
end)
end
end
function UIXianJie_RPXBCollectWin:updateCDTx()
local data=xianjieModel:getResPointData(self.guid)
local nowTime=timeHelper.getServerShortTime()
local least=math.max(data.end_time-nowTime,0)
local timeStr=FMT.fmt("{0}<color=#76D81E>后消失</color>",timeHelper.format_time_stamp3(least))
self.cdTx:setText(timeStr)
end
function UIXianJie_RPXBCollectWin:refreshMarchInfo()
local marching=xianjieModel:haveResPointMarch(self.guid)
self.commitBtn:setActive(not marching)
self.stateLayout:setActive(marching)
if marching then
self:startMarchTick()
self:updateMarchTick()
else
self.tsuoimg:setActive(false)
self.stateimg:setActive(true)
self:stopMarchTick()
end
end

function UIXianJie_RPXBCollectWin:startMarchTick()
if not self.marchTick then
self.marchTick=self:setTimer(1,0,function()
self:updateMarchTick()
end)
end
end

function UIXianJie_RPXBCollectWin:stopMarchTick()
if self.marchTick then
self:stopTimerByID(self.marchTick)
self.marchTick=nil
end
end

function UIXianJie_RPXBCollectWin:updateMarchTick()
local march=xianjieModel:getResPointMarch(self.guid)
local teamHandle=march:getTeamHandle()
local state,times,lerp=teamHandle:getTeamState()

if state==xjMarchTeamStateType.eBattle then
self.tsuoimg:setActive(true)
self.stateimg:setActive(false)
end
if lerp and lerp>0 then
local desc=xjMarchTeamStateType:getDesc(state)
if desc=='战斗中'then
desc='探索中'
end
self.stateTxt:setText(desc)
local time_str=lerp>0 and timeHelper.format_time_stamp3(lerp)or'--'
self.stateTimeTxt:setText(time_str)
else
self.tsuoimg:setActive(true)
self.stateimg:setActive(false)
self.commitBtn:setActive(false)
self.stateLayout:setActive(false)
self:stopMarchTick()
end
end