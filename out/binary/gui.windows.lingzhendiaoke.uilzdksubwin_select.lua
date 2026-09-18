







def_class("UILZDKSubWin_Select",UIWindowBase)









function UILZDKSubWin_Select:bindComponents()

self.selectRoot1=UIObject.get(self,0)
self.selectRoot2=UIObject.get(self,1)
self.selectRoot3=UIObject.get(self,2)
self.selectRoot4=UIObject.get(self,3)
self.selectRoot5=UIObject.get(self,4)
self.Bg=UIObject.get(self,5)
self.root=UIObject.get(self,6)



end


function UILZDKSubWin_Select:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.selectRoot1);self.selectRoot1=nil;
_UIObject_release(self.selectRoot2);self.selectRoot2=nil;
_UIObject_release(self.selectRoot3);self.selectRoot3=nil;
_UIObject_release(self.selectRoot4);self.selectRoot4=nil;
_UIObject_release(self.selectRoot5);self.selectRoot5=nil;
_UIObject_release(self.Bg);self.Bg=nil;
_UIObject_release(self.root);self.root=nil;
end


















local selectRootCmpIdx={
icon=0,
select=1,
itemList={4,3,2},
gou=5,
}

function UILZDKSubWin_Select:onLoaded(...)
self:bindComponents()
self.selectRootList={self.selectRoot1,self.selectRoot2,self.selectRoot3,self.selectRoot4,self.selectRoot5}
self.widgetBaseList={}
for i,v in ipairs(self.selectRootList)do
local widget=v:getWidgetBase()
self.widgetBaseList[i]=widget
widget:SetChildToggleChange(selectRootCmpIdx.select,function(name,isOn)
self:SetToggleChange(i,isOn)
end)
end





self.root:setChildCanvasGroupAlpha(0)
self.Bg:setChildUIModelShowTarget(5373,1,{},2104)
self.Bg:setChildModelAnimationState(2104,2)
self:delayDo(1,function()
self.root:setChildCanvasGroupDOFade(1,2)
self.Bg:setChildModelAnimationState(eAnimationID.stand,1)
end)
end


function UILZDKSubWin_Select:__delete()
self:unbindComponents()

end




function UILZDKSubWin_Select:onShow(argtable,afterOnloaded)
local level=argtable and argtable[1]or 1
self.sfId=argtable and argtable[2]or nil
self.jzGuid=argtable and argtable[3]or nil
local dzList=LZDiaoKeModel:getJZData_DzdkList(self.sfId,self.jzGuid)
self.dzList=table.deepCopy(dzList)
local dzItemList=cfgHelper.get(cfg_lingzhendiaokebaseconfig_get,1,"dzItemList")
for i,v in ipairs(self.widgetBaseList)do
if dzList[i]then
v:SetChildGray(selectRootCmpIdx.icon,false)
v:SetChildToggle(selectRootCmpIdx.select,true)
else
v:SetChildGray(selectRootCmpIdx.icon,true)
v:SetChildToggle(selectRootCmpIdx.select,false)
end
local itemList=dzItemList[i]
for ii,vv in ipairs(selectRootCmpIdx.itemList)do
if itemList[ii]then
v:SetChildActive(vv,true)
local conf={showname=false,showStageBg=false,stage="",showCountBG=true,itemcount=FMT.fmt("{0}级",ii),gray=level<ii and 3 or nil}
local item_data={itemid=itemList[ii],itemcount=0}

local prop=itemsComponentHelper.getCommonFillData(item_data,conf)
prop[PropIndex(DataPropKey.eWidgetActive,10)]=level<ii
v:SetChildPropData(vv,prop)
v:SetBaseItemClickEvent(vv,function(...)
itemsComponentHelper.onItemClick(...)
end)
else
v:SetChildActive(vv,false)
end
end
end
end


function UILZDKSubWin_Select:onHide()

end



function UILZDKSubWin_Select:onClickClose()
local dzdkList={}
for k,v in pairs(self.dzList)do
dzdkList[#dzdkList+1]=v
end
if#dzdkList<=0 then
UIManager.error("至少选择一种")
return
end
if not self.sfId or not self.jzGuid then
logErr("请求雕刻定制列表参数不全")
return
end
LZDiaoKeController:req_Dingzhi(self.sfId,self.jzGuid,#dzdkList,dzdkList)
self:closeSelf()
end


function UILZDKSubWin_Select:SetToggleChange(index,isOn)

self.dzList[index]=isOn and index or nil
local widget=self.widgetBaseList[index]
widget:SetChildGray(selectRootCmpIdx.icon,not isOn)
widget:SetChildActive(selectRootCmpIdx.gou,isOn)
end
