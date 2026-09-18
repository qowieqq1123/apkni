







def_class("UISubAct_XXBX_Win",UIWindowBase)









function UISubAct_XXBX_Win:bindComponents()

self.modelBg=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.unlockText=UIText.get(self,2)
self.unlcokBtn=UIButton.get(self,3)
self.timeRoot=UIObject.get(self,4)
self.TipsBtn=UIButton.get(self,5)
self.ScrollerView=UILoopListView.new(self,6)
self.titleImgae=UIImage.get(self,7)
self.ratio=UIImage.get(self,8)
self.lefttime=UIText.get(self,9)
self.rewadProgressbg=UIObject.get(self,10)
self.bottomBg=UIObject.get(self,11)
self.titleBgmodel=UIObject.get(self,12)

self.unlcokBtn:setButtonClick(function()self:onUnlcokBtn()end)

self.TipsBtn:setButtonClick(function()self:onTipsBtn()end)

self.ScrollerView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UISubAct_XXBX_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.unlockText);self.unlockText=nil;
_UIObject_release(self.unlcokBtn);self.unlcokBtn=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.TipsBtn);self.TipsBtn=nil;
self.ScrollerView:deleteSelf();self.ScrollerView=nil;
_UIObject_release(self.titleImgae);self.titleImgae=nil;
_UIObject_release(self.ratio);self.ratio=nil;
_UIObject_release(self.lefttime);self.lefttime=nil;
_UIObject_release(self.rewadProgressbg);self.rewadProgressbg=nil;
_UIObject_release(self.bottomBg);self.bottomBg=nil;
_UIObject_release(self.titleBgmodel);self.titleBgmodel=nil;
end

















local abname="ui/windows/activities/sub_xianxuanbaoxia/xianxuanbaoxia_atlas_pak.ab"

local subitemcmp=
{
normalReward=0,
select=1,
spriteani=2,
lock=3,
gray=4,
}

local itemTempCfg={
{
name="item1",
cmpIndex={
bg=0,
freeCreat=1,
rmbCreat=2,
activebg=3,
numTxt=4,
freeRecvFlag=5,
rmbRecvFlag=6,
recvBtn=7,
btnTxt=8,
allRecvFlag=9,
progressBar=10,
progress=11,
notRecvFlag=12,
},
itemSize={x=28,y=142},
},
{
name="item2",
cmpIndex={
bg=0,
freeCreat=1,
rmbCreat=2,
activebg=3,
numTxt=4,
freeRecvFlag=5,
rmbRecvFlag=6,
recvBtn=7,
btnTxt=8,
allRecvFlag=9,
progressBar=10,
progress=11,
notRecvFlag=12,
rmbTitleBg=13,
actrmbTitleBg=14,
rmbTitle=15,
},
itemSize={x=28,y=142},
},

}
local ItemState={
eNotRecv=0,
eRecv=1,
eRecved=2,
}

local RewardState={
eNotRecv=0,
eRecv=1,
eRecved=2,
}




function UISubAct_XXBX_Win:onLoaded(...)
self:bindComponents()
self.modelBg:setChildUIModelShowTarget(5722,1,{},0)
self.titleBgmodel:setChildUIModelShowTarget(5723,1,{},0)
self.bottomBg:setChildUIModelShowTarget(5724,1,{},0)
end


function UISubAct_XXBX_Win:__delete()
self:stopCDTick()
self:unbindComponents()
end




function UISubAct_XXBX_Win:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id


self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)


self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)

self.recharge_id=self.config.recharge_id

local titleImgName=self.config.titleImgName
self.titleImgae:setSprite(abname,titleImgName)
local ratioImgCfg=self.config.ratioImgCfg
local ratioAbName=ratioImgCfg[1]
local ratioImgName=ratioImgCfg[2]
self.ratio:setSprite(ratioAbName,ratioImgName)
local btnImgNmae=self.config.btnImgNmae
self.unlcokBtn:setCSImageSprite(abname,btnImgNmae)


self:startCDTick()

self:refresh(true)
end


function UISubAct_XXBX_Win:onHide()

end

function UISubAct_XXBX_Win:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_XXBX_Win:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_XXBX_Win:updateCDTick()
local lefttime=activitiesModel:getSubActEndLeftTime(self.actID,self.subType,self.subid)
if lefttime<0 then
lefttime=0
end
self.lefttime:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp3(lefttime)))
end


function UISubAct_XXBX_Win:initScrollerView()
local prefabnameList={}
local dataList=self:getDataList()
for i,v in ipairs(dataList)do
if v.empty then
prefabnameList[i]=v.empty
else
prefabnameList[i]=v.zixuanFlag and itemTempCfg[2].name or itemTempCfg[1].name
end

end
self.ScrollerView:initDataEx(prefabnameList,dataList)
local curIndex=self:getLoginCnt()
self.ScrollerView:jumpItem(curIndex)
end

function UISubAct_XXBX_Win:refreshShowItem()
local dataList=self:getDataList()
for i,v in ipairs(dataList)do
local index=i
local dataIndexEx=v.dataIndexEx
if dataIndexEx then
local widget=self.ScrollerView:getItemWidget(index)
if widget then
self:onFreshAction(index,widget,v)
end
end
end
local curIndex=self:getLoginCnt()
self.ScrollerView:jumpItem(curIndex)
end

function UISubAct_XXBX_Win:refresh(initFlag)
self:refreshTouZiBtn()
self:refreshProgressbg()
if initFlag then
self:initScrollerView()
else
self:refreshShowItem()
end
end

function UISubAct_XXBX_Win:refreshTouZiBtn()
local buyFlag=self:getBuyFlag()
if buyFlag then
self.unlcokBtn:setActive(false)
else
self.unlcokBtn:setActive(true)







end
end

function UISubAct_XXBX_Win:refreshProgressbg()
local loginCnt=self:getLoginCnt()
self.rewadProgressbg:setActive(loginCnt>0)
end



function UISubAct_XXBX_Win:onFreshAction(index,widget,data)
if data.empty then
return
end
local index=data.dataIndexEx
local zixuanFlag=data.zixuanFlag
local tempCfg=zixuanFlag and itemTempCfg[2]or itemTempCfg[1]
local itemcmp=tempCfg.cmpIndex
widget:SetChildText(itemcmp.numTxt,FMT.fmt("第{0}天",index))
local state,freeRewardState,rmbRewardState=self:getItemState(index)

local itemSize=tempCfg.itemSize

if data.finally then
widget:SetChildSizeDelta(itemcmp.progressBar,itemSize.x,itemSize.y/2)
else
widget:SetChildSizeDelta(itemcmp.progressBar,itemSize.x,itemSize.y)
end

if state==ItemState.eNotRecv then
widget:SetChildSizeDelta(itemcmp.progress,16,0)
widget:SetChildActive(itemcmp.activebg,false)
widget:SetChildActive(itemcmp.allRecvFlag,false)
widget:SetChildActive(itemcmp.recvBtn,false)
widget:SetChildActive(itemcmp.notRecvFlag,true)
widget:SetChildActive(itemcmp.freeRecvFlag,false)
widget:SetChildActive(itemcmp.rmbRecvFlag,false)
if zixuanFlag then
widget:SetChildActive(itemcmp.rmbTitleBg,true)
widget:SetChildActive(itemcmp.actrmbTitleBg,false)
widget:SetChildText(itemcmp.rmbTitle,FMT.fmt("以下奖励{0}选{1}",mathHelper.numberToChinese(data.selectCfg[1]),mathHelper.numberToChinese(data.selectCfg[2])))
end
elseif state==ItemState.eRecv then
local loginCnt=self:getLoginCnt()
if index==loginCnt then
widget:SetChildSizeDelta(itemcmp.progress,16,itemSize.y/2)
else
widget:SetChildSizeDelta(itemcmp.progress,16,itemSize.y)
end

widget:SetChildActive(itemcmp.activebg,true)
widget:SetChildActive(itemcmp.allRecvFlag,false)
widget:SetChildActive(itemcmp.recvBtn,true)
widget:SetChildActive(itemcmp.notRecvFlag,false)

widget:SetChildActive(itemcmp.freeRecvFlag,freeRewardState==RewardState.eRecved)
widget:SetChildActive(itemcmp.rmbRecvFlag,rmbRewardState==RewardState.eRecved)
local btnClickFlag=false
if freeRewardState==RewardState.eRecv or rmbRewardState==RewardState.eRecv then
widget:SetChildText(itemcmp.btnTxt,"领取")
btnClickFlag=true
elseif freeRewardState==RewardState.eRecved and rmbRewardState==RewardState.eNotRecv then
widget:SetChildText(itemcmp.btnTxt,"继续领取")
btnClickFlag=false
end

if zixuanFlag then
widget:SetChildActive(itemcmp.rmbTitleBg,true)
widget:SetChildActive(itemcmp.actrmbTitleBg,true)
if rmbRewardState==RewardState.eRecv or rmbRewardState==RewardState.eNotRecv then
widget:SetChildText(itemcmp.rmbTitle,FMT.fmt("以下奖励{0}选{1}",mathHelper.numberToChinese(data.selectCfg[1]),mathHelper.numberToChinese(data.selectCfg[2])))
else
widget:SetChildText(itemcmp.rmbTitle,"自选宝箱已领取")
end
end
widget:SetChildButtonClick(itemcmp.recvBtn,function()
self:onClickItem(btnClickFlag and 1 or 0)
end,true)
elseif state==ItemState.eRecved then
widget:SetChildActive(itemcmp.activebg,true)
widget:SetChildActive(itemcmp.allRecvFlag,true)
widget:SetChildActive(itemcmp.recvBtn,false)
widget:SetChildActive(itemcmp.notRecvFlag,false)
widget:SetChildActive(itemcmp.freeRecvFlag,true)
widget:SetChildActive(itemcmp.rmbRecvFlag,true)
if zixuanFlag then
widget:SetChildActive(itemcmp.rmbTitleBg,true)
widget:SetChildActive(itemcmp.actrmbTitleBg,true)
widget:SetChildText(itemcmp.rmbTitle,"自选宝箱已领取")
end
local loginCnt=self:getLoginCnt()
if data.finally or index==loginCnt then
widget:SetChildSizeDelta(itemcmp.progress,16,itemSize.y/2)
else
widget:SetChildSizeDelta(itemcmp.progressBar,itemSize.x,itemSize.y)
end
end
local temp={
{cmpIndex=itemcmp.freeCreat,rewards=data.freeRewards},
{cmpIndex=itemcmp.rmbCreat,rewards=data.rmbRewards}
}
for i,v in ipairs(temp)do
local cmpIndex=v.cmpIndex
local rewards=v.rewards

widget:SetChildLayoutGroupCreateItems(cmpIndex,#rewards,function(groupItemIndex)
local itemDataCfg={}
local reward=rewards[groupItemIndex]
itemDataCfg[1]=reward[1]
itemDataCfg[2]=reward[2]
itemDataCfg.showStage=true
local itemwidget=widget:GetChildLayoutGroupGridItem(cmpIndex,groupItemIndex-1)
widgetHelper.setNormalRewardItem(itemwidget,subitemcmp.normalReward,itemDataCfg)
itemwidget:SetChildButtonClick(subitemcmp.spriteani,function()
self:onClickItem(index)
end,true)


local spriteaniFlag=false
if state==ItemState.eRecv then
if i==1 and freeRewardState==RewardState.eRecv then
spriteaniFlag=true
elseif i==2 and rmbRewardState==RewardState.eRecv then
spriteaniFlag=true
end
end

local grayFlag=not spriteaniFlag
itemwidget:SetChildActive(subitemcmp.gray,grayFlag)
local lockFlag=false
itemwidget:SetChildActive(subitemcmp.lock,lockFlag)

itemwidget:SetChildActive(subitemcmp.spriteani,spriteaniFlag)
local selectFlag=false
itemwidget:SetChildActive(subitemcmp.select,selectFlag)
end)

end
end

function UISubAct_XXBX_Win:onStartAction()

end



function UISubAct_XXBX_Win:getBuyFlag()
return self.sub_actInfo:getBuyFlag()
end

function UISubAct_XXBX_Win:getFreeRecvFlag(index)
return self.sub_actInfo:getFreeRecvFlag(index)
end

function UISubAct_XXBX_Win:getRmbRecvFlag(index)
return self.sub_actInfo:getRmbRecvFlag(index)
end

function UISubAct_XXBX_Win:getLoginCnt()
return self.sub_actInfo:getStart2NowDay()
end

function UISubAct_XXBX_Win:getDataList()
local list={}







list[1]={empty="topEmpty"}
local rewards=self.config.rewards
for i,v in ipairs(rewards)do
local temp={}
temp.dataIndexEx=i
temp.zixuanFlag=false
temp.freeRewards=v[1]
local rmbRewards={}
for ii,vv in ipairs(v[2])do
local itemId=vv[1]
local itemConfig=itemsConfig.getConfig(itemId)
local funcparam=itemConfig and itemConfig.funcparam or nil
if funcparam and funcparam.type==item_funtion_type.selectbox and funcparam.itemList then
temp.zixuanFlag=true
temp.selectCfg={#funcparam.itemList,funcparam.num}
for i3,v3 in ipairs(funcparam.itemList)do
rmbRewards[#rmbRewards+1]=v3
end
else
rmbRewards[#rmbRewards+1]=vv
end
end
temp.rmbRewards=rmbRewards

temp.finally=i==#rewards
list[#list+1]=temp
end
list[#list+1]={empty="bottomEmpty"}
return list
end

function UISubAct_XXBX_Win:getItemState(index)
local loginCnt=self:getLoginCnt()
if index>loginCnt then
return ItemState.eNotRecv,RewardState.eNotRecv,RewardState.eNotRecv
end
if self:getFreeRecvFlag(index)and self:getRmbRecvFlag(index)and self:getBuyFlag()then
return ItemState.eRecved,RewardState.eRecved,RewardState.eRecved
end

local freeRewardState=self:getFreeRecvFlag(index)and RewardState.eRecved or RewardState.eRecv

local rmbRewardState=self:getRmbRecvFlag(index)and RewardState.eRecved or RewardState.eRecv
rmbRewardState=self:getBuyFlag()and rmbRewardState or RewardState.eNotRecv
return ItemState.eRecv,freeRewardState,rmbRewardState
end








function UISubAct_XXBX_Win:onUnlcokBtn()
local argtable={}
argtable.act_id=self.actID
argtable.sub_act_type=self.subType
argtable.sub_act_id=self.subid
UIManager:showWindow("UISubAct_XXBX_Buy_Win",argtable)
end



function UISubAct_XXBX_Win:onTipsBtn()
local descFMT='UIXXBX_Tips_%s'
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name=descFMT})
end

function UISubAct_XXBX_Win:onClickItem(index)

if index>0 then
call_activitiesHandle_func("activitiesHandle_xianxuanbaoxia","reqReward",self.actID,self.subid)
else
self:onUnlcokBtn()
end

end

