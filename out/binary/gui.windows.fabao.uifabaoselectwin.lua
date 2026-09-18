







def_class("UIFabaoSelectWin",UIWindowBase)









function UIFabaoSelectWin:bindComponents()

self.Contect=UIObject.get(self,0)
self.title=UIText.get(self,1)



end


function UIFabaoSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Contect);self.Contect=nil;
_UIObject_release(self.title);self.title=nil;
end


















function UIFabaoSelectWin:onLoaded(...)
self:bindComponents()
self.useItemIdx={}
self:addNotify(notifyConfig.onItemUse,function(...)self:onItemUse(...)end)
self:addNotify(notifyConfig.on_item_list_changed,function(...)self:on_item_list_changed(...)end)
end

function UIFabaoSelectWin:__delete()
self:unbindComponents()
end

function UIFabaoSelectWin:onShow(argtable,afterOnloaded)
local itemguid=argtable.itemguid
local itemexp=fabaoConfig.getlxConstConfig().itemexp
self.itemexp=itemexp
self.itemguid=itemguid
local list={}
for itemid,_ in pairs(itemexp)do
local len=#list
list[#list+1]={itemid=itemid,i=len}
end
table.sort(list,function(a,b)
local a_color=itemsConfig.getConfig(a.itemid).color
local b_color=itemsConfig.getConfig(b.itemid).color
return a_color*100<b_color*100
end)

local title=argtable.title
local len=#list
self.Contect:setChildLayoutGroupCreateItems(len,function(i)
local widget=self.Contect:getChildLayoutGroupGridItem(i-1)
local item=list[i]
local itemid=item.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local has=itemsModel.getCount(itemid)
local color=itemCfg.color
local count=itemexp[itemid]
local name=itemCfg.name
self.useItemIdx[itemid]=i

local cb=function(idx)
self:onUseClick(idx,itemid)
end


widgetHelper.setItemQulaity(widget,itemid,0)
widget:SetChildImageExGray(0,has<=0)
widget:SetChildIcon(1,iconHelper.getIconName(itemid),false)
widget:SetChildButtonClick(1,function()
tipsManager.showTips({itemid=itemid})
end)
widget:SetChildImageExGray(1,has<=0)
widget:SetChildText(2,name)
widget:SetChildText(3,FMT.fmt('灵性+{0}',count))
widget:SetChildLongPress(7,i,cb,nil)
widget:SetChildActive(5,has>1)
widget:SetChildText(6,has>1 and has or'')
end)

self.title:setText(title or'')
end

function UIFabaoSelectWin:onHide()

end



function UIFabaoSelectWin:on_item_list_changed(argstable)
local lastList={}
local hasList={}
for i,v in ipairs(argstable)do
local itemid=v[3]
if self.useItemIdx[itemid]then
if not lastList[itemid]then
lastList[itemid]=0
end
if not hasList[itemid]then
hasList[itemid]=0
end
lastList[itemid]=lastList[itemid]+v[4]
hasList[itemid]=hasList[itemid]+v[5]
end
end
for itemid,v in pairs(lastList)do
local last=lastList[itemid]
local has=hasList[itemid]
local use=last-has
if use>0 then
UIManager.info(FMT.fmt('灵性值增加{0}点',use*self.itemexp[itemid]))
local idx=self.useItemIdx[itemid]
local widget=self.Contect:getChildLayoutGroupGridItem(idx-1)
local curhas=itemsModel.getCount(itemid)
widget:SetChildImageExGray(0,curhas<=0)
widget:SetChildImageExGray(1,curhas<=0)
widget:SetChildActive(5,curhas>1)
widget:SetChildText(6,curhas>1 and curhas or'')
end
end
end

function UIFabaoSelectWin:useTest(itemid,num)
fabaoProtocolControl.reqUseLingXingItem(self.itemguid,itemid,num)
end

function UIFabaoSelectWin:checkUse(itemguid,itemid)
local has=itemsModel.getCount(itemid)
if has==0 then
local name=itemsModel.getName(itemid)
UIManager.error(FMT.fmt('{0}数量不足',name))
UIManager:closeWindow('UICommonPageWin')
gainControl:showGainWin(itemid)
return false
end

local equip=fabaoHelper.getFabao(itemguid)
local isDressSelf=benMingFaBaoHelper.isDressSelf(equip)
if not isDressSelf then
local dressdz=fabaoModel.getDiziguidByItemguid(itemguid)
if dressdz then
UIManager.error('非主人穿戴,无法增加灵性')
else
UIManager.error('尚未穿戴，无法增加灵性')
end
return false
end

local left=fabaoModel.getLeftAddExp(itemguid)
if left<=0 then
UIManager.error('灵性值已达储存上限')
return false
end
local maxNum=math.ceil(left/self.itemexp[itemid])
return true,maxNum
end

function UIFabaoSelectWin:onUseClick(idx,itemid)
local flag,maxNum=self:checkUse(self.itemguid,itemid)
if not flag then
if not self or self.isClose then return end
self:stopItemLongPress(idx)
return
end
local num=1
if self.useGoodTime~=nil then
local cur=Time.realtimeSinceStartup
local lerp=cur-self.useGoodTime
if lerp>=3 then
num=10
elseif lerp>=2 then
num=5
end
else
self.useGoodTime=Time.realtimeSinceStartup
end
local max=itemsModel.getCount(itemid)
if num>max then
num=max
end
if num>maxNum then
num=maxNum
end
self.useItemID=itemid
fabaoProtocolControl.reqUseLingXingItem(self.itemguid,itemid,num)
end

function UIFabaoSelectWin:stopItemLongPress(idx)
local widget=self.Contect:getChildLayoutGroupGridItem(idx-1)
if widget then
widget:SetChildLongPressStop(7)
end
end