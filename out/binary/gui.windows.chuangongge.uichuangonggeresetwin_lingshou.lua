







def_class("UIChuanGongGeResetWin_LingShou",UIWindowBase)









function UIChuanGongGeResetWin_LingShou:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.consumeIcon=UIObject.get(self,1)
self.consumeNum=UIText.get(self,2)
self.counttip=UIText.get(self,3)
self.desc=UIText.get(self,4)
self.empty=UIObject.get(self,5)
self.resetBtn=UIButton.get(self,6)
self.rewardList=UIObject.get(self,7)
self.rewardRoot=UIObject.get(self,8)
self.Root=UIObject.get(self,9)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.resetBtn:setButtonClick(function()self:onResetBtn()end)



end


function UIChuanGongGeResetWin_LingShou:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.consumeIcon);self.consumeIcon=nil;
_UIObject_release(self.consumeNum);self.consumeNum=nil;
_UIObject_release(self.counttip);self.counttip=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.empty);self.empty=nil;
_UIObject_release(self.resetBtn);self.resetBtn=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardRoot);self.rewardRoot=nil;
_UIObject_release(self.Root);self.Root=nil;
end



















function UIChuanGongGeResetWin_LingShou:onLoaded(...)
self:bindComponents()

local _recv_19_105=function()
if not self or self.isClose then return end
self:onCloseBtn()
end
self:addProNotify(19,105,_recv_19_105)
end


function UIChuanGongGeResetWin_LingShou:__delete()
self:unbindComponents()
end




function UIChuanGongGeResetWin_LingShou:onShow(argtable,afterOnloaded)
self.lsGuidSrc=argtable.lsGuidSrc
self.lsGuidDest=argtable.lsGuidDest
self.costMoney=argtable.costMoney

local lsDataSrc=lingshouModel:getLingShouData2(self.lsGuidSrc)
local lsDataDest=lingshouModel:getLingShouData2(self.lsGuidDest)

local desc=FMT.fmt("将<color='#ca631d'>{0}</color>的境界传功给<color='#ca631d'>{1}</color>，同时<color='#ca631d'>{2}</color>的血脉等级、主动技能等级、潜力值都将重置到初始状态，无法被<color='#ca631d'>{3}</color>继承",lsDataSrc.name,lsDataDest.name,lsDataSrc.name,lsDataDest.name)
self.desc:setText(desc)

local moneyIconName=iconHelper.getMoneyIconName(self.costMoney[1])
self.consumeIcon:setIcon(moneyIconName,false)
self.consumeNum:setText(string.format("X%d",self.costMoney[2]))

local resetItemList=lingshouModel:calculateResetReturnItemList_ChuanGong(self.lsGuidSrc)

local len=#resetItemList
self.empty:setActive(len<=0)

self.rewardList:setChildLayoutGroupCreateItems(len,function(index)
local item=self.rewardList:getChildLayoutGroupGridItem(index-1)
local costData=resetItemList[index]
local isSpe=costData[1]<0
item:SetChildActive(0,not isSpe)
item:SetChildActive(1,isSpe)
if isSpe then
self:refreshCostItem_Spe(item,costData,lsDataSrc)
else
local itemId=costData[1]
local itemNum=costData[2]




local countStr=itemNum<1 and''or mathHelper.formatNumber(itemNum)
local showCountBG=itemNum>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(itemId)
end)
end
end)
end

function UIChuanGongGeResetWin_LingShou:refreshCostItem_Spe(item,costData,lsDataSrc)
local subItem=item:GetChildWidgetBase(1)
item:SetChildActive(0,false)
item:SetChildActive(1,true)

local needCount=costData[2]
subItem:SetChildQulaity(3,-costData[1])
subItem:SetChildActive(0,true)
subItem:SetChildText(2,needCount)
end


function UIChuanGongGeResetWin_LingShou:onHide()

end





function UIChuanGongGeResetWin_LingShou:onCloseBtn()
self:closeSelf()
end



function UIChuanGongGeResetWin_LingShou:onResetBtn()
itemsModel:useItem(self.costMoney[1],self.costMoney[2],function()
lingshouController.req_19_105(self.lsGuidSrc,self.lsGuidDest)
end,WARNING_TYPE.eWarning,eMoneyType.mtXianYu)
end

