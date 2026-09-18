







def_class("UISubAct_shizhuanchoujianWin",UIWindowBase)









function UISubAct_shizhuanchoujianWin:bindComponents()

self.name=UIText.get(self,0)
self.time=UIText.get(self,1)
self.root=UIObject.get(self,2)
self.npcModel=UIObject.get(self,3)
self.speakObj=UIObject.get(self,4)
self.speakText=UIText.get(self,5)
self.btn_one=UIButton.get(self,6)
self.text_one1=UIText.get(self,7)
self.text_one2=UIText.get(self,8)
self.icon_one=UIImage.get(self,9)
self.btn_two=UIButton.get(self,10)
self.text_two1=UIText.get(self,11)
self.text_two2=UIText.get(self,12)
self.icon_two=UIImage.get(self,13)
self.btn_gailv=UIButton.get(self,14)
self.btn_jianli=UIButton.get(self,15)
self.firstrole=UIObject.get(self,16)
self.secrole=UIObject.get(self,17)
self.thrtrole=UIObject.get(self,18)
self.fourrole=UIObject.get(self,19)
self.fiverole=UIObject.get(self,20)
self.rolepanel=UIObject.get(self,21)
self.suitModel=UIObject.get(self,22)
self.left=UIButton.get(self,23)
self.right=UIButton.get(self,24)
self.spine_effect=UIObject.get(self,25)
self.abuyrole=UIObject.get(self,26)
self.bbuyrole=UIObject.get(self,27)
self.cbuyrole=UIObject.get(self,28)
self.dbuyrole=UIObject.get(self,29)
self.ebuyrole=UIObject.get(self,30)
self.buyrolepanel=UIObject.get(self,31)
self.sixrole=UIObject.get(self,32)
self.sevenrole=UIObject.get(self,33)
self.suitpanel=UIObject.get(self,34)
self.bgaModel=UIObject.get(self,35)
self.bgbModel=UIObject.get(self,36)
self.fbuyrole=UIObject.get(self,37)
self.gbuyrole=UIObject.get(self,38)
self.hbuyrole=UIObject.get(self,39)
self.buyrolepanelout=UIObject.get(self,40)
self.rolepaneltop=UIObject.get(self,41)
self.topfirstrole=UIObject.get(self,42)
self.moneysRoot=UIButton.get(self,43)
self.moneyIcon=UIObject.get(self,44)
self.add=UIButton.get(self,45)
self.moneyText=UIText.get(self,46)
self.imgtanhao=UIObject.get(self,47)
self.text_mianfei=UIText.get(self,48)
self.suitClick=UIButton.get(self,49)
self.jumpAnimation=UIToggleButton.get(self,50)
self.out_effect=UIObject.get(self,51)
self.uipanel=UIObject.get(self,52)
self.ffbuyrole=UIObject.get(self,53)
self.ggbuyrole=UIObject.get(self,54)
self.hhbuyrole=UIObject.get(self,55)
self.iibuyrole=UIObject.get(self,56)
self.jjbuyrole=UIObject.get(self,57)
self.ibuyrole=UIObject.get(self,58)
self.jbuyrole=UIObject.get(self,59)
self.kbuyrole=UIObject.get(self,60)
self.lbuyrole=UIObject.get(self,61)
self.mbuyrole=UIObject.get(self,62)
self.nbuyrole=UIObject.get(self,63)
self.obuyrole=UIObject.get(self,64)
self.nextTx=UIText.get(self,65)
self.masks=UIObject.get(self,66)
self.glreddot=UIObject.get(self,67)
self.Pbuyrole=UIObject.get(self,68)
self.isShowReddotBtn=UIButton.get(self,69)

self.btn_one:setButtonClick(function()self:onBtn_one()end)

self.btn_two:setButtonClick(function()self:onBtn_two()end)

self.btn_gailv:setButtonClick(function()self:onBtn_gailv()end)

self.btn_jianli:setButtonClick(function()self:onBtn_jianli()end)

self.left:setButtonClick(function()self:onLeft()end)

self.right:setButtonClick(function()self:onRight()end)

self.moneysRoot:setButtonClick(function()self:onMoneysRoot()end)

self.add:setButtonClick(function()self:onAdd()end)

self.suitClick:setButtonClick(function()self:onSuitClick()end)

self.isShowReddotBtn:setButtonClick(function()self:onIsShowReddotBtn()end)
self.btn={
["one"]=self.btn_one,
["two"]=self.btn_two,
["gailv"]=self.btn_gailv,
["jianli"]=self.btn_jianli,
}
self.text={
["one1"]=self.text_one1,
["one2"]=self.text_one2,
["two1"]=self.text_two1,
["two2"]=self.text_two2,
["mianfei"]=self.text_mianfei,
}
self.icon={
["one"]=self.icon_one,
["two"]=self.icon_two,
}
self.spine={
["effect"]=self.spine_effect,
}
self.out={
["effect"]=self.out_effect,
}



end


function UISubAct_shizhuanchoujianWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.btn_one);self.btn_one=nil;
_UIObject_release(self.text_one1);self.text_one1=nil;
_UIObject_release(self.text_one2);self.text_one2=nil;
_UIObject_release(self.icon_one);self.icon_one=nil;
_UIObject_release(self.btn_two);self.btn_two=nil;
_UIObject_release(self.text_two1);self.text_two1=nil;
_UIObject_release(self.text_two2);self.text_two2=nil;
_UIObject_release(self.icon_two);self.icon_two=nil;
_UIObject_release(self.btn_gailv);self.btn_gailv=nil;
_UIObject_release(self.btn_jianli);self.btn_jianli=nil;
_UIObject_release(self.firstrole);self.firstrole=nil;
_UIObject_release(self.secrole);self.secrole=nil;
_UIObject_release(self.thrtrole);self.thrtrole=nil;
_UIObject_release(self.fourrole);self.fourrole=nil;
_UIObject_release(self.fiverole);self.fiverole=nil;
_UIObject_release(self.rolepanel);self.rolepanel=nil;
_UIObject_release(self.suitModel);self.suitModel=nil;
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.right);self.right=nil;
_UIObject_release(self.spine_effect);self.spine_effect=nil;
_UIObject_release(self.abuyrole);self.abuyrole=nil;
_UIObject_release(self.bbuyrole);self.bbuyrole=nil;
_UIObject_release(self.cbuyrole);self.cbuyrole=nil;
_UIObject_release(self.dbuyrole);self.dbuyrole=nil;
_UIObject_release(self.ebuyrole);self.ebuyrole=nil;
_UIObject_release(self.buyrolepanel);self.buyrolepanel=nil;
_UIObject_release(self.sixrole);self.sixrole=nil;
_UIObject_release(self.sevenrole);self.sevenrole=nil;
_UIObject_release(self.suitpanel);self.suitpanel=nil;
_UIObject_release(self.bgaModel);self.bgaModel=nil;
_UIObject_release(self.bgbModel);self.bgbModel=nil;
_UIObject_release(self.fbuyrole);self.fbuyrole=nil;
_UIObject_release(self.gbuyrole);self.gbuyrole=nil;
_UIObject_release(self.hbuyrole);self.hbuyrole=nil;
_UIObject_release(self.buyrolepanelout);self.buyrolepanelout=nil;
_UIObject_release(self.rolepaneltop);self.rolepaneltop=nil;
_UIObject_release(self.topfirstrole);self.topfirstrole=nil;
_UIObject_release(self.moneysRoot);self.moneysRoot=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.add);self.add=nil;
_UIObject_release(self.moneyText);self.moneyText=nil;
_UIObject_release(self.imgtanhao);self.imgtanhao=nil;
_UIObject_release(self.text_mianfei);self.text_mianfei=nil;
_UIObject_release(self.suitClick);self.suitClick=nil;
_UIObject_release(self.jumpAnimation);self.jumpAnimation=nil;
_UIObject_release(self.out_effect);self.out_effect=nil;
_UIObject_release(self.uipanel);self.uipanel=nil;
_UIObject_release(self.ffbuyrole);self.ffbuyrole=nil;
_UIObject_release(self.ggbuyrole);self.ggbuyrole=nil;
_UIObject_release(self.hhbuyrole);self.hhbuyrole=nil;
_UIObject_release(self.iibuyrole);self.iibuyrole=nil;
_UIObject_release(self.jjbuyrole);self.jjbuyrole=nil;
_UIObject_release(self.ibuyrole);self.ibuyrole=nil;
_UIObject_release(self.jbuyrole);self.jbuyrole=nil;
_UIObject_release(self.kbuyrole);self.kbuyrole=nil;
_UIObject_release(self.lbuyrole);self.lbuyrole=nil;
_UIObject_release(self.mbuyrole);self.mbuyrole=nil;
_UIObject_release(self.nbuyrole);self.nbuyrole=nil;
_UIObject_release(self.obuyrole);self.obuyrole=nil;
_UIObject_release(self.nextTx);self.nextTx=nil;
_UIObject_release(self.masks);self.masks=nil;
_UIObject_release(self.glreddot);self.glreddot=nil;
_UIObject_release(self.Pbuyrole);self.Pbuyrole=nil;
_UIObject_release(self.isShowReddotBtn);self.isShowReddotBtn=nil;
self.btn=nil;
self.text=nil;
self.icon=nil;
self.spine=nil;
self.out=nil;
end



















local cmpItemIndex=
{
name=0,
item1=1,
buyLimit=6,
buyBtn=7,
freeBtn=8,
buyText=9,
resetFlag=10,
got=11,
selectBtn=12,
buyIcon=13,
}

local itemIndexList={1,2,3,4,5}

local itemCIndex=
{
item=0,
addRoot=1,
button=2,
change=3,
}
local _this


local cspoint=
{
{{-358,0},{299,0}},{{-158,-50},{430,-50}},{{50,-60},{595,-60}},{{299,0},{0,0}},{{423,0},{0,0}},
}


local buycspoint=
{
{-666,-99},{-710,-170},{-690,-150},{-585,-190},{-308,-240},{-287,-210},{-269,-189},{-259,-170},{-239,-150},{-200,-130},
}

local buyCenterpoint=
{
{-462,28},{-309,33},
}

local buyxiaoshipoint=
{
{-317,149},{-317,120},{-317,108},
}

local buyoutcenpoint=
{
{-445,-28},{-309,-10},{-280,-35},
}

local buyoutpoint=
{
{-205,-30},{-43,-30},{116,-30},{838,-40},{838,-75},
}


local new_stand_point=
{
{{-860,-45},{34,0},{175,-1}},{{1128,0},{550,8}}
}


local new_walk_point=
{
{{-1053,5},{1095,-60}},{{1128,-50},{-1053,-45}},{{-1053,-50},{1128,10}},
}


local new_topwalk_point=
{
{{-534,450},{-180,450}},
}


local new_buy_modelid=
{
1114120,1114121,1114122,1124120,1124121,1124122,1114120,1114121,1114122,1124120
}


local new_stand_modelid=
{
1113025,1123008,1123007,1113032,1113032,1123007
}

local shopspeaktype=
{
danchou=2,
lianchou=3,
}

local _order={
eZongMenPostType.eZhangMen,
eZongMenPostType.eChuanGong,
eZongMenPostType.eJieYin,
eZongMenPostType.eJielu,
eZongMenPostType.eZhenYu,
eZongMenPostType.eNeiMen,
eZongMenPostType.eWaiMen,
}


local dizitemp=
{
2101,2102,2103,3001,3002,3003,3005,3006,3007,3008
}


function UISubAct_shizhuanchoujianWin:onLoaded(...)
self:bindComponents()
_this=self
local on_new_day=function()
if self and not self.isClose and self.onRefresh then
self:onRefresh()
end
end
self.jumpAnimation:setToggleChange(function(...)self:onJumpAnimation(...)end)
self.rolewalks={self.firstrole,self.secrole,self.thrtrole,self.fourrole,self.fiverole,self.sixrole,self.sevenrole}
self.rolebuys={self.abuyrole,self.bbuyrole,self.cbuyrole,self.dbuyrole,self.ebuyrole,self.ffbuyrole,self.ggbuyrole,self.hhbuyrole,self.iibuyrole,self.jjbuyrole}
self.rolebuysout={self.fbuyrole,self.gbuyrole,self.hbuyrole,self.ibuyrole,self.jbuyrole,self.kbuyrole,self.lbuyrole,self.mbuyrole,self.nbuyrole,self.obuyrole}






notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
self:addNotify(notifyConfig.onSubActivityOverBeforeEndTime24Hour,self.onSubActivityOverBeforeEndTime24Hour)
end


function UISubAct_shizhuanchoujianWin:__delete()
self:unbindComponents()

self.isOver=nil
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
self:stopExpireTimer()
_this=nil

notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)

end


function UISubAct_shizhuanchoujianWin:stopExpireTimer()
if self.refreshTimeId then
self:stopTimerByID(self.refreshTimeId)
self.refreshTimeId=nil
end
if self.refreshTimeId2 then
self:stopTimerByID(self.refreshTimeId2)
self.refreshTimeId2=nil
end
if self.refreshTimeIdspeak2 then
self:stopTimerByID(self.refreshTimeIdspeak2)
self.refreshTimeIdspeak2=nil
end
if self.refreshTimeId3 then
self:stopTimerByID(self.refreshTimeId3)
self.refreshTimeId3=nil
end
if self.refreshTimeIdspeak3 then
self:stopTimerByID(self.refreshTimeIdspeak3)
self.refreshTimeIdspeak3=nil
end
if self.refreshTimeId4 then
self:stopTimerByID(self.refreshTimeId4)
self.refreshTimeId4=nil
end
if self.refreshTimeIdspeak4 then
self:stopTimerByID(self.refreshTimeIdspeak4)
self.refreshTimeIdspeak4=nil
end

if self.refreshTimeId33 then
self:stopTimerByID(self.refreshTimeId33)
self.refreshTimeId33=nil
end
if self.refreshTimeIdshop then
self:stopTimerByID(self.refreshTimeIdshop)
self.refreshTimeIdshop=nil
end
if self.buyroletime1 then
self:stopTimerByID(self.buyroletime1)
self.buyroletime1=nil
end
if self.buyroletime21 then
self:stopTimerByID(self.buyroletime21)
self.buyroletime21=nil
end
if self.buyroletime22 then
self:stopTimerByID(self.buyroletime22)
self.buyroletime22=nil
end
if self.buyroletime23 then
self:stopTimerByID(self.buyroletime23)
self.buyroletime23=nil
end

if self.refreshTimespeak1 then
self:stopTimerByID(self.refreshTimespeak1)
self.refreshTimespeak1=nil
end
if self.refreshTimespeak2 then
self:stopTimerByID(self.refreshTimespeak2)
self.refreshTimespeak2=nil
end

if self.refreshTimeIdsuit then
self:stopTimerByID(self.refreshTimeIdsuit)
self.refreshTimeIdsuit=nil
end
if self.Timersuitleft then
self:stopTimerByID(_this.Timersuitleft)
self.Timersuitleft=nil
end
if self.Timersuitright then
self:stopTimerByID(_this.Timersuitright)
self.Timersuitright=nil
end


if self.tweener11 then
self.tweener11:Kill(false)
self.tweener11=nil
end
if self.tweener21 then
self.tweener21:Kill(false)
self.tweener21=nil
end
if self.tweener31 then
self.tweener31:Kill(false)
self.tweener31=nil
end
if self.tweener41 then
self.tweener41:Kill(false)
self.tweener41=nil
end
if self.tweener51 then
self.tweener51:Kill(false)
self.tweener51=nil
end

if self.tweener33 then
self:stopTimerByID(_this.tweener33)
self.tweener33=nil
end
if self.tweener44 then
self:stopTimerByID(_this.tweener44)
self.tweener44=nil
end
if self.tweener55 then
self:stopTimerByID(_this.tweener55)
self.tweener55=nil
end

if self.animnplay then
self:stopTimerByID(_this.animnplay)
self.animnplay=nil
end

if self.outrole1 then
self:stopTimerByID(_this.outrole1)
self.outrole1=nil
end
if self.outrole2 then
self:stopTimerByID(_this.outrole2)
self.outrole2=nil
end
if self.outrole3 then
self:stopTimerByID(_this.outrole3)
self.outrole3=nil
end
if self.outrole4 then
self:stopTimerByID(_this.outrole4)
self.outrole4=nil
end
if self.outrole5 then
self:stopTimerByID(_this.outrole5)
self.outrole5=nil
end
if self.outrole6 then
self:stopTimerByID(_this.outrole6)
self.outrole6=nil
end
if self.outrole8 then
self:stopTimerByID(_this.outrole8)
self.outrole8=nil
end
if self.outrole9 then
self:stopTimerByID(_this.outrole9)
self.outrole9=nil
end
if self.outrole10 then
self:stopTimerByID(_this.outrole10)
self.outrole10=nil
end
if self.jiesuan then
self:stopTimerByID(_this.jiesuan)
self.jiesuan=nil
end

end





function UISubAct_shizhuanchoujianWin:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eDressLottery
self.subid=argtable.sub_act_id

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)

self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)



self.isShowMoney=self.config.isShowMoney
self.fmTweenerList={}

if self.info then
local leftTime=self.info:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("剩余时间：{0}",UISubAct_shizhuanchoujianWin.format_time_stamp2(leftTime)))
else
self.time:setText("活动已结束")
self.isOver=true
end
self.leftTimer=self:setTimer(1,-1,function()
local info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
if info then
local leftTime=info:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("剩余时间：{0}",UISubAct_shizhuanchoujianWin.format_time_stamp2(leftTime)))
else
self.time:setText("活动已结束")
self.isOver=true
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
end
else
self.time:setText("活动已结束")
self.isOver=true
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
end

end)
else
self.time:setText("活动已结束")
self.isOver=true
end


_this.leftpoint3=new_walk_point[1][1]
_this.rightpoint3=new_walk_point[1][2]

_this.leftpoint4=new_walk_point[2][2]
_this.rightpoint4=new_walk_point[2][1]

_this.leftpoint5=new_walk_point[3][1]
_this.rightpoint5=new_walk_point[3][2]

_this.leftpointtop=new_topwalk_point[1][1]
_this.rightpointtop=new_topwalk_point[1][2]

_this.animadoing=false
_this.choujiantype=-1
_this.selectid=1
_this.suitlist=cfg_lotteryact3config_get(_this.subid).spinelist
_this.moneyType=cfg_lotteryact3config_get(_this.subid).cost_items[1]
_this.suitbacklist={}

_this.bgaModel:setChildUIModelShowTarget(4864,1,nil,eAnimationID.stand)
_this.bgbModel:setChildUIModelShowTarget(4865,1,nil,eAnimationID.stand)


_this.masks:setActive(false)

local isfirstreddot=userActorSetting.get('UISubAct_shizhuanchoujianWin_reddot',false)
if isfirstreddot then
_this.glreddot:setActive(false)
else
_this.glreddot:setActive(true)
end
UISubAct_shizhuanchoujianWin:refreshMoneyRoot()

UISubAct_shizhuanchoujianWin:showSpineSelect()
UISubAct_shizhuanchoujianWin:refreshShopModel()
UISubAct_shizhuanchoujianWin:doSpeaking_player()
UISubAct_shizhuanchoujianWin:refreshShopbubble()
UISubAct_shizhuanchoujianWin:refreshCostBtn()
UISubAct_shizhuanchoujianWin:RoleWalkAnima()
UISubAct_shizhuanchoujianWin:refreshJumpAnimation()
UISubAct_shizhuanchoujianWin:showSpineSelectAnima()
UISubAct_shizhuanchoujianWin:baodinum()

self:refreshIsShowReddotBtn()
end

local _format=string.format
local _floor=math.floor
function UISubAct_shizhuanchoujianWin.format_time_stamp2(inteval)
local SS=inteval%60
local cc=_floor(inteval/60)
local mm=cc%60
cc=_floor(cc/60)
local HH=cc%24
cc=_floor(cc/24)
local DD=cc

if DD>0 then
return _format('%s天%s时%s分',DD,HH,mm)
else
if HH>0 then
return _format('%s时%s分',HH,mm)
else
if mm>0 then
return _format('%s分%s秒',mm,SS)
else
return _format('%s秒',SS)
end
end
end
end


function UISubAct_shizhuanchoujianWin:rec_newday()
UISubAct_shizhuanchoujianWin:refreshMoneyRoot()
UISubAct_shizhuanchoujianWin:refreshCostBtn()
end


function UISubAct_shizhuanchoujianWin:refreshMoneyRoot()
local iconName=iconHelper.getIconName(_this.moneyType)
_this.moneyIcon:setChildIcon(iconName,false)
local num=bagControl.invokeFuncByItemId(_this.moneyType,'getItemCountByItemID',_this.moneyType)
_this.moneyText:setText(num)
end

function UISubAct_shizhuanchoujianWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if itemid==_this.moneyType then
_this:refreshMoneyRoot()
_this:refreshCostBtn()
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,_this.subType)
end
end

function UISubAct_shizhuanchoujianWin.on_money_changed(moneyType,lastVal,val)
if moneyType==_this.moneyType then
_this:refreshMoneyRoot()
_this:refreshCostBtn()
end
end


function UISubAct_shizhuanchoujianWin:onHide()
self:stopExpireTimer()
end




function UISubAct_shizhuanchoujianWin:refreshCostBtn()
local mydata=activitiesModel:getSubActInfoData(_this.actid,_this.subType,_this.subid)
local cfg=cfg_lotteryact3config_get(_this.subid)
local free_times=cfg.free_times or 0
local use_free_times=mydata.use_free_times or 0
local hasfree=free_times-use_free_times

local costid=_this.moneyType
local costnum=cfg.cost_items[2]
local onebuy=cfg.lottery_list[1]
local twenbuy=cfg.lottery_list[2]
local haveItem
if moneyConfig.isMoney(costid)then
haveItem=moneyModel.getMoney(costid)
else
haveItem=bagControl.invokeFuncByItemId(costid,'getItemCountByItemID',costid)
end
local iconName=iconHelper.getIconName(costid)
_this.icon_one:setImageIcon(iconName)
_this.icon_one:setActive(true)
_this.text_one1:setText(FMT.fmt('购物{0}次',onebuy))
_this.icon_two:setImageIcon(iconName)
_this.icon_two:setActive(true)
_this.text_two1:setText(FMT.fmt('购物{0}次',twenbuy))
_this.text_mianfei:setText('')


if hasfree>0 then

_this.text_one1:setText(FMT.fmt('免费次数'))
_this.text_mianfei:setText(FMT.fmt('{0}次',hasfree))
_this.icon_one:setActive(false)
_this.text_one2:setText('')
else
local needCost=costnum*onebuy
if haveItem>=needCost then

_this.text_one2:setText(FMT.fmt('<color=#FFFFFF>{0}</color>',needCost))
else

_this.text_one2:setText(FMT.fmt('<color=#FF2626>{0}</color>',needCost))
end
end


if(hasfree-twenbuy)>0 then

else
local needCost=costnum*twenbuy
if haveItem>=needCost then

_this.text_two2:setText(FMT.fmt('<color=#FFFFFF>{0}</color>',needCost))
else

_this.text_two2:setText(FMT.fmt('<color=#FF2626>{0}</color>',needCost))
end
end
end


function UISubAct_shizhuanchoujianWin:refreshShopModel()
local cfg_npcmodelid=cfg_lotteryact3config_get(_this.subid).shopnpcmodel
_this.npcModel:setChildUIModelShowTarget(cfg_npcmodelid,1,{},eAnimationID.stand,false,true)
_this.npcModel:setChildUIModelShowFlipX(true)
end


function UISubAct_shizhuanchoujianWin:refreshShopbubble()
if _this.refreshTimeIdshop then
_this:stopTimerByID(_this.refreshTimeIdshop)
_this.refreshTimeIdshop=nil
end
_this.refreshTimeFunshop=function()
if not _this.animadoing then
UISubAct_shizhuanchoujianWin:doSpeaking_player(1)
end
end
_this.refreshTimeFunshop()
local cfg=cfg_lotteryact3config_get(_this.subid).shopspeaks
local shoptime=cfg[1][1]or 11
_this.refreshTimeIdshop=_this:setTimer(shoptime,0,_this.refreshTimeFunshop)
end

function UISubAct_shizhuanchoujianWin:doSpeaking_player(speakType)
local cfg=cfg_lotteryact3config_get(_this.subid).shopspeaks
local speakList=cfg[1][2]
if speakType==shopspeaktype.danchou then
speakList=cfg[2]
elseif speakType==shopspeaktype.lianchou then
speakList=cfg[3]
end
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
_this.speakObj:setChildCanvasGroupAlpha(1)
_this.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
_this:doTalkAnim_player()
end

function UISubAct_shizhuanchoujianWin:doTalkAnim_player()
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
function UISubAct_shizhuanchoujianWin:talkEnd()
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


function UISubAct_shizhuanchoujianWin:shopimgshow()
_this.imgtanhao:setScale(Vector3(0.5,0.5,0.5))
_this.imgtanhao:setChildCanvasGroupDOFade(1,0.5,nil)
_this.winlua:SetChildDOTweenAnimation_DOPlay(_this.imgtanhao:getID())
_this.imgtanhao:setChildDOScale(1,0.2,nil)
_this:delayDo(2.5,function()
if _this==nil then return end
_this.imgtanhao:setChildCanvasGroupDOFade(0,1)
_this.winlua:SetChildDOTweenAnimation_DOPause(_this.imgtanhao:getID())
_this.imgtanhao:setRotation(0,0,0)
end)

end


function UISubAct_shizhuanchoujianWin:showSpineSelect()
if _this.suitlist and _this.selectid then
local data=_this.suitlist[_this.selectid]
local jobid=data[2]
local body=data[3]
local suitscale=cfg_lotteryact3config_get(_this.subid).suitscale[1]or 1.5
_this.suitModel:setChildUIModelShowTarget(body,suitscale,{},eAnimationID.stand,false,true)
end
end

function UISubAct_shizhuanchoujianWin:showSpineSelectAnima()
if _this.refreshTimeIdsuit then
_this:stopTimerByID(_this.refreshTimeIdsuit)
_this.refreshTimeIdsuit=nil
end
_this.refreshTimeFunsuit=function()
if _this.animadoing==true then return end
UISubAct_shizhuanchoujianWin:onRight()
end

local autotime=cfg_lotteryact3config_get(_this.subid).autosuittime or 8

_this.refreshTimeIdsuit=_this:setTimer(autotime,0,_this.refreshTimeFunsuit)
end


function UISubAct_shizhuanchoujianWin:refreshRLBtnShow()
if _this.suitlist and _this.selectid then
if _this.selectid==1 then
_this.left:setActive(false)
else
_this.left:setActive(true)
end
if _this.selectid==#_this.suitlist then
_this.right:setActive(false)
else
_this.right:setActive(true)
end
end
end

function UISubAct_shizhuanchoujianWin:refreshJumpAnimation()
_this.jumpAnimationclick=userActorSetting.get('UISubAct_shizhuanchoujianWin_FLAG',false)
_this.jumpAnimation:setToggle(_this.jumpAnimationclick)
end

function UISubAct_shizhuanchoujianWin:onJumpAnimation(name,jump,data)
_this.jumpAnimationclick=jump
AudioManager.playBtnClick()
userActorSetting.set('UISubAct_shizhuanchoujianWin_FLAG',jump)
userActorSetting.flush()
end


function UISubAct_shizhuanchoujianWin:onSuitClick()
if _this.suitlist and _this.selectid then
local data=_this.suitlist[_this.selectid]
local jobid=data[2]
local body=data[3]
local itemId=data[1]or-1
if itemId and itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=nil,showModel=true})
end
end


function UISubAct_shizhuanchoujianWin:onLeft()
if _this.suitlist and _this.selectid then
if(_this.selectid-1)<=0 then
_this.selectid=#_this.suitlist
else
_this.selectid=_this.selectid-1
end
_this.spine_effect:setChildShowEffect(10377,true)
_this.suitpanel:setChildCanvasGroupAlpha(0)
_this.suitpanel:setChildCanvasGroupDOFade(1,1)

UISubAct_shizhuanchoujianWin:showSpineSelect()
UISubAct_shizhuanchoujianWin:showSpineSelectAnima()
end
end

function UISubAct_shizhuanchoujianWin:onRight()
if _this.suitlist and _this.selectid then
if(_this.selectid+1)>#_this.suitlist then
_this.selectid=1
else
_this.selectid=_this.selectid+1
end
_this.spine_effect:setChildShowEffect(10377,true)
_this.suitpanel:setChildCanvasGroupAlpha(0)
_this.suitpanel:setChildCanvasGroupDOFade(1,1)

UISubAct_shizhuanchoujianWin:showSpineSelect()
UISubAct_shizhuanchoujianWin:showSpineSelectAnima()
end
end

function UISubAct_shizhuanchoujianWin:onAdd()

end
function UISubAct_shizhuanchoujianWin:onMoneysRoot()
gainControl:showGainWin(_this.moneyType)
end


function UISubAct_shizhuanchoujianWin:onBtn_one()
if _this.animadoing==true then return end
AudioManager.playBtnClick()
local mydata=activitiesModel:getSubActInfoData(_this.actid,_this.subType,_this.subid)
local cfg=cfg_lotteryact3config_get(_this.subid)
local free_times=cfg.free_times or 0
local use_free_times=mydata.use_free_times or 0
local hasfree=free_times-use_free_times
local costid=_this.moneyType
local costnum=cfg.cost_items[2]
local onebuy=cfg.lottery_list[1]
local haveItem
if moneyConfig.isMoney(costid)then
haveItem=moneyModel.getMoney(costid)
else
haveItem=bagControl.invokeFuncByItemId(costid,'getItemCountByItemID',costid)
end


if hasfree>0 then
local isshowtips=mydata.idx
if isshowtips==0 then
UISubAct_shizhuanchoujianWin:handel_ShowSelect(1)
else
local info={1,1}
local jsonStr=jsonHelper.encode(info)
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actid,_this.subType,_this.subid,jsonStr)
_this.choujiantype=1
end

else
local needCost=costnum*onebuy
if haveItem>=needCost then
local isshowtips=mydata.idx
if isshowtips==0 then
UISubAct_shizhuanchoujianWin:handel_ShowSelect(1)
else
local info={1,1}
local jsonStr=jsonHelper.encode(info)
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actid,_this.subType,_this.subid,jsonStr)
_this.choujiantype=1
end
else

gainControl:showGainWin(_this.moneyType)
return
end
end
end

function UISubAct_shizhuanchoujianWin:onBtn_two()
if _this.animadoing==true then return end
AudioManager.playBtnClick()
local mydata=activitiesModel:getSubActInfoData(_this.actid,_this.subType,_this.subid)
local cfg=cfg_lotteryact3config_get(_this.subid)
local free_times=cfg.free_times or 0
local use_free_times=mydata.use_free_times or 0
local hasfree=free_times-use_free_times
local costid=_this.moneyType
local costnum=cfg.cost_items[2]
local twenbuy=cfg.lottery_list[2]
local haveItem
if moneyConfig.isMoney(costid)then
haveItem=moneyModel.getMoney(costid)
else
haveItem=bagControl.invokeFuncByItemId(costid,'getItemCountByItemID',costid)
end


if hasfree>=10 then
local isshowtips=mydata.idx
if isshowtips==0 then
UISubAct_shizhuanchoujianWin:handel_ShowSelect(10)
else
local info={1,2}
local jsonStr=jsonHelper.encode(info)
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actid,_this.subType,_this.subid,jsonStr)
_this.choujiantype=10
end
else
local needCost=costnum*twenbuy
if haveItem>=needCost then
local isshowtips=mydata.idx
if isshowtips==0 then
UISubAct_shizhuanchoujianWin:handel_ShowSelect(10)
else
local info={1,2}
local jsonStr=jsonHelper.encode(info)
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actid,_this.subType,_this.subid,jsonStr)
_this.choujiantype=10
end
else

gainControl:showGainWin(_this.moneyType)
return
end
end
end


function UISubAct_shizhuanchoujianWin:handel_ShowSelect(choujiantype)
local cfg=cfg_lotteryact3config_get(_this.subid)
local defaultIdx=cfg.defaultdress
local itemsID=cfg.showdresslist[defaultIdx][1]
local itemsCfg=itemsConfig.getConfig(itemsID)
local contentStr=FMT.fmt('需要先选择心愿时装，继续操作将会自动将 <color=#549327>{0}</color> 选为心愿时装，是否确认?\n\n注：心愿时装可随时进行更换',itemsCfg.name)
local show_data={
type='UIDialouge',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
okcallback=function()
if _this==nil then return end
local json_str=jsonHelper.encode({2,defaultIdx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actid,_this.subType,_this.subid,json_str)
_this.choujiantype=choujiantype
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
end


function UISubAct_shizhuanchoujianWin:rec_selectUp()
if _this.choujiantype==1 then
local info={1,1}
local jsonStr=jsonHelper.encode(info)
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actid,_this.subType,_this.subid,jsonStr)
elseif _this.choujiantype==10 then
local info={1,2}
local jsonStr=jsonHelper.encode(info)
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actid,_this.subType,_this.subid,jsonStr)
end
end


function UISubAct_shizhuanchoujianWin:onBtn_gailv()
AudioManager.playBtnClick()
UIManager:showWindow('UISubAct_shizhuanchoujian_reward_win',{act_id=_this.actid,sub_act_type=_this.subType,sub_act_id=_this.subid,})
end

function UISubAct_shizhuanchoujianWin:onBtn_jianli()
local mydata=activitiesModel:getSubActInfoData(_this.actid,_this.subType,_this.subid)

UIManager:showWindow('UISubAct_SZCJ_xinyuanwin',{act_id=_this.actid,sub_act_type=_this.subType,sub_act_id=_this.subid,})

local isreddot=userActorSetting.get('UISubAct_shizhuanchoujianWin_reddot',false)
if not isreddot then
userActorSetting.set('UISubAct_shizhuanchoujianWin_reddot',true)
userActorSetting.flush()
_this.glreddot:setActive(false)
end
end


function UISubAct_shizhuanchoujianWin:refreshwalkdizi()
local guids={'ss','aa'}

if#guids<6 then
local numdizi=6-#guids
if numdizi>1 then

local list_bc={}
local list_temp_bc={}
for k=1,#dizitemp do
list_temp_bc[#list_temp_bc+1]=k
end
local num_bc=#dizitemp
for i=1,numdizi do
local rr=math.random(1,num_bc-i+1)
local aa=list_temp_bc[rr]
table.insert(list_bc,aa)
local templist_bc={}
for k,v in ipairs(list_temp_bc)do
if v==list_temp_bc[rr]then
else
templist_bc[#templist_bc+1]=v
end
end
list_temp_bc=templist_bc
end

for m,n in ipairs(list_bc)do
if dizitemp[n]then

guids[#guids+1]=dizitemp[n]
end
end
else
guids[#guids+1]=dizitemp[1]
end
end

end


function UISubAct_shizhuanchoujianWin:RoleWalkAnima()
_this.rolepanel:setChildCanvasGroupAlpha(0)
_this.rolepaneltop:setChildCanvasGroupAlpha(0)
UISubAct_shizhuanchoujianWin:OpeanRoleWalkpanel(2)

local randomrole=6
_this.roles={}
_this.rolestop={}
for i=1,randomrole do
local widget=_this.rolewalks[i]:getWidgetBase()
_this.roles[#_this.roles+1]=widget
end
_this.roles[6]=_this.topfirstrole:getWidgetBase()


local disciplesList=UIDiscipleModel:getAllDiscipleData()
local guids={}
local guid_list={}
for k,v in pairs(disciplesList)do
local netdata=v.netData
if UIDiscipleModel:getDiscipleName(netdata.net.discipleguid)~='元润'then
guid_list[#guid_list+1]=netdata.net.discipleguid
end
end

if#guid_list>=6 then

local list_new={}
local list_temp={}
for k=1,#guid_list do
list_temp[#list_temp+1]=k
end
local num_temp=#guid_list
for i=1,6 do
local r=math.random(1,num_temp-i+1)
local a=list_temp[r]
table.insert(list_new,a)
local templist_new={}
for k,v in ipairs(list_temp)do
if v==list_temp[r]then
else
templist_new[#templist_new+1]=v
end
end
list_temp=templist_new
end
for j=1,6 do
guids[#guids+1]=guid_list[list_new[j]]
end
else
guids=guid_list
end

if#guids<6 then
local numdizi=6-#guids
if numdizi>1 then

local list_bc={}
local list_temp_bc={}
for k=1,#dizitemp do
list_temp_bc[#list_temp_bc+1]=k
end
local num_bc=#dizitemp
for i=1,numdizi do
local rr=math.random(1,num_bc-i+1)
local aa=list_temp_bc[rr]
table.insert(list_bc,aa)
local templist_bc={}
for k,v in ipairs(list_temp_bc)do
if v==list_temp_bc[rr]then
else
templist_bc[#templist_bc+1]=v
end
end
list_temp_bc=templist_bc
end
for m,n in ipairs(list_bc)do
if dizitemp[n]then

guids[#guids+1]=dizitemp[n]
end
end
else
guids[#guids+1]=dizitemp[1]
end
end


_this.gddiziguid={}
_this.gddizinumber={}
_this.gddizichange={[1]=guids[3],[2]=guids[4],[3]=guids[5]}
for k,v in ipairs(guids)do
if v and type(v)=="number"then
_this.gddizinumber[#_this.gddizinumber+1]=v
else
_this.gddiziguid[#_this.gddiziguid+1]=v
end
end


local stand_point_pos=new_stand_point[1]
local stand_pointqi=stand_point_pos[1]
local stand_pointzhong=stand_point_pos[2]
local stand_pointwei=stand_point_pos[3]
_this.roles[1]:SetChildAnchoredPosition(0,Vector2(stand_pointqi[1],stand_pointqi[2]))

if guids[1]and type(guids[1])=="number"then
local info1=UIDiscipleModel:getDiscipleDataByDiziId(guids[1]).imageInfo
local modelParams1=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info1)
_this.roles[1]:SetChildUIModelShowTarget(1,modelParams1.body,1,modelParams1.componets,eAnimationID.stand,false,false,0.1)
else
local info1=UIDiscipleModel:getDiscipleImageInfo(guids[1])
local modelParams1=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info1)
_this.roles[1]:SetChildUIModelShowTarget(1,modelParams1.body,1,modelParams1.componets,eAnimationID.stand,false,false,0.1)
end
_this.roles[1]:SetChildUIModelShowFlipX(1,true)

local fun12=function()
if _this==nil then return end
_this.roles[1]:SetChildModelAnimationState(1,eAnimationID.stand)

if _this.refreshTimespeak1 then
_this:stopTimerByID(_this.refreshTimespeak1)
_this.refreshTimespeak1=nil
end
_this.refreshTimeFuncspeak=function()
if _this==nil then return end
UISubAct_shizhuanchoujianWin:doSpeaking_playerone()
end
_this.refreshTimeFuncspeak()
local cfg_speaks=cfg_lotteryact3config_get(_this.subid).speaks
local speaktime1=cfg_speaks[1][1]or 8
_this.refreshTimespeak1=_this:setTimer(speaktime1,0,_this.refreshTimeFuncspeak)
end
_this.roles[1]:SetChildModelAnimationState(1,eAnimationID.walk)
_this.tweener11=_this.roles[1]:SetChildDOAnchorPos(0,Vector2.New(stand_pointwei[1],stand_pointwei[2]),10,fun12)
_this.tweener11:SetEase(_Ease.Linear)


local stand_point_pos2=new_stand_point[2]
local stand_pointqi2=stand_point_pos2[1]

local stand_pointwei2=stand_point_pos2[2]
_this.roles[2]:SetChildAnchoredPosition(0,Vector2(stand_pointqi2[1],stand_pointqi2[2]))
if guids[2]and type(guids[2])=="number"then
local info2=UIDiscipleModel:getDiscipleDataByDiziId(guids[2]).imageInfo
local modelParams2=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info2)
_this.roles[2]:SetChildUIModelShowTarget(1,modelParams2.body,1,modelParams2.componets,eAnimationID.stand,false,false,0.1)
else
local info2=UIDiscipleModel:getDiscipleImageInfo(guids[2])
local modelParams2=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info2)
_this.roles[2]:SetChildUIModelShowTarget(1,modelParams2.body,1,modelParams2.componets,eAnimationID.stand,false,false,0.1)
end
_this.roles[2]:SetChildUIModelShowFlipX(1,false)

local fun21=function()
if _this==nil then return end
_this.roles[2]:SetChildModelAnimationState(1,eAnimationID.stand)

if _this.refreshTimespeak2 then
_this:stopTimerByID(_this.refreshTimespeak2)
_this.refreshTimespeak2=nil
end
_this.refreshTimeFuncspeak2=function()
if _this==nil then return end
UISubAct_shizhuanchoujianWin:doSpeaking_playertwo()
end
_this.refreshTimeFuncspeak2()
local cfg_speaks=cfg_lotteryact3config_get(_this.subid).speaks
local speaktime2=cfg_speaks[2][1]or 10
_this.refreshTimespeak2=_this:setTimer(speaktime2,0,_this.refreshTimeFuncspeak2)
end
_this.roles[2]:SetChildModelAnimationState(1,eAnimationID.walk)
_this.tweener21=_this.roles[2]:SetChildDOAnchorPos(0,Vector2.New(stand_pointwei2[1],stand_pointwei2[2]),8,fun21)
_this.tweener21:SetEase(_Ease.Linear)


local stand_point_pos3=new_walk_point[1]
local stand_pointqi3=stand_point_pos3[1]
local stand_pointwei3=stand_point_pos3[2]
_this.roles[3]:SetChildAnchoredPosition(0,Vector2(stand_pointqi3[1],stand_pointqi3[2]))
if guids[3]and type(guids[3])=="number"then
local info3=UIDiscipleModel:getDiscipleDataByDiziId(guids[3]).imageInfo
local modelParams3=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info3)
_this.roles[3]:SetChildUIModelShowTarget(1,modelParams3.body,1,modelParams3.componets,eAnimationID.stand,false,false,0.1)
else
local info3=UIDiscipleModel:getDiscipleImageInfo(guids[3])
local modelParams3=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info3)
_this.roles[3]:SetChildUIModelShowTarget(1,modelParams3.body,1,modelParams3.componets,eAnimationID.stand,false,false,0.1)
end
_this.rolestwordtwo=-1
_this.roles[3]:SetChildUIModelShowFlipX(1,_this.rolestwordtwo==1)
_this.tweener33=_this:delayDo(10,function()
if _this==nil then return end
UISubAct_shizhuanchoujianWin:UpdateViewtwo()
end)


local stand_point_pos4=new_walk_point[2]
local stand_pointqi4=stand_point_pos4[1]
local stand_pointwei4=stand_point_pos4[2]
_this.roles[4]:SetChildAnchoredPosition(0,Vector2(stand_pointqi4[1],stand_pointqi4[2]))
if guids[4]and type(guids[4])=="number"then
local info4=UIDiscipleModel:getDiscipleDataByDiziId(guids[4]).imageInfo
local modelParams4=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info4)
_this.roles[4]:SetChildUIModelShowTarget(1,modelParams4.body,1,modelParams4.componets,eAnimationID.stand,false,false,0.1)
else
local info4=UIDiscipleModel:getDiscipleImageInfo(guids[4])
local modelParams4=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info4)
_this.roles[4]:SetChildUIModelShowTarget(1,modelParams4.body,1,modelParams4.componets,eAnimationID.stand,false,false,0.1)
end

_this.rolestwordthree=1
_this.roles[4]:SetChildUIModelShowFlipX(1,_this.rolestwordthree==1)
_this.tweener44=_this:delayDo(5,function()
if _this==nil then return end
UISubAct_shizhuanchoujianWin:UpdateViewthree()
end)


local stand_point_pos5=new_walk_point[3]
local stand_pointqi5=stand_point_pos5[1]
local stand_pointwei5=stand_point_pos5[2]
_this.roles[5]:SetChildAnchoredPosition(0,Vector2(stand_pointqi5[1],stand_pointqi5[2]))
if guids[5]and type(guids[5])=="number"then
local info5=UIDiscipleModel:getDiscipleDataByDiziId(guids[5]).imageInfo
local modelParams5=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info5)
_this.roles[5]:SetChildUIModelShowTarget(1,modelParams5.body,1,modelParams5.componets,eAnimationID.stand,false,false,0.1)
else
local info5=UIDiscipleModel:getDiscipleImageInfo(guids[5])
local modelParams5=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info5)
_this.roles[5]:SetChildUIModelShowTarget(1,modelParams5.body,1,modelParams5.componets,eAnimationID.stand,false,false,0.1)
end
_this.rolestwordfour=-1
_this.roles[5]:SetChildUIModelShowFlipX(1,_this.rolestwordfour==1)
_this.tweener55=_this:delayDo(20,function()
if _this==nil then return end
UISubAct_shizhuanchoujianWin:UpdateViewfour()
end)


local stand_point_pos6=new_topwalk_point[1]
local stand_pointqi6=stand_point_pos6[1]

_this.roles[6]:SetChildAnchoredPosition(0,Vector2(stand_pointqi6[1],stand_pointqi6[2]))
if guids[6]and type(guids[6])=="number"then
local info6=UIDiscipleModel:getDiscipleDataByDiziId(guids[6]).imageInfo
local modelParams6=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info6)
_this.roles[6]:SetChildUIModelShowTarget(1,modelParams6.body,1,modelParams6.componets,eAnimationID.stand,false,false,0.1)
else
local info6=UIDiscipleModel:getDiscipleImageInfo(guids[6])
local modelParams6=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info6)
_this.roles[6]:SetChildUIModelShowTarget(1,modelParams6.body,1,modelParams6.componets,eAnimationID.stand,false,false,0.1)
end
_this.rolestwordone=-1
_this.roles[6]:SetChildUIModelShowFlipX(1,_this.rolestwordone==1)

UISubAct_shizhuanchoujianWin:UpdateViewone()
end


function UISubAct_shizhuanchoujianWin:doSpeaking_playerone(speakType)
local cfg_speaks=cfg_lotteryact3config_get(_this.subid).speaks
local speakList=cfg_speaks[1][2]or{{"这位仙友，你也是来钓鱼的吗？"},{"吾纵横渔界多年，未逢一败，无敌真寂寞啊。"}}
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
_this.roles[1]:SetChildCanvasGroupAlpha(2,1)
_this.roles[1]:SetChildTrendsTextPlay(3,speakStr,speed,nil)
_this:doTalkAnim_playerone()
end
function UISubAct_shizhuanchoujianWin:doTalkAnim_playerone()
if _this.talkTween11~=nil then
_this.talkTween11:Kill()
_this.talkTween11=nil
end

_this.roles[1]:SetChildScale(2,Vector3.zero)
_this:delayDo(0.2,function()
_this.roles[1]:SetChildCanvasGroupAlpha(2,1)
_this.talkTween11=_this.roles[1]:SetChildDOScaleY(2,1.2,0.2,function()
if _this==nil then return end
_this.talkTween11=nil
_this.talkTween11=_this.roles[1]:SetChildDOScale(2,0.8,0.1,function()
if _this==nil then return end
_this.talkTween11=nil
return _this:talkEndone()
end)
end)
end)
end
function UISubAct_shizhuanchoujianWin:talkEndone()
if _this.speakShowTimerone then
_this:stopTimerByID(_this.speakShowTimerone)
_this.speakShowTimerone=nil
end
_this.speakShowTimerone=_this:delayDo(3.5,function()

if _this==nil then return end
_this.roles[1]:SetChildScale(2,Vector3.zero)
_this.roles[1]:SetChildCanvasGroupAlpha(2,0)

if _this.speakShowTimerone then
_this:stopTimerByID(_this.speakShowTimerone)
_this.speakShowTimerone=nil
end
end)
end


function UISubAct_shizhuanchoujianWin:doSpeaking_playertwo(speakType)
local cfg_speaks=cfg_lotteryact3config_get(_this.subid).speaks
local speakList=cfg_speaks[2][2]or{{"这位仙友，你也是来钓鱼的吗？"},{"吾纵横渔界多年，未逢一败，无敌真寂寞啊。"}}
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
_this.roles[2]:SetChildCanvasGroupAlpha(2,1)
_this.roles[2]:SetChildTrendsTextPlay(3,speakStr,speed,nil)
_this:doTalkAnim_playertwo()
end
function UISubAct_shizhuanchoujianWin:doTalkAnim_playertwo()
if _this.talkTween12~=nil then
_this.talkTween12:Kill()
_this.talkTween12=nil
end

_this.roles[2]:SetChildScale(2,Vector3.zero)
_this:delayDo(0.2,function()
_this.roles[2]:SetChildCanvasGroupAlpha(2,1)
_this.talkTween12=_this.roles[2]:SetChildDOScaleY(2,1.2,0.2,function()
if _this==nil then return end
_this.talkTween12=nil
_this.talkTween12=_this.roles[2]:SetChildDOScale(2,0.8,0.1,function()
if _this==nil then return end
_this.talkTween12=nil
return _this:talkEndtwo()
end)
end)
end)
end
function UISubAct_shizhuanchoujianWin:talkEndtwo()
if _this.speakShowTimerone2 then
_this:stopTimerByID(_this.speakShowTimerone2)
_this.speakShowTimerone2=nil
end
_this.speakShowTimerone2=_this:delayDo(2.8,function()

if _this==nil then return end
_this.roles[2]:SetChildScale(2,Vector3.zero)
_this.roles[2]:SetChildCanvasGroupAlpha(2,0)

if _this.speakShowTimerone2 then
_this:stopTimerByID(_this.speakShowTimerone2)
_this.speakShowTimerone2=nil
end
end)
end


function UISubAct_shizhuanchoujianWin:doSpeaking_playerthree(speakType)
local cfg_speaks=cfg_lotteryact3config_get(_this.subid).speaks
local speakList=cfg_speaks[3][2]or{{"这位仙友，你也是来钓鱼的吗？"},{"吾纵横渔界多年，未逢一败，无敌真寂寞啊。"}}
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
_this.roles[3]:SetChildCanvasGroupAlpha(2,1)
_this.roles[3]:SetChildTrendsTextPlay(3,speakStr,speed,nil)
_this:doTalkAnim_playerthree()
end
function UISubAct_shizhuanchoujianWin:doTalkAnim_playerthree()
if _this.talkTween13~=nil then
_this.talkTween13:Kill()
_this.talkTween13=nil
end

_this.roles[3]:SetChildScale(2,Vector3.zero)
_this:delayDo(0.2,function()
_this.roles[3]:SetChildCanvasGroupAlpha(2,1)
_this.talkTween13=_this.roles[3]:SetChildDOScaleY(2,1.2,0.2,function()
if _this==nil then return end
_this.talkTween13=nil
_this.talkTween13=_this.roles[3]:SetChildDOScale(2,0.8,0.1,function()
if _this==nil then return end
_this.talkTween13=nil
return _this:talkEndthree()
end)
end)
end)
end
function UISubAct_shizhuanchoujianWin:talkEndthree()
if _this.speakShowTimerone3 then
_this:stopTimerByID(_this.speakShowTimerone3)
_this.speakShowTimerone3=nil
end
_this.speakShowTimerone3=_this:delayDo(3,function()

if _this==nil then return end
_this.roles[3]:SetChildScale(2,Vector3.zero)
_this.roles[3]:SetChildCanvasGroupAlpha(2,0)

if _this.speakShowTimerone3 then
_this:stopTimerByID(_this.speakShowTimerone3)
_this.speakShowTimerone3=nil
end
end)
end


function UISubAct_shizhuanchoujianWin:doSpeaking_playerfour(speakType)
local cfg_speaks=cfg_lotteryact3config_get(_this.subid).speaks
local speakList=cfg_speaks[4][2]or{{"这位仙友，你也是来钓鱼的吗？"},{"吾纵横渔界多年，未逢一败，无敌真寂寞啊。"}}
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
_this.roles[4]:SetChildCanvasGroupAlpha(2,1)
_this.roles[4]:SetChildTrendsTextPlay(3,speakStr,speed,nil)
_this:doTalkAnim_playerfour()
end
function UISubAct_shizhuanchoujianWin:doTalkAnim_playerfour()
if _this.talkTween14~=nil then
_this.talkTween14:Kill()
_this.talkTween14=nil
end

_this.roles[4]:SetChildScale(2,Vector3.zero)
_this:delayDo(0.2,function()
_this.roles[4]:SetChildCanvasGroupAlpha(2,1)
_this.talkTween14=_this.roles[4]:SetChildDOScaleY(2,1.2,0.2,function()
if _this==nil then return end
_this.talkTween14=nil
_this.talkTween14=_this.roles[4]:SetChildDOScale(2,0.8,0.1,function()
if _this==nil then return end
_this.talkTween14=nil
return _this:talkEndfour()
end)
end)
end)
end
function UISubAct_shizhuanchoujianWin:talkEndfour()
if _this.speakShowTimerone4 then
_this:stopTimerByID(_this.speakShowTimerone4)
_this.speakShowTimerone4=nil
end
_this.speakShowTimerone4=_this:delayDo(3,function()

if _this==nil then return end
_this.roles[4]:SetChildScale(2,Vector3.zero)
_this.roles[4]:SetChildCanvasGroupAlpha(2,0)

if _this.speakShowTimerone4 then
_this:stopTimerByID(_this.speakShowTimerone4)
_this.speakShowTimerone4=nil
end
end)
end


function UISubAct_shizhuanchoujianWin:doSpeaking_playerfive(speakType)
local cfg_speaks=cfg_lotteryact3config_get(_this.subid).speaks
local speakList=cfg_speaks[5][2]or{{"这位仙友，你也是来钓鱼的吗？"},{"吾纵横渔界多年，未逢一败，无敌真寂寞啊。"}}
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
_this.roles[5]:SetChildCanvasGroupAlpha(2,1)
_this.roles[5]:SetChildTrendsTextPlay(3,speakStr,speed,nil)
_this:doTalkAnim_playerfive()
end
function UISubAct_shizhuanchoujianWin:doTalkAnim_playerfive()
if _this.talkTween15~=nil then
_this.talkTween15:Kill()
_this.talkTween15=nil
end

_this.roles[5]:SetChildScale(2,Vector3.zero)
_this:delayDo(0.2,function()
_this.roles[5]:SetChildCanvasGroupAlpha(2,1)
_this.talkTween15=_this.roles[5]:SetChildDOScaleY(2,1.2,0.2,function()
if _this==nil then return end
_this.talkTween15=nil
_this.talkTween15=_this.roles[5]:SetChildDOScale(2,0.8,0.1,function()
if _this==nil then return end
_this.talkTween15=nil
return _this:talkEndfive()
end)
end)
end)
end
function UISubAct_shizhuanchoujianWin:talkEndfive()
if _this.speakShowTimerone5 then
_this:stopTimerByID(_this.speakShowTimerone5)
_this.speakShowTimerone5=nil
end
_this.speakShowTimerone5=_this:delayDo(3,function()

if _this==nil then return end
_this.roles[5]:SetChildScale(2,Vector3.zero)
_this.roles[5]:SetChildCanvasGroupAlpha(2,0)

if _this.speakShowTimerone5 then
_this:stopTimerByID(_this.speakShowTimerone5)
_this.speakShowTimerone5=nil
end
end)
end



function UISubAct_shizhuanchoujianWin:doSpeaking_playerbuyin(index_right)
local cfg_speaks=cfg_lotteryact3config_get(_this.subid).buyspeaks
local speakList=cfg_speaks[1]or{{"这位仙友，你也是来钓鱼的吗？"},{"吾纵横渔界多年，未逢一败，无敌真寂寞啊。"}}
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
local widget=_this.rolebuys[index_right]:getWidgetBase()
widget:SetChildCanvasGroupAlpha(2,1)
widget:SetChildTrendsTextPlay(3,speakStr,speed,nil)
_this:doTalkAnim_playerbuyin(widget)
end
function UISubAct_shizhuanchoujianWin:doTalkAnim_playerbuyin(widget)
if _this.talkTweenbuyin1~=nil then
_this.talkTweenbuyin1:Kill()
_this.talkTweenbuyin1=nil
end

widget:SetChildScale(2,Vector3.zero)
_this:delayDo(0.2,function()
widget:SetChildCanvasGroupAlpha(2,1)
_this.talkTweenbuyin1=widget:SetChildDOScaleY(2,1.2,0.2,function()
if _this==nil then return end
_this.talkTweenbuyin1=nil
_this.talkTweenbuyin1=widget:SetChildDOScale(2,0.8,0.1,function()
if _this==nil then return end
_this.talkTweenbuyin1=nil
return _this:talkEndbuyin(widget)
end)
end)
end)
end
function UISubAct_shizhuanchoujianWin:talkEndbuyin(widget)
if _this.speakShowTimerbuyin1 then
_this:stopTimerByID(_this.speakShowTimerbuyin1)
_this.speakShowTimerbuyin1=nil
end
_this.speakShowTimerbuyin1=_this:delayDo(2,function()

if _this==nil then return end
widget:SetChildScale(2,Vector3.zero)
widget:SetChildCanvasGroupAlpha(2,0)

if _this.speakShowTimerbuyin1 then
_this:stopTimerByID(_this.speakShowTimerbuyin1)
_this.speakShowTimerbuyin1=nil
end
end)
end

function UISubAct_shizhuanchoujianWin:doSpeaking_playerbuyint(index_right)
local cfg_speaks=cfg_lotteryact3config_get(_this.subid).buyspeaks
local speakList=cfg_speaks[1]or{{"这位仙友，你也是来钓鱼的吗？"},{"吾纵横渔界多年，未逢一败，无敌真寂寞啊。"}}
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
local widget=_this.rolebuys[index_right]:getWidgetBase()
widget:SetChildCanvasGroupAlpha(2,1)
widget:SetChildTrendsTextPlay(3,speakStr,speed,nil)
_this:doTalkAnim_playerbuyint(widget)
end
function UISubAct_shizhuanchoujianWin:doTalkAnim_playerbuyint(widget)
if _this.talkTweenbuyin2~=nil then
_this.talkTweenbuyin2:Kill()
_this.talkTweenbuyin2=nil
end

widget:SetChildScale(2,Vector3.zero)
_this:delayDo(0.2,function()
widget:SetChildCanvasGroupAlpha(2,1)
_this.talkTweenbuyin2=widget:SetChildDOScaleY(2,1.2,0.2,function()
if _this==nil then return end
_this.talkTweenbuyin2=nil
_this.talkTweenbuyin2=widget:SetChildDOScale(2,0.8,0.1,function()
if _this==nil then return end
_this.talkTweenbuyin2=nil
return _this:talkEndbuyint(widget)
end)
end)
end)
end
function UISubAct_shizhuanchoujianWin:talkEndbuyint(widget)
if _this.speakShowTimerbuyin2 then
_this:stopTimerByID(_this.speakShowTimerbuyin2)
_this.speakShowTimerbuyin2=nil
end
_this.speakShowTimerbuyin2=_this:delayDo(2,function()

if _this==nil then return end
widget:SetChildScale(2,Vector3.zero)
widget:SetChildCanvasGroupAlpha(2,0)

if _this.speakShowTimerbuyin2 then
_this:stopTimerByID(_this.speakShowTimerbuyin2)
_this.speakShowTimerbuyin2=nil
end
end)
end

function UISubAct_shizhuanchoujianWin:doSpeaking_playerbuyinth(index_left)
local cfg_speaks=cfg_lotteryact3config_get(_this.subid).buyspeaks
local speakList=cfg_speaks[2]or{{"这位仙友，你也是来钓鱼的吗？"},{"吾纵横渔界多年，未逢一败，无敌真寂寞啊。"}}
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
local widget=_this.rolebuys[index_left]:getWidgetBase()
widget:SetChildCanvasGroupAlpha(2,1)
widget:SetChildTrendsTextPlay(3,speakStr,speed,nil)
_this:doTalkAnim_playerbuyinth(widget)
end
function UISubAct_shizhuanchoujianWin:doTalkAnim_playerbuyinth(widget)
if _this.talkTweenbuyin3~=nil then
_this.talkTweenbuyin3:Kill()
_this.talkTweenbuyin3=nil
end

widget:SetChildScale(2,Vector3.zero)
_this:delayDo(0.2,function()
widget:SetChildCanvasGroupAlpha(2,1)
_this.talkTweenbuyin3=widget:SetChildDOScaleY(2,1.2,0.2,function()
if _this==nil then return end
_this.talkTweenbuyin3=nil
_this.talkTweenbuyin3=widget:SetChildDOScale(2,0.8,0.1,function()
if _this==nil then return end
_this.talkTweenbuyin3=nil
return _this:talkEndbuyinth(widget)
end)
end)
end)
end
function UISubAct_shizhuanchoujianWin:talkEndbuyinth(widget)
if _this.speakShowTimerbuyin3 then
_this:stopTimerByID(_this.speakShowTimerbuyin3)
_this.speakShowTimerbuyin3=nil
end
_this.speakShowTimerbuyin3=_this:delayDo(2,function()

if _this==nil then return end
widget:SetChildScale(2,Vector3.zero)
widget:SetChildCanvasGroupAlpha(2,0)

if _this.speakShowTimerbuyin3 then
_this:stopTimerByID(_this.speakShowTimerbuyin3)
_this.speakShowTimerbuyin3=nil
end
end)
end

function UISubAct_shizhuanchoujianWin:doSpeaking_playerbuyinf(index_left)
local cfg_speaks=cfg_lotteryact3config_get(_this.subid).buyspeaks
local speakList=cfg_speaks[2]or{{"这位仙友，你也是来钓鱼的吗？"},{"吾纵横渔界多年，未逢一败，无敌真寂寞啊。"}}
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
local widget=_this.rolebuys[index_left]:getWidgetBase()
widget:SetChildCanvasGroupAlpha(2,1)
widget:SetChildTrendsTextPlay(3,speakStr,speed,nil)
_this:doTalkAnim_playerbuyinf(widget)
end
function UISubAct_shizhuanchoujianWin:doTalkAnim_playerbuyinf(widget)
if _this.talkTweenbuyin4~=nil then
_this.talkTweenbuyin4:Kill()
_this.talkTweenbuyin4=nil
end

widget:SetChildScale(2,Vector3.zero)
_this:delayDo(0.2,function()
widget:SetChildCanvasGroupAlpha(2,1)
_this.talkTweenbuyin4=widget:SetChildDOScaleY(2,1.2,0.2,function()
if _this==nil then return end
_this.talkTweenbuyin4=nil
_this.talkTweenbuyin4=widget:SetChildDOScale(2,0.8,0.1,function()
if _this==nil then return end
_this.talkTweenbuyin4=nil
return _this:talkEndbuyinf(widget)
end)
end)
end)
end
function UISubAct_shizhuanchoujianWin:talkEndbuyinf(widget)
if _this.speakShowTimerbuyin4 then
_this:stopTimerByID(_this.speakShowTimerbuyin4)
_this.speakShowTimerbuyin4=nil
end
_this.speakShowTimerbuyin4=_this:delayDo(2,function()

if _this==nil then return end
widget:SetChildScale(2,Vector3.zero)
widget:SetChildCanvasGroupAlpha(2,0)

if _this.speakShowTimerbuyin4 then
_this:stopTimerByID(_this.speakShowTimerbuyin4)
_this.speakShowTimerbuyin4=nil
end
end)
end


function UISubAct_shizhuanchoujianWin:buyspeak()
local left1=math.random(1,2)
local left2=math.random(3,4)
local right1=math.random(5,7)
local right2=math.random(8,10)
_this:delayDo(0.2,function()
UISubAct_shizhuanchoujianWin:doSpeaking_playerbuyin(right1)
UISubAct_shizhuanchoujianWin:doSpeaking_playerbuyinth(left1)
end)
_this:delayDo(0.4,function()
UISubAct_shizhuanchoujianWin:doSpeaking_playerbuyint(right2)
UISubAct_shizhuanchoujianWin:doSpeaking_playerbuyinf(left2)
end)
end


function UISubAct_shizhuanchoujianWin:UpdateViewone()
if _this.refreshTimeId then
_this:stopTimerByID(_this.refreshTimeId)
_this.refreshTimeId=nil
end
_this.refreshTimeFunc=function()
local fun=function()
if _this==nil then return end
_this.roles[6]:SetChildModelAnimationState(1,eAnimationID.stand)
end
if _this==nil then return end
_this.rolestwordone=-_this.rolestwordone
_this.roles[6]:SetChildModelAnimationState(1,eAnimationID.walk)
_this.roles[6]:SetChildUIModelShowFlipX(1,_this.rolestwordone==1)

if _this.rolestwordone==1 then
local tweener=_this.roles[6]:SetChildDOAnchorPosX(0,_this.rightpointtop[1],3,fun)
tweener:SetEase(_Ease.Linear)
elseif _this.rolestwordone==-1 then
local tweener=_this.roles[6]:SetChildDOAnchorPosX(0,_this.leftpointtop[1],4,fun)
tweener:SetEase(_Ease.Linear)
end
end
_this.refreshTimeFunc()
_this.refreshTimeId=_this:setTimer(9,0,_this.refreshTimeFunc)
end


function UISubAct_shizhuanchoujianWin:UpdateViewtwo()
if _this.refreshTimeId2 then
_this:stopTimerByID(_this.refreshTimeId2)
_this.refreshTimeId2=nil
end
local isinit=true
_this.refreshTimeFunc2=function()
local fun=function()
if _this==nil then return end
_this.roles[3]:SetChildModelAnimationState(1,eAnimationID.stand)
end
if _this==nil then return end
_this.rolestwordtwo=-_this.rolestwordtwo
if not isinit and _this.gddiziguid[3]then


local guid
local disciplesList=UIDiscipleModel:getAllDiscipleData()
for k,v in pairs(disciplesList)do
local netdata=v.netData
local isget=true
if UIDiscipleModel:getDiscipleName(netdata.net.discipleguid)~='元润'then
for i,j in ipairs(_this.gddiziguid)do
if j==netdata.net.discipleguid then
isget=false
end
end
if isget then
guid=netdata.net.discipleguid
break
end
end
end

if guid then
if type(guid)=="number"then
local info5=UIDiscipleModel:getDiscipleDataByDiziId(guid).imageInfo
local modelParams5=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info5)
_this.roles[3]:SetChildUIModelShowTarget(1,modelParams5.body,1,modelParams5.componets,eAnimationID.stand,false,false,0.1)
else
_this.gddiziguid[3]=guid
local info5=UIDiscipleModel:getDiscipleImageInfo(guid)
local modelParams5=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info5)
_this.roles[3]:SetChildUIModelShowTarget(1,modelParams5.body,1,modelParams5.componets,eAnimationID.stand,false,false,0.1)
end
end
end
_this.roles[3]:SetChildModelAnimationState(1,eAnimationID.walk)
_this.roles[3]:SetChildUIModelShowFlipX(1,_this.rolestwordtwo==1)

if _this.rolestwordtwo==1 then
_this.tweener31=_this.roles[3]:SetChildDOAnchorPos(0,Vector2.New(_this.rightpoint3[1],_this.rightpoint3[2]),27,fun)
_this.tweener31:SetEase(_Ease.Linear)
elseif _this.rolestwordtwo==-1 then
_this.tweener31=_this.roles[3]:SetChildDOAnchorPos(0,Vector2.New(_this.leftpoint3[1],_this.leftpoint3[2]),24,fun)
_this.tweener31:SetEase(_Ease.Linear)
end
end
_this.refreshTimeFunc2()
isinit=false
_this.refreshTimeId2=_this:setTimer(50,0,_this.refreshTimeFunc2)

local cfg_speaks=cfg_lotteryact3config_get(_this.subid).speaks
local speaktime3=cfg_speaks[3][1]or 5
if _this.refreshTimeIdspeak2 then
_this:stopTimerByID(_this.refreshTimeIdspeak2)
_this.refreshTimeIdspeak2=nil
end
_this.refreshTimeIdspeak2=_this:setTimer(speaktime3,0,function()
if _this==nil then return end
UISubAct_shizhuanchoujianWin:doSpeaking_playerthree()
end)
end


function UISubAct_shizhuanchoujianWin:UpdateViewthree()
if _this.refreshTimeId3 then
_this:stopTimerByID(_this.refreshTimeId3)
_this.refreshTimeId3=nil
end
local isinit4=true
_this.refreshTimeFunc3=function()
local fun=function()
if _this==nil then return end
_this.roles[4]:SetChildModelAnimationState(1,eAnimationID.stand)
end
if _this==nil then return end
_this.rolestwordthree=-_this.rolestwordthree

if not isinit4 and _this.gddiziguid[4]then


local guid
local disciplesList=UIDiscipleModel:getAllDiscipleData()
for k,v in pairs(disciplesList)do
local netdata=v.netData
local isget=true
if UIDiscipleModel:getDiscipleName(netdata.net.discipleguid)~='元润'then
for i,j in ipairs(_this.gddiziguid)do
if j==netdata.net.discipleguid then
isget=false
end
end
if isget then
guid=netdata.net.discipleguid
break
end
end
end

if guid then
if type(guid)=="number"then
local info5=UIDiscipleModel:getDiscipleDataByDiziId(guid).imageInfo
local modelParams5=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info5)
_this.roles[4]:SetChildUIModelShowTarget(1,modelParams5.body,1,modelParams5.componets,eAnimationID.stand,false,false,0.1)
else
_this.gddiziguid[4]=guid
local info5=UIDiscipleModel:getDiscipleImageInfo(guid)
local modelParams5=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info5)
_this.roles[4]:SetChildUIModelShowTarget(1,modelParams5.body,1,modelParams5.componets,eAnimationID.stand,false,false,0.1)
end
end
end
_this.roles[4]:SetChildModelAnimationState(1,eAnimationID.walk)
_this.roles[4]:SetChildUIModelShowFlipX(1,_this.rolestwordthree==1)
if _this.rolestwordthree==1 then
_this.tweener41=_this.roles[4]:SetChildDOAnchorPos(0,Vector2.New(_this.rightpoint4[1],_this.rightpoint4[2]),15,fun)
_this.tweener41:SetEase(_Ease.Linear)
elseif _this.rolestwordthree==-1 then
_this.tweener41=_this.roles[4]:SetChildDOAnchorPos(0,Vector2.New(_this.leftpoint4[1],_this.leftpoint4[2]),19,fun)
_this.tweener41:SetEase(_Ease.Linear)
end
end
_this.refreshTimeFunc3()
isinit4=false
_this.refreshTimeId3=_this:setTimer(26,0,_this.refreshTimeFunc3)

if _this.refreshTimeIdspeak3 then
_this:stopTimerByID(_this.refreshTimeIdspeak3)
_this.refreshTimeIdspeak3=nil
end

local cfg_speaks=cfg_lotteryact3config_get(_this.subid).speaks
local speaktime4=cfg_speaks[4][1]or 7
_this.refreshTimeIdspeak3=_this:setTimer(speaktime4,0,function()
if _this==nil then return end
UISubAct_shizhuanchoujianWin:doSpeaking_playerfive()
end)
end


function UISubAct_shizhuanchoujianWin:UpdateViewfour()
if _this.refreshTimeId4 then
_this:stopTimerByID(_this.refreshTimeId4)
_this.refreshTimeId4=nil
end
local isinit5=true
_this.refreshTimeFunc4=function()
local fun=function()
if _this==nil then return end
_this.roles[5]:SetChildModelAnimationState(1,eAnimationID.stand)
end
if _this==nil then return end
_this.rolestwordfour=-_this.rolestwordfour
if not isinit5 and _this.gddiziguid[5]then


local guid
local disciplesList=UIDiscipleModel:getAllDiscipleData()
for k,v in pairs(disciplesList)do
local netdata=v.netData
local isget=true
if UIDiscipleModel:getDiscipleName(netdata.net.discipleguid)~='元润'then
for i,j in ipairs(_this.gddiziguid)do
if j==netdata.net.discipleguid then
isget=false
end
end
if isget then
guid=netdata.net.discipleguid
break
end
end
end

if guid then
if type(guid)=="number"then
local info5=UIDiscipleModel:getDiscipleDataByDiziId(guid).imageInfo
local modelParams5=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info5)
_this.roles[5]:SetChildUIModelShowTarget(1,modelParams5.body,1,modelParams5.componets,eAnimationID.stand,false,false,0.1)
else
_this.gddiziguid[5]=guid
local info5=UIDiscipleModel:getDiscipleImageInfo(guid)
local modelParams5=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info5)
_this.roles[5]:SetChildUIModelShowTarget(1,modelParams5.body,1,modelParams5.componets,eAnimationID.stand,false,false,0.1)
end
end
end
_this.roles[5]:SetChildModelAnimationState(1,eAnimationID.walk)
_this.roles[5]:SetChildUIModelShowFlipX(1,_this.rolestwordfour==1)
if _this.rolestwordfour==1 then
_this.tweener51=_this.roles[5]:SetChildDOAnchorPos(0,Vector2.New(_this.rightpoint5[1],_this.rightpoint5[2]),22,fun)
_this.tweener51:SetEase(_Ease.Linear)
elseif _this.rolestwordfour==-1 then
_this.tweener51=_this.roles[5]:SetChildDOAnchorPos(0,Vector2.New(_this.leftpoint5[1],_this.leftpoint5[2]),16,fun)
_this.tweener51:SetEase(_Ease.Linear)
end
end
_this.refreshTimeFunc4()
isinit5=false
_this.refreshTimeId4=_this:setTimer(30,0,_this.refreshTimeFunc4)

if _this.refreshTimeIdspeak4 then
_this:stopTimerByID(_this.refreshTimeIdspeak4)
_this.refreshTimeIdspeak4=nil
end

local cfg_speaks=cfg_lotteryact3config_get(_this.subid).speaks
local speaktime4=cfg_speaks[4][1]or 7
_this.refreshTimeIdspeak4=_this:setTimer(speaktime4,0,function()
if _this==nil then return end
UISubAct_shizhuanchoujianWin:doSpeaking_playerfour()
end)
end


function UISubAct_shizhuanchoujianWin:OpeanRoleWalkpanel(id)
if id==1 then
_this.rolepanel:setChildCanvasGroupDOFade(0,0.8)
_this.rolepaneltop:setChildCanvasGroupDOFade(0,0.8)
_this.uipanel:setChildCanvasGroupDOFade(0,0.8)
else
_this.rolepanel:setChildCanvasGroupDOFade(1,1.5)
_this.rolepaneltop:setChildCanvasGroupDOFade(1,1.5)
_this.uipanel:setChildCanvasGroupDOFade(1,1.5)
end
end


function UISubAct_shizhuanchoujianWin:handelShowBuySuccess()

if not _this.jumpAnimationclick then
_this.animadoing=true
_this.masks:setActive(true)

UISubAct_shizhuanchoujianWin:OpeanRoleWalkpanel(1)
_this.buyrolepanel:setChildCanvasGroupAlpha(0,0)
_this.buyrolepanelout:setChildCanvasGroupDOFade(0,1)

UISubAct_shizhuanchoujianWin:jintougoing()


if _this.choujiantype==1 then

AudioManager.playAudio(658)
elseif _this.choujiantype==10 then

AudioManager.playAudio(657)
end

_this.animnplay=_this:delayDo(0.8,function()
if _this==nil then return end
UISubAct_shizhuanchoujianWin:DoInRoleBuyAnima()
end)
else
_this.masks:setActive(false)
UISubAct_shizhuanchoujianWin:showJieSuanWin()
end
end


function UISubAct_shizhuanchoujianWin:DoInRoleBuyAnima()
_this.buyrolepanel:setChildCanvasGroupAlpha(0)


if _this.buyrolesout and#_this.buyrolesout>0 then
for i=1,#_this.buyrolesout do
_this.buyrolesout[i]:SetChildAnchoredPosition(0,Vector2(-1053,0))
end
end
if _this.buyrolesoneout and#_this.buyrolesoneout>0 then
for i=1,#_this.buyrolesoneout do
_this.buyrolesoneout[i]:SetChildAnchoredPosition(0,Vector2(-1053,0))
end
end


local list_1={}
local list={1,2,3,4,5,6,7,8,9,10}
local num=10
for i=1,10 do
local r=math.random(1,num-i+1)
local a=list[r]
table.insert(list_1,a)
local templist={}
for k,v in ipairs(list)do
if v==list[r]then
else
templist[#templist+1]=v
end
end
list=templist
end

_this.modelbuys={}
for i=1,10 do
_this.modelbuys[#_this.modelbuys+1]=new_buy_modelid[list_1[i]]
end
UISubAct_shizhuanchoujianWin:refreshShopbubble()

if _this.choujiantype==1 then
_this.buyrolepanel:setChildCanvasGroupAlpha(1)
_this.buyrolesone={}
_this.buyrolesone[#_this.buyrolesone+1]=_this.rolebuys[1]:getWidgetBase()

local cspos=buycspoint[1]
local centerpos=buyCenterpoint[1]
local lastpos=buyxiaoshipoint[1]
local tword=cspos[1]<centerpos[1]
_this.buyrolesone[1]:SetChildAnchoredPosition(0,Vector2(cspos[1],cspos[2]))
_this.buyrolesone[1]:SetChildCanvasGroupAlpha(0,1)
_this.buyrolesone[1]:SetChildUIModelShowTarget(1,_this.modelbuys[1],1,{},eAnimationID.stand,false,false,0.1)
_this.buyrolesone[1]:SetChildUIModelShowFlipX(1,tword)

_this.buyrolesone[1]:SetChildModelAnimationState(1,eAnimationID.run)
local fun1=function()
if _this==nil then return end
local tweener12=_this.buyrolesone[1]:SetChildDOAnchorPos(0,Vector2.New(lastpos[1],lastpos[2]),1,nil)
tweener12:SetEase(_Ease.Linear)
_this.buyroletime1=_this:delayDo(0.5,function()
if _this==nil then return end
_this.buyrolesone[1]:SetChildCanvasGroupDOFade(0,0,0.5)
if _this.suitbacklist and#_this.suitbacklist>0 then
UISubAct_shizhuanchoujianWin:shopimgshow()
end
if _this.buyroletime1 then
_this:stopTimerByID(_this.buyroletime1)
_this.buyroletime1=nil
end
end)
end
local tweener12=_this.buyrolesone[1]:SetChildDOAnchorPos(0,Vector2.New(centerpos[1],centerpos[2]),1,fun1)
tweener12:SetEase(_Ease.Linear)


_this:delayDo(2.3,function()
if _this==nil then return end
if _this.suitbacklist and#_this.suitbacklist>0 then
_this.out_effect:setChildShowEffect(10379,true)
else
_this.out_effect:setChildShowEffect(10378,true)
end
end)

_this:delayDo(3,function()
UISubAct_shizhuanchoujianWin:DoOutRoleBuyAnima()
UISubAct_shizhuanchoujianWin:doSpeaking_player(shopspeaktype.danchou)
end)


elseif _this.choujiantype==10 then
_this.buyrolepanel:setChildCanvasGroupAlpha(1)
local randomrole=10
_this.buyroles={}
for i=1,randomrole do
local widget=_this.rolebuys[i]:getWidgetBase()
_this.buyroles[#_this.buyroles+1]=widget
end

UISubAct_shizhuanchoujianWin:buyspeak()

local cspos=buycspoint[1]
local centerpos=buyCenterpoint[1]
local lastpos=buyxiaoshipoint[1]
local tword=cspos[1]<centerpos[1]
_this.buyroles[1]:SetChildAnchoredPosition(0,Vector2(cspos[1],cspos[2]))
_this.buyroles[1]:SetChildCanvasGroupAlpha(0,1)
_this.buyroles[1]:SetChildUIModelShowTarget(1,_this.modelbuys[2],1,{},eAnimationID.stand,false,false,0.1)
_this.buyroles[1]:SetChildUIModelShowFlipX(1,tword)

_this.buyroles[1]:SetChildModelAnimationState(1,eAnimationID.run)
local fun21=function()
if _this==nil then return end
local tweener21=_this.buyroles[1]:SetChildDOAnchorPos(0,Vector2.New(lastpos[1],lastpos[2]),1,nil)
tweener21:SetEase(_Ease.Linear)
_this.buyroletime21=_this:delayDo(0.5,function()
if _this==nil then return end
_this.buyroles[1]:SetChildCanvasGroupDOFade(0,0,0.5)
if _this.buyroletime21 then
_this:stopTimerByID(_this.buyroletime21)
_this.buyroletime21=nil
end
end)
end
local tweener21=_this.buyroles[1]:SetChildDOAnchorPos(0,Vector2.New(centerpos[1],centerpos[2]),1,fun21)
tweener21:SetEase(_Ease.Linear)


_this:delayDo(0.5,function()
local cspos2=buycspoint[2]
local centerpos2=buyCenterpoint[1]
local lastpos2=buyxiaoshipoint[1]
local tword2=cspos2[1]<centerpos2[1]
_this.buyroles[2]:SetChildAnchoredPosition(0,Vector2(cspos2[1],cspos2[2]))
_this.buyroles[2]:SetChildCanvasGroupAlpha(0,1)
_this.buyroles[2]:SetChildUIModelShowTarget(1,_this.modelbuys[2],1,{},eAnimationID.stand,false,false,0.1)
_this.buyroles[2]:SetChildUIModelShowFlipX(1,tword2)

_this.buyroles[2]:SetChildModelAnimationState(1,eAnimationID.run)
local fun22=function()
if _this==nil then return end
local tweener22=_this.buyroles[2]:SetChildDOAnchorPos(0,Vector2.New(lastpos2[1],lastpos2[2]),1,nil)
tweener22:SetEase(_Ease.Linear)
_this.buyroletime22=_this:delayDo(0.5,function()
if _this==nil then return end
_this.buyroles[2]:SetChildCanvasGroupDOFade(0,0,0.5)
if _this.suitbacklist and#_this.suitbacklist>0 then
UISubAct_shizhuanchoujianWin:shopimgshow()
end
if _this.buyroletime22 then
_this:stopTimerByID(_this.buyroletime22)
_this.buyroletime22=nil
end
end)
end
local tweener22=_this.buyroles[2]:SetChildDOAnchorPos(0,Vector2.New(centerpos2[1]+10,centerpos2[2]+2),2,fun22)
tweener22:SetEase(_Ease.Linear)
end)


local cspos3=buycspoint[3]
local centerpos3=buyCenterpoint[1]
local lastpos3=buyxiaoshipoint[1]
local tword3=cspos3[1]<centerpos3[1]
_this.buyroles[3]:SetChildAnchoredPosition(0,Vector2(cspos3[1],cspos3[2]))
_this.buyroles[3]:SetChildCanvasGroupAlpha(0,1)
_this.buyroles[3]:SetChildUIModelShowTarget(1,_this.modelbuys[3],1,{},eAnimationID.stand,false,false,0.1)
_this.buyroles[3]:SetChildUIModelShowFlipX(1,tword3)

_this.buyroles[3]:SetChildModelAnimationState(1,eAnimationID.run)
local fun23=function()
if _this==nil then return end
local tweener23=_this.buyroles[3]:SetChildDOAnchorPos(0,Vector2.New(lastpos3[1],lastpos3[2]),1.5,nil)
tweener23:SetEase(_Ease.Linear)
_this.buyroletime23=_this:delayDo(0.5,function()
if _this==nil then return end
_this.buyroles[3]:SetChildCanvasGroupDOFade(0,0,0.5)
if _this.buyroletime23 then
_this:stopTimerByID(_this.buyroletime23)
_this.buyroletime23=nil
end
end)
end
local tweener23=_this.buyroles[3]:SetChildDOAnchorPos(0,Vector2.New(centerpos3[1],centerpos3[2]),2,fun23)
tweener23:SetEase(_Ease.Linear)


local cspos4=buycspoint[4]
local centerpos4=buyCenterpoint[1]
local lastpos4=buyxiaoshipoint[1]
local tword4=cspos4[1]<centerpos4[1]
_this.buyroles[4]:SetChildAnchoredPosition(0,Vector2(cspos4[1],cspos4[2]))
_this.buyroles[4]:SetChildCanvasGroupAlpha(0,1)
_this.buyroles[4]:SetChildUIModelShowTarget(1,_this.modelbuys[4],1,{},eAnimationID.stand,false,false,0.1)
_this.buyroles[4]:SetChildUIModelShowFlipX(1,tword4)

_this.buyroles[4]:SetChildModelAnimationState(1,eAnimationID.run)
local fun24=function()
if _this==nil then return end
local tweener24=_this.buyroles[4]:SetChildDOAnchorPos(0,Vector2.New(lastpos4[1],lastpos4[2]),1.5,nil)
tweener24:SetEase(_Ease.Linear)
_this.buyroletime24=_this:delayDo(0.5,function()
if _this==nil then return end
_this.buyroles[4]:SetChildCanvasGroupDOFade(0,0,0.5)
if _this.buyroletime24 then
_this:stopTimerByID(_this.buyroletime24)
_this.buyroletime24=nil
end
end)
end
local tweener24=_this.buyroles[4]:SetChildDOAnchorPos(0,Vector2.New(centerpos4[1]+12,centerpos4[2]+1),2,fun24)
tweener24:SetEase(_Ease.Linear)


_this:delayDo(0.3,function()
local cspos5=buycspoint[5]
local centerpos5=buyCenterpoint[2]
local lastpos5=buyxiaoshipoint[1]
local tword5=cspos5[1]<centerpos5[1]
_this.buyroles[5]:SetChildAnchoredPosition(0,Vector2(cspos5[1],cspos5[2]))
_this.buyroles[5]:SetChildCanvasGroupAlpha(0,1)
_this.buyroles[5]:SetChildUIModelShowTarget(1,_this.modelbuys[5],1,{},eAnimationID.stand,false,false,0.1)
_this.buyroles[5]:SetChildUIModelShowFlipX(1,tword5)

_this.buyroles[5]:SetChildModelAnimationState(1,eAnimationID.run)
local fun25=function()
if _this==nil then return end
local tweener25=_this.buyroles[5]:SetChildDOAnchorPos(0,Vector2.New(lastpos5[1],lastpos5[2]),1,nil)
tweener25:SetEase(_Ease.Linear)
_this.buyroletime25=_this:delayDo(0.5,function()
if _this==nil then return end
_this.buyroles[5]:SetChildCanvasGroupDOFade(0,0,0.5)
if _this.buyroletime25 then
_this:stopTimerByID(_this.buyroletime25)
_this.buyroletime25=nil
end
end)
end
local tweener25=_this.buyroles[5]:SetChildDOAnchorPos(0,Vector2.New(centerpos5[1]-5,centerpos5[2]+5),1,fun25)
tweener25:SetEase(_Ease.Linear)
end)


local cspos6=buycspoint[6]
local centerpos6=buyCenterpoint[2]
local lastpos6=buyxiaoshipoint[1]
local tword6=cspos6[1]<centerpos6[1]
_this.buyroles[6]:SetChildAnchoredPosition(0,Vector2(cspos6[1],cspos6[2]))
_this.buyroles[6]:SetChildCanvasGroupAlpha(0,1)
_this.buyroles[6]:SetChildUIModelShowTarget(1,_this.modelbuys[6],1,{},eAnimationID.stand,false,false,0.1)
_this.buyroles[6]:SetChildUIModelShowFlipX(1,tword6)

_this.buyroles[6]:SetChildModelAnimationState(1,eAnimationID.run)
local fun26=function()
if _this==nil then return end
local tweener26=_this.buyroles[6]:SetChildDOAnchorPos(0,Vector2.New(lastpos6[1],lastpos6[2]),1.5,nil)
tweener26:SetEase(_Ease.Linear)
_this.buyroletime26=_this:delayDo(0.5,function()
if _this==nil then return end
_this.buyroles[6]:SetChildCanvasGroupDOFade(0,0,0.5)
if _this.buyroletime26 then
_this:stopTimerByID(_this.buyroletime26)
_this.buyroletime26=nil
end
end)
end
local tweener26=_this.buyroles[6]:SetChildDOAnchorPos(0,Vector2.New(centerpos6[1]-8,centerpos6[2]),2.1,fun26)
tweener26:SetEase(_Ease.Linear)



_this:delayDo(0.4,function()
local cspos7=buycspoint[7]
local centerpos7=buyCenterpoint[2]
local lastpos7=buyxiaoshipoint[1]
local tword7=cspos7[1]<centerpos7[1]
_this.buyroles[7]:SetChildAnchoredPosition(0,Vector2(cspos7[1],cspos7[2]))
_this.buyroles[7]:SetChildCanvasGroupAlpha(0,1)
_this.buyroles[7]:SetChildUIModelShowTarget(1,_this.modelbuys[7],1,{},eAnimationID.stand,false,false,0.1)
_this.buyroles[7]:SetChildUIModelShowFlipX(1,tword7)

_this.buyroles[7]:SetChildModelAnimationState(1,eAnimationID.run)
local fun27=function()
if _this==nil then return end
local tweener27=_this.buyroles[7]:SetChildDOAnchorPos(0,Vector2.New(lastpos7[1]-12,lastpos7[2]-2),1.5,nil)
tweener27:SetEase(_Ease.Linear)
_this.buyroletime27=_this:delayDo(0.5,function()
if _this==nil then return end
_this.buyroles[7]:SetChildCanvasGroupDOFade(0,0,0.5)
if _this.buyroletime27 then
_this:stopTimerByID(_this.buyroletime27)
_this.buyroletime27=nil
end
end)
end
local tweener27=_this.buyroles[7]:SetChildDOAnchorPos(0,Vector2.New(centerpos7[1]-13,centerpos7[2]-5),2,fun27)
tweener27:SetEase(_Ease.Linear)
end)


_this:delayDo(0.3,function()
local cspos8=buycspoint[8]
local centerpos8=buyCenterpoint[2]
local lastpos8=buyxiaoshipoint[1]
local tword8=cspos8[1]<centerpos8[1]
_this.buyroles[8]:SetChildAnchoredPosition(0,Vector2(cspos8[1],cspos8[2]))
_this.buyroles[8]:SetChildCanvasGroupAlpha(0,1)
_this.buyroles[8]:SetChildUIModelShowTarget(1,_this.modelbuys[8],1,{},eAnimationID.stand,false,false,0.1)
_this.buyroles[8]:SetChildUIModelShowFlipX(1,tword8)

_this.buyroles[8]:SetChildModelAnimationState(1,eAnimationID.run)
local fun28=function()
if _this==nil then return end
local tweener28=_this.buyroles[8]:SetChildDOAnchorPos(0,Vector2.New(lastpos8[1]-14,lastpos8[2]),1,nil)
tweener28:SetEase(_Ease.Linear)
_this.buyroletime28=_this:delayDo(0.5,function()
if _this==nil then return end
_this.buyroles[8]:SetChildCanvasGroupDOFade(0,0,0.5)
if _this.buyroletime28 then
_this:stopTimerByID(_this.buyroletime28)
_this.buyroletime28=nil
end
end)
end
local tweener28=_this.buyroles[8]:SetChildDOAnchorPos(0,Vector2.New(centerpos8[1]-15,centerpos8[2]),2,fun28)
tweener28:SetEase(_Ease.Linear)
end)


_this:delayDo(0.5,function()
local cspos9=buycspoint[9]
local centerpos9=buyCenterpoint[2]
local lastpos9=buyxiaoshipoint[1]
local tword9=cspos9[1]<centerpos9[1]
_this.buyroles[9]:SetChildAnchoredPosition(0,Vector2(cspos9[1],cspos9[2]))
_this.buyroles[9]:SetChildCanvasGroupAlpha(0,1)
_this.buyroles[9]:SetChildUIModelShowTarget(1,_this.modelbuys[9],1,{},eAnimationID.stand,false,false,0.1)
_this.buyroles[9]:SetChildUIModelShowFlipX(1,tword9)

_this.buyroles[9]:SetChildModelAnimationState(1,eAnimationID.run)
local fun29=function()
if _this==nil then return end
local tweener29=_this.buyroles[9]:SetChildDOAnchorPos(0,Vector2.New(lastpos9[1],lastpos9[2]),1.5,nil)
tweener29:SetEase(_Ease.Linear)
_this.buyroletime29=_this:delayDo(0.5,function()
if _this==nil then return end
_this.buyroles[9]:SetChildCanvasGroupDOFade(0,0,0.5)
if _this.buyroletime29 then
_this:stopTimerByID(_this.buyroletime29)
_this.buyroletime29=nil
end
end)
end
local tweener29=_this.buyroles[9]:SetChildDOAnchorPos(0,Vector2.New(centerpos9[1],centerpos9[2]),2,fun29)
tweener29:SetEase(_Ease.Linear)
end)


_this:delayDo(0.5,function()
local cspos10=buycspoint[10]
local centerpos10=buyCenterpoint[2]
local lastpos10=buyxiaoshipoint[1]
local tword10=cspos10[1]<centerpos10[1]
_this.buyroles[10]:SetChildAnchoredPosition(0,Vector2(cspos10[1],cspos10[2]))
_this.buyroles[10]:SetChildCanvasGroupAlpha(0,1)
_this.buyroles[10]:SetChildUIModelShowTarget(1,_this.modelbuys[10],1,{},eAnimationID.stand,false,false,0.1)
_this.buyroles[10]:SetChildUIModelShowFlipX(1,tword10)

_this.buyroles[10]:SetChildModelAnimationState(1,eAnimationID.run)
local fun210=function()
if _this==nil then return end
local tweener210=_this.buyroles[10]:SetChildDOAnchorPos(0,Vector2.New(lastpos10[1],lastpos10[2]),1.2,nil)
tweener210:SetEase(_Ease.Linear)
_this.buyroletime210=_this:delayDo(0.5,function()
if _this==nil then return end
_this.buyroles[10]:SetChildCanvasGroupDOFade(0,0,0.5)
if _this.buyroletime210 then
_this:stopTimerByID(_this.buyroletime210)
_this.buyroletime210=nil
end
end)
end
local tweener210=_this.buyroles[10]:SetChildDOAnchorPos(0,Vector2.New(centerpos10[1],centerpos10[2]),2.2,fun210)
tweener210:SetEase(_Ease.Linear)
end)


_this:delayDo(4.1,function()
if _this==nil then return end
if _this.suitbacklist and#_this.suitbacklist>0 then
_this.out_effect:setChildShowEffect(10379,true)
else
_this.out_effect:setChildShowEffect(10378,true)
end
end)


_this:delayDo(4.8,function()
UISubAct_shizhuanchoujianWin:DoOutRoleBuyAnima()
UISubAct_shizhuanchoujianWin:doSpeaking_player(shopspeaktype.lianchou)
end)
end
end


function UISubAct_shizhuanchoujianWin:DoOutRoleBuyAnima()
UISubAct_shizhuanchoujianWin:jintououting()

if _this.suitbacklist and#_this.suitbacklist>0 then
for k,v in ipairs(_this.suitbacklist)do
if _this.modelbuys[k]then
_this.modelbuys[k]=v[2]
end
end
end
_this.buyrolepanelout:setChildCanvasGroupAlpha(0)


if _this.choujiantype==1 then
_this.buyrolepanelout:setChildCanvasGroupAlpha(1)
_this.buyrolesoneout={}
_this.buyrolesoneout[#_this.buyrolesoneout+1]=_this.Pbuyrole:getWidgetBase()
_this.buyrolesoneout[1]:SetChildCanvasGroupAlpha(-1,1)
local lastpos=buyxiaoshipoint[1]
local centerpos=buyoutcenpoint[2]
local outpos=buyoutpoint[4]
local tword=outpos[1]>centerpos[1]
_this.buyrolesoneout[1]:SetChildAnchoredPosition(0,Vector2(lastpos[1],lastpos[2]))
_this.buyrolesoneout[1]:SetChildUIModelShowTarget(1,_this.modelbuys[1],1,{},eAnimationID.stand,false,false,0.1)
_this.buyrolesoneout[1]:SetChildUIModelShowFlipX(1,tword)


if _this.suitbacklist[1]then
_this.buyrolesoneout[1]:SetChildModelAnimationState(1,eAnimationID.walk)
else
_this.buyrolesoneout[1]:SetChildModelAnimationState(1,eAnimationID.walk2)
end
_this.buyrolesoneout[1]:SetChildCanvasGroupDOFade(0,1,0.5)
local fun=function()
if _this==nil then return end
local fun2=function()
if _this==nil then return end
_this.buyrolesoneout[1]:SetChildCanvasGroupDOFade(-1,0,0.2)
_this.buyrolesoneout[1]:SetChildModelAnimationState(1,eAnimationID.stand)
end
local tweener12=_this.buyrolesoneout[1]:SetChildDOAnchorPos(0,Vector2.New(outpos[1],outpos[2]),6,fun2)
tweener12:SetEase(_Ease.Linear)
end
local tweener12=_this.buyrolesoneout[1]:SetChildDOAnchorPos(0,Vector2.New(centerpos[1],centerpos[2]),1.2,fun)
tweener12:SetEase(_Ease.Linear)


_this:delayDo(3,function()
if _this==nil then return end
UISubAct_shizhuanchoujianWin:showJieSuanWin()
end)


elseif _this.choujiantype==10 then
_this.buyrolepanelout:setChildCanvasGroupAlpha(1)
local randomrole=10
_this.buyrolesout={}
for i=1,randomrole do
local widget=_this.rolebuysout[i]:getWidgetBase()
_this.buyrolesout[#_this.buyrolesout+1]=widget
end


_this.outrole1=_this:delayDo(4.5,function()
_this.buyrolesout[1]:SetChildCanvasGroupAlpha(-1,1)
local lastpos=buyxiaoshipoint[1]
local centerpos=buyoutcenpoint[2]
local outpos=buyoutpoint[4]
local tword=outpos[1]>centerpos[1]
_this.buyrolesout[1]:SetChildAnchoredPosition(0,Vector2(lastpos[1],lastpos[2]))
_this.buyrolesout[1]:SetChildUIModelShowTarget(1,_this.modelbuys[1],1,{},eAnimationID.stand,false,false,0.1)
_this.buyrolesout[1]:SetChildUIModelShowFlipX(1,tword)


if _this.suitbacklist[1]then
_this.buyrolesout[1]:SetChildModelAnimationState(1,eAnimationID.walk)
else
_this.buyrolesout[1]:SetChildModelAnimationState(1,eAnimationID.walk2)
end
_this.buyrolesout[1]:SetChildCanvasGroupDOFade(0,1,1.5)
local fun11=function()
if _this==nil then return end
local fun12=function()
if _this==nil then return end
_this.buyrolesout[1]:SetChildCanvasGroupDOFade(-1,0,0.2)
_this.buyrolesout[1]:SetChildModelAnimationState(1,eAnimationID.stand)
end
local tweener21=_this.buyrolesout[1]:SetChildDOAnchorPos(0,Vector2.New(outpos[1],outpos[2]),7,fun12)
tweener21:SetEase(_Ease.Linear)
end
local tweener21=_this.buyrolesout[1]:SetChildDOAnchorPos(0,Vector2.New(centerpos[1],centerpos[2]),1.3,fun11)
tweener21:SetEase(_Ease.Linear)
end)


_this.outrole2=_this:delayDo(4,function()
if _this==nil then return end
_this.buyrolesout[2]:SetChildCanvasGroupAlpha(-1,1)
local lastpos2=buyxiaoshipoint[1]
local centerpos2=buyoutcenpoint[2]
local outpos2=buyoutpoint[5]
local tword2=outpos2[1]>centerpos2[1]
_this.buyrolesout[2]:SetChildAnchoredPosition(0,Vector2(lastpos2[1],lastpos2[2]))
_this.buyrolesout[2]:SetChildUIModelShowTarget(1,_this.modelbuys[2],1,{},eAnimationID.stand,false,false,0.1)
_this.buyrolesout[2]:SetChildUIModelShowFlipX(1,tword2)


if _this.suitbacklist[2]then
_this.buyrolesout[2]:SetChildModelAnimationState(1,eAnimationID.walk)
else
_this.buyrolesout[2]:SetChildModelAnimationState(1,eAnimationID.walk2)
end
_this.buyrolesout[2]:SetChildCanvasGroupDOFade(0,1,1.5)
local fun21=function()
if _this==nil then return end
local fun22=function()
if _this==nil then return end
_this.buyrolesout[2]:SetChildCanvasGroupDOFade(-1,0,0.2)
_this.buyrolesout[2]:SetChildModelAnimationState(1,eAnimationID.stand)
end
local tweener22=_this.buyrolesout[2]:SetChildDOAnchorPos(0,Vector2.New(outpos2[1],outpos2[2]),6.5,fun22)
tweener22:SetEase(_Ease.Linear)
end
local tweener22=_this.buyrolesout[2]:SetChildDOAnchorPos(0,Vector2.New(centerpos2[1],centerpos2[2]),1.2,fun21)
tweener22:SetEase(_Ease.Linear)
end)


_this.outrole3=_this:delayDo(3.4,function()
if _this==nil then return end
_this.buyrolesout[3]:SetChildCanvasGroupAlpha(-1,1)
local lastpos3=buyxiaoshipoint[1]
local centerpos3=buyoutcenpoint[2]
local outpos3=buyoutpoint[5]
local tword3=outpos3[1]>centerpos3[1]
_this.buyrolesout[3]:SetChildAnchoredPosition(0,Vector2(lastpos3[1],lastpos3[2]))
_this.buyrolesout[3]:SetChildUIModelShowTarget(1,_this.modelbuys[3],1,{},eAnimationID.stand,false,false,0.1)
_this.buyrolesout[3]:SetChildUIModelShowFlipX(1,tword3)

if _this.suitbacklist[3]then
_this.buyrolesout[3]:SetChildModelAnimationState(1,eAnimationID.walk)
else
_this.buyrolesout[3]:SetChildModelAnimationState(1,eAnimationID.walk2)
end
_this.buyrolesout[3]:SetChildCanvasGroupDOFade(0,1,1.5)
local fun31=function()
if _this==nil then return end
local fun32=function()
if _this==nil then return end
_this.buyrolesout[3]:SetChildCanvasGroupDOFade(-1,0,0.2)
_this.buyrolesout[3]:SetChildModelAnimationState(1,eAnimationID.stand)
end
local tweener23=_this.buyrolesout[3]:SetChildDOAnchorPos(0,Vector2.New(outpos3[1],outpos3[2]),6.6,fun32)
tweener23:SetEase(_Ease.Linear)
end
local tweener23=_this.buyrolesout[3]:SetChildDOAnchorPos(0,Vector2.New(centerpos3[1],centerpos3[2]),1.1,fun31)
tweener23:SetEase(_Ease.Linear)
end)


_this.outrole4=_this:delayDo(3.1,function()
_this.buyrolesout[4]:SetChildCanvasGroupAlpha(-1,1)
local lastpos4=buyxiaoshipoint[1]
local centerpos4=buyoutcenpoint[3]
local outpos4=buyoutpoint[4]
local tword4=outpos4[1]>centerpos4[1]
_this.buyrolesout[4]:SetChildAnchoredPosition(0,Vector2(lastpos4[1],lastpos4[2]))
_this.buyrolesout[4]:SetChildUIModelShowTarget(1,_this.modelbuys[4],1,{},eAnimationID.stand,false,false,0.1)
_this.buyrolesout[4]:SetChildUIModelShowFlipX(1,tword4)

if _this.suitbacklist[4]then
_this.buyrolesout[4]:SetChildModelAnimationState(1,eAnimationID.walk)
else
_this.buyrolesout[4]:SetChildModelAnimationState(1,eAnimationID.walk2)
end
_this.buyrolesout[4]:SetChildCanvasGroupDOFade(0,1,1.5)
local fun34=function()
if _this==nil then return end
local fun342=function()
if _this==nil then return end
_this.buyrolesout[4]:SetChildCanvasGroupDOFade(-1,0,0.2)
_this.buyrolesout[4]:SetChildModelAnimationState(1,eAnimationID.stand)
end
local tweener24=_this.buyrolesout[4]:SetChildDOAnchorPos(0,Vector2.New(outpos4[1],outpos4[2]),6.1,fun342)
tweener24:SetEase(_Ease.Linear)
end
local tweener24=_this.buyrolesout[4]:SetChildDOAnchorPos(0,Vector2.New(centerpos4[1],centerpos4[2]),1.2,fun34)
tweener24:SetEase(_Ease.Linear)
end)


_this.outrole5=_this:delayDo(3,function()
_this.buyrolesout[5]:SetChildCanvasGroupAlpha(-1,1)
local lastpos5=buyxiaoshipoint[1]
local centerpos5=buyoutcenpoint[2]
local outpos5=buyoutpoint[4]
local tword5=outpos5[1]>centerpos5[1]
_this.buyrolesout[5]:SetChildAnchoredPosition(0,Vector2(lastpos5[1],lastpos5[2]))
_this.buyrolesout[5]:SetChildUIModelShowTarget(1,_this.modelbuys[5],1,{},eAnimationID.stand,false,false,0.1)
_this.buyrolesout[5]:SetChildUIModelShowFlipX(1,tword5)

if _this.suitbacklist[7]then
_this.buyrolesout[5]:SetChildModelAnimationState(1,eAnimationID.walk)
else
_this.buyrolesout[5]:SetChildModelAnimationState(1,eAnimationID.walk2)
end
_this.buyrolesout[5]:SetChildCanvasGroupDOFade(0,1,1.5)
local fun35=function()
if _this==nil then return end
local fun352=function()
if _this==nil then return end
_this.buyrolesout[5]:SetChildCanvasGroupDOFade(-1,0,0.2)
_this.buyrolesout[5]:SetChildModelAnimationState(1,eAnimationID.stand)
end
local tweener25=_this.buyrolesout[5]:SetChildDOAnchorPos(0,Vector2.New(outpos5[1],outpos5[2]),6.4,fun352)
tweener25:SetEase(_Ease.Linear)
end
local tweener25=_this.buyrolesout[5]:SetChildDOAnchorPos(0,Vector2.New(centerpos5[1],centerpos5[2]),1.5,fun35)
tweener25:SetEase(_Ease.Linear)
end)


_this.outrole6=_this:delayDo(2.7,function()
_this.buyrolesout[6]:SetChildCanvasGroupAlpha(-1,1)
local lastpos6=buyxiaoshipoint[1]
local centerpos6=buyoutcenpoint[2]
local outpos6=buyoutpoint[4]
local tword6=outpos6[1]>centerpos6[1]
_this.buyrolesout[6]:SetChildAnchoredPosition(0,Vector2(lastpos6[1],lastpos6[2]))
_this.buyrolesout[6]:SetChildUIModelShowTarget(1,_this.modelbuys[6],1,{},eAnimationID.stand,false,false,0.1)
_this.buyrolesout[6]:SetChildUIModelShowFlipX(1,tword6)

if _this.suitbacklist[8]then
_this.buyrolesout[6]:SetChildModelAnimationState(1,eAnimationID.walk)
else
_this.buyrolesout[6]:SetChildModelAnimationState(1,eAnimationID.walk2)
end
_this.buyrolesout[6]:SetChildCanvasGroupDOFade(0,1,1.5)
local fun36=function()
if _this==nil then return end
local fun362=function()
if _this==nil then return end
_this.buyrolesout[6]:SetChildCanvasGroupDOFade(-1,0,0.2)
_this.buyrolesout[6]:SetChildModelAnimationState(1,eAnimationID.stand)
end
local tweener26=_this.buyrolesout[6]:SetChildDOAnchorPos(0,Vector2.New(outpos6[1],outpos6[2]),6,fun362)
tweener26:SetEase(_Ease.Linear)
end
local tweener26=_this.buyrolesout[6]:SetChildDOAnchorPos(0,Vector2.New(centerpos6[1],centerpos6[2]),1,fun36)
tweener26:SetEase(_Ease.Linear)


_this.buyrolesout[7]:SetChildCanvasGroupAlpha(-1,1)
local lastpos7=buyxiaoshipoint[1]
local centerpos7=buyoutcenpoint[2]
local outpos7=buyoutpoint[5]
local tword7=outpos7[1]>centerpos7[1]
_this.buyrolesout[7]:SetChildAnchoredPosition(0,Vector2(lastpos7[1],lastpos7[2]))
_this.buyrolesout[7]:SetChildUIModelShowTarget(1,_this.modelbuys[7],1,{},eAnimationID.stand,false,false,0.1)
_this.buyrolesout[7]:SetChildUIModelShowFlipX(1,tword7)

if _this.suitbacklist[9]then
_this.buyrolesout[7]:SetChildModelAnimationState(1,eAnimationID.walk)
else
_this.buyrolesout[7]:SetChildModelAnimationState(1,eAnimationID.walk2)
end
_this.buyrolesout[7]:SetChildCanvasGroupDOFade(0,1,1.5)
local fun37=function()
if _this==nil then return end
local fun372=function()
if _this==nil then return end
_this.buyrolesout[7]:SetChildCanvasGroupDOFade(-1,0,0.2)
_this.buyrolesout[7]:SetChildModelAnimationState(1,eAnimationID.stand)
end
local tweener27=_this.buyrolesout[7]:SetChildDOAnchorPos(0,Vector2.New(outpos7[1],outpos7[2]),6.2,fun372)
tweener27:SetEase(_Ease.Linear)
end
local tweener27=_this.buyrolesout[7]:SetChildDOAnchorPos(0,Vector2.New(centerpos7[1],centerpos7[2]),1.2,fun37)
tweener27:SetEase(_Ease.Linear)
end)


_this.outrole8=_this:delayDo(2.1,function()
_this.buyrolesout[8]:SetChildCanvasGroupAlpha(-1,1)
local lastpos8=buyxiaoshipoint[1]
local centerpos8=buyoutcenpoint[2]
local outpos8=buyoutpoint[4]
local tword8=outpos8[1]>centerpos8[1]
_this.buyrolesout[8]:SetChildAnchoredPosition(0,Vector2(lastpos8[1],lastpos8[2]))
_this.buyrolesout[8]:SetChildUIModelShowTarget(1,_this.modelbuys[8],1,{},eAnimationID.stand,false,false,0.1)
_this.buyrolesout[8]:SetChildUIModelShowFlipX(1,tword8)

if _this.suitbacklist[6]then
_this.buyrolesout[8]:SetChildModelAnimationState(1,eAnimationID.walk)
else
_this.buyrolesout[8]:SetChildModelAnimationState(1,eAnimationID.walk2)
end
_this.buyrolesout[8]:SetChildCanvasGroupDOFade(0,1,1.5)
local fun38=function()
if _this==nil then return end
local fun382=function()
if _this==nil then return end
_this.buyrolesout[8]:SetChildCanvasGroupDOFade(-1,0,0.2)
_this.buyrolesout[8]:SetChildModelAnimationState(1,eAnimationID.stand)
end
local tweener28=_this.buyrolesout[8]:SetChildDOAnchorPos(0,Vector2.New(outpos8[1],outpos8[2]),6,fun382)
tweener28:SetEase(_Ease.Linear)
end
local tweener28=_this.buyrolesout[8]:SetChildDOAnchorPos(0,Vector2.New(centerpos8[1],centerpos8[2]),1.2,fun38)
tweener28:SetEase(_Ease.Linear)
end)


_this.outrole9=_this:delayDo(1.1,function()
_this.buyrolesout[9]:SetChildCanvasGroupAlpha(-1,1)
local lastpos9=buyxiaoshipoint[1]
local centerpos9=buyoutcenpoint[2]
local outpos9=buyoutpoint[5]
local tword9=outpos9[1]>centerpos9[1]
_this.buyrolesout[9]:SetChildAnchoredPosition(0,Vector2(lastpos9[1],lastpos9[2]))
_this.buyrolesout[9]:SetChildUIModelShowTarget(1,_this.modelbuys[9],1,{},eAnimationID.stand,false,false,0.1)
_this.buyrolesout[9]:SetChildUIModelShowFlipX(1,tword9)

if _this.suitbacklist[9]then
_this.buyrolesout[9]:SetChildModelAnimationState(1,eAnimationID.walk)
else
_this.buyrolesout[9]:SetChildModelAnimationState(1,eAnimationID.walk2)
end
_this.buyrolesout[9]:SetChildCanvasGroupDOFade(0,1,1.5)
local fun39=function()
if _this==nil then return end
local fun392=function()
if _this==nil then return end
_this.buyrolesout[9]:SetChildCanvasGroupDOFade(-1,0,0.2)
_this.buyrolesout[9]:SetChildModelAnimationState(1,eAnimationID.stand)
end
local tweener29=_this.buyrolesout[9]:SetChildDOAnchorPos(0,Vector2.New(outpos9[1],outpos9[2]),6.1,fun392)
tweener29:SetEase(_Ease.Linear)
end
local tweener29=_this.buyrolesout[9]:SetChildDOAnchorPos(0,Vector2.New(centerpos9[1],centerpos9[2]),1.2,fun39)
tweener29:SetEase(_Ease.Linear)
end)


_this.outrole10=_this:delayDo(0.5,function()
_this.buyrolesout[10]:SetChildCanvasGroupAlpha(-1,1)
local lastpos10=buyxiaoshipoint[1]
local centerpos10=buyoutcenpoint[2]
local outpos10=buyoutpoint[4]
local tword10=outpos10[1]>centerpos10[1]
_this.buyrolesout[10]:SetChildAnchoredPosition(0,Vector2(lastpos10[1],lastpos10[2]))
_this.buyrolesout[10]:SetChildUIModelShowTarget(1,_this.modelbuys[10],1,{},eAnimationID.stand,false,false,0.1)
_this.buyrolesout[10]:SetChildUIModelShowFlipX(1,tword10)

if _this.suitbacklist[10]then
_this.buyrolesout[10]:SetChildModelAnimationState(1,eAnimationID.walk)
else
_this.buyrolesout[10]:SetChildModelAnimationState(1,eAnimationID.walk2)
end
_this.buyrolesout[10]:SetChildCanvasGroupDOFade(0,1,1.5)
local fun310=function()
if _this==nil then return end
local fun3102=function()
if _this==nil then return end
_this.buyrolesout[10]:SetChildCanvasGroupDOFade(-1,0,0.2)
_this.buyrolesout[10]:SetChildModelAnimationState(1,eAnimationID.stand)
end
local tweener210=_this.buyrolesout[10]:SetChildDOAnchorPos(0,Vector2.New(outpos10[1],outpos10[2]),6,fun3102)
tweener210:SetEase(_Ease.Linear)
end
local tweener210=_this.buyrolesout[10]:SetChildDOAnchorPos(0,Vector2.New(centerpos10[1],centerpos10[2]),1,fun310)
tweener210:SetEase(_Ease.Linear)
end)


_this.jiesuan=_this:delayDo(6,function()
if _this==nil then return end
UISubAct_shizhuanchoujianWin:showJieSuanWin()
end)
else
UISubAct_shizhuanchoujianWin:showJieSuanWin()
end
end


function UISubAct_shizhuanchoujianWin:checkSuitReward()


local data=activitiesModel:getSubActInfoData(_this.actid,_this.subType,_this.subid)
if data==nil then return end
local list=data.specialPrize or{}
local conf={}
for i,v in ipairs(list)do
table.insert(conf,{itemid=v.itemid,num=v.num})
end
_this.suitbacklist={}
local getmodel=cfg_lotteryact3config_get(_this.subid).getmodel
for k,v in ipairs(conf)do
for i,j in ipairs(getmodel)do
if j[1]==v.itemid then

_this.suitbacklist[#_this.suitbacklist+1]=j
end
end
end

end


function UISubAct_shizhuanchoujianWin:showJieSuanWin()
_this.animadoing=false
UISubAct_shizhuanchoujianWin:OpeanRoleWalkpanel(2)
_this.masks:setActive(false)
_this.choujiantype=-1

local data=activitiesModel:getSubActInfoData(_this.actid,_this.subType,_this.subid)
if data==nil then return end
local list=data.specialPrize or{}
local conf={}
local haveClothing=false
for i,v in ipairs(list)do
table.insert(conf,{itemid=v.itemid,num=v.num})
if itemsConfig.isClothing(v.itemid)then
haveClothing=true
end
end
local effectList={}
local getmodel=cfg_lotteryact3config_get(_this.subid).getmodel
for k,v in ipairs(conf)do
for i,j in ipairs(getmodel)do
if j[1]==v.itemid then
effectList[v.itemid]=true
end
end
end
local args={
list=list,
effect=effectList,
isHideDrawBtn=false,
act_id=_this.actid,
sub_act_type=_this.subType,
sub_act_id=_this.subid
}

if haveClothing then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.GetClothingItem)
end

UIManager:showWindow('UISubAct_shizhuanchoujian_prizeWin',args)

AudioManager.playAudio(407)
end


function UISubAct_shizhuanchoujianWin:jintougoing()



_this.root:setScale(Vector3(1,1,1))













_this.root:setRotation(0,0,0)
_this.root:setChildDOAnchorPos(Vector2.New(500,40),1.5,nil)
_this.root:setChildDOScale(1.3,1.5,nil)

end

function UISubAct_shizhuanchoujianWin:jintououting()
_this.root:setRotation(0,0,0)
_this.root:setChildDOAnchorPos(Vector2.New(0,0),2.3,nil)
_this.root:setChildDOScale(1,2.3,nil)
end


function UISubAct_shizhuanchoujianWin:baodinum()
local data=activitiesModel:getSubActInfoData(_this.actid,_this.subType,_this.subid)
if data==nil then return end
local history_num=data.history_use_times or 0
local max=cfg_lotteryact3config_get(_this.subid).guarantee_times or 50
local num=history_num
if max<=history_num then
num=math.fmod(history_num,max)
end
local nextnum=max-num
local colorStr=FONT_COLOR_VAL[FONT_COLOR.eOrangeColor]
_this.nextTx:setText(FMT.fmt("再购物 <color=#8f5127>{0}</color> 次，必得 <color={1}>极品仙衣</color>",nextnum,colorStr))
end






function UISubAct_shizhuanchoujianWin:refreshIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
local isForbiddenShowReddot=actInfo:checkIsForbiddenShowReddot()
self.isShowReddotBtn:setActive(not isForbiddenShowReddot)
if isForbiddenShowReddot then
return
end

local isShowReddot=actInfo:checkIsShowReddot()
local btnWidget=self.isShowReddotBtn:getWidgetBase()
btnWidget:SetChildActive(0,not isShowReddot)
btnWidget:SetChildActive(1,isShowReddot)
end

function UISubAct_shizhuanchoujianWin:onIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
local isShowReddot=actInfo:checkIsShowReddot()
isShowReddot=not isShowReddot

actInfo:setIsShowReddot(isShowReddot)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
self:refreshIsShowReddotBtn()
end

function UISubAct_shizhuanchoujianWin.onSubActivityOverBeforeEndTime24Hour(actId,subType,subId)
if _this==nil then return end
if _this.actid==actId and _this.subType==subType and _this.subid==subId then
_this:refreshIsShowReddotBtn()
end
end

