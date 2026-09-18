







def_class("UIXM_TYSC_sellRewardWin",UIWindowBase)









function UIXM_TYSC_sellRewardWin:bindComponents()

self.rewardRoot=UIObject.get(self,0)
self.noItemTips=UIText.get(self,1)
self.goodsCreater=UIObject.get(self,2)



end


function UIXM_TYSC_sellRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rewardRoot);self.rewardRoot=nil;
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.goodsCreater);self.goodsCreater=nil;
end
















local _this


function UIXM_TYSC_sellRewardWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_TYSC_sellRewardWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_TYSC_sellRewardWin:onHide()

end




function UIXM_TYSC_sellRewardWin:onShow(argtable,afterOnloaded)
local rewardList={}
local temp=xianmengModel:getSellRewards_TYSC()
if#temp>0 then
for i,data in ipairs(temp)do
local itemid=data.param_1
local itemnum=data.param_2
local itemConfig=itemsConfig.getConfig(itemid)
table.insert(rewardList,{itemid,itemnum,itemConfig.color})
end
end
local num=#rewardList
if num>1 then
table.sort(rewardList,function(a,b)
return a[3]>b[3]
end)
end
local isshow=num>0
self.rewardRoot:setActive(isshow)
self.noItemTips:setActive(not isshow)
if isshow then
self.goodsCreater:setChildLayoutGroupCreateItems(num)
local grids=self.goodsCreater:getChildLayoutGroupGridList()
for i=1,num do
local item=grids[i-1]
local data=rewardList[i]
local itemid=data[1]
local itemnum=data[2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end
end

function UIXM_TYSC_sellRewardWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eRight})
end