







def_class("UISubAct_TXDTQ_mainWin",UIWindowBase)









function UISubAct_TXDTQ_mainWin:bindComponents()

self.root=UIObject.get(self,0)
self.infoList=UIObject.get(self,1)
self.infomationBtn=UIButton.get(self,2)
self.modelInfo=UIObject.get(self,3)
self.model=UIObject.get(self,4)
self.modelinfo=UIObject.get(self,5)
self.name=UIText.get(self,6)
self.buyBtn=UIButton.get(self,7)
self.buyNum=UIText.get(self,8)
self.rewardroot=UIObject.get(self,9)
self.rewardList=UIScrollView.get(self,10)
self.rewardListContent=UIObject.get(self,11)
self.countdown=UIObject.get(self,12)
self.countdownTxt=UIText.get(self,13)
self.buyState=UIObject.get(self,14)
self.btnspine=UIObject.get(self,15)
self.graybtn=UIButton.get(self,16)

self.infomationBtn:setButtonClick(function()self:onInfomationBtn()end)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)

self.graybtn:setButtonClick(function()self:onGraybtn()end)



end


function UISubAct_TXDTQ_mainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.infoList);self.infoList=nil;
_UIObject_release(self.infomationBtn);self.infomationBtn=nil;
_UIObject_release(self.modelInfo);self.modelInfo=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.modelinfo);self.modelinfo=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.buyNum);self.buyNum=nil;
_UIObject_release(self.rewardroot);self.rewardroot=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardListContent);self.rewardListContent=nil;
_UIObject_release(self.countdown);self.countdown=nil;
_UIObject_release(self.countdownTxt);self.countdownTxt=nil;
_UIObject_release(self.buyState);self.buyState=nil;
_UIObject_release(self.btnspine);self.btnspine=nil;
_UIObject_release(self.graybtn);self.graybtn=nil;
end



















function UISubAct_TXDTQ_mainWin:onLoaded(...)
self:bindComponents()

self:addNotify(notifyConfig.onWanBaoXunBaoDuiUnlockChannel,function(...)self:onWanBaoXunBaoDuiUnlockChannel(...)end)
end


function UISubAct_TXDTQ_mainWin:__delete()
self:unbindComponents()
self:stopSelfTimer()
end




function UISubAct_TXDTQ_mainWin:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eHangDaoTeQuan
self.subid=argtable.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)

self.tqid=self.config.rewards[1][1]
self.tqCfg=cfgHelper.get1(cfg_cattequanconfig_get,self.tqid)

self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
self.startday=self.info.start_day_idx
self.start_time=self.info.start_time
self.end_time=self.info.end_time

self:initView()
self.rewardroot:setActive(true)
end


function UISubAct_TXDTQ_mainWin:onHide()
self.rewardroot:setActive(false)
end





function UISubAct_TXDTQ_mainWin:onBuyBtn()

local channelDatas=wanBaoXunBaoDuiModel:getChannelDatas()
local state=channelDatas[self.tqCfg.channelid].open_state

if state then
socketManager:send(249,105,self.actid,36,self.subid,"[1]");
else
local callback=function()
local rechargeId=self.tqCfg.rechargeid
payControl.reqPay(rechargeId,1,self.tqCfg.id)
end
local rechargeCfg=cfgHelper.get1(cfg_rechargeconfig_get,self.tqCfg.rechargeid)
local str=pfwindowslController:showDesc_ByMoneyType(rechargeCfg)
local content=FMT.fmt("是否使用{0}解锁特权航道",str)
local show_data={
type='UIDialouge',
title='提示',
oktext='确定',
content=content,
canceltext='取消',
showclosebtn=true,
okcallback=function()
callback()
end,
cancelcallback=nil,
closecallback=nil,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

AudioManager.playOpenUI()
end

function UISubAct_TXDTQ_mainWin:onInfomationBtn()
local catCfg=cfgHelper.get1(cfg_catconfig_get,self.tqCfg.catid)

local speInfo=catCfg.speInfo

local catinfo={}
catinfo.guid=-1
catinfo.wx_id=catCfg.show[1][1]
catinfo.color=speInfo[1]
catinfo.propList=speInfo[2]
catinfo.prop_num=#speInfo[2]
catinfo.txList=speInfo[3]
catinfo.texing_num=#speInfo[3]
catinfo.equip_num=0
catinfo.tili=0
catinfo.name_id=self.tqCfg.catid
catinfo.lv=1

local temp=table.deepCopy(catinfo)
wanBaoXunBaoDuiModel:updateEmployee(temp)

self:showWindow("UIWanBaoXunBaoDui_RecruitmentWin",{type=WBXBD_ReCruitment_TYPE.info,catdata={temp}})
end



function UISubAct_TXDTQ_mainWin:onReceiveBtn()
local channelDatas=wanBaoXunBaoDuiModel:getChannelDatas()
local state=channelDatas[self.tqCfg.channelid].open_state

if state then
socketManager:send(249,105,self.actid,SUB_ACTIVITY_TYPE.eHangDaoTeQuan,self.subid,"[1]");
end
end

function UISubAct_TXDTQ_mainWin:recv_receive(actID,subType,subID)
self.info=activitiesModel:getSubActInfo(actID,subType,subID)
self:freshButton()
end

function UISubAct_TXDTQ_mainWin:initView()
self.info:checkReddot()

self:refreshTimer()












local reward=self.config.clientshowrewards[1][2]
local propArray={}
for k,v in ipairs(reward)do
local conf={itemid=v[1],itemcount=v[2]>1 and v[2]or'',showCountBG=v[2]>1,showname=false}
table.insert(propArray,itemsComponentHelper.getCommonFillDataSmall(conf))
end

self.rewardListContent:setChildLayoutGroupCreateItems(#reward,function(index)
local itemdata=reward[index]
local data=propArray[index]
local item=self.rewardListContent:getChildLayoutGroupGridItem(index-1)
item:SetChildPropData(-1,data)
item:SetBaseItemClickEvent(-1,function()
itemsComponentHelper.onItemClick(itemdata[1],index)
end)
end)



local catCfg=cfgHelper.get1(cfg_catconfig_get,self.tqCfg.catid)
local modelcfg=cfgHelper.get1(cfg_catshowconfig_get,catCfg.show[1][1])
local name=cfgHelper.get1(cfg_catnameconfig_get,modelcfg.nameList[1]).name
self.model:setChildUIModelShowTarget(modelcfg.model,2,nil,eAnimationID.stand,false,false,0,nil)
self.name:setText(wanbaoXunBaoDuiHelper.transLineStr(name))

self:freshButton()
end

function UISubAct_TXDTQ_mainWin:freshButton()
local channelDatas=wanBaoXunBaoDuiModel:getChannelDatas()
local rcstate=channelDatas[self.tqCfg.channelid].open_state
local rwstate=mathHelper.getBitValue(self.info.flag or 0,0)

local btntxt=''
if not rcstate then
local rechargeCfg=cfgHelper.get1(cfg_rechargeconfig_get,self.tqCfg.rechargeid)
local str=pfwindowslController:showDesc_ByMoneyType(rechargeCfg)
btntxt=FMT.fmt('{0}开启',str)
end

self.buyNum:setText(btntxt)

self.buyBtn:setActive(not rwstate or not rcstate)
self.buyState:setActive(rwstate and rcstate)
self.btnspine:setActive(not rwstate or not rcstate)
self.graybtn:setActive(rwstate and rcstate)
end

function UISubAct_TXDTQ_mainWin:refreshTimer()
local time=activitiesModel:getSubActEndLeftTime(self.actid,self.subType,self.subid)
self.stamp=os.time()+time


self:stopSelfTimer()

local func=function()
if self==nil then return end
local left=self.stamp-os.time()
if left<0 then left=0 end
self.countdownTxt:setText(FMT.fmt("剩余时间:{0}",timeHelper.format_time_stamp3(left)))
end
self.timer=self:setTimer(1,0,func)
func()
end

function UISubAct_TXDTQ_mainWin:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end

function UISubAct_TXDTQ_mainWin:onWanBaoXunBaoDuiUnlockChannel(channel_id)
if channel_id==self.tqCfg.channelid then

socketManager:send(249,105,self.actid,36,self.subid,"[1]");
end
end


