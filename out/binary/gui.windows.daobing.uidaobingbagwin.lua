







def_class("UIDaoBingBagWin",UIWindowBase)









function UIDaoBingBagWin:bindComponents()

self.root=UIObject.get(self,0)
self.tempTips=UIObject.get(self,1)
self.dropdown=UIDropdown.get(self,2)
self.sortBtn=UIButton.get(self,3)
self.dbtitle=UIObject.get(self,4)
self.dbCreater=UIObject.get(self,5)
self.sp1title=UIObject.get(self,6)
self.sp1Creater=UIObject.get(self,7)
self.sp2title=UIObject.get(self,8)
self.sp2Creater=UIObject.get(self,9)

self.sortBtn:setButtonClick(function()self:onSortBtn()end)



end


function UIDaoBingBagWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tempTips);self.tempTips=nil;
_UIObject_release(self.dropdown);self.dropdown=nil;
_UIObject_release(self.sortBtn);self.sortBtn=nil;
_UIObject_release(self.dbtitle);self.dbtitle=nil;
_UIObject_release(self.dbCreater);self.dbCreater=nil;
_UIObject_release(self.sp1title);self.sp1title=nil;
_UIObject_release(self.sp1Creater);self.sp1Creater=nil;
_UIObject_release(self.sp2title);self.sp2title=nil;
_UIObject_release(self.sp2Creater);self.sp2Creater=nil;
end

















local _sortNames={'战力','品质','星级','精炼等级'}
local _sortKey='daobingsortkey'
local _orderKey='daobingorderkey'
local _starIdx={7,8,9,10,11}

function UIDaoBingBagWin:onLoaded(...)
self:bindComponents()
self.dropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
self.sortType=userActorSetting.get(_sortKey,1)
self.sortOrder=userActorSetting.get(_orderKey,eSortOrder.eDown)
self:addNotify(notifyConfig.on_item_list_changed,function(...)self:onItemsChanged(...)end)
end

function UIDaoBingBagWin:__delete()
self:unbindComponents()
end

function UIDaoBingBagWin:onShow(argtable,afterOnloaded)
self:initListPanel()
self:initDropdown()
end

function UIDaoBingBagWin:onHide()

end




function UIDaoBingBagWin:onItemsChanged(argsTable)
local hasDaoBing=false
local hasSuiPian=false
for i,v in ipairs(argsTable)do
hasDaoBing=hasDaoBing or itemsConfig.isDaoBing(v[3])
hasSuiPian=hasSuiPian or itemsConfig.isDaoBingMaterials(v[3])
end
if hasDaoBing then
self:freshDaoBing()
end
if hasSuiPian then
self:freshSuiPian()
end
local len=#self.sp1list+#self.sp2list+#self.dblist
self.tempTips:setActive(len==0)
end


function UIDaoBingBagWin:initListPanel()
self:freshDaoBing()
self:freshSuiPian()
local len=#self.sp1list+#self.sp2list+#self.dblist
self.tempTips:setActive(len==0)
end

function UIDaoBingBagWin:freshSuiPian()
local filter={}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eDaoBingMaterials
local splist=bagControl.getBagItemsByFilter(BAG_TYPE.eDaoBingBag,filter,false)

local sp1list={}
local sp2list={}
local itemids={}
for i,v in ipairs(splist)do
if not itemids[v.itemid]then
itemids[v.itemid]=true
local ret=daobingHelper.isCanCombine(v.itemid)
if ret then
sp1list[#sp1list+1]=v
else
sp2list[#sp2list+1]=v
end
end
end
sp1list=self:sortSuiPian(sp1list)
local sp1len=#sp1list
self.sp1list=sp1list
self.sp1title:setActive(sp1len>0)
local func=function(idx)
local item=self.sp1Creater:getChildLayoutGroupGridItem(idx-1)
self:freshSpItem(sp1list[idx],item,idx)
end
self.sp1Creater:setChildLayoutGroupCreateItems(sp1len,func)

sp2list=self:sortSuiPian(sp2list)
local sp2len=#sp2list
self.sp2list=sp2list
self.sp2title:setActive(sp2len>0)
local func=function(idx)
local item=self.sp2Creater:getChildLayoutGroupGridItem(idx-1)
self:freshSpItem(sp2list[idx],item,idx)
end
self.sp2Creater:setChildLayoutGroupCreateItems(sp2len,func)
end

function UIDaoBingBagWin:freshDaoBing()

local filter={}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eDaoBing
local dblist=bagControl.getBagItemsByFilter(BAG_TYPE.eDaoBingBag,filter,false)
local list=daobingModel:getAllEquip()
dblist=table.concatTableX(dblist,list)
dblist=self:sortDaoBing(dblist)
local dblen=#dblist
self.dblist=dblist
self.dbtitle:setActive(dblen>0)
local func=function(idx)
local item=self.dbCreater:getChildLayoutGroupGridItem(idx-1)
self:freshDaobingItem(item,idx)
end
self.dbCreater:setChildLayoutGroupCreateItems(dblen,func)
end

function UIDaoBingBagWin:freshDaobingItem(item,idx)
local itemInfo=self.dblist[idx]
local itemid=itemInfo.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local itemguid=itemInfo.itemguid
local star=daobingModel:getStarLv(itemguid)
local dzguid=daobingModel:getDiziguidByItemguid(itemguid)
local hasEquiped=dzguid~=nil
local jjlv=daobingModel:getJilianLv(itemguid)
local name=itemCfg.name
local isMaxStar=daobingHelper.isMaxStarByGUID(itemguid)
local iconName=isMaxStar and iconHelper.getDaobingBigBgIcon(itemCfg.icon)or
iconHelper.getDaobingBigIcon(itemCfg.icon)
if jjlv>0 then
name=FMT.fmt('{0}{1}',name,FMT.cfmt(FONT_COLOR.eGreenColor,'+{0}',jjlv))
end

item:SetChildCSImageSprite(0,globalABLookup.daobingBagSprite,daobingConfig.getColorBg(itemCfg.color))

item:SetChildIcon(1,iconName,true)

item:SetChildText(2,name)

item:SetChildButtonClick(3,function()
self:onItemClick(idx)
end)

item:SetChildStarNumber(4,star)

item:SetChildActive(6,hasEquiped)

if hasEquiped then
comHelper.setChildModelHeadIconBG(item,6,dzguid)
comHelper.setChildModelRawImage(item,dzguid,5,0,eHeadCenterType.eHead,0.6)
end
end

function UIDaoBingBagWin:freshSpItem(itemInfo,item,idx)
local itemid=itemInfo.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local itemguid=itemInfo.itemguid
local num=itemInfo.itemcount
local numStr=num>1 and num or''

local conf={itemid=itemid,
itemcount=numStr,
showCountBG=num>1,
showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
local itemWidget=item:GetChildWidgetBase(0)
itemsComponentHelper.setUIBaseItemSmallSign(itemWidget,conf)

item:SetChildText(3,itemsConfig.getItemName(itemid))

item:SetChildActive(1,true)
local cur=bagModel.getItemCountById(itemid)
local max=itemCfg.piece[2]
item:SetChildProgressText(1,string.format('%d/%d',cur,max))
if cur>max then cur=max end
item:SetChildProgressValue(1,cur,max)

item:SetChildButtonClick(2,function()
self:onSpItemClick(itemInfo,idx)
end)

local ret=daobingHelper.isCanCombine(itemid)
item:SetChildActive(4,ret)
end

function UIDaoBingBagWin:onSpItemClick(itemInfo,idx)
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid
tipsManager.showTips({formType=TIPS_FORM_TYPE.eDaoBingBagGrids,
itemid=itemid,
itemguid=itemguid})
end

function UIDaoBingBagWin:onItemClick(idx)
local itemInfo=self.dblist[idx]
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid
tipsManager.showTips({formType=TIPS_FORM_TYPE.eDaoBingBagGrids,
itemid=itemid,
itemguid=itemguid})
end

function UIDaoBingBagWin:initDropdown()
self.dropdown:setOption(_sortNames)

self.dropdown:setValue(self.sortType-1)
end

function UIDaoBingBagWin:onDropdownChange(idx)
idx=idx+1
if self.sortType==idx then return end
self.sortType=idx
userActorSetting.flushVal(_sortKey,idx)
self:initListPanel()
end

function UIDaoBingBagWin:onSortBtn()
if self.sortOrder==eSortOrder.eDown then
self.sortOrder=eSortOrder.eUp
else
self.sortOrder=eSortOrder.eDown
end
userActorSetting.flushVal(_orderKey,self.sortOrder)
self:initListPanel()
end

function UIDaoBingBagWin:sortDaoBing(list)
return daobingHelper.sortDaoBing(list,self.sortType,self.sortOrder)
end

function UIDaoBingBagWin:sortSuiPian(list)
local sortTag={}
for i,v in ipairs(list)do
local color=itemsConfig.getConfig(v.itemid).color
sortTag[v.itemid]=color*100000+i
end

table.sort(list,function(a,b)
return sortTag[a.itemid]>sortTag[b.itemid]
end)
return list
end

function UIDaoBingBagWin:onChangItemRet(itemguid)
for i,v in ipairs(self.dblist)do
if tostring(v.itemguid)==tostring(itemguid)then
local item=self.dbCreater:getChildLayoutGroupGridItem(i-1)
if item then
self:freshDaobingItem(item,i)
end
return
end
end
end
