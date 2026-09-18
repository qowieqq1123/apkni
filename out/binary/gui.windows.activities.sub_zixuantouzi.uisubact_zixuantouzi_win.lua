







def_class("UISubAct_zixuantouzi_Win",UIWindowBase)









function UISubAct_zixuantouzi_Win:bindComponents()

self.modelBg=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.unlockText=UIText.get(self,2)
self.unlcokBtn=UIButton.get(self,3)
self.timeRoot=UIObject.get(self,4)
self.jumpBtn=UIButton.get(self,5)
self.TipsBtn=UIButton.get(self,6)
self.ScrollerView=UIObject.get(self,7)
self.titleImgae=UIImage.get(self,8)
self.rmbEffect=UIImage.get(self,9)
self.lefttime=UIText.get(self,10)
self.curScore=UIText.get(self,11)
self.Content=UIObject.get(self,12)
self.bottomBg=UIObject.get(self,13)
self.rmbtitle=UIText.get(self,14)
self.activeReward=UIObject.get(self,15)
self.reSetBtn=UIButton.get(self,16)

self.unlcokBtn:setButtonClick(function()self:onUnlcokBtn()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.TipsBtn:setButtonClick(function()self:onTipsBtn()end)

self.reSetBtn:setButtonClick(function()self:onReSetBtn()end)



end


function UISubAct_zixuantouzi_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.unlockText);self.unlockText=nil;
_UIObject_release(self.unlcokBtn);self.unlcokBtn=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.TipsBtn);self.TipsBtn=nil;
_UIObject_release(self.ScrollerView);self.ScrollerView=nil;
_UIObject_release(self.titleImgae);self.titleImgae=nil;
_UIObject_release(self.rmbEffect);self.rmbEffect=nil;
_UIObject_release(self.lefttime);self.lefttime=nil;
_UIObject_release(self.curScore);self.curScore=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.bottomBg);self.bottomBg=nil;
_UIObject_release(self.rmbtitle);self.rmbtitle=nil;
_UIObject_release(self.activeReward);self.activeReward=nil;
_UIObject_release(self.reSetBtn);self.reSetBtn=nil;
end

















local itemsize=117
local firstitemsize=82
local abname="ui/windows/activities/sub_zixuantouzi/zixuantouzi_atlas_pak.ab"

local itemcmp=
{
bg=0,
freeCreat=1,
rmbCreat=2,
activebg=3,
countTxt=4,
addBtn=5,
reSelectBtn=6,
lockFlag=7,
freeRecv=8,
rmbRecv=9,
}

local item2cmp=
{
normalReward=0,
select=1,
spriteani=2,
lock=3,
gray=4,
}



function UISubAct_zixuantouzi_Win:onLoaded(...)
self:bindComponents()
self.modelBg:setChildUIModelShowTarget(6263,1,{},0)

end


function UISubAct_zixuantouzi_Win:__delete()
self:stopCDTick()
self:unbindComponents()
end




function UISubAct_zixuantouzi_Win:onShow(argtable,afterOnloaded)

self.actID=argtable and argtable.act_id or nil
self.subType=argtable and argtable.sub_act_type or nil
self.subid=argtable and argtable.sub_act_id or nil

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)

self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

self:initTemp()

self:init()
self:refresh()
end


function UISubAct_zixuantouzi_Win:onHide()
self:stopCDTick()
end

function UISubAct_zixuantouzi_Win:onShowArgRecv(argtable)
self:onShow(argtable)
end

function UISubAct_zixuantouzi_Win:initTemp()
local target_rewards=self.config.target_rewards
local recharge_list=self.config.recharge_list
self.scrollerDataList={}

for i,v in ipairs(target_rewards)do
local temp={}
temp.targetScore=v[1]
temp.freeRewards=v[2][1]
table.insert(self.scrollerDataList,temp)
end
table.sort(self.scrollerDataList,function(a,b)
return a.targetScore<b.targetScore
end)
local rechargeListCfg=self.config.rechargeListCfg
self.buyDataList={}
self.maxEffect=0
for i,v in ipairs(recharge_list)do
local rCfg=rechargeListCfg[i]
if not rCfg then
logErr("自选投资缺 投资客户端配置",i)
return
end
local teamp={}
teamp.title=rCfg.title
teamp.effect=rCfg.effect
if rCfg.effect>self.maxEffect then
self.maxEffect=rCfg.effect
end
teamp.id=i
teamp.recharge_id=v[1]
local list={}
teamp.rechargeRewards=v[2]
for ii,vv in ipairs(target_rewards)do
local listTemp={}
listTemp.targetScore=vv[1]
listTemp.rmbRewards=vv[2][i+1]
if not listTemp.rmbRewards then
logErr("自选投资缺配置 有充值配置 没有投资奖励",teamp.recharge_id,i+1)
return
end
table.insert(list,listTemp)
end
table.sort(list,function(a,b)
return a.targetScore<b.targetScore
end)

teamp.list=list
table.insert(self.buyDataList,teamp)
end

end


function UISubAct_zixuantouzi_Win:init()

self.titleImgae:setCSImageSprite(abname,self.config.titleImgae)

self:startCDTick()


local len=#self.scrollerDataList
self.ScrollerView:setChildScrollViewCreateGrids(len,1)













self.jumpBtn:setActive(self.config.jumpCfg~=nil)
end

function UISubAct_zixuantouzi_Win:refresh()

local selectBuyId=self:getSelectBuyId()
local buyedId=self:getBuyedId()

local curScore=self:getCurScore()
self.curScore:setText(curScore)

local len=#self.scrollerDataList
if len<=0 then
return
end

local grids=self.ScrollerView:getChildScrollViewItemWidgets()
for i=1,len do
self:SetItemData(grids[i-1],i)
end






local curIndex=0
for i,v in ipairs(self.scrollerDataList)do
local targetScore=v.targetScore
if curScore>=targetScore then
curIndex=i
end
end

self.ScrollerView:setChildScrollViewSelectItem(curIndex,false,false,true)





















local showId=buyedId or selectBuyId
local activeWidget=self.activeReward:getWidgetBase()
if showId then


local showData=self.buyDataList[showId]
self.rmbtitle:setText(showData.title)


local rechargeRewards=showData.rechargeRewards

activeWidget:SetChildLayoutGroupCreateItems(1,#rechargeRewards,function(groupItemIndex)
local itemdata={}
local reward=rechargeRewards[groupItemIndex]
itemdata[1]=reward[1]
itemdata[2]=reward[2]
itemdata.showStage=true
local itemwidget=activeWidget:GetChildLayoutGroupGridItem(1,groupItemIndex-1)
widgetHelper.setNormalRewardItem(itemwidget,0,itemdata)

itemwidget:SetChildActive(item2cmp.gray,false)
itemwidget:SetChildActive(item2cmp.lock,false)
itemwidget:SetChildActive(item2cmp.spriteani,false)
itemwidget:SetChildActive(item2cmp.select,false)
end)
activeWidget:SetChildActive(4,true)
activeWidget:SetChildActive(5,false)
if buyedId then
self.unlcokBtn:setActive(false)
activeWidget:SetChildActive(3,true)
self.reSetBtn:setActive(false)
else
self.unlcokBtn:setActive(true)
local recharge_id=showData.recharge_id
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,recharge_id)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
self.unlockText:setText(FMT.fmt("{0}购买",str))
activeWidget:SetChildActive(3,false)
self.reSetBtn:setActive(true)
end
activeWidget:SetChildText(6,FMT.fmt("{0}%收益",showData.effect))
else
activeWidget:SetChildActive(3,false)
activeWidget:SetChildActive(4,false)
activeWidget:SetChildActive(5,true)

self.rmbtitle:setText("选择礼包")

self.unlcokBtn:setActive(true)
self.unlockText:setText("选择礼包")
activeWidget:SetChildText(6,FMT.fmt("{0}%收益",self.maxEffect))
self.reSetBtn:setActive(false)
end

end


function UISubAct_zixuantouzi_Win:SetItemData(widget,index)
if widget==nil then
widget=self.ScrollerView:getChildScrollViewItemWidget(index-1)
end
local data=self.scrollerDataList[index]
if widget and data then
local curScore=self:getCurScore()
widget:SetChildText(itemcmp.countTxt,data.targetScore)


local freeState=self:getFreeState(index)
widget:SetChildActive(itemcmp.freeRecv,freeState==RewardTempState.eRecved)
local freeRewards=data.freeRewards
widget:SetChildLayoutGroupCreateItems(itemcmp.freeCreat,#freeRewards,function(groupItemIndex)
local itemdata={}
local reward=freeRewards[groupItemIndex]
itemdata[1]=reward[1]
itemdata[2]=reward[2]
itemdata.showStage=true
local itemwidget=widget:GetChildLayoutGroupGridItem(itemcmp.freeCreat,groupItemIndex-1)
widgetHelper.setNormalRewardItem(itemwidget,0,itemdata)











itemwidget:SetChildButtonClick(2,function()
self:onPrize(index)
end,true)
itemwidget:SetChildActive(item2cmp.gray,freeState==RewardTempState.eRecved or freeState==RewardTempState.eNotRecv)
itemwidget:SetChildActive(item2cmp.lock,false)
itemwidget:SetChildActive(item2cmp.spriteani,freeState==RewardTempState.eRecv)
itemwidget:SetChildActive(item2cmp.select,false)
end)


local selectBuyId=self:getSelectBuyId()
local buyedId=self:getBuyedId()
local showId=buyedId or selectBuyId
if showId then
widget:SetChildActive(itemcmp.rmbCreat,true)
widget:SetChildActive(itemcmp.addBtn,false)









local rmbState=self:getRmbState(index)
widget:SetChildActive(itemcmp.rmbRecv,rmbState==RewardTempState.eRecved)
local showData=self.buyDataList[showId]

local rmbRewards=showData.list[index].rmbRewards
widget:SetChildLayoutGroupCreateItems(itemcmp.rmbCreat,#rmbRewards,function(groupItemIndex)
local itemdata={}
local reward=rmbRewards[groupItemIndex]
itemdata[1]=reward[1]
itemdata[2]=reward[2]
itemdata.showStage=true
local itemwidget=widget:GetChildLayoutGroupGridItem(itemcmp.rmbCreat,groupItemIndex-1)
widgetHelper.setNormalRewardItem(itemwidget,0,itemdata)






itemwidget:SetChildButtonClick(2,function()
self:onPrize(index)
end,true)
itemwidget:SetChildActive(item2cmp.gray,rmbState==RewardTempState.eRecved or rmbState==RewardTempState.eNotRecv)
itemwidget:SetChildActive(item2cmp.lock,buyedId==nil)
itemwidget:SetChildActive(item2cmp.spriteani,rmbState==RewardTempState.eRecv)
itemwidget:SetChildActive(item2cmp.select,false)
end)


else
widget:SetChildActive(itemcmp.rmbRecv,false)
widget:SetChildActive(itemcmp.rmbCreat,false)
widget:SetChildActive(itemcmp.addBtn,true)
widget:SetChildButtonClick(itemcmp.addBtn,function()
self:openBuyWin()
end,true)


end
end
end

function UISubAct_zixuantouzi_Win:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_zixuantouzi_Win:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_zixuantouzi_Win:updateCDTick()
local leftTime=activitiesModel:getSubActEndLeftTime(self.actID,self.subType,self.subid)
self.lefttime:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp3(leftTime)))
end


function UISubAct_zixuantouzi_Win:getSelectBuyId()
return self.sub_actInfo:getSelectBuyId()
end

function UISubAct_zixuantouzi_Win:getBuyedId()
return self.sub_actInfo:getBuyedId()
end

function UISubAct_zixuantouzi_Win:getCurScore()
return self.sub_actInfo:getCurScore()
end

function UISubAct_zixuantouzi_Win:getRecvIndex()
return self.sub_actInfo:getRecvIndex()
end

function UISubAct_zixuantouzi_Win:getFreeState(index)
local recvIndex=self:getRecvIndex()
if recvIndex>=index then
return RewardTempState.eRecved
end
local data=self.scrollerDataList[index]
local curScore=self:getCurScore()
if curScore>=data.targetScore then
return RewardTempState.eRecv
end
return RewardTempState.eNotRecv
end

function UISubAct_zixuantouzi_Win:getRmbState(index)
local recvIndex=self:getRecvIndex()
local buyId=self:getBuyedId()
if not buyId then
return RewardTempState.eNotRecv
end
if recvIndex>=index then
return RewardTempState.eRecved
end
local data=self.scrollerDataList[index]
local curScore=self:getCurScore()

if curScore>=data.targetScore then
return RewardTempState.eRecv
end
return RewardTempState.eNotRecv
end







function UISubAct_zixuantouzi_Win:onUnlcokBtn()
local selectBuyId=self:getSelectBuyId()
self:openBuyWin(selectBuyId)









end



function UISubAct_zixuantouzi_Win:onJumpBtn()

local jumpCfg=self.config.jumpCfg
if not jumpCfg then
return
end
if#jumpCfg==1 then
local info=jumpCfg[1]
local jump=info.jump
gainControl:handleJump(jump)
return
end
local args={
title='积分获取',
tips="可通过以下途径获取积分，达到目标：",
gainWayList=jumpCfg,
}
self:showWindow("UICommonGainWayWin",args)
end



function UISubAct_zixuantouzi_Win:onTipsBtn()
local d={}
d.title='说明'
d.mode=3
d.name='ui_zixuantouzi_help_%d'
self:showWindow('UIRuleWin',d)
end

function UISubAct_zixuantouzi_Win:onPrize(index)
call_activitiesHandle_func("activitiesHandle_zixuantouzi","reqGetReward",self.actID,self.subid,1)
end

function UISubAct_zixuantouzi_Win:openBuyWin(selectId)
local args={}
args.act_id=self.actID
args.sub_act_type=self.subType
args.sub_act_id=self.subid
args.selectId=selectId
args.list=self.buyDataList

self:showWindow("UISubAct_ZXTZ_Buy_Win",args)
end

function UISubAct_zixuantouzi_Win:onReSetBtn()
self:openBuyWin()
end



