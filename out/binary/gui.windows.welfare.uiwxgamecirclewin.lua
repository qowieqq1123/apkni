







def_class("UIWXGameCircleWin",UIWindowBase)









function UIWXGameCircleWin:bindComponents()

self.biaoyu=UIObject.get(self,0)
self.biaoyu1=UIObject.get(self,1)
self.dzModel=UIObject.get(self,2)
self.fbg=UIObject.get(self,3)
self.freeReward=UIButton.get(self,4)
self.freeRewardReddot=UIObject.get(self,5)
self.gotoText=UIText.get(self,6)
self.gotoWXBtn=UIButton.get(self,7)
self.itemListRoot=UIObject.get(self,8)
self.Root=UIObject.get(self,9)
self.taskroot=UIObject.get(self,10)
self.TipsBtn=UIButton.get(self,11)
self.title=UIObject.get(self,12)
self.titleTxt=UIText.get(self,13)
self.wxgameTaskItem_1=UIObject.get(self,14)
self.wxgameTaskItem_2=UIObject.get(self,15)
self.wxgameTaskItem_3=UIObject.get(self,16)
self.wxgameTaskItem_4=UIObject.get(self,17)
self.wxgameTaskItem_5=UIObject.get(self,18)
self.wxgameTaskItem_6=UIObject.get(self,19)
self.yun=UIObject.get(self,20)

self.freeReward:setButtonClick(function()self:onFreeReward()end)

self.gotoWXBtn:setButtonClick(function()self:onGotoWXBtn()end)

self.TipsBtn:setButtonClick(function()self:onTipsBtn()end)
self.wxgameTaskItem={
self.wxgameTaskItem_1,
self.wxgameTaskItem_2,
self.wxgameTaskItem_3,
self.wxgameTaskItem_4,
self.wxgameTaskItem_5,
self.wxgameTaskItem_6,
}



end


function UIWXGameCircleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.biaoyu);self.biaoyu=nil;
_UIObject_release(self.biaoyu1);self.biaoyu1=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.fbg);self.fbg=nil;
_UIObject_release(self.freeReward);self.freeReward=nil;
_UIObject_release(self.freeRewardReddot);self.freeRewardReddot=nil;
_UIObject_release(self.gotoText);self.gotoText=nil;
_UIObject_release(self.gotoWXBtn);self.gotoWXBtn=nil;
_UIObject_release(self.itemListRoot);self.itemListRoot=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.taskroot);self.taskroot=nil;
_UIObject_release(self.TipsBtn);self.TipsBtn=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.wxgameTaskItem_1);self.wxgameTaskItem_1=nil;
_UIObject_release(self.wxgameTaskItem_2);self.wxgameTaskItem_2=nil;
_UIObject_release(self.wxgameTaskItem_3);self.wxgameTaskItem_3=nil;
_UIObject_release(self.wxgameTaskItem_4);self.wxgameTaskItem_4=nil;
_UIObject_release(self.wxgameTaskItem_5);self.wxgameTaskItem_5=nil;
_UIObject_release(self.wxgameTaskItem_6);self.wxgameTaskItem_6=nil;
_UIObject_release(self.yun);self.yun=nil;
self.wxgameTaskItem=nil;
end


















local taskItemIndex={
day=0,
subItemList={1,2},
bg=3,
recvFlag=4,
reddot=5,
}

local RecvFlag=
{
eNotRecv=0,
eRecv=1,
eRecved=2,
}

local _this

function UIWXGameCircleWin:onLoaded(...)
_this=self
self:bindComponents()
self.fbg:setChildUIModelShowTarget(5393,1,{},eAnimationID.stand)
self.yun:setChildUIModelShowTarget(5394,1,{},eAnimationID.stand)
local diziid=3005
local dizidata=UIDiscipleModel:getDiscipleDataByDiziId(diziid)
local imageInfo=dizidata.imageInfo
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo)
self.dzModel:setChildUIModelShowTarget(modelParams.body,0.95,modelParams.componets,0)
if webGLHelper:isRunWeiXin()or webGLHelper:isRunAlipayMiniGame()then
if deviceHelper.getAPILevel()<66 then
self.gotoWXBtn:setActive(false)
return
end
notifySystem:listenNotify(notifyConfig.onWeiXinClubButtonClick,self.WeiXinClubButtonClick)
self.clubButtonId=webGLHelper:createClubButton(self.gotoWXBtn:getTransform())
self.clubButtonFlag=true
elseif welfareModel:getWXGameCircleIsDouYin()then




self.gotoText:setText("前往小游戏站")
end

welfareModel:setWXGameCircle_openWinTime(timeHelper.getServerShortTime())
reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end


function UIWXGameCircleWin:__delete()
self:unbindComponents()
if webGLHelper:isRunWeiXin()then
if self.clubButtonId then
notifySystem:removelistener(notifyConfig.onWeiXinClubButtonClick,self.WeiXinClubButtonClick)
webGLHelper:destroyClubButton(self.clubButtonId)
self.clubButtonFlag=false
end
end
_this=nil
end




function UIWXGameCircleWin:onShow(argtable,afterOnloaded)
self:refresh()
end


function UIWXGameCircleWin:onHide()
if(webGLHelper:isRunWeiXin())and self.clubButtonId and self.clubButtonFlag then
webGLHelper:showClubButton(self.clubButtonId,false)

self.clubButtonFlag=false
end
end

function UIWXGameCircleWin:onShowArgRecv()
if(webGLHelper:isRunWeiXin())and self.clubButtonId and not self.clubButtonFlag then
webGLHelper:showClubButton(self.clubButtonId,true)

self.clubButtonFlag=true
end
end

function UIWXGameCircleWin:refresh()
self:refreshBtn()
self:refreshTitle()
self:refreshTaskItemList()
end

function UIWXGameCircleWin:refreshBtn()
local freeReddot=welfareModel:checkWXGameCircleReddot_FreeReward()
self.freeReward:setActive(freeReddot)
end

function UIWXGameCircleWin:refreshTitle()
local signday=welfareModel:getWXGameCircle_SignDay()
self.titleTxt:setText(string.format("当前累计签到：%s天",signday))
end

function UIWXGameCircleWin:refreshTaskItemList()
local round=welfareModel:getWXGameCircle_Round()
local roundCfg=self:getRoundCfg(round)
for i,v in ipairs(self.wxgameTaskItem)do
if roundCfg[i]then
v:setActive(true)
local widget=v:getWidgetBase()
self:setTaskItem(i,widget,roundCfg[i])
else
v:setActive(false)
end
end
end

function UIWXGameCircleWin:setTaskItem(i,widget,data)
widget:SetChildText(taskItemIndex.day,string.format("签到%s天",data.day))
local state=self:checkRecvFlag(data)
widget:SetChildActive(taskItemIndex.bg,state==RecvFlag.eRecved)
widget:SetChildActive(taskItemIndex.recvFlag,state==RecvFlag.eRecved)
widget:SetChildActive(taskItemIndex.reddot,state==RecvFlag.eRecv)
widget:SetClickerEvent("click",nil,function()
self:onClick(i,data)
end,nil,nil)

local reward=data.reward
for i,v in ipairs(taskItemIndex.subItemList)do
local itemCfg=reward[i]
if itemCfg then
widget:SetChildActive(v,true)
local conf={
itemid=itemCfg[1],
itemcount=itemCfg[2]<=1 and''or itemCfg[2],
showname=false,
showCountBG=itemCfg[2]>1,
gray=state==RecvFlag.eRecved and 3 or 0,
showStage=true,
}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetActive,11)]=false






prop[PropIndex(DataPropKey.eWidgetActive,12)]=false
widget:SetChildPropData(v,prop)
widget:SetBaseItemClickEvent(v,function(...)
self:onClickSmallItem(data,...)
end)
else
widget:SetChildActive(v,false)
end

end
end

function UIWXGameCircleWin:checkRecvFlag(data)
local idx=data.idx
if welfareModel:checkWXGameCircleRecvFlag(idx)then
return RecvFlag.eRecved
end
local signday=welfareModel:getWXGameCircle_SignDay()
return data.day<=signday and RecvFlag.eRecv or RecvFlag.eNotRecv
end

function UIWXGameCircleWin:onClickSmallItem(data,itemId,index,guid,attach)
if itemId==-1 then
return
end
local state=self:checkRecvFlag(data)
if state==RecvFlag.eRecv then
welfareController:reqWXGameCircleReward(data.idx)
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight})
end

function UIWXGameCircleWin:onClick(index,data)
local state=self:checkRecvFlag(data)
if state==RecvFlag.eRecv then
welfareController:reqWXGameCircleReward(data.idx)
return
end
end

function UIWXGameCircleWin:getRoundCfg(curRound)














local cfg=cfg_wechatgameconfig()
return cfg[curRound]
end





function UIWXGameCircleWin:onFreeReward()
local giftId=cfgHelper.get2(cfg_wechatgamebaseconfig_get,1,'giftId')
FreeGiftController.SendFreeGift(giftId,nil,function(result)
if result then
UIManager:invokeUIMethod("UIWXGameCircleWin","refreshBtn")

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end
end)
end



function UIWXGameCircleWin:onGotoWXBtn()
if welfareModel:getWXGameCircleIsDouYin()then
webGLHelper:reportDYToMini()
end
if webGLHelper:isRunWeiXin()or webGLHelper:isRunAlipayMiniGame()then
return
end
if welfareModel:getWXGameCircle_Today()==0 then
welfareController:reqWXGameCircleSignIn()
end
end

function UIWXGameCircleWin.WeiXinClubButtonClick(id)
if id==_this.clubButtonId then
if welfareModel:getWXGameCircle_Today()==0 then
welfareController:reqWXGameCircleSignIn()
end
end
end



function UIWXGameCircleWin:onTipsBtn()
local d={}
d.title='说明'
d.mode=3
if welfareModel:getWXGameCircleIsDouYin()then
d.name='dygame_%d'
else
d.name='wxgame_%d'
end
UIManager:showWindow('UIRuleWin',d)
end

