







def_class("UIXianGongInfluenceReputationWin",UIWindowBase)









function UIXianGongInfluenceReputationWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.descList=UIObject.get(self,1)
self.descView=UIObject.get(self,2)
self.scrollView=UIObject.get(self,3)
self.swList=UIObject.get(self,4)
self.swProgress=UIProgress.get(self,5)
self.swValue=UIText.get(self,6)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXianGongInfluenceReputationWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.descList);self.descList=nil;
_UIObject_release(self.descView);self.descView=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.swList);self.swList=nil;
_UIObject_release(self.swProgress);self.swProgress=nil;
_UIObject_release(self.swValue);self.swValue=nil;
end















local _this=nil
local _descLang="xianjieshili_shengwangtisheng_help_%d"
local _descMax=10
local _swItemCmp={
levelTx=0,
numBg=1,
numTx=2,
rewardView=3,
rewardList=4,
reddot=5,
}



function UIXianGongInfluenceReputationWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onXianGongNPCRelationChange,self.onXianGongNPCRelationChange)
self:addProNotify(37,109,self.on_37_109)
end


function UIXianGongInfluenceReputationWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianGongInfluenceReputationWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.faction=argtable.faction
self.config=cfgHelper.get1(cfg_xianjieforceconfig_get,self.faction)
self:refreshDescList()
self:refreshSWList()
if argtable.level then
self:jumpToItem(argtable.level)
end
end


function UIXianGongInfluenceReputationWin:onHide()

end




function UIXianGongInfluenceReputationWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UIXianGongInfluenceReputationWin:refreshDescList()
self.descDatas={}
for i=1,_descMax do
local str=cfgHelper.get1(cfg_lang_get,string.format(_descLang,i))
if str~=nil then
table.insert(self.descDatas,str)
end
end
self.descList:setChildLayoutGroupCreateItems(#self.descDatas,function(index)
local item=self.descList:getChildLayoutGroupGridItem(index-1)
local obj=item:GetChildGameObject(1)
local width=item:GetChildSizeDeltaX(1)
local str=comHelper.getCheckLayoutStr(obj,width,self.descDatas[index])
item:SetChildText(0,str)
item:ForceLayoutRect(0)
end)
self.winlua:ForceLayoutRect(self.descList:getID())

local height=self.descList:getChildSizeDeltaY()
self.descView:setChildScrollRectEnable(height>359)
end

function UIXianGongInfluenceReputationWin:refreshSWList()
local config=cfg_xianjiefeellevelconfig()
local flag=xjFactionNPCModel:getReputationFlag(self.faction)
local total,level,stepCur,stepMax=xjFactionNPCModel:getReputationValue(self.faction)
self.swList:setChildLayoutGroupCreateItems(#config,function(index)
local item=self.swList:getChildLayoutGroupGridItem(index-1)
local cfg=config[index]
local rewards=self.config.reward[index]
local hasReward=rewards~=nil and#rewards>0
item:SetChildText(_swItemCmp.levelTx,cfg.name)
item:SetChildText(_swItemCmp.numTx,cfg.feel_num)
item:SetChildActive(_swItemCmp.rewardView,hasReward)
if hasReward then
item:SetChildLayoutGroupCreateItems(_swItemCmp.rewardList,#rewards,function(_index)
local _item=item:GetChildLayoutGroupGridItem(_swItemCmp.rewardList,_index-1)
local itemData=rewards[_index]
local itemId=itemData[1]
local itemNum=itemData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local _conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local _prop=itemsComponentHelper.getCommonFillDataSmall(_conf)
_item:SetChildPropData(0,_prop)
_item:SetBaseItemClickEvent(0,function(id,idx,guid,attach)
self:onClickSWRewardItem(index,_index,id,idx,guid,attach)
end)
_item:SetChildActive(1,flag>=index)
end)
item:SetChildScrollRectEnable(_swItemCmp.rewardView,#rewards>=5)
item:SetChildButtonClick(_swItemCmp.rewardView,function()
self:onClickSWItem(index)
end)
item:SetChildActive(_swItemCmp.reddot,flag<index and level>=index)
end
end)
self.winlua:ForceLayoutRect(self.swList:getID())
if level>=#config then
self.swProgress:setProgressValue(10000,10000)
else
local stepProgress=10000/(#config-1)
local progressValue=stepProgress*(level-1)+stepProgress*(stepCur/stepMax)
self.swProgress:setProgressValue(math.floor(progressValue),10000)
end
self.swValue:setText(FMT.fmt("当前:{0}",math.floor(total)))
end

function UIXianGongInfluenceReputationWin:jumpToItem(index)
local viewHeight=self.scrollView:getChildSizeDeltaY()
local listHeight=self.swList:getChildSizeDeltaY()
local targetY=(39+69)*(index-1)
local y=Mathf.Clamp(targetY,0,listHeight-viewHeight)
self.swList:setChildAnchoredPos(0,y)
end

function UIXianGongInfluenceReputationWin:onClickSWItem(index)
local flag=xjFactionNPCModel:getReputationFlag(self.faction)
local total,level,stepCur,stepMax=xjFactionNPCModel:getReputationValue(self.faction)
if flag<index and level>=index then

xjFactionNPCController:send_37_109(self.faction)
end
end

function UIXianGongInfluenceReputationWin:onClickSWRewardItem(index,_index,id,idx,guid,attach)
local flag=xjFactionNPCModel:getReputationFlag(self.faction)
local total,level,stepCur,stepMax=xjFactionNPCModel:getReputationValue(self.faction)
if flag<index and level>=index then

xjFactionNPCController:send_37_109(self.faction)
else
itemsComponentHelper.onItemClickEx(id,idx,guid,attach)
end
end

function UIXianGongInfluenceReputationWin.onXianGongNPCRelationChange(npcId,npcLvChange,reputationLvChange)
local faction=xjFactionNPCModel:findFactionByNpc(npcId)
if faction==_this.faction then
local config=cfg_xianjiefeellevelconfig()
local total,level,stepCur,stepMax=xjFactionNPCModel:getReputationValue(faction)
_this.swProgress:setProgressValue(total,config[#config].feel_num)

if reputationLvChange then
local flag=xjFactionNPCModel:getReputationFlag(faction)
for index=1,level do
local item=_this.swList:getChildLayoutGroupGridItem(index-1)
local cfg=config[index]
item:SetChildActive(_swItemCmp.reddot,flag<index and level>=index)
end
end
end
end

function UIXianGongInfluenceReputationWin.on_37_109(result,faction)
if faction==_this.faction then
local config=cfg_xianjiefeellevelconfig()
local flag=xjFactionNPCModel:getReputationFlag(faction)
local total,level,stepCur,stepMax=xjFactionNPCModel:getReputationValue(faction)
for index=1,#config do
local item=_this.swList:getChildLayoutGroupGridItem(index-1)
local cfg=config[index]
local _items=item:GetChildLayoutGroupGridList(_swItemCmp.rewardList)
for _index=1,_items.Count do
local _item=_items[_index-1]
_item:SetChildActive(1,flag>=index)
end
item:SetChildActive(_swItemCmp.reddot,flag<index and level>=index)
end
end
end