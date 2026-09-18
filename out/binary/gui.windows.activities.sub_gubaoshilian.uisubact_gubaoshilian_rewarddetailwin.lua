







def_class("UISubAct_GuBaoShiLian_RewardDetailWin",UIWindowBase)









function UISubAct_GuBaoShiLian_RewardDetailWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.rewardView=UILoopListView.new(self,2)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.rewardView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UISubAct_GuBaoShiLian_RewardDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
self.rewardView:deleteSelf();self.rewardView=nil;
end















local _this=nil
local _itemCmp={
levelTx=0,
rewardList=1,
}



function UISubAct_GuBaoShiLian_RewardDetailWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_GuBaoShiLian_RewardDetailWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_GuBaoShiLian_RewardDetailWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

local createList={}
for i,v in ipairs(self.config.layer_list)do
createList[#createList+1]=i
end
self.rewardView:initData('rewardItem',createList)
end


function UISubAct_GuBaoShiLian_RewardDetailWin:onHide()

end




function UISubAct_GuBaoShiLian_RewardDetailWin:onBackground()
self:onCloseBtn()
end


function UISubAct_GuBaoShiLian_RewardDetailWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UISubAct_GuBaoShiLian_RewardDetailWin:onStartAction()

end

function UISubAct_GuBaoShiLian_RewardDetailWin:onFreshAction(i,widget,data)
local config=cfgHelper.get1(cfg_gubaoshilianlayerconfig_get,self.config.layer_list[i])
local dropId=config.drop_id
local dropCfg=cfgHelper.get(cfg_awardconfig_get,dropId)
local levelStr=FMT.fmt("第{0}层",i)
local rewardDatas=dropCfg.detailItems or{}
widget:SetChildText(_itemCmp.levelTx,levelStr)
widget:SetChildLayoutGroupCreateItems(_itemCmp.rewardList,#rewardDatas,function(index)
local item=widget:GetChildLayoutGroupGridItem(_itemCmp.rewardList,index-1)
local itemData=rewardDatas[index]
local itemId=itemData[1]
local itemNum=itemData[2]
local itemRange=itemData.range
local showCountBG=itemNum>1 or itemData.range~=nil
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,range=itemRange}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
item:SetChildPropData(0,itemProp)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
item:SetChildActive(1,itemNum==-1 and itemRange==nil)
end)
end
