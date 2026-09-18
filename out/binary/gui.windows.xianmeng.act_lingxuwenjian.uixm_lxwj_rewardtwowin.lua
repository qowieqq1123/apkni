







def_class("UIXM_LXWJ_RewardTwoWin",UIWindowBase)









function UIXM_LXWJ_RewardTwoWin:bindComponents()

self.root=UIObject.get(self,0)
self.rankGridPanel=UIObject.get(self,1)



end


function UIXM_LXWJ_RewardTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rankGridPanel);self.rankGridPanel=nil;
end
















local _this=nil


function UIXM_LXWJ_RewardTwoWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_LXWJ_RewardTwoWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_LXWJ_RewardTwoWin:onHide()

end




function UIXM_LXWJ_RewardTwoWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self:refreshView()
end
end

function UIXM_LXWJ_RewardTwoWin:refreshView()
if self.myDatas==nil then
self.myDatas={}
local lp={}
local cfgs=cfg_lingxuwenjianlevelconfig()
for i,v in ipairs(cfgs)do
if lp[v.floor]==nil then
lp[v.floor]=true
table.insert(self.myDatas,v)
end
end
table.sort(self.myDatas,function(a,b)
return a.floor>b.floor
end)
end
local num=#self.myDatas
local func=function(i)
if _this==nil then return end
local item=_this.rankGridPanel:getChildLayoutGroupGridItem(i-1)
local cfg=_this.myDatas[i]

item:SetChildCSImageSprite(0,globalABLookup.lingxuwenjianicons,cfg.icon)
item:SetChildText(1,cfg.floorname)

local list1={}
list1[1]=cfg.rank[1]
_this:refreshItemRewards(item,2,list1)
local list2={}
list2[1]=cfg.rank[2]
_this:refreshItemRewards(item,3,list2)
local list3={}
list3[1]=cfg.rank[3]
_this:refreshItemRewards(item,4,list3)
end
self.rankGridPanel:setChildLayoutGroupCreateItems(num,func)
end

function UIXM_LXWJ_RewardTwoWin:refreshItemRewards(item,idx,rewards)
local c=#rewards
local showReward=c>0
item:SetChildActive(idx,showReward)
if showReward then
item:SetChildLayoutGroupCreateItems(idx,c)
local grids2=item:GetChildLayoutGroupGridList(idx)
for i=1,c do
local rewardItem=grids2[i-1]
local itemid=rewards[i][1]
local itemnum=rewards[i][2]
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
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end
end

function UIXM_LXWJ_RewardTwoWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end
