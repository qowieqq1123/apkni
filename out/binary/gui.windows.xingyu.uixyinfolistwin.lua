







def_class("UIXYInfoListWIn",UIWindowBase)









function UIXYInfoListWIn:bindComponents()

self.mask=UIButton.get(self,0)
self.rightArrow=UIButton.get(self,1)
self.leftArrow=UIButton.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.bgicon=UIImage.get(self,4)
self.nameicon=UIImage.get(self,5)
self.desc_1=UIText.get(self,6)
self.tipsBtn=UIButton.get(self,7)
self.title=UIText.get(self,8)
self.effectItem_1=UIObject.get(self,9)
self.effectItem_2=UIObject.get(self,10)
self.rewardBtn=UIButton.get(self,11)
self.rewardView=UIObject.get(self,12)
self.rewardList=UIObject.get(self,13)
self.tipsTxt=UIText.get(self,14)
self.paiqianBtn=UIButton.get(self,15)
self.costIcon=UIImage.get(self,16)
self.costTxt=UIText.get(self,17)
self.enterBtn=UIButton.get(self,18)
self.lockTipRoot=UIObject.get(self,19)
self.lockTip=UIText.get(self,20)
self.desc_2=UIText.get(self,21)
self.desc_3=UIText.get(self,22)
self.paiqianBtnTxt=UIText.get(self,23)
self.enterBtnTxt=UIText.get(self,24)
self.chakanBtn=UIButton.get(self,25)
self.bgModel=UIObject.get(self,26)
self.root=UIObject.get(self,27)

self.mask:setButtonClick(function()self:onMask()end)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.paiqianBtn:setButtonClick(function()self:onPaiqianBtn()end)

self.enterBtn:setButtonClick(function()self:onEnterBtn()end)

self.chakanBtn:setButtonClick(function()self:onChakanBtn()end)
self.desc={
self.desc_1,
self.desc_2,
self.desc_3,
}
self.effectItem={
self.effectItem_1,
self.effectItem_2,
}



end


function UIXYInfoListWIn:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.bgicon);self.bgicon=nil;
_UIObject_release(self.nameicon);self.nameicon=nil;
_UIObject_release(self.desc_1);self.desc_1=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.effectItem_1);self.effectItem_1=nil;
_UIObject_release(self.effectItem_2);self.effectItem_2=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardView);self.rewardView=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.paiqianBtn);self.paiqianBtn=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costTxt);self.costTxt=nil;
_UIObject_release(self.enterBtn);self.enterBtn=nil;
_UIObject_release(self.lockTipRoot);self.lockTipRoot=nil;
_UIObject_release(self.lockTip);self.lockTip=nil;
_UIObject_release(self.desc_2);self.desc_2=nil;
_UIObject_release(self.desc_3);self.desc_3=nil;
_UIObject_release(self.paiqianBtnTxt);self.paiqianBtnTxt=nil;
_UIObject_release(self.enterBtnTxt);self.enterBtnTxt=nil;
_UIObject_release(self.chakanBtn);self.chakanBtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
self.desc=nil;
self.effectItem=nil;
end















local abName="ui/windows/xingyu/xingyu_atlas_pak.ab"



function UIXYInfoListWIn:onLoaded(...)
self:bindComponents()
self.bgModel:setChildUIModelShowTarget(5651,1,nil,eAnimationID.enter,false,false,0,function()


self:delayDo(0.5,function()
if self and not self.isClose then
self.root:setChildCanvasGroupDOFade(1,0.5)
end
end)

end)
end


function UIXYInfoListWIn:__delete()
self:unbindComponents()
self:stopTimer()
end




function UIXYInfoListWIn:onShow(argtable,afterOnloaded)
local xyId
local otherArgs
local listIndex
self.xingyuList=XingYuModel:getXingYuIdList()
if not self.xingyuList then
logErr("UIXYInfoListWIn 没有 xingyuList")
return
end
self.maxIndex=#self.xingyuList
if argtable then
xyId=argtable.xyId
otherArgs=argtable.otherArgs
if otherArgs then
listIndex=otherArgs.listIndex
end
end
if not listIndex and xyId then
for i,v in ipairs(self.xingyuList)do
if xyId==v then
listIndex=i
break
end
end
end
self.selectIndex=listIndex or 1

self:refreshView(afterOnloaded)
end


function UIXYInfoListWIn:onHide()

end

function UIXYInfoListWIn:refreshView(afterOnloaded)
self.rightArrow:setActive(self.selectIndex>1)
self.leftArrow:setActive(self.selectIndex<self.maxIndex)
local xyId=self.xingyuList[self.selectIndex]
local xyCfg=XingYuModel:getXingYuConfig(xyId)
local bgiconAssest=xyCfg.bgiconAssest
self.bgicon:setSprite(abName,bgiconAssest)
local nameiconAssest=xyCfg.nameiconAssest
self.nameicon:setSprite(abName,nameiconAssest)
local descList=xyCfg.descList
for i,v in ipairs(self.desc)do
v:setText(descList[i]or"")
end
self:refreshTitle()
self:refreshEffect(afterOnloaded)
self:refreshReward()
self:refreshBottom()
end

function UIXYInfoListWIn:refreshTitle()
local func=function()
local xyId=self.xingyuList[self.selectIndex]
local state,endTime=XingYuController.getXingYuState(xyId)
if self.lastState~=state then
local isbreak=self:stateChange(state)
if isbreak then
return
end
self.lastState=state
end

local str=""
local curTime=timeHelper.getServerShortTime()
local lerp=0

if state==XingYuState.eDataErr or
state==XingYuState.eNone then
lerp=-1
elseif state==XingYuState.eTanSuo then
str="探索期结束："
lerp=endTime-curTime
elseif state==XingYuState.eHunZhan then
str="混战期结束："
lerp=endTime-curTime
elseif state==XingYuState.eZhenDuo then
str="争夺期结束："
lerp=endTime-curTime
elseif state==XingYuState.eFinish then
str="星域消失："
lerp=endTime-curTime
end
if lerp>=0 then
if lerp>=3600 then
str=FMT.fmt("{0}{1}",str,timeHelper.format_time_stamp11(lerp,true))
else
str=FMT.fmt("{0}{1}",str,timeHelper.format_time_stamp7(lerp))
end
else
self:stopTimer()
end
self.title:setText(str)
end
self:startTimer(func)

func()
end

function UIXYInfoListWIn:refreshEffect(afterOnloaded)
local xyId=self.xingyuList[self.selectIndex]
local hjList=XingYuController.getHuanjingList(xyId)
for i,v in ipairs(self.effectItem)do
local widget=v:getWidgetBase()
if hjList[i]then
widget:SetChildActive(-1,true)
local str
local cfg=hjList[i]
local id=cfg.id
local parms=cfg.parms
local type=cfg.type
local newFlag=cfg.newFlag
widget:SetChildActive(2,newFlag)
widget:SetChildActive(3,newFlag)
if newFlag then
if afterOnloaded then
self:delayDo(0.6,function()
if self and not self.isClose and widget then
widget:SetChildShowEffect(3,10792,true)
end
end)
else
widget:SetChildShowEffect(3,10792,true)
end
end
if type==XYHJTYPE.eFaZe then
local ruleCfg=cfgHelper.getSSlawRule(id)
if ruleCfg then
local image=ruleCfg.image
local desc=ruleCfg.desc
local descparm=ruleCfg.descparm
if descparm and descparm[parms]and next(descparm[parms])then
desc=string.format(desc,unpack(descparm[parms]))
end
widget:SetChildCSImageIcon(0,image,false)
widget:SetChildText(1,desc)
else
widget:SetChildActive(-1,false)
end
elseif type==XYHJTYPE.eLimit then
local baseCfg=XingYuModel:getXingYuBaseConfig()
local limitTypeCfg=baseCfg.limitTypeCfg
local fmtStr=limitTypeCfg[id].fmtStr
local image=limitTypeCfg[id].iconName
local fmtparms
if id==1 then
fmtparms=cfgHelper.get(cfg_disciplevocationconfig_get,parms[1],"name")
elseif id==2 then
local spetype=parms[1]
local speId=parms[2]
local specialityConfig
if spetype==DISCIPLE_SPECIALITY_TYPE.eSpiritRoot then
specialityConfig=cfg_disciplespiritrootbookconfig_get(speId)
else
specialityConfig=UIDiscipleModel:getSpecialityConfig(spetype,speId)
end
fmtparms=specialityConfig.name
end
local desc=FMT.fmt(fmtStr,fmtparms)
widget:SetChildCSImageIcon(0,image,false)
widget:SetChildText(1,desc)
end
widget:SetChildActive(-1,true)
else
widget:SetChildActive(-1,false)
end
end
end

function UIXYInfoListWIn:refreshReward()
local xyId=self.xingyuList[self.selectIndex]
local xyCfg=XingYuModel:getXingYuConfig(xyId)
self.detialList=xyCfg.detailRewards
local allRewardList=xyCfg.showRewards



























































local count=#allRewardList>4 and 4 or#allRewardList
self.rewardList:setChildLayoutGroupCreateItems(count,function(index)
local rewardItem=self.rewardList:getChildLayoutGroupGridItem(index-1)
local rewardData=allRewardList[index]
widgetHelper.setNormalRewardItem(rewardItem,-1,rewardData,true)

local itemCfg=itemsConfig.getConfig(rewardData[1])
local color=itemCfg.color
if color>=eQualityColor.eOrange then
rewardItem:SetChildQualityEffect(1,color)
end

end)
end

function UIXYInfoListWIn:refreshBottom()
local xyId=self.xingyuList[self.selectIndex]
local xyCfg=XingYuModel:getXingYuConfig(xyId)
local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eXianJieXingYu)

if actInfo then
local open,tipStr=actInfo:checkCondition()
if open then
self.lockTipRoot:setActive(false)
local state,endTime=XingYuController.getXingYuState(xyId)
local hasTeam=XingYuController.checkHasTeam(xyId)
self.tipsTxt:setActive(false)
if state==XingYuState.eTanSuo then
self.tipsTxt:setActive(true)
local limtTime=XingYuController.getTeamDispLimit()
local tsEndTime=XingYuController.getTanSuoEndTime()
local lerp=tsEndTime-limtTime
self.tipsTxt:setText(FMT.fmt("探索期结束前{0}不可派遣",timeHelper.format_time_stamp7(lerp)))










self.chakanBtn:setActive(false)
if hasTeam then
self.paiqianBtn:setActive(true)
self.enterBtn:setActive(true)
self.enterBtn:setChildAnchoredPos(427.6,-240.7)
self.paiqianBtn:setChildAnchoredPos(239,-240.7)



else
self.paiqianBtn:setActive(true)
self.enterBtn:setActive(false)
self.paiqianBtn:setChildAnchoredPos(338.5,-240.7)










end

local inLimtTime=XingYuController.checkInPaiQianLimtTime(xyId)
if inLimtTime then
if hasTeam then
self.paiqianBtnTxt:setText("查看队伍")
else
self.paiqianBtnTxt:setText("派遣队伍")
end
else
if hasTeam then


self.paiqianBtnTxt:setText("查看队伍")
else
self.paiqianBtnTxt:setText("派遣队伍")
end
end

elseif state==XingYuState.eHunZhan or state==XingYuState.eZhenDuo then


if hasTeam then
self.chakanBtn:setActive(false)
self.paiqianBtn:setActive(true)
self.paiqianBtnTxt:setText("查看队伍")
self.enterBtn:setActive(true)
self.enterBtn:setChildAnchoredPos(427.6,-240.7)
self.paiqianBtn:setChildAnchoredPos(239,-240.7)
else
self.chakanBtn:setActive(true)
self.paiqianBtn:setActive(false)
self.enterBtn:setActive(false)
end
elseif state==XingYuState.eFinish then


if hasTeam then
self.chakanBtn:setActive(false)
self.paiqianBtn:setActive(false)
self.enterBtn:setActive(true)
self.enterBtn:setChildAnchoredPos(338.5,-240.7)
else
self.chakanBtn:setActive(true)
self.paiqianBtn:setActive(false)
self.enterBtn:setActive(false)
end
end


else
self.tipsTxt:setActive(false)
self.paiqianBtn:setActive(false)
self.enterBtn:setActive(false)
self.lockTipRoot:setActive(true)
self.lockTip:setText(tipStr)
end
else
self.tipsTxt:setActive(false)
self.paiqianBtn:setActive(false)
self.enterBtn:setActive(false)
self.lockTipRoot:setActive(false)
end
end

function UIXYInfoListWIn:stateChange(state)
self:refreshBottom()
return false
end


function UIXYInfoListWIn:stopTimer()
if self._timer then
self:stopTimerByID(self._timer)
self._timer=nil
end
end

function UIXYInfoListWIn:startTimer(func)
self:stopTimer()
self._timer=self:setTimer(1,0,func)
end







function UIXYInfoListWIn:onMask()
xianjieController:closeWin("UIXYInfoListWIn")
end



function UIXYInfoListWIn:onRightArrow()
if self.selectIndex>1 then
self.selectIndex=self.selectIndex-1
self:refreshView()
end
end



function UIXYInfoListWIn:onLeftArrow()
if self.selectIndex<self.maxIndex then
self.selectIndex=self.selectIndex+1
self:refreshView()
end
end



function UIXYInfoListWIn:onCloseBtn()
xianjieController:closeWin("UIXYInfoListWIn")
end



function UIXYInfoListWIn:onTipsBtn()





local args={
ruleGroupID=ruleTipsImageGroup.eXingYu,
}
self:showWindow("UIRuleTipsImage2Win",args)
end



function UIXYInfoListWIn:onRewardBtn()

local xyId=self.xingyuList[self.selectIndex]
UIManager:showWindow("UIXingYuListRewardWin",{xyId=xyId})

end



function UIXYInfoListWIn:onPaiqianBtn()
local xyId=self.xingyuList[self.selectIndex]

local flag=XingYuController.checkLastXingYuRecv()
if flag then
local func=function()
XingYuController.showGetReward()
end
local contentStr="星域奖励未领取，无法派遣队伍\n是否前往领取？"
local dialog=UIDialogManager.getConfirmDialogEx(nil,{
content=contentStr,
okcb=func,
})
dialog:show()
return
end


local hasTeam=XingYuController.checkHasTeam(xyId)
if not hasTeam then
local inLimtTime=XingYuController.checkInPaiQianLimtTime(xyId)
if inLimtTime then
UIManager.error("当前时段不可派遣")
return
end










end

self:showWindow("UIXYTeamListWIn",{xyId=xyId})

end



function UIXYInfoListWIn:onEnterBtn()




local xyId=self.xingyuList[self.selectIndex]
XingYuController.req_35_102(xyId)
end

function UIXYInfoListWIn:onChakanBtn()
local xyId=self.xingyuList[self.selectIndex]
local state,endTime=XingYuController.getXingYuState(xyId)

if state==XingYuState.eHunZhan then
XingYuController.req_35_106(xyId)
elseif state==XingYuState.eZhenDuo or state==XingYuState.eFinish then
XingYuController.req_35_107(xyId)
end
end



