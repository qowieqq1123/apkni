







def_class("UIXianGuanCampaignMainWin",UIWindowBase)









function UIXianGuanCampaignMainWin:bindComponents()

self.backButton=UIButton.get(self,0)
self.background=UIImage.get(self,1)
self.campaignTabBtn=UIButton.get(self,2)
self.helpBtn=UIButton.get(self,3)
self.jobList=UIObject.get(self,4)
self.listBg=UIObject.get(self,5)
self.registerBtn=UIButton.get(self,6)
self.rewardBtn=UIButton.get(self,7)
self.rewardReddot=UIObject.get(self,8)
self.signupBtn=UIButton.get(self,9)
self.signupName=UIText.get(self,10)
self.stageList=UIObject.get(self,11)
self.stateText=UIText.get(self,12)
self.teamBtn=UIButton.get(self,13)
self.timeText=UIText.get(self,14)
self.titleText=UIText.get(self,15)

self.backButton:setButtonClick(function()self:onBackButton()end)

self.campaignTabBtn:setButtonClick(function()self:onCampaignTabBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.registerBtn:setButtonClick(function()self:onRegisterBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.signupBtn:setButtonClick(function()self:onSignupBtn()end)

self.teamBtn:setButtonClick(function()self:onTeamBtn()end)



end


function UIXianGuanCampaignMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backButton);self.backButton=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.campaignTabBtn);self.campaignTabBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.jobList);self.jobList=nil;
_UIObject_release(self.listBg);self.listBg=nil;
_UIObject_release(self.registerBtn);self.registerBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.signupBtn);self.signupBtn=nil;
_UIObject_release(self.signupName);self.signupName=nil;
_UIObject_release(self.stageList);self.stageList=nil;
_UIObject_release(self.stateText);self.stateText=nil;
_UIObject_release(self.teamBtn);self.teamBtn=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end
















local CmpStageItemIndex={
select=0,
name=1,
icon=2,
icon1=3,
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
bg1=26,
cxBtn=27,
qxBtn=28,
}

local _this

local _ab=globalABLookup.xianguan
local _jx_ab=globalABLookup.xianguanJingXuan

local _bgOffsetY={[3]={0,0},[2]={-3,-25},[1]={2,-23}}




function UIXianGuanCampaignMainWin:onLoaded(...)
self:bindComponents()
_this=self

self:addProNotify(40,26,self.on_40_26)
self:addProNotify(40,23,self.on_40_23)
self:addNotify(notifyConfig.onXianGuanJingXuanSegmentChange,self.refreshJingXuanSegment)

self.campaignType=1
self.eStageIdx=1

end


function UIXianGuanCampaignMainWin:__delete()
self:unbindComponents()

_this=nil
end

function UIXianGuanCampaignMainWin.refreshJingXuanSegment(campaignType,oldStatus)
if campaignType==XianGuanCampaignType.eWenXuan then
local segment=xianguanController:getActivitySegment_WenXuan_Compatible()
if segment~=XianGuanWenXuanSegment.eRegister then
UIManager.info("报名时间已结束")
UIFullXJForceControl:closeWindow(_this.__name)

UIFullXJForceControl:showJingXuanMainWindow(XianGuanCampaignType.eWenXuan)
return
end
elseif campaignType==XianGuanCampaignType.eWuXuan then
local segment=xianguanController:getActivitySegment_WuXuan_Compatible()
if segment~=XianGuanWuXuanSegment.eRegister then
local openBWMatch=xianguanController:isInMatchStage_enter_WuXuan_BW()
local tipsStr="报名时间已结束"
if openBWMatch then
tipsStr="补位报名时间已结束"
end
UIManager.info(tipsStr)
UIFullXJForceControl:closeWindow(_this.__name)

UIFullXJForceControl:showJingXuanMainWindow(XianGuanCampaignType.eWuXuan)
return
end
end
_this:refreshAll(campaignType)
end

function UIXianGuanCampaignMainWin.on_40_26()
if _this.campaignType==XianGuanCampaignType.eWuXuan then
_this:refreshReward()
end
end

function UIXianGuanCampaignMainWin.on_40_23()
if _this.campaignType==XianGuanCampaignType.eWuXuan then
_this:refreshJobListButton()
_this:refreshSignUp()
end
end




function UIXianGuanCampaignMainWin:onShow(argtable,afterOnloaded)
self.campaignType=argtable and argtable.campaignType or self.campaignType
self.eStageIdx=argtable and argtable.stage or self.eStageIdx

if afterOnloaded then
self.listBg:setChildUIModelShowTarget(6019,1,nil,eAnimationID.stand,false,true,0)
end

if self.campaignType==XianGuanCampaignType.eWenXuan then
self.isInWBMatch=xianguanController:isInMatchStage_enter_WenXuan_BW()
elseif self.campaignType==XianGuanCampaignType.eWuXuan then
self.isInWBMatch=xianguanController:isInMatchStage_enter_WuXuan_BW()
end

self:refreshAll()
end


function UIXianGuanCampaignMainWin:onHide()

end


function UIXianGuanCampaignMainWin:refreshAll(campaignType)
if campaignType~=nil and campaignType~=self.campaignType then
return
end

self:refreshTime()


self:refreshCampaignTabBtn()


self:refreshLeftBar()


self:refreshXGList()


self:refreshReward()
end

function UIXianGuanCampaignMainWin:refreshTime()
local status,beginTime,endTime=xianguanController:getActivitySegment_Enter_Campaign_Compatible(self.campaignType)
self.status=status
if self.campaignType==XianGuanCampaignType.eWenXuan then
if status==XianGuanWenXuanSegment.eNone or status==XianGuanCampaignType.eFinish then
local str=status==XianGuanCampaignType.eFinish and"已结束"or"未开启"
self.stateText:setText(str)
self.timeText:setText("")
if self.myTimer~=nil then
self:stopTimerByID(self.myTimer)
self.myTimer=nil
end
return
end
else
if status==XianGuanWuXuanSegment.eNone or status==XianGuanWuXuanSegment.eFinish then
local str=status==XianGuanWuXuanSegment.eFinish and"已结束"or"未开启"
self.stateText:setText(str)
self.timeText:setText("")
if self.myTimer~=nil then
self:stopTimerByID(self.myTimer)
self.myTimer=nil
end
return
end
end

if self.myTimer~=nil then
self:stopTimerByID(self.myTimer)
self.myTimer=nil
end

local timeFunc
if self.campaignType==XianGuanCampaignType.eWenXuan then
timeFunc=function()
local currTime=timeHelper.getServerShortTime()
if endTime<currTime then
self:stopTimerByID(self.myTimer)
self.myTimer=nil
return
end
local stateT_str
local openWenXuanBWOpen=xianguanController:isInMatchStage_enter_WenXuan_BW()

if status==XianGuanWenXuanSegment.eRegister then
stateT_str="报名阶段"
elseif status==XianGuanWenXuanSegment.eVote then
stateT_str="投票阶段"
elseif status==XianGuanWenXuanSegment.eFinish then
stateT_str="已结束"
else
stateT_str="未开始"
end
if openWenXuanBWOpen then
stateT_str='补位'..stateT_str
end
local time_str=FMT.fmt('倒计时：{0}',timeHelper.format_time_stamp3(endTime-currTime))
self.stateText:setText(stateT_str)
self.timeText:setText(time_str)
end
elseif XianGuanCampaignType.eWuXuan then
timeFunc=function()
local currTime=timeHelper.getServerShortTime()
if endTime<currTime then
self:stopTimerByID(self.myTimer)
self.myTimer=nil
return
end
local stateT_str
local openWuXuanBWOpen=xianguanController:isInMatchStage_enter_WuXuan_BW()

if status==XianGuanWuXuanSegment.eRegister then
stateT_str="报名阶段"
elseif status==XianGuanWuXuanSegment.eReady then
stateT_str="准备阶段"
elseif status==XianGuanWuXuanSegment.eMatch then
stateT_str="比赛阶段"
elseif status==XianGuanWuXuanSegment.eFinish then
stateT_str="已结束"
else
stateT_str="未开始"
end
if openWuXuanBWOpen then
stateT_str='补位'..stateT_str
end
local time_str=FMT.fmt('倒计时：{0}',timeHelper.format_time_stamp3(endTime-currTime))
self.stateText:setText(stateT_str)
self.timeText:setText(time_str)
end
end
if timeFunc~=nil then
self.myTimer=self:setTimer(1,0,timeFunc)
timeFunc()
end
end

function UIXianGuanCampaignMainWin:refreshReward()
if self.campaignType==1 then

local reward=xianguanController:getWenXuanReddot_Compatible()
self.rewardBtn:setActive(reward)
self.rewardReddot:setActive(reward)
else
local segment=xianguanModel:getWuXuanActivitySegment()
local reward=xianguanController:getWuXuanReddot_Compatible()
self.rewardBtn:setActive(reward)
self.rewardReddot:setActive(reward)
end
end

function UIXianGuanCampaignMainWin:refreshCampaignTabBtn()
self.titleText:setText(self.campaignType==1 and"仙官文选"or"仙官武选")
self.campaignTabBtn:setCSImageSprite(_jx_ab,FMT.fmt("button_xgwx_qiehuan_{0}",self.campaignType==1 and 2 or 1))

self.teamBtn:setActive(self.campaignType==2)
end

function UIXianGuanCampaignMainWin:refreshLeftBar()
local topCfg=cfgHelper.get1(cfg_xianguangroupconfig_get,1)

local reserveStageIconList=topCfg.stageIconList

local stageNameList=table.weakCopy(topCfg.stageNameList1)
table.insert(stageNameList,"全 部")
stageNameList=table.reverse(stageNameList)
if stageNameList~=nil then
local stageLen=#stageNameList

local createFunc=function(index)
local item=_this.stageList:getChildLayoutGroupGridItem(index-1)
local idx=index-1

local name=stageNameList[index]
local isShow=name~=nil

item:SetChildActive(-1,isShow)

if isShow then
local iconIndex=reserveStageIconList[idx]
local iconName=FMT.fmt("icon_xianguanui_{0}",idx==0 and 1 or iconIndex)
item:SetChildCSImageSprite(CmpStageItemIndex.icon,_ab,iconName)

local iconIndex1=reserveStageIconList[#reserveStageIconList-idx+1]
local iconName1=FMT.fmt("icon_xiangongtequan_{0}",idx==0 and 4 or iconIndex1)
item:SetChildCSImageSprite(CmpStageItemIndex.icon1,_ab,iconName1)

item:SetChildText(CmpStageItemIndex.name,name)

local isSelect=_this.eStageIdx==index
item:SetChildActive(CmpStageItemIndex.select,isSelect)

local selectFunc=function()
if _this==nil then return end

local preItem=_this.stageList:getChildLayoutGroupGridItem(_this.eStageIdx-1)
preItem:SetChildActive(CmpStageItemIndex.select,false)

_this.eStageIdx=index
item:SetChildActive(CmpStageItemIndex.select,true)

_this:refreshXGList()
end

item:SetChildButtonClick(-1,selectFunc,true)
end
end

self.stageList:setChildLayoutGroupCreateItems(stageLen,createFunc)
end
end

function UIXianGuanCampaignMainWin:refreshSignUp()
local officer_id=xianguanController:getJingXuanPlayerJob(XianGuanCampaignType.eWenXuan)
officer_id=officer_id or xianguanController:getJingXuanPlayerJob(XianGuanCampaignType.eWuXuan)
local cfg=officer_id and xianguanConfig.getJobConfig(1,officer_id)or nil
self.signupBtn:setCSImageSprite(_jx_ab,FMT.fmt("button_canxuan_{0}",cfg~=nil and 1 or 2))
self.signupName:setText(cfg~=nil and cfg.name or"未参选")
end

function UIXianGuanCampaignMainWin:refreshXGList()
local officer_id=xianguanController:getJingXuanPlayerJob(XianGuanCampaignType.eWenXuan)
officer_id=officer_id or xianguanController:getJingXuanPlayerJob(XianGuanCampaignType.eWuXuan)
if officer_id==nil then
local jobInfo=xianguanModel:getSelfGroupJobInfo(1)
if next(jobInfo)then
officer_id=jobInfo.jobId
end
end
local cfg=officer_id and xianguanConfig.getJobConfig(1,officer_id)or nil
self.signupBtn:setCSImageSprite(_jx_ab,FMT.fmt("button_canxuan_{0}",cfg~=nil and 1 or 2))
self.signupName:setText(cfg~=nil and cfg.name or"未参选")

local topCfg=cfgHelper.get1(cfg_xianguangroupconfig_get,1)
local reserveStageIconList=table.weakCopy(topCfg.stageIconList)
table.insert(reserveStageIconList,0)
reserveStageIconList=table.reverse(reserveStageIconList)

local jobCfgList=xianguanConfig.getCampaignListConfig(self.campaignType,reserveStageIconList[self.eStageIdx])
self.confgs=jobCfgList
local cfgLen=#jobCfgList
local _minH=math.min(math.abs(jobCfgList[1].pos[2])-math.abs(jobCfgList[cfgLen].pos[2])+200,750)
local _h=(750-_minH)/2
local initHeight=self.eStageIdx>2 and math.abs(jobCfgList[cfgLen].pos[2])-_h or 0
local totleHeight=math.abs(jobCfgList[1].pos[2])+350-initHeight
self.jobList:setChildSizeDelta(1034,math.min(math.max(totleHeight,750),2750))

local model1CreateFunc=function(index,item,cfg)
local isShow=cfg~=nil
item:SetChildActive(-1,isShow)
if isShow then
local jobPlayerInfo=xianguanController.getJobPlayerInfo(topCfg.id,cfg.id)
local isHasPlayer=jobPlayerInfo and jobPlayerInfo.actorid~=nil

item:SetChildActive(CmpJobItemIndex.headBg,isHasPlayer)
item:SetChildActive(CmpJobItemIndex.addFlagBg,not isHasPlayer)
item:SetChildActive(CmpJobItemIndex.addFlag,not isHasPlayer)
item:SetChildActive(CmpJobItemIndex.addFlag,not isHasPlayer)
item:SetChildActive(CmpJobItemIndex.playerBg,isHasPlayer)
item:SetChildActive(CmpJobItemIndex.jobState,not isHasPlayer)
item:SetChildActive(CmpJobItemIndex.bLevelBg,isHasPlayer)





if isHasPlayer then
local iconInfo=jobPlayerInfo.iconInfo
playerController:setHeadIcon(item,CmpJobItemIndex.head,{scale=1,iconInfo=iconInfo})

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
local isHasPlayer=jobPlayerInfo and jobPlayerInfo.actorid~=nil

item:SetChildActive(CmpJobItemIndex.xwyd,not isHasPlayer)
item:SetChildActive(CmpJobItemIndex.mask,isHasPlayer)
item:SetChildActive(CmpJobItemIndex.playerInfo,isHasPlayer)

if isHasPlayer then

local selfActorId=playerModel:getActorID()
local isSelf=mathHelper.compareInt64(selfActorId,jobPlayerInfo.actorid)
local nameColor=isSelf and"#aae252"or"#f7f7f7"
local namtStr=toColorStringX(nameColor,jobPlayerInfo.actorname)
item:SetChildText(CmpJobItemIndex.info2,namtStr)


local replace={[PLAYER_IMAGE_TYPE.eBodyOrnament]=1}
playerController:setImage(item,CmpJobItemIndex.model,jobPlayerInfo.sex,jobPlayerInfo.iconInfo,playerController:supportDynamic(),0.8,replace)

else


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

local officer_id=xianguanController:getJingXuanPlayerJob(XianGuanCampaignType.eWenXuan)or xianguanController:getJingXuanPlayerJob(XianGuanCampaignType.eWuXuan)
local cfg=jobCfgList[index]

local isModel2=cfg.stage==4

item:SetChildActive(CmpJobItemIndex.model2,isModel2)
item:SetChildActive(CmpJobItemIndex.model1,not isModel2)

if isModel2 then
model2CreateFunc(index,item,cfg)
else
model1CreateFunc(index,item,cfg)
end


item:SetChildAnchoredPos(-1,cfg.pos[1],cfg.pos[2]+initHeight)

local canCX=xianguanConfig.checkCanJob(topCfg.id,cfg.id)
local hasCX=officer_id~=nil
local canQX=officer_id==cfg.id

local isBWHasActor=false
local isHasJob=false
if _this.isInWBMatch then
isBWHasActor=xianguanController:checkJobHasActor(cfg.id)
isHasJob=xianguanController:checkSelfHasJob()
end

local isRegister=_this.status==1
item:SetChildCSImageSprite(CmpJobItemIndex.cxBtn,_jx_ab,self.campaignType==XianGuanCampaignType.eWenXuan and"button_wenxuancanxuan_1"or"button_wuxuancanxuan_1")
item:SetChildCSImageSprite(CmpJobItemIndex.qxBtn,_jx_ab,self.campaignType==XianGuanCampaignType.eWenXuan and"button_wenxuancanxuan_2"or"button_wuxuancanxuan_2")
item:SetChildGray(CmpJobItemIndex.cxBtn,not canCX and(not isBWHasActor)and(not isHasJob))
item:SetChildActive(CmpJobItemIndex.cxBtn,(not isBWHasActor)and not hasCX and isRegister and(not isHasJob))
item:SetChildActive(CmpJobItemIndex.qxBtn,canQX and isRegister)
item:SetChildButtonClick(CmpJobItemIndex.cxBtn,function()
if not canCX then
UIManager.error(FMT.fmt("{0}可参选",xianguanConfig.getJobCondition(topCfg.id,cfg.id,true)))
return
end
if cfg.campaignType==XianGuanCampaignType.eWenXuan then
UIManager:showWindow("UIXianGuanCampaignDescWin",{officerId=cfg.id})
elseif cfg.campaignType==XianGuanCampaignType.eWuXuan then
UIFullXJForceControl:showWuXuanAttendWin(cfg.id)
end
end)
item:SetChildButtonClick(CmpJobItemIndex.qxBtn,function()
local config=xianguanController:getJingXuanConfig(self.campaignType)


local showdata={
type='UIDialouge',
title='提示',
content=FMT.fmt("取消参选后，需要等待{0}秒可再参选，\n是否取消？",config.cooldown_sec),
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function()
local isRegister=_this.status==1
if not isRegister then
UIManager.error("只有报名阶段才能取消参选")
return
end
if _this.campaignType==1 then
xianguanController:req_send_40_9()
else
xianguanController:send_40_23_cancel()
end
end,
showclosebtn=true,
}
local dialog=UIDialogManager.newDialog(showdata)
dialog:show()
end)

local clickFunc=function()
if _this==nil then return end
local args={groupId=topCfg.id,jobId=cfg.id,isCampaign=true}

_this:showWindow("UIXianGuanJobDetailsWin",args)
end

item:SetBaseItemClickEvent(-1,clickFunc)
end
self.jobList:setChildLayoutGroupCreateItems(cfgLen,createFunc)
end

function UIXianGuanCampaignMainWin:refreshJobListButton()
local items=self.jobList:getChildLayoutGroupGridList()
local topCfg=cfgHelper.get1(cfg_xianguangroupconfig_get,1)
local reserveStageIconList=topCfg.stageIconList
local officer_id=xianguanController:getJingXuanPlayerJob(self.campaignType)
for index=1,items.Count do
local item=items[index-1]
local cfg=self.confgs[index]
local canCX=xianguanConfig.checkCanJob(topCfg.id,cfg.id)
local hasCX=officer_id~=nil
local canQX=officer_id==cfg.id

local isRegister=_this.status==1
item:SetChildGray(CmpJobItemIndex.cxBtn,not canCX)
item:SetChildActive(CmpJobItemIndex.cxBtn,not hasCX and isRegister)
item:SetChildActive(CmpJobItemIndex.qxBtn,canQX and isRegister)
end
end






function UIXianGuanCampaignMainWin:onBackButton()
self:closeSelf()
end



function UIXianGuanCampaignMainWin:onHelpBtn()
local isBW=xianguanController:IsInBWMatchStage_Campaign_Compatible(self.campaignType)
local d={}
d.mode=3
d.title="说明"
if isBW then
d.name=FMT.fmt('xianguan_jingxuan_buwei_{0}_%d',self.campaignType)
else
d.name=FMT.fmt('xianguan_jingxuan_{0}_%d',self.campaignType)
end
d.showBlack=true
self:showWindow('UIRuleWin',d)
end



function UIXianGuanCampaignMainWin:onRegisterBtn()
local job=xianguanController:getJingXuanPlayerJob(self.campaignType)
UIFullXJForceControl:showJingXuanWindow(self.campaignType,job)
end



function UIXianGuanCampaignMainWin:onRewardBtn()

local config=xianguanController:getJingXuanConfig(self.campaignType)
local segment=xianguanController:getActivitySegment_Campaign_Compatible(self.campaignType)
if config.free_gift[segment]then
local free_flag=xianguanController:getJingXuanFreeReward(self.campaignType)
if self.campaignType==XianGuanCampaignType.eWenXuan then
if not mathHelper.getBitValue(free_flag,segment)then
xianguanController:req_send_40_3(segment)
end
elseif self.campaignType==XianGuanCampaignType.eWuXuan then
if not mathHelper.getBitValue(free_flag,segment)then
xianguanController:send_40_26(segment)
end
end
end
end



function UIXianGuanCampaignMainWin:onCampaignTabBtn()
if self.campaignType==XianGuanCampaignType.eWenXuan then
local segment=xianguanController:getActivitySegment_WuXuan_Compatible()
if segment==XianGuanWuXuanSegment.eNone or segment==XianGuanWuXuanSegment.eFinish then
UIManager.error("不在活动时间内")
return
end
if segment==XianGuanWuXuanSegment.eRegister then
self.campaignType=XianGuanCampaignType.eWuXuan
else
UIFullXJForceControl:closeWindow(self.__name)
UIFullXJForceControl:showJingXuanMainWindow(XianGuanCampaignType.eWuXuan)
return
end
elseif self.campaignType==XianGuanCampaignType.eWuXuan then
local segment=xianguanController:getActivitySegment_WenXuan_Compatible()
if segment==XianGuanWenXuanSegment.eNone or segment==XianGuanWenXuanSegment.eFinish then
UIManager.error("不在活动时间内")
return
end
if segment==XianGuanWenXuanSegment.eRegister then
self.campaignType=XianGuanCampaignType.eWenXuan
else
UIFullXJForceControl:closeWindow(self.__name)
UIFullXJForceControl:showJingXuanMainWindow(XianGuanCampaignType.eWenXuan)
return
end
end
self:refreshAll()
end



function UIXianGuanCampaignMainWin:onSignupBtn()
local officerId=xianguanController:getJingXuanPlayerJob(XianGuanCampaignType.eWenXuan)
officerId=officerId or xianguanController:getJingXuanPlayerJob(XianGuanCampaignType.eWuXuan)
local cfg=officerId and xianguanConfig.getJobConfig(1,officerId)or nil
if cfg then
local topCfg=cfgHelper.get1(cfg_xianguangroupconfig_get,1)
local args={groupId=topCfg.id,jobId=cfg.id,isCampaign=true}
_this:showWindow("UIXianGuanJobDetailsWin",args)
else
UIManager.error("尚未参选仙官")
end
end

function UIXianGuanCampaignMainWin:onTeamBtn()
local job=xianguanModel:getWuXuanPlayerJob()
if job==nil or job<=0 then
UIManager.error("参选武官后方可调整")
return
end

local winArgs=
{
enterTxt="仙官武选",
skipDiscipleStateCheck=true,
statePriorityCheck=false,
skipDiscipleInjuryCheck=true,
skipShouYuanCheck=true,
sureBodyid=2068,
sureBodyAnim=eAnimationID.dog_idle_1,
cancelCallBack=function()
UIFullXJForceControl:jumpJingXuanMainWindow(XianGuanCampaignType.eWuXuan)
end,
enterCallBack=function(guidList)
local teamList={}
for i,v in ipairs(guidList)do
if v[1]==fightPreSelectModel.teamEntityType.dizi then
table.insert(teamList,v[2])
else
table.insert(teamList,int64.zero)
end
end
xianguanController:send_40_24(teamList)

UIManager:invokeUIMethod('UIFightPrepareWin','onCancelFunc')
fightController:closeSelectStage()
end,
}
fightController.showPrepareWin(eFightPreSelectType.xianguanwuxuan,winArgs)
end