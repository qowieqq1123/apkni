







def_class("UIServerTransferHistroyWin",UIWindowBase)









function UIServerTransferHistroyWin:bindComponents()

self.arrivalActorList=UIObject.get(self,0)
self.arrivalEmpty=UIObject.get(self,1)
self.cancelButton=UIButton.get(self,2)
self.leaveActorList=UIObject.get(self,3)
self.leaveEmpty=UIObject.get(self,4)
self.leftArrowBtn=UIButton.get(self,5)
self.npcModel=UIObject.get(self,6)
self.rightArrowBtn=UIButton.get(self,7)
self.root=UIObject.get(self,8)
self.showPanel_1=UIObject.get(self,9)
self.showPanel_2=UIObject.get(self,10)
self.showPanel_3=UIObject.get(self,11)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.leftArrowBtn:setButtonClick(function()self:onLeftArrowBtn()end)

self.rightArrowBtn:setButtonClick(function()self:onRightArrowBtn()end)
self.showPanel={
self.showPanel_1,
self.showPanel_2,
self.showPanel_3,
}



end


function UIServerTransferHistroyWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrivalActorList);self.arrivalActorList=nil;
_UIObject_release(self.arrivalEmpty);self.arrivalEmpty=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.leaveActorList);self.leaveActorList=nil;
_UIObject_release(self.leaveEmpty);self.leaveEmpty=nil;
_UIObject_release(self.leftArrowBtn);self.leftArrowBtn=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.rightArrowBtn);self.rightArrowBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.showPanel_1);self.showPanel_1=nil;
_UIObject_release(self.showPanel_2);self.showPanel_2=nil;
_UIObject_release(self.showPanel_3);self.showPanel_3=nil;
self.showPanel=nil;
end


















local showPanelPage=1
local _itemCmp={
bgImg=0,
headIcon=1,
name=2,
fight=3,
gradeIcon=4,
detailBtn=5,
serverName=6,
}
local panelAnimation={
[1]={[2]=eAnimationID.trans_paint_leave,[3]=eAnimationID.stand3},
[2]={[1]=eAnimationID.stand,[3]=eAnimationID.trans_leave_arrive,},
[3]={[1]=eAnimationID.stand,[2]=eAnimationID.trans_arrive_leave,},
}

function UIServerTransferHistroyWin:onLoaded(...)
self:bindComponents()
self.requestCrossNameCallBack=function()
if self and not self.isClose then
self:CrossNameCallBack()
end
end
loginRequestUpdate:registerRequest(REQUEST_TYPE.eRequestCross,self.requestCrossNameCallBack)
end


function UIServerTransferHistroyWin:__delete()
self:unbindComponents()
loginRequestUpdate:unregisterRequest(REQUEST_TYPE.eRequestCross,self.requestCrossNameCallBack)
end

function UIServerTransferHistroyWin:CrossNameCallBack()
if self.leaveList then
for index=1,#self.leaveList do
local item=self.leaveActorList:getChildLayoutGroupGridItem(index-1)
if item then
local actorData=self.leaveList[index]
item:SetChildText(_itemCmp.serverName,loginModel:getCrossZoneName(actorData.cross_id))
end
end
end
end




function UIServerTransferHistroyWin:onShow(argtable,afterOnloaded)
local list=ServerTransferModel:getTransferServerHistroyList()or defaultT
self.arrivalList={}
self.leaveList={}
for i,v in ipairs(list)do
if v.log_type==1 then
table.insert(self.arrivalList,v)
elseif v.log_type==2 then
table.insert(self.leaveList,v)
end
end

local commonSetItemData=function(actorData,item)
local fightnum=tonumber(tostring(actorData.fight_val))
playerController:setHeadIcon(item,_itemCmp.headIcon,{iconInfo=actorData.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
item:SetChildText(_itemCmp.name,actorData.name)
item:SetChildText(_itemCmp.fight,string.format('巅峰实力：%s',mathHelper.formatNumber3(fightnum)))
item:SetChildCSImageSprite(_itemCmp.gradeIcon,globalABLookup.globa4,ServerTransferModel:getZongMenGradeIcon(actorData.zm_pj))
end

self.arrivalEmpty:setActive(#self.arrivalList<=0)
self.arrivalActorList:setChildLayoutGroupCreateItems(#self.arrivalList,function(index)
local item=self.arrivalActorList:getChildLayoutGroupGridItem(index-1)
local actorData=self.arrivalList[index]
commonSetItemData(actorData,item)
item:SetChildScale(_itemCmp.bgImg,index%2==0 and Vector3(-1,1,1)or Vector3(1,1,1))
item:SetChildButtonClick(_itemCmp.detailBtn,function()
otherPlayerController:openOtherPlayerInfoWin(actorData.actor_id,nil,nil,{serverid=actorData.cross_id})
end)
end)

self.leaveEmpty:setActive(#self.leaveList<=0)
self.leaveActorList:setChildLayoutGroupCreateItems(#self.leaveList,function(index)
local item=self.leaveActorList:getChildLayoutGroupGridItem(index-1)
local actorData=self.leaveList[index]
commonSetItemData(actorData,item)
item:SetChildText(_itemCmp.serverName,loginModel:getCrossZoneName(actorData.cross_id))
end)

showPanelPage=1
self:refreshShowPanel(true)

local curr_act_open_time=list[1].switch_server_time
userActorArraySetting.set(ACTOR_SETTING_TYPE.eServerTransfer,'transferServerHistroyStamp',curr_act_open_time)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eServerTransfer)
UIManager:invokeUIMethod('UIFuncStorageWin','refreshServerTransferHistroyBtn')
end

function UIServerTransferHistroyWin:refreshShowPanel(isInit)
for i,v in ipairs(self.showPanel)do
if not isInit then
v:setActive(i==showPanelPage)
end
v:setChildCanvasGroupDOFade(i==showPanelPage and 1 or 0,0.6)
v:setChildCanvasGroupRaycast(i==showPanelPage)
end
end


function UIServerTransferHistroyWin:onCancelButton()
UIFullServerTransferControl:closeUI(true,true)
end

function UIServerTransferHistroyWin:onLeftArrowBtn()
local oldPage=showPanelPage
if showPanelPage>1 then
showPanelPage=showPanelPage-1
else
showPanelPage=#self.showPanel
end
local anim=panelAnimation[oldPage][showPanelPage]
self.npcModel:setChildModelAnimationState(anim)
self:refreshShowPanel()
end

function UIServerTransferHistroyWin:onRightArrowBtn()
local oldPage=showPanelPage
if showPanelPage<#self.showPanel then
showPanelPage=showPanelPage+1
else
showPanelPage=1
end
local anim=panelAnimation[oldPage][showPanelPage]
self.npcModel:setChildModelAnimationState(anim)
self:refreshShowPanel()
end