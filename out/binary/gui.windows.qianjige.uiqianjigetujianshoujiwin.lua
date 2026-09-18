







def_class("UIQianJiGeTuJianShouJiWin",UIWindowBase)









function UIQianJiGeTuJianShouJiWin:bindComponents()

self.ListPanel=UIObject.get(self,0)


self.sprite_button_qjgjnxx_1=0
self.sprite_button_qjgjnxx_2=1
self.sprite_button_qjgjnxx_3=2

end


function UIQianJiGeTuJianShouJiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ListPanel);self.ListPanel=nil;
end



















function UIQianJiGeTuJianShouJiWin:onLoaded(...)
self:bindComponents()
end


function UIQianJiGeTuJianShouJiWin:__delete()
self:unbindComponents()
end




function UIQianJiGeTuJianShouJiWin:onShow(argtable,afterOnloaded)
local tabId=argtable.tab
self.tabId=tabId
self.config=mysteryWeekActivityModel:getTuJianShouJiConfigByTagId(tabId)or{}

self:refreshList()
end

function UIQianJiGeTuJianShouJiWin:refreshList()
local sjList=mysteryWeekActivityModel:getsjId()or{}
local sjId=sjList[self.tabId]or 0
local activedLen=mysteryWeekActivityModel:getActivedTuJianTagLen(self.tabId)
local config=self.config

local list=table.deepCopy(config)
table.sort(list,function(a,b)
local sortA=a.sjId
local sortB=b.sjId
if a.sjId<=sjId then
sortA=sortA+10000
end
if b.sjId<=sjId then
sortB=sortB+10000
end
return sortA<sortB
end)

self.ListPanel:setChildScrollViewCreateGrids(#config,1)
local grids=self.ListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local grid=grids[i-1]
local cfg=list[i]
local num=cfg.num



grid:SetChildText(0,FMT.fmt("激活{0}个法则({1}/{2})",num,activedLen,num))

grid:SetChildActive(3,activedLen>=num and cfg.sjId>sjId)

grid:SetChildButtonClick(3,function()
mysteryWeekActivityController:send_4_77(self.tabId)
end)
grid:SetChildActive(4,cfg.sjId<=sjId)
local baseRewards
if cfg.itemList then
baseRewards=cfg.itemList
else
local dropId=cfg.dropId
local showItems=cfgHelper.get2(cfg_awardconfig_get,dropId,'showItems')
baseRewards=showItems
end

grid:SetChildScrollViewCreateGrids(2,#baseRewards,#baseRewards)
local grids=grid:GetChildScrollViewItemWidgets(2)
for ii=1,#baseRewards do
local widget=grids[ii-1]
local reward=baseRewards[ii]
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)


widget:SetChildPropData(2,prop)
widget:SetBaseItemClickEvent(2,function(...)
self:onClickRewardItem(...)
end)

end
end
end


function UIQianJiGeTuJianShouJiWin:onHide()

end
function UIQianJiGeTuJianShouJiWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end


