







def_class("UIJCYLJiXianJiangLiWin",UIWindowBase)









function UIJCYLJiXianJiangLiWin:bindComponents()

self.title=UIText.get(self,0)
self.closeButton=UIButton.get(self,1)
self.taskList=UIObject.get(self,2)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIJCYLJiXianJiangLiWin")end)



end


function UIJCYLJiXianJiangLiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.taskList);self.taskList=nil;
end



















function UIJCYLJiXianJiangLiWin:onLoaded(...)
self:bindComponents()
end


function UIJCYLJiXianJiangLiWin:__delete()
self:unbindComponents()
end




function UIJCYLJiXianJiangLiWin:onShow(argtable,afterOnloaded)
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eJiuCengYaoLou
self.subid=argtable.sub_act_id
self.floorDataList=argtable.data

local jiXianList={}
for i,v in ipairs(self.floorDataList)do
local floor=v.floor
local reward=activitiesHandle_jiucengyaolou:get_jixianCiTiao(self.subid,floor)
if reward and next(reward)then
local num
for i,v in pairs(reward)do num=i break end
table.insert(jiXianList,{floor=floor,reward=reward[num],num=num})

end
end

self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
if self.info then
self.shoutongData=self.info:getJiXianJiangLi(true)
end
self.jiXianList=jiXianList
self:onRefresh(jiXianList)
end

function UIJCYLJiXianJiangLiWin:onRecv()
self.taskList:setChildScrollViewCreateGrids(#self.jiXianList,1)
self.shoutongData=self.info:getJiXianJiangLi()or{}
local items=self.taskList:getChildScrollViewItemWidgets()
for i=0,items.Count-1 do
local item=items[i]
local notHaveShowTong=true
local data=self.jiXianList[i+1]
local floor=data.floor
if self.shoutongData then
local showtong=self.shoutongData[floor]
if showtong then
notHaveShowTong=false

item:SetChildActive(1,true)
playerController:setHeadIcon(item,1,{scale=0.9,iconInfo=showtong.iconInfo})
item:SetChildText(2,showtong.param_3)
item:SetChildActive(3,false)
item:SetChildActive(11,false)
end
end
if notHaveShowTong then
item:SetChildText(2,"")
item:SetChildActive(1,false)
item:SetChildActive(3,true)
item:SetChildActive(11,true)
end
end

end

function UIJCYLJiXianJiangLiWin:onRefresh(jiXianList)
jiXianList=jiXianList or self.jiXianList
self.taskList:setChildScrollViewCreateGrids(#jiXianList,1)
local items=self.taskList:getChildScrollViewItemWidgets()
local jump=nil
for i=0,items.Count-1 do
local item=items[i]
local index=i+1
local data=jiXianList[index]
local floor=data.floor
local rewards=data.reward
local num=data.num
local rewardNum=#rewards
item:SetChildLayoutGroupCreateItems(5,rewardNum)

local isGot=self.info:isJXGot(floor)
local canGet=self.info:isJXGetReward(floor)
local groupGrids=item:GetChildLayoutGroupGridList(5)
for ii=1,rewardNum do
local itemGrid=groupGrids[ii-1]
if itemGrid then
local reward=rewards[ii]
local itemid=reward[1]
local count=reward[2]
local conf={itemid=itemid,itemcount=count,showCountBG=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemGrid:SetChildPropData(-1,prop)
itemGrid:SetChildButtonClick(9,function()

if canGet and not isGot then
local time=timeHelper.getServerShortTime()
self.clickTime=self.clickTime or{}
if self.clickTime[floor]and time<self.clickTime[floor]+2 then
return
end
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actid,self.subType,self.subid,jsonHelper.encode({4,unpack(self:getSendList())}))
else
tipsManager.showTips({itemid=itemid})
end
end)
itemGrid:SetChildLongTouch(9,i,0.5,function()
tipsManager.showTips({itemid=itemid})
end)
itemGrid:SetChildGray(-1,isGot)
end
end
item:SetChildText(4,FMT.fmt("第{0}层",floor))

if not jump and not isGot then
jump=index
end

item:SetChildActive(8,isGot)
item:SetChildActive(6,not isGot)
item:SetChildActive(10,canGet and not isGot)

item:SetChildText(7,canGet and""or"")
item:SetChildButtonClick(6,function()

end)
local notHaveShowTong=true
if self.shoutongData then
local showtong=self.shoutongData[floor]
if showtong then
notHaveShowTong=false
item:SetChildActive(1,true)
item:SetChildActive(3,false)
item:SetChildActive(11,false)
item:SetChildText(2,showtong.param_3)
playerController:setHeadIcon(item,1,{scale=0.9,iconInfo=showtong.iconInfo})
end
end
if notHaveShowTong then
item:SetChildText(2,"")
item:SetChildActive(1,false)
item:SetChildActive(3,true)
item:SetChildActive(11,true)
end
end
if jump then
self.taskList:setChildScrollViewSelectItem(jump-1,true,true,false)
end
end


function UIJCYLJiXianJiangLiWin:onHide()

end

function UIJCYLJiXianJiangLiWin:getSendList()
local list={}
for i,data in ipairs(self.jiXianList)do
local floor=data.floor
local isGot=self.info:isJXGot(floor)
local canGet=self.info:isJXGetReward(floor)
if canGet and not isGot then
table.insert(list,floor)
end
end
return list
end


