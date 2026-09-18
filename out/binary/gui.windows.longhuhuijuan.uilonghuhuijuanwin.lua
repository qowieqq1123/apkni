







def_class("UILongHuHuiJuanWin",UIWindowBase)









function UILongHuHuiJuanWin:bindComponents()

self.RewardGot=UIObject.get(self,0)
self.UIBaseItem=UIBaseItem.get(self,1)
self.progressbar=UIProgress.get(self,2)
self.RewardRed=UIObject.get(self,3)
self.previewMask=UIButton.get(self,4)
self.previewBtn=UIButton.get(self,5)
self.time=UIText.get(self,6)
self.eventViewPanel=UIObject.get(self,7)
self.model=UIObject.get(self,8)
self.rightButton=UIButton.get(self,9)
self.leftButton=UIButton.get(self,10)
self.creator=UIGameobjectClone.new(self,11)
self.mapRoot=UIObject.get(self,12)
self.eventView=UIObject.get(self,13)
self.LayoutReward=UIObject.get(self,14)
self.zhenji=UIImage.get(self,15)
self.tIcon=UIImage.get(self,16)

self.previewMask:setButtonClick(function()self:onPreviewMask()end)

self.previewBtn:setButtonClick(function()self:onPreviewBtn()end)

self.rightButton:setButtonClick(function()self:onRightButton()end)

self.leftButton:setButtonClick(function()self:onLeftButton()end)



end


function UILongHuHuiJuanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.RewardGot);self.RewardGot=nil;
_UIObject_release(self.UIBaseItem);self.UIBaseItem=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.RewardRed);self.RewardRed=nil;
_UIObject_release(self.previewMask);self.previewMask=nil;
_UIObject_release(self.previewBtn);self.previewBtn=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.eventViewPanel);self.eventViewPanel=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.rightButton);self.rightButton=nil;
_UIObject_release(self.leftButton);self.leftButton=nil;
self.creator:deleteSelf();self.creator=nil;
_UIObject_release(self.mapRoot);self.mapRoot=nil;
_UIObject_release(self.eventView);self.eventView=nil;
_UIObject_release(self.LayoutReward);self.LayoutReward=nil;
_UIObject_release(self.zhenji);self.zhenji=nil;
_UIObject_release(self.tIcon);self.tIcon=nil;
end



















function UILongHuHuiJuanWin:onLoaded(...)
self:bindComponents()
self.tweeners={}
self.tweenerVal={}
self.zhenJiEventList={}
end


function UILongHuHuiJuanWin:__delete()
self:unbindComponents()
for k,v in pairs(self.tweeners)do
v:Kill()
end
end




function UILongHuHuiJuanWin:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eLongHuHuiJuan
self.subid=argtable.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)

self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)

self.pageIndex=self.info:getMapIndex()
self:refresh(self.pageIndex)


end


function UILongHuHuiJuanWin:onHide()

end

function UILongHuHuiJuanWin:refresh(maxMap)
self:refreshMap(maxMap)

self:setProgress()

self:refreshEvent()
end

function UILongHuHuiJuanWin:refreshMap(maxMap)
local areaList=self.config.plot
local num=#areaList
self.eventViewPanel:setChildScrollViewCreateGrids(num,num)
if maxMap then
self.eventViewPanel:setChildScrollViewSelectItem(maxMap-1,false,false,false)
end
local today=self.info:getStart2NowDay()
local grids=self.eventViewPanel:getChildScrollViewItemWidgets()
for i=1,num do
local item=grids[i-1]

self:refreshPlot(i,today,item)
end
end

function UILongHuHuiJuanWin:refreshPlot(idx,today,item,anim)
local areaList=self.config.plot
local cfg=areaList[idx]
if not cfg then
return
end
if not today then
today=self.info:getStart2NowDay()
end
if not item then
item=self.eventViewPanel:getChildScrollViewItemWidget(idx-1)
end

local maxid=self.info:getPlotMaxid()

local isOpen,openType=self.info:checkPlotOpenCfg(idx,cfg,today)

if isOpen then

local buffid=self.info:getBuff(idx)
item:SetChildActive(12,buffid~=nil)
if buffid then
local guildstateconfig=cfg_guildstateconfig_get(buffid)
local iconname=iconHelper.getzmStateIcon(guildstateconfig.icon)
item:SetChildCSImageIcon(0,iconname,true)
item:SetChildButtonClick(0,function()
local widget=item:GetChildWidgetBase(0)
self:showBuffTipsWin(widget,buffid)
end)
end
local act=self.info:getPlotAct(idx)
item:SetChildActive(13,act~=nil)
if act then
local icon=iconHelper.getzmStateIcon(act[5])
item:SetChildCSImageIcon(5,icon,true)
item:SetChildButtonClick(5,function()
activitiesController:jump(self.actid,act[1],act[2])
end)
end
local zhenJi=self.info:getPlotZhenJi(idx)
item:SetChildActive(14,zhenJi~=nil)
if zhenJi then

local zjId=zhenJi[2]
local zhenJiEventCfg=cfgHelper.get(cfg_longhuhuijuaneventconfig_get,zjId)
local icon=iconHelper.getzmStateIcon(zhenJiEventCfg.icon)
item:SetChildCSImageIcon(7,icon,true)
item:SetChildButtonClick(7,function()
self:showWindow("UIZhenJiFixWin",{act_id=self.actid,sub_act_id=self.subid,zhenjiId=zjId,plotId=idx})
end)
if not self.zhenJiEventList[idx]then
self.zhenJiEventList[idx]=self:addZhenJiEvent(zjId,idx,zhenJi[3])
end
item:SetChildActive(10,self.info:checkZhenJiFix(zjId)==true)
end

item:SetChildCanvasGroupAlpha(11,1)
if anim then
item:SetChildActive(1,true)
item:SetChildActive(6,true)
item:SetChildCanvasGroupDOFade(11,0,1,function()
item:SetChildActive(1,false)
end)
item:SetDissolveFactor(1,0)
self.tweenerVal["dissove"..idx]=0
self.tweeners["dissove"..idx]=_DOTweenProxy.DoValueTo(
function()
return self.tweenerVal["dissove"..idx]or 0
end,
function(val)
self.tweenerVal["dissove"..idx]=val
item:SetDissolveFactor(1,val)
end,
1,1)
else
item:SetChildActive(1,false)
item:SetChildActive(6,true)
end
else
item:SetChildActive(1,true)
item:SetChildActive(6,false)
if idx==maxid+1 then
if openType==1 then
item:SetChildActive(3,true)
item:SetChildActive(2,false)
item:SetChildActive(4,false)
self:doPunchRotation(item,9,idx,false)
elseif openType==2 then
item:SetChildActive(2,true)
item:SetChildActive(3,false)
item:SetChildActive(4,false)
self:doPunchRotation(item,9,idx,false)
elseif openType==3 then
item:SetChildActive(4,true)
item:SetChildActive(2,false)
item:SetChildActive(3,false)
item:SetChildButtonClick(4,function()
activitiesHandle_longhuhuijuan.req_plot_unlock(self.actid,self.subid,idx)
end)

self:doPunchRotation(item,9,idx,true)
end
else
item:SetChildActive(4,false)
item:SetChildActive(2,false)
item:SetChildActive(3,false)
self:doPunchRotation(item,9,idx,false)
end
end

if anim then
self:refreshEvent()
end

end

function UILongHuHuiJuanWin:refreshPlotZhenJi(idx,item)
if not item then
item=self.eventViewPanel:getChildScrollViewItemWidget(idx-1)
end
local zhenJi=self.info:getPlotZhenJi(idx)
item:SetChildActive(7,zhenJi~=nil)
if zhenJi then
local zjId=zhenJi[2]
item:SetChildActive(10,self.info:checkZhenJiFix(zjId)==true)
end

end

function UILongHuHuiJuanWin:showBuffTipsWin(posItem,buffid)
local args=
{
buffid=buffid,
posWidget=posItem,
}


self:showWindow("UILongHuHuiJuanTips",args)
end

function UILongHuHuiJuanWin:setProgress()
local progress=self.info:getProgress()
local max=self.config.active_reward[1]
self.progressbar:setProgress(progress,max)
self.progressbar:setChildProgressText(FMT.fmt("绘画进度：{0}%",math.floor(progress/max*100)))
local active_reward=self.config.active_reward[2]
local item={itemid=active_reward[1]}
local got=self.info:isGuBaoGot()
local get=progress>=max and not got

local config={itemcount=active_reward[2]==1 and''or active_reward[2],showname=false,gray=got and 1 or 0}
local porp=itemsComponentHelper.getCommonFillData(item,config)
self.RewardGot:setActive(got)
self.UIBaseItem:setChildPropData(porp)
self.RewardRed:setActive(get)
self:doPunchRotation(self.winid,self.RewardRed:getID(),100,get)
if get then

self.UIBaseItem:setBaseItemClickEvent(function()
activitiesHandle_longhuhuijuan.req_gubao_get(self.actid,self.subid)
end)
else
self.UIBaseItem:setBaseItemClickEvent(itemsComponentHelper.onItemClick)
end
end

function UILongHuHuiJuanWin:refreshEvent()
local main_event,idx,idx2=self.info:getMainEvent()
local max=self.info:getPlotMaxid()
if main_event then
local posId=main_event[2]
local posCfg=cfgHelper.get(cfg_longhuhuijuanposconfig_get,posId)
if max>=posCfg.plot then
if not self.mainEventItem then
self.mainEventItem=self:addMainEvent(idx,idx2,main_event)
else
self.creator:recycleItemById(self.mainEventItem)
self.mainEventItem=self:addMainEvent(idx,idx2,main_event)
end
else
if self.mainEventItem then
self.creator:recycleItemById(self.mainEventItem)
end
end
else
if self.mainEventItem then
self.creator:recycleItemById(self.mainEventItem)
end
end

local lineEvents=self.info:getLineEvents()
self:clearLineEvent()
for i,v in ipairs(lineEvents)do
local posId=v[3][2]
local posCfg=cfgHelper.get(cfg_longhuhuijuanposconfig_get,posId)
if max>=posCfg.plot then
local guid=self:addLineEvent(v[1],v[2],v[3])
self.lineEventItem[guid]=1
end
end

end

function UILongHuHuiJuanWin:addMainEvent(lineIdx,lineIdx2,mainEventCfg)
return self.creator:createObject('lhMapEventItem',self.mapRoot:getID(),0,{act_id=self.actid,sub_act_id=self.subid,eventType=1,lineIdx=lineIdx,lineIdx2=lineIdx2,mainEventCfg=mainEventCfg})
end

function UILongHuHuiJuanWin:addLineEvent(lineIdx,lineIdx2,lineEventCfg)
return self.creator:createObject('lhMapEventItem',self.mapRoot:getID(),0,{act_id=self.actid,sub_act_id=self.subid,eventType=2,lineIdx=lineIdx,lineIdx2=lineIdx2,lineEventCfg=lineEventCfg})
end

function UILongHuHuiJuanWin:clearLineEvent()
if self.lineEventItem then
for guid,v in pairs(self.lineEventItem)do
self.creator:recycleItemById(guid)
end
end
self.lineEventItem={}
end

function UILongHuHuiJuanWin:addZhenJiEvent(eventId,plotId,pos)
return self.creator:createObject('lhMapEventItem',self.mapRoot:getID(),0,{act_id=self.actid,sub_act_id=self.subid,eventType=3,zjEvent=eventId,plotId=plotId,zjPos=pos})
end








function UILongHuHuiJuanWin:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
if isReddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
if not reddotIndex then
reddotIndex=#self.reddotTweenerList+1
end

if self.reddotTweenerList[reddotIndex]==nil then
widget:SetChildRotation(componentIndex,0,0,0)
local tweener=widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
self.reddotTweenerList[reddotIndex].widget=widget
self.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
widget:SetChildRotation(componentIndex,0,0,0)
return nil
end
end
end


function UILongHuHuiJuanWin:endAllReddotPunchRotation()
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return
end
for i,v in pairs(self.reddotTweenerList)do
if v~=nil then
v.tweener:Complete()
v.tweener:Kill()
local widget=v.widget
local componentIndex=v.componentIndex
widget:SetChildRotation(componentIndex,0,0,0)

self.reddotTweenerList[i]=nil
end
end
end





function UILongHuHuiJuanWin:onLeftButton()
self.eventViewPanel:setChildScrollViewSelectItem(0,true,false,false)
end



function UILongHuHuiJuanWin:onRightButton()
self.eventViewPanel:setChildScrollViewSelectItem(9,true,false,false)
end

function UILongHuHuiJuanWin:onPreviewBtn()
self.previewMask:setActive(true)
if not self.previewRewardInit then
self.previewRewardInit=true

local reward=self.config.show_reward
local len=#reward
self.LayoutReward:setChildLayoutGroupCreateItems(len)
local grids=self.LayoutReward:getChildLayoutGroupGridList()
for i=1,len do
local active_reward=reward[i]
local item={itemid=active_reward[1]}
local grid=grids[i-1]

local config={itemcount='',showname=false}
local porp=itemsComponentHelper.getCommonFillData(item,config)
grid:SetChildPropData(-1,porp)
grid:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClick)
end
end
end

function UILongHuHuiJuanWin:onPreviewMask()
self.previewMask:setActive(false)
end
