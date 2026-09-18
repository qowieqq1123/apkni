







def_class("UIFabaoJingHuaSelectWin",UIWindowBase)









function UIFabaoJingHuaSelectWin:bindComponents()

self.Contect=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.putBtn=UIButton.get(self,2)
self.resetBtn=UIButton.get(self,3)

self.putBtn:setButtonClick(function()self:onPutBtn()end)

self.resetBtn:setButtonClick(function()self:onResetBtn()end)



end


function UIFabaoJingHuaSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Contect);self.Contect=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.putBtn);self.putBtn=nil;
_UIObject_release(self.resetBtn);self.resetBtn=nil;
end


















function UIFabaoJingHuaSelectWin:onLoaded(...)
self:bindComponents()
self.additem={}
end

function UIFabaoJingHuaSelectWin:__delete()
self:unbindComponents()
tipsManager.closeTips()
end

function UIFabaoJingHuaSelectWin:onShow(argtable,afterOnloaded)
local itemguid=argtable.itemguid
if itemguid then
self.itemid=bagModel.getItem(itemguid).itemid
end
self.mainitemid=argtable.mainitemid
self.putlist=argtable.putlist
self.selectCB=argtable.selectCB
self:freshInfo()
end

function UIFabaoJingHuaSelectWin:onHide()

end



function UIFabaoJingHuaSelectWin:freshInfo()
local ids=table.deepCopy(fabaoConfig.getJingHuaIds())
local cfgs=fabaoConfig.getJingHuaCfg()
table.sort(ids,function(a,b)
return itemsConfig.getConfig(a).color>itemsConfig.getConfig(b).color
end)
local len=#ids
self.ids=ids
local stage=itemsConfig.getConfig(self.mainitemid).stage
self.Contect:setChildLayoutGroupCreateItems(len,function(i)
local widget=self.Contect:getChildLayoutGroupGridItem(i-1)
local itemid=ids[i]
local itemCfg=itemsConfig.getConfig(itemid)
local color=itemCfg.color
local name=itemCfg.name
local desc=itemCfg.desc2 or''
local isput=tostring(self.itemid)==tostring(itemid)
if isput then
self.selectIdx=i
end
local need=cfgs[itemid][1][stage]
local has=itemsModel.getCount(itemid)
if self.putlist then
local put=self.putlist[itemid]or 0
has=has-put
end
local left=has-(self.additem[itemid]or 0)
local enough=left>=need
local countTxt=enough and FMT.fmt('{0}/{1}',left,need)or
FMT.cfmt(FONT_COLOR.eRedColor,'{0}/{1}',left,need)
widgetHelper.setItemQulaity(widget,itemid,0)
widget:SetChildIcon(1,iconHelper.getIconName(itemCfg.icon),false)
widget:SetChildButtonClick(1,function()
tipsManager.showTips({itemid=itemid})
end)
widget:SetChildText(2,name)
widget:SetChildText(3,desc)
widget:SetChildButtonClick(4,function()
if self.selectIdx==i then return end
self:onSelect(itemid,i)
end,true)
widget:SetChildActive(5,isput)
widget:SetChildActive(6,isput)
widget:SetChildActive(7,true)
widget:SetChildText(8,countTxt)
widget:SetChildActive(9,not enough)


end)
end

function UIFabaoJingHuaSelectWin:onPut(itemid,i)
local oldidx=self.selectIdx
self.selectIdx=i
self.itemid=itemid
if oldidx then
local widget=self.Contect:getChildLayoutGroupGridItem(oldidx-1)
widget:SetChildActive(5,false)
widget:SetChildActive(6,false)
end
local widget=self.Contect:getChildLayoutGroupGridItem(i-1)
widget:SetChildActive(5,true)
widget:SetChildActive(6,true)
end

function UIFabaoJingHuaSelectWin:onSelect(itemid,i)
if self.selectIdx==i then return end
local oldidx=self.selectIdx
self.selectIdx=i
self.itemid=itemid
if oldidx then
local widget=self.Contect:getChildLayoutGroupGridItem(oldidx-1)
widget:SetChildActive(5,false)
widget:SetChildActive(6,false)
end
local widget=self.Contect:getChildLayoutGroupGridItem(i-1)
widget:SetChildActive(5,true)
widget:SetChildActive(6,true)
end

function UIFabaoJingHuaSelectWin:onPutBtn()
local itemid=self.itemid
if itemid==nil then
UIManager.error('请选择精华')
return
end
local cfgs=fabaoConfig.getJingHuaCfg()
local stage=itemsConfig.getConfig(self.mainitemid).stage
local need=cfgs[itemid][1][stage]
local has=itemsModel.getCount(itemid)
if self.putlist then
local put=self.putlist[itemid]or 0
has=has-put
end
local enough=has>=need

if not enough then
gainControl:showGainWin(itemid)
return
end
local filter={}
filter[ITEM_FILTER_TYPE.eItemid]=itemid
local itemlist=bagControl.getBagItemsByFilter(ITEM_MAIN_TYPE.eMaterials,filter,false)
local sortTag={}
for i,v in ipairs(itemlist)do
sortTag[tostring(v.itemguid)]=i
end
table.sort(itemlist,function(a,b)
if a.itemcount==b.itemcount then
return sortTag[tostring(a.itemguid)]>sortTag[tostring(b.itemguid)]
else
return a.itemcount>b.itemcount
end
end)
local item=itemlist[1]or{}
local itemguid=item.itemguid
self.additem={}
self.additem[itemid]=need
self:freshCount()
if self.selectCB then
self.selectCB(itemguid,itemid,need)
end
UIManager:closeWindow('UICommonPageWin')
end

function UIFabaoJingHuaSelectWin:freshCount()
local ids=self.ids
local cfgs=fabaoConfig.getJingHuaCfg()
for i=1,#ids do
local itemid=ids[i]
local widget=self.Contect:getChildLayoutGroupGridItem(i-1)
local stage=itemsConfig.getConfig(self.mainitemid).stage
local need=cfgs[itemid][1][stage]
local has=itemsModel.getCount(itemid)
if self.putlist then
local put=self.putlist[itemid]or 0
has=has-put
end
local enough=has>=need
local left=has-(self.additem[itemid]or 0)
local countTxt=enough and FMT.fmt('{0}/{1}',left,need)or
FMT.cfmt(FONT_COLOR.eRedColor,'{0}/{1}',left,need)
widget:SetChildText(8,countTxt)
widget:SetChildActive(9,not enough)


end
end

function UIFabaoJingHuaSelectWin:onResetBtn()
if self.selectCB then
self.selectCB()
end
end

