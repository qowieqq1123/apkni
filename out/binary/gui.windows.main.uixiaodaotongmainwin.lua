







def_class("UIXiaoDaoTongMainWin",UIWindowBase)









function UIXiaoDaoTongMainWin:bindComponents()

self.arrow=UIObject.get(self,0)
self.block=UIObject.get(self,1)
self.dogBtn=UIButton.get(self,2)
self.dogReddot=UIObject.get(self,3)
self.dogSp=UIObject.get(self,4)
self.frameSp=UIObject.get(self,5)
self.menuGridPanel=UIObject.get(self,6)
self.rightTalk=UIObject.get(self,7)
self.rightTalkDesc=UIText.get(self,8)
self.root=UIObject.get(self,9)
self.tybg=UIImage.get(self,10)

self.dogBtn:setButtonClick(function()self:onDogBtn()end)



end


function UIXiaoDaoTongMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.block);self.block=nil;
_UIObject_release(self.dogBtn);self.dogBtn=nil;
_UIObject_release(self.dogReddot);self.dogReddot=nil;
_UIObject_release(self.dogSp);self.dogSp=nil;
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
_UIObject_release(self.rightTalk);self.rightTalk=nil;
_UIObject_release(self.rightTalkDesc);self.rightTalkDesc=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tybg);self.tybg=nil;
end





















local pageConfig=
{
[1]={
page=3,
win='UIXiaoDaoTongTipsWin',
ab=globalABLookup.global,
icon='icon_tytabzwbtixing_1',
checkReddot=function()
return xiaodaotongModel:getReddot()
end,
},
[2]={
page=1,
win='UIFastManagerWin',
ab=globalABLookup.global,
icon='icon_tytabzwbshengchan_1',
checkReddot=function()
return xiaodaotongModel:getManufactureReddot()
end,
checkOpen=function()
if mainControl:isInScene(eSceneType.eWorld)then return false end
if mainControl:isInScene(eSceneType.eZongmen)and zongmenControl:isMountid(mapIdType.fort)then return false end
if mainControl:isInScene(eSceneType.eXianJie)then return false end
return true
end
},
[3]={
page=2,
win='UIFastManagerWin',
ab=globalABLookup.global,
icon='icon_tytabzwbjianzao_1',
checkReddot=function()
return xiaodaotongModel:getBuildingReddot()
end,
checkOpen=function()
if mainControl:isInScene(eSceneType.eWorld)then return false end
if mainControl:isInScene(eSceneType.eZongmen)and zongmenControl:isMountid(mapIdType.fort)then return false end
if mainControl:isInScene(eSceneType.eXianJie)then return false end
return true
end
},
[4]={
page=4,
win='UICatEntrustWin',
ab=globalABLookup.globa4,
icon='icon_tytabmmweituo_1',
checkReddot=function()
return catEntrustModel:getReddot()
end,
checkOpen=function()
if not systemModel.isOpen(SYSTEM_DEFINE.eCatEntrust)then return false end
if mainControl:isInScene(eSceneType.eWorld)then return false end

return true
end
},
}
local _this=nil
local dogAnims={{0,true},{12,false},{2113,false}}
local xzsDogAnims={{3085,false},{3086,false}}


function UIXiaoDaoTongMainWin:onLoaded(...)
_this=self
self:bindComponents()

webGLHelper:uiWindowCloseCamera(self.tybg)




self.winList={}
self.pageLookup={}
self.openPageList={}

for i,v in ipairs(pageConfig)do
if v.checkOpen then
if v.checkOpen()then
self.openPageList[#self.openPageList+1]=v
end
else
self.openPageList[#self.openPageList+1]=v
end
end


for i,v in ipairs(self.openPageList)do
self.pageLookup[v.page]=i
end

self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChange(...)end)
end


function UIXiaoDaoTongMainWin:__delete()
_this=nil
self:unbindComponents()

webGLHelper:uiWindowShowCamera()

for win,v in pairs(self.winList)do
UIManager:closeWindow(win)
end
self.winList=nil
end


function UIXiaoDaoTongMainWin:onHide()

end




function UIXiaoDaoTongMainWin:onShow(argtable,afterOnloaded)
local page=3
local args
if argtable then
if argtable.page then
page=argtable.page
local _page=xiaodaotongModel:getBuildCallbackPage()
if _page then
page=_page
xiaodaotongModel:setBuildCallbackPage(argtable.page)
end
end
args=argtable.args
end
local idx=self.pageLookup[page]or 1
self.m_args=args
if afterOnloaded then
local cnt=#self.openPageList
self.menuGridPanel:setChildLayoutGroupCreateItems(cnt)
local grids=self.menuGridPanel:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
local cfg=self.openPageList[i]
item:SetChildCSImageSprite(1,cfg.ab,cfg.icon)
local isSelected=i==idx
self:refreshMenuItemSelect(item,i,isSelected)
self:refreshMenuItemReddot(item,i)
item:SetChildButtonClick(-1,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)





end

self.dogSp:setActive(false)
self.root:setChildCanvasGroupAlpha(0)
local xzsVisiable=xiaoZhuShouController:checkXiaoZhuShouVisiable()
local xzsOpen=xiaoZhuShouController:checkXiaoZhuShouOpen()
local bgModel=xzsVisiable and 5764 or 4710
local bgAnim=xzsVisiable and(xzsOpen and 3082 or 3084)or 2040
self.frameSp:setChildUIModelShowTarget(bgModel,1,{},bgAnim,false,false,0,function()
if _this==nil then return end
self:delayDo(0.15,function()
self.dogSp:setActive(true)
self.root:setChildCanvasGroupDOFade(1,0.25,nil)
self:onMenuItemClick(idx)
self:activeWeakguide()
end)
end)
local anim=table.randomIndex(xzsVisiable and xzsDogAnims or dogAnims)
local dogModel=xzsVisiable and 5765 or 4717
self.dogSp:setChildUIModelShowTarget(dogModel,1,{},anim[1],false,false,0,nil)
self.dogSp:setChildUIModelShowFlipX(anim[2])
self.arrow:setActive(not xzsVisiable)

local dogReddot=xzsOpen and(not dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXZSTips)or xiaoZhuShouModel:checkReportReddot())
self:doPunchRotation(dogReddot)
else
self:onMenuItemClick(idx)
end
end


function UIXiaoDaoTongMainWin:doPunchRotation(reddot)
self.dogReddot:setActive(reddot)
if reddot then
if self.reddotTweener==nil then
self.dogReddot:setRotation(0,0,0)
local tweener=self.dogReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.dogReddot:setRotation(0,0,0)
end
end
end

function UIXiaoDaoTongMainWin:activeWeakguide()
local num=zongmenModel:getFreeManufactureBuildingReddotNum()
if num>=5 then
weakGuideController:beginGuide(3562)
end
end

function UIXiaoDaoTongMainWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end

item:SetChildActive(0,flag)
end

function UIXiaoDaoTongMainWin:refreshMenuItemReddot(item,idx)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local cfg=self.openPageList[idx]
local isReddot=cfg.checkReddot()
item:SetChildActive(2,isReddot)
end

function UIXiaoDaoTongMainWin:refreshMenuReddot(page)
if self.delayFlushTimer==nil then
local func=function()
if not self or self.isClose then return end
self:refreshMenuReddotEx(page)
self.delayFlushTimer=nil
end

self.delayFlushTimer=FrameTimer.New(func,1,0)
self.delayFlushTimer:Start()
end
end

function UIXiaoDaoTongMainWin:refreshMenuReddotEx(page)
local idx=self.pageLookup[page]
if idx then
self:refreshMenuItemReddot(nil,idx)
end
end

function UIXiaoDaoTongMainWin:onMenuItemClick(idx)
local cfg=self.openPageList[idx]
if cfg.page==self.curPage then
return
end
local old=self.curPage
self.curPage=cfg.page
if old~=nil then
local idx_=self.pageLookup[old]
self:refreshMenuItemSelect(nil,idx_,false)
end
self:refreshMenuItemSelect(nil,idx,true)
self:refreshMenuPage()
end

function UIXiaoDaoTongMainWin:refreshPageReddot()
local grids=self.menuGridPanel:getChildLayoutGroupGridList()
local cnt=#self.openPageList
for i=1,cnt do
local item=grids[i-1]
self:refreshMenuItemReddot(item,i)
end
end

function UIXiaoDaoTongMainWin:refreshMenuPage()
local idx=self.pageLookup[self.curPage]
local cfg=self.openPageList[idx]
local win=cfg.win
if self.pagewin~=win and self.pagewin~=nil then
self:hideWindow(self.pagewin)
end
if win~=nil and win~=''then
self.winList[win]=true
self.pagewin=win
local args=table.deepCopy(self.m_args)or{}
args.parentWin='UIXiaoDaoTongMainWin'
args.menuPageIndex=self.curPage
self:showWindow(win,args)
end
end

function UIXiaoDaoTongMainWin:onClickClose()
self:closeSelf()
end

function UIXiaoDaoTongMainWin:checkTalk(args)
if self.delayFlushTalkTimer==nil then
local func=function()
if not self or self.isClose then return end
self:checkTalkEx(args)
self.delayFlushTalkTimer=nil
end

self.delayFlushTalkTimer=FrameTimer.New(func,1,0)
self.delayFlushTalkTimer:Start()
end
end

function UIXiaoDaoTongMainWin:checkTalkEx(args)
local idx=self.pageLookup[self.curPage]
local cfg=self.openPageList[idx]
local win=cfg.win
local list,onceTalk=UIManager:invokeUIMethod(win,'getTalkList',args)
self:doTalk(list,onceTalk)
end

function UIXiaoDaoTongMainWin:doTalk(list,onceTalk)
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
if self.talkDelay then
self:stopTimerByID(self.talkDelay)
self.talkDelay=nil
end
if self.talkDelay2 then
self:stopTimerByID(self.talkDelay2)
self.talkDelay2=nil
end
self.rightTalk:setChildCanvasGroupAlpha(0)
self.talkList=list
self.talkIndex=0
if list~=nil then
self:doTalkAnim(onceTalk)
end
end

function UIXiaoDaoTongMainWin:doTalkAnim(onceTalk)
self.talkDelay=self:delayDo(5,function()
self.talkDelay=nil
self.rightTalk:setChildCanvasGroupAlpha(0)
end)
self.talkDelay2=self:delayDo(7,function()
self.talkDelay2=nil
self:doTalkAnim()
end)
local str
if onceTalk==nil then
self.talkIndex=self.talkIndex+1
if self.talkIndex>#self.talkList then
self.talkIndex=1
end
str=self.talkList[self.talkIndex]
else
str=onceTalk
end
self.rightTalkDesc:setText(str)
self.rightTalk:setScale(Vector3.zero)
self.rightTalk:setChildCanvasGroupAlpha(1)
self.talkTween=self.rightTalk:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.rightTalk:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
end)
end)
end

function UIXiaoDaoTongMainWin:onDogBtn()
if xiaoZhuShouController:checkXiaoZhuShouVisiable()then
UIManager:showWindow("UIXiaoZhuShouWin")
self:closeSelf()
elseif systemModel.isOpen(SYSTEM_DEFINE.eBatch)then
xianChongControl:showFastManufactureWin()
end
end

function UIXiaoDaoTongMainWin:onMoneyChange(moneyType,lastVal,val)
self:refreshMenuReddot(1)
end

function UIXiaoDaoTongMainWin:ChangeDog(flag)
self.dogSp:setActive(flag)

end