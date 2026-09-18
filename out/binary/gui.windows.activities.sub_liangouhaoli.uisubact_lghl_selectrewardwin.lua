







def_class("UISubAct_LGHL_SelectRewardWin",UIWindowBase)









function UISubAct_LGHL_SelectRewardWin:bindComponents()

self.backBtn=UIButton.get(self,0)
self.content=UIObject.get(self,1)
self.mbg=UIObject.get(self,2)
self.okBtn=UIButton.get(self,3)
self.rewardGridList=UIObject.get(self,4)

self.backBtn:setButtonClick(function()self:onBackBtn()end)

self.okBtn:setButtonClick(function()self:onOkBtn()end)



end


function UISubAct_LGHL_SelectRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backBtn);self.backBtn=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.okBtn);self.okBtn=nil;
_UIObject_release(self.rewardGridList);self.rewardGridList=nil;
end
















local _this




function UISubAct_LGHL_SelectRewardWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_LGHL_SelectRewardWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_LGHL_SelectRewardWin:onShow(argtable,afterOnloaded)
self.actId=argtable.act_id
self.subType=argtable.sub_act_type
self.subId=argtable.sub_act_id
self.aimIndex=argtable.aimIndex or 0
self.parentWin=argtable.parentWin
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.argtable=argtable

local serverOpenDay=timeHelper.getServerOpenDay()
local zmLevel=zongmenModel:getLevel()or 0
local len=#self.config.aim
self.rewardGridList:setChildLayoutGroupCreateItems(len,function(index)
local item=self.rewardGridList:getChildLayoutGroupGridItem(index-1)
local data=self.config.aim[index]
local isShow=serverOpenDay>=data[1]and zmLevel>=data[2]and(data[3]==0 or systemModel.isOpen(data[3]))
item:SetChildActive(-1,isShow)

item:SetChildActive(0,index==self.aimIndex)
local rewards=data[4]
item:SetChildLayoutGroupCreateItems(1,#rewards,function(idx)
local rewardItem=item:GetChildLayoutGroupGridItem(1,idx-1)
local rewardData=rewards[idx]
local showCountBG=rewardData[2]>1
local countStr=showCountBG and rewardData[2]or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(-1,prop)
rewardItem:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)

item:SetChildButtonClick(2,function()
if _this.aimIndex>0 then
local oldItem=_this.rewardGridList:getChildLayoutGroupGridItem(_this.aimIndex-1)
oldItem:SetChildActive(0,false)
end
item:SetChildActive(0,true)
_this.aimIndex=index
end)
end)

if afterOnloaded then
self.content:setChildCanvasGroupAlpha(0)

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(6346,1,nil,eAnimationID.enter)
self:delayDo(0.6,function()
if not _this then return end
return _this.content:setChildCanvasGroupDOFade(1,0.5)
end)
end
end


function UISubAct_LGHL_SelectRewardWin:onHide()

end





function UISubAct_LGHL_SelectRewardWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UISubAct_LGHL_SelectRewardWin:onOkBtn()
if self.aimIndex==0 then
UIManager.info("未选择大奖")
return
end
local handleName=activitiesController:getHandleName(self.subType)
call_activitiesHandle_func(handleName,'reqSelectAim',self.actId,self.subId,self.aimIndex)
self:onCloseBtn()
end

function UISubAct_LGHL_SelectRewardWin:onBackBtn()
self:onCloseBtn()
end

