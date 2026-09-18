







def_class("UIXJFMReward_TargetWin",UIWindowBase)









function UIXJFMReward_TargetWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.list=UIObject.get(self,1)
self.tips=UIText.get(self,2)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXJFMReward_TargetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.list);self.list=nil;
_UIObject_release(self.tips);self.tips=nil;
end















local _this=nil
local _itemCmp={
rankNo=0,
rewardView=1,
rewardList=2,
recved=3,
notRecv=4,
recvBtn=5,
}
local targetState={
eRecv=1,
eRecved=2,
eNotRecv=3,
}



function UIXJFMReward_TargetWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXJFMReward_TargetWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXJFMReward_TargetWin:onShow(argtable,afterOnloaded)
self:updateView()
self.tips:setText(FMT.fmt("累计伤害：{0}",mathHelper.formatNumber(XianJieFuMoModel:getTotaldamage(),false)))
end


function UIXJFMReward_TargetWin:onHide()

end




function UIXJFMReward_TargetWin:onCloseBtn()
self:closeSelf()
end

function UIXJFMReward_TargetWin:updateView()
local infos=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"target_reward")
if infos then
self.list:setChildLayoutGroupCreateItems(#infos,function(index)
local item=self.list:getChildLayoutGroupGridItem(index-1)
local data=infos[index]
local damage=data[1]
local rewards=data[2]
item:SetChildText(_itemCmp.rankNo,FMT.fmt("累计造成{0}伤害",mathHelper.formatNumber(damage,false)))
local rewardCnt=#rewards
item:SetChildScrollRectEnable(_itemCmp.rewardView,rewardCnt>10)
item:SetChildLayoutGroupCreateItems(_itemCmp.rewardList,rewardCnt,function(index)
local itemReward=item:GetChildLayoutGroupGridItem(_itemCmp.rewardList,index-1)
local rewardData=rewards[index]
local rewardId=rewardData[1]
local rewardNum=rewardData[2]
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemReward:SetChildPropData(0,prop)
itemReward:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end)
local state=self:getTargetState(index,damage)
item:SetChildActive(_itemCmp.notRecv,state==targetState.eNotRecv)
item:SetChildActive(_itemCmp.recvBtn,state==targetState.eRecv)
item:SetChildActive(_itemCmp.recved,state==targetState.eRecved)
if state==targetState.eRecv then
self.MaxRecvIndex=index
end
if state==targetState.eRecv then
local func=function()
XianJieFuMoController.req_248_104(self.MaxRecvIndex or 0)
end
item:SetChildButtonClick(_itemCmp.recvBtn,func,true)
end
end)
else

end
end

function UIXJFMReward_TargetWin:getTargetState(index,damage)
local recvIndex=XianJieFuMoModel:getRecvIdx()
local curdamage=XianJieFuMoModel:getTotaldamage()
if recvIndex>=index then
return targetState.eRecved
end
return curdamage>=damage and targetState.eRecv or targetState.eNotRecv
end
