







def_class("UIXMEpuipChongZhiWin",UIWindowBase)









function UIXMEpuipChongZhiWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.title=UIText.get(self,1)
self.rewardPanel=UIObject.get(self,2)
self.chongzhiBtn=UIButton.get(self,3)
self.cost=UIText.get(self,4)
self.costicon=UIObject.get(self,5)
self.frame=UIButton.get(self,6)
self.introductiontxt=UIText.get(self,7)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIXMEpuipChongZhiWin")end)

self.chongzhiBtn:setButtonClick(function()self:onChongzhiBtn()end)

self.frame:setButtonClick(function()self:onFrame()end)



end


function UIXMEpuipChongZhiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.chongzhiBtn);self.chongzhiBtn=nil;
_UIObject_release(self.cost);self.cost=nil;
_UIObject_release(self.costicon);self.costicon=nil;
_UIObject_release(self.frame);self.frame=nil;
_UIObject_release(self.introductiontxt);self.introductiontxt=nil;
end



















local _this=nil

function UIXMEpuipChongZhiWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXMEpuipChongZhiWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXMEpuipChongZhiWin:onShow(argtable,afterOnloaded)
self.item=argtable.item
local equip=self.item
local equipitemid=equip.itemid
local itemConfig=itemsConfig.getConfig(equipitemid)
local str=FMT.fmt("重置后，装备<color=#ca631d>{0}</color>的凝练次数将变更为<color=#ca631d>初始状态</color>。装备凝练时消耗的道具材料<color=#549327>100%</color>返还。<color=#ca631d>（仙气/魔气、玄铁无法返还）</color>",itemConfig.name)
self.introductiontxt:setText(str)
self.cost:setActive(false)

local costlist={}
local ninglian_star=equipsModel.getNingLianStar(equip)
for k=1,ninglian_star do
local cost,effect_id,percent=equipsModel.getEquipXMNingLianData(equip.itemid,k)

table.insert(costlist,cost[1])
end
local _num=0
local _itemid=0
for k,v in ipairs(costlist)do
_itemid=v[1]
_num=_num+v[2]
end
local rewardlist={{_itemid,_num}}



local rnum=#rewardlist
self.rewardPanel:setChildLayoutGroupCreateItems(rnum)
local grids=self.rewardPanel:getChildLayoutGroupGridList()
local rewards=rewardlist
for i=1,rnum do
local rwItem=grids[i-1]
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
rwItem:SetChildPropData(0,prop)
rwItem:SetChildActive(0,true)
rwItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end

function UIXMEpuipChongZhiWin:onHide()

end

function UIXMEpuipChongZhiWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,})
end


function UIXMEpuipChongZhiWin:onChongzhiBtn()
if _this==nil then
return
end
local equip=self.item
equipsProtocolControl:send_2_163(equip.itemguid)
self:onFrame()
end


function UIXMEpuipChongZhiWin:onFrame()
UIManager:closeWindow("UIXMEpuipChongZhiWin")
end
