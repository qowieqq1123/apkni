







def_class("UIFangYingTingPlotSelectWin",UIWindowBase)







local abName="ui/windows/activities/sub_dahuaxiyouliandong/fangyingtingact_atlas_pak.ab"

function UIFangYingTingPlotSelectWin:bindComponents()

self.BagList=UILoopListView.new(self,0)
self.cancel=UIButton.get(self,1)
self.OKBtn=UIButton.get(self,2)

self.BagList:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.cancel:setButtonClick(function()self:onCancel()end)

self.OKBtn:setButtonClick(function()self:onOKBtn()end)



end


function UIFangYingTingPlotSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
self.BagList:deleteSelf();self.BagList=nil;
_UIObject_release(self.cancel);self.cancel=nil;
_UIObject_release(self.OKBtn);self.OKBtn=nil;
end
















local this
local stringF=string.format
local gridCmp=
{
icon=0,
title_name=1,
txt_progress=2,
completed=3,
progressBg=7,
lockIcon=8,
}

local openState=
{
completed=1,
inProgress=2,
notOpen=3,
}

local StateCfg=
{
[openState.completed]=
{
titleName="<color=#686868>%s</color>",
BgName="image_fangyingting_zt3",
},
[openState.inProgress]=
{
titleName="<color=#874112>%s</color>",
BgName="image_fangyingting_zt1",
},
[openState.notOpen]=
{
titleName="<color=#FF200B>%s</color>",
BgName="image_fangyingting_zt2",
},
}




function UIFangYingTingPlotSelectWin:onLoaded(...)
self:bindComponents()
this=self
end


function UIFangYingTingPlotSelectWin:__delete()
self:unbindComponents()
end




function UIFangYingTingPlotSelectWin:onShow(argtable,afterOnloaded)
self.actID=argtable.actID
self.subType=argtable.subType
self.subid=argtable.subid
self.selectWhichAct=argtable.selectWhichAct

self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)

self.BagList:bindSlowWidget(function(...)
self:bindGrid(...)
end)

self.today=self.info:getStart2NowDay()

self.eventList=self.sub_actcfg.eventList
self.titleList=self.sub_actcfg.titleList
self.titleList=self.sub_actcfg.titleList
self.iconList=self.sub_actcfg.iconList

self.BagList:initData('bagItem',self.eventList,#self.eventList+2)




self.BagList:jumpItem(self.selectWhichAct)
end


function UIFangYingTingPlotSelectWin:onHide()

end


function UIFangYingTingPlotSelectWin:bindGrid(index,grid)
if index==1 or index==#self.eventList+2 then
grid:SetChildActive(-1,false)
else
local selectWhichAct=index-1
local title=self.titleList[index-1]
grid:SetChildText(gridCmp.title_name,title)
local screenAllCompleted=self.info:checkScreenAllCompleted(selectWhichAct)

local CurScreenIsOpen=self.info:checkCurScreenIsOpen(selectWhichAct)
grid:SetChildActive(gridCmp.completed,screenAllCompleted)
local str=""
local cfg=StateCfg[openState.completed]
if screenAllCompleted then
str=stringF(cfg.titleName,"已完成")
else
if not CurScreenIsOpen then
cfg=StateCfg[openState.notOpen]
local Condition=self.sub_actcfg.openCDN[selectWhichAct]
str=stringF(cfg.titleName,stringF("活动第%s天开启",Condition))
if Condition==self.today+1 then
str=stringF(cfg.titleName,"明日开启")
else
local title=self.sub_actcfg.titleList[selectWhichAct-1]
str=stringF(cfg.titleName,stringF("完成第%s幕后解锁",selectWhichAct-1))
end

else
cfg=StateCfg[openState.inProgress]
str=stringF(cfg.titleName,"进行中")
end
end
grid:SetChildActive(gridCmp.lockIcon,not CurScreenIsOpen)
grid:SetChildText(gridCmp.txt_progress,str)
local iconNumber=self.iconList[selectWhichAct]
grid:SetChildIcon(gridCmp.icon,stringF("image_shijian_%s",iconNumber),false)
grid:SetChildCSImage(gridCmp.progressBg,abName,cfg.BgName,false)
end
end

function UIFangYingTingPlotSelectWin:onFreshAction(index,grid)
self:bindGrid(index,grid)
end

function UIFangYingTingPlotSelectWin:onStartAction()

end

function UIFangYingTingPlotSelectWin:onCloseClick()
self:closeSelf()
end



function UIFangYingTingPlotSelectWin:onCancel()
self:onCloseClick()
end


function UIFangYingTingPlotSelectWin:onOKBtn()
local index=self.BagList._loopListView2.CurSnapNearestItemIndex
self.myData.selectWhichAct=index+1

UIManager:callWindowFunc('UIDaHuaXiYouWin','PlotSelectChange')
self:onCloseClick()
end

function UIFangYingTingPlotSelectWin:scrollViewChange()
end


