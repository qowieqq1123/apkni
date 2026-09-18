







def_class("UISubAct_TXDLB_mainWin",UIWindowBase)









function UISubAct_TXDLB_mainWin:bindComponents()

self.topTipsText=UIText.get(self,0)
self.showRankBtn=UIButton.get(self,1)
self.rankFirstList=UIObject.get(self,2)
self.leftBtn=UIButton.get(self,3)
self.rightBtn=UIButton.get(self,4)
self.timeText=UIText.get(self,5)
self.bottomTipsText=UIText.get(self,6)
self.Content=UIObject.get(self,7)
self.root=UIObject.get(self,8)
self.time=UIText.get(self,9)
self.catpanel=UIObject.get(self,10)
self.catmodelone=UIObject.get(self,11)
self.catmodeltwo=UIObject.get(self,12)
self.catmodelthree=UIObject.get(self,13)
self.bgModel=UIObject.get(self,14)

self.showRankBtn:setButtonClick(function()self:onShowRankBtn()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)



end


function UISubAct_TXDLB_mainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.topTipsText);self.topTipsText=nil;
_UIObject_release(self.showRankBtn);self.showRankBtn=nil;
_UIObject_release(self.rankFirstList);self.rankFirstList=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.bottomTipsText);self.bottomTipsText=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.catpanel);self.catpanel=nil;
_UIObject_release(self.catmodelone);self.catmodelone=nil;
_UIObject_release(self.catmodeltwo);self.catmodeltwo=nil;
_UIObject_release(self.catmodelthree);self.catmodelthree=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end

















local _this
local rankItemIndex={
rankTitle=0,
rankIcon=1,
headEmpty=2,
headIcon=3,
headKuang=4,
info=5,
notPlayerInfo=6,
zmName=7,
playerName=8,
manufactureCountTitle=9,
rankPlayerClick=10,
selfManufactureCount=11,
selfRank=12,
selfClick=13,
manufactureCount=14,
manufactureCountIcon=15,
selfManufactureCountIcon=16,

nameDesc=17,
xiangoucount=18,
rwscrollview=19,
mainfeibtn=20,
mianfeitext=21,
houbibtn=22,
huobitxt=23,
zhigoubtn=24,
zhigoutxt=25,
receiveicon=26,

rwitems={27,28,29,30,31,32},
bg=33,
}
local abname='ui/windows/activities/sub_tanxiandui/tanxiandui_atlas_pak.ab'

local TextColors=
{
[3]='54370d',
[4]='542d68',
[5]='2d4868',
}




function UISubAct_TXDLB_mainWin:onLoaded(...)
self:bindComponents()
_this=self
self.leftidx=0
self.rightidxnum=0
end


function UISubAct_TXDLB_mainWin:__delete()
self:unbindComponents()
self.isOver=nil
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
end




function UISubAct_TXDLB_mainWin:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eTanXianLiBao
self.subid=argtable.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)

self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
self.startday=self.info.start_day_idx
self.start_time=self.info.start_time
self.end_time=self.info.end_time

if self.info then
local leftTime=self.info:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("剩余时间：{0}",UISubAct_TXDLB_mainWin.format_time_stamp2(leftTime)))
else
self.time:setText("活动已结束")
self.isOver=true
end
self.leftTimer=self:setTimer(1,-1,function()
local info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
if info then
local leftTime=info:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("剩余时间：{0}",UISubAct_TXDLB_mainWin.format_time_stamp2(leftTime)))
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

self.rankFirstList:setActive(true)
self:refreshScrollerView(self.actid,self.subType,self.subid)
_this.leftidx=0
_this.rightidxnum=_this.pageCount-3-_this.leftidx
self:checkArrowBtn()
self:refreshCatModel()
self.bgModel:setChildUIModelShowTarget(5020,1,{},eAnimationID.stand,false,false,0,nil)
end

local _format=string.format
local _floor=math.floor
function UISubAct_TXDLB_mainWin.format_time_stamp2(inteval)
local SS=inteval%60
local cc=_floor(inteval/60)
local mm=cc%60
cc=_floor(cc/60)
local HH=cc%24
cc=_floor(cc/24)
local DD=cc

if DD>0 then
return _format('%s天%s时',DD,HH)
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


function UISubAct_TXDLB_mainWin:onHide()
self.rankFirstList:setActive(false)

end





function UISubAct_TXDLB_mainWin:onShowRankBtn()
end

function UISubAct_TXDLB_mainWin:onLeftBtn()


_this.leftidx=_this.leftidx-1
_this.rightidxnum=_this.pageCount-3-_this.leftidx
if _this.leftidx>=0 then
_this.rankFirstList:setChildScrollViewSelectItem(_this.leftidx,true,false,false)
end
_this:checkArrowBtn()
end

function UISubAct_TXDLB_mainWin:onRightBtn()


_this.leftidx=_this.leftidx+1
_this.rightidxnum=_this.pageCount-3-_this.leftidx
if _this.rightidxnum>=0 then
_this.rankFirstList:setChildScrollViewSelectItem(_this.leftidx,true,false,false)
end
_this:checkArrowBtn()
end


function UISubAct_TXDLB_mainWin:checkArrowBtn()
_this.leftBtn:setActive(_this.leftidx>0)
_this.rightBtn:setActive(_this.rightidxnum>0)

if _this.pageCount<=3 then
_this.leftBtn:setActive(false)
_this.rightBtn:setActive(false)
end
end


function UISubAct_TXDLB_mainWin:getSortList(actID,subType,subID)
local mydata=activitiesModel:getSubActInfoData(actID,subType,subID)
local bugdata={}
for k,v in ipairs(mydata.arry)do
bugdata[v.param_1]=v.param_2
end
local list={}
local Reward=cfg_buyact4config_get(subID).rewards

for i,v in ipairs(Reward)do
local xiangounum=v[1]
local shengyunum=xiangounum
if bugdata[v[5]]then
shengyunum=xiangounum-bugdata[v[5]]
end
if shengyunum<0 then
shengyunum=0
end
local state=shengyunum>0 and 1 or 0

local weight=state*1000+(1000-v[5])
table.insert(list,{v,shengyunum,weight})
end
table.sort(list,function(a,b)
return a[3]>b[3]
end)

return list
end


function UISubAct_TXDLB_mainWin:refreshScrollerView(actID,subType,subID)

local datalist=UISubAct_TXDLB_mainWin:getSortList(actID,subType,subID)
_this.rankFirstList:setChildScrollViewCreateGrids(#datalist,#datalist)
local grids=_this.rankFirstList:getChildScrollViewItemWidgets()
_this.pageCount=#_this.rankFirstList
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=datalist[i]
local cfg=data[1]

local xiangounum=datalist[i][2]
local str=FMT.fmt("限购次数：{0}",xiangounum)
if xiangounum<=0 then
str=FMT.fmt("<color=#171311>限购次数：{0}</color>",xiangounum)
end
item:SetChildActive(rankItemIndex.xiangoucount,true)
item:SetChildText(rankItemIndex.xiangoucount,str)
item:SetChildActive(rankItemIndex.receiveicon,false)





























local rewards=cfg[2]
local grids_up=item:GetChildCommonLayoutGroupWidgetList(35)
local grids_down=item:GetChildCommonLayoutGroupWidgetList(36)
local rewardCount=#rewards
item:SetChildActive(36,rewardCount>2)
local gridIdxList=self:getGridIndexList(rewardCount)
local gridCount=grids_up.Count+grids_down.Count
for i=1,gridCount do
local widget
local gridIdx=gridIdxList[i]
if gridIdx<=grids_up.Count then
widget=grids_up[gridIdx-1]
else
widget=grids_down[gridIdx-grids_up.Count-1]
end
local reward=rewards[i]
if reward then
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItemitem(itemid,1,data[3])
end)
else
widget:SetChildActive(-1,false)
end
end


if#cfg[3]==0 and#cfg[4]==0 then
item:SetChildActive(rankItemIndex.mainfeibtn,true)
item:SetChildActive(rankItemIndex.houbibtn,false)
item:SetChildActive(rankItemIndex.zhigoubtn,false)
local textcolor=TextColors[cfg[7]]
item:SetChildText(rankItemIndex.nameDesc,FMT.fmt("<color=#{0}>{1}</color>",textcolor,cfg[6])or'预留礼包名称')

item:SetChildCSImageSprite(rankItemIndex.bg,abname,FMT.fmt("image_fuyunlb_{0}",cfg[7]))

if xiangounum<=0 then
item:SetChildActive(rankItemIndex.mainfeibtn,false)
item:SetChildActive(rankItemIndex.receiveicon,true)
item:SetChildActive(rankItemIndex.xiangoucount,false)
end
local func=function()
_this:OnClickMianFeiCallback(1,data,actID,subType,subID)
end
item:SetChildButtonClick(rankItemIndex.mainfeibtn,func,true)
end


if#cfg[3]>0 and#cfg[4]==0 then
item:SetChildActive(rankItemIndex.mainfeibtn,false)
item:SetChildActive(rankItemIndex.houbibtn,true)
item:SetChildActive(rankItemIndex.zhigoubtn,false)
local textcolor=TextColors[cfg[7]]
item:SetChildText(rankItemIndex.nameDesc,FMT.fmt("<color=#{0}>{1}</color>",textcolor,cfg[6])or'预留礼包名称')
item:SetChildCSImageSprite(rankItemIndex.bg,abname,FMT.fmt("image_fuyunlb_{0}",cfg[7]))

if xiangounum<=0 then
item:SetChildActive(rankItemIndex.houbibtn,false)
item:SetChildActive(rankItemIndex.receiveicon,true)
item:SetChildActive(rankItemIndex.xiangoucount,false)
end

local costItemID=cfg[3][1][1]
local itemNum=cfg[3][1][2]
local have=itemsModel.getCount(costItemID)
local colorStr=have>=itemNum and"F9F9F9"or"F9F9F9"


local costStr=FMT.fmt("<color=#{0}>{1}</color>",colorStr,itemNum)
item:SetChildIcon(37,iconHelper.getIconName(costItemID),false)
item:SetChildText(rankItemIndex.huobitxt,costStr)
local func=function()
_this:OnClickDaiBiCallback(1,data,actID,subType,subID,rewards,cfg[6])
end
item:SetChildButtonClick(rankItemIndex.houbibtn,func,true)
end


if#cfg[3]==0 and#cfg[4]>0 then
item:SetChildActive(rankItemIndex.mainfeibtn,false)
item:SetChildActive(rankItemIndex.houbibtn,false)
item:SetChildActive(rankItemIndex.zhigoubtn,true)
local textcolor=TextColors[cfg[7]]
item:SetChildText(rankItemIndex.nameDesc,FMT.fmt("<color=#{0}>{1}</color>",textcolor,cfg[6])or'预留礼包名称')
item:SetChildCSImageSprite(rankItemIndex.bg,abname,FMT.fmt("image_fuyunlb_{0}",cfg[7]))

if xiangounum<=0 then
item:SetChildActive(rankItemIndex.zhigoubtn,false)
item:SetChildActive(rankItemIndex.receiveicon,true)
item:SetChildActive(rankItemIndex.xiangoucount,false)
end


local rechargeid=cfg[4][1]
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeid)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
local zhigoustr=str or'nil'
item:SetChildText(rankItemIndex.zhigoutxt,zhigoustr)
local func=function()
_this:OnClickZhiGouCallback(1,data,actID,subType,subID,rewards,cfg[6])
end
item:SetChildButtonClick(rankItemIndex.zhigoubtn,func,true)
end

end
end

function UISubAct_TXDLB_mainWin:getGridIndexList(count)
if count==3 then
return{1,2,4,5,3,6}
elseif count==4 then
return{1,2,4,5,3,6}
else
return{1,2,3,4,5,6}
end
end


function UISubAct_TXDLB_mainWin:onClickItemitem(itemId,index,guid,attach)
if itemId then
tipsManager.showTips({itemid=itemId,itemguid=nil})
end
end


function UISubAct_TXDLB_mainWin:OnClickMianFeiCallback(clicknum,data,actID,subType,subID)
local cfg=data[1]
local xiangounum=data[2]
if xiangounum>0 then
local info={cfg[5],1}
local jsonStr=jsonHelper.encode(info)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subID,jsonStr)
else
UIManager.error('今日已达到购买次数上限')
end

AudioManager.playOpenUI()
end


function UISubAct_TXDLB_mainWin:OnClickDaiBiCallback(clicknum,data,actID,subType,subID,rewards,namedesc)
local cfg=data[1]

local moneyType=cfg[3][1][1]
local needCount=cfg[3][1][2]
local buyCount=data[2]
local left=buyCount

if left<0 then left=0 end




























local buyNum=0
local limitCount=buyCount
local showItem=rewards
local buyCostType=cfg[3][1][1]
local buyCostVal=cfg[3][1][2]
local show_data=
{
rewards=showItem,
name='礼包',
price={buyCostType,buyCostVal},
isCheckMaxSelectCount=true,
leftNum=buyNum,
maxcount=limitCount,
callback=function(num)
local info={cfg[5],num}
local jsonStr=jsonHelper.encode(info)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subID,jsonStr)
end,
}
UIManager:showWindow("UICommonBuyDialogWin",show_data)

AudioManager.playOpenUI()
end


function UISubAct_TXDLB_mainWin:OnClickZhiGouCallback(clicknum,data,actID,subType,subID,rewards,namedesc)
local cfg=data[1]
if UISubAct_TXDLB_mainWin:checkplatform()then
local rechargeId=cfg[4][1]
local info={cfg[5],1}
local params=payControl.getActivityPayParams(actID,subType,subID,info)
payControl.reqPay(rechargeId,1,params)
else
local refresh=function(num)
local rechargeid=cfg[4][num]
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeid)
local contentStr=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
return contentStr
end


local left=data[2]
local showItem=rewards

local show_data={
type='UIDialougeBuyCountNoTip',
rewards=showItem,
title='礼包',
refreshcallback=refresh,
max=left,
tips='',
oktext='购买',
canceltext='取消',
tipContent='',
tipsPos=Vector2.New(152,-7),
okcallback=function(num)
local rechargeId=cfg[4][num]
local info={cfg[5],num}
local params=payControl.getActivityPayParams(actID,subType,subID,info)
payControl.reqPay(rechargeId,1,params)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

AudioManager.playOpenUI()
end


function UISubAct_TXDLB_mainWin:checkplatform()
return deviceHelper.isRunIOS()or webGLHelper:isRunMiniGame()
end

function UISubAct_TXDLB_mainWin:refreshTimer()
local time=activitiesModel:getSubActEndLeftTime(self.actid,self.subType,self.subid)
self.stamp=os.time()+time
self:stopSelfTimer()
local func=function()
if self==nil then return end
local left=self.stamp-os.time()
if left<0 then left=0 end
self.countdowntxt:setText(timeHelper.format_time_stamp3(left))
end
self.timer=self:setTimer(1,0,func)
func()
end
function UISubAct_TXDLB_mainWin:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end



function UISubAct_TXDLB_mainWin:refreshCatModel()
local isshow=true
self.catpanel:setActive(isshow)
if isshow then
self.catmodelone:setChildUIModelShowTarget(5028,1.3,{5002},eAnimationID.stand)

self.catmodelone:setScale(Vector3(-1,1,1))
self.catmodeltwo:setChildUIModelShowTarget(5023,1.3,{5011},eAnimationID.stand)
self.catmodelthree:setChildUIModelShowTarget(5025,1.3,{5018},eAnimationID.stand)
end
end
