







def_class("UIDouFaTaiRewardWin",UIWindowBase)









function UIDouFaTaiRewardWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.scrollerView=UIObject.get(self,1)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIDouFaTaiRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
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


function UIDouFaTaiRewardWin:onLoaded(...)
self:bindComponents()
self.scrollerView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIDouFaTaiRewardWin:__delete()
self:unbindComponents()
end




function UIDouFaTaiRewardWin:onShow(argtable,afterOnloaded)
self:refreshItems()
end


function UIDouFaTaiRewardWin:onHide()

end

function UIDouFaTaiRewardWin:refreshItems()
local data=douFaTaiModel:get_doufatai_data()
self.doufataiData=data
local allConfig=cfg_doufataivaluerewardconfig()
local rewardConfig=self:sortRewardList(allConfig)

self.scrollerView:setChildScrollViewCreateGrids(#rewardConfig,1)
local grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local config=rewardConfig[i]
local nameStr=FMT.fmt('问道值达到{0}分',config.weidao)
item:SetChildText(item_index.name,nameStr)
local canReward=data.wendao>=config.weidao
local isGot=douFaTaiModel:checkRewardIsGot(config.id,data.rewardFlag)
item:SetChildActive(item_index.rewardbtn,not isGot)
item:SetChildActive(item_index.gotflag,isGot)
local rewardStr=canReward and'领取奖励'or'未达成'
item:SetChildText(item_index.rewardtext,rewardStr)
local btnEnable=not isGot and canReward
local gray=not isGot and not canReward
item:SetChildActive(item_index.paimingImg,btnEnable)
item:SetChildButtonEnable(item_index.rewardbtn,btnEnable,gray)
item:SetChildButtonClick(item_index.rewardbtn,function(...)
self:onClickRewarBtn(config.id)
end)

local rewardList=config.rewards

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

function UIDouFaTaiRewardWin:sortRewardList(config)
local list={}
for i,v in ipairs(config)do
local isGot=douFaTaiModel:checkRewardIsGot(v.id,self.doufataiData.rewardFlag)
if isGot then
v.sortTag=v.id+1000000
else
v.sortTag=v.id
end
table.insert(list,v)
end
table.sort(list,function(a,b)return a.sortTag<b.sortTag end)
return list
end

function UIDouFaTaiRewardWin:onClickRewarBtn(index)
douFaTaiController:req_rank_reward()
end

function UIDouFaTaiRewardWin:onClickItem(itemid,index,guid,attach)

if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=guid})
end





function UIDouFaTaiRewardWin:onCloseBtn()
UIFullDouFaTaiControl:closeWindow(self.winlua.name)
end

