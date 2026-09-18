







def_class("UIXianYuanXunFangInfoWin",UIWindowBase)









function UIXianYuanXunFangInfoWin:bindComponents()

self.background=UIButton.get(self,0)
self.changeBtn=UIButton.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.roleGridPanel=UIObject.get(self,3)
self.scrollView=UIObject.get(self,4)

self.background:setButtonClick(function()self:onBackground()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXianYuanXunFangInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.roleGridPanel);self.roleGridPanel=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
end
















local _this=nil
local _itemCmp={
click=0,
lihui=1,
detailpBtn=2,
orientation=3,
tuijian=4,
xiaoren=5,
name=6,
xiaorenBtn=7,
gailv=8,
select=9,
}


function UIXianYuanXunFangInfoWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXianYuanXunFangInfoWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXianYuanXunFangInfoWin:onHide()

end




function UIXianYuanXunFangInfoWin:onShow(argtable,afterOnloaded)
self.myData=xianyuanxunfangModel:getData()
self.mycfg=xianyuanxunfangModel:getCfg2()

self:refreshList()
end

function UIXianYuanXunFangInfoWin:onBackground()
self:closeSelf()
end

function UIXianYuanXunFangInfoWin:onChangeDZBtn()
self:showWindow('UIXianYuanXunFangSelectWin')
end

function UIXianYuanXunFangInfoWin:onClickSelect(_index)
if _index~=self.myData.itemid then
xianyuanxunfangController:reqSelectUp(_index)
end
end

function UIXianYuanXunFangInfoWin:onClickDetail(_index)
local idx=self.myData.items[_index]
local itemID=self.mycfg.disciple[idx][1]
UIRecruitControl:showItemDiscipleInfoByItemId2(itemID)
end

function UIXianYuanXunFangInfoWin:refreshList()
self.roleGridPanel:setChildLayoutGroupCreateItems(self.mycfg.select_num,function(_index)
local item=self.roleGridPanel:getChildLayoutGroupGridItem(_index-1)
local idx=self.myData.items[_index]
local itemID=self.mycfg.disciple[idx][1]
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemID)
local info=dzData.imageInfo

item:SetChildButtonClick(_itemCmp.click,function()
self:onClickSelect(_index)
end)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(info)
modelParams.scale=0.025
modelParams.offset={0,1}
comHelper.setChildModelRawImageEx(_itemCmp.lihui,item,modelParams,eHeadCenterType.eNone,1,false)

item:SetChildButtonClick(_itemCmp.detailpBtn,function()
self:onClickDetail(_index)
end)

local abname,icon=UIDiscipleModel:getJobOrientationBigIcon(info.job,dzData.id)
item:SetChildCSImageSprite(_itemCmp.orientation,abname,icon)

item:SetChildActive(_itemCmp.tuijian,table.containsValue(self.mycfg.defaultdz,itemID))

modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)
item:SetChildUIModelShowTarget(_itemCmp.xiaoren,modelParams.body,0.75,modelParams.componets,eAnimationID.stand)

item:SetChildText(_itemCmp.name,dzData.disciplename)

item:SetChildButtonClick(_itemCmp.xiaorenBtn,function()
self:onClickDetail(_index)
end)
local love=_index==self.myData.itemid
item:SetChildActive(_itemCmp.gailv,love)
item:SetChildActive(_itemCmp.select,love)
if love then
item:SetChildUIModelShowTarget(_itemCmp.gailv,5295,1,{},eAnimationID.enter,false,true,0,nil)
else
item:SetChildUIModelRemoveTarget(_itemCmp.gailv)
end
end)
self.scrollView:setChildScrollRectEnable(self.mycfg.select_num>3)
end

function UIXianYuanXunFangInfoWin:refreshSelect()
local items=self.roleGridPanel:getChildLayoutGroupGridList()
for i=1,items.Count do
local item=items[i-1]
local love=i==self.myData.itemid
item:SetChildActive(_itemCmp.gailv,love)
item:SetChildActive(_itemCmp.select,love)
if love then
item:SetChildUIModelShowTarget(_itemCmp.gailv,5295,1,{},eAnimationID.enter,false,true,0,nil)
else
item:SetChildUIModelRemoveTarget(_itemCmp.gailv)
end
end
end

function UIXianYuanXunFangInfoWin:onChangeBtn()
UIManager:showWindow('UIXianYuanXunFangSelectWin')
end

function UIXianYuanXunFangInfoWin:onCloseBtn()
self:closeSelf()
end

function UIXianYuanXunFangInfoWin:rec_selectDZ()
self:refreshList()
end

function UIXianYuanXunFangInfoWin:rec_selectUp()
self:refreshSelect()
end