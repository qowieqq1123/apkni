







def_class("UISubAct_dongtianfudi_info_Win",UIWindowBase)









function UISubAct_dongtianfudi_info_Win:bindComponents()

self.animRoot=UIObject.get(self,0)
self.bg=UIObject.get(self,1)
self.TabPanel=UIObject.get(self,2)
self.TabPanel2=UIObject.get(self,3)
self.closeBtn=UIButton.get(self,4)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_dongtianfudi_info_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.animRoot);self.animRoot=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.TabPanel);self.TabPanel=nil;
_UIObject_release(self.TabPanel2);self.TabPanel2=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end




















function UISubAct_dongtianfudi_info_Win:onLoaded(...)
self:bindComponents()
self.bg:setChildUIModelShowTarget(4738,1,{},eAnimationID.enter,false,nil,0)

self.TabPanel2:setChildAnchoredPos(1000,-50)
self.TabPanel2:setChildDOLocalMoveX(611.3,0.3)
end


function UISubAct_dongtianfudi_info_Win:__delete()
self:unbindComponents()
UIManager:invokeUIMethod("UISubAct_dongtianfudi_Win","showInfoRoot",1)
end




function UISubAct_dongtianfudi_info_Win:onShow(argtable,afterOnloaded)
local pageWinList=argtable.pageWinList
local winIndex=argtable.winIndex
local args=argtable.args
local fudiIndex=argtable.fudiIndex

self.pageWinList=pageWinList
self.selectIndex=winIndex
self.fudiIndex=fudiIndex
self.args=args

self.actid=args.act_id
self.subType=SUB_ACTIVITY_TYPE.eDongTianFuDi
self.subid=args.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)

local win=pageWinList[winIndex]


if not self.initWin then
args.initWin=true
self:showWindow(win.panel,{fudiIndex=fudiIndex,args=args})
self.initWin=true

self.TabPanel:setLocalPosY(-638)
local tween=self.TabPanel:setChildDOLocalMoveY(143.3,0.325)
tween:SetDelay(0.12)
self.TabPanel:setChildCanvasGroupAlpha(0)
local tween=self.TabPanel:setChildCanvasGroupDOFade(1,0.325)
tween:SetDelay(0.12)
else
args.initWin=nil
self:showWindow(win.panel,{fudiIndex=fudiIndex,args=args})
end

self:refreshTopList()
self:refreshRightList()
UIManager:invokeUIMethod("UISubAct_dongtianfudi_Win","showInfoRoot",0)
end

function UISubAct_dongtianfudi_info_Win:onRecv()
self:refreshTopReddot()
self:refreshRightReddot()
end

function UISubAct_dongtianfudi_info_Win:refreshTopList()
local num=#self.pageWinList
local pageWinList=self.pageWinList
self.TabPanel:setChildScrollViewCreateGrids(num,num)
local grids=self.TabPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local page=pageWinList[i]
local name=page.name

item:SetChildText(1,name)
item:SetChildActive(0,self.selectIndex==i)
item:SetChildButtonClick(2,function()
self:onTabClick(i,page,item)
end)

if page.reddot then
item:SetChildActive(3,page.reddot(self.actid,self.subid,self.fudiIndex))
else
item:SetChildActive(3,false)
end

end
end

function UISubAct_dongtianfudi_info_Win:refreshTopReddot()
local pageWinList=self.pageWinList
local grids=self.TabPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local page=pageWinList[i]
if page.reddot then
item:SetChildActive(3,page.reddot(self.actid,self.subid,self.fudiIndex))
else
item:SetChildActive(3,false)
end
end
end

function UISubAct_dongtianfudi_info_Win:onTabClick(index,page,item)
if self.selectIndex==index then
return
end
self:hideWindow(self.pageWinList[self.selectIndex].panel)
local oldIndex=self.selectIndex
self.selectIndex=index
self.args.initWin=nil
self:showWindow(page.panel,{fudiIndex=self.fudiIndex,args=self.args})
item:SetChildActive(0,true)
local grid=self.TabPanel:getChildScrollViewItemWidget(oldIndex-1)
if grid then
grid:SetChildActive(0,false)
end
end


function UISubAct_dongtianfudi_info_Win:refreshRightList()
local nameList=self.config.name
local num=#nameList
self.TabPanel2:setChildScrollViewCreateGrids(num,1)
local grids=self.TabPanel2:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local name=nameList[i]

item:SetChildText(1,name)
item:SetChildActive(0,self.fudiIndex==i)
item:SetChildButtonClick(2,function()
self:onTab2Click(i,item)
end)
item:SetChildActive(3,self.pageWinList[2].reddot(self.actid,self.subid,i))
end
end

function UISubAct_dongtianfudi_info_Win:refreshRightReddot()
local grids=self.TabPanel2:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
item:SetChildActive(3,self.pageWinList[2].reddot(self.actid,self.subid,i))
end
end

function UISubAct_dongtianfudi_info_Win:onTab2Click(index,item)
if self.fudiIndex==index then
return
end

local oldIndex=self.fudiIndex
self.fudiIndex=index
self.args.initWin=nil
self:showWindow(self.pageWinList[self.selectIndex].panel,{fudiIndex=index,args=self.args})
item:SetChildActive(0,true)
local grid=self.TabPanel2:getChildScrollViewItemWidget(oldIndex-1)
if grid then
grid:SetChildActive(0,false)
end
self:refreshTopReddot()
end


function UISubAct_dongtianfudi_info_Win:onHide()

end





function UISubAct_dongtianfudi_info_Win:onCloseBtn()
self:closeSelf()
end

