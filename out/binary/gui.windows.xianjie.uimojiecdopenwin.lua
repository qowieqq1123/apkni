







def_class("UIMoJieCDOpenWin",UIWindowBase)









function UIMoJieCDOpenWin:bindComponents()

self.artImg_1=UIObject.get(self,0)
self.background=UIButton.get(self,1)
self.backgroundModel=UIObject.get(self,2)
self.bgmodel=UIObject.get(self,3)
self.cdTx=UIText.get(self,4)
self.cdTxEx=UIText.get(self,5)
self.closeBtn=UIButton.get(self,6)
self.content_1=UIObject.get(self,7)
self.content_2=UIObject.get(self,8)
self.content_3=UIObject.get(self,9)
self.content_4=UIObject.get(self,10)
self.desc_1=UIText.get(self,11)
self.gotoBtn=UIButton.get(self,12)
self.gotoBtnTxt=UIText.get(self,13)
self.moonModel=UIObject.get(self,14)
self.mzyhClaimedImage=UIObject.get(self,15)
self.mzyhClaimRewardBtn=UIButton.get(self,16)
self.mzyhContentTex=UIText.get(self,17)
self.mzyhRewardLayout=UIObject.get(self,18)
self.newBiebtn=UIButton.get(self,19)
self.newBiebtntxt=UIText.get(self,20)
self.playBtn=UIButton.get(self,21)
self.playBtn2=UIButton.get(self,22)
self.playBtnReddot_1=UIObject.get(self,23)
self.playBtnReddot_2=UIObject.get(self,24)
self.progressbar=UIObject.get(self,25)
self.progressValueTxt=UIText.get(self,26)
self.recvFlag=UIObject.get(self,27)
self.rewardIcon=UIButton.get(self,28)
self.rewardLayout=UIObject.get(self,29)
self.rewardReddot=UIObject.get(self,30)
self.ruleBtn=UIButton.get(self,31)
self.storyRewardLayout_1=UIObject.get(self,32)
self.storyRewardLayout_2=UIObject.get(self,33)
self.tabItem_1=UIObject.get(self,34)
self.tabItem_2=UIObject.get(self,35)
self.tabItem_3=UIObject.get(self,36)
self.tabItem_4=UIObject.get(self,37)
self.tabList=UIObject.get(self,38)
self.taskTip=UIText.get(self,39)
self.xyprogressbar=UIObject.get(self,40)
self.xyprogressValueTxt=UIText.get(self,41)
self.xytaskTip=UIText.get(self,42)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.mzyhClaimRewardBtn:setButtonClick(function()self:onMzyhClaimRewardBtn()end)

self.newBiebtn:setButtonClick(function()self:onNewBiebtn()end)

self.playBtn:setButtonClick(function()self:onPlayBtn()end)

self.playBtn2:setButtonClick(function()self:onPlayBtn2()end)

self.rewardIcon:setButtonClick(function()self:onRewardIcon()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)
self.artImg={
self.artImg_1,
}
self.content={
self.content_1,
self.content_2,
self.content_3,
self.content_4,
}
self.desc={
self.desc_1,
}
self.playBtnReddot={
self.playBtnReddot_1,
self.playBtnReddot_2,
}
self.storyRewardLayout={
self.storyRewardLayout_1,
self.storyRewardLayout_2,
}
self.tabItem={
self.tabItem_1,
self.tabItem_2,
self.tabItem_3,
self.tabItem_4,
}



end


function UIMoJieCDOpenWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.artImg_1);self.artImg_1=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.backgroundModel);self.backgroundModel=nil;
_UIObject_release(self.bgmodel);self.bgmodel=nil;
_UIObject_release(self.cdTx);self.cdTx=nil;
_UIObject_release(self.cdTxEx);self.cdTxEx=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.content_1);self.content_1=nil;
_UIObject_release(self.content_2);self.content_2=nil;
_UIObject_release(self.content_3);self.content_3=nil;
_UIObject_release(self.content_4);self.content_4=nil;
_UIObject_release(self.desc_1);self.desc_1=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.gotoBtnTxt);self.gotoBtnTxt=nil;
_UIObject_release(self.moonModel);self.moonModel=nil;
_UIObject_release(self.mzyhClaimedImage);self.mzyhClaimedImage=nil;
_UIObject_release(self.mzyhClaimRewardBtn);self.mzyhClaimRewardBtn=nil;
_UIObject_release(self.mzyhContentTex);self.mzyhContentTex=nil;
_UIObject_release(self.mzyhRewardLayout);self.mzyhRewardLayout=nil;
_UIObject_release(self.newBiebtn);self.newBiebtn=nil;
_UIObject_release(self.newBiebtntxt);self.newBiebtntxt=nil;
_UIObject_release(self.playBtn);self.playBtn=nil;
_UIObject_release(self.playBtn2);self.playBtn2=nil;
_UIObject_release(self.playBtnReddot_1);self.playBtnReddot_1=nil;
_UIObject_release(self.playBtnReddot_2);self.playBtnReddot_2=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.progressValueTxt);self.progressValueTxt=nil;
_UIObject_release(self.recvFlag);self.recvFlag=nil;
_UIObject_release(self.rewardIcon);self.rewardIcon=nil;
_UIObject_release(self.rewardLayout);self.rewardLayout=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.storyRewardLayout_1);self.storyRewardLayout_1=nil;
_UIObject_release(self.storyRewardLayout_2);self.storyRewardLayout_2=nil;
_UIObject_release(self.tabItem_1);self.tabItem_1=nil;
_UIObject_release(self.tabItem_2);self.tabItem_2=nil;
_UIObject_release(self.tabItem_3);self.tabItem_3=nil;
_UIObject_release(self.tabItem_4);self.tabItem_4=nil;
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.taskTip);self.taskTip=nil;
_UIObject_release(self.xyprogressbar);self.xyprogressbar=nil;
_UIObject_release(self.xyprogressValueTxt);self.xyprogressValueTxt=nil;
_UIObject_release(self.xytaskTip);self.xytaskTip=nil;
self.artImg=nil;
self.content=nil;
self.desc=nil;
self.playBtnReddot=nil;
self.storyRewardLayout=nil;
self.tabItem=nil;
end















local _this=nil
local tabCmpIndex={
bg=0,
select=1,
name=2,
reddot=3,
}

local ContentPage={
HDJZ=1,
TXYB=2,
BZZM=3,
MZYH=4,
}


local tabFunc={
[ContentPage.HDJZ]={
ReddotFunc=function()
return false
end,
refreshFunc=function(_self)
_self:refreshContent1()
end,
getCustonPanelConfig=function()
local _custom={}
_custom.modelId=6270
_custom.artImg={"ui/windows/xianjie/mojiepreview_atlas_pak.ab","image_mojiesaijiyugao_wz1"}
_custom.desc="为保护仙界，诸位祖师请远征魔界消灭魔君"

local enterData=xianjieModel:getMoJieEnterData()
if not enterData then
return _custom
end
local sId=enterData.sId
local cfg=cfg_mojieyugaoextbaseconfig_get(sId)
local custonPanelConfig=cfg.custonPanelConfig

if custonPanelConfig and custonPanelConfig[ContentPage.HDJZ]then
local custon=custonPanelConfig[ContentPage.HDJZ]
if custon.modelid then
_custom.modelId=custon.modelid
end
if custon.artImg then
_custom.artImg=custon.artImg
end
if custon.desc then
_custom.desc=custon.desc
end
end
return _custom
end,
},
[ContentPage.TXYB]={
ReddotFunc=function()
return MojiePreviewExtendController.checkReddot()
end,
refreshFunc=function(_self)
if not dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMJYG_TJYX)then
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMJYG_TJYX,true)
reddotControl.on_change_catch_type(CATCH_TYPE.eMJYGExtend)
end
_self:refreshContent2()
end,
getCustonPanelConfig=function()
local _custom={}
_custom.modelId=6300

local enterData=xianjieModel:getMoJieEnterData()
if not enterData then
return _custom
end
local sId=enterData.sId
local cfg=cfg_mojieyugaoextbaseconfig_get(sId)
local custonPanelConfig=cfg.custonPanelConfig

if custonPanelConfig and custonPanelConfig[ContentPage.TXYB]then
local custon=custonPanelConfig[ContentPage.TXYB]
if custon.modelid then
_custom.modelId=custon.modelid
end
end
return _custom
end,
},
[ContentPage.BZZM]={
ReddotFunc=function()
return MojiePreviewExtendController.checkAllBZZhengMoReddot()
end,
refreshFunc=function(_self)
_self:refreshContent3()
end,
nameExFunc=function()

local enterData=xianjieModel:getMoJieEnterData()
if not enterData then
return false
end
local sId=enterData.sId
local cfg=cfg_mojieyugaoextbaseconfig_get(sId)
local bzzmItems=cfg.bzzmItems
local flag=MojiePreviewExtendModel:getData_bzzmRwFlag()
for k,v in pairs(bzzmItems)do
if k>flag then
return false
end
end
return true
end,
getCustonPanelConfig=function()
local _custom={}
_custom.modelId=6301

local enterData=xianjieModel:getMoJieEnterData()
if not enterData then
return _custom
end
local sId=enterData.sId
local cfg=cfg_mojieyugaoextbaseconfig_get(sId)
local custonPanelConfig=cfg.custonPanelConfig

if custonPanelConfig and custonPanelConfig[ContentPage.BZZM]then
local custon=custonPanelConfig[ContentPage.BZZM]
if custon.modelid then
_custom.modelId=custon.modelid
end
end
return _custom
end,
},
[ContentPage.MZYH]={
ReddotFunc=function()
return MojiePreviewExtendController.checkMzyhRewardReddot()
end,
refreshFunc=function(self)
self:refreshContent4()
end,
nameExFunc=function()

end,
getCustonPanelConfig=function()
local _custom={}
_custom.modelId=6301

local enterData=xianjieModel:getMoJieEnterData()
if not enterData then
return _custom
end
local sId=enterData.sId
local cfg=cfg_mojieyugaoextbaseconfig_get(sId)
local custonPanelConfig=cfg.custonPanelConfig

if custonPanelConfig and custonPanelConfig[ContentPage.MZYH]then
local custon=custonPanelConfig[ContentPage.MZYH]
if custon.modelid then
_custom.modelId=custon.modelid
end
end
return _custom
end,
},
}



function UIMoJieCDOpenWin:onLoaded(...)
self:bindComponents()
if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgmodel:getID(),true,true,true)
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.moonModel:getID(),true,true,true)
end
self.tabItemWidget={}
for i,v in ipairs(self.tabItem)do
self.tabItemWidget[i]=v:getWidgetBase()
self.tabItemWidget[i]:SetChildButtonClick(tabCmpIndex.bg,function()
self:clickTab(i)
end)
end
_this=self
end


function UIMoJieCDOpenWin:__delete()
self:unbindComponents()
_this=nil
end




function UIMoJieCDOpenWin:onShow(argtable,afterOnloaded)
local enterData=xianjieModel:getMoJieEnterData()
local nowTime=timeHelper.getServerShortTime()
self.newBieFlag=argtable and argtable.newBieFlag
self.tabIndex=argtable and argtable.tabIndex or self.tabIndex


if enterData then
local sId=enterData.sId
self.baseCfg=cfg_mojieyugaoextbaseconfig_get(sId)
if not self.tabIndex then
if MojiePreviewExtendController.checkTabShow(ContentPage.TXYB)then
for i,tabCfg in ipairs(self.baseCfg.tabCfgList)do
if tabCfg.contentIndex==ContentPage.TXYB then
self.tabIndex=i
break
end
end
else
self.tabIndex=1
end
end

self.cdTime=enterData.sTime

local stratDayZeroTime=timeHelper.getServerZeroShortStamp(self.cdTime)
local leastTime=self.cdTime-nowTime

if stratDayZeroTime>nowTime then
self.cdTx:setText(FMT.fmt("魔界开启倒计时：<color=#c82c2c>{0}</color>",timeHelper.format_time_stamp4(leastTime)))
self:startCDTick()
self:previewIng()
else
self:previewEnd()
end
else
self:onCloseBtn()
end

end


function UIMoJieCDOpenWin:onHide()

end


function UIMoJieCDOpenWin:previewIng()
self.newBiebtn:setActive(false)
self.tabList:setActive(true)
local tabCfgList=self.baseCfg.tabCfgList
local ygDays=self.baseCfg.ygDays
local nowTime=timeHelper.getServerShortTime()
for i,v in ipairs(self.tabItemWidget)do

local tabCfg=tabCfgList[i]
if tabCfg then

local contentIndex=tabCfg.contentIndex










v:SetChildActive(-1,true)
v:SetChildText(tabCmpIndex.name,tabCfg.name)
if tabCfg.nameEx and tabFunc[contentIndex].nameExFunc and tabFunc[contentIndex].nameExFunc()then
v:SetChildText(tabCmpIndex.name,tabCfg.nameEx)
end
local isShow,tabName,tips=MojiePreviewExtendController.checkTabShow(contentIndex,true)
if not isShow and(tabName==nil or tabName=="")then
v:SetChildActive(-1,false)
else
v:SetChildGray(tabCmpIndex.bg,not isShow)
if not isShow then
v:SetChildText(tabCmpIndex.name,tabName)
end
end

else

v:SetChildActive(-1,false)
end
end
self:refreshTabSelect()
if self.tabIndex then
local tabCfgList=self.baseCfg.tabCfgList
local tabCfg=tabCfgList[self.tabIndex]
local contentIndex=tabCfg.contentIndex
for i,v in ipairs(self.content)do
v:setActive(i==contentIndex)
v:setChildCanvasGroupAlpha(0)
end
local subTabFunc=tabFunc[contentIndex]
subTabFunc.refreshFunc(self)
end
self:refreshTabReddot()
end


















function UIMoJieCDOpenWin:refreshTabSelect()
for i,v in ipairs(self.tabItemWidget)do
v:SetChildActive(tabCmpIndex.select,self.tabIndex==i)
end
end

function UIMoJieCDOpenWin:refreshTabReddot()
for i,v in ipairs(self.tabItemWidget)do
local tabCfgList=self.baseCfg.tabCfgList
local tabCfg=tabCfgList[i]
if tabCfg then
local contentIndex=tabCfg.contentIndex
v:SetChildActive(tabCmpIndex.reddot,tabFunc[contentIndex].ReddotFunc())
end
end
end

function UIMoJieCDOpenWin:refreshContent1()
self.moonModel:setActive(true)
self.bgmodel:setActive(true)
self.moonModel:setChildUIModelShowTarget(6271,1,nil,eAnimationID.enter)
local subTabFunc=self:getSubTabFunc()
local custom=subTabFunc.getCustonPanelConfig()

self.artImg_1:setCSImageSprite(custom.artImg[1],custom.artImg[2])
self.desc_1:setText(custom.desc)
self.bgmodel:setChildUIModelShowTarget(custom.modelId,1,nil,eAnimationID.enter)
self.content_1:setChildCanvasGroupDOFade(1,2)
end

function UIMoJieCDOpenWin:refreshContent2()
self.moonModel:setActive(false)
self.bgmodel:setActive(true)

local subTabFunc=self:getSubTabFunc()
local custom=subTabFunc.getCustonPanelConfig()

self.bgmodel:setChildUIModelShowTarget(custom.modelId,1,nil,eAnimationID.enter)

local myTaskId=MojiePreviewExtendModel:getData_taskId()
local mytaskCfg=cfg_mojieyugaogerentaskconfig_get(myTaskId)
if not mytaskCfg then
logErr("魔界预告拓展没有任务配置 id-->>",myTaskId)
return
end

local taskdesc=mytaskCfg.taskdesc
local targetScore=mytaskCfg.score
local taskDescStr=FMT.fmt(taskdesc,targetScore)
local myTaskReddot=MojiePreviewExtendController.checkMyTaskReddot()
local flag=MojiePreviewExtendModel:getData_myReward()==1
if myTaskReddot then
taskDescStr="点击领取奖励"
elseif flag then
taskDescStr="已领取奖励"
end
self.taskTip:setText(taskDescStr)
local curScore=MojiePreviewExtendModel:getData_myScore()
self.progressbar:setChildUIProgressbar(curScore,targetScore,false)
self.progressValueTxt:setText(FMT.fmt("{0}/{1}",mathHelper.formatNumber(curScore),mathHelper.formatNumber(targetScore)))
self.rewardReddot:setActive(false)
if myTaskReddot then
self.winlua:SetChildDOTweenAnimation_DOPlay(self.rewardIcon:getID())
else
self.winlua:SetChildDOTweenAnimation_DOPause(self.rewardIcon:getID())
end


local xytaskdesc=self.baseCfg.xytaskdesc
local xianyuTask=self.baseCfg.xianyuTask
local xyTargetScore=xianyuTask[1]
local itemList=xianyuTask[2]
local xytaskDescStr=FMT.fmt(xytaskdesc,xyTargetScore)
self.xytaskTip:setText(xytaskDescStr)
local curXyScore=MojiePreviewExtendModel:getData_xianyuScore()
local xyRFlag=MojiePreviewExtendModel:getData_xianyuReward()==1
self.xyprogressbar:setChildUIProgressbar(curXyScore,xyTargetScore,false)
self.xyprogressValueTxt:setText(FMT.fmt("{0}/{1}",mathHelper.formatNumber(curXyScore),mathHelper.formatNumber(xyTargetScore)))

if xyRFlag then
self.gotoBtn:setActive(false)
self.recvFlag:setActive(true)
else
self.recvFlag:setActive(false)
self.gotoBtn:setActive(true)
local xyTaskReddot=MojiePreviewExtendController.checkXyTaskReddot()
if xyTaskReddot then
self.gotoBtnTxt:setText("领取")
else
self.gotoBtnTxt:setText("前往获取")
end
end

self.rewardLayout:setChildLayoutGroupCreateItems(#itemList,function(index)
local item=self.rewardLayout:getChildLayoutGroupGridItem(index-1)
local rewardData=itemList[index]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""


local fillData=itemsComponentHelper.getCommonFillData({itemid=itemId},{showname=false,itemcount=countStr,showCountBG=showCountBG,showStageBg=true})
if itemsConfig.isMoney(itemId)then
fillData[PropIndex(DataPropKey.eWidgetActive,9)]=false
end
item:SetChildPropData(-1,fillData)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)






end)
self.content_2:setChildCanvasGroupDOFade(1,2)
end

function UIMoJieCDOpenWin:refreshContent3()
self.moonModel:setActive(true)
self.bgmodel:setActive(true)

local subTabFunc=self:getSubTabFunc()
local custom=subTabFunc.getCustonPanelConfig()

self.moonModel:setChildUIModelShowTarget(6271,1,nil,eAnimationID.enter)
self.bgmodel:setChildUIModelShowTarget(custom.modelId,1,nil,eAnimationID.enter)







local chapterMaxId=MojiePreviewExtendModel:getData_chapterMaxId()
local fisrtLookFlag=chapterMaxId>=1
local secondLookFlag=chapterMaxId>=2
local bzzmItems=self.baseCfg.bzzmItems
for id,v in ipairs(self.storyRewardLayout)do
local itemList=bzzmItems[id]
if itemList then
v:setChildLayoutGroupCreateItems(#itemList,function(index)
local item=v:getChildLayoutGroupGridItem(index-1)
local rewardData=itemList[index]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""


local fillData=itemsComponentHelper.getCommonFillData({itemid=itemId},{showname=false,itemcount=countStr,showCountBG=showCountBG,showStageBg=true})
if itemsConfig.isMoney(itemId)then
fillData[PropIndex(DataPropKey.eWidgetActive,9)]=false
end
local canRecv=MojiePreviewExtendController.checkBZZhengMoReddot(id)
local recvFlag=id<=MojiePreviewExtendModel:getData_bzzmRwFlag()
fillData[PropIndex(DataPropKey.eWidgetActive,10)]=recvFlag
fillData[PropIndex(DataPropKey.eWidgetActive,1)]=canRecv
item:SetChildPropData(-1,fillData)
local reddotObj=self.playBtnReddot[id]
if recvFlag then
reddotObj:setActive(false)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
else
if canRecv then

reddotObj:setActive(false)
item:SetBaseItemClickEvent(-1,function()
MojiePreviewExtendController.req_39_28(id)
end)
else


if id==1 then
reddotObj:setActive(MojiePreviewExtendController.checkBZZhengMoCanLook(id))
else
reddotObj:setActive(MojiePreviewExtendController.checkBZZhengMoCanLook(id)and fisrtLookFlag)
end

item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end
end







end)
end
self.content_3:setChildCanvasGroupDOFade(1,2)
end
self.playBtn:setGray(not MojiePreviewExtendController.checkBZZhengMoCanLook(1))
self.playBtn2:setGray(not MojiePreviewExtendController.checkBZZhengMoCanLook(2)or not fisrtLookFlag)

if not fisrtLookFlag then
local enterData=xianjieModel:getMoJieEnterData()
local sId=enterData.sId
local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eMJYGPlay,{})
local playFlagListEx=localCfg.playFlagListEx or{}
local sList=playFlagListEx[tostring(sId)]or{}
if sList[tostring(1)]==true then
MojiePreviewExtendController.req_39_34(1)
end
end

if not secondLookFlag then
local enterData=xianjieModel:getMoJieEnterData()
local sId=enterData.sId
local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eMJYGPlay,{})
local playFlagListEx=localCfg.playFlagListEx or{}
local sList=playFlagListEx[tostring(sId)]or{}
if sList[tostring(2)]==true then
MojiePreviewExtendController.req_39_34(2)
end
end
end

function UIMoJieCDOpenWin:refreshContent4()
self.moonModel:setActive(false)
self.bgmodel:setActive(false)
self.content_4:setChildCanvasGroupDOFade(1,1)

local enterData=xianjieModel:getMoJieEnterData()
local sId=enterData.sId
local mzyhItemList=self.baseCfg.mzyhItems
local contentText=self.baseCfg.mzyhContentTex
local mzyhItemId=mzyhItemList[1][1]or-1
local itemName=mzyhItemId~=-1 and itemsConfig.getItemName(mzyhItemId)or""


local moJieCfg=cfgHelper.get1(cfg_devildomseasonconfig_get,sId)
local seasonName=moJieCfg.name or""


self.mzyhContentTex:setText(FMT.fmt(contentText,itemName,seasonName,FONT_COLOR_VAL[FONT_COLOR.eOrangeColor]))


self.mzyhRewardLayout:setChildLayoutGroupCreateItems(#mzyhItemList,function(index)
local item=self.mzyhRewardLayout:getChildLayoutGroupGridItem(index-1)
local rewardInfo=mzyhItemList[index]
local itemId=rewardInfo[1]
local itemCount=rewardInfo[2]
local showCountBg=itemCount>1

local countStr=showCountBg and mathHelper.formatNumber(itemCount)or""
local fillData=itemsComponentHelper.getCommonFillData({itemid=itemId},{
showname=false,
itemcount=countStr,
showCountBG=showCountBg,
showStageBg=true})

if itemsConfig.isMoney(itemId)then
fillData[PropIndex(DataPropKey.eWidgetActive,9)]=false
end
item:SetChildPropData(-1,fillData)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
self:updateMzyhRewardClaimState()
end

function UIMoJieCDOpenWin:clickTab(index)
if self.tabIndex==index then
return
end
local tabCfgList=self.baseCfg.tabCfgList
local tabCfg=tabCfgList[index]
local contentIndex=tabCfg.contentIndex
local isShow,tabName,tips=MojiePreviewExtendController.checkTabShow(contentIndex,true)
if not isShow then
UIManager.info(tips)
return
end
for i,v in ipairs(self.content)do
v:setActive(i==contentIndex)
v:setChildCanvasGroupAlpha(0)
end
self.tabIndex=index
self:refreshTabSelect()
local subTabFunc=tabFunc[contentIndex]
subTabFunc.refreshFunc(self)
self:refreshTabReddot()
end


function UIMoJieCDOpenWin:previewEnd()
self.tabList:setActive(false)
self:stopCDTick()
self.cdTx:setText("")
self.content_1:setActive(false)
self.content_2:setActive(false)
self.content_3:setActive(false)
self.content_4:setActive(false)

local nowTime=timeHelper.getServerShortTime()

local isRealStart=nowTime>=self.cdTime

if not isRealStart then
self.cdTxEx:setActive(true)
self:updateCDTickEx()
self:startCDTickEx()
self.newBiebtn:setActive(true)
self.newBiebtntxt:setText("战意凌霄")
self.newBiebtn:setGray(true)
self.moonModel:setActive(false)
self.moonModel:setChildUIModelShowTarget(6271,1,nil,eAnimationID.enter)
self.bgmodel:setChildUIModelShowTarget(6302,1,nil,eAnimationID.enter)
return
end

self:stopCDTickEx()
self.cdTxEx:setText("")

if MojiePreviewExtendController.checkPoKaiMoJieFlag()then
self.newBiebtn:setActive(false)
return
end
self.newBiebtn:setActive(true)
self.newBiebtn:setGray(false)
local fixNewBieId=self.baseCfg.fixNewBie
local weekNewBieId=self.baseCfg.weekNewBie
local fixNewBieFinish=true
if fixNewBieId then
fixNewBieFinish=newbieModel.isFinish(fixNewBieId)
end




local btnTxt=fixNewBieFinish and"破开魔界"or"战意凌霄"
if self.baseCfg.custonPanelConfig and self.baseCfg.custonPanelConfig.btnTxtOption then
btnTxt=fixNewBieFinish and self.baseCfg.custonPanelConfig.btnTxtOption[1]or self.baseCfg.custonPanelConfig.btnTxtOption[2]
end
self.newBiebtntxt:setText(btnTxt)
if fixNewBieFinish then
self.moonModel:setActive(false)
self.bgmodel:setChildUIModelShowTarget(6303,1,nil,eAnimationID.enter)

weakGuideController:beginGuide(weekNewBieId,nil,false)
else
self.moonModel:setActive(false)
self.moonModel:setChildUIModelShowTarget(6271,1,nil,eAnimationID.enter)
self.bgmodel:setChildUIModelShowTarget(6302,1,nil,eAnimationID.enter)
local cfg=newbieModel.getLookupConfig(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_BRANCH_LUA_FUNC_NAME.mj_zhanyilingxiaoLuaFunc)

newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_BRANCH_LUA_FUNC_NAME.mj_zhanyilingxiaoLuaFunc)
end
end




function UIMoJieCDOpenWin:onBackground()
self:onCloseBtn()
end


function UIMoJieCDOpenWin:onCloseBtn()
self:closeSelf()
end

function UIMoJieCDOpenWin:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UIMoJieCDOpenWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIMoJieCDOpenWin:startCDTickEx()
if not self.cdTickEx then
self.cdTickEx=self:setTimer(1,0,function()
self:updateCDTickEx()
end)
end
end

function UIMoJieCDOpenWin:stopCDTickEx()
if self.cdTickEx then
self:stopTimerByID(self.cdTickEx)
self.cdTickEx=nil
end
end

function UIMoJieCDOpenWin:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
local leastTime=self.cdTime-nowTime
self.cdTx:setText(FMT.fmt("魔界开启倒计时：<color=#c82c2c>{0}</color>",timeHelper.format_time_stamp4(leastTime)))

local stratDayZeroTime=timeHelper.getServerZeroShortStamp(self.cdTime)
if stratDayZeroTime<=nowTime then

self:previewEnd()
end
end

function UIMoJieCDOpenWin:updateCDTickEx()
local nowTime=timeHelper.getServerShortTime()
local leastTime=self.cdTime-nowTime
self.cdTxEx:setText(FMT.fmt("魔界开启倒计时：<color=#c82c2c>{0}</color>",timeHelper.format_time_stamp4(leastTime)))
if leastTime<=0 then

self:previewEnd()
end
end

function UIMoJieCDOpenWin:onRewardIcon()
local flag=MojiePreviewExtendModel:getData_myReward()==1
if flag then
UIManager.info("奖励已领取")
return
end

if not MojiePreviewExtendController.checkMyTaskReddot()then
local myTaskId=MojiePreviewExtendModel:getData_taskId()
local mytaskCfg=cfg_mojieyugaogerentaskconfig_get(myTaskId)
local taskdesc=mytaskCfg.taskdesc
local targetScore=mytaskCfg.score
local taskDescStr=FMT.fmt(taskdesc,targetScore)
local targetDesc=FMT.fmt("{0}可获得以下奖励",taskDescStr)
local rewardList=mytaskCfg.items

local showdata=
{
type='UIDialougeWithIcon',
title='个人奖励',


closetip=true,
okcallback=function(...)

end,
isshowrewards=true,
repaneltxt=targetDesc,
rewardList=rewardList,
showclosebtn=true,
repanelTips="个人积分会在每日0点刷新重置"
}
self:showWindow('UIDialougeMJPHBBtips',showdata)
return
end
MojiePreviewExtendController.req_39_25(1)
end

function UIMoJieCDOpenWin:onGotoBtn()
if MojiePreviewExtendController.checkXyTaskReddot()then
MojiePreviewExtendController.req_39_25(2)
return
end
local jumpCfg=self.baseCfg.jumpCfg
if not jumpCfg then
return
end
if#jumpCfg==1 then
local info=jumpCfg[1]
local jump=info.jump
self:onCloseBtn()
gainControl:handleJump(jump)
return
end
local args={
title='积分获取',
tips="可通过以下途径获取积分，达到目标",
gainWayList=jumpCfg,
closeCallBack=function()
if not self or self.isClose then
return
end
self:onCloseBtn()
end
}
self:showWindow("UICommonGainWayWin",args)
end

function UIMoJieCDOpenWin:onRuleBtn()
local d={}
d.title='说明'
d.mode=3
d.name='ui_mojjiecdopen_help_%d'
self:showWindow('UIRuleScrollViewWin',d)
end

function UIMoJieCDOpenWin:onNewBiebtn()
local nowTime=timeHelper.getServerShortTime()

if nowTime<self.cdTime then
UIManager.info("魔界还未开启")
return
end

local fixNewBieId=self.baseCfg.fixNewBie
local fixNewBieFinish=true
if fixNewBieId then
fixNewBieFinish=newbieModel.isFinish(fixNewBieId)
end
if fixNewBieFinish then
if not seasonController:checkSeasonHandleComplete(0)then
local show_data=
{
title='提示',
_okText="确定",
_cancelText="取消",
tipsText="需要完成重建仙域才可破开魔界，\n是否前往？",
closetopbtn=true,
cellcallback=function()
UIFullSeasonControl:openSeasonWindow(0)
end,
}
self:showWindow('UIDialougeNormalTip',show_data)
return
end
if seasonController:checkSeasonHandleCompleteButNotOver(0)then

local show_data=
{
title='提示',
_okText="确定",
_cancelText="取消",
tipsText="需要领取完重建仙域奖励才可破开魔界，\n是否前往领取？",
closetopbtn=true,
cellcallback=function()
UIFullSeasonControl:openSeasonWindow(0)
end,
}
self:showWindow('UIDialougeNormalTip',show_data)
return
end

local sData=MojiePreviewExtendModel:getSeverData()or{}
local enterData=xianjieModel:getMoJieEnterData()
if enterData and not table.containsValue(sData,enterData.sId)then
table.insert(sData,enterData.sId)
MojiePreviewExtendModel:setSeverData(sData)
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.MoJieYuGao,#sData,sData)
notifySystem:postNotify(notifyConfig.onSeasonChange)
end

local storyBehaviorName=self.baseCfg.enterMjstory
self:onCloseBtn()
storyAICommonManager:startStoryBehavior(storyBehaviorName)
else


local storyBehaviorName=self.baseCfg.zylxstory
self:onCloseBtn()
storyAICommonManager:startStoryBehavior(storyBehaviorName)
end
end

function UIMoJieCDOpenWin:onPlayBtn()
local iscan,leftDay=MojiePreviewExtendController.checkBZZhengMoCanLook(1)
if not iscan then
local str=leftDay==1 and"此章剧情明日解锁"or FMT.fmt("此章剧情{0}天后解锁",leftDay)
UIManager.info(str)
return
end
local bzzmstory=self.baseCfg.bzzmstory
local func=function()

storyAICommonManager:startStoryBehavior(bzzmstory[1])













local chapterMaxId=MojiePreviewExtendModel:getData_chapterMaxId()
local fisrtLookFlag=chapterMaxId>=1
if fisrtLookFlag then
return
end
MojiePreviewExtendController.req_39_34(1)

local enterData=xianjieModel:getMoJieEnterData()
local sId=enterData.sId
local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eMJYGPlay,{})
local playFlagListEx=localCfg.playFlagListEx or{}
local sList=playFlagListEx[tostring(sId)]or{}
if sList[tostring(1)]then
return
end
sList[tostring(1)]=true
playFlagListEx[tostring(sId)]=sList
localCfg.playFlagListEx=playFlagListEx
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eMJYGPlay,localCfg)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eMJYGPlay)
end
self:onCloseBtn()
if xianjieModel:checkSceneIndex(xianjienSceneIndexType.eXianJie)then
func()
else
xianjieController:jumpXianJie(xianjienSceneType.eXianJie,nil,func)
end
end


function UIMoJieCDOpenWin:onPlayBtn2()
local iscan,leftDay=MojiePreviewExtendController.checkBZZhengMoCanLook(2)
if not iscan then
local str=leftDay==1 and"此章剧情明日解锁"or FMT.fmt("此章剧情{0}天后解锁",leftDay)
UIManager.info(str)
return
end










local chapterMaxId=MojiePreviewExtendModel:getData_chapterMaxId()
local fisrtLookFlag=chapterMaxId>=1
if not fisrtLookFlag then
UIManager.info("请先观看第一章")
return
end

local bzzmstory=self.baseCfg.bzzmstory
local func=function()
storyAICommonManager:startStoryBehavior(bzzmstory[2])













local chapterMaxId=MojiePreviewExtendModel:getData_chapterMaxId()
local lookFlag=chapterMaxId>=2
if lookFlag then
return
end
MojiePreviewExtendController.req_39_34(2)

local enterData=xianjieModel:getMoJieEnterData()
local sId=enterData.sId
local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eMJYGPlay,{})
local playFlagListEx=localCfg.playFlagListEx or{}
local sList=playFlagListEx[tostring(sId)]or{}
if sList[tostring(2)]then
return
end
sList[tostring(2)]=true
playFlagListEx[tostring(sId)]=sList
localCfg.playFlagListEx=playFlagListEx
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eMJYGPlay,localCfg)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eMJYGPlay)
end
self:onCloseBtn()
if xianjieModel:checkSceneIndex(xianjienSceneIndexType.eXianJie)then
func()
else
xianjieController:jumpXianJie(xianjienSceneType.eXianJie,nil,func)
end

end

function UIMoJieCDOpenWin:onMzyhClaimRewardBtn()
MojiePreviewExtendController.req_39_40()
end


function UIMoJieCDOpenWin:updateMzyhRewardClaimState()
local data=MojiePreviewExtendModel:getData()
local rwFlag=data.mzyhReward

if rwFlag==nil then
self.mzyhClaimRewardBtn:setActive(false)
self.mzyhClaimedImage:setActive(true)
return
end


self.mzyhClaimRewardBtn:setActive(rwFlag==0)
self.mzyhClaimedImage:setActive(rwFlag==1)
self:refreshTabReddot()
end

function UIMoJieCDOpenWin:getSubTabFunc()
local tabCfgList=self.baseCfg.tabCfgList
local tabCfg=tabCfgList[self.tabIndex]
local contentIndex=tabCfg.contentIndex
local subTabFunc=tabFunc[contentIndex]
return subTabFunc
end
