







def_class("UIXJLittleWorldZhenWuBagWin",UIWindowBase)









function UIXJLittleWorldZhenWuBagWin:bindComponents()

self.activeButton=UIButton.get(self,0)
self.activeMaterials=UIObject.get(self,1)
self.activePanel=UIObject.get(self,2)
self.activeRed=UIObject.get(self,3)
self.amaterialsItem_1=UIBaseItem.get(self,4)
self.amaterialsItem_2=UIBaseItem.get(self,5)
self.amaterialsItem_3=UIBaseItem.get(self,6)
self.amaterialsItem_4=UIBaseItem.get(self,7)
self.amaterialsItem_5=UIBaseItem.get(self,8)
self.BagList=UIScrollViewSlow.get(self,9)
self.changeButton=UIButton.get(self,10)
self.closeBtn=UIButton.get(self,11)
self.costPanel=UIObject.get(self,12)
self.effectPanel=UIObject.get(self,13)
self.effectRoot=UIObject.get(self,14)
self.groupRoot=UIObject.get(self,15)
self.left=UIObject.get(self,16)
self.materials=UIObject.get(self,17)
self.materialsItem_1=UIBaseItem.get(self,18)
self.materialsItem_2=UIBaseItem.get(self,19)
self.materialsItem_3=UIBaseItem.get(self,20)
self.materialsItem_4=UIBaseItem.get(self,21)
self.materialsItem_5=UIBaseItem.get(self,22)
self.maxStar=UIText.get(self,23)
self.right=UIObject.get(self,24)
self.star=UIObject.get(self,25)
self.upButton=UIButton.get(self,26)
self.zwDesc=UIText.get(self,27)
self.zwIcon=UIImage.get(self,28)
self.zwName=UIText.get(self,29)

self.activeButton:setButtonClick(function()self:onActiveButton()end)

self.changeButton:setButtonClick(function()self:onChangeButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.upButton:setButtonClick(function()self:onUpButton()end)
self.amaterialsItem={
self.amaterialsItem_1,
self.amaterialsItem_2,
self.amaterialsItem_3,
self.amaterialsItem_4,
self.amaterialsItem_5,
}
self.materialsItem={
self.materialsItem_1,
self.materialsItem_2,
self.materialsItem_3,
self.materialsItem_4,
self.materialsItem_5,
}



end


function UIXJLittleWorldZhenWuBagWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.activeButton);self.activeButton=nil;
_UIObject_release(self.activeMaterials);self.activeMaterials=nil;
_UIObject_release(self.activePanel);self.activePanel=nil;
_UIObject_release(self.activeRed);self.activeRed=nil;
_UIObject_release(self.amaterialsItem_1);self.amaterialsItem_1=nil;
_UIObject_release(self.amaterialsItem_2);self.amaterialsItem_2=nil;
_UIObject_release(self.amaterialsItem_3);self.amaterialsItem_3=nil;
_UIObject_release(self.amaterialsItem_4);self.amaterialsItem_4=nil;
_UIObject_release(self.amaterialsItem_5);self.amaterialsItem_5=nil;
_UIObject_release(self.BagList);self.BagList=nil;
_UIObject_release(self.changeButton);self.changeButton=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.effectPanel);self.effectPanel=nil;
_UIObject_release(self.effectRoot);self.effectRoot=nil;
_UIObject_release(self.groupRoot);self.groupRoot=nil;
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.materials);self.materials=nil;
_UIObject_release(self.materialsItem_1);self.materialsItem_1=nil;
_UIObject_release(self.materialsItem_2);self.materialsItem_2=nil;
_UIObject_release(self.materialsItem_3);self.materialsItem_3=nil;
_UIObject_release(self.materialsItem_4);self.materialsItem_4=nil;
_UIObject_release(self.materialsItem_5);self.materialsItem_5=nil;
_UIObject_release(self.maxStar);self.maxStar=nil;
_UIObject_release(self.right);self.right=nil;
_UIObject_release(self.star);self.star=nil;
_UIObject_release(self.upButton);self.upButton=nil;
_UIObject_release(self.zwDesc);self.zwDesc=nil;
_UIObject_release(self.zwIcon);self.zwIcon=nil;
_UIObject_release(self.zwName);self.zwName=nil;
self.amaterialsItem=nil;
self.materialsItem=nil;
end


















local _colomn=2
local _creatGirdPrecent=100

function UIXJLittleWorldZhenWuBagWin:onLoaded(...)
self:bindComponents()

self.BagList:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)

end


function UIXJLittleWorldZhenWuBagWin:__delete()
self:unbindComponents()
end




function UIXJLittleWorldZhenWuBagWin:onShow(argtable,afterOnloaded)
local defaultGroup=1
if argtable then
defaultGroup=argtable.selectGroup or defaultGroup
end

self.left:setChildAnchoredPos(-512,0)
self.left:setChildDOAnchorPosX(0,0.5)

self.right:setChildAnchoredPos(512,-34.7)
self.right:setChildDOAnchorPosX(-7.3,0.5)


self:showWindow("UILittleWorldZhenWuSlotWin",argtable)

self.isWinShow=true
self:refreshBagTypePanel()

self:selectGroupItem(defaultGroup)
end

function UIXJLittleWorldZhenWuBagWin:onShowArgRecv(argtable)
local defaultGroup=1
if argtable then
defaultGroup=argtable.selectGroup or defaultGroup
end

self:selectGroupItem(defaultGroup)
end


function UIXJLittleWorldZhenWuBagWin:onHide()

end

function UIXJLittleWorldZhenWuBagWin:recvEquip()
self:refreshBagTypePanel()
self:refreshBagListPanel()
end

function UIXJLittleWorldZhenWuBagWin:refreshBagTypePanel()
local areaConfig=cfg_smallworldareaconfig()
self.groupRoot:setChildLayoutGroupCreateItems(#areaConfig)
local have=LittleWorldModel:isZhenWuCanEquip()
local grids=self.groupRoot:getChildLayoutGroupGridList()
for i=1,grids.Count do
local config=areaConfig[i]
local grid=grids[i-1]
grid:SetChildText(0,config.name)
grid:SetChildButtonClick(2,function()
self:selectGroupItem(i)
end)

LittleWorldController:doPunchRotation(self,grid,3,i,not LittleWorldModel:getZhenWuData(i)and have)
end
end

function UIXJLittleWorldZhenWuBagWin:selectGroupItem(i)
if i==self.groupIdx then return end
local grid=self.groupRoot:getChildLayoutGroupGridItem(i-1)
if grid then
grid:SetChildActive(1,true)
end
if self.groupIdx then
local grid=self.groupRoot:getChildLayoutGroupGridItem(self.groupIdx-1)
if grid then
grid:SetChildActive(1,false)
end
end
self.groupIdx=i

self:refreshBagListPanel(true)

UIManager:callWindowFunc("UIPlanent","moveToSlot",i)
end



function UIXJLittleWorldZhenWuBagWin:refreshBagListPanel(resetSelectItem)
local bagIdList=LittleWorldModel:getZhenWuSlotBag(self.groupIdx)

self.itemsList=bagIdList
local chlen=#bagIdList

local tNum=chlen

local row=math.ceil(tNum/_colomn)+7
tNum=(row+7)*_colomn
local row=math.ceil(tNum/_colomn)

if resetSelectItem then
self.selectItemIdx=1
for i,v in ipairs(self.itemsList)do
if LittleWorldModel:isZhenWuEquiped(v)then
self.selectItemIdx=i
break
end
end
end

if not self.isSetZero then
self.BagList:freshSlowGrids(tNum,row,_colomn,self.isSetZero)
self.isSetZero=true
else
self.BagList:freshAllItems()
end

self:refreshInfoPanel()
end

function UIXJLittleWorldZhenWuBagWin:bindGrid(index,item)
local zwId=self.itemsList[index]
local isTemp=zwId==nil
if not isTemp then

local zwConfig=cfgHelper.get(cfg_smallworldtownconfig_get,zwId)

local itemConfig=itemsConfig.getConfig(zwConfig.show_item)
local data=LittleWorldModel:getZhenWuData(zwId)
local star=data or 0

local starCfg=cfg_smallworldtownstarconfig_get(zwId)
local showStar=starCfg[1]~=nil

local isEquiped=LittleWorldModel:isZhenWuEquiped(zwId)

local porp=itemsComponentHelper.getCommonFillData({itemid=itemConfig.id},{showCountBG=false,showcount=false,showname=true,nomalname=true})
porp[PropIndex(DataPropKey.eWidgetIcon,3)]=LittleWorldModel.get_zw_big_icon(zwConfig.show_icon_l)
porp[PropIndex(DataPropKey.eWidgetText,7)]=zwConfig.show_name
item:SetChildActive(-1,true)
item:SetChildActive(0,true)
item:SetChildPropData(0,porp)

item:SetBaseItemClickEvent(0,function(itemid,idx,itemguid,attach)
local oldIdx=self.selectItemIdx
self.selectItemIdx=index
self.BagList:freshSlowItem(oldIdx-1)
self.BagList:freshSlowItem(index-1)
self:refreshInfoPanel()
end)

item:SetChildActive(2,isEquiped~=nil)
item:SetChildActive(3,showStar)
item:SetChildStarNumber(3,star)
item:SetChildActive(5,self.selectItemIdx==index)

item:SetChildActive(7,LittleWorldModel:isZhenWuCanActive(zwId))

item:SetChildGray(0,data==nil)
else
item:SetChildActive(-1,false)




end
end

function UIXJLittleWorldZhenWuBagWin:refreshInfoPanel()
local zwId=self.itemsList[self.selectItemIdx]
local zwConfig=cfgHelper.get(cfg_smallworldtownconfig_get,zwId)



local data=LittleWorldModel:getZhenWuData(zwId)
local star=data or 0

self.zwIcon:setImageIcon(LittleWorldModel.get_zw_big_icon(zwConfig.show_icon_l),true)
self.zwName:setText(zwConfig.show_name)
self.zwDesc:setText(zwConfig.desc)

local starCfg=cfg_smallworldtownstarconfig_get(zwId)
local nextStar=starCfg~=nil and starCfg[star+1]~=nil
local showStar=starCfg[1]~=nil
self.star:setActive(showStar)
if showStar then
self.winid:SetChildGroundStarNum(self.star:getID(),5)
self.winid:SetChildStarNumber(self.star:getID(),star)
self.effectRoot:setChildAnchoredPos(7,0.8)
else
self.effectRoot:setChildAnchoredPos(7,20)
end


local effectConfig=LittleWorldModel.getZWEffectConfig(zwId,star)
if effectConfig then

local list={}
for i,v in ipairs(effectConfig)do
local effType=v[1]
local effArgs=v[2]

for t,v2 in pairs(effArgs)do
local desc=LittleWorldModel:getZhenWuEffectDesc(effType,t,v2)
table.insert(list,desc)
end
end

self.effectPanel:setChildLayoutGroupCreateItems(#list)
local grids=self.effectPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
grid:SetChildText(1,list[i])
end
else
self.effectPanel:setChildLayoutGroupCreateItems(0)
end
local equipedSlot=LittleWorldModel:isZhenWuEquiped(zwId)

if data~=nil then
self.activePanel:setActive(false)
self.changeButton:setActive(equipedSlot~=self.groupIdx)
if nextStar then
self.costPanel:setActive(true)
self.maxStar:setActive(false)
self.upButton:setActive(true)
local costConfig=starCfg~=nil and starCfg[star].up_costs or{}
for i,item in ipairs(self.materialsItem)do
local reward=costConfig[i]
if reward then
local matItemId=reward[1]
local needCount=reward[2]
local showStage=not moneyConfig.isMoney(matItemId)
local have=itemsModel.getCount(matItemId)
local color=have>=needCount and FONT_TIPS_COLOR_VAL[FONT_COLOR.eGreenColor]or FONT_TIPS_COLOR_VAL[FONT_COLOR.eRedColor]
local countStr
if moneyConfig.isMoney(matItemId)then
countStr=FMT.fmt("<color={1}>{0}</color>",mathHelper.formatNumber(needCount),color)
else
countStr=FMT.fmt("<color={2}>{0}/{1}</color>",mathHelper.formatNumber(have),mathHelper.formatNumber(needCount),color)
end
local conf={itemid=matItemId,itemcount=countStr,showCountBG=true,showStage=showStage,range=reward.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:setActive(true)
item:setChildPropData(prop)
local _onClickMaterialItem=function(...)
itemsComponentHelper.onItemClick(...)
end
item:setBaseItemChildID(matItemId)
item:setBaseItemClickEvent(_onClickMaterialItem)
else
item:setActive(false)
end
end
else
self.costPanel:setActive(false)
self.upButton:setActive(false)
self.maxStar:setActive(showStar)
end
else
self.changeButton:setActive(false)
self.upButton:setActive(false)
self.activePanel:setActive(true)
self.costPanel:setActive(false)
self.maxStar:setActive(false)
self.activeRed:setActive(LittleWorldModel:isZhenWuCanActive(zwId))
local costConfig=zwConfig.lv_costs
for i,item in ipairs(self.amaterialsItem)do
local reward=costConfig[i]
if reward then
local matItemId=reward[1]
local needCount=reward[2]
local showStage=not moneyConfig.isMoney(matItemId)
local have=itemsModel.getCount(matItemId)
local color=have>=needCount and FONT_TIPS_COLOR_VAL[FONT_COLOR.eGreenColor]or FONT_TIPS_COLOR_VAL[FONT_COLOR.eRedColor]
local countStr
if moneyConfig.isMoney(matItemId)then
countStr=FMT.fmt("<color={1}>{0}</color>",mathHelper.formatNumber(needCount),color)
else
countStr=FMT.fmt("<color={2}>{0}/{1}</color>",mathHelper.formatNumber(have),mathHelper.formatNumber(needCount),color)
end
local conf={itemid=matItemId,itemcount=countStr,showCountBG=true,showStage=showStage,range=reward.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:setActive(true)
item:setChildPropData(prop)
local _onClickMaterialItem=function(...)
itemsComponentHelper.onItemClick(...)
end
item:setBaseItemChildID(matItemId)
item:setBaseItemClickEvent(_onClickMaterialItem)
else
item:setActive(false)
end
end
end


end

function UIXJLittleWorldZhenWuBagWin:checkEquip(town_id)
local slotZw=LittleWorldModel:getZhenWuIdxSlot(self.groupIdx)
if not slotZw then
LittleWorldController.req_37_73(self.groupIdx,town_id)
else
self:refreshBagListPanel()
end
end


function UIXJLittleWorldZhenWuBagWin:onActiveButton()
local zwId=self.itemsList[self.selectItemIdx]
local zwConfig=cfgHelper.get(cfg_smallworldtownconfig_get,zwId)
local costConfig=zwConfig.lv_costs
for i,reward in ipairs(costConfig)do
local have=UIDanYaoModel:getHaveItemCount(reward[1])
if have<reward[2]then
gainControl:showCommonGainWin_item(reward[1],{needCount=reward[2]})
return
end
end

LittleWorldController.req_37_76(zwId)
end




function UIXJLittleWorldZhenWuBagWin:onChangeButton()
local zwId=self.itemsList[self.selectItemIdx]
LittleWorldController.req_37_73(self.groupIdx,zwId)
end



function UIXJLittleWorldZhenWuBagWin:onUpButton()
local zwId=self.itemsList[self.selectItemIdx]
local data=LittleWorldModel:getZhenWuData(zwId)
local star=data or 0
local starCfg=cfg_smallworldtownstarconfig_get(zwId)
local costConfig=starCfg[star].up_costs
for i,reward in ipairs(costConfig)do
local have=UIDanYaoModel:getHaveItemCount(reward[1])
if have<reward[2]then
gainControl:showCommonGainWin_item(reward[1],{needCount=reward[2]})
return
end
end

LittleWorldController.req_37_74(zwId)
end


function UIXJLittleWorldZhenWuBagWin:onCloseBtn()
if self.isClosing then
return
end
self.isClosing=true
self.left:setChildDOAnchorPosX(-512,0.5)
self.right:setChildDOAnchorPosX(512,0.5,function()
self.isClosing=nil
self:closeSelf()
end)
end