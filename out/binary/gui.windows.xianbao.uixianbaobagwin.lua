







def_class("UIXianBaoBagWin",UIWindowBase)









function UIXianBaoBagWin:bindComponents()

self.root=UIObject.get(self,0)
self.creater=UIObject.get(self,1)
self.empty=UIObject.get(self,2)



end


function UIXianBaoBagWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.creater);self.creater=nil;
_UIObject_release(self.empty);self.empty=nil;
end


















local _this=nil

function UIXianBaoBagWin:onLoaded(...)
self:bindComponents()
self:addNotify(notifyConfig.on_item_list_changed,function(...)self:onItemsChanged(...)end)
_this=self
end


function UIXianBaoBagWin:__delete()
self:unbindComponents()
_this=nil
end

function UIXianBaoBagWin:doFadeIn(delay,duration)
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,duration,nil)
end
if delay>0 then
self:delayDo(delay,func)
else
func()
end
end




function UIXianBaoBagWin:onShow(argtable,afterOnloaded)
self.isShow=true
self:doFadeIn(0,1)
self.targertXbId=argtable and argtable.xbid
local func=function()
self:initXBListPanel()
end
if afterOnloaded then
self:delayDo(0.01,func)
else
func()
end

end

function UIXianBaoBagWin:onShowArgRecv(argtable)
self.isShow=true
self:initXBListPanel()
end

function UIXianBaoBagWin:getXBList(compare)
local bagList=bagControl.getBagItemsByFilter(BAG_TYPE.eXianBao,{},true,false)or{}
local xianbaolist={}
local xbId,xbCfg,type,itemid,num
local tempList={}
for i,v in ipairs(bagList)do
itemid=v.itemid
num=v.itemcount
xbId=xianbaoConfig.getXBId(itemid)
xbCfg=xianbaoConfig.getXBCfg(xbId)
type=xbCfg.type
type=1
if not tempList[type]then
local temp={}
temp.typo=type
temp.title="激活道具"
temp.childlist={}
tempList[type]=temp
table.insert(xianbaolist,temp)
end
local subTemp={}
subTemp.id=xbId
subTemp.icon=xbCfg.icon
subTemp.color=xbCfg.color
subTemp.name=xbCfg.name
subTemp.num=num
subTemp.itemid=itemid
table.insert(tempList[type].childlist,subTemp)
end

self.maxPageIndex=0
self.maxPageNum=0
self.jumpPageIndex=0
self.jumpPageNum=0
for pageidx,pageData in ipairs(xianbaolist)do
local n=#pageData.childlist
if n>self.maxPageNum then
self.maxPageIndex=pageidx
self.maxPageNum=n
end
if self.jumpPageIndex==0 then
for childidx,xbCfg in ipairs(pageData.childlist)do
local xbid=xbCfg.id
if self.targertXbId==xbid then
self.jumpPageIndex=pageidx
self.jumpPageNum=childidx
break
end
end
end
end

if compare and self.xianbaolist then
for k,v in pairs(xianbaolist)do
if self.xianbaolist[k]then
if#self.xianbaolist[k].childlist~=#v.childlist then
self.xianbaolist=xianbaolist
return true
end
else
self.xianbaolist=xianbaolist
return true
end
end
return false
end
self.xianbaolist=xianbaolist
return true
end

function UIXianBaoBagWin:initXBListPanel(jump,compare)
local compareRes=self:getXBList(compare)
if not compareRes then
return
end
local pagenum=#self.xianbaolist
if pagenum<=0 then
self.empty:setActive(true)
self.creater:setChildLayoutGroupClearAllItems()
return
end
self.empty:setActive(false)
local func=function(idx)
local item=self.creater:getChildLayoutGroupGridItem(idx-1)
self:refreshPageItem(item,idx,jump)
end
self.creater:setChildLayoutGroupCreateItems(pagenum,func)
end

function UIXianBaoBagWin:refreshPageItem(item,pageidx,check)
local pageData=self.xianbaolist[pageidx]
local pageType=pageData.typo
local name_str=pageData.title
item:SetChildText(0,name_str)
local childnum=#pageData.childlist
local func=function(idx)
local childItem=item:GetChildLayoutGroupGridItem(1,idx-1)
childItem:SetChildButtonClick(2,function()
self:onChildItemClick(pageidx,idx)
end)
self:refreshChildItem(childItem,pageidx,idx)
if check then
self:checkRefreshFinish(pageidx,idx)
end



end
item:SetChildLayoutGroupCreateItems(1,childnum,func)
end

function UIXianBaoBagWin:onChildItemClick(pageidx,childidx)
local pageData=self.xianbaolist[pageidx]
local xbCfg=pageData.childlist[childidx]
local xbid=xbCfg.id
local itemid=xbCfg.itemid
tipsManager.showTipsXB({attach={xbItemId=itemid},formType=TIPS_FORM_TYPE.eXianBaoBag,tipsType=TIPS_TYPE.eCommonXianBao,itemid=xbid,bg=false,funType=TIPS_FUNC_TYPE.eXianBao})
end

function UIXianBaoBagWin:refreshChildItem(item,pageidx,childidx)
local pageData=self.xianbaolist[pageidx]
local pageType=pageData.typo
local xbCfg=pageData.childlist[childidx]
local xbid=xbCfg.id
local itemid=xbCfg.itemid
local num=xbCfg.num
local num_str
local showCountBG
if num>1 then
num_str=tostring(num)
showCountBG=true
else
num_str=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=num_str,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
local itemWidget=item:GetChildWidgetBase(0)
itemsComponentHelper.setUIBaseItemSmallSign(itemWidget,conf)

local name_str=itemsConfig.getItemName(itemid)

item:SetChildText(3,name_str)

local showProgress=false
item:SetChildActive(1,showProgress)








local reddot=false




item:SetChildActive(4,reddot)
end


function UIXianBaoBagWin:checkRefreshFinish(pageidx,childidx)
if self.maxPageIndex==0 then return end

if pageidx==self.maxPageIndex and childidx==self.maxPageNum and self.jumpPageIndex~=0 then

local pos=self.creater:getChildLocalPosition()
if pos.y<1 then
self:jumpRedItem()
end
end
end


function UIXianBaoBagWin:jumpRedItem()
local func=function()
local pageItem=self.creater:getChildLayoutGroupGridItem(self.jumpPageIndex-1)
local childItem=pageItem:GetChildLayoutGroupGridItem(1,self.jumpPageNum-1)
local sp=childItem:GetChildUIScreenPos(-1,false)
local sp_=Vector2(sp.x,sp.y)
local lp=self.creater:getChildUIScreenPos2Local(sp_)
local moveY=-lp.y-85

if moveY>=200 then
self.creater:setChildDOLocalMoveY(moveY,0.2,nil)
end
end
self:delayDo(0.1,func)
end

function UIXianBaoBagWin:onHide()
self.isShow=false
end

function UIXianBaoBagWin:onItemsChanged(itemList)
if not self.isShow then
return
end
for i,v in ipairs(itemList)do
local itmeid=v[3]
if xianbaoConfig.isXianbaoActiveItemEx(itmeid)then
self:initXBListPanel(false,true)
return
end
end
end



