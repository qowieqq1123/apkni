







def_class("UIXMFXZYGainDialog",UIWindowBase)









function UIXMFXZYGainDialog:bindComponents()

self.background=UIButton.get(self,0)
self.content=UIObject.get(self,1)
self.tabList=UIObject.get(self,2)

self.background:setButtonClick(function()self:onBackground()end)



end


function UIXMFXZYGainDialog:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.tabList);self.tabList=nil;
end















local _this=nil
local _itemCmp={
root=-1,
item=0,
num=1,
}
local _actorCmp={
head=0,
name=1
}



function UIXMFXZYGainDialog:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXMFXZYGainDialog:__delete()
self:unbindComponents()
_this=nil
end




function UIXMFXZYGainDialog:onShow(argtable,afterOnloaded)
local dataList=xianmengModel:getGainList_fenxiangziyuan()
local maxCnt=0
local sortList={}
for index,data in ipairs(dataList)do
maxCnt=math.max(maxCnt,data.len)
table.insert(sortList,index)
end
table.sort(sortList,function(a,b)
local aData=dataList[a]
local bData=dataList[b]
return aData.len<bData.len
end)
self.tabList:setChildLayoutGroupCreateItems(maxCnt-1,nil)
self.content:setChildLayoutGroupCreateItems(#sortList,function(index)
local item=self.content:getChildLayoutGroupGridItem(index-1)
local data=dataList[sortList[index]]
local itemId=data.itemid
local config=cfgHelper.get1(cfg_guildaskforconfig_get,itemId)
local nameStr=data.len*config.num
local conf={itemid=itemId,showCountBG=false,showStage=true,itemcount="",showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(_itemCmp.item,prop)
item:SetBaseItemClickEvent(_itemCmp.item,itemsComponentHelper.onItemClickEx)
item:SetChildText(_itemCmp.num,data.len*config.num)
item:SetChildLayoutGroupCreateItems(_itemCmp.root,maxCnt,function(idx)
local actorItem=item:GetChildLayoutGroupGridItem(_itemCmp.root,idx-1)
local actorData=idx<=data.len and data.list[idx]or nil
if actorData then
playerController:setHeadIcon(actorItem,_actorCmp.head,{iconInfo=actorData.iconInfo})
actorItem:SetChildText(_actorCmp.name,actorData.actorname)
else
playerController:setHeadIcon(actorItem,_actorCmp.head,nil)
actorItem:SetChildText(_actorCmp.name,"")
end
end)
end)
end


function UIXMFXZYGainDialog:onHide()

end





function UIXMFXZYGainDialog:onBackground()
xianmengController:req_protocol_20_47()
self:closeSelf()
end