







def_class("UISubAct_xianjieqiyuan_LoveListDialog",UIWindowBase)









function UISubAct_xianjieqiyuan_LoveListDialog:bindComponents()

self.background=UIButton.get(self,0)
self.changeBtn=UIButton.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.roleGridPanel=UIObject.get(self,3)
self.scrollView=UIObject.get(self,4)

self.background:setButtonClick(function()self:onBackground()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_xianjieqiyuan_LoveListDialog:unbindComponents()
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



function UISubAct_xianjieqiyuan_LoveListDialog:onLoaded(...)
self:bindComponents()
_this=self

self:addProNotify(247,36,self.on_247_36)
self:addProNotify(247,37,self.on_247_37)
self:addProNotify(247,41,self.on_247_41)
end


function UISubAct_xianjieqiyuan_LoveListDialog:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_xianjieqiyuan_LoveListDialog:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
if self.info then
self.data=self.info:getData()
if self.data then
self:refreshList()
return
end
end
self:onCloseBtn()
end


function UISubAct_xianjieqiyuan_LoveListDialog:onHide()

end




function UISubAct_xianjieqiyuan_LoveListDialog:onBackground()
self:onCloseBtn()
end


function UISubAct_xianjieqiyuan_LoveListDialog:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


function UISubAct_xianjieqiyuan_LoveListDialog:onChangeBtn()
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
parentWin=self,
}
self:showWindow('UISubAct_xianjieqiyuan_SelectLoveDialog2',args)
end

function UISubAct_xianjieqiyuan_LoveListDialog:onClickSelect(_index)
if self.data.itemid~=_index then
local json_str=jsonHelper.encode({1,_index})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actId,self.subType,self.subId,json_str)
end
end

function UISubAct_xianjieqiyuan_LoveListDialog:onClickDetail(_index)
local index=self.data.items[_index]
local itemID=self.config.disciple[index]
UIRecruitControl:showItemDiscipleInfoByItemId2(itemID)
end

function UISubAct_xianjieqiyuan_LoveListDialog:refreshList()
self.roleGridPanel:setChildLayoutGroupCreateItems(self.config.select_num,function(_index)
local item=self.roleGridPanel:getChildLayoutGroupGridItem(_index-1)
local index=self.data.items[_index]
local itemID=self.config.disciple[index]
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

item:SetChildActive(_itemCmp.tuijian,table.containsValue(self.config.defaultdz,index))

modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)
item:SetChildUIModelShowTarget(_itemCmp.xiaoren,modelParams.body,0.75,modelParams.componets,eAnimationID.stand)

item:SetChildText(_itemCmp.name,dzData.disciplename)

item:SetChildButtonClick(_itemCmp.xiaorenBtn,function()
self:onClickDetail(_index)
end)

local love=self.data.itemid==_index
item:SetChildActive(_itemCmp.gailv,love)
item:SetChildActive(_itemCmp.select,love)
if love then
item:SetChildUIModelShowTarget(_itemCmp.gailv,5295,1,{},eAnimationID.enter,false,true,0,nil)
else
item:SetChildUIModelRemoveTarget(_itemCmp.gailv)
end
end)
self.scrollView:setChildScrollRectEnable(self.config.select_num>3)
end

function UISubAct_xianjieqiyuan_LoveListDialog:refreshSelect()
local items=self.roleGridPanel:getChildLayoutGroupGridList()
for i=1,items.Count do
local item=items[i-1]
local love=self.data.itemid==i
item:SetChildActive(_itemCmp.gailv,love)
item:SetChildActive(_itemCmp.select,love)
if love then
item:SetChildUIModelShowTarget(_itemCmp.gailv,5295,1,{},eAnimationID.enter,false,true,0,nil)
else
item:SetChildUIModelRemoveTarget(_itemCmp.gailv)
end
end
end

function UISubAct_xianjieqiyuan_LoveListDialog.on_247_36(args)
local actId=args[1]
local subId=args[2]
local subType=SUB_ACTIVITY_TYPE.eXianJieQiYuan2
if _this and _this.info:compare(actId,subType,subId)then
_this.data=_this.info:getData()
_this:refreshList()
end
end

function UISubAct_xianjieqiyuan_LoveListDialog.on_247_37(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eXianJieQiYuan2
if _this and _this.info:compare(actId,subType,subId)then
_this:refreshSelect()
end
end

function UISubAct_xianjieqiyuan_LoveListDialog.on_247_41(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eXianJieQiYuan2
if _this and _this.info:compare(actId,subType,subId)then
_this:refreshList()
end
end