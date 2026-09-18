







def_class("UIXianGuanMainWin",UIWindowBase)









function UIXianGuanMainWin:bindComponents()

self.backButton=UIButton.get(self,0)
self.background=UIImage.get(self,1)
self.compaignBtn_1=UIButton.get(self,2)
self.compaignBtn_2=UIButton.get(self,3)
self.helpBtn=UIButton.get(self,4)
self.jobList=UIObject.get(self,5)
self.listBg=UIObject.get(self,6)
self.logBtn=UIButton.get(self,7)
self.privilegeBtn=UIButton.get(self,8)
self.privilegeReddot=UIObject.get(self,9)
self.privilegeTips=UIText.get(self,10)
self.stageDownBtn=UIButton.get(self,11)
self.stageList=UIObject.get(self,12)
self.stageUpBtn=UIButton.get(self,13)
self.tabList=UIObject.get(self,14)

self.backButton:setButtonClick(function()self:onBackButton()end)

self.compaignBtn_1:setButtonClick(function()self:onCompaignBtn_1()end)

self.compaignBtn_2:setButtonClick(function()self:onCompaignBtn_2()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.logBtn:setButtonClick(function()self:onLogBtn()end)

self.privilegeBtn:setButtonClick(function()self:onPrivilegeBtn()end)

self.stageDownBtn:setButtonClick(function()self:onStageDownBtn()end)

self.stageUpBtn:setButtonClick(function()self:onStageUpBtn()end)
self.compaignBtn={
self.compaignBtn_1,
self.compaignBtn_2,
}



end


function UIXianGuanMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backButton);self.backButton=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.compaignBtn_1);self.compaignBtn_1=nil;
_UIObject_release(self.compaignBtn_2);self.compaignBtn_2=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.jobList);self.jobList=nil;
_UIObject_release(self.listBg);self.listBg=nil;
_UIObject_release(self.logBtn);self.logBtn=nil;
_UIObject_release(self.privilegeBtn);self.privilegeBtn=nil;
_UIObject_release(self.privilegeReddot);self.privilegeReddot=nil;
_UIObject_release(self.privilegeTips);self.privilegeTips=nil;
_UIObject_release(self.stageDownBtn);self.stageDownBtn=nil;
_UIObject_release(self.stageList);self.stageList=nil;
_UIObject_release(self.stageUpBtn);self.stageUpBtn=nil;
_UIObject_release(self.tabList);self.tabList=nil;
self.compaignBtn=nil;
end
















local _this

local _ab=globalABLookup.xianguan

local _listHeightOffset=300

local _bgOffsetY={[3]={0,0},[2]={-3,-25},[1]={2,-23}}


local CmpStageItemIndex={
select=0,
name=1,
reddot=2,
icon=3,
}

local CmpJobItemIndex={
headBg=0,
head=1,
nameTx=2,
nameIcon=3,
compaignType=4,
playerName=5,
addFlag=6,
reddot=7,
jobState=8,
jobStateTip=9,
playerBg=10,
bLevelBg=11,
bLevel=12,
nameBg=13,
addFlagBg=14,
model1=15,
model2=16,
xwyd=17,
mask=18,
playerInfo=19,
icon2=20,
info=21,
typeIcon2=22,
jobImgName=23,
model=24,
info2=25,
bg1=26
}




function UIXianGuanMainWin:onLoaded(...)
self:bindComponents()

self.sRightIndex=1

_this=self

self:addNotify(notifyConfig.onChangeXianGuanJob,function(...)
if _this==nil then return end
_this:onChangeXianGuanJob(...)
end)
self:addNotify(notifyConfig.onTeQuanInfoChange,function(...)
if _this==nil then return end
_this:onChangeSelfPrivilegeCount(...)
end)
self:addNotify(notifyConfig.onXianGuanJingXuanSegmentChange,function(...)
if _this==nil then return end
_this:onChangeJingXuanSegment(...)
end)
self:addNotify(notifyConfig.onLimitActReddotChange,function(...)
if _this==nil then return end
_this:onLimitActReddotChange(...)
end)
self:addNotify(notifyConfig.onTeQuanInfoReset,function(...)
if _this==nil then return end
_this:onChangeSelfPrivilegeCount(...)
end)
end


function UIXianGuanMainWin:__delete()
self:removeAllBreathBt()
self:stopCompaignBtn2Tick()
self:unbindComponents()

_this=nil
end




function UIXianGuanMainWin:onShow(argtable,afterOnloaded)

self.sRightIndex=argtable and argtable.sRightIndex or self.sRightIndex

if afterOnloaded then
self.listBg:setChildUIModelShowTarget(6019,1,nil,eAnimationID.stand)
end

self:refreshAll()
end


function UIXianGuanMainWin:onHide()

end


function UIXianGuanMainWin:refreshAll()
self:initData()


self:refreshRightBar()


self:refreshXGList()

self:refreshButton()
end


function UIXianGuanMainWin:refreshRightBar()
local topCfg=cfgHelper.get1(cfg_xianguangroupconfig_get,1)

local reserveStageIconList=topCfg.stageIconList

self.stageList:setActive(topCfg.isShowJobStage)

if topCfg.isShowJobStage then
local stageNameList=topCfg.stageNameList
stageNameList=table.reverse(stageNameList)
if stageNameList~=nil then
local stageLen=#stageNameList

local createFunc=function(index)
local item=_this.stageList:getChildLayoutGroupGridItem(index-1)

local name=stageNameList[index]
local isShow=name~=nil

item:SetChildActive(-1,isShow)

if isShow then
local iconIndex=reserveStageIconList[index]
local iconName=FMT.fmt("icon_xianguanui_{0}",iconIndex)
item:SetChildCSImageSprite(CmpStageItemIndex.icon,_ab,iconName)

item:SetChildText(CmpStageItemIndex.name,name)

local isSelect=_this.sRightIndex==index
item:SetChildActive(CmpStageItemIndex.select,isSelect)

local reddot=xianguanController.getStageReddot(topCfg.id,stageLen-index+1)
item:SetChildActive(CmpStageItemIndex.reddot,false)

local selectFunc=function()
if _this==nil then return end

local preItem=_this.stageList:getChildLayoutGroupGridItem(_this.sRightIndex-1)
preItem:SetChildActive(CmpStageItemIndex.select,false)

_this.sRightIndex=index
item:SetChildActive(CmpStageItemIndex.select,true)

_this:doMoveJobList(index)
end

item:SetChildButtonClick(-1,selectFunc,true)
end
end

self.stageList:setChildLayoutGroupCreateItems(stageLen,createFunc)
end
end
end

function UIXianGuanMainWin:refreshXGList()
local topCfg=cfgHelper.get1(cfg_xianguangroupconfig_get,1)
local jobCfgList=xianguanConfig.getJobListConfig(topCfg.id)
local jobCfgLen=#jobCfgList

local totalHeight=xianguanConfig.getListContentTotalHeight(topCfg.id)
self.jobList:setChildSizeDelta(1034,totalHeight)

local model1CreateFunc=function(index,item,cfg)
local isShow=cfg~=nil
item:SetChildActive(-1,isShow)
if isShow then
local jobPlayerInfo=xianguanController.getJobPlayerInfo(topCfg.id,cfg.id)
local isHasPlayer=jobPlayerInfo.actorid~=nil

local isCanJob=xianguanController.checkIsCanJob(topCfg.id,cfg.id)
local isInJob=xianguanController.checkSelfInJob(topCfg.id)
local isLook=jobPlayerInfo.leftTime>0
if isLook then
isHasPlayer=false
end

item:SetChildActive(CmpJobItemIndex.headBg,isHasPlayer)
item:SetChildActive(CmpJobItemIndex.addFlagBg,not isHasPlayer)
item:SetChildActive(CmpJobItemIndex.addFlag,not isHasPlayer)
item:SetChildActive(CmpJobItemIndex.addFlag,not isHasPlayer)
item:SetChildActive(CmpJobItemIndex.playerBg,isHasPlayer)
item:SetChildActive(CmpJobItemIndex.jobState,not isHasPlayer)
item:SetChildActive(CmpJobItemIndex.bLevelBg,isHasPlayer)





if isHasPlayer then
local iconInfo=jobPlayerInfo.iconInfo
playerController:setHeadIcon(item,CmpJobItemIndex.head,{scale=0.8,iconInfo=iconInfo})

local selfActorId=playerModel:getActorID()
local isSelf=mathHelper.compareInt64(selfActorId,jobPlayerInfo.actorid)
local nameColor=isSelf and"#aae252"or"#f7f7f7"
local namtStr=toColorStringX(nameColor,jobPlayerInfo.actorname)
item:SetChildText(CmpJobItemIndex.playerName,namtStr)


item:SetChildText(CmpJobItemIndex.bLevel,jobPlayerInfo.level or 0)
else

item:SetChildActive(CmpJobItemIndex.reddot,false)

local tipStr







tipStr=toColorStringX("#efeded","虚位以待")
item:SetChildText(CmpJobItemIndex.jobStateTip,tipStr)
end

local nameColor=topCfg.nameColorList[cfg.stage]

local nameStr=string.insertBreakLine(cfg.name,true)
if pfwindowslController:checkIsGameVersion_yuenan()then
nameStr=cfg.name
end
item:SetChildText(CmpJobItemIndex.nameTx,nameStr)

local titleBgName=topCfg.nameBgList[cfg.stage]
item:SetChildCSImageSprite(CmpJobItemIndex.nameBg,_ab,titleBgName)

local bgName=topCfg.jobBgList[cfg.stage]
item:SetChildCSImageSprite(CmpJobItemIndex.bg1,_ab,bgName)

item:SetChildAnchoredPos(CmpJobItemIndex.bg1,_bgOffsetY[cfg.stage][1],_bgOffsetY[cfg.stage][2])

local jobIconName=xianguanConfig.getJobIconName(cfg.jobIcon)
item:SetChildCSImageSprite(CmpJobItemIndex.nameIcon,_ab,jobIconName)

local isShowCampaignType=cfg.campaignType~=nil
item:SetChildActive(CmpJobItemIndex.compaignType,isShowCampaignType)
if isShowCampaignType then
local compaignTypeIconName=cfgHelper.get2(cfg_xianguancampaigntypeconfig_get,cfg.campaignType,'icon')
item:SetChildCSImageSprite(CmpJobItemIndex.compaignType,_ab,compaignTypeIconName)
end
end
end

local model2CreateFunc=function(index,item,cfg)
local jobPlayerInfo=xianguanController.getJobPlayerInfo(topCfg.id,cfg.id)
local isHasPlayer=jobPlayerInfo.actorid~=nil

local isCanJob=xianguanController.checkIsCanJob(topCfg.id,cfg.id)
local isInJob=xianguanController.checkSelfInJob(topCfg.id)
local isLook=jobPlayerInfo.leftTime>0
if isLook then
isHasPlayer=false
end

item:SetChildActive(CmpJobItemIndex.xwyd,not isHasPlayer)
item:SetChildActive(CmpJobItemIndex.mask,isHasPlayer)

if isHasPlayer then

local selfActorId=playerModel:getActorID()
local isSelf=mathHelper.compareInt64(selfActorId,jobPlayerInfo.actorid)
local nameColor=isSelf and"#aae252"or"#f7f7f7"
local namtStr=toColorStringX(nameColor,jobPlayerInfo.actorname)
item:SetChildText(CmpJobItemIndex.info2,namtStr)


local replace={[PLAYER_IMAGE_TYPE.eBodyOrnament]=1}
playerController:setImage(item,CmpJobItemIndex.model,jobPlayerInfo.sex,jobPlayerInfo.iconInfo,playerController:supportDynamic(),0.8,replace)

else
local tipStr







tipStr=toColorStringX("#efeded","虚位以待")
item:SetChildText(CmpJobItemIndex.info2,tipStr)
end

local jobIconName=xianguanConfig.getJobIconName(cfg.jobIcon)
item:SetChildCSImageSprite(CmpJobItemIndex.icon2,_ab,jobIconName)


local isShowCampaignType=cfg.campaignType~=nil
item:SetChildActive(CmpJobItemIndex.typeIcon2,isShowCampaignType)
if isShowCampaignType then
local compaignTypeIconName=cfgHelper.get2(cfg_xianguancampaigntypeconfig_get,cfg.campaignType,'icon')
item:SetChildCSImageSprite(CmpJobItemIndex.typeIcon2,_ab,compaignTypeIconName)
end

local isShowJobImgName=cfg.jobImgName~=nil
if isShowJobImgName then
item:SetChildCSImageSprite(CmpJobItemIndex.jobImgName,_ab,cfg.jobImgName)
end

end

local createFunc=function(index)
if _this==nil then return end

local item=_this.jobList:getChildLayoutGroupGridItem(index-1)

local cfg=jobCfgList[index]


local isModel2=cfg.stage==4

item:SetChildActive(CmpJobItemIndex.model2,isModel2)
item:SetChildActive(CmpJobItemIndex.model1,not isModel2)

if isModel2 then
model2CreateFunc(index,item,cfg)
else
model1CreateFunc(index,item,cfg)
end


item:SetChildAnchoredPos(-1,cfg.position[1],cfg.position[2])

local clickFunc=function()
if _this==nil then return end
local args={groupId=topCfg.id,jobId=cfg.id}

_this:showWindow("UIXianGuanJobDetailsWin",args)
end

item:SetBaseItemClickEvent(-1,clickFunc)
item:SetChildNewBieComponentId(-1,'UIXianGuanMainWin.item'..index)

end

self.jobList:setChildLayoutGroupCreateItems(jobCfgLen,createFunc)
end

function UIXianGuanMainWin:refreshButton()
self:refreshCompaignBtn1()
self:refreshCompaignBtn2()

local isInJob=xianguanController:checkSelfHasJob()
self.privilegeBtn:setActive(xianguanController.checkHasVoluintaryPrivilege())
if isInJob then
self:refreshPrivilegeBtn()
end

local commonLimit=xianguanHelper.checkClientCommonPlatformLimit()
self.logBtn:setActive(commonLimit)
end

function UIXianGuanMainWin:refreshCompaignBtn1()
local show=xianguanModel:checkWenXuanEnterOpen()
if xianguanController:isInMatchStage_enter_WenXuan_BW()then
show=show and xianguanController:isOpen_WenXuan_BW()
end
self.compaignBtn_1:setActive(show)

if show then
local isInBWMatch=xianguanController:isInMatchStage_enter_WenXuan_BW()
local widget=self.winlua:GetChildWidgetBase(self.compaignBtn_1:getID())
local status,beginTime,endTime=xianguanController:getActivitySegment_Enter_WenXuan_Compatible()
local color=nil
if status==XianGuanWenXuanSegment.eVote or status==XianGuanWenXuanSegment.eRegister then
color="a1ec58"
elseif status==XianGuanWenXuanSegment.eNone then
color="f36666"
endTime=endTime or xianguanModel:getWenXuanNextOpenTime()
elseif status==XianGuanWenXuanSegment.eBwWait then
color="f36666"
end
local showCD=color~=nil and endTime~=nil
widget:SetChildActive(2,status==XianGuanWenXuanSegment.eVote)
widget:SetChildActive(3,status==XianGuanWenXuanSegment.eRegister)
widget:SetChildActive(4,status==XianGuanWenXuanSegment.eFinish)
widget:SetChildActive(5,status==XianGuanWenXuanSegment.eNone)
widget:SetChildActive(7,isInBWMatch)
widget:SetChildActive(0,showCD)
self:refreshCompaignReddot1()
if showCD then
self.compaignBtn1TickTime=endTime
self.compaignBtn1TickColor=color
if self:updateCompaignBtn1Tick()then
self:startCompaignBtn1Tick()
return
end
end
end
self.compaignBtn1TickTime=nil
self.compaignBtn1TickColor=nil
self:stopCompaignBtn1Tick()
end

function UIXianGuanMainWin:startCompaignBtn1Tick()
if not self.compaignBtn1Tick then
self.compaignBtn1Tick=self:setTimer(1,0,function()
if not self:updateCompaignBtn1Tick()then
self:refreshCompaignBtn1()
end
end)
end
end

function UIXianGuanMainWin:stopCompaignBtn1Tick()
if self.compaignBtn1Tick then
self:stopTimerByID(self.compaignBtn1Tick)
self.compaignBtn1Tick=nil
end
end

function UIXianGuanMainWin:updateCompaignBtn1Tick()
local widget=self.winlua:GetChildWidgetBase(self.compaignBtn_1:getID())
local nowTime=timeHelper.getServerShortTime()
local least=math.max(self.compaignBtn1TickTime-nowTime,0)
widget:SetChildText(1,FMT.cfmt3(self.compaignBtn1TickColor,timeHelper.format_time_stamp3(least)))
return least>0
end

function UIXianGuanMainWin:refreshCompaignReddot1()
local reddot=xianguanController:getWenXuanReddot_Compatible()
local widget=self.winlua:GetChildWidgetBase(self.compaignBtn_1:getID())
widget:SetChildActive(6,reddot)
end

function UIXianGuanMainWin:refreshCompaignBtn2()
local show=xianguanModel:checkWuXuanEnterOpen()
if xianguanController:isInMatchStage_enter_WuXuan_BW()then
show=show and xianguanController:isOpen_WuXuan_BW()
end
self.compaignBtn_2:setActive(show)

if show then
local isInBWMatch=xianguanController:isInMatchStage_enter_WuXuan_BW()
local segment,beginTime,endTime=xianguanController:getActivitySegment_Enter_WuXuan_Compatible()
local widget=self.winlua:GetChildWidgetBase(self.compaignBtn_2:getID())
local color=nil
if segment==XianGuanWuXuanSegment.eMatch or segment==XianGuanWuXuanSegment.eReady then
color="a1ec58"
elseif segment==XianGuanWuXuanSegment.eNone then
color="f36666"
endTime=endTime or xianguanModel:getWuXuanNextOpenTime()
elseif segment==XianGuanWuXuanSegment.eRegister then
color="a1ec58"
elseif segment==XianGuanWuXuanSegment.eBwWait then
color="f36666"
end
local showCD=color~=nil and endTime~=nil
widget:SetChildActive(2,segment==XianGuanWuXuanSegment.eMatch)
widget:SetChildActive(3,segment==XianGuanWuXuanSegment.eReady)
widget:SetChildActive(4,segment==XianGuanWuXuanSegment.eRegister)
widget:SetChildActive(5,segment==XianGuanWuXuanSegment.eFinish)
widget:SetChildActive(6,segment==XianGuanWuXuanSegment.eNone)
widget:SetChildActive(8,isInBWMatch)
widget:SetChildActive(0,showCD)
self:refreshCompaignReddot2()
if showCD then
self.compaignBtn2TickTime=endTime
self.compaignBtn2TickColor=color
if self:updateCompaignBtn2Tick()then
self:startCompaignBtn2Tick()
return
end
end
end
self.compaignBtn2TickTime=nil
self.compaignBtn2TickColor=nil
self:stopCompaignBtn2Tick()
end

function UIXianGuanMainWin:startCompaignBtn2Tick()
if not self.compaignBtn2Tick then
self.compaignBtn2Tick=self:setTimer(1,0,function()
if not self:updateCompaignBtn2Tick()then
self:refreshCompaignBtn2()
end
end)
end
end

function UIXianGuanMainWin:stopCompaignBtn2Tick()
if self.compaignBtn2Tick then
self:stopTimerByID(self.compaignBtn2Tick)
self.compaignBtn2Tick=nil
end
end

function UIXianGuanMainWin:updateCompaignBtn2Tick()
local widget=self.winlua:GetChildWidgetBase(self.compaignBtn_2:getID())
local nowTime=timeHelper.getServerShortTime()
local least=math.max(self.compaignBtn2TickTime-nowTime,0)
widget:SetChildText(1,FMT.cfmt3(self.compaignBtn2TickColor,timeHelper.format_time_stamp3(least)))
return least>0
end

function UIXianGuanMainWin:refreshCompaignReddot2()
local segment=xianguanController:getActivitySegment_WuXuan_Compatible()
local reddot=xianguanController:getWuXuanReddot_Compatible()
local widget=self.winlua:GetChildWidgetBase(self.compaignBtn_2:getID())
widget:SetChildActive(7,reddot)
end

function UIXianGuanMainWin:refreshPrivilegeBtn()
local residueTimes,totalNum=xianguanController.getPrivilegeDayNumInfo()
local isCanUse=residueTimes>0

local color=isCanUse and"#a1ec58"or"#f36666"
local numStr=toColorStringX(color,FMT.fmt("{0}/{1}",residueTimes,totalNum))
numStr=FMT.fmt("剩余：{0}次",numStr)
self.privilegeTips:setText(numStr)

self.privilegeReddot:setActive(xianguanController.getSelfPrivilegeUseReddot())
end


function UIXianGuanMainWin:initData()
local topCfg=cfgHelper.get1(cfg_xianguangroupconfig_get,1)
local totalHeight=xianguanConfig.getListContentTotalHeight(topCfg.id)
self.toHeightList=xianguanConfig.getToListHeightList(topCfg.id)
self.normalizeHeightList={}
for index,val in ipairs(self.toHeightList)do
self.normalizeHeightList[index]=val/totalHeight
end
end

function UIXianGuanMainWin:changeSelectTopBar()
self:initData()
self:refreshRightBar()
self:removeAllBreathBt()
self:refreshXGList()
end

function UIXianGuanMainWin:doMoveJobList(index)
local toHeight=self.toHeightList[index]

if index==1 then
toHeight=0
end

self.jobList:setChildDOAnchorPosY(-toHeight,0.2)
end



function UIXianGuanMainWin:ScrollRectOnValueChange(args)
local curIndex=self.sRightIndex
for index,nval in ipairs(self.normalizeHeightList)do
if 1+nval>=args.y then
curIndex=index
end
end

if curIndex~=self.sRightIndex then
self.sRightIndex=curIndex
self:refreshRightBar()
end
end


function UIXianGuanMainWin:setBreathAnimation(index,item,pos,state)
if self.bDotweenList==nil then self.bDotweenList={}end

local dt=self.bDotweenList[index]
if dt then
dt:Complete()
dt:Kill()
self.bDotweenList[index]=nil
end

if state then
item:SetChildScale(pos,Vector3(1.1,1.1,1.1))
local dt=item:SetChildDOScale(pos,0.8,1)
dt:SetEase(_Ease.Linear)
dt:SetLoops(-1,_LoopType.Yoyo)
self.bDotweenList[index]=dt
end
end


function UIXianGuanMainWin:removeAllBreathBt()
if self.bDotweenList then
for index,dt in pairs(self.bDotweenList)do
dt:Complete()
dt:Kill()
end

self.bDotweenList=nil
end
end



function UIXianGuanMainWin:onChangeXianGuanJob(jobInfo)


if jobInfo and 1==jobInfo.groupId then
self:refreshRightBar()
self:refreshXGList()
self:refreshButton()
end
end

function UIXianGuanMainWin:onChangeSelfPrivilegeCount()
self:refreshButton()
end

function UIXianGuanMainWin:onChangeJingXuanSegment(campaignType)
if campaignType==XianGuanCampaignType.eWenXuan then
self:refreshCompaignBtn1()
elseif campaignType==XianGuanCampaignType.eWuXuan then
self:refreshCompaignBtn2()
end
end

function UIXianGuanMainWin:onLimitActReddotChange(limitActType)
if limitActType==LIMIT_ACT_TYPE.eXianGuanWuXuan then
self:refreshCompaignReddot2()
elseif limitActType==LIMIT_ACT_TYPE.eXianGuanWenXuan then
self:refreshCompaignReddot1()
end
end





function UIXianGuanMainWin:onBackButton()
self:closeSelf()
end



function UIXianGuanMainWin:onCompaignBtn_1()
UIFullXJForceControl:showJingXuanMainWindow(XianGuanCampaignType.eWenXuan)
end


function UIXianGuanMainWin:onCompaignBtn_2()
UIFullXJForceControl:showJingXuanMainWindow(XianGuanCampaignType.eWuXuan)
end



function UIXianGuanMainWin:onHelpBtn()








local args={
ruleGroupID=ruleTipsImageGroup.eXianGuan
}
self:showWindow("UIRuleTipsImage2Win",args)
end



function UIXianGuanMainWin:onPrivilegeBtn()
if xianguanController.checkHasVoluintaryPrivilege()then
self:showWindow("UIXianGuanTeQuanWin")
else
UIManager.error("没有主动特权")
end
end

function UIXianGuanMainWin:onLogBtn()
self:showWindow("UIXianGuanLogDetailWin")
end

function UIXianGuanMainWin:onStageUpBtn()

end

function UIXianGuanMainWin:onStageDownBtn()

end


