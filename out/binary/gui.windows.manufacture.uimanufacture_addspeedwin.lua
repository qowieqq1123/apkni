







def_class("UIManufacture_addSpeedWin",UIWindowBase)









function UIManufacture_addSpeedWin:bindComponents()

self.add=UIButton.get(self,0)
self.addmore=UIButton.get(self,1)
self.btnApply=UIButton.get(self,2)
self.btnApplymore=UIButton.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.closeTipsBtn=UIButton.get(self,5)
self.count=UIText.get(self,6)
self.countmore=UIText.get(self,7)
self.cut=UIButton.get(self,8)
self.cutmore=UIButton.get(self,9)
self.desc=UIText.get(self,10)
self.descmore=UIText.get(self,11)
self.getitem=UIObject.get(self,12)
self.item=UIObject.get(self,13)
self.item1=UIObject.get(self,14)
self.item2=UIObject.get(self,15)
self.item3=UIObject.get(self,16)
self.item4=UIObject.get(self,17)
self.jlreddot=UIObject.get(self,18)
self.materialList=UIObject.get(self,19)
self.morebtn=UIButton.get(self,20)
self.moreimg=UIImage.get(self,21)
self.Moreroot=UIObject.get(self,22)
self.notSlider=UIObject.get(self,23)
self.ruleList=UIObject.get(self,24)
self.rulePart=UIObject.get(self,25)
self.singlebtn=UIButton.get(self,26)
self.singleroot=UIObject.get(self,27)
self.sinimg=UIImage.get(self,28)
self.slider=UIObject.get(self,29)
self.slidermore=UIObject.get(self,30)
self.state=UIButton.get(self,31)

self.add:setButtonClick(function()self:onAdd()end)

self.addmore:setButtonClick(function()self:onAddmore()end)

self.btnApply:setButtonClick(function()self:onBtnApply()end)

self.btnApplymore:setButtonClick(function()self:onBtnApplymore()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.closeTipsBtn:setButtonClick(function()self:onCloseTipsBtn()end)

self.cut:setButtonClick(function()self:onCut()end)

self.cutmore:setButtonClick(function()self:onCutmore()end)

self.morebtn:setButtonClick(function()self:onMorebtn()end)

self.singlebtn:setButtonClick(function()self:onSinglebtn()end)

self.state:setButtonClick(function()self:onState()end)



end


function UIManufacture_addSpeedWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.add);self.add=nil;
_UIObject_release(self.addmore);self.addmore=nil;
_UIObject_release(self.btnApply);self.btnApply=nil;
_UIObject_release(self.btnApplymore);self.btnApplymore=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.closeTipsBtn);self.closeTipsBtn=nil;
_UIObject_release(self.count);self.count=nil;
_UIObject_release(self.countmore);self.countmore=nil;
_UIObject_release(self.cut);self.cut=nil;
_UIObject_release(self.cutmore);self.cutmore=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.descmore);self.descmore=nil;
_UIObject_release(self.getitem);self.getitem=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.item2);self.item2=nil;
_UIObject_release(self.item3);self.item3=nil;
_UIObject_release(self.item4);self.item4=nil;
_UIObject_release(self.jlreddot);self.jlreddot=nil;
_UIObject_release(self.materialList);self.materialList=nil;
_UIObject_release(self.morebtn);self.morebtn=nil;
_UIObject_release(self.moreimg);self.moreimg=nil;
_UIObject_release(self.Moreroot);self.Moreroot=nil;
_UIObject_release(self.notSlider);self.notSlider=nil;
_UIObject_release(self.ruleList);self.ruleList=nil;
_UIObject_release(self.rulePart);self.rulePart=nil;
_UIObject_release(self.singlebtn);self.singlebtn=nil;
_UIObject_release(self.singleroot);self.singleroot=nil;
_UIObject_release(self.sinimg);self.sinimg=nil;
_UIObject_release(self.slider);self.slider=nil;
_UIObject_release(self.slidermore);self.slidermore=nil;
_UIObject_release(self.state);self.state=nil;
end


















local _rewardItemIndex={
root=0,
qualityEffect=1,
quality=2,
icon=3,
count=4,
stage=5,
lock=6,
stageBG=7,
gailv=8,
xin=9,
coutnBg=10,
grayImg=11,
teyou=12,
suit=13,
}

local _this=nil

function UIManufacture_addSpeedWin:onLoaded(...)
_this=self
self.Allitemidtable={}
self:bindComponents()
self._onMoneyChange=function(...)self:onMoneyChange(...)end
self._onItemChange=function(...)self:onItemChange(...)end
notifySystem:listenNotify(notifyConfig.on_money_changed,self._onMoneyChange)
notifySystem:listenNotify(notifyConfig.on_item_changed,self._onItemChange)
end


function UIManufacture_addSpeedWin:__delete()
_this=nil
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_money_changed,self._onMoneyChange)
notifySystem:removelistener(notifyConfig.on_item_changed,self._onItemChange)
end

function UIManufacture_addSpeedWin:onMoneyChange(moneyType,lastVal,val)
local moneyList=self.Allitemidtable
for i,v in ipairs(moneyList)do
local moneyInfo=moneyList[i]
if moneyInfo[1]==moneyType then
self:InitMoreData()
if self.isMore then
self:RefreshMoredata()
else
self:RefreshSingle()
end
break
end
end
end
function UIManufacture_addSpeedWin:onItemChange(changeType,itemguid,itemid,lastcount,itemcount)
local moneyList=self.Allitemidtable
for i,v in ipairs(moneyList)do
local moneyInfo=moneyList[i]
if moneyInfo[1]==itemid then
self:InitMoreData()
if self.isMore then
self:RefreshMoredata()
else
self:RefreshSingle()
end
break
end
end
end



function UIManufacture_addSpeedWin:onShow(argtable,afterOnloaded)
self.isMore=false
self.currVal=argtable.currVal
self.minVal=argtable.minVal
self.maxVal=argtable.maxVal
self.itemData=argtable.itemData
self.descFunc=argtable.descFunc2
self.applyFunc=argtable.applyFunc
self.plantCfg=argtable.plantCfg
self.speedupTime=argtable.speedupTime
self.firsttime=argtable.firsttime
self.pcreateaddpercent=argtable.pcreateaddpercent or 0
self.pcreatesubpercent=argtable.pcreatesubpercent or 0
self.pcreatetimepercent=argtable.pcreatetimepercent or 0
self.un_build_id=argtable.un_build_id
self.sfid=argtable.sfid
self.hasExNum=argtable.hasExNum
self.plant_id=argtable.plant_id
self.Moreroot:setActive(false)
self.singleroot:setActive(true)
self.state:setActive(false)
self.sinimg:setActive(true)
self.moreimg:setActive(false)

self:notneedrefresh()
self:RefreshSingle()
self:InitMoreData()
self.Allitemidtable={{16001}}
for k,v in ipairs(self.plantCfg.cost)do

local costid=v[1]
self.Allitemidtable[#self.Allitemidtable+1]={costid}
end
local rewards=self.plantCfg.rewards
local rewardid=rewards[1][1]
self.Allitemidtable[#self.Allitemidtable+1]={rewardid}
self:showWindow("UITopMoneyWin2",self.Allitemidtable)
self.rulePart:setActive(false)
self.closeTipsBtn:setActive(false)
self:refreshRulePart()
end


function UIManufacture_addSpeedWin:onHide()

end


function UIManufacture_addSpeedWin:RefreshSingle()
local have=0
if moneyConfig.isMoney(self.itemData[1])then
have=moneyModel.getMoney(self.itemData[1])
else
have=bagModel.getNotExpireItemCountById(self.itemData[1])
end
self.maxVal=math.min(have,math.ceil(self.firsttime/self.speedupTime))


self.winlua:SetChildSliderInit(self.slider:getID(),self.currVal,self.minVal,self.maxVal,function(val)
self.currVal=val
self.count:setText(val)
local desc=self.descFunc(val)
self.desc:setText(desc)
local itemtable={self.itemData[1],self.currVal}
widgetHelper.setNormalRewardItem(self.winlua,self.item:getID(),itemtable)
end)

end

function UIManufacture_addSpeedWin:onBtnApply()
self.applyFunc(self.currVal)
self:onCloseBtn()
end



function UIManufacture_addSpeedWin:onAdd()
if self.currVal<self.maxVal then
self.currVal=self.currVal+1
self.winlua:SetChildSliderValue(self.slider:getID(),self.currVal)
end
end



function UIManufacture_addSpeedWin:onCut()
if self.currVal>self.minVal then
self.currVal=self.currVal-1
self.winlua:SetChildSliderValue(self.slider:getID(),self.currVal)
end
end





function UIManufacture_addSpeedWin:notneedrefresh()
self.moreVal=1
end


function UIManufacture_addSpeedWin:InitMoreData()
self.moreMax=50
self.moreMin=1
local oneluntime=self.plantCfg[1]
local groups=self.plantCfg.groups
local singlelun=groups[1]
local oneFangAntime=self:setNeedTime(oneluntime,self.pcreatetimepercent,singlelun)
local have=0
if moneyConfig.isMoney(self.itemData[1])then
have=moneyModel.getMoney(self.itemData[1])
else
have=bagModel.getNotExpireItemCountById(self.itemData[1])
end

local speedCanFangAn=math.floor(((have-self.maxVal)*self.speedupTime)/oneFangAntime)+1


local cost=self.plantCfg.cost
local costFangAn=1
local costflag=false
for k,v in ipairs(cost)do

local costid=v[1]
local usecost=v[2]
local costnow=self:setCosts(v,self.pcreatesubpercent)
local havenum=itemsModel.getCount(costid)
local costFangAn_local=math.floor(havenum/costnow)+1
if costflag then
costFangAn=math.min(costFangAn_local,costFangAn)
else
costflag=true
costFangAn=costFangAn_local
end
end

local rewards=self.plantCfg.rewards
local rewardid=rewards[1][1]
local oneRewardnum=rewards[1][2]
local times=groups[1]
local count=self:setRewards(oneRewardnum,times)
local maxreward=zongmenModel:getWarehouseLimit(rewardid)
local have=moneyModel.getMoney(rewardid)
local Canaddnum=maxreward-have
local addFangAn=math.floor(Canaddnum/count)
if Canaddnum<=0 then
self.notCanAdd=true
end
local max=math.min(addFangAn,speedCanFangAn)

max=math.min(max,costFangAn)

self.moreMax=math.min(max,self.moreMax)
if self.moreMax<=0 then
self.moreMax=1
end
if self.moreVal>self.moreMax then
self.moreVal=self.moreMax
end

end

function UIManufacture_addSpeedWin:RefreshMoredata()

local rewards=self.plantCfg.rewards
local rewardid=rewards[1][1]
local oneRewardnum=rewards[1][2]
local groups=self.plantCfg.groups
local oneluntime=self.plantCfg[1]
local singlelun=groups[1]
local Rewardnum=self:setRewards(oneRewardnum,groups[1])
local needreduce=self:setRewards(oneRewardnum,self.hasExNum)

local firstreward=Rewardnum-needreduce

local getitemData={rewardid,firstreward}

local oneFangAntime=self:setNeedTime(oneluntime,self.pcreatetimepercent,singlelun)
local firsttime=self.firsttime


widgetHelper.setNormalRewardItem(self.winlua,self.getitem:getID(),getitemData)
self:setMoreItemText(firstreward,self.getitem)

local cost=self.plantCfg.cost
local cmp=
{
self.item1,
self.item2,
self.item3,
self.item4,
}


local index=0
index=index+1
local speeditemid=self.itemData[1]
local FangAnItemnum=math.ceil(firsttime/self.speedupTime)
local speeditemnum=FangAnItemnum
local speeditemdata={speeditemid,speeditemnum}
widgetHelper.setNormalRewardItem(self.winlua,cmp[index]:getID(),speeditemdata)
local countStr=mathHelper.formatNumber4(speeditemnum,1)
local have=0
if moneyConfig.isMoney(self.itemData[1])then
have=moneyModel.getMoney(self.itemData[1])
else
have=bagModel.getNotExpireItemCountById(self.itemData[1])
end
if speeditemnum>have then
local wid=cmp[index]:getWidgetBase()
wid:SetChildText(4,FMT.fmt('<color=#c83232>{0}</color>',countStr))
end


index=index+1
for i=index,4 do
cmp[i]:setActive(false)
end
if self.moreMax==1 then
self.moreMin=0
end
self.notSlider:setActive(self.moreMin==0)
self.winlua:SetChildSliderInit(self.slidermore:getID(),self.moreVal,self.moreMin,self.moreMax,function(val)
self.moreVal=val
self.countmore:setText(val)
local desc=FMT.fmt("执行生产方案次数<color=#7d3b17>{0}次</color>",val)
self.descmore:setText(desc)

self:setMoreItemText(Rewardnum*(self.moreVal-1)+firstreward,self.getitem)
for i=1,4 do
cmp[i]:setActive(true)
end
local index=0
index=index+1

if self.moreVal>1 then
local needspeedtime=(self.moreVal-1)*oneFangAntime
local FangAnItemnum=math.ceil(needspeedtime/self.speedupTime)
self:setMoreItemText(FangAnItemnum+speeditemnum,cmp[index])
else
self:setMoreItemText(speeditemnum,cmp[index])
if speeditemnum>have then
local wid=cmp[index]:getWidgetBase()
wid:SetChildText(4,FMT.fmt('<color=#c83232>{0}</color>',speeditemnum))
end
end

if self.moreVal>1 then
for k,v in ipairs(cost)do
index=index+1
local costid=v[1]
local usecost=v[2]
local useitemData={costid,usecost}
local costnow=self:setCosts(useitemData,self.pcreatesubpercent)
widgetHelper.setNormalRewardItem(self.winlua,cmp[index]:getID(),useitemData)
self:setMoreItemText((costnow*(self.moreVal-1)),cmp[index])
end
end

index=index+1
for i=index,4 do
cmp[i]:setActive(false)
end
end)
end

function UIManufacture_addSpeedWin:onAddmore()
if self.moreVal<self.moreMax then
self.moreVal=self.moreVal+1
self.winlua:SetChildSliderValue(self.slidermore:getID(),self.moreVal)
end
end

function UIManufacture_addSpeedWin:onCutmore()
if self.moreVal>self.moreMin then
self.moreVal=self.moreVal-1
self.winlua:SetChildSliderValue(self.slidermore:getID(),self.moreVal)
end
end

function UIManufacture_addSpeedWin:setRewards(rewards,times)
local count=0
for i=1,times do
count=count+math.floor(rewards*(self.pcreateaddpercent*0.01+1))
end
return count
end

function UIManufacture_addSpeedWin:setCosts(cost,percent)
if cost then
local mtype=cost[1]
local mval=cost[2]
local change=math.ceil(mval*percent/100)
local need=mval+change
return need
end
end

function UIManufacture_addSpeedWin:setNeedTime(need_time,percent,times)
local count=0
for i=1,times do
count=count+math.floor(need_time*(percent*0.01+1))
end
return count
end


function UIManufacture_addSpeedWin:setMoreItemText(count,item)

local countStr=mathHelper.formatNumber4(count,1)
local widget=item:getWidgetBase()
widget:SetChildText(4,countStr)
end

function UIManufacture_addSpeedWin:onMorebtn()
self.isMore=true
self.Moreroot:setActive(true)
self.singleroot:setActive(false)
self.sinimg:setActive(false)
self.moreimg:setActive(true)
self.state:setActive(true)
self:RefreshMoredata()
end



function UIManufacture_addSpeedWin:onSinglebtn()
self.isMore=false
self.Moreroot:setActive(false)
self.singleroot:setActive(true)
self.sinimg:setActive(true)
self.moreimg:setActive(false)
self.state:setActive(false)
self:RefreshSingle()
end


function UIManufacture_addSpeedWin:onBtnApplymore()
local oneluntime=self.plantCfg[1]
local groups=self.plantCfg.groups
local singlelun=groups[1]
local oneFangAntime=self:setNeedTime(oneluntime,self.pcreatetimepercent,singlelun)
local firsttime=self.firsttime
local FangAnItemnum=math.ceil(firsttime/self.speedupTime)
local speeditemnum=FangAnItemnum
local have=0
if moneyConfig.isMoney(self.itemData[1])then
have=moneyModel.getMoney(self.itemData[1])
else
have=bagModel.getNotExpireItemCountById(self.itemData[1])
end

if speeditemnum>have then
gainControl:showGainWin(self.itemData[1])
return
end
if self.notCanAdd then
local desc="仓库<color=#ca631d>{0}</color>容量已满，暂无法执行生产方案次数"
cangkuFullSolutionController:showCangKuFullSolutionByItemList(self.plantCfg.rewards,nil,desc)
return
end

local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eshengchanAddSpeed)
if not flag then
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt('是否执行正在生产的方案<color=#7d3b17>{0}次</color>？',self.moreVal),
canceltext='取消',
oktext='确定',
choosetext="今日不再提示",
choosecallback=function(flag)
if _this==nil then return end

dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eshengchanAddSpeed,flag)
end,
okcallback=function(...)
socketManager:send_6_185(self.sfid,self.un_build_id,self.plant_id,self.moreVal)
self:closeSelf()
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
else
socketManager:send_6_185(self.sfid,self.un_build_id,self.plant_id,self.moreVal)
self:closeSelf()
end

end

function UIManufacture_addSpeedWin:onCloseBtn()
self:closeSelf()
end

function UIManufacture_addSpeedWin:onState()

self.rulePart:setActive(true)
self.closeTipsBtn:setActive(true)
end

function UIManufacture_addSpeedWin:refreshRulePart()
local desclist={}
local name="AddSpeed_rule_%d"
for i=1,10 do
local str=cfgHelper.get1(cfg_lang_get,string.format(name,i))
if str~=nil then
table.insert(desclist,str)
end
end

local descLen=#desclist

self.ruleList:setChildLayoutGroupCreateItems(descLen,function(index)
local item=self.ruleList:getChildLayoutGroupGridItem(index-1)

local desc=desclist[index]

item:SetChildText(0,desc)
end)
end

function UIManufacture_addSpeedWin:onCloseTipsBtn()
self.rulePart:setActive(false)
self.closeTipsBtn:setActive(false)
end
