







def_class("UIYFLTSelectPlantMain",UIWindowBase)









function UIYFLTSelectPlantMain:bindComponents()

self.jumptxt=UILinkImageText.get(self,0)
self.List2=UIObject.get(self,1)
self.prepareRoot=UIObject.get(self,2)
self.previewItem=UIObject.get(self,3)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,4)
self.selecttipsbg=UIObject.get(self,5)
self.selecttipsbg2=UIObject.get(self,6)



end


function UIYFLTSelectPlantMain:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.jumptxt);self.jumptxt=nil;
_UIObject_release(self.List2);self.List2=nil;
_UIObject_release(self.prepareRoot);self.prepareRoot=nil;
_UIObject_release(self.previewItem);self.previewItem=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
_UIObject_release(self.selecttipsbg);self.selecttipsbg=nil;
_UIObject_release(self.selecttipsbg2);self.selecttipsbg2=nil;
end















local UIYFLTSelectPlantEnScroller=simple_class(UIEnhancedScroller)



function UIYFLTSelectPlantMain:onLoaded(...)
self:bindComponents()

self.enhancedscrollscript=UIYFLTSelectPlantEnScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self

local _onDragBegin=function(index,pos)
self:onDragBegin(index,pos)
end
local _onDragEnd=function(index,pos)
self:onDragEnd(index,pos)
end
self.winlua:SetChildUIDragEvent(self.List2:getID(),0,_onDragBegin,_onDragEnd,nil)
end


function UIYFLTSelectPlantMain:__delete()
self:unbindComponents()
end




function UIYFLTSelectPlantMain:onShow(argtable,afterOnloaded)
UIManager:showWindow("UIYiFangLingTianMain",argtable)
self.itemlist={}
self.isDrag=false
local cfg=cfg_yifanglintianconfig()
for k,v in pairs(cfg)do
table.insert(self.itemlist,v.id)
end
self.mapWin=UIManager:findActiveWindow("UIYFLTMapWin")
self:Refresh(true)
end


function UIYFLTSelectPlantMain:onHide()

end

function UIYFLTSelectPlantMain:Refresh(init)
local filter={}
filter[ITEM_FILTER_TYPE.eItemid]={ITEM_FILTER_COMPARE.eEquals,self.itemlist}
self.itemDatas=bagControl.getBagItemsByFilter(BAG_TYPE.eItemBag,filter,false,false)
local mylv=playerModel:getActorLevel()
table.sort(self.itemDatas,function(a,b)
local acfg=itemsConfig.getConfig(a.itemid)
local bcfg=itemsConfig.getConfig(b.itemid)
local a_needlv=cfgHelper.get2(cfg_yifanglintianconfig_get,a.itemid,'need_level')
local b_needlv=cfgHelper.get2(cfg_yifanglintianconfig_get,b.itemid,'need_level')

if a_needlv<=mylv and b_needlv>mylv then
return true
elseif a_needlv>mylv and b_needlv<=mylv then
return false
end

if bcfg.color>acfg.color then
return false
elseif bcfg.color<acfg.color then
return true
end
return a.itemid<b.itemid
end)
local isChangedNum=self.max and self.max~=#self.itemDatas
self.max=#self.itemDatas
self:refreshList(init,isChangedNum)
end


function UIYFLTSelectPlantMain:refreshList(init,isChangedNum)
if init then
self.enhancedscrollscript:initData(self.itemDatas,127,self.max)
else
if isChangedNum then
self.enhancedscrollscript:initData(self.itemDatas,127,self.max)
else
self.enhancedscrollscript:doRefreshActiveCellViews()
end
end





local link=FMT.fmt("点击“<a;获取种子;{0};1;20,0;/>”",FONT_COLOR.eWhiteColor)
self.jumptxt:setText(link)
self.jumptxt:setActive(self.max<=0)

local gzflag=YiFangLingTianController:checkAnyPlantMatched()
self.selecttipsbg:setActive(self.max>0 and gzflag)
end

function UIYFLTSelectPlantMain:revertPosition()
if self.idx then
local temp_cell=self.enhancedscrollscript:GetCell(self.idx-1)
if temp_cell then
local item=temp_cell:GetChildWidgetBase(0)
item:SetChildLocalPosition(11,Vector3(0,0,0))
item:SetChildActive(12,false)
end
self.idx=nil
end
local gzflag=YiFangLingTianController:checkAnyPlantMatched()
self.selecttipsbg:setActive(self.max>0 and gzflag)
self.selecttipsbg2:setActive(false)
end

function UIYFLTSelectPlantMain:refreshActiveCellViews()
self.enhancedscrollscript:doRefreshActiveCellViews()
end

function UIYFLTSelectPlantEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIYFLTSelectPlantEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end


function UIYFLTSelectPlantEnScroller:RefreshCell(dataIndex,cellIndex,cell)
local item=cell:GetChildWidgetBase(0)
if not self.window or self.window.isClose then
return
end
local idx=dataIndex
local itemdata=self.window.itemDatas[idx]
if itemdata then
item:SetChildActive(10,true)
local itemid=itemdata.itemid
local item_config=itemsConfig.getConfig(itemid)
local itemName=item_config.name
local itemnum=itemdata.itemcount
local itemcount,showCountBG
if itemnum>1 then
itemcount=mathHelper.formatNumber(itemnum,false)
showCountBG=true
else
itemcount=1
showCountBG=true
end

local needlv=cfgHelper.get2(cfg_yifanglintianconfig_get,itemid,'need_level')
local mylv=playerModel:getActorLevel()
item:SetChildImageExGray(0,mylv<needlv)
item:SetChildImageExGray(1,mylv<needlv)

local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)


item:SetChildPropData(-1,prop)

item:SetChildLocalPosition(11,self.window.idx==idx and Vector3(0,10,0)or Vector3(0,0,0))
item:SetChildActive(12,self.window.idx==idx)


item:SetBaseItemLongTouchEvent(-1,function(...)
tipsManager.showTips({formType=TIPS_FORM_TYPE.eYFLTBag,
itemid=itemid,
showModel=true,
backType=TIPS_BACK_TYPE.eBag,
itemguid=itemdata.itemguid,
attach={}})
end)
item:SetBaseItemClickEvent(-1,function(...)

local dzid=YiFangLingTianModel:GetNowDzID()
if tostring(dzid)=='0'then
UIManager.info("请先安排弟子")
return
end
if mylv<needlv then
UIManager.info(string.format("宗门%d级才可使用该种子",needlv))
return
end

if self.window.idx then
local temp_cell=self:GetCell(self.window.idx-1)
if temp_cell then
local item=temp_cell:GetChildWidgetBase(0)
item:SetChildLocalPosition(11,Vector3(0,0,0))
item:SetChildActive(12,false)
end
end

self.window.idx=idx
item:SetChildLocalPosition(11,Vector3(0,10,0))
item:SetChildActive(12,true)
UIManager:invokeUIMethod("UIYFLTMapWin","preparePlanting",itemid)
UIManager:invokeUIMethod("UIYiFangLingTianMain","onCloseBySelect")
self.window.selecttipsbg:setActive(false)
self.window.selecttipsbg2:setActive(true)
end)
item:SetChildText(4,itemName)
else
item:SetChildActive(10,false)
end
end

function UIYFLTSelectPlantEnScroller:onItemBeginDrag(dataIndex,screenPos,cell)
if not self.window or self.window.isClose or not self.window.mapWin then
return
end
UIManager:invokeUIMethod("UIYFLTMapWin","enableDrag",false)
local dzid=YiFangLingTianModel:GetNowDzID()
if tostring(dzid)=='0'then
return
end
local itemdata=self.window.itemDatas[dataIndex+1]
local itemid=itemdata.itemid
local needlv=cfgHelper.get2(cfg_yifanglintianconfig_get,itemid,'need_level')
local mylv=playerModel:getActorLevel()
if mylv<needlv then
return
end
self.window.isDrag=true

local widget=self.window.previewItem:getChildWidgetBase(-1)
local color=itemsConfig.getItemColor(itemid)
local iconName=iconHelper.getIconName(itemid)
widget:SetChildQulaity(0,color)
widget:SetChildCSImageIcon(1,iconName,false)
self.window.previewItem:setChildUIScreenPos(screenPos)
self.window.previewItem:setActive(true)
end

function UIYFLTSelectPlantEnScroller:onItemDrag(dataIndex,screenPos)
if not self.window.isDrag then
return
end
dataIndex=dataIndex+1
local dragIndex=self.window.mapWin:convertPos2GridIdx(screenPos)

local itemdata=self.window.itemDatas[dataIndex]
local itemid=itemdata.itemid
if dragIndex then
if not self.isDragDone then
self.window.previewItem:setActive(false)
end
self.isDragDone=dragIndex

if self.window.idx and self.window.idx~=dataIndex then
local temp_cell=self:GetCell(self.window.idx-1)
if temp_cell then
local item=temp_cell:GetChildWidgetBase(0)
item:SetChildLocalPosition(11,Vector3(0,0,0))
item:SetChildActive(12,false)
end
end

self.window.idx=dataIndex
local temp_cell=self:GetCell(self.window.idx-1)
if temp_cell then
local item=temp_cell:GetChildWidgetBase(0)
item:SetChildLocalPosition(11,Vector3(0,10,0))
item:SetChildActive(12,true)
end
UIManager:invokeUIMethod("UIYiFangLingTianMain","onCloseBySelect")
self.window.selecttipsbg:setActive(false)
self.window.selecttipsbg2:setActive(true)

UIManager:invokeUIMethod("UIYFLTMapWin","preparePlanting",itemid,false,dragIndex)
elseif not self.isDragDone then
self.window.previewItem:setChildUIScreenPos(screenPos)
end
end

function UIYFLTSelectPlantEnScroller:onItemEndDrag(dataIndex,screenPos,cell)
UIManager:invokeUIMethod("UIYFLTMapWin","enableDrag",true)
self.window.isDrag=false
self.isDragDone=nil
self.window.previewItem:setActive(false)
end


function UIYFLTSelectPlantMain:onDragBegin(index,pos)
UIManager:invokeUIMethod("UIYFLTMapWin","enableDrag",false)
end

function UIYFLTSelectPlantMain:onDragEnd(index,pos)
UIManager:invokeUIMethod("UIYFLTMapWin","enableDrag",true)
end