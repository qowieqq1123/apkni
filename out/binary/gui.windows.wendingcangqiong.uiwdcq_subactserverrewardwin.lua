







def_class("UIWDCQ_SubActServerRewardWin",UIWindowBase)









function UIWDCQ_SubActServerRewardWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.djsBg=UIObject.get(self,1)
self.djsTxt=UIText.get(self,2)
self.list=UIObject.get(self,3)
self.Root=UIObject.get(self,4)
self.scrollerView=UIObject.get(self,5)
self.sloganTxt=UIText.get(self,6)
self.uiRoot=UIObject.get(self,7)



end


function UIWDCQ_SubActServerRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.djsBg);self.djsBg=nil;
_UIObject_release(self.djsTxt);self.djsTxt=nil;
_UIObject_release(self.list);self.list=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.sloganTxt);self.sloganTxt=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local CmpGroupItemIndex={
titleIcon=0,
list=1,
}

local CmpSubItemIndex={
mcIcon=0,
roleInfo=1,
nameTxt=2,
serverTxt=3,
head=4,
rewardList=5,
loseHead=6,
}


local _width=730


local _topPadding=50


local _itemHeight=100
local _itemSpace=3





function UIWDCQ_SubActServerRewardWin:onLoaded(...)
self:bindComponents()
end


function UIWDCQ_SubActServerRewardWin:__delete()
self:clearTimer()

self:unbindComponents()
end




function UIWDCQ_SubActServerRewardWin:onShow(argtable,afterOnloaded)

self.groupDatas=WDCQController.getQuFuRewardActData()




local groupLen=#self.groupDatas


local totalHeight=0
self.stageHeightList={}

for index,groupData in ipairs(self.groupDatas)do
local listLen=#groupData.list

local height=listLen*_itemHeight+(listLen-1)*_itemSpace
self.stageHeightList[index]=height

local groupHeight=height+_topPadding
totalHeight=totalHeight+groupHeight
end


self.list:setChildLayoutGroupCreateItems(groupLen,function(...)self:groupCreateFunc(...)end)

self.list:setChildSizeDelta(_width,totalHeight)

self:freshTimer()

self.bgModel:setChildUIModelShowTarget(5577,1,nil,eAnimationID.stand)
end


function UIWDCQ_SubActServerRewardWin:onHide()

end


function UIWDCQ_SubActServerRewardWin:groupCreateFunc(index)
local item=self.list:getChildLayoutGroupGridItem(index-1)

local data=self.groupDatas[index]
local groupId=data.groupId

local listLen=#data.list

local groupNameIcon=WDCQController.getGroupIconName(groupId)
item:SetChildCSImageSprite(CmpGroupItemIndex.titleIcon,globalABLookup.wendingcangqiong,groupNameIcon)

item:SetChildLayoutGroupCreateItems(CmpGroupItemIndex.list,listLen,function(index)
self:stageCreateFunc(index,item,data)
end)

local height=self.stageHeightList[index]+_topPadding
item:SetChildSizeDelta(-1,_width,height)
item:SetChildSizeDelta(CmpGroupItemIndex.list,_width,self.stageHeightList[index])
end

function UIWDCQ_SubActServerRewardWin:stageCreateFunc(index,item,data)
local sitem=item:GetChildLayoutGroupGridItem(CmpGroupItemIndex.list,index-1)

local sdata=data.list[index]


local roleInfo=WDCQModel:getRankRoleInfoLookUp(sdata.actorid)




local isLose=mathHelper.validInt64(sdata.actorid)and roleInfo.name==''

local mcIcon=FMT.fmt('imge_lundaopm_{0}',sdata.rank)
sitem:SetChildCSImageSprite(CmpSubItemIndex.mcIcon,globalABLookup.lundaodahui,mcIcon)

local bgIcon=FMT.fmt('image_qufuhuodong_{0}',sdata.rank+1)
sitem:SetChildCSImageSprite(-1,globalABLookup.wendingcangqiong,bgIcon)

local serverName=loginModel:getServerName(roleInfo.serverId)
serverName=FMT.fmt("[{0}]",serverName)
sitem:SetChildText(CmpSubItemIndex.serverTxt,serverName)
sitem:SetChildText(CmpSubItemIndex.nameTxt,playerModel:getOtherActorName(roleInfo.name))

sitem:SetChildActive(CmpSubItemIndex.head,not isLose)
sitem:SetChildActive(CmpSubItemIndex.loseHead,isLose)
if not isLose then
local iconInfo=roleInfo.iconInfo
playerController:setHeadIcon(sitem,CmpSubItemIndex.head,{scale=0.65,iconInfo=iconInfo})
end

local isReceive=sdata.isReceive==1

local rewardList=cfgHelper.get3(cfg_wendingcangqiongrankconfig_get,sdata.groupId,sdata.rank,'server_rewards')
local rewardLen=#rewardList
sitem:SetChildLayoutGroupCreateItems(CmpSubItemIndex.rewardList,rewardLen,function(rindex)
local ritem=sitem:GetChildLayoutGroupGridItem(CmpSubItemIndex.rewardList,rindex-1)

local rdata=rewardList[rindex]
local itemid=rdata[1]
local itemcount=rdata[2]
local showCountBG=itemcount>0
local itemCountStr=showCountBG and itemcount or""

local gray=isReceive and 1 or 0


ritem:SetChildActive(1,isReceive)

local conf={itemid=itemid,itemcount=itemCountStr,showCountBG=showCountBG,showStage=true,showname=false,gray=gray,colorEffect=not isReceive}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)

ritem:SetChildPropData(0,propData)
ritem:SetBaseItemClickEvent(0,function()
if isReceive then

itemsComponentHelper.onItemClick(itemid)
else

WDCQController.req_38_9(sdata.groupId,sdata.rank)
end
end)
end)
end

function UIWDCQ_SubActServerRewardWin:freshReceive(group,rank)
for index,groupData in ipairs(self.groupDatas)do
for lindex,ldata in ipairs(groupData.list)do
local item=self.list:getChildLayoutGroupGridItem(index-1)
ldata.isReceive=1
self:stageCreateFunc(lindex,item,groupData)
end
end
end

function UIWDCQ_SubActServerRewardWin:freshTimer()

self:clearTimer()

local qfTime=WDCQController.getQuFugEnterLeftTime()
local curTime=timeHelper.getServerShortTime()
local leftTime=qfTime-curTime
local func=function()
local residueTime=leftTime-Time.deltaTime

if residueTime>0 then
local info=FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp3(residueTime))
self.djsTxt:setText(info)
else
self.djsTxt:setText("活动已结束")
end
end

self.timer=self:setTimer(1,0,func)
func()
end

function UIWDCQ_SubActServerRewardWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end




function UIWDCQ_SubActServerRewardWin:getTestData()
local groupCfgList=WDCQController:getUnlockGroupCfgList()

local groupList={}

for index,cfg in ipairs(groupCfgList)do
local len=Mathf.Random(1,3)

if len>0 then
local temp={groupId=cfg.id,list={}}
groupList[index]=temp
for rank=1,len do
local tt={}

tt.actorid=playerModel:getActorID()
tt.groupId=cfg.id
tt.rank=rank
tt.isReceive=false

temp.list[rank]=tt
end
end
end

return groupList
end