







def_class("UILingzhenChongZhuWin",UIWindowBase)









function UILingzhenChongZhuWin:bindComponents()

self.underPanel2=UIObject.get(self,0)
self.underPanel=UIObject.get(self,1)
self.BtnSelectBefore=UIObject.get(self,2)
self.BtnSelectAfter=UIObject.get(self,3)
self.itemList=UIObject.get(self,4)
self.lattrs=UIObject.get(self,5)
self.emptyAfter=UIText.get(self,6)
self.rattrs=UIObject.get(self,7)
self.rattrRoot_4=UIObject.get(self,8)
self.rattrRoot_3=UIObject.get(self,9)
self.rattrRoot_2=UIObject.get(self,10)
self.rattrRoot_1=UIObject.get(self,11)
self.lattrRoot_4=UIObject.get(self,12)
self.lattrRoot_2=UIObject.get(self,13)
self.lattrRoot_1=UIObject.get(self,14)
self.lattrRoot_3=UIObject.get(self,15)
self.btnRefresh=UIButton.get(self,16)
self.btnRefresh2=UIButton.get(self,17)
self.btnSure=UIButton.get(self,18)
self.itemImage=UIImage.get(self,19)
self.add=UIObject.get(self,20)
self.itemImg=UIImage.get(self,21)
self.itembg=UIButton.get(self,22)
self.level=UIText.get(self,23)
self.btnRefresh3=UIButton.get(self,24)

self.btnRefresh:setButtonClick(function()self:onBtnRefresh()end)

self.btnRefresh2:setButtonClick(function()self:onBtnRefresh2()end)

self.btnSure:setButtonClick(function()self:onBtnSure()end)

self.itembg:setButtonClick(function()self:onItembg()end)

self.btnRefresh3:setButtonClick(function()self:onBtnRefresh3()end)
self.rattrRoot={
self.rattrRoot_1,
self.rattrRoot_2,
self.rattrRoot_3,
self.rattrRoot_4,
}
self.lattrRoot={
self.lattrRoot_1,
self.lattrRoot_2,
self.lattrRoot_3,
self.lattrRoot_4,
}



end


function UILingzhenChongZhuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.underPanel2);self.underPanel2=nil;
_UIObject_release(self.underPanel);self.underPanel=nil;
_UIObject_release(self.BtnSelectBefore);self.BtnSelectBefore=nil;
_UIObject_release(self.BtnSelectAfter);self.BtnSelectAfter=nil;
_UIObject_release(self.itemList);self.itemList=nil;
_UIObject_release(self.lattrs);self.lattrs=nil;
_UIObject_release(self.emptyAfter);self.emptyAfter=nil;
_UIObject_release(self.rattrs);self.rattrs=nil;
_UIObject_release(self.rattrRoot_4);self.rattrRoot_4=nil;
_UIObject_release(self.rattrRoot_3);self.rattrRoot_3=nil;
_UIObject_release(self.rattrRoot_2);self.rattrRoot_2=nil;
_UIObject_release(self.rattrRoot_1);self.rattrRoot_1=nil;
_UIObject_release(self.lattrRoot_4);self.lattrRoot_4=nil;
_UIObject_release(self.lattrRoot_2);self.lattrRoot_2=nil;
_UIObject_release(self.lattrRoot_1);self.lattrRoot_1=nil;
_UIObject_release(self.lattrRoot_3);self.lattrRoot_3=nil;
_UIObject_release(self.btnRefresh);self.btnRefresh=nil;
_UIObject_release(self.btnRefresh2);self.btnRefresh2=nil;
_UIObject_release(self.btnSure);self.btnSure=nil;
_UIObject_release(self.itemImage);self.itemImage=nil;
_UIObject_release(self.add);self.add=nil;
_UIObject_release(self.itemImg);self.itemImg=nil;
_UIObject_release(self.itembg);self.itembg=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.btnRefresh3);self.btnRefresh3=nil;
self.rattrRoot=nil;
self.lattrRoot=nil;
end



















function UILingzhenChongZhuWin:onLoaded(...)
self:bindComponents()
self.lockSlot={}
end


function UILingzhenChongZhuWin:__delete()
self:unbindComponents()
end




function UILingzhenChongZhuWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
local itemguid=argtable.itemguid
local yfguid=argtable.yfguid
local kongIndex=argtable.kongIndex
local openForm=argtable.openForm
self.openYfguid=yfguid

if openForm==1 then
self:showEmptyPanel()
else
if itemguid or(yfguid and kongIndex)then
self:selectLzId(itemguid,false,yfguid,kongIndex)
else
self:showEmptyPanel()
end
end


end


function UILingzhenChongZhuWin:onHide()

end


function UILingzhenChongZhuWin:showEmptyPanel()
self.itemImg:setActive(false)
self.itemImage:setActive(false)
self.add:setActive(true)
self.underPanel:setActive(false)
self.underPanel2:setActive(true)
end

function UILingzhenChongZhuWin:selectLzId(itemguid,playEffect,yufuGuid,kongIndex,keepLock)
if type(itemguid)=="string"then
itemguid=int64.zero
end
self.selectGuid=itemguid
self.yufuGuid=yufuGuid
self.kongIndex=kongIndex

if not keepLock then
self.lockSlot={}
end

self:refreshItem(itemguid,yufuGuid,kongIndex)
local chongZhuData=LingZhenChongZhuModel:getChongZhuEquipData(itemguid,yufuGuid,kongIndex)

self:refreshLeft(itemguid,playEffect,yufuGuid,kongIndex)

self.underPanel:setActive(true)
self.underPanel2:setActive(false)
if chongZhuData then
self.rattrs:setActive(true)
self.emptyAfter:setActive(false)
self.btnRefresh2:setActive(true)
self.btnSure:setActive(true)
self.btnRefresh:setActive(false)
self.btnRefresh3:setActive(true)
self:refreshRight(itemguid,playEffect,yufuGuid,kongIndex)
else
self.rattrs:setActive(false)
self.emptyAfter:setActive(true)
self.btnRefresh2:setActive(false)
self.btnSure:setActive(false)
self.btnRefresh:setActive(true)
self.btnRefresh3:setActive(false)
end
end

function UILingzhenChongZhuWin:refreshItem(itemguid,yufuGuid,kongIndex)
local item=UIYuFuLingZhenControl:getItem(itemguid,yufuGuid,kongIndex)

local itemid=item.itemid
if yufuGuid and kongIndex and kongIndex>0 then
itemid=item.itemId
end
local cfg=itemsConfig.getConfig(itemid)
local icon=UIYuFuLingZhenControl:getLZIconName(cfg)
self.itemImage:setActive(true)
self.itemImg:setActive(true)
self.itemImg:setCSImageSprite(globalABLookup.yufulingzhen,UIYuFuLingZhenControl:getPZIconName(cfg.color))
self.itemImage:setChildIcon(icon,true)

self.level:setText(cfg.level)
self.add:setActive(false)
end


function UILingzhenChongZhuWin:refreshLeft(itemguid,playEffect,yufuGuid,kongIndex)
itemguid=itemguid or self.selectGuid

local itemData=UIYuFuLingZhenControl:getItem(itemguid,yufuGuid,kongIndex)
local attrList
if yufuGuid and kongIndex and kongIndex>0 then
attrList=itemData.randAttrIdList
else
attrList=itemData.itemData.randAttrIdList
end


local chongZhuData=LingZhenChongZhuModel:getChongZhuEquipData(itemguid,yufuGuid,kongIndex)
local gudingData={}
local guingNum=0
local isChongChu=chongZhuData~=nil
if chongZhuData then
gudingData=chongZhuData.randAttrIdList2
if next(gudingData)then
for k,v in pairs(gudingData)do
guingNum=guingNum+1
for ii,vv in ipairs(attrList)do
if v==vv then
self.lockSlot[ii]=vv
end
end
end

else
if next(self.lockSlot)then
for i,v in ipairs(attrList)do
if self.lockSlot[i]then
guingNum=guingNum+1
gudingData[v]=i
end
end
end
end
else
if next(self.lockSlot)then
for i,v in ipairs(attrList)do
if self.lockSlot[i]then
guingNum=guingNum+1
gudingData[v]=i
end
end
end
end
self.guingNum=guingNum
self.gudingData=gudingData

self.gudingIdx={}

for i,widget in ipairs(self.lattrRoot)do
local attrId=attrList[i]
if attrId then
widget:setActive(true)
local aWidget=widget:getChildWidgetBase()
local isGuDing=gudingData[attrId]

local str=''
local attrCfg=cfgHelper.get1(cfg_yufuzhenturandattrconfig_get,attrId)

local diziAttrs=UIYuFuLingZhenControl:getDzAttrDesc(attrCfg)












if diziAttrs then
str=FMT.fmt('{0}{1}',str,diziAttrs)
end
aWidget:SetChildText(0,str)
if isGuDing then
self.gudingIdx[attrId]=i
aWidget:SetChildActive(3,true)
else
aWidget:SetChildActive(3,false)
end
aWidget:SetChildActive(2,(not isGuDing and self.guingNum~=2)and chongZhuData==nil)

aWidget:SetChildButtonClick(4,function()
if isChongChu then
return
end
self.gudingData[attrId]=nil
self.lockSlot[i]=nil
self.guingNum=self.guingNum-1
aWidget:SetChildActive(3,false)
for ii,w in ipairs(self.lattrRoot)do
local aId=attrList[ii]
local isGuDing=self.gudingData[aId]
local a=w:getChildWidgetBase()
if isGuDing then
a:SetChildActive(3,true)
else
a:SetChildActive(3,false)
a:SetChildActive(2,self.guingNum~=2 and chongZhuData==nil)
end
end
self:refreshCost()
end)
if self.guingNum~=2 then
aWidget:SetChildButtonClick(2,function()
if isChongChu then
return
end
if self.guingNum==2 then
UIManager.error("只能锁定2个属性")
return
end
self.lockSlot[i]=attrId
self.gudingData[attrId]=true
self.guingNum=self.guingNum+1

for ii,w in ipairs(self.lattrRoot)do
local aId=attrList[ii]
local isGuDing=self.gudingData[aId]
local a=w:getChildWidgetBase()
if isGuDing then
a:SetChildActive(3,true)
else
a:SetChildActive(3,false)
a:SetChildActive(2,self.guingNum~=2 and chongZhuData==nil)
end
end
self:refreshCost()
end)
end
if playEffect==2 then
aWidget:SetChildShowEffect(6,10503,true)
end
else
widget:setActive(false)

end
end
self:refreshCost()
end

function UILingzhenChongZhuWin:refreshRight(itemguid,playEffect,yufuGuid,kongIndex)
local chongZhuData=LingZhenChongZhuModel:getChongZhuEquipData(itemguid,yufuGuid,kongIndex)

local gudingData={}
if chongZhuData then
gudingData=chongZhuData.randAttrIdList2
end



local attrList=chongZhuData.randAttrIdList
local showList={}
for i,v in pairs(self.gudingIdx)do
showList[v]=i
end

for i,v in ipairs(attrList)do
if not self.gudingIdx[v]then
for ii=1,4 do
if not showList[ii]then
showList[ii]=v
break
end
end
end
end

for i,widget in ipairs(self.rattrRoot)do
local attrId=showList[i]
if attrId and not self.gudingIdx[attrId]then
widget:setActive(true)
local aWidget=widget:getChildWidgetBase()

local str=''
local attrCfg=cfgHelper.get1(cfg_yufuzhenturandattrconfig_get,attrId)

local diziAttrs=UIYuFuLingZhenControl:getDzAttrDesc(attrCfg)












if diziAttrs then
str=FMT.fmt('{0}{1}',str,diziAttrs)
end
aWidget:SetChildText(0,str)
if playEffect==1 then
aWidget:SetChildShowEffect(4,10503,true)
end
else
widget:setActive(false)
end
end
end

function UILingzhenChongZhuWin:refreshCost()
local cfg=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"xcChongZhuItems")
local freshCost=cfg[1]or{}

local lockNum=self.guingNum

if lockNum==1 then
freshCost=cfg[2]
elseif lockNum==2 then
freshCost=cfg[3]
end
local listNum=#freshCost
local costList={}
self.itemList:setChildLayoutGroupCreateItems(listNum)
local grids=self.itemList:getChildLayoutGroupGridList()
for i=1,listNum do
local grid=grids[i-1]
local item=freshCost[i]
local count=itemsModel.getCount(item[1])
local canBuy=count>=item[2]
local str=itemsConfig.isMoney(item[1])and item[2]or FMT.fmt("{0}/{1}",count,item[2])
local conf={itemid=item[1],itemcount=item[2]>0 and(canBuy and str or FMT.cfmt(FONT_COLOR.eRedColor,str))or'',showCountBG=item[2]>0,showname=false,gray=item[2]==0 and 1 or 0}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
grid:SetChildPropData(0,prop)
grid:SetChildActive(2,item[2]==0)
grid:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
table.insert(costList,item)
end
self.costList=costList
end





function UILingzhenChongZhuWin:onBtnRefresh()
local gudingList={}
for a,v in pairs(self.gudingData)do
table.insert(gudingList,a)
end
local cost={}
for i,v in ipairs(self.costList)do
cost[v[1]]=(cost[v[1]]or 0)+v[2]
end
for k,v in pairs(cost)do
local have=itemsModel.getCount(k)
if have<v then
local moneyName=itemsConfig.getItemName(k)
local err=FMT.fmt('{0}不足',moneyName)
UIManager.error(err)
gainControl:showGainWin(k)
return
end
end
local selectGuid=self.selectGuid
local dzId=int64.zero
if self.yufuGuid and self.kongIndex and self.kongIndex>0 then
dzId=UIFuLuFangModel:getDzGuidByItemGuid(self.yufuGuid)
selectGuid=int64.zero
end


socketManager:send_2_118(dzId,self.yufuGuid or int64.zero,self.kongIndex or 0,#gudingList,gudingList,selectGuid)




end



function UILingzhenChongZhuWin:onBtnRefresh2()


UIYuFuLingZhenControl.req_2_105(self.yufuGuid or int64.zero,self.selectGuid,self.kongIndex or 0)
end

function UILingzhenChongZhuWin:onBtnRefresh3()
self:onBtnRefresh()
end



function UILingzhenChongZhuWin:onBtnSure()
local selectGuid=self.selectGuid
local dzId=int64.zero
if self.yufuGuid and self.kongIndex and self.kongIndex>0 then
dzId=UIFuLuFangModel:getDzGuidByItemGuid(self.yufuGuid)
selectGuid=int64.zero
end
socketManager:send_2_119(dzId,self.yufuGuid or int64.zero,self.kongIndex or 0,selectGuid)
end



function UILingzhenChongZhuWin:onItembg()
self:showWindow("UIYFLZSelectWin",{index=6,yfGuid=self.yufuGuid or self.openYfguid,selectCallback=function(guid,yufuGuid,kongIndex)
self:selectLzId(guid,false,yufuGuid,kongIndex)end})
end

function UILingzhenChongZhuWin:onCloseClick()
self:closeSelf()
end
function UILingzhenChongZhuWin:onCloseBg()
self:closeSelf()
end