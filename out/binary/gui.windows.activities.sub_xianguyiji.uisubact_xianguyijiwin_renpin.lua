







def_class("UISubAct_xianguyijiWin_RenPin",UIWindowBase)









function UISubAct_xianguyijiWin_RenPin:bindComponents()

self.background=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.creater=UIGameobjectClone.new(self,2)
self.closeBtn=UIButton.get(self,3)
self.item_1=UIObject.get(self,4)
self.item_2=UIObject.get(self,5)
self.list_2=UIObject.get(self,6)
self.list_1=UIObject.get(self,7)
self.tips=UIText.get(self,8)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.item={
self.item_1,
self.item_2,
}
self.list={
self.list_1,
self.list_2,
}



end


function UISubAct_xianguyijiWin_RenPin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.root);self.root=nil;
self.creater:deleteSelf();self.creater=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.item_1);self.item_1=nil;
_UIObject_release(self.item_2);self.item_2=nil;
_UIObject_release(self.list_2);self.list_2=nil;
_UIObject_release(self.list_1);self.list_1=nil;
_UIObject_release(self.tips);self.tips=nil;
self.item=nil;
self.list=nil;
end
















local _this=nil
local _itemKid={
titleTx=0,
head=1,


zmTx=3,
nameTx=4,
valueTx=5,
addBtn=6,
delBtn=7,
walkBg=8,
walkTx=9,
addTx=10,
delTx=11,
wait=12,
}




function UISubAct_xianguyijiWin_RenPin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_xianguyijiWin_RenPin:__delete()

self:unbindComponents()
_this=nil
end




function UISubAct_xianguyijiWin_RenPin:onShow(argtable,afterOnloaded)
self.activityId=argtable.activityId
self.subType=argtable.subType
self.subId=argtable.subId
self.activityData=argtable.activityData
self.config=argtable.config

local textStr=self.config.textStr or"探寻"
self.tips.setText(FMT.fmt("（十连{0}才能上榜，活动结束后奖励通过邮件发放）",textStr))









self:onLoadBackFinish()

end


function UISubAct_xianguyijiWin_RenPin:onHide()

end




function UISubAct_xianguyijiWin_RenPin:onCloseBtn()
if self.loaded then
self:closeSelf()
end
end

function UISubAct_xianguyijiWin_RenPin:onBackground()
self:onCloseBtn()
end

function UISubAct_xianguyijiWin_RenPin:initView()
for i,v in ipairs(self.list)do
local colName=FMT.fmt("reward{0}",i)
local cfg=self.config[colName]
v:setChildLayoutGroupCreateItems(#cfg,function(index)
local item=v:getChildLayoutGroupGridItem(index-1)
local rewardData=cfg[index]
local rewardId=rewardData[1]
local rewardNum=rewardData[2]
local showCountBG=rewardNum>1
local countStr=showCountBG and mathHelper.formatNumber(rewardNum)or''
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(0,function(...)itemsComponentHelper.onItemClick(...)end)
item:SetChildPropData(0,prop)
end)
end

for i,v in ipairs(self.item)do
local widget=v:getWidgetBase()
widget:SetChildText(_itemKid.titleTx,i==1 and"欧皇"or"非酋")
widget:SetChildButtonClick(_itemKid.addBtn,function()
self:onClickAdd(i)
end)
widget:SetChildButtonClick(_itemKid.delBtn,function()
self:onClickDel(i)
end)
widget:SetChildButtonClick(_itemKid.head,function()
self:onClickHead(i)
end)
end
end

function UISubAct_xianguyijiWin_RenPin:onClickAdd(index)
local data=self.data[index]
if data then
local limit=self.activityData:getData()
local isGood=index==1
local have=isGood and limit.good or limit.bad
if self.config.dz_all_times and have<self.config.dz_all_times then
local jstr=jsonHelper.encode({3,1,index})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.activityId,self.subType,self.subId,jstr)

data.dz_times=data.dz_times+1

local widget=self.item[index]:getWidgetBase()
widget:SetChildText(_itemKid.addTx,data.dz_times)

if isGood then
limit.good=limit.good+1
if limit.good>=self.config.dz_all_times then
widget:SetChildUIGray(_itemKid.addBtn,true)
widget:SetChildUIGray(_itemKid.delBtn,true)
end
else
limit.bad=limit.bad+1
if limit.bad>=self.config.dz_all_times then
widget:SetChildUIGray(_itemKid.addBtn,true)
widget:SetChildUIGray(_itemKid.delBtn,true)
end
end

UIManager:invokeUIMethod("UISubAct_xianguyijiWin","refreshLuckReddot")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
else
UIManager.error("今日次数已用完")
end
end
end

function UISubAct_xianguyijiWin_RenPin:onClickDel(index)
local data=self.data[index]
if data then
local limit=self.activityData:getData()
local isGood=index==1
local have=isGood and limit.good or limit.bad
if self.config.dz_all_times and have<self.config.dz_all_times then
local jstr=jsonHelper.encode({3,2,index})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.activityId,self.subType,self.subId,jstr)

data.dc_times=data.dc_times+1

local widget=self.item[index]:getWidgetBase()
widget:SetChildText(_itemKid.delTx,data.dc_times)

if isGood then
limit.good=limit.good+1
if limit.good>=self.config.dz_all_times then
widget:SetChildUIGray(_itemKid.addBtn,true)
widget:SetChildUIGray(_itemKid.delBtn,true)
end
else
limit.bad=limit.bad+1
if limit.bad>=self.config.dz_all_times then
widget:SetChildUIGray(_itemKid.addBtn,true)
widget:SetChildUIGray(_itemKid.delBtn,true)
end
end


UIManager:invokeUIMethod("UISubAct_xianguyijiWin","refreshLuckReddot")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
else
UIManager.error("今日次数已用完")
end
end
end

function UISubAct_xianguyijiWin_RenPin:refreshView(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshViewImp()
end
end

function UISubAct_xianguyijiWin_RenPin:refreshViewImp()
self.data=self.activityData:getCommentData()
if self.data then
for i,v in ipairs(self.item)do
self:refreshViewItem(i)
end
end
end

function UISubAct_xianguyijiWin_RenPin:refreshViewItem(i)
local widget=self.item[i]:getWidgetBase()
local data=self.data[i]
if data then
widget:SetChildText(_itemKid.zmTx,data.zm_name)
widget:SetChildText(_itemKid.nameTx,data.actor_name)
widget:SetChildText(_itemKid.valueTx,FMT.fmt("欧气值：{0}",data.ouqi_value))
widget:SetChildText(_itemKid.addTx,data.dz_times)
widget:SetChildText(_itemKid.delTx,data.dc_times)













playerController:setHeadIcon(widget,_itemKid.head,{iconInfo=data.iconInfo})

widget:SetChildActive(_itemKid.wait,false)
widget:SetChildActive(_itemKid.addBtn,true)
widget:SetChildActive(_itemKid.delBtn,true)

local activityData=self.activityData:getData()
local have=i==1 and activityData.good or activityData.bad
local gray=self.config.dz_all_times and have>=self.config.dz_all_times
widget:SetChildUIGray(_itemKid.addBtn,gray)
widget:SetChildUIGray(_itemKid.delBtn,gray)
else
widget:SetChildText(_itemKid.zmTx,"")
widget:SetChildText(_itemKid.nameTx,"")
widget:SetChildText(_itemKid.valueTx,"")
widget:SetChildText(_itemKid.addTx,"")
widget:SetChildText(_itemKid.delTx,"")




playerController:setHeadIcon(widget,_itemKid.head,nil)
widget:SetChildActive(_itemKid.wait,true)
widget:SetChildActive(_itemKid.addBtn,false)
widget:SetChildActive(_itemKid.delBtn,false)
end
end

function UISubAct_xianguyijiWin_RenPin:refreshViewItem_Num(i)
local widget=self.item[i]:getWidgetBase()
local data=self.data[index]
widget:SetChildText(_itemKid.addTx,data.dz_times)
widget:SetChildText(_itemKid.delTx,data.dc_times)

local activityData=self.activityData:getData()
local have=i==1 and activityData.good or activityData.bad
local gray=self.config.dz_all_times and have>=self.config.dz_all_times
widget:SetChildUIGray(_itemKid.addBtn,gray)
widget:SetChildUIGray(_itemKid.delBtn,gray)
end

function UISubAct_xianguyijiWin_RenPin:onLoadBackFinish()
if not self.loaded then
self.loaded=true
self.root:setActive(true)
end

self:initView()
self:refreshViewImp()
end

function UISubAct_xianguyijiWin_RenPin:onClickHead(index)
local data=self.data[index]
otherPlayerController:openOtherPlayerInfoWin(data.actor_id)
end