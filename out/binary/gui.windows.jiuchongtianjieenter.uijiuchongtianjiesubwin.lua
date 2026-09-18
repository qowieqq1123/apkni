







def_class("UIJiuChongTianJieSubWin",UIWindowBase)









function UIJiuChongTianJieSubWin:bindComponents()

self.bgroot=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.groupRoot=UIObject.get(self,2)
self.leaveBtn=UIButton.get(self,3)
self.root=UIObject.get(self,4)
self.subRoot=UIObject.get(self,5)
self.testRoot=UIButton.get(self,6)
self.topMask=UIObject.get(self,7)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.leaveBtn:setButtonClick(function()self:onLeaveBtn()end)

self.testRoot:setButtonClick(function()self:onTestRoot()end)



end


function UIJiuChongTianJieSubWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgroot);self.bgroot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.groupRoot);self.groupRoot=nil;
_UIObject_release(self.leaveBtn);self.leaveBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.subRoot);self.subRoot=nil;
_UIObject_release(self.testRoot);self.testRoot=nil;
_UIObject_release(self.topMask);self.topMask=nil;
end


















local titleAB="ui/windows/jiuchongtianjieenter/enter_sub_title_atlas_pak.ab"
local imgAB="ui/windows/jiuchongtianjieenter/enter_sub_img_atlas_pak.ab"
local enterAB="ui/windows/jiuchongtianjieenter/enter_atlas_pak.ab"


function UIJiuChongTianJieSubWin:onLoaded(...)
self:bindComponents()


self.onJctjReddotChange=function()
self:refreshReddot()
end
self:addNotify(notifyConfig.onJctjReddotChange,self.onJctjReddotChange)

self.onJctjProgressChange=function()
self:refreshGroup(self.selectGroupIdx)
self:refreshSub()
end
self:addNotify(notifyConfig.onJctjProgressChange,self.onJctjProgressChange)

self.plotTest=0
self:showTestRoot()
end


function UIJiuChongTianJieSubWin:__delete()
self:unbindComponents()
end




function UIJiuChongTianJieSubWin:onShow(argtable,afterOnloaded)
local sysType=argtable.sysType

self:refreshGroup(sysType)
self:refreshSub()

if argtable.additionalWin then
self:delayDo(0.2,function()
self:showWindow(argtable.additionalWin)
end)
end
end


function UIJiuChongTianJieSubWin:onHide()

end


local finishWidgetIdx={{2,5},{3,6},{4,7}}
function UIJiuChongTianJieSubWin:refreshGroup(selectType)
local list=JiuChongTianJieEnterModel:getSortSysList()
local num=#list
self.groupList=list
self.groupRoot:setChildLayoutGroupCreateItems(num)
local grids=self.groupRoot:getChildLayoutGroupGridList()

for i=1,num do
local grid=grids[i-1]
local config=list[i]

local unlock=JiuChongTianJieEnterModel:getSysConditon(config.id)
if unlock then
grid:SetChildActive(0,true)
grid:SetChildCSImageSprite(0,enterAB,config.titleImg)
else
grid:SetChildActive(0,false)
end

local progress,max=JiuChongTianJieEnterModel:getProgressCount(config.id)

grid:SetChildText(1,FMT.fmt("{0}/{1}",progress,max))

grid:SetChildActive(9,self.selectGroupIdx==i)

local reddot=JiuChongTianJieEnterModel:getReddot(config.id)and self.selectGroupIdx~=i
grid:SetChildActive(10,reddot)
self:doPunchRotation_Btn("g"..i,grid,10,reddot)
grid:SetChildActive(11,not unlock)
grid:SetChildActive(2,unlock or false)
grid:SetChildButtonClick(8,function()

if not unlock then
local isShield=JiuChongTianJieEnterModel:isShield(config.id)
if isShield then
if config.id==JIUCHONGTIANJIE_SYS_TYPE.eZhuXianTai then
UIManager.error("请师尊斩断尘缘后再行查看")
else
UIManager.error("敬请期待")
end
else
local condText=JiuChongTianJieEnterModel:getConditonTxt(config.id)
UIManager.error(condText)
end
return
end

if self.selectGroupIdx==i then
return
end
self:selectGroup(i)
self:refreshSub()
end)

end
if selectType then
self:selectGroup(selectType)
else
self:selectGroup(1)
end
end

function UIJiuChongTianJieSubWin:refreshSub()
local group=self.groupList[self.selectGroupIdx]

if not group then return end
local sysType=group.id

local subList=JiuChongTianJieEnterModel:getSysList(sysType)
local list={}
for i,sub in ipairs(subList)do
local subConfig=cfgHelper.get(cfg_jctjsubsysconfig_get,sub)
local subClass=JiuChongTianJieEnterModel:getSubSysClass(sub)

table.insert(list,{class=subClass,config=subConfig})

end
self.selectSubList=list
local num=#list
self.subRoot:setChildLayoutGroupCreateItems(num)
local grids=self.subRoot:getChildLayoutGroupGridList()
local delay=0.1
for i=1,num do
local grid=grids[i-1]
local config=list[i].config
local class=list[i].class
grid:SetChildCSImageSprite(0,titleAB,"image_jiuchongtjsfbt_"..config.icon)
grid:SetChildCSImageSprite(6,imgAB,"image_jiuchongtjsfct_"..config.icon)
local checkOpen=class:checkOpen()or false

local isXjjy=config.id==JIUCHONGTIANJIE_SUB_SYS_TYPE.eXianJieJieYin
grid:SetChildActive(0,not isXjjy)
grid:SetChildActive(6,not isXjjy)
grid:SetChildActive(13,not isXjjy)
grid:SetChildActive(14,isXjjy)

grid:SetChildActive(10,not checkOpen)
if not checkOpen then

local coldDay=class:getColdDay()
if coldDay>0 then
grid:SetChildText(9,FMT.fmt("<size=30>{0}</size>天后开启",coldDay))
else
grid:SetChildText(9,class:getOpenTips()or'')
end
else
grid:SetChildText(9,'')
end

local cur,max=class:getProgress()
if cur==nil or max==nil then
loggerUtil.logErrFMT("系统[{0}]进度为空",config.name)
cur=0
max=0
end

local showProgessNum=class.showProgessNum
local isShowProgress=class.isShowProgress
grid:SetChildActive(2,false)
grid:SetChildActive(3,false)
grid:SetChildActive(4,checkOpen and isShowProgress)
grid:SetChildActive(7,cur>=max)








grid:SetChildProgress(4,cur,max)










grid:SetChildButtonClick(5,function()
if not checkOpen then

local coldDay=class:getColdDay()
if coldDay>0 then
UIManager.error(FMT.fmt("<size=30>{0}</size>天后开启{1}",coldDay,config.name))
else
UIManager.error(class:getOpenTips()or'')
end
return
end

local playPlot=userActorArraySetting.get(ACTOR_SETTING_TYPE.eJiuChongTianJie,"playOpenPlot"..config.id,false)and self.plotTest~=1
if not playPlot then
UIManager:showWindow("UIJiuChongTianJieSysOpenWin",{sysid=config.id,callback=function()
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eJiuChongTianJie,"playOpenPlot"..config.id,true)
class:doJump()
end})
else
class:doJump()
end
end)
local reddot=class:getReddot()or false
grid:SetChildActive(8,reddot)

self:doPunchRotation_Btn("s"..i,grid,8,reddot)

grid:SetChildCanvasGroupAlpha(11,0)
self:delayDo(0.2+delay*(i-1),function()
grid:SetChildCanvasGroupAlpha(11,1)
grid:SetChildDOPunchPosition(11,Vector3(0,-15,0),0.5,0,0)
end)

grid:SetChildNewBieComponentId(5,FMT.fmt('UIJiuChongTianJieSubWin.subItem_{0}',config.id))
end

if NEWBIE_LUA_FUNC_NAME['first_enter_JCTJ_sub_'..sysType]then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME['first_enter_JCTJ_sub_'..sysType])
end
end

function UIJiuChongTianJieSubWin:refreshReddot()
local group=self.groupList[self.selectGroupIdx]
if not group then return end
local grids=self.subRoot:getChildLayoutGroupGridList()
for i=1,grids.Count do
local item=self.selectSubList[i]
if item then
local class=item.class
local reddot=class:getReddot()or false
grids[i-1]:SetChildActive(8,reddot)
self:doPunchRotation_Btn("s"..i,grids[i-1],8,reddot)
end
end
local list=JiuChongTianJieEnterModel:getSortSysList()
local grids=self.groupRoot:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
local config=list[i]
local reddot=JiuChongTianJieEnterModel:getReddot(config.id)and self.selectGroupIdx~=i
grid:SetChildActive(10,reddot)
self:doPunchRotation_Btn("g"..i,grid,10,reddot)
end
end


function UIJiuChongTianJieSubWin:selectGroup(idx)
local grids=self.groupRoot:getChildLayoutGroupGridList()
if grids[idx-1]then
grids[idx-1]:SetChildActive(9,true)

grids[idx-1]:SetChildActive(10,false)
end
if self.selectGroupIdx and grids[self.selectGroupIdx-1]then
grids[self.selectGroupIdx-1]:SetChildActive(9,false)
end
self.selectGroupIdx=idx
self:refreshReddot()
end

function UIJiuChongTianJieSubWin:doPunchRotation_Btn(widgetId,btnWidget,index,reddot)
if not self.reddotTweener_BtnList then
self.reddotTweener_BtnList={}
end

if reddot then
if self.reddotTweener_BtnList[widgetId]==nil then
btnWidget:SetChildRotation(index,0,0,0)
local tweener=btnWidget:SetChildDOPunchRotation(index,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener_BtnList[widgetId]={}
self.reddotTweener_BtnList[widgetId].tweener=tweener
self.reddotTweener_BtnList[widgetId].cmpIndex=index
self.reddotTweener_BtnList[widgetId].btnWidget=btnWidget
btnWidget:SetChildActive(index,true)
end
else
if self.reddotTweener_BtnList[widgetId]~=nil then
btnWidget:SetChildActive(index,false)
local tweener=self.reddotTweener_BtnList[widgetId].tweener
tweener:Complete()
tweener:Kill()
self.reddotTweener_BtnList[widgetId]=nil
btnWidget:SetChildRotation(index,0,0,0)
end
end
end

function UIJiuChongTianJieSubWin:showTestRoot()
local show=false



self.testRoot:setActive(show)

end

function UIJiuChongTianJieSubWin:onTestRoot()
self.plotTest=1
end




function UIJiuChongTianJieSubWin:onCloseBtn()
self.topMask:setChildCanvasGroupAlpha(0)
self.topMask:setChildCanvasGroupDOFade(1,0.75,function()
UIManager:callWindowFunc("UIJiuChongTianJieEnterWin","playOpenAnim")
self:closeSelf()
end)
end

function UIJiuChongTianJieSubWin:onLeaveBtn()
local func=function()
UIFullJiuChongTianJieControl:closeUI()
end
loadingControl.openCloud(func,0.5)
end
