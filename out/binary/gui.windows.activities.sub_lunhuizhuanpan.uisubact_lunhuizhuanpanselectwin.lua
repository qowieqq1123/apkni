







def_class("UISubAct_lunhuizhuanpanSelectWin",UIWindowBase)









function UISubAct_lunhuizhuanpanSelectWin:bindComponents()

self.leftArrow=UIObject.get(self,0)
self.libContent=UIObject.get(self,1)
self.previewContent=UIObject.get(self,2)
self.previewMask=UIButton.get(self,3)
self.rewardPreviewPanel=UIObject.get(self,4)
self.rightArrow=UIObject.get(self,5)
self.root=UIObject.get(self,6)

self.previewMask:setButtonClick(function()self:onPreviewMask()end)



end


function UISubAct_lunhuizhuanpanSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.libContent);self.libContent=nil;
_UIObject_release(self.previewContent);self.previewContent=nil;
_UIObject_release(self.previewMask);self.previewMask=nil;
_UIObject_release(self.rewardPreviewPanel);self.rewardPreviewPanel=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.root);self.root=nil;
end


















local _this

function UISubAct_lunhuizhuanpanSelectWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_lunhuizhuanpanSelectWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_lunhuizhuanpanSelectWin:onShow(argtable,afterOnloaded)
self.libs=argtable.lib
self.activityId=argtable.activityId
self.subType=argtable.subType
self.subId=argtable.subId

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
self.actData=self.activityData.data
if not self.activityData or not self.actData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
local luck_lookup=self.actData.luck_lookup
self.select_idx=self.actData.select_idx
self.libContent:setChildLayoutGroupCreateItems(#self.libs,function(index)
local libItem=self.libContent:getChildLayoutGroupGridItem(index-1)
local small_rewards=self.actData.reward_lib[index]
local big_rewards=self.config.reward_preview_pro_pr[index][1]
libItem:SetChildLayoutGroupCreateItems(0,#small_rewards+1,function(idx)
local rewardItem=libItem:GetChildLayoutGroupGridItem(0,idx-1)
local is_big_rewawrd=idx==1
local rewards=is_big_rewawrd and big_rewards or small_rewards[idx-1]
local items=is_big_rewawrd and rewards or rewards.items
local isRewardList=is_big_rewawrd and#items>1
local itemid=is_big_rewawrd and items[1][1]or items[1]
local count=is_big_rewawrd and items[1][2]or items[2]
local reward_idx=is_big_rewawrd and 1 or rewards.idx
local luck_num=luck_lookup[reward_idx]or 0
local itemnum=is_big_rewawrd and 1 or(rewards.num-luck_num)

local itemConfig=itemsConfig.getConfig(itemid)
local itemColor=itemConfig.color
local iconName=iconHelper.getItemIconName(itemConfig.icon)
local countStr=''
if count>1 then
countStr=mathHelper.formatNumber(count)
end
rewardItem:SetChildCSImageSprite(0,"ui/windows/activities/sub_lunhuizhuanpan/lunhuizhuanpan_atlas_pak.ab",string.format("image_lunhuipanzhen_pzdk%d",itemColor))
rewardItem:SetChildIcon(1,iconName,true)
rewardItem:SetChildText(2,countStr)
rewardItem:SetChildText(3,string.format("<color=%s>%d份</color>",itemnum<=0 and"#f36666"or"#F1CE78",itemnum))
rewardItem:SetChildActive(4,is_big_rewawrd)
rewardItem:SetChildActive(5,is_big_rewawrd)
rewardItem:SetChildButtonClick(6,function()
if _this==nil or _this.isClose then return end
if not isRewardList then
itemsComponentHelper.onItemClickEx(itemid)
else
local pos=rewardItem:GetChildUIScreenPos(-1)
self:refreshPreviewReward(index,pos)
self.previewMask:setActive(true)
end
end)
rewardItem:SetChildActive(7,isRewardList)
end)
libItem:SetChildActive(1,index==self.select_idx)
libItem:SetChildActive(2,index~=self.select_idx)
libItem:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onClickRewardLib(index)
end)
libItem:SetChildActive(3,index==self.select_idx)
end)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6)
end
end

function UISubAct_lunhuizhuanpanSelectWin:refreshPreviewReward(index,screenPos)
local select_idx=index
if select_idx<=0 then return end
local rewards=self.config.reward_preview_pro_pr[select_idx][1]
self.previewContent:setChildLayoutGroupCreateItems(#rewards,function(index)
local item=self.previewContent:getChildLayoutGroupGridItem(index-1)
local reward=rewards[index]
local itemid=reward[1]
local count=reward[2]
local pr=reward[3]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local graynum=0
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=graynum,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
itemsComponentHelper.onItemClickEx(...)
end)
item:SetChildText(1,FMT.fmt("{0}%",pr/100))
end)

local rootPosX=screenPos.x
local rootPosY=screenPos.y-50
self.rewardPreviewPanel:setChildUIScreenPos(Vector2.New(rootPosX,rootPosY))
end

function UISubAct_lunhuizhuanpanSelectWin:changeRewardLibRefresh()
if self.select_idx>0 then
local libItem=self.libContent:getChildLayoutGroupGridItem(self.select_idx-1)
libItem:SetChildActive(1,false)
libItem:SetChildActive(2,true)
libItem:SetChildActive(3,false)
end
self.select_idx=self.actData.select_idx
local libItem=self.libContent:getChildLayoutGroupGridItem(self.select_idx-1)
libItem:SetChildActive(1,true)
libItem:SetChildActive(2,false)
libItem:SetChildActive(3,true)
self:closeSelf()
end

function UISubAct_lunhuizhuanpanSelectWin:onClickRewardLib(index)
if self.select_idx~=index then
call_activitiesHandle_func("activitiesHandle_lunhuizhuanpan","reqChangeRewardLib",self.activityId,self.subId,index)
end
end

function UISubAct_lunhuizhuanpanSelectWin:onPreviewMask()
self.previewMask:setActive(false)
end