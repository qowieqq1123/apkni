







def_class("UISubAct_zongmendabi_headreward_win",UIWindowBase)









function UISubAct_zongmendabi_headreward_win:bindComponents()

self.headReward1Grid=UIObject.get(self,0)
self.headReward2Grid=UIObject.get(self,1)
self.headReward3Grid=UIObject.get(self,2)



end


function UISubAct_zongmendabi_headreward_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.headReward1Grid);self.headReward1Grid=nil;
_UIObject_release(self.headReward2Grid);self.headReward2Grid=nil;
_UIObject_release(self.headReward3Grid);self.headReward3Grid=nil;
end
















local _this


function UISubAct_zongmendabi_headreward_win:onLoaded(...)
_this=self
self:bindComponents()
end


function UISubAct_zongmendabi_headreward_win:__delete()
_this=nil
self:unbindComponents()
end


function UISubAct_zongmendabi_headreward_win:onHide()

end




function UISubAct_zongmendabi_headreward_win:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

self:refreshReward(1)
self:refreshReward(2)
self:refreshReward(3)
end

function UISubAct_zongmendabi_headreward_win:refreshReward(idx)
local rewards=self.sub_actInfo:getHeadReward(idx)
local rewardGrid
local bgicon
local effectid
if idx==3 then
rewardGrid=self.headReward3Grid
bgicon='image_zongmendabijlui_3'
effectid=10211
elseif idx==2 then
rewardGrid=self.headReward2Grid
bgicon='image_zongmendabijlui_2'
effectid=10212
else
rewardGrid=self.headReward1Grid
bgicon='image_zongmendabijlui_1'
effectid=10213
end
rewardGrid:setChildLayoutGroupCreateItems(#rewards)
local grids=rewardGrid:getChildLayoutGroupGridList()
for i=1,#rewards do
local reward=rewards[i]
local item=grids[i-1]
local itemid=reward.itemid
local itemnum=reward.itemcount
local showCountBG=false
if itemnum>1 then
showCountBG=true
end
item:SetChildActive(1,showCountBG)
if showCountBG then
item:SetChildText(2,tostring(itemnum))
end
local showSign=itemsConfig.isFabao(itemid)
item:SetChildActive(4,showSign)
local iconName=itemsModel.getIconName(reward)
item:SetChildCSImageIcon(0,iconName,true)
item:SetChildCSImageSprite(3,globalABLookup.zonmengdabi_baoming,bgicon)
item:SetChildButtonClick(-1,function()
if _this==nil then return end
_this:onClickItem(idx,i)
end)
item:SetChildShowEffect(5,effectid,true)
end
end


function UISubAct_zongmendabi_headreward_win:onClickItem(idx,idx_)
local rewards=self.sub_actInfo:getHeadReward(idx)
local reward=rewards[idx_]
local itemguid=reward.itemguid
local itemid=reward.itemid
local watch=watchModel.getItem(itemguid)
if watch==nil then
watchModel.setItem(reward)
end
tipsManager.showTips({itemid=itemid,itemguid=itemguid,move=TIPS_MOVE_POS.eRight})
end