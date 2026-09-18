







def_class("UIChangBaoActivityWin",UIWindowBase)









function UIChangBaoActivityWin:bindComponents()

self.root=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.bgmodel=UIObject.get(self,2)
self.back=UIButton.get(self,3)
self.bgmodel2=UIObject.get(self,4)
self.bgmodel3=UIObject.get(self,5)
self.desc=UIText.get(self,6)
self.rewardScrollView=UIObject.get(self,7)
self.getbtn=UIButton.get(self,8)
self.djstime=UIText.get(self,9)
self.npcModel=UIObject.get(self,10)
self.speakObj=UIObject.get(self,11)
self.speakText=UIText.get(self,12)
self.ziti1=UIText.get(self,13)
self.ziti2=UIText.get(self,14)
self.ziti3=UIText.get(self,15)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.back:setButtonClick(function()self:onBack()end)

self.getbtn:setButtonClick(function()self:onGetbtn()end)



end


function UIChangBaoActivityWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.bgmodel);self.bgmodel=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.bgmodel2);self.bgmodel2=nil;
_UIObject_release(self.bgmodel3);self.bgmodel3=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.getbtn);self.getbtn=nil;
_UIObject_release(self.djstime);self.djstime=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.ziti1);self.ziti1=nil;
_UIObject_release(self.ziti2);self.ziti2=nil;
_UIObject_release(self.ziti3);self.ziti3=nil;
end















local dayitem=
{
selitem=0,
btn=1,
txt=2,
chooseimg=3,
reddot=4,
}
local _this
local abname2="ui/windows/firstrecharge/firstrecharge_atlas_pak.ab"




function UIChangBaoActivityWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIChangBaoActivityWin:__delete()
self:unbindComponents()
self:cleartimes()
_this=nil
end

function UIChangBaoActivityWin:cleartimes()
if self.refreshTimeIdshop then
self:stopTimerByID(self.refreshTimeIdshop)
self.refreshTimeIdshop=nil
end
if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
if self.talkTween2~=nil then
self.talkTween2:Kill()
self.talkTween2=nil
end
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
end


function UIChangBaoActivityWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then return end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eCenter})
end

function UIChangBaoActivityWin:onGetbtn()
local isCanGetGift=FreeGiftController.GetFreeGift(self.libaoid)
if not isCanGetGift then
UIManager.info("已领取")
return
end

local api=self.nowapi
local checkapi=self.checkapi


if api<checkapi then
UIManager.info("请祖师更到最新版本")
return
end


FreeGiftController.SendFreeGift(self.libaoid,nil,function()
if _this==nil then return end

ChangeActController:freshReddot()
reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
_this.winlua:SetChildGray(_this.getbtn:getID(),true)
end)
end




function UIChangBaoActivityWin:onShow(argtable,afterOnloaded)
self.bgmodel:setChildUIModelShowTarget(6473,1,nil,eAnimationID.stand)
local versionId=pfwindowslController:getGameVersion()
self.config=cfg_huanbaozhiyinconfig_get(versionId)
self.libaoid=self.config.freelsit
self.checkapi=self.config.checkapi
self.nowapi=deviceHelper.getAPILevel()

self:freshdata()

local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eHanBaoZhiYin)
if not flag then
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eHanBaoZhiYin,true)
end
reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end


function UIChangBaoActivityWin:onHide()

end

function UIChangBaoActivityWin:onCloseBtn()
end
function UIChangBaoActivityWin:onBack()
end


function UIChangBaoActivityWin:freshdata()

local desc=self.config.desc
if desc then
self.ziti1:setText(desc[1]or"")
self.ziti2:setText(desc[2]or"")
self.ziti3:setText(desc[3]or"")
end


local freeCfg=cfg_freegiftconfig_get(self.libaoid)
local rewardList=freeCfg.rewards
self:freshRewards(rewardList)




self:setbtngray()


self:djstimespanel()
end

function UIChangBaoActivityWin:freshRewards(rewardList)

if rewardList then
local len=#rewardList
self.rewardScrollView:setChildScrollViewCreateGrids(len,len)
local reward_grids=self.rewardScrollView:getChildScrollViewItemWidgets()
for j=1,len do
local reward=rewardList[j]
local itemid=reward[1]
local count=reward[2]
local widget2=reward_grids[j-1]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget2:SetChildActive(-1,true)
widget2:SetChildPropData(0,prop)
widget2:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end
end

function UIChangBaoActivityWin:setbtngray()
local isCanGetGift=FreeGiftController.GetFreeGift(self.libaoid)
local api=self.nowapi
local checkapi=self.checkapi
if isCanGetGift and api>=checkapi then
self.winlua:SetChildGray(self.getbtn:getID(),false)
else
self.winlua:SetChildGray(self.getbtn:getID(),true)
end
end


function UIChangBaoActivityWin:refreshShopModel()
local cfg_npcmodelid=2113025
self.npcModel:setChildUIModelShowTarget(cfg_npcmodelid,0.7,{},eAnimationID.stand,false,true)
self.npcModel:setChildUIModelShowFlipX(true)
end

function UIChangBaoActivityWin:refreshShopbubble()
if self.refreshTimeIdshop then
self:stopTimerByID(self.refreshTimeIdshop)
self.refreshTimeIdshop=nil
end
local func=function()
self:doSpeaking_player()
end
func()
local shoptime=8
self.refreshTimeIdshop=self:setTimer(shoptime,0,func)
end

function UIChangBaoActivityWin:doSpeaking_player()
local speakList=self.config.speakList
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self:doTalkAnim_player()
end

function UIChangBaoActivityWin:doTalkAnim_player()
if _this.talkTween2~=nil then
_this.talkTween2:Kill()
_this.talkTween2=nil
end
_this.speakObj:setScale(Vector3.zero)
_this:delayDo(0.2,function()
_this.speakObj:setChildCanvasGroupAlpha(1)
_this.talkTween2=_this.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween2=nil
_this.talkTween2=_this.speakObj:setChildDOScale(0.9,0.1,function()
if _this==nil then return end
_this.talkTween2=nil
return _this:talkEnd()
end)
end)
end)
end
function UIChangBaoActivityWin:talkEnd()
if _this.speakShowTimer then
_this:stopTimerByID(_this.speakShowTimer)
_this.speakShowTimer=nil
end
_this.speakShowTimer=_this:delayDo(3.5,function()

if _this==nil then return end
_this.speakObj:setScale(Vector3.zero)
_this.speakObj:setChildCanvasGroupAlpha(0)
if _this.speakShowTimer then
_this:stopTimerByID(_this.speakShowTimer)
_this.speakShowTimer=nil
end
end)
end

function UIChangBaoActivityWin:djstimespanel()
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
local endStamp
local condition=self.config.condition
for k,v in ipairs(condition)do
local type=v[1]
if type==3 then
endStamp=timeHelper.getDateStamp(v[3])
end
end
if endStamp then
local endtime=timeHelper.convertShortStamp(endStamp)
self.leftTimer=self:setTimer(1,-1,function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=endtime-nowTime
if lerp>0 then
self.djstime:setText(FMT.fmt("剩余时间：{0}",timeHelper.format_time_stamp3(lerp)))
else
self.djstime:setText("已结束")
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
end
end)
end
end


function UIChangBaoActivityWin:testttt()
local api=_this.nowapi
local checkapi=_this.checkapi
local str=FMT.fmt('当前客户端版本等级：{0}，配置表版本等级：{1}',api,checkapi)
UIManager.info(str)
end
function UIChangBaoActivityWin:testttt2(_api)
UIManager.info(FMT.fmt('更改客户端当前版本等级：{0}',_api))
_this.nowapi=_api
_this:setbtngray()
end


