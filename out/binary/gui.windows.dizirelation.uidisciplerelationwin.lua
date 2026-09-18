







def_class("UIDiscipleRelationWin",UIWindowBase)









function UIDiscipleRelationWin:bindComponents()

self.root=UIObject.get(self,0)
self.roleListPanel=UIScrollView.get(self,1)
self.friendListPanel=UIObject.get(self,2)
self.coupleListPanel=UIObject.get(self,3)
self.actorInfoItem=UIObject.get(self,4)
self.pageBtnsGrid=UIObject.get(self,5)
self.coupleItem=UIObject.get(self,6)



end


function UIDiscipleRelationWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.friendListPanel);self.friendListPanel=nil;
_UIObject_release(self.coupleListPanel);self.coupleListPanel=nil;
_UIObject_release(self.actorInfoItem);self.actorInfoItem=nil;
_UIObject_release(self.pageBtnsGrid);self.pageBtnsGrid=nil;
_UIObject_release(self.coupleItem);self.coupleItem=nil;
end

















local pageConfig=
{
[DISCIPLE_RELATION_TYPE.eFriend]={
typo=DISCIPLE_RELATION_TYPE.eFriend,
name='恩怨',
checkOpen=function(diziguid)
return true
end,
open=function(self_)
self_:refreshFriendInfo()
end,
close=function(self_)
self_:closeFriendInfo()
end,
},
[DISCIPLE_RELATION_TYPE.eShiTu]={
typo=DISCIPLE_RELATION_TYPE.eShiTu,
name='师徒',
checkOpen=function(diziguid)
return systemModel.isOpen(SYSTEM_DEFINE.eShitu)
end,
open=function(self_)

end,
close=function(self_)

end,
},
[DISCIPLE_RELATION_TYPE.eDaoLv]={
typo=DISCIPLE_RELATION_TYPE.eDaoLv,
name='道侣',
checkOpen=function(diziguid)
local open=systemModel.isOpen(SYSTEM_DEFINE.eDiscipleCouple)
if not open then return false end
local coupleGuid=DiscipleCoupleModel:getDiscipleCoupleGuid(diziguid)
local fateCouple=DiscipleCoupleModel:getDiscipleFateCouple(diziguid)
return mathHelper.validInt64(coupleGuid)or fateCouple
end,
open=function(self_)
self_:refreshCoupleInfo()
end,
close=function(self_)
self_:closeCoupleInfo()
end,
},
[DISCIPLE_RELATION_TYPE.eFamily]={
typo=DISCIPLE_RELATION_TYPE.eFamily,
name='家庭',
checkOpen=function(diziguid)
return systemModel.isOpen(SYSTEM_DEFINE.eJiaTing)
end,
open=function(self_)

end,
close=function(self_)

end,
},
}
local _this=nil


function UIDiscipleRelationWin:onLoaded(...)
_this=self
self:bindComponents()
self._on_select_role=function(...)
self:on_select_role(...)
end
self.roleListPanel:setClickAction(self._on_select_role)








end


function UIDiscipleRelationWin:__delete()
_this=nil
self:unbindComponents()
end


function UIDiscipleRelationWin:onHide()

end




function UIDiscipleRelationWin:onShow(argtable,afterOnloaded)
self.isAnim=false
local guid=argtable.guid
self.selectGuid=guid

if afterOnloaded then
self.selectPageType=DISCIPLE_RELATION_TYPE.eFriend
end
self:initPageBtns()
self:refreshInfo()

self:playAnim1()
end

function UIDiscipleRelationWin:onShowArgRecv(argtable)
local guid=argtable.guid
self.selectGuid=guid
local old=self.selectPageType
local pcfg=pageConfig[self.selectPageType]
if not pcfg.checkOpen(self.selectGuid)then
self.selectPageType=DISCIPLE_RELATION_TYPE.eFriend
end
self:initPageBtns()
self:refreshInfo(old)

if self.selectPageType==DISCIPLE_RELATION_TYPE.eFriend then
self:playAnim1()
elseif self.selectPageType==DISCIPLE_RELATION_TYPE.eDaoLv then
self:playAnim1_couple()
end
end


function UIDiscipleRelationWin:onPageClick(pageType)
if self.isAnim then return end
if self.selectPageType==pageType then return end
local old=self.selectPageType
if old~=nil then
local olditem=self.pageBtnsGrid:getChildLayoutGroupGridItem(old-1)
self:refreshPageBtnSelect(olditem,false)
end
local item=self.pageBtnsGrid:getChildLayoutGroupGridItem(pageType-1)
self:refreshPageBtnSelect(item,true)
self.selectPageType=pageType

self:refreshInfo(old)
end

function UIDiscipleRelationWin:initPageBtns()
self.openNum=0
for i,v in pairs(pageConfig)do
if v.checkOpen(self.selectGuid)then
self.openNum=self.openNum+1
end
end
local func=function(index)
local item=self.pageBtnsGrid:getChildLayoutGroupGridItem(index-1)
self:refreshPageBtn(item,index)
end
self.pageBtnsGrid:setChildLayoutGroupCreateItems(#pageConfig,func)
end

function UIDiscipleRelationWin:refreshPageBtn(item,index)
if self.openNum<=1 then
item:SetChildActive(-1,false)
return
end
local pcfg=pageConfig[index]
if not pcfg.checkOpen(self.selectGuid)then
item:SetChildActive(-1,false)
return
end
item:SetChildActive(-1,true)
local pageType=pcfg.typo
item:SetChildButtonClick(-1,function()
self:onPageClick(pageType)
end)
local isSelect=pageType==self.selectPageType
self:refreshPageBtnSelect(item,isSelect)

item:SetChildText(1,pcfg.name)
end

function UIDiscipleRelationWin:refreshPageBtnSelect(item,isSelect)
local iconname=isSelect and'button_digxtab_3'or'button_digxtab_1'
item:SetChildCSImageSprite(0,globalABLookup.globa4,iconname)


end

function UIDiscipleRelationWin:refreshInfo(oldPage)
local guid=self.selectGuid
local netData=UIDiscipleModel:getDiscipleData(guid)

local actorWidget=self.actorInfoItem:getWidgetBase()
comHelper.setChildModelRawImage(actorWidget,guid,0,0,eHeadCenterType.eHead)
actorWidget:SetChildText(1,netData.disciplename)

if oldPage~=nil and oldPage~=self.selectPageType then
local old_pcfg=pageConfig[oldPage]
old_pcfg.close(self)
end

local pcfg=pageConfig[self.selectPageType]
pcfg.open(self)
end





function UIDiscipleRelationWin:closeFriendInfo()
self.friendListPanel:setActive(false)
end

function UIDiscipleRelationWin:refreshFriendInfo()
self.friendListPanel:setActive(true)
local guid=self.selectGuid
local relations={}
relations[1]=UIDiscipleModel:getRelationDiscipleList(guid,DISCIPLE_RELATION_TYPE.eFriend,
{DISCIPLE_FRIEND_RELATION_TYEP.eQinmi,DISCIPLE_FRIEND_RELATION_TYEP.eFriend},true)
relations[2]=UIDiscipleModel:getRelationDiscipleList(guid,DISCIPLE_RELATION_TYPE.eFriend,
{DISCIPLE_FRIEND_RELATION_TYEP.eChoushi,DISCIPLE_FRIEND_RELATION_TYEP.eYanwu},true)
local grids=self.friendListPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]

local idx=i%3
if idx==0 then idx=3 end
local side=1
if i>3 then side=2 end

local info=relations[side][idx]
local guid=nil
local unlock=info~=nil and mathHelper.validInt64(info[1])
if unlock then
guid=info[1]
end
item:SetChildActive(2,unlock)
item:SetChildActive(3,not unlock)
item:SetChildActive(4,unlock)
item:SetChildActive(5,unlock)
if unlock then
local netData=UIDiscipleModel:getDiscipleData(guid)

comHelper.setChildModelRawImage(item,guid,2,0,eHeadCenterType.eHead)

item:SetChildText(4,netData.disciplename)

local str=side==1 and'友好'or'厌恶'
local typo,str=UIDiscipleModel:getFriendRelationChildType(info[2])
item:SetChildText(6,str)
end

item:SetChildButtonClick(1,function()
self:onFriendItemClick(guid,i)
end)
end
end

function UIDiscipleRelationWin:onFriendItemClick(guid,index)
if self.isAnim then return end
local unlock=guid~=nil
if not unlock then return end

local func=function()
if _this==nil then return end
local win=UIManager:findActiveWindow('UIDiscipleListComponent')
if win then
return win:onSelect(guid,nil,true)
end
end
self:playAnim2(index,func)
end



function UIDiscipleRelationWin:closeCoupleInfo()
self.coupleListPanel:setActive(false)
end

function UIDiscipleRelationWin:refreshCoupleInfo()
self.coupleListPanel:setActive(true)
local info=nil
local guid=DiscipleCoupleModel:getDiscipleCoupleGuid(self.selectGuid)
local unlock=mathHelper.validInt64(guid)
local unlock2,fateCoupleId=DiscipleCoupleModel:getDiscipleFateCouple(self.selectGuid)
local item=self.coupleItem:getChildWidgetBase()
item:SetChildActive(2,unlock or unlock2)
item:SetChildActive(3,not unlock and not unlock2)
item:SetChildActive(4,unlock or unlock2)
item:SetChildActive(5,unlock or unlock2)
if unlock then
local netData=UIDiscipleModel:getDiscipleData(guid)

comHelper.setChildModelRawImage(item,guid,2,0,eHeadCenterType.eHead)

item:SetChildText(4,netData.disciplename)

local str='道侣'
item:SetChildText(6,str)
elseif unlock2 then
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(fateCoupleId)
if netData then
guid=netData.discipleguid
else
netData=UIDiscipleModel:getDiscipleDataByDiziId(fateCoupleId)
guid=nil
end

comHelper.setChildModelRawImageByDiziId(item,fateCoupleId,2,0,eHeadCenterType.eHead,nil,not guid)

item:SetChildText(4,netData.disciplename)

local str='道侣'
item:SetChildText(6,str)
end

item:SetChildButtonClick(1,function()
self:onCoupleItemClick(guid,unlock2)
end)
end

function UIDiscipleRelationWin:onCoupleItemClick(guid,fateCouple)
if self.isAnim then return end
local unlock=guid~=nil
if not unlock then
if fateCouple then
UIManager.error("该弟子未获得")
end
return
end

local func=function()
if _this==nil then return end
local win=UIManager:findActiveWindow('UIDiscipleListComponent')
if win then
return win:onSelect(guid,nil,true)
end
end
self:playAnim2_couple(func)
end


function UIDiscipleRelationWin:getRelationPanel()
local relationType=self.selectPageType
if relationType==DISCIPLE_RELATION_TYPE.eFriend then
return self.friendListPanel
end
return nil
end


function UIDiscipleRelationWin:playAnim1()
self.isAnim=true
self.actorInfoItem:setChildCanvasGroupAlpha(0)
self.actorInfoItem:setScale(Vector3(0.5,0.5,0.5))
local func=function()
if _this==nil then return end
_this:playAnimEx()
end
self.actorInfoItem:setChildDOScale(1,0.15,func)
self.actorInfoItem:setChildCanvasGroupDOFade(1,0.15,nil)

local listPanel=self:getRelationPanel()
local grids=listPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
item:SetChildActive(0,false)
item:SetChildCanvasGroupAlpha(1,0)
item:SetChildAnchoredPosition(1,Vector2.New(0,0))
end
end

function UIDiscipleRelationWin:playAnim2(index,callback)
self.isAnim=true
self.actorInfoItem:setChildCanvasGroupAlpha(0)
local listPanel=self:getRelationPanel()

local func=function()
if _this==nil then return end
local item_=listPanel:getChildCommonLayoutGroupWidgetItem(index-1)
item_:SetChildCanvasGroupAlpha(1,0)
item_:SetChildAnchoredPosition(1,Vector2.New(0,0))
item_:SetChildScale(1,Vector3(1,1,1))
item_:SetChildActive(4,true)
item_:SetChildActive(5,true)

_this.actorInfoItem:setChildCanvasGroupAlpha(1)
_this:playAnimEx(callback)
end
local grids=listPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
item:SetChildActive(0,false)
if i==index then
item:SetChildDOScale(1,1.6,0.25,nil)
item:SetChildDOAnchorPos(1,Vector2.New(10,0),0.3,func)
item:SetChildActive(4,false)
item:SetChildActive(5,false)
else
item:SetChildCanvasGroupAlpha(1,0)
item:SetChildAnchoredPosition(1,Vector2.New(0,0))
end
end
end

function UIDiscipleRelationWin:playAnimEx(callback)
if callback then
callback()
end
local listPanel=self:getRelationPanel()
local func2=function()
if _this==nil then return end
_this.isAnim=false
local grids__=listPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids__.Count do
local item__=grids__[i-1]
item__:SetChildActive(0,true)
end
end
local grids_=listPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids_.Count do
local item_=grids_[i-1]
local f=i==1 and func2 or nil
item_:SetChildCanvasGroupDOFade(1,1,0.25,nil)
item_:SetChildDOAnchorPos(1,Vector2.New(-232,0),0.25,f)
end
end


function UIDiscipleRelationWin:playAnim1_couple()
self.isAnim=true
self.actorInfoItem:setChildCanvasGroupAlpha(0)
self.actorInfoItem:setScale(Vector3(0.5,0.5,0.5))
local func=function()
if _this==nil then return end
_this:playAnimEx_couple()
end
self.actorInfoItem:setChildDOScale(1,0.15,func)
self.actorInfoItem:setChildCanvasGroupDOFade(1,0.15,nil)

local item=self.coupleItem:getChildWidgetBase()
item:SetChildActive(0,false)
item:SetChildCanvasGroupAlpha(1,0)
item:SetChildAnchoredPosition(1,Vector2.New(0,0))
end

function UIDiscipleRelationWin:playAnim2_couple(callback)
self.isAnim=true
self.actorInfoItem:setChildCanvasGroupAlpha(0)
local func=function()
if _this==nil then return end
local item_=_this.coupleItem:getChildWidgetBase()
item_:SetChildCanvasGroupAlpha(1,0)
item_:SetChildAnchoredPosition(1,Vector2.New(0,0))
item_:SetChildScale(1,Vector3(1,1,1))
item_:SetChildActive(4,true)
item_:SetChildActive(5,true)

_this.actorInfoItem:setChildCanvasGroupAlpha(1)
_this:playAnimEx_couple(callback)
end
local coupleItem=self.coupleItem:getChildWidgetBase()
coupleItem:SetChildActive(0,false)
coupleItem:SetChildDOScale(1,1.6,0.25,nil)
coupleItem:SetChildDOAnchorPos(1,Vector2.New(10,0),0.3,func)
coupleItem:SetChildActive(4,false)
coupleItem:SetChildActive(5,false)
end

function UIDiscipleRelationWin:playAnimEx_couple(callback)
if callback then
callback()
end
local func2=function()
if _this==nil then return end
_this.isAnim=false
local item__=_this.coupleItem:getChildWidgetBase()
item__:SetChildActive(0,true)
end
local item_=self.coupleItem:getChildWidgetBase()
item_:SetChildCanvasGroupDOFade(1,1,0.25,nil)
item_:SetChildDOAnchorPos(1,Vector2.New(-232,0),0.25,func2)
end