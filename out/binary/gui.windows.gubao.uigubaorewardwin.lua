







def_class("UIGuBaoRewardWin",UIWindowBase)









function UIGuBaoRewardWin:bindComponents()

self.menuScroller=UIObject.get(self,0)
self.ScrollView=UILoopListView.new(self,1)

self.ScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIGuBaoRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.menuScroller);self.menuScroller=nil;
self.ScrollView:deleteSelf();self.ScrollView=nil;
end
















local menuCmpIndex=
{
selectBg=0,
reddot=1,
name=2,
}


function UIGuBaoRewardWin:onLoaded(...)
self:bindComponents()
end


function UIGuBaoRewardWin:__delete()
self:unbindComponents()
end


function UIGuBaoRewardWin:onHide()

end




function UIGuBaoRewardWin:onShow(argtable,afterOnloaded)
self.page=1
if afterOnloaded then
self:initMenu()
end
self:refreshView()
end


function UIGuBaoRewardWin:initMenu()
self.menuScroller:setChildScrollViewInit(0.5,false,function(...)self:onClickMenu(...)end)
self.menuList=cfg_gubaoaimrewardconfig()
self.menuScroller:setChildScrollViewCreateGrids(#self.menuList,1)
local grids=self.menuScroller:getChildScrollViewItemWidgets()
for i,v in ipairs(self.menuList)do
local slot=grids[i-1]
slot:SetChildText(menuCmpIndex.name,v.name)
slot:SetChildActive(menuCmpIndex.selectBg,i==self.page)
self:refreshMenuItemEx(slot,i)
end
end

function UIGuBaoRewardWin:onClickMenu(chickNum,index)
if self.page==index+1 then
return
end

local grids=self.menuScroller:getChildScrollViewItemWidgets()

local newSlot=grids[index]
if newSlot then
newSlot:SetChildActive(menuCmpIndex.selectBg,true)
end

local oldSlot=grids[self.page-1]
if oldSlot then
oldSlot:SetChildActive(menuCmpIndex.selectBg,false)
end
self.page=index+1

self:refreshView()
end

function UIGuBaoRewardWin:refreshMenuItem(index)
local slot=self.menuScroller:getChildScrollViewItemWidget(index-1)
self:refreshMenuItemEx(slot,index)
end

function UIGuBaoRewardWin:refreshMenuItemEx(slot,index)
local isreddot=gubaoModel:checkCollectReddot(index)
slot:SetChildActive(menuCmpIndex.reddot,isreddot)
end

function UIGuBaoRewardWin:getDataIndexByID(childID)
for i,data in ipairs(self.datalist)do
local cfg=data.cfg
if cfg.id==childID then
return i
end
end
return nil
end

function UIGuBaoRewardWin:getDataList()
self.datalist={}
local page=self.page
local menucfg=self.menuList[page]
self.descFmt=menucfg.desc
local getter=gubaoModel:getCollectChildGetter(menucfg)
local list=getter()
for i,cfg in pairsBySortKey(list)do
local data={}
data.cfg=cfg
local isfinish=gubaoModel:checkRewarFinish(page,cfg.id)
local flag,cur,max=gubaoModel:getCollectProgressEx(page,cfg.point)
data.hasReward=flag and not isfinish
local state=gubaoModel:getCollectChildState(page,cfg.id,cfg.point)
local weight=state*1000+(100-cfg.id)
data.weight=weight
table.insert(self.datalist,data)
end
table.sort(self.datalist,function(a,b)
return a.weight>b.weight
end)
end

function UIGuBaoRewardWin:refreshView()
self:getDataList()

local createCount=#self.datalist
local createList={}
for i=1,createCount do createList[#createList+1]=i end
self.ScrollView:initData('gubaoRewardItem',createList)
end

function UIGuBaoRewardWin:onFreshAction(i,grid)
local data=self.datalist[i]
local cfg=data.cfg

local goodlist=cfg.rewards
if grid then
local goodgrid=grid:GetChildCommonLayoutGroupWidgetList(1)
for i=1,4 do
local godddata=goodlist[i]
local gooditem=goodgrid[i-1]
local show=godddata~=nil
gooditem:SetChildActive(1,show)
if show then
local itemID=godddata[1]
local itemnum=godddata[2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemID,itemcount=itemcount,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
gooditem:SetChildPropData(0,prop)
gooditem:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(...)end)
end
end

self:refreshItem(grid,i)
end
end

function UIGuBaoRewardWin:onStartAction()

end
function UIGuBaoRewardWin:refreshItem(item,idx)
local data=self.datalist[idx]
local cfg=data.cfg
local isfinish=gubaoModel:checkRewarFinish(self.page,cfg.id)

local flag,cur,max=gubaoModel:getCollectProgressEx(self.page,cfg.point)
if cur>max then cur=max end
local title_str=FMT.fmt(self.descFmt,cur,max)
item:SetChildText(0,title_str)

local showBtn=data.hasReward
item:SetChildActive(2,showBtn)
item:SetChildButtonClick(2,function()
self:onReward(idx)
end)

item:SetChildActive(5,showBtn)

local showFinishSign=flag and isfinish
item:SetChildActive(3,showFinishSign)

local showLockSing=not flag
item:SetChildActive(4,showLockSing)
end

function UIGuBaoRewardWin:onGoodItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end
end

function UIGuBaoRewardWin:onReward(idx)
if bagHelper.checkBagFull(BAG_TYPE.eItemBag)then
return
end
local rewardlist={}
for i,data in ipairs(self.datalist)do
if data.hasReward then
table.insert(rewardlist,data.cfg.id)
end
end
if#rewardlist>0 then
gubaoController:reqRewardList(self.page,rewardlist)
end
end

function UIGuBaoRewardWin:rec_reward(collectType)
if self.page~=collectType then return end

self:refreshView()
self:refreshMenuItem(self.page)
end