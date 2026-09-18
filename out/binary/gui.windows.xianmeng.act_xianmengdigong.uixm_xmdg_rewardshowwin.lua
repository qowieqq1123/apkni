







def_class("UIXM_XMDG_rewardShowWin",UIWindowBase)









function UIXM_XMDG_rewardShowWin:bindComponents()

self.root=UIObject.get(self,0)
self.descTxt=UIText.get(self,1)
self.rewardPanel=UIObject.get(self,2)



end


function UIXM_XMDG_rewardShowWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
end
















local _this=nil


function UIXM_XMDG_rewardShowWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_XMDG_rewardShowWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_XMDG_rewardShowWin:onHide()

end




function UIXM_XMDG_rewardShowWin:onShow(argtable,afterOnloaded)
local rewardid=argtable.rewardid
local posx=argtable.posx or 0
local posy=argtable.posy or 0
self.root:setLocalPos(posx,posy,0)
self.descTxt:setText(argtable.desc)

local rewards={}
local zmlv=zongmenModel:getLevel()
local list=zongmenControl:getRewardConfigData(rewardid,zmlv)
if list~=nil and#list>0 then
for i2,v2 in ipairs(list)do
local cfg=itemsConfig.getConfig(v2[1])
table.insert(rewards,{v2[1],v2[2],cfg.color})
end
end
local c=#rewards
if c>1 then
table.sort(rewards,function(a,b)
return a[3]>b[3]
end)
end
self.rewardPanel:setChildLayoutGroupCreateItems(c)
local grids=self.rewardPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
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
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)

local showSign=itemnum<0
item:SetChildActive(1,showSign)
end
end

function UIXM_XMDG_rewardShowWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end
