







def_class("UIWenXinGuan_SpecialityPreviewWin",UIWindowBase)









function UIWenXinGuan_SpecialityPreviewWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.creater_devil=UIObject.get(self,1)
self.creater_immortal=UIObject.get(self,2)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.creater={
["devil"]=self.creater_devil,
["immortal"]=self.creater_immortal,
}



end


function UIWenXinGuan_SpecialityPreviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.creater_devil);self.creater_devil=nil;
_UIObject_release(self.creater_immortal);self.creater_immortal=nil;
self.creater=nil;
end


















local this


function UIWenXinGuan_SpecialityPreviewWin:onLoaded(...)
self:bindComponents()
this=self
self.scrollViewType=
{
["talentImmortal"]=this.talentScrollView_Immortal,
["quirkImmortal"]=this.quirkScrollView_Immortal,
["talentDevil"]=this.talentScrollView_Devil,
["quirkDevil"]=this.quirkScrollView_Devil,
}

self.gridPanelType=
{
["talentImmortal"]=this.talentListPanel_Immortal,
["quirkImmortal"]=this.quirkListPanel_Immortal,
["talentDevil"]=this.talentListPanel_Devil,
["quirkDevil"]=this.quirkListPanel_Devil,
}
end


function UIWenXinGuan_SpecialityPreviewWin:__delete()
self:unbindComponents()
end




function UIWenXinGuan_SpecialityPreviewWin:onShow(argtable,afterOnloaded)
self.discipleGuid=argtable.guid
self.list_immortal,self.list_devil=WenXinGuanModel:checkXMSpeList()
self:refreshScrollView()
end


function UIWenXinGuan_SpecialityPreviewWin:onHide()

end

function UIWenXinGuan_SpecialityPreviewWin:freshChildItem(pageidx,index,creater,data)
local pageWidget=creater:getChildLayoutGroupGridItem(pageidx-1)
local item=pageWidget:GetChildLayoutGroupGridItem(2,index-1)

local typo=data.typo
local id=data.id
local effectcfg=UIDiscipleModel:getSpecialityConfig(typo,id)
local name=UIDiscipleModel.getSpecialityNameStr(effectcfg.name)
local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(effectcfg.framecolor)

item:SetChildText(0,name)
item:SetChildCSImageSprite(1,abName,frameIcon)
item:SetChildButtonClick(1,function()
self.onDescSlotClick(self.discipleGuid,effectcfg,item)
end)
end

function UIWenXinGuan_SpecialityPreviewWin:freshPageItem(pageidx,data,creater)
local widget=creater:getChildLayoutGroupGridItem(pageidx-1)
local data=data[pageidx]
local len=#data.list


local func=function(idx)
local itemData=data.list[idx]
self:freshChildItem(pageidx,idx,creater,itemData)
end

local text=UIDiscipleModel:getSpecialityTypeName(data.typo)
widget:SetChildLayoutGroupCreateItems(2,len,func)
widget:SetChildText(1,text)
end

function UIWenXinGuan_SpecialityPreviewWin:refreshScrollView()
local func=function(idx)
self:freshPageItem(idx,this.list_immortal,this.creater_immortal)
end
if self.list_immortal and next(self.list_immortal)then
local len=#self.list_immortal
self.creater_immortal:setChildLayoutGroupCreateItems(len,func)
end

local func=function(idx)
self:freshPageItem(idx,this.list_devil,this.creater_devil)
end
if self.list_devil and next(self.list_devil)then
local len=#self.list_devil
self.creater_devil:setChildLayoutGroupCreateItems(len,func)
end





























end

function UIWenXinGuan_SpecialityPreviewWin.onDescSlotClick(guid,effectcfg,speitem)
local cfg=effectcfg
local speitem=speitem
UIManager:showWindow('UISpecialityWin',{item=speitem,node='top',guid=guid,config=cfg,pivot=Vector2(0.5,0)})
end



function UIWenXinGuan_SpecialityPreviewWin:onCloseBtn()
self:closeSelf()
end