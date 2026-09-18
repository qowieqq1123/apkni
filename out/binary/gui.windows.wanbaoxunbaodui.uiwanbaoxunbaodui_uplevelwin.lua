







def_class("UIWanBaoXunBaoDui_UpLevelWin",UIWindowBase)









function UIWanBaoXunBaoDui_UpLevelWin:bindComponents()

self.root=UIObject.get(self,0)
self.uiroot=UIObject.get(self,1)
self.itemScrollView=UIScrollView.get(self,2)
self.emptyTip=UIText.get(self,3)



end


function UIWanBaoXunBaoDui_UpLevelWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.uiroot);self.uiroot=nil;
_UIObject_release(self.itemScrollView);self.itemScrollView=nil;
_UIObject_release(self.emptyTip);self.emptyTip=nil;
end
















local CmpSlotItemIndex={
item=0,
name=1,
info=2,
operationBtn=3,
btnname=4,
}




function UIWanBaoXunBaoDui_UpLevelWin:onLoaded(...)
self:bindComponents()
local onItemChange=function(...)
self:onItemChange(...)
end
self:addNotify(notifyConfig.on_item_changed,onItemChange)

self.itemScrollView:bindScrollWidget(function(...)self:bindItem(...)end)
end


function UIWanBaoXunBaoDui_UpLevelWin:__delete()
self:unbindComponents()
end




function UIWanBaoXunBaoDui_UpLevelWin:onShow(argtable,afterOnloaded)
self.employeeData=argtable and argtable.data
self:refresh()

if afterOnloaded then


self.uiroot:setChildDOAnchorPosX(-258.83,0.3,nil)

end
end


function UIWanBaoXunBaoDui_UpLevelWin:onHide()

end



function UIWanBaoXunBaoDui_UpLevelWin:refresh()
self.dataLookup={}
self.data=wanBaoXunBaoDuiModel:getEmployeeExpItemdata()or{}

self.emptyTip:setActive(#self.data==0)
self.itemScrollView:setActive(#self.data>0)
if#self.data>0 then
self.itemScrollView:freshGridsNum(#self.data,#self.data,1,true)
else
self.emptyTip:setText("【缺少升级道具】")
end
self.itemScrollView:setChildScrollRectEnable(#self.data>3)
end

function UIWanBaoXunBaoDui_UpLevelWin:bindItem(index,item)
local data=self.data[index]

item:SetChildActive(-1,data~=nil)

if data~=nil then
self.dataLookup[data.itemid]=data
local itemid=data.itemid
local itemguid=data.itemguid or-1
local itemcount=data.itemcount or 0
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local name=FMT.cfmt(color,itemConfig.name)
local info=itemConfig.funcparam and FMT.fmt('经验+{0}',itemConfig.funcparam.exp)or''

item:SetChildText(CmpSlotItemIndex.name,name)
item:SetChildText(CmpSlotItemIndex.info,info)

local conf={itemid=itemid,itemcount=itemcount>1 and itemcount or'',showCountBG=itemcount>1,showname=false}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(CmpSlotItemIndex.item,itemProp)
item:SetBaseItemClickEvent(CmpSlotItemIndex.item,itemsComponentHelper.onItemClick)

item:SetChildLongPress(CmpSlotItemIndex.operationBtn,1,function()
self:useItem(data)
end,function()print("dly fncallback")end)
end
end

function UIWanBaoXunBaoDui_UpLevelWin:onItemChange(changeType,itemguid,itemid,oldcount,newcount)
if self.dataLookup and self.dataLookup[itemid]then
self:refresh()
end
end

local count=1
function UIWanBaoXunBaoDui_UpLevelWin:useItem(data)

if wanBaoXunBaoDuiModel:checkEmployeeMaxLv(self.employeeData.guid)then
wanBaoXunBaoDuiController:reqFeedCat(WBXBD_UseItem_TYPE.item,data.itemguid,self.employeeData.guid)

AudioManager.playAudio(629)
end

count=count+1
end
