







def_class("UIYLZAccWin",UIWindowBase)









function UIYLZAccWin:bindComponents()

self.acctime=UIText.get(self,0)
self.addBtn=UIButton.get(self,1)
self.allSelect=UIButton.get(self,2)
self.handleImg=UIObject.get(self,3)
self.materials=UIObject.get(self,4)
self.materialsItem_1=UIBaseItem.get(self,5)
self.materialsItem_2=UIBaseItem.get(self,6)
self.materialsItem_3=UIBaseItem.get(self,7)
self.materialsItem_4=UIBaseItem.get(self,8)
self.peo=UIText.get(self,9)
self.root=UIObject.get(self,10)
self.selectCntText=UIText.get(self,11)
self.slider=UIObject.get(self,12)
self.subBtn=UIButton.get(self,13)
self.time=UIText.get(self,14)
self.useButton=UIButton.get(self,15)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.allSelect:setButtonClick(function()self:onAllSelect()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.useButton:setButtonClick(function()self:onUseButton()end)
self.materialsItem={
self.materialsItem_1,
self.materialsItem_2,
self.materialsItem_3,
self.materialsItem_4,
}



end


function UIYLZAccWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.acctime);self.acctime=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.allSelect);self.allSelect=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.materials);self.materials=nil;
_UIObject_release(self.materialsItem_1);self.materialsItem_1=nil;
_UIObject_release(self.materialsItem_2);self.materialsItem_2=nil;
_UIObject_release(self.materialsItem_3);self.materialsItem_3=nil;
_UIObject_release(self.materialsItem_4);self.materialsItem_4=nil;
_UIObject_release(self.peo);self.peo=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.slider);self.slider=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.useButton);self.useButton=nil;
self.materialsItem=nil;
end



















function UIYLZAccWin:onLoaded(...)
self:bindComponents()
self.itemWidget={}
for i,v in ipairs(self.materialsItem)do
self.itemWidget[i]=v:getWidgetBase()
end
end


function UIYLZAccWin:__delete()
self:unbindComponents()
end




function UIYLZAccWin:onShow(argtable,afterOnloaded)


local endStamp=argtable.endStamp
self.endStamp=endStamp

self.speedType=argtable.speedType

self.buildId=argtable.buildId

self.builduId=argtable.builduId

self.timeTips=argtable.timeTips or"<color=#7d3b17>治疗剩余时长：</color>{0}"

local now=timeHelper.getServerShortTime()

if endStamp-now>0 then
self.time:setText(FMT.fmt(self.timeTips,timeHelper.format_time_stamp2(endStamp-now)))
self:startLeftTimer()
else
self.isTimeUp=true
self.time:setText(FMT.fmt(self.timeTips,"0秒"))
end

local accCfg=cfgHelper.get3(cfg_monijybasicconfig_get,1,"reduce_allow",self.speedType)
self.accPermission={}
for i,v in pairs(accCfg)do
table.insert(self.accPermission,i)
end
table.sort(self.accPermission)

self.accListern={}
for i=#self.accPermission,1,-1 do
local mode=self.accPermission[i]
local costCfg=cfgHelper.get3(cfg_monijybasicconfig_get,1,"reduce_times",mode)
for itemId,itemCfg in pairs(costCfg)do
local buildId=itemCfg[4]
if buildId and buildId[self.buildId]then


table.insert(self.accListern,{mode,itemId,itemCfg[1],itemCfg[2],itemCfg[3]})

end
end
end

table.sort(self.accListern,function(a,b)
local aColor=itemsConfig.getItemColor(a[2])
local bColor=itemsConfig.getItemColor(b[2])
if aColor==bColor then
return a[2]<b[2]
else
return aColor<bColor
end

end)


self:refreshAccelerateCost()
end

function UIYLZAccWin:refreshAccelerateCost()
for i,item in ipairs(self.materialsItem)do
if self.accListern[i]then
item:setActive(true)
local cost=self.accListern[i]
local matItemId=cost[2]
local have=bagModel.getNotExpireItemCountById(matItemId)
local countStr=have

local showStage=not moneyConfig.isMoney(matItemId)

local conf={itemid=matItemId,itemcount=countStr,showCountBG=true,showStage=showStage}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetGray,0)]=have==0
prop[PropIndex(DataPropKey.eWidgetGray,1)]=have==0
prop[PropIndex(DataPropKey.eWidgetText,9)]=timeHelper.formatSimpleTime(cost[4])
item:setChildPropData(prop)
local _onClickMaterialItem=function(...)
self:onClickMaterialItem(i)
end
item:setBaseItemChildID(matItemId)
item:setBaseItemClickEvent(_onClickMaterialItem)
else
item:setActive(false)
end
end

self:onClickMaterialItem(1)
end

function UIYLZAccWin:onClickMaterialItem(i)
if self.selectItemIdx==i then return end

local cost=self.accListern[i]
local item=self.itemWidget[i]

if not cost then
return
end

if self.selectItemIdx then
local pitem=self.itemWidget[self.selectItemIdx]
pitem:SetChildActive(8,false)
end

self.selectItemIdx=i



item:SetChildActive(8,true)

local have=bagModel.getNotExpireItemCountById(cost[2])
local time=cost[4]
local need=cost[3]

self.selectNum=need

local now=timeHelper.getServerShortTime()
local left=self.endStamp-now

local num=math.ceil(left/time)

if math.floor(num/need)>have then
num=have
end

self.selectItemId=cost[2]
self.max=num/need
self.min=1
self.need=need

self.winlua:SetChildImageRaycast(self.handleImg:getID(),have>=need)
self.winlua:SetChildImageRaycast(self.subBtn:getID(),have>=need)
self.winlua:SetChildImageRaycast(self.addBtn:getID(),have>=need)

self.slider:setChildSliderInit(1,1,num/need,function(val)
self.selectNum=val*need
self.selectCntText:setText(self.selectNum)
self.acctime:setText(FMT.fmt("总加速时长：{0}",timeHelper.format_time_stamp2(val*time)))
end)
end

function UIYLZAccWin:onAddBtn()
if self.selectNum/self.need>=self.max then
return
end
self.slider:setChildSliderValue(self.selectNum/self.need+1)
end

function UIYLZAccWin:onSubBtn()
if self.selectNum/self.need<=self.min then
return
end
self.slider:setChildSliderValue(self.selectNum/self.need-1)
end

function UIYLZAccWin:startLeftTimer()
self.timerid=self:setTimer(1,-1,function()
local now=timeHelper.getServerShortTime()
if self.endStamp-now>0 then
self.time:setText(FMT.fmt(self.timeTips,timeHelper.format_time_stamp2(self.endStamp-now)))
else
self.isTimeUp=true
self.time:setText(FMT.fmt(self.timeTips,"0秒"))
if self.timeid then
self:stopTimerByID(self.timeid)
self.timerid=nil
end
end
end)
end


function UIYLZAccWin:onHide()

end





function UIYLZAccWin:onAllSelect()
local now=timeHelper.getServerShortTime()
local left=self.endStamp-now
local num
local useList={}
for i,cost in ipairs(self.accListern)do

local matItemId=cost[2]
local have=bagModel.getNotExpireItemCountById(cost[2])

local time=cost[4]
local need=cost[3]

local use=0

num=math.ceil(left/time)
if math.floor(num/need)>have then
use=have
else
use=num
end

left=left-time*use

if use>0 then
table.insert(useList,{self.builduId or 0,use,matItemId})
end

if left<=0 then
break
end
end

if next(useList)then
local okCall=function()
if self.isTimeUp then
UIManager.error("治疗完成")
return
end
zongmenControl:reqSpeedup(speedUpMode.eItemBuilding,0,0,self.speedType,mapIdType.fort,0,useList)
UIManager:closeWindow('UICommonPageWin')
self:closeSelf()
end

local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eYLZAcc)
if flag then
okCall()
return
end

local itemlist={}
for i,v in ipairs(useList)do
table.insert(itemlist,{itemid=v[3],itemcount=v[2]})
end
local now=timeHelper.getServerShortTime()
local endStamp=self.endStamp
local show_data={
type='UIDialougeBuyWithReward3',
title='一键使用',
oktext='确定',
canceltext='取消',
itemlist=itemlist,
tip=FMT.fmt("<color=#171311>治疗剩余时长：{0}</color>",timeHelper.format_time_stamp2(endStamp-now)),
tipRefresh=function(dSelf)
if dSelf and not dSelf.isClose then
if endStamp-now>0 then
dSelf.tip:setText(FMT.fmt("治疗剩余时长：{0}",timeHelper.format_time_stamp2(endStamp-now)))
dSelf.timerid=dSelf:setTimer(1,-1,function()
local now=timeHelper.getServerShortTime()
if endStamp-now>0 then
dSelf.tip:setText(FMT.fmt("治疗剩余时长：{0}",timeHelper.format_time_stamp2(endStamp-now)))
else
dSelf.tip:setText("治疗剩余时长：0秒")
if dSelf.timeid then
dSelf:stopTimerByID(dSelf.timeid)
dSelf.timerid=nil
end
end
end)
else
dSelf.tip:setText("治疗剩余时长：0秒")
end
end
end,
tip2="您确认使用以下道具进行一键加速？",
showclosebtn=true,
okcallback=okCall,
cancelcallback=nil,
closecallback=nil,
canvasindex=10,


}
local dialog=UIDialogManager.newDialog(show_data)
dialog.choosetext="今日不再提示"
dialog.choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eYLZAcc,flag)
end
dialog:show()
end
end



function UIYLZAccWin:onUseButton()
if self.isTimeUp then
UIManager.error("治疗完成")
return
end

if not self.selectItemId then
return
end
local have=bagModel.getNotExpireItemCountById(self.selectItemId)
if have<self.selectNum/self.need then
gainControl:showCommonGainWin_item(self.selectItemId)
return
end
zongmenControl:reqSpeedup(speedUpMode.eItemBuilding,0,0,self.speedType,mapIdType.fort,0,{{self.builduId or 0,self.selectNum,self.selectItemId}})

UIManager:closeWindow('UICommonPageWin')
self:closeSelf()
end

