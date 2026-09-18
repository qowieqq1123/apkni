







def_class("UIXianGuanCampaignRegisterWin",UIWindowBase)









function UIXianGuanCampaignRegisterWin:bindComponents()

self.background=UIImage.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.endDesc=UIObject.get(self,2)
self.helpBtn=UIButton.get(self,3)
self.jobList=UIObject.get(self,4)
self.mbg=UIObject.get(self,5)
self.meNotRank=UIText.get(self,6)
self.meOppose=UIText.get(self,7)
self.meOtherJob=UIText.get(self,8)
self.meRank=UIText.get(self,9)
self.meRoot=UIButton.get(self,10)
self.meSupport=UIText.get(self,11)
self.moneyRoot1=UIObject.get(self,12)
self.moneyRoot2=UIObject.get(self,13)
self.moneyRoot3=UIObject.get(self,14)
self.notCampaign=UIText.get(self,15)
self.officerItem_1=UIBaseItem.get(self,16)
self.officerItem_2=UIBaseItem.get(self,17)
self.officerItem_3=UIBaseItem.get(self,18)
self.officerSlot=UIBaseItem.get(self,19)
self.panel1=UIObject.get(self,20)
self.panel2=UIObject.get(self,21)
self.qiuYuanBtn=UIButton.get(self,22)
self.refreshBtn=UIButton.get(self,23)
self.registerScrollView=UILoopListView.new(self,24)
self.rewardBtn=UIButton.get(self,25)
self.rewardReddot=UIObject.get(self,26)
self.root=UIObject.get(self,27)
self.searchBtn=UIButton.get(self,28)
self.searchInput=UIInputField.get(self,29)
self.timeText=UIText.get(self,30)
self.titleIcon=UIImage.get(self,31)
self.titleText=UIText.get(self,32)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.meRoot:setButtonClick(function()self:onMeRoot()end)

self.qiuYuanBtn:setButtonClick(function()self:onQiuYuanBtn()end)

self.refreshBtn:setButtonClick(function()self:onRefreshBtn()end)

self.registerScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)
self.officerItem={
self.officerItem_1,
self.officerItem_2,
self.officerItem_3,
}



end


function UIXianGuanCampaignRegisterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.endDesc);self.endDesc=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.jobList);self.jobList=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.meNotRank);self.meNotRank=nil;
_UIObject_release(self.meOppose);self.meOppose=nil;
_UIObject_release(self.meOtherJob);self.meOtherJob=nil;
_UIObject_release(self.meRank);self.meRank=nil;
_UIObject_release(self.meRoot);self.meRoot=nil;
_UIObject_release(self.meSupport);self.meSupport=nil;
_UIObject_release(self.moneyRoot1);self.moneyRoot1=nil;
_UIObject_release(self.moneyRoot2);self.moneyRoot2=nil;
_UIObject_release(self.moneyRoot3);self.moneyRoot3=nil;
_UIObject_release(self.notCampaign);self.notCampaign=nil;
_UIObject_release(self.officerItem_1);self.officerItem_1=nil;
_UIObject_release(self.officerItem_2);self.officerItem_2=nil;
_UIObject_release(self.officerItem_3);self.officerItem_3=nil;
_UIObject_release(self.officerSlot);self.officerSlot=nil;
_UIObject_release(self.panel1);self.panel1=nil;
_UIObject_release(self.panel2);self.panel2=nil;
_UIObject_release(self.qiuYuanBtn);self.qiuYuanBtn=nil;
_UIObject_release(self.refreshBtn);self.refreshBtn=nil;
self.registerScrollView:deleteSelf();self.registerScrollView=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.searchInput);self.searchInput=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.titleIcon);self.titleIcon=nil;
_UIObject_release(self.titleText);self.titleText=nil;
self.officerItem=nil;
end
















local CmpJobItemIndex={
select=0,
name=1,
icon=2,
icon1=3,
}

local CmpOfficerItemIndex={
rankIcon=0,
rankText=1,
name=2,
serverName=3,
xmName=4,
}

local CmpOfficerSlotIndex={
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
}

local CmpRegisterItemIndex={
panel1=0,
head=1,
levelBg=2,
level=3,
serverName=4,
xmName=5,
name=6,
desc=7,
panel2=8,
head2=9,
levelBg2=10,
level2=11,
serverName2=12,
xmName2=13,
name2=14,
desc2=15,
supportNum2=16,
supportBtn2=17,
opposeBtn2=18,
rankIcon2=19,
rankText2=20,
changeDesc=21,
bg=22,
supportImg2=23,
opposeImg2=24,
endIcon=25,
}

local titleIconnameEnum={
[2]="image_xiangongyouhwx_06",
[5]="image_xiangongyouhwx_05",
[9]="image_xiangongyouhwx_04",
[10]="image_xiangongyouhwx_02",
[11]="image_xiangongyouhwx_03",
}

local _this

local _ab=globalABLookup.xianguan
local _jx_ab=globalABLookup.xianguanJingXuan

local _bgOffsetY={[3]={0,0},[2]={-3,-25},[1]={2,-23}}




function UIXianGuanCampaignRegisterWin:onLoaded(...)
self:bindComponents()
_this=self

self.fmTweener={}

self.qiuYuanBtn:setActive(false)

self._onItemListChanged=function(...)self:onItemListChanged(...)end
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self._onItemListChanged)

notifySystem:listenNotify(notifyConfig.onXianGuanJingXuanSegmentChange,self.refreshJingXuanSegment)

self.eSelfJobIdx=nil
self.campaignType=1
self.eJobIdx=1

self.loopListViewCmp=self.winlua:GetChildLoopListView2(self.registerScrollView:getID())

self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)

end


function UIXianGuanCampaignRegisterWin:__delete()
self:unbindComponents()

for k,v in pairs(self.fmTweener)do
v:Kill()
end

notifySystem:removelistener(notifyConfig.on_item_list_changed,self._onItemListChanged)
notifySystem:removelistener(notifyConfig.onXianGuanJingXuanSegmentChange,self.refreshJingXuanSegment)
_this=nil
end

function UIXianGuanCampaignRegisterWin.refreshJingXuanSegment(campaignType,oldStatus)
if _this.campaignType==campaignType then
local status=xianguanController:getActivitySegment_Enter_WenXuan_Compatible()
if status~=oldStatus then
_this:refreshAll()
end
end
end




function UIXianGuanCampaignRegisterWin:onShow(argtable,afterOnloaded)
self.callback=argtable.callback

self.campaignType=argtable and argtable.campaignType or self.campaignType
local selfJob=xianguanModel:getWenXuanPlayerJob()

self.config=xianguanController:getJingXuanConfig(XianGuanCampaignType.eWenXuan)

self.openBWState=xianguanController:isInMatchStage_WenXuan_BW()
if self.openBWState then
self.bwShowJobLookup=xianguanModel:getBWMatchJobLookUp_WenXuan()
end

for k,v in pairs(self.fmTweener)do
v:Kill()
end
self.fmTweener={}
self.lastcount={}

self.jobs={}
local cfgs=xianguanConfig.getCampaignJobListConfig(self.campaignType)
for i,v in ipairs(cfgs)do
if self.openBWState then
if self.bwShowJobLookup[v.id]then
table.insert(self.jobs,v)
end
else
table.insert(self.jobs,v)
end
end

if argtable.jobId or selfJob~=0 then
local flag1=not argtable.jobId
local flag2=not selfJob
for i,v in ipairs(self.jobs)do
if argtable.jobId and v.id==argtable.jobId then
self.eJobIdx=i
flag1=true
end
if selfJob~=0 and v.id==selfJob then
self.eSelfJobIdx=i
flag2=true
end
if flag1 and flag2 then
break
end
end
end

self.curJobId=self.jobs[self.eJobIdx].id

self:initMoneyRoot()
self:refreshAll()

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(5900,1,nil,eAnimationID.stand,false,false,0,function()
if _this==nil then return end
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end
end


function UIXianGuanCampaignRegisterWin:onHide()

end


function UIXianGuanCampaignRegisterWin:refreshAll()

self:refreshTime()
self:refreshJobBar()
self:refreshReward()
self:refreshView()

local selfJob=xianguanModel:getWenXuanPlayerJob()
local list=xianguanModel:getWenXuanRecordList(self.curJobId)
if not list or xianguanModel:getIsSendWenXuanRecord(self.curJobId)then
xianguanController:req_send_40_5(self.curJobId)
else
self:refreshList()

if selfJob==self.curJobId then
self:refreshSelfRank()
end
end


if self.status==XianGuanWenXuanSegment.eVote and selfJob~=0 and selfJob~=self.curJobId then
local selfList=xianguanModel:getWenXuanRecordList(selfJob)
if not selfList or xianguanModel:getIsSendWenXuanRecord(selfJob)then
xianguanController:req_send_40_5(selfJob)
else
self:refreshSelfRank()
end
end
end

function UIXianGuanCampaignRegisterWin:refreshTime()
local status,beginTime,endTime=xianguanController:getActivitySegment_Enter_WenXuan_Compatible()
self.status=status
local str=""
local showEnd=false
if status==XianGuanWenXuanSegment.eRegister then
str='报名倒计时：{0}'
elseif status==XianGuanWenXuanSegment.eVote then
str='投票倒计时：{0}'
elseif status==XianGuanWenXuanSegment.eNone or status==XianGuanWenXuanSegment.eFinish then
str='开启倒计时：{0}'
endTime=xianguanModel:getWenXuanNextOpenTime()
showEnd=true
elseif status==XianGuanWenXuanSegment.eBwWait then
str='补位倒计时：{0}'
showEnd=true
end
self.endDesc:setActive(showEnd)

if self.myTimer~=nil then
self:stopTimerByID(self.myTimer)
self.myTimer=nil
end
if not endTime then
self.endDesc:setActive(false)
self.timeText:setText("活动未开启")
return
end
local timeFunc=function()
local currTime=timeHelper.getServerShortTime()
if endTime<currTime then
self:stopTimerByID(self.myTimer)
self.myTimer=nil
return
end
local time_str=FMT.fmt(str,timeHelper.format_time_stamp3(endTime-currTime))
self.timeText:setText(time_str)

local flag=xianguanModel:getIsSendWenXuanRefresh()
self.refreshBtn:setGray(not flag)
end

self.myTimer=self:setTimer(1,0,timeFunc)
timeFunc()
end

function UIXianGuanCampaignRegisterWin:refreshJobBar()

local jobLen=#self.jobs
local jobCfgList=self.jobs

local createFunc=function(index)
local item=_this.jobList:getChildLayoutGroupGridItem(index-1)

local cfg=jobCfgList[index]

local iconName=FMT.fmt("icon_xianguanui_{0}",5-cfg.stage)
item:SetChildCSImageSprite(CmpJobItemIndex.icon,_ab,iconName)

local iconName1=FMT.fmt("icon_xiangongtequan_{0}",cfg.stage)
item:SetChildCSImageSprite(CmpJobItemIndex.icon1,_ab,iconName1)

local name=cfg.campaign_name
item:SetChildText(CmpJobItemIndex.name,name)

local isSelect=_this.eJobIdx==index
item:SetChildActive(CmpJobItemIndex.select,isSelect)

local selectFunc=function()
if _this==nil then return end
_this:jumpJob(index)
end

item:SetChildButtonClick(-1,selectFunc,true)
end

self.jobList:setChildLayoutGroupCreateItems(jobLen,createFunc)
end

function UIXianGuanCampaignRegisterWin:jumpJob(index)

if self.eJobIdx then
local preItem=self.jobList:getChildLayoutGroupGridItem(self.eJobIdx-1)
preItem:SetChildActive(CmpJobItemIndex.select,false)
end

self.eJobIdx=index
self.curJobId=self.jobs[index].id
local item=self.jobList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(CmpJobItemIndex.select,true)

local list=xianguanModel:getWenXuanRecordList(self.curJobId)
if not list or xianguanModel:getIsSendWenXuanRecord(self.curJobId)then
xianguanController:req_send_40_5(self.curJobId)
else
self:refreshList()
self:refreshSelfRank()
end
end

function UIXianGuanCampaignRegisterWin:getDataList()
local inputstr=self.searchInput:getInputFieldValue()
local datalist=xianguanModel:getWenXuanRecordList(self.curJobId)or{}
self.top3RankList={}
local list={}
for i,v in ipairs(datalist)do
if string.find(v.name,inputstr)~=nil then
v.rank=i
table.insert(list,v)
end
if i<=3 then
v.rank=i
table.insert(self.top3RankList,v)
end
end
return list
end

function UIXianGuanCampaignRegisterWin:refreshList(officer_id,list)
if not officer_id or officer_id==self.curJobId then
local isRegister=self.status==XianGuanWenXuanSegment.eRegister
local selfJob=xianguanModel:getWenXuanPlayerJob()
local selfActorId=playerModel:getActorID()
local hasMe=selfJob==self.curJobId
if list then
self.datalist=list
else
self.datalist={}
self.top3RankList={}
local list=xianguanModel:getWenXuanRecordList(self.curJobId)
if next(list)~=nil then
for i,v in ipairs(list)do
v.rank=i
table.insert(self.datalist,v)

if i<=3 then
table.insert(self.top3RankList,v)
end
end
end
end

self.meIndex=nil
local createCount=#self.datalist
local createList={}
self.dataListLookup={}
for i=1,createCount do
createList[#createList+1]=i

local actorStr=tostring(self.datalist[i].actor_id)
self.dataListLookup[actorStr]=i
end
if hasMe then
self.meIndex=self.dataListLookup[tostring(selfActorId)]
end
self.notCampaign:setActive(createCount==0)
self.registerScrollView:setActive(createCount>0)
self.registerScrollView:setChildSizeDelta(780,isRegister and 564 or 475)
if createCount>0 then
self.registerScrollView:initData('registerItem',createList)
self.registerScrollView:jumpItem(1)
end
end

self:refreshView()
end

function UIXianGuanCampaignRegisterWin:refreshView()
local isRegister=self.status==XianGuanWenXuanSegment.eRegister
local selfActorId=playerModel:getActorID()

self.panel1:setActive(isRegister)
self.panel2:setActive(not isRegister)

local curCfg=xianguanConfig.getJobConfig(1,self.curJobId)
self.titleIcon:setCSImageSprite(_jx_ab,titleIconnameEnum[curCfg.type])

if isRegister then
local topCfg=cfgHelper.get1(cfg_xianguangroupconfig_get,1)
local model1CreateFunc=function(item,cfg)
local isShow=cfg~=nil
item:SetChildActive(-1,isShow)
if isShow then
local jobPlayerInfo=xianguanController.getJobPlayerInfo(topCfg.id,cfg.id)
local isHasPlayer=jobPlayerInfo and jobPlayerInfo.actorid~=nil

item:SetChildActive(CmpOfficerSlotIndex.headBg,isHasPlayer)
item:SetChildActive(CmpOfficerSlotIndex.addFlagBg,not isHasPlayer)
item:SetChildActive(CmpOfficerSlotIndex.addFlag,not isHasPlayer)
item:SetChildActive(CmpOfficerSlotIndex.addFlag,not isHasPlayer)
item:SetChildActive(CmpOfficerSlotIndex.playerBg,isHasPlayer)
item:SetChildActive(CmpOfficerSlotIndex.jobState,not isHasPlayer)
item:SetChildActive(CmpOfficerSlotIndex.bLevelBg,isHasPlayer)

if isHasPlayer then
local iconInfo=jobPlayerInfo.iconInfo
playerController:setHeadIcon(item,CmpOfficerSlotIndex.head,{scale=1,iconInfo=iconInfo})

local isSelf=mathHelper.compareInt64(selfActorId,jobPlayerInfo.actorid)
local nameColor=isSelf and"#aae252"or"#f7f7f7"
local namtStr=toColorStringX(nameColor,jobPlayerInfo.actorname)
item:SetChildText(CmpOfficerSlotIndex.playerName,namtStr)


item:SetChildText(CmpOfficerSlotIndex.bLevel,jobPlayerInfo.level or 0)
else

item:SetChildActive(CmpOfficerSlotIndex.reddot,false)

local tipStr=toColorStringX("#efeded","虚位以待")
item:SetChildText(CmpOfficerSlotIndex.jobStateTip,tipStr)
end

local nameStr=string.insertBreakLine(cfg.name,true)
if pfwindowslController:checkIsGameVersion_yuenan()then
nameStr=cfg.name
end
item:SetChildText(CmpOfficerSlotIndex.nameTx,nameStr)

local titleBgName=topCfg.nameBgList[cfg.stage]
item:SetChildCSImageSprite(CmpOfficerSlotIndex.nameBg,_ab,titleBgName)

local bgName=topCfg.jobBgList[cfg.stage]
item:SetChildCSImageSprite(CmpOfficerSlotIndex.bg1,_ab,bgName)
item:SetChildAnchoredPos(CmpOfficerSlotIndex.bg1,_bgOffsetY[cfg.stage][1],_bgOffsetY[cfg.stage][2])

local jobIconName=xianguanConfig.getJobIconName(cfg.jobIcon)
item:SetChildCSImageSprite(CmpOfficerSlotIndex.nameIcon,_ab,jobIconName)

item:SetChildActive(CmpOfficerSlotIndex.compaignType,false)
end
end

local model2CreateFunc=function(item,cfg)
local jobPlayerInfo=xianguanController.getJobPlayerInfo(topCfg.id,cfg.id)
local isHasPlayer=jobPlayerInfo and jobPlayerInfo.actorid~=nil

item:SetChildActive(CmpOfficerSlotIndex.xwyd,not isHasPlayer)
item:SetChildActive(CmpOfficerSlotIndex.mask,isHasPlayer)
item:SetChildActive(CmpOfficerSlotIndex.playerInfo,isHasPlayer)

if isHasPlayer then







item:SetChildText(CmpOfficerSlotIndex.info2,jobPlayerInfo.actorname)


local replace={[PLAYER_IMAGE_TYPE.eBodyOrnament]=1}
playerController:setImage(item,CmpOfficerSlotIndex.model,jobPlayerInfo.sex,jobPlayerInfo.iconInfo,playerController:supportDynamic(),0.8,replace)
end

local jobIconName=xianguanConfig.getJobIconName(cfg.jobIcon)
item:SetChildCSImageSprite(CmpOfficerSlotIndex.icon2,_ab,jobIconName)

item:SetChildActive(CmpOfficerSlotIndex.typeIcon2,false)
local isShowJobImgName=cfg.jobImgName~=nil
if isShowJobImgName then
item:SetChildCSImageSprite(CmpOfficerSlotIndex.jobImgName,_ab,cfg.jobImgName)
end

end

local item=self.winlua:GetChildCSGUIBaseItem(self.officerSlot:getID())

local cfg=xianguanConfig.getJobConfig(1,self.curJobId)

local isModel2=cfg.stage==4

item:SetChildActive(CmpOfficerSlotIndex.model2,isModel2)
item:SetChildActive(CmpOfficerSlotIndex.model1,not isModel2)

if isModel2 then
model2CreateFunc(item,cfg)
else
model1CreateFunc(item,cfg)
end

local clickFunc=function()
if _this==nil then return end
local args={groupId=topCfg.id,jobId=cfg.id,isCampaign=true}

_this:showWindow("UIXianGuanJobDetailsWin",args)
end

item:SetBaseItemClickEvent(-1,clickFunc)
else
self:refreshMoneyRoot()
self:refreshTop3Rank()
end
end

function UIXianGuanCampaignRegisterWin:initMoneyRoot()
local isVote=self.status==XianGuanWenXuanSegment.eVote

self.moneyRoot1:setActive(isVote)
self.moneyRoot2:setActive(isVote)
self.moneyRoot3:setActive(isVote)

local wxData=xianguanModel:getWenXuanData()
local use_vote_agree_num=wxData and wxData.use_vote_agree_num or 0
local count1=self.config.free_vote_agree-use_vote_agree_num
local widget1=self.winlua:GetChildWidgetBase(self.moneyRoot1:getID())
widget1:SetChildCSImageSprite(0,_jx_ab,"image_dianzan_1")
widget1:SetChildText(1,count1)
widget1:SetChildActive(3,false)
self.lastcount[1]=count1

local use_vote_against_num=wxData and wxData.use_vote_against_num or 0
local count2=self.config.free_vote_against-use_vote_against_num
local widget2=self.winlua:GetChildWidgetBase(self.moneyRoot2:getID())
widget2:SetChildCSImageSprite(0,_jx_ab,"image_dianzan_2")
widget2:SetChildText(1,count2)
widget2:SetChildActive(3,false)
self.lastcount[2]=count2

local widget3=self.winlua:GetChildWidgetBase(self.moneyRoot3:getID())
local itemid=self.config.item_vote_agree
local itemCount=bagModel.getNotExpireItemCountById(itemid)
local iconName=iconHelper.getIconName(itemid)
widget3:SetChildIcon(0,iconName,false)
widget3:SetChildText(1,itemCount)
widget3:SetChildActive(3,true)
widget3:SetChildButtonClick(2,function()
gainControl:showGainWin(itemid)
end)
self.lastcount[3]=itemCount
end

function UIXianGuanCampaignRegisterWin:refreshMoneyRoot()
local isVote=self.status==XianGuanWenXuanSegment.eVote

self.moneyRoot1:setActive(isVote)
self.moneyRoot2:setActive(isVote)
self.moneyRoot3:setActive(isVote)
if isVote then
local wxData=xianguanModel:getWenXuanData()
local use_vote_agree_num=wxData and wxData.use_vote_agree_num or 0
local count1=self.config.free_vote_agree-use_vote_agree_num
self:freshMoneyValue(1,count1)

local use_vote_against_num=wxData and wxData.use_vote_against_num or 0
local count2=self.config.free_vote_against-use_vote_against_num
self:freshMoneyValue(2,count2)
end
end

function UIXianGuanCampaignRegisterWin:freshMoneyValue(index,itemCount)
local rootStr=FMT.fmt('moneyRoot{0}',index)
local widget=self.winlua:GetChildWidgetBase(self[rootStr]:getID())
self:clearFMTweener(index)
self.fmTweener[index]=_DOTweenProxy.DoValueTo(function()
return self.lastcount[index]
end,function(val)
local count=math.floor(val)
self.lastcount[index]=count
widget:SetChildText(1,count)
end,itemCount,1)
end

function UIXianGuanCampaignRegisterWin:clearFMTweener(index)
if self.fmTweener[index]then
self.fmTweener[index]:Kill()
self.fmTweener[index]=nil
end
end

function UIXianGuanCampaignRegisterWin:refreshTop3Rank()
local top3RankList=self.top3RankList or{}
for i=1,3 do
local recordData=top3RankList[i]
local widget=self.winlua:GetChildCSGUIBaseItem(self.officerItem[i]:getID())

if recordData then
local guildName=recordData.guild_name~=""and recordData.guild_name or"暂无仙盟"
local serverName=loginModel:getServerName(recordData.server_id)
serverName=FMT.fmt('[{0}]',serverName)

widget:SetChildText(CmpOfficerItemIndex.name,recordData.name)
widget:SetChildText(CmpOfficerItemIndex.serverName,serverName)
widget:SetChildText(CmpOfficerItemIndex.xmName,guildName)
else
widget:SetChildText(CmpOfficerItemIndex.name,"")
widget:SetChildText(CmpOfficerItemIndex.serverName,"暂无参选")
widget:SetChildText(CmpOfficerItemIndex.xmName,"")

end

widget:SetChildText(CmpOfficerItemIndex.rankText,i)
if i<=3 then
local rankIcon=FMT.fmt('icon_phbmingci_{0}',i)
widget:SetChildActive(CmpOfficerItemIndex.rankIcon,true)
widget:SetChildCSImageSprite(CmpOfficerItemIndex.rankIcon,globalABLookup.rankList,rankIcon)
else
widget:SetChildActive(CmpOfficerItemIndex.rankIcon,false)
end
end
end

function UIXianGuanCampaignRegisterWin:refreshSelfRank()
local isRegister=self.status==XianGuanWenXuanSegment.eRegister
local isVote=self.status==XianGuanWenXuanSegment.eVote
if isRegister then
return
end
local selfJob=xianguanModel:getWenXuanPlayerJob()
local selfActorId=playerModel:getActorID()
self.qiuYuanBtn:setActive(isVote and selfJob~=0)
self.refreshBtn:setActive(isVote)


if not selfJob or selfJob==0 then
self.meRoot:setActive(false)
self.meNotRank:setActive(true)
self.qiuYuanBtn:setActive(false)
self.meNotRank:setText("尚未参选仙官")
return
end
self.meRoot:setActive(true)
self.meNotRank:setActive(false)

if selfJob~=self.curJobId then
local curRank=xianguanModel:getWenXuanElectionRecordRankByActorId(selfJob,selfActorId)
self.meRank:setText("")
self.meSupport:setText("")
self.meOppose:setText("")
if not curRank then
self.meOtherJob:setText("")
else
if isVote then
self.meOtherJob:setText(FMT.fmt("我已参选：{0}      我的排名：{1}",self.jobs[self.eSelfJobIdx].campaign_name,curRank>100 and"100+"or curRank))
else
self.meOtherJob:setText(FMT.fmt("{0}仙官{1}",self.jobs[self.eSelfJobIdx].campaign_name,curRank==1 and"胜选"or"落选"))
end
end
return
end

local idx=self.dataListLookup[tostring(selfActorId)]
local myRecordData=self.datalist[idx]
self.meRank:setText(FMT.fmt("我的排名：{0}",myRecordData.rank>100 and"100+"or myRecordData.rank))
self.meSupport:setText(FMT.fmt("支持数：{0}",myRecordData.agree_num))
self.meOppose:setText(FMT.fmt("反对数：{0}",myRecordData.against_num))
self.meOtherJob:setText("")
end

function UIXianGuanCampaignRegisterWin:onFreshAction(i,widget)
local isRegister=_this.status==XianGuanWenXuanSegment.eRegister
local recordData=_this.datalist[i]

local iconInfo=recordData.iconInfo
local serverName=loginModel:getServerName(recordData.server_id)
serverName=FMT.fmt('[{0}]',serverName)
local guild_name=recordData.guild_name~=""and FMT.fmt('[{0}]',recordData.guild_name)or"暂无"
local declaration_idx=recordData.declaration_idx>0 and recordData.declaration_idx or 1
local descStr=cfgHelper.get2(cfg_officerelectiondeclarationconfig_get,declaration_idx,"desc")

local selfActorId=playerModel:getActorID()
local isSelf=mathHelper.compareInt64(selfActorId,recordData.actor_id)

widget:SetChildCSImageSprite(CmpRegisterItemIndex.bg,_jx_ab,FMT.fmt('image_wenxuan_xinxidiban_{0}',isSelf and 3 or 1))

widget:SetChildActive(CmpRegisterItemIndex.panel1,isRegister)
widget:SetChildActive(CmpRegisterItemIndex.panel2,not isRegister)
if isRegister then
playerController:setHeadIcon(widget,CmpRegisterItemIndex.head,{scale=1,iconInfo=iconInfo})
widget:SetChildText(CmpRegisterItemIndex.name,recordData.name)
widget:SetChildText(CmpRegisterItemIndex.serverName,serverName)
widget:SetChildText(CmpRegisterItemIndex.xmName,guild_name)
widget:SetChildText(CmpRegisterItemIndex.level,recordData.lv)
widget:SetChildText(CmpRegisterItemIndex.desc,chatEmotHelper.decodeEmot(descStr))

widget:SetChildActive(CmpRegisterItemIndex.desc,true)

local changeDescFunc=function()
if _this==nil or not isSelf then return end
UIManager:showWindow("UIXianGuanCampaignDescWin",{officerId=_this.curJobId,descIdx=recordData.declaration_idx})
end
widget:SetChildButtonClick(CmpRegisterItemIndex.changeDesc,changeDescFunc)
widget:SetChildActive(CmpRegisterItemIndex.changeDesc,isSelf)
else
local isVote=_this.status==XianGuanWenXuanSegment.eVote
playerController:setHeadIcon(widget,CmpRegisterItemIndex.head2,{scale=1,iconInfo=iconInfo})
widget:SetChildText(CmpRegisterItemIndex.name2,recordData.name)
widget:SetChildText(CmpRegisterItemIndex.serverName2,serverName)
widget:SetChildText(CmpRegisterItemIndex.xmName2,guild_name)
widget:SetChildText(CmpRegisterItemIndex.level2,recordData.lv)
widget:SetChildText(CmpRegisterItemIndex.rankText2,recordData.rank)

if recordData.rank<=3 then
local rankIcon=FMT.fmt('icon_phbmingci_{0}',recordData.rank)
widget:SetChildActive(CmpRegisterItemIndex.rankIcon2,true)
widget:SetChildCSImageSprite(CmpRegisterItemIndex.rankIcon2,globalABLookup.rankList,rankIcon)
else
widget:SetChildActive(CmpRegisterItemIndex.rankIcon2,false)
end

local supportStr=FMT.fmt('<color=#549327>{0}</color>/<color=#c82c2c>{1}</color>',recordData.agree_num,recordData.against_num)
widget:SetChildText(CmpRegisterItemIndex.supportNum2,supportStr)

widget:SetChildActive(CmpRegisterItemIndex.desc2,false)
widget:SetChildActive(CmpRegisterItemIndex.opposeBtn2,isVote)
widget:SetChildActive(CmpRegisterItemIndex.supportBtn2,isVote)

widget:SetChildActive(CmpRegisterItemIndex.endIcon,not isVote)
if not isVote then
local endIconname=recordData.rank==1 and"image_shengxuan"or"image_luoxuan"
widget:SetChildCSImageSprite(CmpRegisterItemIndex.endIcon,_jx_ab,endIconname)
end

local clickSupportFunc=function()
if _this==nil then return end
if not isVote then
UIManager.error("活动未开启")
return
end
self:showVoteTips(recordData.actor_id,1,recordData.name)
end
widget:SetChildButtonClick(CmpRegisterItemIndex.supportBtn2,clickSupportFunc)

local clickOpposeFunc=function()
if _this==nil then return end
if not isVote then
UIManager.error("活动未开启")
return
end
self:showVoteTips(recordData.actor_id,2,recordData.name)
end
widget:SetChildButtonClick(CmpRegisterItemIndex.opposeBtn2,clickOpposeFunc)
end
end

function UIXianGuanCampaignRegisterWin:showVoteTips(actorid,vote,name)
local wxData=xianguanModel:getWenXuanData()
local count
local itemCount=bagModel.getNotExpireItemCountById(self.config.item_vote_agree)
if vote==1 then
local use_vote_agree_num=wxData and wxData.use_vote_agree_num or 0
count=self.config.free_vote_agree-use_vote_agree_num
else
local use_vote_against_num=wxData and wxData.use_vote_against_num or 0
count=self.config.free_vote_against-use_vote_against_num
end
if itemCount<=0 and count<=0 then
UIManager.error("暂无选票")
return
end
local args={
parentWin=self,
actorId=actorid,
vote=vote,
job=_this.curJobId,
actorName=name,
}
self:showWindow("UIXianGuanWenXuanVoteTipsWin",args)
end

function UIXianGuanCampaignRegisterWin:onStartAction()

end

function UIXianGuanCampaignRegisterWin:freshMyRegisterItem()
if not self.meIndex then
return
end
local nowShowItemCount=self.loopListViewCmp.ShownItemCount

for i=0,nowShowItemCount-1 do
local item=self.loopListViewCmp:GetShownItemByIndex(i)
local index=item.ItemIndex
if index==self.meIndex-1 then
self:onFreshAction(self.meIndex,item.Widget)
break
end
end
end


function UIXianGuanCampaignRegisterWin:freshVoteRegisterItem(officerId,actorId)
self:refreshMoneyRoot()
if officerId~=self.curJobId then
return
end
local rank=self.dataListLookup[tostring(actorId)]
local nowShowItemCount=self.loopListViewCmp.ShownItemCount

for i=0,nowShowItemCount-1 do
local item=self.loopListViewCmp:GetShownItemByIndex(i)
local index=item.ItemIndex
if index==rank-1 then
local recordData=self.datalist[rank]
local supportStr=FMT.fmt('<color=#549327>{0}</color>/<color=#c82c2c>{1}</color>',recordData.agree_num,recordData.against_num)
item.Widget:SetChildText(CmpRegisterItemIndex.supportNum2,supportStr)
break
end
end


local isSelf=playerModel:checkActorId(actorId)
if isSelf then
self:refreshSelfRank()
end
end

function UIXianGuanCampaignRegisterWin:refreshReward()
local reward=xianguanController:getWenXuanReddot_Compatible()
self.rewardBtn:setActive(reward)
self.rewardReddot:setActive(reward)
end

function UIXianGuanCampaignRegisterWin:onItemListChanged(list)
if list==nil or self.status~=XianGuanWenXuanSegment.eVote then return end

for i,v in ipairs(list)do
local changeType=v[1]
local itemguid=v[2]
local itemid=v[3]

if itemid==self.config.item_vote_agree then
local itemCount=bagModel.getNotExpireItemCountById(self.config.item_vote_agree)
self:freshMoneyValue(3,itemCount)
break
end
end
end


function UIXianGuanCampaignRegisterWin:onSearchBtn()
local inputstr=self.searchInput:getInputFieldValue()

if inputstr==''or inputstr==nil then
if self.inputstr~=nil then

self:refreshList()
self:refreshSelfRank()
else
UIManager.info('请输入搜索内容')
end
return
end
if self.inputstr==inputstr then
if self.searchTipsStr~=nil then
UIManager.info(self.searchTipsStr)
end
return
end
if helper.check_spec_chars(inputstr)then
self.searchTipsStr='名称含敏感字符'
UIManager.info(self.searchTipsStr)
return
end
self.inputstr=inputstr
local list=self:getDataList()
if#list<=0 then

self.searchTipsStr='暂未搜索到该祖师'
UIManager.info(self.searchTipsStr)
return
end
self.searchTipsStr=nil
self.searchInput:setInputFieldValue('')
self:refreshList(nil,list)
end

function UIXianGuanCampaignRegisterWin:onSearchChange(str)

end

function UIXianGuanCampaignRegisterWin:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
end





function UIXianGuanCampaignRegisterWin:onBackButton()
local callback=self.callback
self:closeSelf()
if callback then
callback()
end
end



function UIXianGuanCampaignRegisterWin:onQiuYuanBtn()

local segment=xianguanController:getActivitySegment_WenXuan_Compatible()
if segment~=XianGuanWenXuanSegment.eVote then
return
end

local selfJob=xianguanModel:getWenXuanPlayerJob()
local selfActorId=playerModel:getActorID()
local args={
parentWin=self,
actorId=selfActorId,
job=selfJob,
isShare=true,
}
self:showWindow("UIXianGuanWenXuanShareInspireWin",args)
end



function UIXianGuanCampaignRegisterWin:onRewardBtn()

local segment=xianguanController:getActivitySegment_Campaign_Compatible(XianGuanCampaignType.eWenXuan)
if self.config.free_gift[segment]then
local free_flag=xianguanController:getJingXuanFreeReward(XianGuanCampaignType.eWenXuan)
if not mathHelper.getBitValue(free_flag,segment)then
xianguanController:req_send_40_3(segment)
end
end
end



function UIXianGuanCampaignRegisterWin:onMeRoot()
local selfJob=xianguanModel:getWenXuanPlayerJob()
if selfJob~=0 and self.eSelfJobIdx~=self.eJobIdx then
self:jumpJob(self.eSelfJobIdx)
end
end



function UIXianGuanCampaignRegisterWin:onRefreshBtn()
local flag,time=xianguanModel:getIsSendWenXuanRefresh()
if not flag then
UIManager.error(FMT.fmt("{0}秒后可再次刷新",time))
return
end

xianguanController:req_send_40_5(self.curJobId)
xianguanModel:setGetWenXuanRefreshTime()
end



function UIXianGuanCampaignRegisterWin:onHelpBtn()
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



function UIXianGuanCampaignRegisterWin:onCloseBtn()
local callback=self.callback
UIFullXJForceControl:closeWindow(self.__name)
if callback then
callback()
end
end
