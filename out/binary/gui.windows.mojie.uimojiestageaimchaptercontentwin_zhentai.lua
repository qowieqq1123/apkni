







def_class("UIMoJieStageAimChapterContentWin_ZhenTai",UIWindowBase)









function UIMoJieStageAimChapterContentWin_ZhenTai:bindComponents()

self.background=UIImage.get(self,0)
self.finishImg=UIObject.get(self,1)
self.jumpBtn=UIButton.get(self,2)
self.mainTask=UIObject.get(self,3)
self.mainTaskTxt=UIText.get(self,4)
self.progressBox=UIObject.get(self,5)
self.spRuleBtn=UIButton.get(self,6)
self.stagePassLevelRewardList=UIObject.get(self,7)
self.storyBg=UIObject.get(self,8)
self.storyTx=UIText.get(self,9)
self.storyTx2=UIText.get(self,10)
self.tipsExBg=UIObject.get(self,11)
self.tipsExTxt=UIText.get(self,12)
self.tipsTx=UIText.get(self,13)
self.zhenTaiList=UIObject.get(self,14)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.spRuleBtn:setButtonClick(function()self:onSpRuleBtn()end)



end


function UIMoJieStageAimChapterContentWin_ZhenTai:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.finishImg);self.finishImg=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.mainTask);self.mainTask=nil;
_UIObject_release(self.mainTaskTxt);self.mainTaskTxt=nil;
_UIObject_release(self.progressBox);self.progressBox=nil;
_UIObject_release(self.spRuleBtn);self.spRuleBtn=nil;
_UIObject_release(self.stagePassLevelRewardList);self.stagePassLevelRewardList=nil;
_UIObject_release(self.storyBg);self.storyBg=nil;
_UIObject_release(self.storyTx);self.storyTx=nil;
_UIObject_release(self.storyTx2);self.storyTx2=nil;
_UIObject_release(self.tipsExBg);self.tipsExBg=nil;
_UIObject_release(self.tipsExTxt);self.tipsExTxt=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
_UIObject_release(self.zhenTaiList);self.zhenTaiList=nil;
end


















local _this
local _abName="ui/windows/mojiezhentai/mojiezhentai_atlas_pak.ab"

function UIMoJieStageAimChapterContentWin_ZhenTai:onLoaded(...)
self:bindComponents()

_this=self

self:addProNotify(39,2,self.on_39_2)
self:addProNotify(39,3,self.on_39_3)
self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
self:addNotify(notifyConfig.onSeasonStageDataChange,self.onSeasonStageDataChange)
end


function UIMoJieStageAimChapterContentWin_ZhenTai:__delete()
_this=nil

self:stopOpenTimer()
self:stopPreFinishTimer()

self:unbindComponents()
end




function UIMoJieStageAimChapterContentWin_ZhenTai:onShow(argtable,afterOnloaded)
self.showParams=argtable
self.handleType=self.showParams.handleType
self.stageIdx=self.showParams.stageIdx
self.stageHandle=seasonModel:getStage(self.showParams.handleType,self.showParams.stageIdx)
self.stageCfg=seasonModel:getStageConfigEx(self.showParams.handleType,self.showParams.stageIdx)
self.winArgs=self.stageCfg.winArgs

self:refreshAll()
end

function UIMoJieStageAimChapterContentWin_ZhenTai:onJumpBtn()
if not self.stageHandle:isOverBegin()then
local beginTime=self.stageHandle.beginTime
local stageName=self.stageCfg.name
local serverTime=timeHelper.getServerShortTime()
local left=beginTime-serverTime
UIManager.info(FMT.fmt("{0}章节将于{1}后开启",stageName,timeHelper.format_time_stamp4(left)))
return
end

local jumpParams=self.winArgs.jumpBtn.jump
if jumpParams==nil then return end
jumpManager:jump(jumpParams)
end

function UIMoJieStageAimChapterContentWin_ZhenTai:onSpRuleBtn()
if self.spRuleFmt==nil then return end

local d={}
d.mode=3
d.title="说明"
d.name=self.spRuleFmt
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UIMoJieStageAimChapterContentWin_ZhenTai:refreshAll()
self:initActiveData()

self:freshBackGround()
self:freshProgressBox()
self:freshJumpBtn()
self:freshTips()
self:freshMainTask()
self:freshFinishImg()
self:refreshStagePassLevelRewardPart()
self:refreshZhenTaiList()

self:activeObjects()
end


function UIMoJieStageAimChapterContentWin_ZhenTai:initActiveData()

self.isShowProgressBox=false
self.isShowMidTips=true
self.isShowProgressInfo=false
self.isShowFightCD=false
self.isShowSpRuleBtn=false


self.isShowBg=self.winArgs.backgroundImage~=nil
self.isShowJumpBtn=self.winArgs.jumpBtn~=nil
self.isShowMaintask=self.stageCfg.passLevelCondition~=nil


self.isShowFinishImg=self.stageHandle:isFinish()
end

function UIMoJieStageAimChapterContentWin_ZhenTai:activeObjects()
self.background:setActive(self.isShowBg)
self.progressBox:setActive(self.isShowProgressBox)
self.jumpBtn:setActive(self.isShowJumpBtn)
self.tipsTx:setActive(self.isShowMidTips)
self.mainTask:setActive(self.isShowMaintask)
self.finishImg:setActive(self.isShowFinishImg)
self.spRuleBtn:setActive(self.isShowSpRuleBtn)
end

function UIMoJieStageAimChapterContentWin_ZhenTai:freshBackGround()
if not self.isShowBg then return end

local imageCfg=self.winArgs.backgroundImage
self.background:setSprite(imageCfg[1],imageCfg[2])
end
function UIMoJieStageAimChapterContentWin_ZhenTai:freshProgressBox()
if not self.isShowProgressBox then return end

local wb=self.progressBox:getChildWidgetBase()

local tips=FMT.fmt("{0}：{1}",self.winArgs.stageScoreRewardTips,self.stageHandle.chapter_scroe)
wb:SetChildText(0,tips)


local stageScoreRewardList=self.stageCfg.stageScoreRewardList
local rewardBoxInfo=self.winArgs.boxParam
local rewardBoxLen=#rewardBoxInfo

local len=#stageScoreRewardList
local pval=seasonModel:getStageSegementProgressVal(self.showParams.handleType,self.showParams.stageIdx,self.stageHandle.chapter_scroe)
wb:SetChildProgressValue(1,pval*100,100)
wb:SetChildProgressText(1,"")

local score=self.stageHandle.chapter_scroe
local receive=self.stageHandle.stage_rw_idx

wb:SetChildLayoutGroupCreateItems(2,len,function(index)
local item=wb:GetChildLayoutGroupGridItem(2,index-1)
local data=stageScoreRewardList[index]

local rewardBoxInfo=rewardBoxInfo[index]or rewardBoxInfo[rewardBoxLen]
item:SetChildCSImageSprite(0,rewardBoxInfo[1],rewardBoxInfo[2])
item:SetChildScale(0,Vector3(rewardBoxInfo[3],rewardBoxInfo[3],rewardBoxInfo[3]))
item:SetChildText(1,data[1])

local isCanRecv=score>=data[1]
local isReceived=receive>=index

item:SetChildGray(0,isReceived)
item:SetChildActive(2,isCanRecv and(not isReceived))
item:SetChildActive(3,isReceived)

item:SetChildButtonClick(0,function()
if isCanRecv and(not isReceived)then
local reqType=2
seasonController:send_39_2(_this.showParams.handleType,_this.showParams.stageIdx,reqType)
else
_this:onClickBox(index)
end
end,true)
end)

end

function UIMoJieStageAimChapterContentWin_ZhenTai:onClickBox(index)
local config=seasonModel:getStageConfigEx(self.handleType,self.stageIdx)
local score_reward=config.stageScoreRewardList[index]
local getted=self.stage and self.stage.stage_rw_idx>=index or false
local num=score_reward[1]

local itemlist={}
for i,v in ipairs(score_reward[2])do
table.insert(itemlist,{itemid=v[1],itemcount=v[2]})
end
local tipStr=config.winArgs.rewardTips
tipStr=FMT.fmt(tipStr,num)
local show_data={
type='UIDialougeBuyWithReward2',
title='提示',
oktext=not getted and'确定'or nil,
itemlist=itemlist,
tip=tipStr,
showclosebtn=true,
bgClick=true,
gotFlag=getted,
canvasindex=9,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

function UIMoJieStageAimChapterContentWin_ZhenTai:freshJumpBtn()
self.isShowJumpBtn=not self.stageHandle:isFinish()

local isGray=not self.stageHandle:isOverBegin()
self.jumpBtn:setGray(isGray)
end

local _attachmentArgsTips=function(args)
local type=args[1]
local tips=args[2]
if type==0 then return tips end

if type==1 then
return FMT.fmt(tips,_this.stageHandle.chapter_scroe)
end
end
function UIMoJieStageAimChapterContentWin_ZhenTai:freshTips()
self.tipsTx:setText("")
local stageState=self.stageHandle:getState()

local tipStr
if stageState==eSeasonStageStateEnum.eUnLock then
self:startOpenTimer()




elseif stageState==eSeasonStageStateEnum.ePreFinish then
self.isShowSpRuleBtn=self.stageCfg.autoFinishRule~=nil
self.spRuleFmt=self.stageCfg.autoFinishRule
self:startPreFinishTimer()
end

if tipStr then
self.tipsTx:setText(tipStr)
end
end

function UIMoJieStageAimChapterContentWin_ZhenTai:startOpenTimer()
self:stopOpenTimer()

local curTime=timeHelper.getServerShortTime()
local beginTime=self.stageHandle.beginTime

local strFmt=self.winArgs.openPreStr

local func=function()
curTime=timeHelper.getServerShortTime()
local left=beginTime-curTime
local timeStr=timeHelper.format_time_stamp4(left)
local infoStr=FMT.fmt(strFmt,timeStr)
_this.tipsTx:setText(infoStr)

if left<0 then
_this:stopOpenTimer()
_this:refreshAll()
end
end

self.openTimer=self:setTimer(1,0,func)
func()
end

function UIMoJieStageAimChapterContentWin_ZhenTai:stopOpenTimer()
if self.openTimer then
self:stopTimerByID(self.openTimer)
self.openTimer=nil
end
end

function UIMoJieStageAimChapterContentWin_ZhenTai:startPreFinishTimer()
self:stopPreFinishTimer()

local curTime=timeHelper.getServerShortTime()
local endTime=self.stageHandle.endTime

local strFmt=self.stageCfg.autoFinishTimerDesc

local func=function()
curTime=timeHelper.getServerShortTime()
local left=endTime-curTime
local timeStr=timeHelper.format_time_stamp4(left)
timeStr=toColorStringX("#FFC551",timeStr)
local infoStr=FMT.fmt(strFmt,timeStr)
_this.tipsTx:setText(infoStr)

if left<0 then
_this:stopPreFinishTimer()
_this:refreshAll()
end
end

self.preFinishTimer=self:setTimer(1,0,func)
func()
end

function UIMoJieStageAimChapterContentWin_ZhenTai:stopPreFinishTimer()
if self.preFinishTimer then
self:stopTimerByID(self.preFinishTimer)
self.preFinishTimer=nil
end
end

function UIMoJieStageAimChapterContentWin_ZhenTai:freshMainTask()
local passLevelCondition=self.stageCfg.passLevelCondition
local limitVal=Mathf.Min(self.stageHandle.chapter_scroe,passLevelCondition.max)
local str=FMT.fmt("{0}  {1}/{2}",passLevelCondition.desc,limitVal,passLevelCondition.max)

self.mainTaskTxt:setText(str)
end

function UIMoJieStageAimChapterContentWin_ZhenTai:freshFinishImg()
end

function UIMoJieStageAimChapterContentWin_ZhenTai:refreshStagePassLevelRewardPart()
local passStageReward=self.stageCfg.passStageReward
if not passStageReward then return end

local len=#passStageReward

local isFinish=self.stageHandle:isFinish()
local isReceived=self.stageHandle.pass_rw_flag==1
local isCanRecv=isFinish and(not isReceived)

local createFunc=function(index)
if _this==nil then return end

local item=_this.stagePassLevelRewardList:getChildLayoutGroupGridItem(index-1)
local data=passStageReward[index]

local itemid=data[1]
local itemnum=data[2]
local showCountBG=itemnum>1
local itemcount=showCountBG and itemnum or""
local graynum=isReceived and 1 or 0

local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false,gray=graynum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)

item:SetChildActive(1,isCanRecv)
item:SetChildActive(2,isReceived)

item:SetBaseItemClickEvent(0,function()
if isCanRecv then
local reqType=1
seasonController:send_39_2(self.showParams.handleType,self.showParams.stageIdx,reqType)
else
itemsComponentHelper.onItemClick(itemid)
end
end)
end

self.stagePassLevelRewardList:setChildLayoutGroupCreateItems(len,createFunc)
end

function UIMoJieStageAimChapterContentWin_ZhenTai:refreshZhenTaiList()
local client_build_list=self.stageCfg.client_build_list
if not client_build_list then return end
local fix_conf=self.stageCfg.fix_conf
local build_icon_list=self.stageCfg.build_icon_list
local frame_icon_list=self.stageCfg.frame_icon_list
local len=#client_build_list

local createFunc=function(index)
if _this==nil then return end
local item=_this.zhenTaiList:getChildLayoutGroupGridItem(index-1)
local build_id=index
local client_build_id=client_build_list[index]

local name=cfgHelper.get2(cfg_fairylandclientbuildconfig_get,client_build_id,'name')
local data=xianjieModel:getZhenTaiEntity(self.handleType,self.stageIdx,build_id)or defaultT
local finish_cnt=data.finish_cnt or 0
local max_finish_cnt=fix_conf[index]
local percent=finish_cnt/max_finish_cnt
local iconName=build_icon_list[index]
local frameIconName=frame_icon_list[index]
local showPercent=math.max(math.floor(percent*100*10)/10,finish_cnt>0 and 0.1 or 0)

item:SetChildText(0,name)
item:SetChildCSImageSprite(1,_abName,iconName)
item:SetChildCSImageSprite(7,_abName,frameIconName)
item:SetChildActive(2,finish_cnt<max_finish_cnt)
item:SetChildIconFillAmount(3,percent)
item:SetChildText(4,string.format("修复度：%s%%",showPercent))
item:SetChildActive(5,finish_cnt>=max_finish_cnt)

item:SetChildButtonClick(6,function()
local func=function()
xianjieController:jumpMoJieZhenTai(self.handleType,self.stageIdx,build_id,true)
UIFullSeasonControl:closeUI(true,true)
end
local content=string.format("是否前往【%s】",name)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=func,
}
local dialog=UIDialogManager.newDialog(showdata)
dialog:show()
end)
end
self.zhenTaiList:setChildLayoutGroupCreateItems(len,createFunc)
end

function UIMoJieStageAimChapterContentWin_ZhenTai.on_39_2(season_id,chapter_idx,param1,param2)
if season_id==_this.handleType and chapter_idx==_this.stageIdx and _this.stage then

end
end

function UIMoJieStageAimChapterContentWin_ZhenTai.on_39_3(season_id,chapter_idx)
if season_id==_this.handleType and chapter_idx==_this.stageIdx and _this.stage then

end
end

function UIMoJieStageAimChapterContentWin_ZhenTai.onSeasonChange()
_this.stageHandle=seasonModel:getStage(_this.handleType,_this.stageIdx)
_this:refreshAll()

end

function UIMoJieStageAimChapterContentWin_ZhenTai.onSeasonStageChange(season_id,chapter_idx)
if _this.handleType==season_id and chapter_idx==_this.stageIdx then
_this.stageHandle=seasonModel:getStage(_this.handleType,_this.stageIdx)
_this:refreshAll()
end
end

function UIMoJieStageAimChapterContentWin_ZhenTai.onSeasonStageDataChange(season_id,chapter_idx)
if _this.handleType==season_id and chapter_idx==_this.stageIdx then
_this.stageHandle=seasonModel:getStage(_this.handleType,_this.stageIdx)
_this:refreshAll()
end
end


