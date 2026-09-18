







def_class("UIMoJieMoHeBlackWin",UIWindowBase)









function UIMoJieMoHeBlackWin:bindComponents()

self.baodibtn=UIButton.get(self,0)
self.bdtxt=UIText.get(self,1)
self.center=UIObject.get(self,2)
self.closebtn=UIButton.get(self,3)
self.jdRoot=UIObject.get(self,4)
self.mjsltime=UIText.get(self,5)
self.onebtn=UIButton.get(self,6)
self.onetxt=UIText.get(self,7)
self.openmb=UIButton.get(self,8)
self.openxb=UIButton.get(self,9)
self.pgbar=UIObject.get(self,10)
self.pgValueTxt=UIText.get(self,11)
self.pmtsbtn=UIButton.get(self,12)
self.root=UIObject.get(self,13)
self.spinebg=UIObject.get(self,14)
self.tipsbtn=UIButton.get(self,15)
self.tipstxt=UIText.get(self,16)
self.titlename=UIText.get(self,17)
self.twobtn=UIButton.get(self,18)
self.twotxt=UIText.get(self,19)

self.baodibtn:setButtonClick(function()self:onBaodibtn()end)

self.closebtn:setButtonClick(function()self:onClosebtn()end)

self.onebtn:setButtonClick(function()self:onOnebtn()end)

self.openmb:setButtonClick(function()self:onOpenmb()end)

self.openxb:setButtonClick(function()self:onOpenxb()end)

self.pmtsbtn:setButtonClick(function()self:onPmtsbtn()end)

self.tipsbtn:setButtonClick(function()self:onTipsbtn()end)

self.twobtn:setButtonClick(function()self:onTwobtn()end)



end


function UIMoJieMoHeBlackWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.baodibtn);self.baodibtn=nil;
_UIObject_release(self.bdtxt);self.bdtxt=nil;
_UIObject_release(self.center);self.center=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
_UIObject_release(self.jdRoot);self.jdRoot=nil;
_UIObject_release(self.mjsltime);self.mjsltime=nil;
_UIObject_release(self.onebtn);self.onebtn=nil;
_UIObject_release(self.onetxt);self.onetxt=nil;
_UIObject_release(self.openmb);self.openmb=nil;
_UIObject_release(self.openxb);self.openxb=nil;
_UIObject_release(self.pgbar);self.pgbar=nil;
_UIObject_release(self.pgValueTxt);self.pgValueTxt=nil;
_UIObject_release(self.pmtsbtn);self.pmtsbtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.spinebg);self.spinebg=nil;
_UIObject_release(self.tipsbtn);self.tipsbtn=nil;
_UIObject_release(self.tipstxt);self.tipstxt=nil;
_UIObject_release(self.titlename);self.titlename=nil;
_UIObject_release(self.twobtn);self.twobtn=nil;
_UIObject_release(self.twotxt);self.twotxt=nil;
end


















local _this
local RankSubtype=
{
one=1,
two=2,
}
local abname='ui/windows/mojierank/mojierank_atlas_pak.ab'

function UIMoJieMoHeBlackWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIMoJieMoHeBlackWin:__delete()
self:unbindComponents()
end




function UIMoJieMoHeBlackWin:onShow(argtable,afterOnloaded)


local nowsaijiid=xianjieController:getMoJieSaiJiID()
self.mojiecfg=cfgHelper.get1(cfg_mojiemoherankconfig_get,nowsaijiid)
self.selectSubIdx=RankSubtype.one
self:freshSmallPage()

self.center:setChildCanvasGroupAlpha(0)
local func=function()
if _this==nil then return end
self:delayDo(0.4,function()
if _this==nil then return end
self.center:setChildCanvasGroupDOFade(1,0.4,nil)
end)
end
self.spinebg:setChildUIModelShowTarget(6476,1,nil,eAnimationID.enter,false,false,0,func)
self:refreshUI()
self:freshMJSLTitle()
end


function UIMoJieMoHeBlackWin:onHide()

end

function UIMoJieMoHeBlackWin:refreshSpine()

self.spinebg:setChildUIModelShowTarget(6476,1,nil,eAnimationID.stand)



end




function UIMoJieMoHeBlackWin:onBaodibtn()
UIManager:showWindow("UIMoJieRankMoHeRewardListWin",{rankType=self.selectSubIdx})
end



function UIMoJieMoHeBlackWin:onClosebtn()
self:onCloseClick()
end



function UIMoJieMoHeBlackWin:onOnebtn()
if self.selectSubIdx==RankSubtype.one then
return
end
self.selectSubIdx=RankSubtype.one
self:freshSmallPage()
self:refreshUI()
end



function UIMoJieMoHeBlackWin:onOpenmb()
end



function UIMoJieMoHeBlackWin:onOpenxb()
end



function UIMoJieMoHeBlackWin:onPmtsbtn()
local shengjiarg=_this.mojiecfg.shengjiarg
local data

data=shengjiarg[self.selectSubIdx]

if data then
local tipsdata=self:tipsdata()
local showdata=
{
titleName=data[1],
goodDesc=data[2],
showList=data[3],
tips=tipsdata
}
self:showWindow("UIMoJieRankPageWin",showdata)
end
end

function UIMoJieMoHeBlackWin:tipsdata()
local d={}
d.title='说明'
d.mode=3
d.showBlack=true
if self.selectSubIdx==RankSubtype.one then
d.name='MoHe_rule_GR_%d'
elseif self.selectSubIdx==RankSubtype.two then
d.name='MoHe_rule_XM_%d'
end
return d
end


function UIMoJieMoHeBlackWin:onTipsbtn()
local tipsdata=self:tipsdata()

UIManager:showWindow('UIRuleWin',tipsdata)
end



function UIMoJieMoHeBlackWin:onTwobtn()
if self.selectSubIdx==RankSubtype.two then
return
end
self.selectSubIdx=RankSubtype.two
self:freshSmallPage()
self:refreshUI()
end


function UIMoJieMoHeBlackWin:freshSmallPage()
if self.selectSubIdx==RankSubtype.one then
self.winlua:SetChildCSImageSprite(self.onebtn:getID(),abname,'button_myzb_yq5')
self.winlua:SetChildCSImageSprite(self.twobtn:getID(),abname,'button_myzb_yq6')
elseif self.selectSubIdx==RankSubtype.two then
self.winlua:SetChildCSImageSprite(self.onebtn:getID(),abname,'button_myzb_yq6')
self.winlua:SetChildCSImageSprite(self.twobtn:getID(),abname,'button_myzb_yq5')
end

end

function UIMoJieMoHeBlackWin:refreshUI()

if self.selectSubIdx==RankSubtype.one then
self.titlename:setText("个人排名")
socketManager:send_39_41()
UIManager:showWindow("UIMoJieRankMoHePeopleWin")
UIManager:hideWindow("UIMoJieRankMoHeXMWin")
elseif self.selectSubIdx==RankSubtype.two then
self.titlename:setText("仙盟排名")
socketManager:send_39_42()
UIManager:showWindow("UIMoJieRankMoHeXMWin")
UIManager:hideWindow("UIMoJieRankMoHePeopleWin")
end

end


function UIMoJieMoHeBlackWin:onCloseClick()
xianjieController.ShowRank[xianjieController.Ranktype.mhRank].closefunction()
end

function UIMoJieMoHeBlackWin:freshMJSLTitle()
local endtime=xianjieController:getMoJieSaiJieTime()
if endtime then
self:MJrefreshTime(endtime)
else
self:stopSelfTimerMJ()
end
end

function UIMoJieMoHeBlackWin:MJrefreshTime(endTime)
local curTime=timeHelper.getServerShortTime()
local timeStr=FMT.fmt('{0}结算',timeHelper.format_time_stamp15(endTime-curTime))
self.tipstxt:setText(timeStr)
self:stopSelfTimerMJ()
local func=function()
local serTime=timeHelper.getServerShortTime()
local dtTime=endTime-serTime
local showTime=dtTime>=0 and dtTime or 0
timeStr=FMT.fmt('{0}结算',timeHelper.format_time_stamp15(showTime))
self.tipstxt:setText(timeStr)

if dtTime<=0 then
self:stopSelfTimerMJ()
end
end
self.timermjsl=self:setTimer(1,0,func)
end

function UIMoJieMoHeBlackWin:stopSelfTimerMJ()
if self.timermjsl then
self:stopTimerByID(self.timermjsl)
self.timermjsl=nil
end
end