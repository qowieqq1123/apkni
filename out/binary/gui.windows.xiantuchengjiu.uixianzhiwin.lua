







def_class("UIXianZhiWin",UIWindowBase)









function UIXianZhiWin:bindComponents()

self.beishiSpine=UIObject.get(self,0)
self.bgSpine=UIObject.get(self,1)
self.bgSpine2=UIObject.get(self,2)
self.clickXianBaoBtn=UIButton.get(self,3)
self.closeTipsButton=UIButton.get(self,4)
self.expBar=UIObject.get(self,5)
self.expInfo=UIText.get(self,6)
self.expProgress=UIObject.get(self,7)
self.expRoot=UIObject.get(self,8)
self.fullLevelImg=UIObject.get(self,9)
self.getExpBtn=UIButton.get(self,10)
self.levelRoot=UIObject.get(self,11)
self.levelStarList=UIObject.get(self,12)
self.levelTxt=UIText.get(self,13)
self.model=UIObject.get(self,14)
self.modelRoot=UIObject.get(self,15)
self.notHaveReward=UIText.get(self,16)
self.privilegeBtn=UIButton.get(self,17)
self.privilegeReddot=UIObject.get(self,18)
self.privilegeTips=UIText.get(self,19)
self.returnBtnReddot=UIObject.get(self,20)
self.returnXianTuBtn=UIButton.get(self,21)
self.reviewShareBtn=UIButton.get(self,22)
self.reviewShareReddot=UIObject.get(self,23)
self.rewardTips=UIObject.get(self,24)
self.ruleBtn=UIButton.get(self,25)
self.shield=UIObject.get(self,26)
self.speXianBaoModel=UIObject.get(self,27)
self.speXianBaoRoot=UIObject.get(self,28)
self.uiRoot=UIObject.get(self,29)
self.upLevelBtn=UIButton.get(self,30)
self.xgReddot=UIObject.get(self,31)
self.xgRewardBtn=UIButton.get(self,32)
self.xianbaoReddot=UIObject.get(self,33)
self.xianfengReceiveBtn=UIButton.get(self,34)
self.xianfengReceiveImg=UIObject.get(self,35)
self.xianfengReddot=UIObject.get(self,36)
self.xianFengRoot=UIObject.get(self,37)
self.xianguanFengLuDesc=UILinkImageText.get(self,38)
self.xianguanFengluList=UIObject.get(self,39)
self.xianzhiFengluDesc=UILinkImageText.get(self,40)
self.xianzhiFengluList=UIObject.get(self,41)

self.clickXianBaoBtn:setButtonClick(function()self:onClickXianBaoBtn()end)

self.closeTipsButton:setButtonClick(function()self:onCloseTipsButton()end)

self.getExpBtn:setButtonClick(function()self:onGetExpBtn()end)

self.privilegeBtn:setButtonClick(function()self:onPrivilegeBtn()end)

self.returnXianTuBtn:setButtonClick(function()self:onReturnXianTuBtn()end)

self.reviewShareBtn:setButtonClick(function()self:onReviewShareBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.upLevelBtn:setButtonClick(function()self:onUpLevelBtn()end)

self.xgRewardBtn:setButtonClick(function()self:onXgRewardBtn()end)

self.xianfengReceiveBtn:setButtonClick(function()self:onXianfengReceiveBtn()end)



end


function UIXianZhiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.beishiSpine);self.beishiSpine=nil;
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.bgSpine2);self.bgSpine2=nil;
_UIObject_release(self.clickXianBaoBtn);self.clickXianBaoBtn=nil;
_UIObject_release(self.closeTipsButton);self.closeTipsButton=nil;
_UIObject_release(self.expBar);self.expBar=nil;
_UIObject_release(self.expInfo);self.expInfo=nil;
_UIObject_release(self.expProgress);self.expProgress=nil;
_UIObject_release(self.expRoot);self.expRoot=nil;
_UIObject_release(self.fullLevelImg);self.fullLevelImg=nil;
_UIObject_release(self.getExpBtn);self.getExpBtn=nil;
_UIObject_release(self.levelRoot);self.levelRoot=nil;
_UIObject_release(self.levelStarList);self.levelStarList=nil;
_UIObject_release(self.levelTxt);self.levelTxt=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
_UIObject_release(self.notHaveReward);self.notHaveReward=nil;
_UIObject_release(self.privilegeBtn);self.privilegeBtn=nil;
_UIObject_release(self.privilegeReddot);self.privilegeReddot=nil;
_UIObject_release(self.privilegeTips);self.privilegeTips=nil;
_UIObject_release(self.returnBtnReddot);self.returnBtnReddot=nil;
_UIObject_release(self.returnXianTuBtn);self.returnXianTuBtn=nil;
_UIObject_release(self.reviewShareBtn);self.reviewShareBtn=nil;
_UIObject_release(self.reviewShareReddot);self.reviewShareReddot=nil;
_UIObject_release(self.rewardTips);self.rewardTips=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.shield);self.shield=nil;
_UIObject_release(self.speXianBaoModel);self.speXianBaoModel=nil;
_UIObject_release(self.speXianBaoRoot);self.speXianBaoRoot=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.upLevelBtn);self.upLevelBtn=nil;
_UIObject_release(self.xgReddot);self.xgReddot=nil;
_UIObject_release(self.xgRewardBtn);self.xgRewardBtn=nil;
_UIObject_release(self.xianbaoReddot);self.xianbaoReddot=nil;
_UIObject_release(self.xianfengReceiveBtn);self.xianfengReceiveBtn=nil;
_UIObject_release(self.xianfengReceiveImg);self.xianfengReceiveImg=nil;
_UIObject_release(self.xianfengReddot);self.xianfengReddot=nil;
_UIObject_release(self.xianFengRoot);self.xianFengRoot=nil;
_UIObject_release(self.xianguanFengLuDesc);self.xianguanFengLuDesc=nil;
_UIObject_release(self.xianguanFengluList);self.xianguanFengluList=nil;
_UIObject_release(self.xianzhiFengluDesc);self.xianzhiFengluDesc=nil;
_UIObject_release(self.xianzhiFengluList);self.xianzhiFengluList=nil;
end
















local _this




function UIXianZhiWin:onLoaded(...)
self:bindComponents()

_this=self

self:addNotify(notifyConfig.onXianZhiLevelChange,function()
if _this==nil then return end
_this:onXianZhiLevelChange()
end)
self:addNotify(notifyConfig.onXianZhiXianBaoLevelChange,function()
if _this==nil then return end
_this:onXianZhiXianBaoLevelChange()
end)
self:addNotify(notifyConfig.onXianZhiTaskStateChange,function()
if _this==nil then return end
_this:onXianZhiTaskStateChange()
end)
self:addNotify(notifyConfig.on_money_changed,function(...)
if _this==nil then return end
_this:on_money_changed(...)
end)

self:addNotify(notifyConfig.onTeQuanInfoChange,function()
if _this==nil then return end
_this:refreshXianGuanTeQuanBtn()
end)

self:addNotify(notifyConfig.onTeQuanInfoReset,function()
if _this==nil then return end
_this:refreshXianGuanTeQuanBtn()
end)

self.oldEffectId=0

if JiuChongTianJieEnterController.checkCanShare()then
xiantuchengjiuController.send_30_5()
rankListController:req_rankList_data(eRankListType.eDuJieFeiSheng)
end

self:addProNotify(37,45,function()
if _this==nil then return end
_this.xianfengReddot:setActive(false)
end)
end


function UIXianZhiWin:__delete()

if self.expDt then
self.expDt:Complete()
self.expDt:Kill()
self.expDt=nil
end

if self.xianbaoReddotTween then
self.xianbaoReddotTween:Complete()
self.xianbaoReddotTween:Kill()
self.xianbaoReddotTween=nil
end

if self.shareReddotTween then
self.shareReddotTween:Complete()
self.shareReddotTween:Kill()
self.shareReddotTween=nil
end

_this=nil

self:unbindComponents()
end




function UIXianZhiWin:onShow(argtable,afterOnloaded)
local isOpenXianBaoPanel=argtable and argtable.isOpenXianBaoPanel

self:refreshAll()

self.bgSpine:setChildUIModelShowTarget(5549,1,nil,eAnimationID.stand)
self.bgSpine2:setChildUIModelShowTarget(5589,1,nil,eAnimationID.stand)

self.rewardTips:setActive(false)

if isOpenXianBaoPanel then
self:onClickXianBaoBtn()
end
end


function UIXianZhiWin:onHide()

end

function UIXianZhiWin:refreshAll()

self:refreshMainInfo()

self:refreshXianFeng()

self:refreshBtns()
end


function UIXianZhiWin:refreshMainInfo()
self.mainInfo=xianzhiModel:getMainInfo()



self:freshLevelInfo()


self:freshModelInfo()


self:freshExpInfo()
end

function UIXianZhiWin:freshLevelInfo()
local jctian=self.mainInfo.cfg.jctian
local star=self.mainInfo.cfg.star
local totalStar=self.mainInfo.totalStar

local levelStr=FMT.fmt("仙职：{0}重天",mathHelper.numberToChinese(jctian))
self.levelTxt:setText(levelStr)


local cfunc=function(index)
local item=self.levelStarList:getChildLayoutGroupGridItem(index-1)

local isShow=index<=totalStar
item:SetChildActive(-1,isShow)
if isShow then
local isActive=star>=index
item:SetChildActive(0,isActive)
end
end
self.levelStarList:setChildLayoutGroupCreateItems(totalStar,cfunc)
end

function UIXianZhiWin:freshModelInfo()
self.playerImage=playerImageModel:getPlayerImage()



local playerImage=playerImageModel:getPlayerImage()
local sex=playerModel:getActorSex()
local selectindex=sex==1 and 1 or 2
playerImage[PLAYER_IMAGE_TYPE.eBodyOrnament]=self.mainInfo.cfg.showBeiShi[selectindex]
for k,v in pairs(PLAYER_IMAGE_TYPE)do
if playerImage[v]==nil then
playerImage[v]=playerImageConfig.getDefaultImage(v,sex)
end
end


comHelper.setChildPlayerImage(self.winlua,self.model:getID(),playerImage,sex,1,eAnimationID.idle,0,0,playerController:supportDynamic())




local effectid=xianzhiConfig.getXianZhiXianBaoModelInfo()
if effectid~=self.oldEffectId then
self.speXianBaoModel:setChildShowEffect(effectid,true)
self.oldEffectId=effectid
self.speXianBaoModel:setScale(Vector3.zero)
self:delayDo(0.2,function()
if _this==nil then return end
_this.speXianBaoModel:setScale(Vector3(0.75,0.75,0.75))
end)
end

local isReddot=xianzhiModel:checkXianBaoReddot()
self.xianbaoReddot:setActive(isReddot)
if isReddot then
if self.xianbaoReddotTween then
self.xianbaoReddotTween:Complete()
self.xianbaoReddotTween:Kill()
self.xianbaoReddotTween=nil
end

self.xianbaoReddot:setRotation(0,0,0)
self.xianbaoReddotTween=self.winlua:SetChildDOPunchRotation(self.xianbaoReddot:getID(),Vector3(0,0,15),2,2,1)
self.xianbaoReddotTween:SetEase(_Ease.Linear)
self.xianbaoReddotTween:SetLoops(-1,_LoopType.Restart)
end
end

function UIXianZhiWin:freshExpInfo(isShowAni)
local isXzFull=xianzhiModel:checkXzFull()
self.expRoot:setActive(not isXzFull)
self.fullLevelImg:setActive(isXzFull)
if isXzFull then
return
end

if self.expDt then
self.expDt:Complete()
self.expDt:Kill()
self.expDt=nil
end

local hasNum=itemsModel.getCount(self.mainInfo.cfg.exp[1])
local needNum=self.mainInfo.cfg.exp[2]

local isCanUp=hasNum>=needNum

local expInfoStr=FMT.fmt("{0}/{1}",hasNum,needNum)

self.expInfo:setText(expInfoStr)

if isShowAni then
local newAmount=hasNum/needNum
self.expDt=self.expBar:setChildImageDOFillAmount(newAmount,0.2)
else
self.expBar:setChildIconFillAmount(hasNum/needNum)
end

self.upLevelBtn:setActive(isCanUp)
self.getExpBtn:setActive(not isCanUp)
end


function UIXianZhiWin:refreshXianFeng()
local isHasReddot=xianzhiModel:checkCanReceiveDayXianFeng()
local isReceived=xianzhiModel:checkReceivedDayXianFeng()
self.xianfengReceiveImg:setActive(false)
self.xianfengReddot:setActive(not isReceived and isHasReddot)
self.xianfengReceiveBtn:setActive(true)


local xzid=xianzhiModel:getXianZhiId()
local cfg=cfgHelper.get1(cfg_xianzhiconfig_get,xzid)

local rate=1

local flLen
local fengluData
local list

local createFunc=function(index)
local item=list:getChildLayoutGroupGridItem(index-1)

local data=fengluData[index]

local itemid=data[1]
local itemnum=data[2]

local rateNum=Mathf.Floor(rate*itemnum)

local numStr=mathHelper.formatNumber4(rateNum,2)

local iconName=iconHelper.getIconName(itemid)
item:SetChildIcon(0,iconName,false)

item:SetChildText(1,numStr)

item:SetBaseItemClickEvent(-1,function()
itemsComponentHelper.onItemClick(itemid)
end)
end

rate=1+xianzhiController.getGBSKil_XianZhiWagesRate()/100
local moneyUpRate=gubaoModel:getGBSkil_MoneyUpRate(0,eMoneyType.mtXianFeng)
local gubaoRate=(1+moneyUpRate/100)
rate=rate*gubaoRate
fengluData=cfg.fenglu
flLen=#cfg.fenglu
list=self.xianzhiFengluList
self.xianzhiFengluList:setChildLayoutGroupCreateItems(flLen,createFunc)


local xzflStr="仙职："
self.xianzhiFengluDesc:setText(xzflStr)


rate=1
list=self.xianguanFengluList
fengluData=xianguanController.getXianGuanWages()
flLen=#fengluData
self.xianguanFengluList:setChildLayoutGroupCreateItems(flLen,createFunc)
local xgflStr
if flLen==0 then
xgflStr=FMT.fmt("仙官：暂无俸禄")
else
xgflStr=FMT.fmt("仙官：")
end

self.xianguanFengLuDesc:setText(xgflStr)
end


function UIXianZhiWin:refreshBtns()

local isShowXGJJReddot=xianzhiModel:checkXGJJReddot()
self.xgReddot:setActive(isShowXGJJReddot)


local reddot,key1,key2=xiantuchengjiuModel:getZMXTSpecialFlag()
local isShowReturnBtn=key1~=nil
self.returnXianTuBtn:setActive(isShowReturnBtn)
self.returnBtnReddot:setActive(reddot==true)

self:refreshXianGuanTeQuanBtn()

self:refreshReviewShareBtn()
end

function UIXianZhiWin:refreshXianGuanTeQuanBtn()
local isShow=xianguanController.checkHasVoluintaryPrivilege()
self.privilegeBtn:setActive(isShow)
if isShow then
local residuNum,totalNum=xianguanController.getPrivilegeDayNumInfo()
local isReddot=residuNum>0

local tipColor=isReddot and"#a1ec58"or"#f36666"
local numStr=FMT.fmt("{0}/{1}",residuNum,totalNum)
local numTipStr=FMT.fmt("剩余：{0}次",toColorStringX(tipColor,numStr))

self.privilegeTips:setText(numTipStr)
self.privilegeReddot:setActive(xianguanController.getSelfPrivilegeUseReddot())
end
end

function UIXianZhiWin:refreshReviewShareBtn()


local isShow=JiuChongTianJieEnterController.checkCanShare()
self.reviewShareBtn:setActive(isShow)

if isShow then
local shareType=shareImageModel:getShareTypeByWinName(self.window_name)
local isReddot=false
local apiValib=api_Available_CroppingTexture()
local isShowShareBtn=shareImageModel:isOpenShareImage()
if shareType and apiValib and isShowShareBtn then
local canGetNum=shareImageModel:getShareRewardCanGetNumByType(shareType)
isReddot=canGetNum>0
end
self.reviewShareReddot:setActive(isReddot)
if isReddot then
if self.shareReddotTween then
self.shareReddotTween:Complete()
self.shareReddotTween:Kill()
self.shareReddotTween=nil
end

self.reviewShareReddot:setRotation(0,0,0)
self.shareReddotTween=self.winlua:SetChildDOPunchRotation(self.reviewShareReddot:getID(),Vector3(0,0,15),2,2,1)
self.shareReddotTween:SetEase(_Ease.Linear)
self.shareReddotTween:SetLoops(-1,_LoopType.Restart)
end
end

end

function UIXianZhiWin:refreshShareRewardShow()


self:refreshReviewShareBtn()

if JiuChongTianJieEnterModel:getServerLocalizeShare()==0 then
local day=timeHelper.getServerOpenDay_Time(timeHelper.getServerLongTime())
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.ZongMenReviewShare,1,{day})
end
end


function UIXianZhiWin:onXianZhiLevelChange(xzId)
self:refreshAll()
end

function UIXianZhiWin:onXianZhiXianBaoLevelChange()
self:freshModelInfo()
end

function UIXianZhiWin:onXianZhiTaskStateChange()
self:refreshBtns()
end

function UIXianZhiWin:on_money_changed(mtype)
if mtype==eMoneyType.mtDaoXun then
self:freshExpInfo(true)

local isReddot=xianzhiModel:checkXianBaoReddot()
self.xianbaoReddot:setActive(isReddot)
end
end





function UIXianZhiWin:onClickXianBaoBtn()
self:showWindow("UIXianZhiXianBaoWin")
end



function UIXianZhiWin:onGetExpBtn()
gainControl:showGainWin(eMoneyType.mtDaoXun)
end



function UIXianZhiWin:onReturnXianTuBtn()
local openFunc=function()
xianzhiModel:setReturnToZMXTFlag(true)
UIFullXianTuChengJiuControl:showWindow_ZongMenXianTu()

UIManager:invokeUIMethod("UIXTCJForeGroundWin",'refreshMenu')
end
UIFullXianTuChengJiuControl:showWindowByCloud(openFunc)
end



function UIXianZhiWin:onRuleBtn()
local d={}
d.title='规则说明'
d.mode=3
d.name='xianzhi_rule_help_%d'
UIManager:showWindow('UIRuleWin',d)
end



function UIXianZhiWin:onUpLevelBtn()
xianzhiController:reqUpXianZhiLevel()
end



function UIXianZhiWin:onXgRewardBtn()
self:showWindow("UIXianGongJiaJiangWin")
end


function UIXianZhiWin:onXianfengReceiveBtn()


if xianzhiModel:checkReceivedDayXianFeng()then
self.rewardTips:setActive(true)
elseif xianzhiModel:checkCanReceiveDayXianFeng()then
xianzhiController:reqReceiveDayWages()
end
end

function UIXianZhiWin:onCloseTipsButton()


self.rewardTips:setActive(false)
end

function UIXianZhiWin:onPrivilegeBtn()
self:showWindow("UIXianGuanTeQuanWin")
end

function UIXianZhiWin:onReviewShareBtn()
local shareShowType=shareImageModel:getShareShowTypeByWinName(self.window_name)
local param={
disciple_guid=self.dujieDisciple,
}
shareImageController:showShareImageWin(shareShowType,param)
end
