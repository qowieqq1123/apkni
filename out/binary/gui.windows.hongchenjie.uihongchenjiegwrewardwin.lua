







def_class("UIHongChenJieGWRewardWin",UIWindowBase)









function UIHongChenJieGWRewardWin:bindComponents()

self.title=UIText.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.scrollerView=UIObject.get(self,2)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIHongChenJieGWRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.scrollerView);self.scrollerView=nil;
end















local item_index=
{
name=0,
paimingImg=1,
rewardbtn=2,
rewardtext=3,
gotflag=4,
itemList=5,
}



function UIHongChenJieGWRewardWin:onLoaded(...)
self:bindComponents()
self.scrollerView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIHongChenJieGWRewardWin:__delete()
self:unbindComponents()
end




function UIHongChenJieGWRewardWin:onShow(argtable,afterOnloaded)
self.id=argtable.id
self.data=hongChenJieModel:getGameHandle(self.id)
self.title:setText("感悟奖励")
self:refreshItems()
end


function UIHongChenJieGWRewardWin:onHide()

end

function UIHongChenJieGWRewardWin:refreshItems()
local moneyType=hongChenJieConfig.getBaseInfo(self.id,'money_type')
local moneyName=itemsModel.getName(moneyType)
local taskRewardDataList=self.data:getTaskRewardDataList()

self.scrollerView:setChildScrollViewCreateGrids(#taskRewardDataList,1)
local grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local itemData=taskRewardDataList[i]
local config=itemData.cfg
local nameStr=FMT.fmt('{0}达到{1}',moneyName,config[1])
item:SetChildText(item_index.name,nameStr)
local canReward=itemData.isCanReward
local isGot=itemData.rewardState
item:SetChildActive(item_index.rewardbtn,not isGot)
item:SetChildActive(item_index.gotflag,isGot)
local rewardStr=canReward and'领取奖励'or'未达成'
item:SetChildText(item_index.rewardtext,rewardStr)
local btnEnable=not isGot and canReward
local gray=not isGot and not canReward
item:SetChildActive(item_index.paimingImg,btnEnable)
item:SetChildButtonEnable(item_index.rewardbtn,btnEnable,gray)
item:SetChildButtonClick(item_index.rewardbtn,function(...)
self:onClickRewarBtn()
end)

local rewardList=config[2]

item:SetChildLayoutGroupCreateItems(item_index.itemList,#rewardList)
local grids=item:GetChildLayoutGroupGridList(item_index.itemList)
for j=1,#rewardList do
local widget=grids[j-1]
local reward=rewardList[j]
local itemid=reward[1]
local count=reward[2]
local conf={itemid=itemid,itemcount=count,showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickItem(...)
end)
end
end
end

function UIHongChenJieGWRewardWin:onClickRewarBtn(index)
hongChenJieController:reqReceiveTaskReward(self.id)
end

function UIHongChenJieGWRewardWin:onClickItem(itemid,index,guid,attach)

if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=guid})
end




function UIHongChenJieGWRewardWin:onCloseBtn()
UIFullHongChenJieControl:closeWindow("UIHongChenJieGWRewardWin")
end

