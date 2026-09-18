







def_class("UIDailySignInWin",UIWindowBase)









function UIDailySignInWin:bindComponents()

self.gubaoImage=UIObject.get(self,0)
self.gubaoName=UIText.get(self,1)
self.signInScroller=UIObject.get(self,2)
self.leftPanel=UIObject.get(self,3)
self.monthImage=UIImage.get(self,4)
self.progressBar=UIImage.get(self,5)
self.progressTipsText=UIText.get(self,6)
self.progress=UIImage.get(self,7)
self.progressCount=UIText.get(self,8)
self.getRewardBtn=UIButton.get(self,9)
self.getRewardBtnText=UIText.get(self,10)
self.gubaoClick=UIButton.get(self,11)

self.getRewardBtn:setButtonClick(function()self:onGetRewardBtn()end)



end


function UIDailySignInWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.gubaoImage);self.gubaoImage=nil;
_UIObject_release(self.gubaoName);self.gubaoName=nil;
_UIObject_release(self.signInScroller);self.signInScroller=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.monthImage);self.monthImage=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressTipsText);self.progressTipsText=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.progressCount);self.progressCount=nil;
_UIObject_release(self.getRewardBtn);self.getRewardBtn=nil;
_UIObject_release(self.getRewardBtnText);self.getRewardBtnText=nil;
_UIObject_release(self.gubaoClick);self.gubaoClick=nil;
end




local _this=nil















function UIDailySignInWin:onLoaded(...)
_this=self
self:bindComponents()
local _onClickSignInItem=function(...)
self:onClickSignInItem(...)
end
local _onClickSignInItem_longTouch=function(...)
self:onClickSignInItem_longTouch(...)
end

self.signInScroller:setChildScrollViewInit(0,true,_onClickSignInItem,_onClickSignInItem_longTouch)
end


function UIDailySignInWin:__delete()
self:doLocalMoveY(false)
_this=nil
self:unbindComponents()
end




function UIDailySignInWin:onShow(argtable,afterOnloaded)
self:refresh()
end


function UIDailySignInWin:onHide()
self:doLocalMoveY(false)
end


function UIDailySignInWin:onShowArgRecv()
self:refresh()
end



function UIDailySignInWin:onClickSignInItem(clickCount,index)

local clickItemIndex=index+1
if clickItemIndex<=self.signInData.gotRewardListLen then

self:onClickSignInItem_longTouch(clickCount,index)
elseif clickItemIndex>self.signInData.gotRewardListLen and clickItemIndex<=self.signInData.signInDayCount then
if self.signInData.gotRewardListLen<self.signInData.signInDayCount then
welfareController:reqDailySignInGetReward()
else

self:onClickSignInItem_longTouch(clickCount,index)
end
elseif clickItemIndex>self.signInData.signInDayCount then
UIManager.error('未达到签到天数')
self:onClickSignInItem_longTouch(clickCount,index)
end
end

function UIDailySignInWin:onClickSignInItem_longTouch(clickCount,index)

local targetReward=self.allRewardList
local itemData=targetReward[index+1]
local itemid=itemData[1]
tipsManager.showTips({itemid=itemid,itemguid=nil})
end

function UIDailySignInWin:refreshSignInList()
local targetReward=self.allRewardList
self.signInScroller:setChildScrollViewCreateGrids(#targetReward,7)

local grids=self.signInScroller:getChildScrollViewItemWidgets()

for i=1,self.dayCount do
local item=grids[i-1]
local itemData=targetReward[i]
if item and itemData then
local itemid=itemData[1]
local count=itemData[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local isSignIn=i<=self.signInData.signInDayCount and i>self.signInData.gotRewardListLen


item:SetChildActive(3,isSignIn)

local isGot=i<=self.signInData.gotRewardListLen

item:SetChildActive(2,isGot)

local conf
if isGot then

conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=1}
else
conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG}
end

local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)




item:SetChildText(1,FMT.fmt('{0}',i))
end
end
end

function UIDailySignInWin:refresh()
self.signInData=welfareModel:getDailySignInData()
if not self.signInData or next(self.signInData)==nil then
welfareController:reqDailySignInData()
return
end
self.signInCfg=cfgHelper.get1(cfg_everydayqiandaoconfig_get,self.signInData.roundId)
self.leijiCfg=cfgHelper.get1(cfg_everydayqiandaoleijiconfig_get,self.signInData.leijiConfId)


local y,m,d=timeHelper.getServerData()
self.dayCount=timeHelper.getMaxDayByMonth(y,m)
self.month=tonumber(m)

local monthImageName=FMT.fmt("image_fulirilisz_{0}",self.month)
self.monthImage:setCSImageSprite("ui/windows/welfare/sharedtextures/dailysignin.ab",monthImageName)


self.allRewardList=welfareModel:getDailySignInRewardByDayRange(1,self.dayCount)

self:refreshSignInList()

self:refreshLeftPanel()
end

function UIDailySignInWin:refreshLeftPanel()
local targetDayCount=self.leijiCfg.rewards[1]
local canGetGubao=self.signInData.leijiDay>=targetDayCount
local isGot=self.signInData.leijiRewardFlag==1



local gubaoItem=nil
if isGot then

local round=self.signInData.leijiConfId+1
local leijiCfg=cfg_everydayqiandaoleijiconfig()
if round>#leijiCfg then
round=1
end
gubaoItem=leijiCfg[round].gubao
targetDayCount=leijiCfg[round].rewards[1]
else
gubaoItem=self.leijiCfg.gubao
end

if gubaoItem and next(gubaoItem)then

self.leftPanel:setActive(true)

self:doLocalMoveY(true)
else

self.leftPanel:setActive(false)

self:doLocalMoveY(false)
return
end

local itemId=gubaoItem[1]

local gbId=gubaoLookup:good2GuBao(itemId)
local gbCfg=cfgHelper.get1(cfg_gubaoconfig_get,gbId)


self.gubaoImage:setImageIcon(gubaoModel:getGuBaoBigIconName(gbCfg.icon),true)


self.gubaoClick:setButtonClick(function()self:onClickGubaoImage(itemId)end)


self.gubaoName:setText(gbCfg.name)


if not canGetGubao or isGot then

self.progressBar:setActive(true)

self.getRewardBtn:setActive(false)

local leijiDay=isGot and 0 or self.signInData.leijiDay
local progressPercent=leijiDay/targetDayCount
self.progress:setChildIconFillAmount(progressPercent)
local tmpDayCount=leijiDay>targetDayCount and targetDayCount or leijiDay
self.progressCount:setText(FMT.fmt("{0}/{1}",tmpDayCount,targetDayCount))


local progressTipsStr=FMT.fmt("累计签到 <color=#ca631d>{0}</color> 天可领取",targetDayCount)
self.progressTipsText:setText(progressTipsStr)
else

self.progressBar:setActive(false)

self.getRewardBtn:setActive(true)


self.getRewardBtn:setImageExGray(isGot)

local btnStr=isGot and"已领取"or"领取"
self.getRewardBtnText:setText(btnStr)
end


end


function UIDailySignInWin:doLocalMoveY(isFloat)
if isFloat then
if self.floatTweener==nil then
self.gubaoImage:setLocalPosY(0)
local tweener=self.gubaoImage:setChildDOLocalMoveY(30.0,1.5)
tweener:SetEase(_Ease.InOutSine)
tweener:SetLoops(-1,_LoopType.Yoyo)
self.floatTweener=tweener
end
else
if self.floatTweener~=nil then
self.floatTweener:Complete()
self.floatTweener:Kill()
self.floatTweener=nil
self.gubaoImage:setLocalPosY(0)
end
end
end



function UIDailySignInWin:onGetRewardBtn()
if self.signInData.leijiRewardFlag==1 then
UIManager.error("您已领取过该奖励")
return
end


welfareController:reqDailySignInGetLeiJiReward()
end


function UIDailySignInWin:onClickGubaoImage(itemid)
gubaoController:gubaoShowTips(itemid)
end