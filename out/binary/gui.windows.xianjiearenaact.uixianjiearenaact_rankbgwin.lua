







def_class("UIXianJieArenaAct_rankBgWin",UIWindowBase)









function UIXianJieArenaAct_rankBgWin:bindComponents()

self.menuGridPanel=UIObject.get(self,0)



end


function UIXianJieArenaAct_rankBgWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
end
















local pageConfig=
{
[1]={
page=4,
win='UIXianJieArenaAct_arenaOccupyWin',
name='擂台\n占领',
checkReddot=function()
return xianJieArenaActModel:checkIsCanGetArenaReward()
end,
checkShowFunc=function()

local isOpenAct=xianJieArenaActModel:checkIsXJArenaActDoing()
if isOpenAct then
return false
end
return true
end,
isSettlementWin=true,
},
[2]={
page=1,
win='UIXianJieArenaAct_rankPersonWin',
name='个人\n战绩',
checkReddot=function()
return false
end,
},
[3]={
page=2,
win='UIXianJieArenaAct_rankXMWin',
name='仙盟\n战绩',
checkReddot=function()
return false
end,
},
[4]={
page=3,
win='UIXianJieArenaAct_rankZhanYunWin',
name='个人\n战陨',
checkReddot=function()
return false
end,
},
}
local _this=nil
local menu_slot_name='button_dytab'




function UIXianJieArenaAct_rankBgWin:onLoaded(...)
_this=self
self:bindComponents()
self.winList={}
self:addNotify(notifyConfig.onEnterXianJieBt,self.onEnterXianJieBt)
end


function UIXianJieArenaAct_rankBgWin:__delete()
_this=nil
self:unbindComponents()
for win,v in pairs(self.winList)do
UIManager:closeWindow(win)
end
self.winList=nil
end




function UIXianJieArenaAct_rankBgWin:onShow(argtable,afterOnloaded)
local page=1
local isHideSettlement=false
if argtable then
if argtable.page then
page=argtable.page
end
if argtable.extraArgs then
self.extraArgs=argtable.extraArgs
end
if argtable.isHideSettlement~=nil then
isHideSettlement=argtable.isHideSettlement
end
end
self.showPageCfgList={}
self.pageLookup={}
for i,v in ipairs(pageConfig)do
local isShow=true
local checkShowFunc=v.checkShowFunc
if v.isSettlementWin and isHideSettlement then
isShow=false
else
if checkShowFunc then
isShow=checkShowFunc()
end
end

if isShow then
local idx=#self.showPageCfgList+1
self.showPageCfgList[idx]=v
self.pageLookup[v.page]=idx
end
end
local idx=self.pageLookup[page]
if afterOnloaded then
local cnt=#self.showPageCfgList
self.menuGridPanel:setChildLayoutGroupCreateItems(cnt)
local grids=self.menuGridPanel:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
local cfg=self.showPageCfgList[i]
item:SetChildText(1,cfg.name)
local isSelected=i==idx
local func=function()
if _this==nil then return end
if isSelected then
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,isSelected and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
end
item:SetChildUIModelShowTarget(2,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)
self:refreshMenuItemSelect(item,i,isSelected)
self:refreshMenuItemReddot(item,i)
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)
end
end
self:onMenuItemClick(idx)
end


function UIXianJieArenaAct_rankBgWin:onHide()

end

function UIXianJieArenaAct_rankBgWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end

if flag then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,flag and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UIXianJieArenaAct_rankBgWin:refreshMenuItemReddot(item,idx)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local cfg=self.showPageCfgList[idx]
local isReddot=cfg.checkReddot()
item:SetChildActive(3,isReddot)


end

function UIXianJieArenaAct_rankBgWin:refreshMenuReddot(page)
local idx=self.pageLookup[page]
self:refreshMenuItemReddot(nil,idx)
end

function UIXianJieArenaAct_rankBgWin:refreshAllMenuReddot()
for page,idx in pairs(self.pageLookup)do
self:refreshMenuItemReddot(nil,idx)
end
end

function UIXianJieArenaAct_rankBgWin:onMenuItemClick(idx)
local cfg=self.showPageCfgList[idx]
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

function UIXianJieArenaAct_rankBgWin:refreshMenuPage()
local idx=self.pageLookup[self.curPage]
local cfg=self.showPageCfgList[idx]
local win=cfg.win
if self.pagewin~=win and self.pagewin~=nil then
self:hideWindow(self.pagewin)
end
if win~=nil and win~=''then
self.winList[win]=true
self.pagewin=win
local args=self.extraArgs or{}
args.parentWin='UIXianJieArenaAct_rankBgWin'
args.page=self.curPage
self:showWindow(win,args)
end
end


function UIXianJieArenaAct_rankBgWin.onEnterXianJieBt()
if not _this then return end

_this:onClickClose()
end



function UIXianJieArenaAct_rankBgWin:onClickClose()
self:closeSelf()
end


function UIXianJieArenaAct_rankBgWin:changeExtraArgs(newArgs)
self.extraArgs=newArgs
end