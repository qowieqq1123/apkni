







def_class("UIMonthInvestorWin_zhekou",UIWindowBase)









function UIMonthInvestorWin_zhekou:bindComponents()

self.mask=UIButton.get(self,0)
self.btnClose=UIButton.get(self,1)
self.title=UIText.get(self,2)
self.rewardScrollView=UIObject.get(self,3)
self.getRewardBtn=UIButton.get(self,4)
self.npcModel=UIObject.get(self,5)
self.titleimage=UIImage.get(self,6)
self.titleimage2=UIImage.get(self,7)
self.speakObj=UIObject.get(self,8)
self.normalCardTime=UIText.get(self,9)
self.highCardTime=UIText.get(self,10)
self.lingyutxtnum=UIText.get(self,11)
self.icon=UIImage.get(self,12)
self.zhekou=UIImage.get(self,13)
self.speakText=UIText.get(self,14)

self.mask:setButtonClick(function()self:onMask()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.getRewardBtn:setButtonClick(function()self:onGetRewardBtn()end)



end


function UIMonthInvestorWin_zhekou:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.getRewardBtn);self.getRewardBtn=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.titleimage);self.titleimage=nil;
_UIObject_release(self.titleimage2);self.titleimage2=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.normalCardTime);self.normalCardTime=nil;
_UIObject_release(self.highCardTime);self.highCardTime=nil;
_UIObject_release(self.lingyutxtnum);self.lingyutxtnum=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.zhekou);self.zhekou=nil;
_UIObject_release(self.speakText);self.speakText=nil;
end



















local _this
function UIMonthInvestorWin_zhekou:onLoaded(...)
self:bindComponents()
_this=self
end


function UIMonthInvestorWin_zhekou:__delete()
self:unbindComponents()
end
local abname='ui/windows/recharge/monthcard_atlas_pak.ab'
local imagename=
{
"image_xianshizhekou",
"image_xianshizhekou_02",

}




function UIMonthInvestorWin_zhekou:onShow(argtable,afterOnloaded)
if argtable then
self.type=argtable[1]
self.cardid=argtable[2]
end
self.titleimage:setActive(false)
self.titleimage2:setActive(false)
if self.type==1 then
self.zhekou:setSprite(abname,imagename[1])

self.titleimage:setActive(true)
elseif self.type==2 then
self.zhekou:setSprite(abname,imagename[2])
self.titleimage2:setActive(true)

end
if self.cardid==1 then
self.title:setText("荣誉执事特权")
elseif self.cardid==2 then
self.title:setText("尊贵股东特权")
end


local cfg=cfgHelper.get1(cfg_yuekanpcconfig_get,4)
self.speakContent_before=cfg.npcTalk_before
self.speakContent_after=cfg.npcTalk_after
self.npcTalkTime=cfg.npcTalkTime
self.npcTalkShowTime=cfg.npcTalkShowTime
local npcModelParms=cfg.npcModel
local modelId=npcModelParms[1]
local modelOffSet=npcModelParms[3]
self.npcModel:setChildUIModelShowTarget(modelId,npcModelParms[2],{},eAnimationID.stand,false,false,0)
self.npcModel:setChildUIModelShowTargetOffset(modelOffSet[1],modelOffSet[2])

self:delayDo(0.3,function()
self:doSpeaking()
end)
self:refresh()

self.icon:setIcon(iconHelper.getIconName(eMoneyType.mtLingYu))
end


function UIMonthInvestorWin_zhekou:onHide()

end




function UIMonthInvestorWin_zhekou:refresh()

self.monthInvestorCfg=cfg_yuekaconfig()
self.monthCfg=self.monthInvestorCfg[self.cardid]
self.monthPrivilegeList=self.monthCfg.showItems

self.rewardScrollView:setChildScrollViewCreateGrids(#self.monthPrivilegeList,1)
local grids=self.rewardScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
local showItems_tequan=self.monthCfg.showItems_tequan
for i=1,count do
local item=grids[i-1]
if item then
local reward=self.monthPrivilegeList[i]
local itemid=reward[1]
local count=0
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}

local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)
item:SetChildActive(0,false)
local desc=showItems_tequan[i]
if desc then
item:SetChildText(8,desc)
end

end

end



local singlenum=0
for k,v in ipairs(self.monthCfg.dayItems)do
if v[1]==2 then
singlenum=singlenum+v[2]
end
end
local day=self.monthCfg.vaildTime
local str=day*singlenum
self.lingyutxtnum:setText(str)
end

function UIMonthInvestorWin_zhekou:onMask()
end



function UIMonthInvestorWin_zhekou:onBtnClose()
self:closeSelf()
end



function UIMonthInvestorWin_zhekou:onGetRewardBtn()
self:closeSelf()
jumpManager:jump({id=701,args={tabType=FULL_TAB_TYPE.eMonthInvestor}})

end



function UIMonthInvestorWin_zhekou:onNpcClick()
end


function UIMonthInvestorWin_zhekou:doSpeaking()
self:clearSpeakTimer()
local speakList={}

local isActiveCard=rechargeModel:checkHasCardActive()
if isActiveCard then
speakList=self.speakContent_after
else
speakList=self.speakContent_before
end

local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self.npcModel:setChildModelAnimationState(2099)
self:doTalkAnim()
end


function UIMonthInvestorWin_zhekou:doTalkAnim()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
self.speakObj:setScale(Vector3.zero)
self:delayDo(0.5,function()
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
end)
end


function UIMonthInvestorWin_zhekou:talkEnd()
self:clearSpeakTimer()
self.speakShowTimer=self:delayDo(self.npcTalkShowTime,function()

self.speakObj:setScale(Vector3.zero)
self.npcModel:setChildModelAnimationState(eAnimationID.stand)

self.speakTimer=self:delayDo(self.npcTalkTime,function()
return self:doSpeaking()
end)
end)
end


function UIMonthInvestorWin_zhekou:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end