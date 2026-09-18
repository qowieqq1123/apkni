







def_class("UIXM_ZZSH_entitySelectPvPWin",UIWindowBase)









function UIXM_ZZSH_entitySelectPvPWin:bindComponents()

self.maskBlock=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.uiPanel=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.tabList=UIObject.get(self,4)

self.maskBlock:setButtonClick(function()self:onMaskBlock()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXM_ZZSH_entitySelectPvPWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.maskBlock);self.maskBlock=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.uiPanel);self.uiPanel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.tabList);self.tabList=nil;
end
















local _this
local pageConfig=
{
[1]={
page=1,
win='UIXM_ZZSH_lingdiSelectWin',
name='领地',
infotype=eZZSHEntityType.eLingDi,
checkReddot=function(self_,win)
return false
end,
},
[2]={
page=2,
win='UIXM_ZZSH_xiammengSelectWin',
name='仙盟',
infotype=eZZSHEntityType.ePvEXianMeng,
checkReddot=function(self_,win)
return false
end,
},
}


function UIXM_ZZSH_entitySelectPvPWin:onLoaded(...)
_this=self
self:bindComponents()
self.winList={}
self.pageLookup={}
for i,v in ipairs(pageConfig)do
self.pageLookup[v.page]=i
end

self.mapView=UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','getMapView')
end

function UIXM_ZZSH_entitySelectPvPWin:getMapView()
return self.mapView
end


function UIXM_ZZSH_entitySelectPvPWin:__delete()
_this=nil
self:unbindComponents()
for win,v in pairs(self.winList)do
UIManager:closeWindow(win)
end
self.winList=nil
end


function UIXM_ZZSH_entitySelectPvPWin:onHide()

end




function UIXM_ZZSH_entitySelectPvPWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
end
self:initQingBaoList()
local page=1
if argtable then
if argtable.page then
page=argtable.page
end
end
local idx=self.pageLookup[page]
if afterOnloaded then
local cnt=#pageConfig
self.tabList:setChildLayoutGroupCreateItems(cnt)
local grids=self.tabList:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
local cfg=pageConfig[i]
item:SetChildText(1,cfg.name)
local isSelected=i==idx
self:refreshMenuItemSelect(item,i,isSelected)
self:refreshMenuItemReddot(item,i)
item:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)
item:SetChildNewBieComponentId(3,FMT.fmt('UIXM_ZZSH_entitySelectPvPWin.shqbtab_{0}',i))
end
end
self:onMenuItemClick(idx,true)
end

function UIXM_ZZSH_entitySelectPvPWin:playEnterAnim()
if not newbieControl.isInNewbie()then
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-508,1))
self.uiPanel:setChildDOAnchorPosX(14,0.2,nil)
else
self.root:setChildCanvasGroupAlpha(1)
end
end

function UIXM_ZZSH_entitySelectPvPWin:playLeaveAnim()
UIManager:invokeUIMethod('UIXM_ZZSH_lingdiSelectWin','playLeaveAnim')
UIManager:invokeUIMethod('UIXM_ZZSH_xiammengSelectWin','playLeaveAnim')
self.uiPanel:setChildDOAnchorPosX(-508,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil
self:closeSelf()
end)
end

function UIXM_ZZSH_entitySelectPvPWin:initQingBaoList()
local lp={[eZZSHEntityType.ePvEXianMeng]=true}
self.qblist=zhengzhanshanhaiModel:getNearEntity(lp)
end

function UIXM_ZZSH_entitySelectPvPWin:getQingBaoList(infotype,isInit)
if isInit then
self:initQingBaoList()
end
local list={}
for i,d in ipairs(self.qblist)do
if d[2]==infotype then
table.insert(list,d)
end
end
return list
end

function UIXM_ZZSH_entitySelectPvPWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.tabList:getChildLayoutGroupGridItem(idx-1)
end
item:SetChildActive(0,flag)
end

function UIXM_ZZSH_entitySelectPvPWin:refreshMenuItemReddot(item,idx)
if item==nil then
item=self.tabList:getChildLayoutGroupGridItem(idx-1)
end
local cfg=pageConfig[idx]
local isReddot=cfg:checkReddot(self)
item:SetChildActive(2,isReddot)
end

function UIXM_ZZSH_entitySelectPvPWin:refreshAllMenuItemReddot()
local cnt=#pageConfig
local grids=self.tabList:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
self:refreshMenuItemReddot(item,i)
end
end

function UIXM_ZZSH_entitySelectPvPWin:onMenuItemClick(idx,isInit)
if self.closeLock then return end
local cfg=pageConfig[idx]
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
self:refreshMenuItemReddot(nil,idx)
self:refreshMenuPage(isInit)
end

function UIXM_ZZSH_entitySelectPvPWin:refreshMenuPage(isInit)
local idx=self.pageLookup[self.curPage]
local cfg=pageConfig[idx]
local win=cfg.win
if self.pagewin~=win and self.pagewin~=nil then
self:hideWindow(self.pagewin)
end
if win~=nil and win~=''then
self.winList[win]=true
self.pagewin=win
local args={}
args.page=self.curPage
args.isInit=isInit
self:showWindow(win,args)
end
end

function UIXM_ZZSH_entitySelectPvPWin:onMaskBlock()
if _this==nil then return end
if self.closeLock then return end
self:onCloseBtn()
end

function UIXM_ZZSH_entitySelectPvPWin:onCloseBtn()
if _this==nil then return end
if self.closeLock then return end
self:playLeaveAnim()
end