







def_class("UIXianGuanSketchyLogWin",UIWindowBase)









function UIXianGuanSketchyLogWin:bindComponents()

self.bgSpine1=UIObject.get(self,0)
self.bgSpine2=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.logLoopView=UILoopListView.new(self,3)
self.lookDetailbtn=UIButton.get(self,4)
self.model=UIObject.get(self,5)
self.modelInfo=UIObject.get(self,6)
self.Root=UIObject.get(self,7)
self.speakBg=UIObject.get(self,8)
self.speakContent=UIText.get(self,9)
self.temp=UIObject.get(self,10)
self.uiRoot=UIObject.get(self,11)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.logLoopView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.lookDetailbtn:setButtonClick(function()self:onLookDetailbtn()end)



end


function UIXianGuanSketchyLogWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgSpine1);self.bgSpine1=nil;
_UIObject_release(self.bgSpine2);self.bgSpine2=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
self.logLoopView:deleteSelf();self.logLoopView=nil;
_UIObject_release(self.lookDetailbtn);self.lookDetailbtn=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.modelInfo);self.modelInfo=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.speakBg);self.speakBg=nil;
_UIObject_release(self.speakContent);self.speakContent=nil;
_UIObject_release(self.temp);self.temp=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this

local _CmpLogInfoIndex={
tqName=0,
tqpz=1,
desc=2,
stamp=3,
}

local _TeQuanQualityBgName={
"image_xianguanjishi_tq3",
"image_xianguanjishi_tq2",
'image_xianguanjishi_tq2',
"image_xianguanjishi_tq1"
}




function UIXianGuanSketchyLogWin:onLoaded(...)
self:bindComponents()

_this=self
end


function UIXianGuanSketchyLogWin:__delete()
_this=nil

self:unbindComponents()

xianguanController:updateLogShowSec()
end




function UIXianGuanSketchyLogWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.bgSpine1:setChildUIModelShowTarget(6076,1,{},eAnimationID.enter)
_this.bgSpine2:setChildUIModelShowTarget(6077,1,{},eAnimationID.enter)

self.uiRoot:setChildCanvasGroupAlpha(0)
self.modelInfo:setChildCanvasGroupAlpha(0)
self:delayDo(0.4,function()
_this.uiRoot:setChildCanvasGroupDOFade(1,0.2)
_this.modelInfo:setChildCanvasGroupDOFade(1,0.2)
end)
end


self.model:setChildUIModelShowTarget(2113057,0.7,{},eAnimationID.stand)
self.model:setChildUIModelShowTargetOffset(50,0)

self:refreshLogList()
end


function UIXianGuanSketchyLogWin:onHide()

end

function UIXianGuanSketchyLogWin:refreshLogList()
self.logList=xianguanModel:getLogList_New()


self.logLoopView:initData("temp",self.logList,#self.logList)
end

function UIXianGuanSketchyLogWin:onStartAction()
end

function UIXianGuanSketchyLogWin:onFreshAction(index,widget,data)
data=self.logList[index]

if data~=nil then
local name=xianguanConfig.getTeQuanCfg(data.tqid,'name')
if pfwindowslController:checkIsGameVersion_yuenan()then
else
local nameList=string.toTable(name)
table.insert(nameList,3,'\n')
name=table.concat(nameList)
end

widget:SetChildText(_CmpLogInfoIndex.tqName,name)

local xgName=xianguanConfig.getJobConfig(nil,data.xgid,'name')
xgName=FMT.fmt("<color=#f36666>[{0}]</color>",xgName)

local pName=toColorStringX('#f1ce78',playerModel:getOtherActorName(data.actorname))

local desc=xianguanModel:getsketchyLogDesc(data)

desc=FMT.fmt("{0}{1}{2}",xgName,pName,desc)
widget:SetChildText(_CmpLogInfoIndex.desc,desc)

local timeStr=timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(),timeHelper.convertLongStamp(tonumber(data.sec)))
widget:SetChildText(_CmpLogInfoIndex.stamp,timeStr)

local stage=xianguanConfig.getJobConfig(nil,data.xgid,'stage')
local imgName=_TeQuanQualityBgName[stage]
widget:SetChildCSImageSprite(_CmpLogInfoIndex.tqpz,globalABLookup.xianguan,imgName)
end
end





function UIXianGuanSketchyLogWin:onCloseBtn()
self:closeSelf()
end

function UIXianGuanSketchyLogWin:onLookDetailbtn()
UIFullCommonControl:showCommonWindow("UIXianGuanLogDetailWin",{isFull=true},nil,1,false,nil,nil)
end
