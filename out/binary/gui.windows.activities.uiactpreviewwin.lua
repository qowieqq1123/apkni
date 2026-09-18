







def_class("UIActPreviewWin",UIWindowBase)









function UIActPreviewWin:bindComponents()

self.root=UIObject.get(self,0)
self.frameSp=UIObject.get(self,1)
self.waterSp=UIObject.get(self,2)
self.titleImg=UIImage.get(self,3)
self.actTipsTxt=UIText.get(self,4)
self.btnGo=UIButton.get(self,5)
self.showToggle=UIToggleButton.get(self,6)
self.actTimeObj=UIObject.get(self,7)
self.btnReward=UIButton.get(self,8)
self.menuGridPanel=UIObject.get(self,9)
self.rewardImg=UIImage.get(self,10)
self.rewardReddot=UIObject.get(self,11)
self.actTimeTxt=UIText.get(self,12)

self.btnGo:setButtonClick(function()self:onBtnGo()end)

self.btnReward:setButtonClick(function()self:onBtnReward()end)



end


function UIActPreviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.waterSp);self.waterSp=nil;
_UIObject_release(self.titleImg);self.titleImg=nil;
_UIObject_release(self.actTipsTxt);self.actTipsTxt=nil;
_UIObject_release(self.btnGo);self.btnGo=nil;
_UIObject_release(self.showToggle);self.showToggle=nil;
_UIObject_release(self.actTimeObj);self.actTimeObj=nil;
_UIObject_release(self.btnReward);self.btnReward=nil;
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
_UIObject_release(self.rewardImg);self.rewardImg=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.actTimeTxt);self.actTimeTxt=nil;
end
















local _this=nil


function UIActPreviewWin:onLoaded(...)
_this=self
self:bindComponents()
self.titlePos=self.titleImg:getChildLocalPosition()
end


function UIActPreviewWin:__delete()
_this=nil
local flag=nil
if self.is_showToggle==true then
flag=self.showToggle:getToggle()
end
self:unbindComponents()
if flag==true then
actPreviewModel:markActPreview()
end
end


function UIActPreviewWin:onHide()

end




function UIActPreviewWin:onShow(argtable,afterOnloaded)
self.actList=actPreviewModel:getPreviewSortList()
self:initMenuPanel()

if self.actTimer==nil then
local func=function()
self:timerRefresh()
self:actRefresh()
end
self.actTimer=self:setTimer(1,0,func)
self:timerRefresh()
end
self:updataView()

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.25,function()
self.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)




end
end

function UIActPreviewWin:timerRefresh()
local d=self.actList[self.curPage]
local lerp,str=d:getOpenTime()
self.actTimeTxt:setText(str)
if lerp==0 then
self:refreshDesc()
end
end

function UIActPreviewWin:actRefresh()
local list=actPreviewModel:getPreviewSortList()
local c1=#self.actList
local c2=0
if list~=nil then
c2=#list
end
if c2==0 then
self:closeSelf()
else
local rebuild=false
if c2~=c1 then
rebuild=true
else
for i=1,c1 do
if self.actList[i].id~=list[i].id then
rebuild=true
break
end
end
end
if rebuild then
self.actList=list
self:initMenuPanel()
self:updataView()
end
end
end

function UIActPreviewWin:updataView()

local hasReward=false
for i,d in ipairs(self.actList)do
if d:checkReward()then
hasReward=true
break
end
end
self.is_showToggle=not hasReward
self.showToggle:setActive(self.is_showToggle)
end

function UIActPreviewWin:findActIndex(id)
for idx,d in ipairs(self.actList)do
if d.id==id then
return idx
end
end
return nil
end

function UIActPreviewWin:initMenuPanel()
local page=1
for idx,d in ipairs(self.actList)do
if d:checkReward()then
page=idx
break
end
end
self.curPage=page
local grids=self.menuGridPanel:getChildCommonLayoutGroupWidgetList()
for i=1,actPreviewModel.maxNum do
local item=grids[i-1]
local d=self.actList[i]
local isshow=d~=nil
item:SetChildActive(-1,isshow)
if isshow then
local cfg=d.cfg
item:SetChildText(2,cfg.name)
local isSelected=i==self.curPage
self:refreshMenuItemSelect(item,i,isSelected)
self:refreshMenuItemReddot(item,i)
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)
end
end
local c=#self.actList
local isshow=c>1
self.menuGridPanel:setActive(isshow)
self:refreshMenuPage()
end

function UIActPreviewWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildCommonLayoutGroupWidgetItem(idx-1)
end
item:SetChildActive(1,flag)
end

function UIActPreviewWin:refreshMenuItemReddot(item,idx)
if item==nil then
item=self.menuGridPanel:getChildCommonLayoutGroupWidgetItem(idx-1)
end
local d=self.actList[idx]
local isReddot=d:checkReward()
item:SetChildActive(3,isReddot)
end

function UIActPreviewWin:onMenuItemClick(page)
if page==self.curPage then
return
end
local old=self.curPage
self.curPage=page
if old~=nil then
self:refreshMenuItemSelect(nil,old,false)
end
self:refreshMenuItemSelect(nil,page,true)
self:refreshMenuPage()
self:timerRefresh()
end

function UIActPreviewWin:refreshMenuPage()
local d=self.actList[self.curPage]
local cfg=d.cfg

local title=cfg.title
local pos=self.titlePos
local titlename=FMT.fmt('actpreview_title_{0}',title[1])
self.titleImg:setSprite(globalABLookup.actpreviewicons,titlename)
self.titleImg:setLocalPos(pos.x+title[2],pos.y+title[3],0)

local spid=cfg.bgSpineID
local showsp=spid>0
self.frameSp:setActive(showsp)
if showsp then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.frameSp:getID(),false,true,false)
self.frameSp:setChildUIModelShowTarget(spid,1,{},2040,false,false,0,nil)
end

self:refreshDesc()

self:refreshReward()
end

function UIActPreviewWin:refreshDesc()

local d=self.actList[self.curPage]
local cfg=d.cfg
local isDoing,desc=d:checkDoing()
self.actTimeObj:setActive(not isDoing)
self.actTipsTxt:setActive(isDoing)
if isDoing then
self.actTipsTxt:setText(desc)
end
if pfwindowslController:checkIsGameVersion_yuenan()then
self.actTimeObj:setActive(false)
self.actTipsTxt:setActive(false)
end

local showGo=cfg.jump~=nil and isDoing
self.btnGo:setActive(showGo)
end

function UIActPreviewWin:refreshReward()
local d=self.actList[self.curPage]

local curHasReward=d:checkReward()
local icon
if curHasReward then
icon='image_zongmdabi_02'
else
icon='image_zongmdabi_03'
end
self.rewardImg:setSprite(globalABLookup.actpreviewicons,icon)
self.rewardReddot:setActive(curHasReward)
end

function UIActPreviewWin:onClickClose()
local page=nil
for idx,d in ipairs(self.actList)do
if d:checkReward()then
page=idx
break
end
end
if page then
if self.curPage==page then
local func=function()
if _this==nil then return end
_this:closeSelf()
end
local content='有奖励尚未领取，是否关闭界面？'
UIDialogManager.getCommonDialog(nil,content,func)
else
self:onMenuItemClick(page)
end
else
self:closeSelf()
end
end

function UIActPreviewWin:onBtnGo()
local d=self.actList[self.curPage]
local cfg=d.cfg
if cfg.jump then
local flag=jumpManager:jump(cfg.jump,nil,JUMP_BACK.eNoBack)
if flag then
UIManager:closeWindow('UIActPreviewWin')
end
end
end

function UIActPreviewWin:onBtnReward()
local d=self.actList[self.curPage]
local curHasReward=d:checkReward()
if not curHasReward then
return
end

actPreviewController:send_254_69(d.id)
end

function UIActPreviewWin:recv_reward(id)
local idx=self:findActIndex(id)
if idx then
self:refreshMenuItemReddot(nil,idx)
end
self:refreshReward()
self:updataView()
end