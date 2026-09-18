







def_class("UIMoGongZhengDuoAct_RewardWin",UIWindowBase)









function UIMoGongZhengDuoAct_RewardWin:bindComponents()

self.back=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.rankList=UILoopListView.new(self,2)
self.title=UIText.get(self,3)

self.back:setButtonClick(function()self:onBack()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.rankList:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIMoGongZhengDuoAct_RewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
self.rankList:deleteSelf();self.rankList=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UIMoGongZhengDuoAct_RewardWin:onLoaded(...)
self:bindComponents()
end


function UIMoGongZhengDuoAct_RewardWin:__delete()
self:unbindComponents()
end




function UIMoGongZhengDuoAct_RewardWin:onShow(argtable,afterOnloaded)
self:refreshReward()
end


function UIMoGongZhengDuoAct_RewardWin:onHide()

end

function UIMoGongZhengDuoAct_RewardWin:refreshReward()
local rewardList=cfgHelper.get(cfg_mogongzhengduobaseconfig_get,1,"rankRewards4")

self.rankList:initData("item",rewardList,#rewardList)
end

function UIMoGongZhengDuoAct_RewardWin:onFreshAction(index,widget,data)
local rangeMin=data[1]
local rangeMax=data[2]
widget:SetChildText(0,rangeMin==rangeMax and rangeMin or FMT.fmt("{0}-{1}",rangeMin,rangeMax))

local rewards=data[3]
widget:SetChildLayoutGroupCreateItems(1,#rewards)
local grids=widget:GetChildLayoutGroupGridList(1)
for i=1,#rewards do
local widget=grids[i-1]
local reward=rewards[i]
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)


widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)

end
end

function UIMoGongZhengDuoAct_RewardWin:onStartAction(index,widget)

end




function UIMoGongZhengDuoAct_RewardWin:onBack()
self:onCloseBtn()
end



function UIMoGongZhengDuoAct_RewardWin:onCloseBtn()
self:closeSelf()
end

