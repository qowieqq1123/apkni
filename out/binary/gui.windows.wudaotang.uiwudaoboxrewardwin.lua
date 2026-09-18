







def_class("UIWuDaoBoxRewardWin",UIWindowBase)









function UIWuDaoBoxRewardWin:bindComponents()

self.pageCreater=UIObject.get(self,0)



end


function UIWuDaoBoxRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.pageCreater);self.pageCreater=nil;
end

















function UIWuDaoBoxRewardWin:onLoaded(...)
self:bindComponents()
end


function UIWuDaoBoxRewardWin:__delete()
self:unbindComponents()
end


function UIWuDaoBoxRewardWin:onHide()

end




function UIWuDaoBoxRewardWin:onShow(argtable,afterOnloaded)
self:updateView()
end

function UIWuDaoBoxRewardWin:updateView()
self.pagelist={1,2,3}
local pagenum=#self.pagelist
self.pageCreater:setChildLayoutGroupCreateItems(pagenum)
local grids=self.pageCreater:getChildLayoutGroupGridList()
for i=1,pagenum do
local item=grids[i-1]
self:refreshPageItem(item,i)
end
end

function UIWuDaoBoxRewardWin:refreshPageItem(item,pageidx)
local planid=self.pagelist[pageidx]
local cfg=cfgHelper.get1(cfg_wudaotangplanconfig_get,planid)

item:SetChildText(0,cfg.name)

item:SetChildCSImageIcon(1,wudaotangModel:getPlanIcon(planid),true)

local rewardlist=nil
local zmlv=zongmenModel:getLevel()or 1
for i,v in ipairs(cfg.showReward)do
if zmlv>=v[1]and zmlv<=v[2]then
rewardlist=v[3]
break
end
end
if rewardlist==nil then
rewardlist=cfg.showReward[1][3]
end
local childnum=#rewardlist
item:SetChildLayoutGroupCreateItems(2,childnum)
local childGrids=item:GetChildLayoutGroupGridList(2)
for i=1,childnum do
local childItem=childGrids[i-1]
self:refreshChildItem(childItem,rewardlist[i])
end
end

function UIWuDaoBoxRewardWin:refreshChildItem(childItem,data)
local itemID=data[1]
local num=data[2]
local str
local showCountBG=true
if num~=nil and num>1 then
str=tostring(num)
else
str=''
showCountBG=false
end
local conf={itemid=itemID,itemcount=str,showname=false,showCountBG=showCountBG,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
childItem:SetChildPropData(0,prop)
childItem:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(TIPS_MOVE_POS.eRight,...)end)
end

function UIWuDaoBoxRewardWin:onGoodItemClick(pos,itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid,move=pos})
end
end