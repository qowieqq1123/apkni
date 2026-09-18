







def_class("UIXianZhanSellWin",UIWindowBase)









function UIXianZhanSellWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.bottomBgModel=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.extraRewardGridGroup=UIObject.get(self,3)
self.extraRewardPanel=UIObject.get(self,4)
self.extraTimeText=UIText.get(self,5)
self.helpBtn=UIButton.get(self,6)
self.huoCangBtn=UIButton.get(self,7)
self.leftButton=UIButton.get(self,8)
self.mask=UIButton.get(self,9)
self.needItemGridGroup=UIObject.get(self,10)
self.nextBtnRoot=UIObject.get(self,11)
self.notExtraRewardTips=UIObject.get(self,12)
self.npcModel=UIObject.get(self,13)
self.npcPanel=UIObject.get(self,14)
self.rightButton=UIButton.get(self,15)
self.selectRewardGridGroup=UIObject.get(self,16)
self.speakObj=UIObject.get(self,17)
self.speakText=UIText.get(self,18)
self.submitBtn=UIButton.get(self,19)
self.timeText=UIText.get(self,20)
self.title=UIText.get(self,21)
self.zhuKeBtn=UIButton.get(self,22)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.huoCangBtn:setButtonClick(function()self:onHuoCangBtn()end)

self.leftButton:setButtonClick(function()self:onLeftButton()end)

self.mask:setButtonClick(function()self:onMask()end)

self.rightButton:setButtonClick(function()self:onRightButton()end)

self.submitBtn:setButtonClick(function()self:onSubmitBtn()end)

self.zhuKeBtn:setButtonClick(function()self:onZhuKeBtn()end)



end


function UIXianZhanSellWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.bottomBgModel);self.bottomBgModel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.extraRewardGridGroup);self.extraRewardGridGroup=nil;
_UIObject_release(self.extraRewardPanel);self.extraRewardPanel=nil;
_UIObject_release(self.extraTimeText);self.extraTimeText=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.huoCangBtn);self.huoCangBtn=nil;
_UIObject_release(self.leftButton);self.leftButton=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.needItemGridGroup);self.needItemGridGroup=nil;
_UIObject_release(self.nextBtnRoot);self.nextBtnRoot=nil;
_UIObject_release(self.notExtraRewardTips);self.notExtraRewardTips=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.npcPanel);self.npcPanel=nil;
_UIObject_release(self.rightButton);self.rightButton=nil;
_UIObject_release(self.selectRewardGridGroup);self.selectRewardGridGroup=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.submitBtn);self.submitBtn=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.zhuKeBtn);self.zhuKeBtn=nil;
end
















local selectRewardItemCmpIndex={
rewardName=0,
rewardItem=1,
rewardCount=2,
notSelectIcon=3,
selectIcon=4,
selectBg=5,
clickArea=6,
bg=7,
}
local _this



function UIXianZhanSellWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXianZhanSellWin:__delete()
_this=nil
self:unbindComponents()
self:clearLeaveAndExtraTimer()
self:clearSpeakTimer()
end




function UIXianZhanSellWin:onShow(argtable,afterOnloaded)
self.npcId=argtable and argtable.npcId
self.index=argtable and argtable.index

if self.npcId then

self.keShangData=xianzhanModel:getKeShangData(self.npcId)
end

if not self.keShangData then

return self:onCloseBtn()
end


if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bottomBgModel:getID(),5297,1,{},eAnimationID.stand)
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5298,1,{},eAnimationID.stand)
end

local baseCfg=cfgHelper.get(cfg_xianzhankeshangbaseconfig_get,1)
self.npcTalkTime=baseCfg.npcSpeakTime
self.npcTalkShowTime=baseCfg.npcSpeakShowTime

self.selectRewardIndex=nil

self:initKsList()

self:refresh()
end


function UIXianZhanSellWin:onHide()
self:clearLeaveAndExtraTimer()
self:clearSpeakTimer()
end

function UIXianZhanSellWin:initKsList()
self.sortKsList={}

local ksList=xianzhanModel:getKeShangList()or{}
self.sortKsList=self:sortKeShangListByRzTime(ksList)

if not self.index then
for k,v in ipairs(self.sortKsList)do
if v.npcid==self.npcId then
self.index=k
break
end
end
end
end

function UIXianZhanSellWin:refreshNextBtn()
local len=#self.sortKsList

self.leftButton:setActive(self.index>1)
self.rightButton:setActive(self.index<len)
self.nextBtnRoot:setActive(len>1)
end

function UIXianZhanSellWin:onLeftButton()
local index=self.index-1
local npcId=self.sortKsList[index]and self.sortKsList[index].npcid

if index and npcId then
UIManager:showWindow("UIXianZhanSellWin",{npcId=npcId,index=index})
end
end

function UIXianZhanSellWin:onRightButton()
local index=self.index+1
local npcId=self.sortKsList[index]and self.sortKsList[index].npcid

if index and npcId then
UIManager:showWindow("UIXianZhanSellWin",{npcId=npcId,index=index})
end
end

function UIXianZhanSellWin:refresh()
local ksCfg=cfgHelper.get(cfg_xianzhankeshangconfig_get,self.npcId)

if not ksCfg then
logErr(FMT.fmt("找不到npcId为{0} 所对应的客商配置 请检查配置与数据是否正确",self.npcId))
return
end

local orderNeedList=ksCfg.sgddList or{}
self.needItemGridGroup:setChildLayoutGroupCreateItems(#orderNeedList)
local grids=self.needItemGridGroup:getChildLayoutGroupGridList()
for i=1,grids.Count do
local item=grids[i-1]
item:SetChildActive(-1,true)
local itemParam=orderNeedList[i]
local itemId=itemParam[1]
local itemNum=itemParam[2]
local hasItemNum=itemsModel.getCount(itemId)
local countStr=FMT.fmt("{0}/{1}",mathHelper.formatNumber(hasItemNum),mathHelper.formatNumber(itemNum))
if hasItemNum>=itemNum then
countStr=FMT.cfmt(FONT_COLOR.eGreenTxtColor,countStr)
end
local conf={itemid=itemId,itemcount=countStr,showCountBG=true,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
local itemName=itemsModel.getName(itemId)
item:SetChildText(2,itemName)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(true,...)
end)
end


self:refreshRewardSelectPanel()


local npcImgId=ksCfg.npcShowId
local modelParams=npcModel:getImageInfo(npcImgId)
comHelper.setChildInSideModelEx(self.npcModel,modelParams,1,0,0,0,false,true)


local extraDropId=ksCfg.rwList2
if extraDropId then
local level=zongmenModel:getLevel()
local awardCfg=itemsAwardConfig:getAwardInConfigByLevel(extraDropId,level)
local extraRewardList=awardCfg.showItems and table.weakCopy(awardCfg.showItems)or{}


local getXyItem=ksCfg.xyVal
if getXyItem then
table.insert(extraRewardList,getXyItem)
end

self.extraRewardGridGroup:setChildLayoutGroupCreateItems(#extraRewardList)
local extraRewardGrids=self.extraRewardGridGroup:getChildLayoutGroupGridList()
for i=1,extraRewardGrids.Count do
local item=extraRewardGrids[i-1]
item:SetChildActive(-1,true)
local itemParam=extraRewardList[i]
local itemId=itemParam[1]
local itemNum=itemParam[2]
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(false,...)
end)
end
end


self:refreshLeaveAndExtraTimeShow()


self:setLeaveAndExtraTimer()


self:delayDo(0.3,function()
self:doSpeaking()
end)

self:refreshNextBtn()
end

function UIXianZhanSellWin:refreshRewardSelectPanel()
local ksCfg=cfgHelper.get(cfg_xianzhankeshangconfig_get,self.npcId)
local selectRewardGrids=self.selectRewardGridGroup:getChildCommonLayoutGroupWidgetList()
for i=1,selectRewardGrids.Count do
local widget=selectRewardGrids[i-1]

local rewardItem=ksCfg.rwList[i]
local itemId=rewardItem[1]
local itemNum=rewardItem[2]
local conf={itemid=itemId,itemcount="",showCountBG=false,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
local itemWidget=widget:GetChildWidgetBase(selectRewardItemCmpIndex.rewardItem)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(false,...)
end)


local itemName=itemsModel.getName(itemId)
widget:SetChildText(selectRewardItemCmpIndex.rewardName,itemName)


local countStr=mathHelper.formatNumber(itemNum)
widget:SetChildText(selectRewardItemCmpIndex.rewardCount,countStr)


local isSelect=i==self.selectRewardIndex
widget:SetChildActive(selectRewardItemCmpIndex.bg,not isSelect)
widget:SetChildActive(selectRewardItemCmpIndex.selectBg,isSelect)
widget:SetChildActive(selectRewardItemCmpIndex.notSelectIcon,not isSelect)
widget:SetChildActive(selectRewardItemCmpIndex.selectIcon,isSelect)


widget:SetChildButtonClick(selectRewardItemCmpIndex.clickArea,function()
if not _this then return end
return _this:selectReward(i)
end)
end
end

function UIXianZhanSellWin:selectReward(rewardIndex)
if rewardIndex==self.selectRewardIndex then
return
end

self.selectRewardIndex=rewardIndex
self:refreshRewardSelectPanel()
end

function UIXianZhanSellWin:refreshLeaveAndExtraTimeShow()
local ksCfg=cfgHelper.get(cfg_xianzhankeshangconfig_get,self.npcId)
local rzTime=self.keShangData.rzTime
local leaveTime=rzTime+ksCfg.ksTime
local extraRewardEndTime=rzTime+ksCfg.tqTime
local nowTime=timeHelper.getServerShortTime()
local lerp=leaveTime-nowTime
if lerp<=0 then

UIManager.error("客商已离开")
return self:onCloseBtn()
end
local timeStr=timeHelper.format_time_stamp11(lerp)
self.timeText:setText(FMT.fmt("滞留时间：<color=#aae252>{0}</color>",timeStr))

local extraDropId=ksCfg.rwList2
local hasExtraCfg=extraDropId~=nil
local hasExtra=nowTime<extraRewardEndTime
self.extraRewardPanel:setActive(hasExtra and hasExtraCfg)
self.notExtraRewardTips:setActive(not hasExtra and hasExtraCfg)
if hasExtra and hasExtraCfg then
local extraLerp=extraRewardEndTime-nowTime
local extraTimeStr=timeHelper.format_time_stamp11(extraLerp)
self.extraTimeText:setText(FMT.fmt("在<color=#aae252>{0}</color>前完成订单可额外获得：",extraTimeStr))
end
end

function UIXianZhanSellWin:setLeaveAndExtraTimer()
self:clearLeaveAndExtraTimer()
self.timer=self:setTimer(1,0,function()
if not _this then return end
return _this:refreshLeaveAndExtraTimeShow()
end)
end

function UIXianZhanSellWin:clearLeaveAndExtraTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end



function UIXianZhanSellWin:doSpeaking()
self:clearSpeakTimer()

local ksCfg=cfgHelper.get(cfg_xianzhankeshangconfig_get,self.npcId)
local speakLibCfg=ksCfg.npcSpeakLib_notFinish
local speakLib=table.weakCopy(speakLibCfg)
local selectIndex
if#speakLib>1 then
if self.lastSpeakIndex and speakLib[self.lastSpeakIndex]then
table.remove(speakLib,self.lastSpeakIndex1)
end
if#speakLib>1 then
selectIndex=math.random(1,#speakLib)
else
selectIndex=1
end
self.lastSpeakIndex=selectIndex
else
selectIndex=1
end

local speakStr=speakLib[selectIndex]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self:doTalkAnim()
end


function UIXianZhanSellWin:doTalkAnim()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
self.speakObj:setScale(Vector3.zero)
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
return _this:talkEnd()
end)
end)
end


function UIXianZhanSellWin:talkEnd()
self:clearSpeakTimer()
self.speakShowTimer=self:delayDo(self.npcTalkShowTime,function()

self.speakObj:setScale(Vector3.zero)

self.speakTimer=self:delayDo(self.npcTalkTime,function()
return self:doSpeaking()
end)
end)
end



function UIXianZhanSellWin:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end




function UIXianZhanSellWin:onCloseBtn()
self:closeSelf()
end



function UIXianZhanSellWin:onHuoCangBtn()
self:showWindow("UIShopHuoCangWin")
end



function UIXianZhanSellWin:onZhuKeBtn()

local npcId=self.npcId
local show_data={
type='UIDialouge',
title='提示',
content='是否请离当前客商？',
oktext='是',
canceltext='否',
okcallback=function()

xianzhanController:req_kickout_keshang(npcId)

if _this==nil then return end

return _this:onCloseBtn()
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end



function UIXianZhanSellWin:onSubmitBtn()
if not self.selectRewardIndex then
return UIManager.error("请选择一项奖励")
end


local ksCfg=cfgHelper.get(cfg_xianzhankeshangconfig_get,self.npcId)
local orderNeedList=ksCfg.sgddList or{}
for i=1,#orderNeedList do
local itemParam=orderNeedList[i]
local itemId=itemParam[1]
local needNum=itemParam[2]
local num=itemsModel.getCount(itemId)
if num<needNum then
local itemName=itemsModel.getName(itemId)
UIManager.error(FMT.fmt('{0}不足',itemName))
gainControl:showGainWin(itemId)
return
end
end

local npcId=self.npcId
local rwIndex=self.selectRewardIndex
xianzhanController:req_finish_keshang_order(npcId,rwIndex)


self:onCloseBtn()
end



function UIXianZhanSellWin:onHelpBtn()
local baseCfg=cfgHelper.get(cfg_xianzhankeshangbaseconfig_get,1)
local langId=baseCfg.ruleLangId or''
local d={}
d.title='规则'
d.mode=3
d.name=langId
self:showWindow('UIRuleWin',d)
end

function UIXianZhanSellWin:onMask()
return self:onCloseBtn()
end


function UIXianZhanSellWin:onClickRewardItem(isShowGetWay,itemId,index,guid,attach)
if itemId==-1 then
return
end

local formType=isShowGetWay and TIPS_FORM_TYPE.eWatchItem or nil


tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight,formType=formType,
showModel=true,})
end

function UIXianZhanSellWin:sortKeShangListByRzTime(list)
local sortList={}
for i,v in pairs(list)do
local npcId=v.npcid
local npcCfg=cfgHelper.get(cfg_xianzhankeshangconfig_get,npcId)
local rzTime=v.rzTime
local leaveTime=rzTime+npcCfg.ksTime
local data={
npcid=v.npcid,
rzTime=v.rzTime,
leaveTime=leaveTime,
}
sortList[#sortList+1]=data
end

table.sort(sortList,function(a,b)
if a.rzTime==b.rzTime then
return a.npcid<b.npcid
else
return a.rzTime<b.rzTime
end
end)

return sortList
end
