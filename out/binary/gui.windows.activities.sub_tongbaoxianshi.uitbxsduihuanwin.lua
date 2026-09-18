







def_class("UITBXSDuiHuanWin",UIWindowBase)









function UITBXSDuiHuanWin:bindComponents()

self.root=UIObject.get(self,0)
self.nameText=UIText.get(self,1)
self.bagPage=UIObject.get(self,2)
self.bagScrollView=UIObject.get(self,3)
self.bagLine=UIObject.get(self,4)



end


function UITBXSDuiHuanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.nameText);self.nameText=nil;
_UIObject_release(self.bagPage);self.bagPage=nil;
_UIObject_release(self.bagScrollView);self.bagScrollView=nil;
_UIObject_release(self.bagLine);self.bagLine=nil;
end



















function UITBXSDuiHuanWin:onLoaded(...)
self:bindComponents()
end


function UITBXSDuiHuanWin:__delete()
self:unbindComponents()
end




function UITBXSDuiHuanWin:onShow(argtable,afterOnloaded)
local selectIndex=argtable.selectIndex
self.selectIndex=selectIndex
self.actid=argtable.actid
self.subType=SUB_ACTIVITY_TYPE.eTongBaoXianShi
self.subid=argtable.subid
local list=argtable.list
self.id=argtable.id
self.bagScrollView:setChildScrollViewCreateGrids(#list,1)
self.bagScrollView:setChildScrollViewSelectItem(0,false,false,true)
local grids=self.bagScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
self:refreshItem(i,item,list[i])
end
end

end

function UITBXSDuiHuanWin:refreshItem(i,item,data)
local itemList=data
item:SetChildLayoutGroupCreateItems(3,3)
local grids=item:GetChildLayoutGroupGridList(3)
for i=0,grids.Count-1 do
local grid=grids[i]
local fangAn=itemList[i+1]
if fangAn then
local have=itemsModel.getCount(fangAn[1])
local countStr







if itemsConfig.isMoney(fangAn[1])then
if have>=fangAn[2]then
countStr=mathHelper.formatNumber(fangAn[2])
else
countStr=FMT.fmt("<color=#f36666>{0}</color>",mathHelper.formatNumber(fangAn[2]))
end
else
if have>=fangAn[2]then
countStr=FMT.fmt("{0}/{1}",mathHelper.formatNumber(have),mathHelper.formatNumber(fangAn[2]))
else
countStr=FMT.fmt("<color=#f36666>{0}/{1}</color>",mathHelper.formatNumber(have),mathHelper.formatNumber(fangAn[2]))
end
end



local conf={showname=false,showcount=true,showCountBG=true,itemcount=countStr,showStageBg=true}
local item={itemid=fangAn[1],itemcount=fangAn[2]}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
grid:SetChildActive(-1,true)
grid:SetChildPropData(-1,prop)
grid:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClick)
else
grid:SetChildActive(-1,false)
end
end
item:SetChildButtonClick(1,function()
if self.selectIndex then
local grid=self.bagScrollView:getChildScrollViewItemWidget(self.selectIndex-1)
if grid then
grid:SetChildActive(1,true)
grid:SetChildActive(0,false)
end
end
item:SetChildActive(1,false)
item:SetChildActive(0,true)
self.selectIndex=i
local infoData=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)or{}
local selectFangAnList=infoData.selectFangAn or{}
selectFangAnList[self.id]=i
infoData.selectFangAn=selectFangAnList
activitiesModel:setSubActInfoData(self.actid,self.subType,self.subid,infoData)
activitiesHandle_tongbaoxianshi.saveSelectData(self.actid,self.subid)
self:onCloseClick()
end)
if self.selectIndex==i then
item:SetChildActive(1,false)
item:SetChildActive(0,true)
else
item:SetChildActive(1,true)
item:SetChildActive(0,false)
end
item:SetChildText(2,FMT.fmt("方案{0}",mathHelper.numberToChinese(i)))
end

function UITBXSDuiHuanWin:onCloseClick()
UIManager:invokeUIMethod("UISubAct_tongbaoxianshi_Win","refresh",self.id)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
self:closeSelf()
end


function UITBXSDuiHuanWin:onHide()

end



