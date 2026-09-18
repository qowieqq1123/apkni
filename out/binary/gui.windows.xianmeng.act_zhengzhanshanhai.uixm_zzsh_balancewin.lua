







def_class("UIXM_ZZSH_balanceWin",UIWindowBase)









function UIXM_ZZSH_balanceWin:bindComponents()

self.notLog=UIObject.get(self,0)
self.blessedScrollView=UIObject.get(self,1)
self.blessedLandPanel=UIObject.get(self,2)
self.blessedLandBtn=UIButton.get(self,3)
self.blessedLandBtnSelect=UIObject.get(self,4)
self.plunderScrollView=UIObject.get(self,5)
self.plunderLandPanel=UIObject.get(self,6)
self.plunderBtn=UIButton.get(self,7)
self.plunderBtnSelect=UIObject.get(self,8)
self.rewardRoot=UIObject.get(self,9)
self.rewardBtn=UIButton.get(self,10)
self.rewardBtnSelect=UIObject.get(self,11)
self.momentumRoot=UIObject.get(self,12)
self.momentumBtn=UIButton.get(self,13)
self.momentumBtnSelect=UIObject.get(self,14)
self.memberRewardScrollView=UIObject.get(self,15)
self.guildRewardScrollView=UIObject.get(self,16)
self.xmqsCount=UIText.get(self,17)
self.xzCount=UIText.get(self,18)
self.qsCount=UIText.get(self,19)
self.momentumChartBtn=UIButton.get(self,20)
self.closeBtn=UIButton.get(self,21)
self.winTimes=UIText.get(self,22)
self.titleDesc=UIText.get(self,23)
self.addtionText=UIText.get(self,24)

self.blessedLandBtn:setButtonClick(function()self:onBlessedLandBtn()end)

self.plunderBtn:setButtonClick(function()self:onPlunderBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.momentumBtn:setButtonClick(function()self:onMomentumBtn()end)

self.momentumChartBtn:setButtonClick(function()self:onMomentumChartBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXM_ZZSH_balanceWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.notLog);self.notLog=nil;
_UIObject_release(self.blessedScrollView);self.blessedScrollView=nil;
_UIObject_release(self.blessedLandPanel);self.blessedLandPanel=nil;
_UIObject_release(self.blessedLandBtn);self.blessedLandBtn=nil;
_UIObject_release(self.blessedLandBtnSelect);self.blessedLandBtnSelect=nil;
_UIObject_release(self.plunderScrollView);self.plunderScrollView=nil;
_UIObject_release(self.plunderLandPanel);self.plunderLandPanel=nil;
_UIObject_release(self.plunderBtn);self.plunderBtn=nil;
_UIObject_release(self.plunderBtnSelect);self.plunderBtnSelect=nil;
_UIObject_release(self.rewardRoot);self.rewardRoot=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardBtnSelect);self.rewardBtnSelect=nil;
_UIObject_release(self.momentumRoot);self.momentumRoot=nil;
_UIObject_release(self.momentumBtn);self.momentumBtn=nil;
_UIObject_release(self.momentumBtnSelect);self.momentumBtnSelect=nil;
_UIObject_release(self.memberRewardScrollView);self.memberRewardScrollView=nil;
_UIObject_release(self.guildRewardScrollView);self.guildRewardScrollView=nil;
_UIObject_release(self.xmqsCount);self.xmqsCount=nil;
_UIObject_release(self.xzCount);self.xzCount=nil;
_UIObject_release(self.qsCount);self.qsCount=nil;
_UIObject_release(self.momentumChartBtn);self.momentumChartBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.winTimes);self.winTimes=nil;
_UIObject_release(self.titleDesc);self.titleDesc=nil;
_UIObject_release(self.addtionText);self.addtionText=nil;
end
















local this
local balanceType=
{
blessedLand=1,
plunderLand=2,
}
local reportType=
{
reward=1,
momentum=2,
}

local blessedItemIndex=
{
oldName=0,
newName=1,
blessedName=2,
oldNameSelect=3,
newNameSelect=4,
arrow=5,
oldNameBack=6,
newNameBack=7,
}

local plunderItemIndex=
{
plunderAttackName=0,
plunderDefendkName=1,
plunderResultName=2,
plunderMySelfImg=3,
}

local memberItemIndex=
{
itemBase=0,
}

local guildItemIndex=
{
icon=0,
count=1,
}




function UIXM_ZZSH_balanceWin:onLoaded(...)
self:bindComponents()

this=self
end


function UIXM_ZZSH_balanceWin:__delete()
self:unbindComponents()
this=nil
end




function UIXM_ZZSH_balanceWin:onShow(argtable,afterOnloaded)
self.data=zhengzhanshanhaiModel:getBalanceData()
if not self.data then zhengzhanshanhaiController:reqBalanceData()return end

local myLdData=zhengzhanshanhaiModel:getMyLDData()
if myLdData then
self.manorId=myLdData.domainid
end


self.config=zhengzhanshanhaiController:getZZSHCfg_domain()

self.selectIndex=balanceType.blessedLand
self.reportIndex=reportType.reward


self:refreshScrollviewData()

self:refreshReportPage()
self:refreshReportPageData()
end

function UIXM_ZZSH_balanceWin:getRewardCfg(index)
local guild=self.config[index].guild
local member=self.config[index].member

return guild,member
end

function UIXM_ZZSH_balanceWin:refreshReportPage()
local flag=self.selectIndex==reportType.reward
self.rewardRoot:setActive(flag)
self.rewardBtnSelect:setActive(flag)

self.momentumRoot:setActive(not flag)
self.momentumBtnSelect:setActive(not flag)
end

function UIXM_ZZSH_balanceWin:refreshReportPageData()
self:refreshRewardPage()
self:refreshMomentumPage()

local str

if self.manorId then
local config=self.config[self.manorId]
if config then



str=string.format("您所在的仙盟占领了%s",config.name)

end
else
str="您的仙盟没有占领领地"
end
self.titleDesc:setText(str)
end

function UIXM_ZZSH_balanceWin:refreshRewardPage()
local guild
local member
local count1
local count2

local safeType=zhengzhanshanhaiModel:checkJoinFightFlag()
local cfg=zhengzhanshanhaiController:getZZSHCfg()

if self.manorId then
guild=self.config[self.manorId].guild
member=self.config[self.manorId].member
count1=#guild
count2=#member
elseif not safeType then
guild=cfg.safe[1]
member=cfg.safe[2]
count1=#guild
count2=#member
else
guild=cfg.comfort[1]
member=cfg.comfort[2]
count1=#guild
count2=#member
end

if count1>0 then
self.guildRewardScrollView:setChildScrollViewCreateGrids(count1,2)
local grids=self.guildRewardScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local reward=guild[i]
local widget=grids[i-1]

widget:SetChildIcon(guildItemIndex.icon,iconHelper.getIconName(reward[1]),false)
widget:SetChildText(guildItemIndex.count,reward[2])
widget:SetChildButtonClick(guildItemIndex.icon,function()
self:onClickRewardItem(reward[1])
end)
end
else
self.guildRewardScrollView:setActive(false)
end

if count2>0 then
self.memberRewardScrollView:setChildScrollViewCreateGrids(count2,count2)
local grids=self.memberRewardScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local reward=member[i]
local widget=grids[i-1]

local countStr=''
local itemid=reward[1]
local itemcount=reward[2]
local showCountBG=false
local colorEffect=false

if itemcount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemcount)
end

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=colorEffect}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(memberItemIndex.itemBase,prop)
widget:SetBaseItemClickEvent(memberItemIndex.itemBase,function(...)
self:onClickRewardItem(...)
end)
end
else
self.memberRewardScrollView:setActive(false)
end
end

function UIXM_ZZSH_balanceWin:refreshMomentumPage()
local wintimes=self.data.winTimes
local winmomentun=self.data.winmomentum
local rankmomentum=self.data.rankmomentum
local addWinmomentun=winmomentun
local allAddWinmomentun=addWinmomentun+rankmomentum
local allWinmomentun=zhengzhanshanhaiModel:getMomentNum()
local oldWinmomentun=allAddWinmomentun

local winTimesText=string.format(' %s',wintimes)
local qsText=string.format(' + %s',rankmomentum)
local xmqsText=string.format(' %s',oldWinmomentun)
local xzText=string.format(' + %s',addWinmomentun)
local addText=string.format(' + %s',allAddWinmomentun)

self.xzCount:setText(xzText)
self.qsCount:setText(qsText)

self.addtionText:setText(addText)
self.winTimes:setText(winTimesText)
end

function UIXM_ZZSH_balanceWin:refreshScrollviewActive()
local flag=self.selectIndex==balanceType.blessedLand

self.blessedLandBtnSelect:setActive(flag)
self.blessedLandPanel:setActive(flag)

self.plunderBtnSelect:setActive(not flag)
self.plunderLandPanel:setActive(not flag)
end

function UIXM_ZZSH_balanceWin:refreshScrollviewData()
this:refreshBlessedScrollviewData()

end

function UIXM_ZZSH_balanceWin:refreshBlessedScrollviewData()
local count=#self.config
local manorLenList=self.data.manorLenList

if count>0 then
self.blessedScrollView:setChildScrollViewCreateGrids(count,1)
local grids=self.blessedScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local oldName
local newName
local blessedName
local widget=grids[i-1]
local data=manorLenList[i]
local ldData=zhengzhanshanhaiModel:getLDData(i)

if data.param_2 then
local oldXmData=zhengzhanshanhaiModel:getXMData(data.param_2)
local newXmData=zhengzhanshanhaiModel:getXMData(ldData.guildid)
if oldXmData then oldName=oldXmData.guildname end
if newXmData then newName=newXmData.guildname end

blessedName=zhengzhanshanhaiModel:getLingDiCfg(data.param_1).name

widget:SetChildActive(blessedItemIndex.arrow,true)
widget:SetChildActive(blessedItemIndex.newNameBack,true)
widget:SetChildActive(blessedItemIndex.oldNameSelect,xianmengModel:isMyXM(data.param_2))
widget:SetChildActive(blessedItemIndex.newNameSelect,xianmengModel:isMyXM(ldData.guildid))

if not oldName then oldName="中立"end
if not newName then newName="中立"end
else
local isMyXm
if ldData then
isMyXm=xianmengModel:isMyXM(ldData.guildid)
local ldOldData=zhengzhanshanhaiModel:getXMData(ldData.guildid)
if ldOldData then
newName=""
oldName=ldOldData.guildname
if oldName==""then oldName="中立"end
else
oldName="中立"
end
else
oldName="中立"
isMyXm=false
end
blessedName=zhengzhanshanhaiModel:getLingDiCfg(i).name

widget:SetChildActive(blessedItemIndex.arrow,false)
widget:SetChildActive(blessedItemIndex.newNameBack,false)
widget:SetChildActive(blessedItemIndex.oldNameSelect,isMyXm)
end

widget:SetChildText(blessedItemIndex.oldName,oldName)
widget:SetChildText(blessedItemIndex.newName,newName)
widget:SetChildText(blessedItemIndex.blessedName,blessedName)
end
end
end

function UIXM_ZZSH_balanceWin:refreshPalunderScrollviewData()
local count=self.data.plunderLen
local plunderLenList=self.data.plunderLenList

if count>0 then
self.plunderScrollView:setChildScrollViewCreateGrids(count,1)
local grids=self.plunderScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local attackName
local defendName
local widget=grids[i-1]
local data=plunderLenList[i]

local defendXMData=zhengzhanshanhaiModel:getXMData(data.param_3)
if defendXMData then
defendName=defendXMData.guildname
end
if not defendName then defendName="中立"end

local attackXMData=zhengzhanshanhaiModel:getXMData(data.param_2)
if attackXMData then
attackName=attackXMData.guildname
end
if not attackName then attackName="已解散仙盟"end

local abname="ui/sharedtextures/uiglobalspriteatlas_1.ab"
local iconName=string.format("image_pqjsshengbai_%s",data.param_1)

widget:SetChildCSImageSprite(plunderItemIndex.plunderResultName,abname,iconName)
widget:SetChildText(plunderItemIndex.plunderAttackName,attackName)
widget:SetChildText(plunderItemIndex.plunderDefendkName,defendName)
widget:SetChildActive(plunderItemIndex.plunderMySelfImg,data.param_2==self.manorId)
end
end
end


function UIXM_ZZSH_balanceWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid})
end


function UIXM_ZZSH_balanceWin:onHide()

end




function UIXM_ZZSH_balanceWin:onBlessedLandBtn()
self.selectIndex=balanceType.blessedLand
self:refreshScrollviewActive()
end


function UIXM_ZZSH_balanceWin:onPlunderBtn()
self.selectIndex=balanceType.plunderLand
self:refreshScrollviewActive()
end


function UIXM_ZZSH_balanceWin:onRewardBtn()
self.selectIndex=reportType.reward
self:refreshReportPage()
end


function UIXM_ZZSH_balanceWin:onMomentumBtn()
self.selectIndex=reportType.momentum
self:refreshReportPage()
end


function UIXM_ZZSH_balanceWin:onMomentumChartBtn()
UIManager:showWindow("UIXM_ZZSH_RankListWin")
self:closeSelf()
end


function UIXM_ZZSH_balanceWin:onCloseBtn()
self:closeSelf()
end