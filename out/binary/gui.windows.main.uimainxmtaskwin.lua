







def_class("UIMainXMTaskWin",UIWindowBase)









function UIMainXMTaskWin:bindComponents()

self.previewitem_1=UIObject.get(self,0)
self.previewitem_2=UIObject.get(self,1)
self.previewitem_3=UIObject.get(self,2)
self.previewitem_4=UIObject.get(self,3)
self.reddot=UIObject.get(self,4)
self.progressBar=UIProgressBarAni.get(self,5)
self.progressVal=UIText.get(self,6)
self.btnWatch=UIButton.get(self,7)
self.title=UIText.get(self,8)
self.gongxunRoot=UIObject.get(self,9)
self.previewRoot=UIObject.get(self,10)
self.root=UIObject.get(self,11)
self.root2=UIObject.get(self,12)
self.kfscrollView=UIObject.get(self,13)

self.btnWatch:setButtonClick(function()self:onBtnWatch()end)
self.previewitem={
self.previewitem_1,
self.previewitem_2,
self.previewitem_3,
self.previewitem_4,
}



end


function UIMainXMTaskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.previewitem_1);self.previewitem_1=nil;
_UIObject_release(self.previewitem_2);self.previewitem_2=nil;
_UIObject_release(self.previewitem_3);self.previewitem_3=nil;
_UIObject_release(self.previewitem_4);self.previewitem_4=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressVal);self.progressVal=nil;
_UIObject_release(self.btnWatch);self.btnWatch=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.gongxunRoot);self.gongxunRoot=nil;
_UIObject_release(self.previewRoot);self.previewRoot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.root2);self.root2=nil;
_UIObject_release(self.kfscrollView);self.kfscrollView=nil;
self.previewitem=nil;
end

















local cmpIndex=
{
text=0,
icon=1,
progressBar=2,
progressText=3,
name_2=4,
}
local _this


function UIMainXMTaskWin:onLoaded(...)
self:bindComponents()
self.rootPos=self.winlua:GetChildAnchoredPosition(self.root:getID())
self:addNotify(notifyConfig.onNewDay5am,function(...)self:freshInfo()end)
self:addNotify(notifyConfig.onLimitActivityPreview,function(...)self:onfreshPreview(...)end)
self.previewTimer={}
self.slist={}
end

function UIMainXMTaskWin:__delete()
self:unbindComponents()
end

function UIMainXMTaskWin:onShow(argtable,afterOnloaded)
self:freshSimple(true)
self:freshInfo()
self:initListhb()
self:refreshhb()
end

function UIMainXMTaskWin:onHide()

end





function UIMainXMTaskWin:onBtnWatch()
local data=zongmenModel:findBuildingDataByID(mapIdType.xianmeng,SLG_SYSTEM_TYPE.eXianXunBang)
if data then
isometricMapSystem:openBuildingWin(data)
end
end

function UIMainXMTaskWin:onfreshPreview(sceneType,mapId)
if sceneType==eSceneType.eZongmen and mapId==mapIdType.xianmeng then
self:freshPreview()
end
end

function UIMainXMTaskWin:freshSimple(isInit)







local isSimple=simpleModeControl:getLeftSimple()==leftSimpleState.hide
if isSimple then
simpleModeControl:setLeftXMSimple(leftXMSimpleState.hide)
else
simpleModeControl:setLeftXMSimple(leftXMSimpleState.info)
end
self:changeRoot()
end

function UIMainXMTaskWin:freshInfo()
self:freshGxInfo()
self:freshPreview()
end

function UIMainXMTaskWin:freshGxInfo()
local hasReddot=xianmengModel:getGXBRewardReddot()
local cnt,maxcnt=xianmengModel:getGVBRewardCount()
local str=not hasReddot and cnt>=maxcnt and
FMT.cfmt(FONT_COLOR.eGreenColor,'{0}/{1}',cnt,maxcnt)or
FMT.fmt('{0}/{1}',cnt,maxcnt)
self.winlua:SetProgressBarAniWithThreeParams(self.progressBar:getID(),cnt,maxcnt,0)
self.progressVal:setText(str)
self.reddot:setActive(hasReddot)
end

function UIMainXMTaskWin:freshGXReddot()
self.reddot:setActive(xianmengModel:getGXBRewardReddot())
end

function UIMainXMTaskWin:freshPreview()
local list=limitActivityPreviewControl:getDataList()
for i,v in ipairs(self.previewitem)do
local activityId=list[i]
local has=activityId~=nil
v:setActive(has)
if has then
local widget=v:getWidgetBase()
self:fillPreviewItem(widget,i,activityId)
end
end
end

function UIMainXMTaskWin:fillPreviewItem(widget,index,activityId)
local activityCfg=limitActivityPreviewControl:getActivityCfg(activityId)
local iconName=iconHelper.getLimitActivityPreviewIcon(activityCfg.xmpreviewicon or 1)
widget:SetChildCSImageSprite(0,globalABLookup.mainwin,iconName)
widget:SetChildText(1,activityCfg.name)
widget:SetChildText(2,activityCfg.xmpreviewdesc)
widget:SetChildButtonClick(5,function()
limitActivitiesController:jump(activityId)
end)
self:startItemTimer(widget,index,activityId)
end

function UIMainXMTaskWin:startItemTimer(widget,index,activityId)
if self.previewTimer[index]then
self:stopTimerByID(self.previewTimer[index])
end
local func=function()
local lefttime=limitActivitiesModel:getActStartLeftTime(activityId)
if lefttime and lefttime>0 then
local timeStr=timeHelper.format_time_stamp12(lefttime)
widget:SetChildText(3,FMT.fmt('{0}后开启',timeStr))
else
local ret,day=limitActivitiesModel:checkDayCondition(activityId)
if day and day>=0 then
widget:SetChildText(3,FMT.fmt('{0}天后可参加',day))
else
widget:SetChildText(3,'')
end
end
end
self.previewTimer[index]=self:setTimer(1,0,func)
func()
end


function UIMainXMTaskWin:changeRoot()
local xmstate=simpleModeControl:getLeftXMSimple()
if xmstate==leftXMSimpleState.hide then
self.winlua:SetChildDOAnchorPosX(self.root:getID(),-1300,0.3)
self.winlua:SetChildDOAnchorPosX(self.root2:getID(),-1300,0.3)
elseif xmstate==leftXMSimpleState.info then
self.winlua:SetChildDOAnchorPosX(self.root:getID(),0,0.3)
self.winlua:SetChildDOAnchorPosX(self.root2:getID(),-1300,0.3)
elseif xmstate==leftXMSimpleState.kufang then
self.winlua:SetChildDOAnchorPosX(self.root:getID(),-1300,0.3)
self.winlua:SetChildDOAnchorPosX(self.root2:getID(),0,0.3)
end
end

function UIMainXMTaskWin:initListhb()
self.slist=cfg_xianmengjuanxianbaseconfig_get(1).moneylist or{}
local len=#self.slist
if len>0 then
self.kfscrollView:setChildScrollViewCreateGrids(len,1)
end
end

function UIMainXMTaskWin:refreshhb()
local len=#self.slist
if len>0 then
local grids=self.kfscrollView:getChildScrollViewItemWidgets()
local depotarry=cfgHelper.get2(cfg_guildbaseconfig_get,1,'depot')
for i=1,grids.Count do
local item=grids[i-1]
local moneyType=self.slist[i]
local val=moneyModel.getMoney(moneyType)
local iconname=iconHelper.getIconName(moneyType)
local moneyName=moneyModel.getMoneyName(moneyType)
local max=100000000
if depotarry and depotarry[moneyType]then
max=depotarry[moneyType]
end
local proText=val<max and val or'满库'
item:SetChildCSImageIcon(cmpIndex.icon,iconname,true)
item:SetChildText(cmpIndex.text,moneyName)
item:SetProgressBarAniWithThreeParams(cmpIndex.progressBar,val,max,0)
item:SetChildText(cmpIndex.progressText,val)
end
end
end