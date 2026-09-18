







def_class("UISubAct_TianTiShiLian_AchieveWin",UIWindowBase)









function UISubAct_TianTiShiLian_AchieveWin:bindComponents()

self.root=UIObject.get(self,0)
self.achieveList=UIScrollView.get(self,1)
self.closeBtn=UIButton.get(self,2)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_TianTiShiLian_AchieveWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.achieveList);self.achieveList=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end















local _this

local achieveItemCompIndex={
achieveInfo=0,
rewardlist=1,
reveiveBtn=2,
noReachImg=3,
receivedImg=4,
}



function UISubAct_TianTiShiLian_AchieveWin:onLoaded(...)
self:bindComponents()
_this=self
self.achieveList:bindScrollWidget(function(...)self:bindAchieveWidet(...)end)
end


function UISubAct_TianTiShiLian_AchieveWin:__delete()
self:unbindComponents()
end




function UISubAct_TianTiShiLian_AchieveWin:onShow(argtable,afterOnloaded)
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eTianTiShiLian
self.subid=argtable.sub_act_id

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)



self:refresh()
end


function UISubAct_TianTiShiLian_AchieveWin:onHide()

end

function UISubAct_TianTiShiLian_AchieveWin:initData()
self.aimDataList={}
for k,adata in pairs(self.config.aim)do
local temp={}
temp.adata=adata
temp.index=k
temp.isReceived=bitHelper.check_pos(self.info.aimflag,k-1)
temp.isReach=self.info.totalfloor>=adata[1]

temp.sortwidget=0

if temp.isReach then
temp.sortwidget=10000+k
elseif temp.isReceived then
temp.sortwidget=k
else
temp.sortwidget=100+k
end

table.insert(self.aimDataList,temp)
end

table.sort(self.aimDataList,function(a,b)
return a.sortwidget<b.sortwidget
end)
end

function UISubAct_TianTiShiLian_AchieveWin:refresh()
self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
self:initData()
self.achieveList:clearItems()
self.achieveList:freshGridsNum(#self.aimDataList,1,#self.aimDataList,not self.listZore)
self.listZore=true
end

function UISubAct_TianTiShiLian_AchieveWin:bindAchieveWidet(index,item)
local achieveData=self.aimDataList[index]

local reachFloor=achieveData.adata[1]
item:SetChildText(achieveItemCompIndex.achieveInfo,FMT.fmt("天梯高度累计达到{0}层",reachFloor))

item:SetChildActive(achieveItemCompIndex.noReachImg,not achieveData.isReach)
item:SetChildActive(achieveItemCompIndex.receivedImg,achieveData.isReceived)
item:SetChildActive(achieveItemCompIndex.reveiveBtn,not achieveData.isReceived and achieveData.isReach)

item:SetChildButtonClick(achieveItemCompIndex.reveiveBtn,function()

activitiesHandle_tiantishilian:sendAchieveReward(_this.actid,_this.subid,achieveData.index)
end)


local initPropDataList={}
for k,reward in pairs(achieveData.adata[2])do
local conf={itemid=reward[1],itemcount=reward[2]>1 and reward[2]or'',showCountBG=reward[2]>1,showname=false}
table.insert(initPropDataList,itemsComponentHelper.getCommonFillDataSmall(conf))
end
item:SetChildUIBaseScrollPropData(achieveItemCompIndex.rewardlist,initPropDataList)
end





function UISubAct_TianTiShiLian_AchieveWin:onCloseBtn()
self:closeSelf()
end

