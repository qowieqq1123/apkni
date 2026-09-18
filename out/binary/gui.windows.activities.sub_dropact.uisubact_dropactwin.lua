







def_class("UISubAct_dropActWin",UIWindowBase)









function UISubAct_dropActWin:bindComponents()

self.rule=UIObject.get(self,0)
self.dropItemRoot=UIObject.get(self,1)
self.jumpBtn=UIButton.get(self,2)
self.baoxiang=UIObject.get(self,3)
self.time=UIObject.get(self,4)
self.titleImg=UIImage.get(self,5)
self.baoXiangOpen=UIButton.get(self,6)
self.baoXiangClose=UIButton.get(self,7)
self.baoXiangReddot=UIObject.get(self,8)
self.timeText=UIText.get(self,9)
self.ruleBg=UIObject.get(self,10)
self.ruleTitle=UIText.get(self,11)
self.ruleText=UIText.get(self,12)
self.dropItemList=UIObject.get(self,13)
self.jumpText=UIText.get(self,14)
self.bannerImg=UIObject.get(self,15)
self.bgModel=UIObject.get(self,16)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.baoXiangOpen:setButtonClick(function()self:onBaoXiangOpen()end)

self.baoXiangClose:setButtonClick(function()self:onBaoXiangClose()end)



end


function UISubAct_dropActWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rule);self.rule=nil;
_UIObject_release(self.dropItemRoot);self.dropItemRoot=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.baoxiang);self.baoxiang=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.titleImg);self.titleImg=nil;
_UIObject_release(self.baoXiangOpen);self.baoXiangOpen=nil;
_UIObject_release(self.baoXiangClose);self.baoXiangClose=nil;
_UIObject_release(self.baoXiangReddot);self.baoXiangReddot=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.ruleBg);self.ruleBg=nil;
_UIObject_release(self.ruleTitle);self.ruleTitle=nil;
_UIObject_release(self.ruleText);self.ruleText=nil;
_UIObject_release(self.dropItemList);self.dropItemList=nil;
_UIObject_release(self.jumpText);self.jumpText=nil;
_UIObject_release(self.bannerImg);self.bannerImg=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end
















local moneyShowType={
[1]='UITopMoneyWin4',
[2]='UITopMoneyWin2',
[3]='UITopMoneyWin3',
}




function UISubAct_dropActWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_dropActWin:__delete()
self:clearTimer()
self:unbindComponents()
if self.moneyWinName then
self:closeWindow(self.moneyWinName)
end
end




function UISubAct_dropActWin:onShow(argtable,afterOnloaded)
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

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time


local bgModelId=self.config.bgModelId
if bgModelId then
self.bgModel:setChildUIModelShowTarget(bgModelId,1,{},eAnimationID.stand,false,false,0)
else
self.bgModel:setChildUIModelRemoveTarget()
end

self:refresh()


local showItemList=self.config.showItemList
local moneytypes={}
for i=1,#showItemList do
local itemId=showItemList[i]
local item={itemId}
table.insert(moneytypes,item)
end
local moneyPos=self.config.moneyPos or{1,180,-45}
self.moneyWinName=moneyShowType[moneyPos[1]]
self:showWindow(self.moneyWinName,{moneys=moneytypes,offsetX=moneyPos[2],offsetY=moneyPos[3]})
end


function UISubAct_dropActWin:onHide()
self:clearTimer()
if self.moneyWinName then
self:closeWindow(self.moneyWinName)
end
end

function UISubAct_dropActWin:refresh()

local abName="ui/windows/activities/sub_dropact/dropact_title_atlas_pak.ab"
local titleParam=self.config.titleParam
local titleImage=titleParam and titleParam.image or nil
if titleImage then
self.titleImg:setActive(true)
self.titleImg:setCSImageSprite(abName,titleImage)

if titleParam.pos then
self.titleImg:setChildAnchoredPos(titleParam.pos[1],titleParam.pos[2])
end
else
self.titleImg:setActive(false)
end


local bannerAbName="ui/windows/activities/sub_dropact/dropact_banner_atlas_pak.ab"
local bannerParam=self.config.bannerParam
local bannerImage=bannerParam and bannerParam.image or nil
if bannerImage then
self.bannerImg:setActive(true)
self.bannerImg:setCSImageSprite(bannerAbName,bannerImage)

if bannerParam.pos then
self.bannerImg:setChildAnchoredPos(bannerParam.pos[1],bannerParam.pos[2])
end
else
self.bannerImg:setActive(false)
end


local showItemList=self.config.showItemList




local grids=self.dropItemList:getChildCommonLayoutGroupWidgetList()
local count=#showItemList
for i=1,grids.Count do
local itemGridIndex=self:getItemGridIndex(count,i)
local itemWidget=grids[itemGridIndex]
local itemid=showItemList[i]
if itemid then
local countStr=''
local conf={itemid=itemid,itemcount=countStr,showCountBG=false,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemWidget:SetChildActive(-1,true)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
else
itemWidget:SetChildActive(-1,false)
end
end
if self.config.showItemPos then
local pos=self.config.showItemPos
self.dropItemRoot:setChildAnchoredPos(pos[1],pos[2])
end


local ruleBgAbName="ui/windows/activities/sub_dropact/dropact_rulebg_atlas_pak.ab"
local ruleShowParam=self.config.ruleShowParam
local ruleBgImage=ruleShowParam and ruleShowParam.bgImage or nil
if ruleBgImage then
self.ruleBg:setActive(true)
self.ruleBg:setCSImageSprite(ruleBgAbName,ruleBgImage)
else
self.ruleBg:setActive(false)
end

if ruleShowParam.pos then
local pos=ruleShowParam.pos
self.rule:setChildAnchoredPos(pos[1],pos[2])
end
if ruleShowParam.width then
local height=self.rule:getChildSizeDeltaY()
self.rule:setChildSizeDelta(ruleShowParam.width,height)
end

local ruleTitleText=self.config.ruleInfo.title
local ruleInfoText=self.config.ruleInfo.info
self.ruleTitle:setText(ruleTitleText)
self.ruleText:setText(ruleInfoText)


local isShowJump=false
if self.config.jumpParam then
self.jumpArgs=self.config.jumpParam.jump
isShowJump=true
if self.config.jumpParam.pos then
local pos=self.config.jumpParam.pos
self.jumpBtn:setChildAnchoredPos(pos[1],pos[2])
end
if self.config.jumpParam.text then
self.jumpText:setText(self.config.jumpParam.text)
end
end
self.jumpBtn:setActive(isShowJump)


if self.config.baoxiangPos then
local posParam=self.config.baoxiangPos or{}
local rootPos=posParam.rootPos or{459.5,55}
self.baoxiang:setChildAnchoredPos(rootPos[1],rootPos[2])
local openPos=posParam.openPos or{0,0}
self.baoXiangOpen:setChildAnchoredPos(openPos[1],openPos[2])
end
local isOpenBaoxiang=self.activityData.data.getRewardSec and self.activityData.data.getRewardSec>0
self.baoXiangOpen:setActive(isOpenBaoxiang)
self.baoXiangClose:setActive(not isOpenBaoxiang)


if self.config.timePos then
local pos=self.config.timePos
self.time:setChildAnchoredPos(pos[1],pos[2])
end


self:setRemainingTimeTimer()
end


function UISubAct_dropActWin:getItemGridIndex(itemCount,index)
local gridIndex
if itemCount==1 then

local indexList={
[1]=1,
[2]=0,
[3]=2,
}
gridIndex=indexList[index]
elseif itemCount==2 then

local indexList={
[1]=0,
[2]=2,
[3]=1,
}
gridIndex=indexList[index]
elseif itemCount==3 then

gridIndex=index-1
end

return gridIndex
end




function UISubAct_dropActWin:onJumpBtn()
if not self.jumpArgs then
logErr(FMT.fmt("找不到活动id: {0}, 活动类型: {1}, 子活动id: {2}的跳转配置",self.activityId,self.subType,self.subId))
return
end
jumpManager:jump(self.jumpArgs)
end



function UISubAct_dropActWin:onBaoXiangOpen()
end



function UISubAct_dropActWin:onBaoXiangClose()

activitiesController:sendProtocol(actSendType.eComonReqHandle,self.activityId,self.subType,self.subId,"")
end

function UISubAct_dropActWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end


function UISubAct_dropActWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.timeText:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp11(lerp,true)))
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UISubAct_dropActWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end