







def_class("UIMoJieRankBlackWin",UIWindowBase)









function UIMoJieRankBlackWin:bindComponents()

self.root=UIObject.get(self,0)
self.spinebg=UIObject.get(self,1)
self.openxb=UIButton.get(self,2)
self.openmb=UIButton.get(self,3)
self.onebtn=UIButton.get(self,4)
self.twobtn=UIButton.get(self,5)
self.onetxt=UIText.get(self,6)
self.twotxt=UIText.get(self,7)
self.tipsbtn=UIButton.get(self,8)
self.tipstxt=UIText.get(self,9)
self.baodibtn=UIButton.get(self,10)
self.bdtxt=UIText.get(self,11)
self.closebtn=UIButton.get(self,12)
self.center=UIObject.get(self,13)
self.pmtsbtn=UIButton.get(self,14)
self.jdRoot=UIObject.get(self,15)
self.pgbar=UIObject.get(self,16)
self.pgValueTxt=UIText.get(self,17)
self.mjsltime=UIText.get(self,18)

self.openxb:setButtonClick(function()self:onOpenxb()end)

self.openmb:setButtonClick(function()self:onOpenmb()end)

self.onebtn:setButtonClick(function()self:onOnebtn()end)

self.twobtn:setButtonClick(function()self:onTwobtn()end)

self.tipsbtn:setButtonClick(function()self:onTipsbtn()end)

self.baodibtn:setButtonClick(function()self:onBaodibtn()end)

self.closebtn:setButtonClick(function()self:onClosebtn()end)

self.pmtsbtn:setButtonClick(function()self:onPmtsbtn()end)



end


function UIMoJieRankBlackWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.spinebg);self.spinebg=nil;
_UIObject_release(self.openxb);self.openxb=nil;
_UIObject_release(self.openmb);self.openmb=nil;
_UIObject_release(self.onebtn);self.onebtn=nil;
_UIObject_release(self.twobtn);self.twobtn=nil;
_UIObject_release(self.onetxt);self.onetxt=nil;
_UIObject_release(self.twotxt);self.twotxt=nil;
_UIObject_release(self.tipsbtn);self.tipsbtn=nil;
_UIObject_release(self.tipstxt);self.tipstxt=nil;
_UIObject_release(self.baodibtn);self.baodibtn=nil;
_UIObject_release(self.bdtxt);self.bdtxt=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
_UIObject_release(self.center);self.center=nil;
_UIObject_release(self.pmtsbtn);self.pmtsbtn=nil;
_UIObject_release(self.jdRoot);self.jdRoot=nil;
_UIObject_release(self.pgbar);self.pgbar=nil;
_UIObject_release(self.pgValueTxt);self.pgValueTxt=nil;
_UIObject_release(self.mjsltime);self.mjsltime=nil;
end
















local _this
local Ranktype=
{
xianfa=1,
zhumo=2,
}
local RankSubtype=
{
one=1,
two=2,
}
local _eRankListType=
{
xf=1,
xs=2,
zm=3,
zmxm=4,
}
local rewardtype=
{
rank=1,
xfz=2,
zmgx=3
}
local rewardrank=
{
xf=1,
xs=2,
zm=3,
zmxm=4,
}
local abname='ui/windows/mojierank/mojierank_atlas_pak.ab'
local menu_slot_name='button_dytab'



function UIMoJieRankBlackWin:onLoaded(...)
self:bindComponents()
_this=self
self.isopenxs=false
self.selectIdx=1
self.selectSubIdx=1
end


function UIMoJieRankBlackWin:__delete()
self:unbindComponents()
self:stopSelfTimerMJ()
_this=nil
end


function UIMoJieRankBlackWin:onTipsbtn()










local rankType=1
if self.selectIdx==Ranktype.xianfa then
rankType=1
elseif self.selectIdx==Ranktype.zhumo then
rankType=2
end
self:showWindow('UIMoJieRankRuleWin_New',{rankType=rankType})
end

function UIMoJieRankBlackWin:onBaodibtn()





















local rankType=1
if self.selectIdx==Ranktype.xianfa then
if self.selectSubIdx==RankSubtype.one then
rankType=rewardrank.xf
elseif self.selectSubIdx==RankSubtype.two then
rankType=rewardrank.xs
end
elseif self.selectIdx==Ranktype.zhumo then
if self.selectSubIdx==RankSubtype.one then
rankType=rewardrank.zm
elseif self.selectSubIdx==RankSubtype.two then
rankType=rewardrank.zmxm
end
end
self:showWindow("UIMoJieRankRewardListWin",{rankType=rankType})
end

function UIMoJieRankBlackWin:onPmtsbtn()
local shengjiarg=_this.mojiecfg.shengjiarg
local data
if self.selectIdx==Ranktype.xianfa then
if self.selectSubIdx==RankSubtype.one then
data=shengjiarg[rewardrank.xf]
elseif self.selectSubIdx==RankSubtype.two then
data=shengjiarg[rewardrank.xs]
end
elseif self.selectIdx==Ranktype.zhumo then
if self.selectSubIdx==RankSubtype.one then
data=shengjiarg[rewardrank.zm]
elseif self.selectSubIdx==RankSubtype.two then
data=shengjiarg[rewardrank.zmxm]
end
end

if data then
local rankType=1
if self.selectIdx==Ranktype.xianfa then
rankType=1
elseif self.selectIdx==Ranktype.zhumo then
rankType=2
end
local showdata=
{
titleName=data[1],
goodDesc=data[2],
showList=data[3],
rankType=rankType,
}
self:showWindow("UIMoJieRankPageWin",showdata)
end
end


function UIMoJieRankBlackWin:onOpenxb()
if self.selectIdx==Ranktype.xianfa then
return
end
self.selectIdx=Ranktype.xianfa
self:reqRankData(self.selectIdx,self.selectSubIdx)
self:refreshSpine()
self:freshBigPage()
self:refreshUI()
end

function UIMoJieRankBlackWin:onOpenmb()
if self.selectIdx==Ranktype.zhumo then
return
end
self.selectIdx=Ranktype.zhumo
self:reqRankData(self.selectIdx,self.selectSubIdx)
self:refreshSpine()
self:freshBigPage()
self:refreshUI()
end

function UIMoJieRankBlackWin:onOnebtn()
if self.selectSubIdx==RankSubtype.one then
return
end
self.selectSubIdx=RankSubtype.one
self:reqRankData(self.selectIdx,self.selectSubIdx)
self:freshSmallPage()
self:refreshUI()
end

function UIMoJieRankBlackWin:onTwobtn()
if self.selectSubIdx==RankSubtype.two then
return
end
self.selectSubIdx=RankSubtype.two
self:reqRankData(self.selectIdx,self.selectSubIdx)
self:freshSmallPage()
self:refreshUI()
end




function UIMoJieRankBlackWin:onShow(argtable,afterOnloaded)
local selectid=argtable.id or 1
local selectsubid=argtable.subid or 1
self.selectIdx=selectid
self.selectSubIdx=selectsubid
local enterData=xianjieModel:getMoJieEnterData()
self.mojiecfg=cfgHelper.get1(cfg_devildomseasonconfig_get,enterData.sId)
self.dailycfg=cfgHelper.get2(cfg_devildombaseconfig_get,1,'daily')or{}
self.saijiid=xianjieController:getMoJieSaiJiID()
self.chapteridx=xianjieController:getMoJieSaiJiChapteridx()or 1


self.center:setChildCanvasGroupAlpha(0)
local func=function()
if _this==nil then return end
self:delayDo(0.4,function()
if _this==nil then return end
self.center:setChildCanvasGroupDOFade(1,0.4,nil)
end)
end
if self.selectIdx==Ranktype.xianfa then
self.spinebg:setChildUIModelShowTarget(6250,1,nil,eAnimationID.enter,false,false,0,func)
elseif self.selectIdx==Ranktype.zhumo then
self.spinebg:setChildUIModelShowTarget(6251,1,nil,eAnimationID.enter,false,false,0,func)
end


self:initBtnPanel()
self:initJumpShow()
self:freshMJSLTitle()
end


function UIMoJieRankBlackWin:onHide()

end

function UIMoJieRankBlackWin:onClosebtn()
self:onCloseClick()
end

function UIMoJieRankBlackWin:onCloseClick(atOnce)

self:closeSelf()

UIManager:closeWindow("UIMoJieRankGRZXWin")
UIManager:closeWindow("UIMoJieRankGRXSWin")
UIManager:closeWindow("UIMoJieRankGRFMWin")
UIManager:closeWindow("UIMoJieRankXMFMWin")
UIManager:closeWindow("UIMoJieRankSelectInternalWin")
end


function UIMoJieRankBlackWin:initBtnPanel()
self:freshBigPage()
self:freshSmallPage()
end

function UIMoJieRankBlackWin:freshBigPage()
if self.selectIdx==Ranktype.xianfa then
self.winlua:SetChildCSImageSprite(self.openxb:getID(),abname,'button_myzb_yq1')
self.winlua:SetChildCSImageSprite(self.openmb:getID(),abname,'button_myzb_yq2')
self.onetxt:setText('个人仙伐')
self.twotxt:setText('个人仙陨')
elseif self.selectIdx==Ranktype.zhumo then
self.winlua:SetChildCSImageSprite(self.openxb:getID(),abname,'button_myzb_yq4')
self.winlua:SetChildCSImageSprite(self.openmb:getID(),abname,'button_myzb_yq3')
self.onetxt:setText('个人伏魔')
self.twotxt:setText('仙盟伏魔')
end
self:freshBaoXianReward()
end

function UIMoJieRankBlackWin:freshSmallPage()
if self.selectSubIdx==RankSubtype.one then
self.winlua:SetChildCSImageSprite(self.onebtn:getID(),abname,'button_myzb_yq5')
self.winlua:SetChildCSImageSprite(self.twobtn:getID(),abname,'button_myzb_yq6')
elseif self.selectSubIdx==RankSubtype.two then
self.winlua:SetChildCSImageSprite(self.onebtn:getID(),abname,'button_myzb_yq6')
self.winlua:SetChildCSImageSprite(self.twobtn:getID(),abname,'button_myzb_yq5')
end
self:freshBaoXianReward()
end


function UIMoJieRankBlackWin:initJumpShow(init)
self:refreshUI()
end

function UIMoJieRankBlackWin:refreshUI()
if self.selectIdx==Ranktype.xianfa then
if self.selectSubIdx==RankSubtype.one then
UIManager:showWindow("UIMoJieRankGRZXWin")

UIManager:hideWindow("UIMoJieRankGRXSWin")
UIManager:hideWindow("UIMoJieRankGRFMWin")
UIManager:hideWindow("UIMoJieRankXMFMWin")
elseif self.selectSubIdx==RankSubtype.two then
UIManager:showWindow("UIMoJieRankGRXSWin")
UIManager:hideWindow("UIMoJieRankGRZXWin")
UIManager:hideWindow("UIMoJieRankGRFMWin")
UIManager:hideWindow("UIMoJieRankXMFMWin")
end
elseif self.selectIdx==Ranktype.zhumo then
if self.selectSubIdx==RankSubtype.one then
UIManager:showWindow("UIMoJieRankGRFMWin")
UIManager:hideWindow("UIMoJieRankGRZXWin")
UIManager:hideWindow("UIMoJieRankGRXSWin")
UIManager:hideWindow("UIMoJieRankXMFMWin")
elseif self.selectSubIdx==RankSubtype.two then
UIManager:showWindow("UIMoJieRankXMFMWin")
UIManager:hideWindow("UIMoJieRankGRZXWin")
UIManager:hideWindow("UIMoJieRankGRXSWin")
UIManager:hideWindow("UIMoJieRankGRFMWin")
end
end
end

function UIMoJieRankBlackWin:refreshSpine()
if self.selectIdx==Ranktype.xianfa then
self.spinebg:setChildUIModelShowTarget(6250,1,nil,eAnimationID.stand)
elseif self.selectIdx==Ranktype.zhumo then
self.spinebg:setChildUIModelShowTarget(6251,1,nil,eAnimationID.stand)
end
end

function UIMoJieRankBlackWin:reqRankData(selectIdx,selectSubIdx)
if selectIdx==1 then
if selectSubIdx==1 then
if xianjieController:checkmojieRankTime(_eRankListType.xf)then
xianjieController:reqmojieRankData(_eRankListType.xf)
end
else
if xianjieController:checkmojieRankTime(_eRankListType.xs)then
xianjieController:reqmojieRankData(_eRankListType.xs)
end
end
else
if selectSubIdx==1 then
if xianjieController:checkmojieRankTime(_eRankListType.zm)then
xianjieController:reqmojieRankData(_eRankListType.zm)
end
else
if xianjieController:checkmojieRankTime(_eRankListType.zmxm)then
xianjieController:reqmojieRankData(_eRankListType.zmxm)
end
end
end
end


function UIMoJieRankBlackWin:freshtipsdesc()
local ruleTips=_this.mojiecfg.ruleTips
local tipsBtnShow=_this.mojiecfg.tipsBtnShow or{}
local lock=false
local Tips=''
local isjindu=false
if self.selectIdx==Ranktype.xianfa then
if self.selectSubIdx==RankSubtype.one then
Tips=ruleTips[rewardrank.xf]
lock=tipsBtnShow[rewardrank.xf]
isjindu=-10
elseif self.selectSubIdx==RankSubtype.two then
Tips=ruleTips[rewardrank.xs]
lock=tipsBtnShow[rewardrank.xs]
isjindu=-20
end
elseif self.selectIdx==Ranktype.zhumo then
if self.selectSubIdx==RankSubtype.one then
Tips=ruleTips[rewardrank.zm]
lock=tipsBtnShow[rewardrank.zm]
elseif self.selectSubIdx==RankSubtype.two then
Tips=ruleTips[rewardrank.zmxm]
lock=tipsBtnShow[rewardrank.zmxm]
end
end
self.mjsltime:setText(Tips)

if lock then
self.tipsbtn:setActive(true)
else
self.tipsbtn:setActive(false)
end

if isjindu then
local dailyList=xianjieController:getDailyList()
local num=dailyList[isjindu]
local num2=self.dailycfg[isjindu]
if num and num2 then
self.jdRoot:setActive(true)
self.pgValueTxt:setText(FMT.fmt("{0}/{1}",num,num2))
self.pgbar:setChildUIProgressbar(num,num2,false)
self.tipstxt:setLocalPosX(254)
else
self.jdRoot:setActive(false)
self.tipstxt:setLocalPosX(0)
end
else
self.jdRoot:setActive(false)
self.tipstxt:setLocalPosX(0)
end
end

function UIMoJieRankBlackWin:freshBaoXianReward()
local rewardList=self:getBaoXianReward()
if rewardList then
self.baodibtn:setActive(true)
else
self.baodibtn:setActive(false)
end
self:freshtipsdesc()
end

function UIMoJieRankBlackWin:getBaoXianReward()
local cfgrank=self:getTypeReward(rewardtype.rank)
local cfgrewards
if self.selectIdx==Ranktype.xianfa then
if self.selectSubIdx==RankSubtype.one then
cfgrewards=cfgrank[rewardrank.xf]
elseif self.selectSubIdx==RankSubtype.two then
cfgrewards=cfgrank[rewardrank.xs]
end
elseif self.selectIdx==Ranktype.zhumo then
if self.selectSubIdx==RankSubtype.one then
cfgrewards=cfgrank[rewardrank.zm]
elseif self.selectSubIdx==RankSubtype.two then
cfgrewards=cfgrank[rewardrank.zmxm]
end
end

if cfgrewards then
local rewardList=self:getRewardByRankTY(cfgrewards)
return rewardList
end
end

function UIMoJieRankBlackWin:getTypeReward(flag)
local cfgrank=_this.mojiecfg.rank

return cfgrank[flag]
end

function UIMoJieRankBlackWin:getRewardByRankTY(cfg)
if cfg then





if cfg[0]then
return cfg[0]
end
end
end

function UIMoJieRankBlackWin:getRuleCfg()

local cfgruleLang=_this.mojiecfg.ruleLangId
local Lang
if self.selectIdx==Ranktype.xianfa then
if self.selectSubIdx==RankSubtype.one then
Lang=cfgruleLang[rewardrank.xf]
elseif self.selectSubIdx==RankSubtype.two then
Lang=cfgruleLang[rewardrank.xs]
end
elseif self.selectIdx==Ranktype.zhumo then
if self.selectSubIdx==RankSubtype.one then
Lang=cfgruleLang[rewardrank.zm]
elseif self.selectSubIdx==RankSubtype.two then
Lang=cfgruleLang[rewardrank.zmxm]
end
end

local sj=self.saijiid
local zj=self.chapteridx



if Lang[zj]then
return Lang[zj]
else
return Lang[1]
end
end


function UIMoJieRankBlackWin:freshMJSLTitle()
local endtime=xianjieController:getMoJieSaiJieTime()
if endtime then
self:MJrefreshTime(endtime)
else
self:stopSelfTimerMJ()
end
end
function UIMoJieRankBlackWin:MJrefreshTime(endTime)
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
function UIMoJieRankBlackWin:stopSelfTimerMJ()
if self.timermjsl then
self:stopTimerByID(self.timermjsl)
self.timermjsl=nil
end
end
