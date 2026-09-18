







def_class("UIXianJieExplorationXingYuWin",UIWindowBase)









function UIXianJieExplorationXingYuWin:bindComponents()

self.chooseGrid=UIObject.get(self,0)
self.maskBlock=UIButton.get(self,1)
self.root=UIObject.get(self,2)
self.scrollView=UIObject.get(self,3)
self.uiPanel=UIObject.get(self,4)
self.tipRoot=UIObject.get(self,5)
self.tips=UIText.get(self,6)
self.timeRoot=UIObject.get(self,7)
self.time=UIText.get(self,8)
self.emptyTip=UIObject.get(self,9)
self.rule=UIButton.get(self,10)

self.maskBlock:setButtonClick(function()self:onMaskBlock()end)

self.rule:setButtonClick(function()self:onRule()end)



end


function UIXianJieExplorationXingYuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.chooseGrid);self.chooseGrid=nil;
_UIObject_release(self.maskBlock);self.maskBlock=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.uiPanel);self.uiPanel=nil;
_UIObject_release(self.tipRoot);self.tipRoot=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.emptyTip);self.emptyTip=nil;
_UIObject_release(self.rule);self.rule=nil;
end















local itemcmp={
item=0,
icon=1,
name=2,
colorFlag=3,
ingFlag=4,
reddot=5,
}

local actID
local _this
local abName="ui/windows/xingyu/xingyu_atlas_pak.ab"



function UIXianJieExplorationXingYuWin:onLoaded(...)
self:bindComponents()
_this=self
actID=LIMIT_ACT_TYPE.eXianJieXingYu
self:addNotify(notifyConfig.onLimitActOpen,self.onLimitActOpen)
self:addNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
end


function UIXianJieExplorationXingYuWin:__delete()
self:unbindComponents()
self:stopTimer()
_this=nil
actID=nil
XingYuController.setFirstReddot()
UIManager:invokeUIMethod("UIXianJieMainWin","refreshTanChaBtn")
end




function UIXianJieExplorationXingYuWin:onShow(argtable,afterOnloaded)
self:refreshView()
if afterOnloaded and argtable.isInit then
self:playEnterAnim()
end
end


function UIXianJieExplorationXingYuWin:onHide()
self:stopTimer()
XingYuController.setFirstReddot()
end

function UIXianJieExplorationXingYuWin:refreshView()
self:refreshLockTips()
self:refreshScrollView()
self:refreshTime()
end

function UIXianJieExplorationXingYuWin:refreshLockTips()
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo then
local open,tipStr=actInfo:checkCondition()
if open then
self.tipRoot:setActive(false)
else
self.tipRoot:setActive(true)
self.tips:setText(tipStr)
end
else
self.tipRoot:setActive(false)
end
end

function UIXianJieExplorationXingYuWin:refreshScrollView()

local _xingyuIdList=XingYuModel:getXingYuIdList()
if not limitActivitiesModel:checkActDoing(actID)or not _xingyuIdList then
self.scrollView:setChildScrollViewCreateGrids(0,1)
self.emptyTip:setActive(true)
return
end

self.emptyTip:setActive(false)
local xingyuIdList=table.deepCopy(_xingyuIdList)
table.sort(xingyuIdList,function(a,b)
local acfg=XingYuModel:getXingYuConfig(a)
local bcfg=XingYuModel:getXingYuConfig(b)
local aSFlag=XingYuController.checkHasTeam(a)and acfg.color+100 or acfg.color
local bSFlag=XingYuController.checkHasTeam(b)and bcfg.color+100 or bcfg.color
return aSFlag>bSFlag
end)

local cnt=#xingyuIdList
self.scrollView:setChildScrollViewCreateGrids(cnt,1)
local grid=self.scrollView:getChildScrollViewItemWidgets()
local reddot=XingYuController.checkFirstReddot()
for i=1,cnt do
local item=grid[i-1]
local xyId=xingyuIdList[i]
local xyCfg=XingYuModel:getXingYuConfig(xyId)
local name=xyCfg.name
local colorAssest=xyCfg.colorAssest
local iconAssest=xyCfg.iconAssest
item:SetChildText(itemcmp.name,name)
item:SetChildCSImageSprite(itemcmp.icon,abName,iconAssest)
item:SetChildCSImageSprite(itemcmp.colorFlag,abName,colorAssest)
local ingFlag=XingYuController.checkHasTeam(xyId)
item:SetChildActive(itemcmp.ingFlag,ingFlag)
item:SetChildActive(itemcmp.reddot,not ingFlag and reddot)
item:SetChildButtonClick(itemcmp.item,function()
local fun=function()
XingYuController:openXYListWin(true,xyId)













end
local sceneType=xianjienSceneType.eXianJie
if xianjieModel:checkSceneType(sceneType)then
fun()
return
end
xianjieController:jumpXianJie(sceneType,{},fun)
end)
end
end



function UIXianJieExplorationXingYuWin:refreshTime()
local func=function()
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo then
local reTime=actInfo.n_start_time
if actInfo:checkIdle()or actInfo:checkPreview()then
reTime=actInfo.start_time
end
local curTime=timeHelper.getServerShortTime()
local lerp=reTime-curTime
if lerp>=0 then
if lerp>=3600 then

local str
if lerp>86400 and lerp%86400==0 then

str=timeHelper.format_time_stamp11(lerp-1,true)
else
str=timeHelper.format_time_stamp11(lerp,true)
end
self.time:setText(FMT.fmt("星域刷新：<color=#7d3b17>{0}</color>",timeHelper.format_time_stamp11(lerp,true)))
else

self.time:setText(FMT.fmt("星域刷新：<color=#7d3b17>{0}</color>",timeHelper.format_time_stamp7(lerp)))
end
else
self.time:setText("")

end
else
self.time:setText("")

end
end
self:startTimer(func)

func()
end


function UIXianJieExplorationXingYuWin:stopTimer()
if self._timer then
self:stopTimerByID(self._timer)
self._timer=nil
end
end

function UIXianJieExplorationXingYuWin:startTimer(func)
self:stopTimer()
self._timer=self:setTimer(1,0,func)
end








function UIXianJieExplorationXingYuWin:onMaskBlock()
end

function UIXianJieExplorationXingYuWin:onRule()
local args={
ruleGroupID=ruleTipsImageGroup.eXingYu,
}
self:showWindow("UIRuleTipsImage2Win",args)
end







function UIXianJieExplorationXingYuWin.onLimitActOpen(argActID,flag)
if _this==nil then return end
if actID~=argActID then return end
_this:refreshView()
end

function UIXianJieExplorationXingYuWin.onLimitActStateChange(argActID,state)
if _this==nil then return end
if actID~=argActID then return end
_this:refreshView()
end




function UIXianJieExplorationXingYuWin:playEnterAnim()

if not newbieControl.isInNewbie()then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-508,0))
self.uiPanel:setChildDOAnchorPosX(14,0.2,nil)
end
UIManager:invokeUIMethod('UIXianJieExplorationWin','playEnterAnim')
end


function UIXianJieExplorationXingYuWin:playLeaveAnim()
self.uiPanel:setChildDOAnchorPosX(-508,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil
self:closeSelf()
end)
end
