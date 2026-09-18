







def_class("UINPCRelationWin",UIWindowBase)









function UINPCRelationWin:bindComponents()

self.root=UIObject.get(self,0)
self.roleListPanel=UIScrollView.get(self,1)
self.friendListPanel=UIObject.get(self,2)
self.actorInfoItem=UIObject.get(self,3)



end


function UINPCRelationWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.friendListPanel);self.friendListPanel=nil;
_UIObject_release(self.actorInfoItem);self.actorInfoItem=nil;
end
















local _this=nil


function UINPCRelationWin:onLoaded(...)
_this=self
self:bindComponents()
self._on_select_role=function(...)
self:on_select_role(...)
end
self.roleListPanel:setClickAction(self._on_select_role)
end


function UINPCRelationWin:__delete()
_this=nil
self:unbindComponents()
end


function UINPCRelationWin:onHide()

end




function UINPCRelationWin:onShow(argtable,afterOnloaded)
local list=npcModel:getAllUnlockNPC(true)
if#list>1 then
table.sort(list,function(a,b)
return a<b
end)
end
self.npcList=list

local npcid=argtable.npcid
if npcid~=nil then
self.selectIndex=self:getNPCIndex(npcid)
self.selectNPC=npcid
else
if self.selectIndex==nil then
self.selectIndex=1
self.selectNPC=list[self.selectIndex]
end
end
self:refreshDiscipleList()
self:refreshInfo()

self:playAnim1()
end

function UINPCRelationWin:refreshDiscipleList(jump)
local tNum=#self.npcList
self.roleListPanel:freshGridsNum(tNum,tNum,1,true)
local idx=1
for i=1,tNum do
local item=self.roleListPanel:getGridObjectByindex(i-1)
local npcid=self.npcList[i]
local npcItemData=npcModel:getNPCItemData(npcid)
local imagecfg=npcModel:getNPCImageCfg(npcid)

comHelper.setChildModelRawImage_npc(item,imagecfg.id,1,0,eHeadCenterType.eHead)

item:SetChildText(2,imagecfg.name)

local isSelect=self.selectNPC==npcid
if isSelect then
idx=i
self.selectIndex=idx
end
self:changeItemSelect(item,isSelect)

end
if self.selectIndex==nil or jump then
self.selectIndex=idx
self.discipleList:jumpToLockX(self.selectIndex)
end
end

function UINPCRelationWin:changeItemSelect(item,isSelect)
local iconname=isSelect and'button_dytab2j_2'or'button_dytab2j_1'
item:SetChildCSImageSprite(0,globalABLookup.global,iconname)
end

function UINPCRelationWin:getNPCIndex(npcid)
for i,npcid_ in ipairs(self.npcList)do
if npcid_==npcid then
return i
end
end
return nil
end

function UINPCRelationWin:on_select_role(id,index,guid,attach)
if self.selectIndex==index then return end

self:onChangeSelect(self.selectIndex,index)

local npcid=self.npcList[self.selectIndex]
self.selectNPC=npcid

self:refreshInfo()
self:playAnim1()
end

function UINPCRelationWin:onChangeSelect(old,cur,isjump)
if old==cur then return end
self.selectIndex=cur
if old~=nil then
local olditem=self.roleListPanel:getGridObjectByindex(old-1)
self:changeItemSelect(olditem,false)
end
local item=self.roleListPanel:getGridObjectByindex(cur-1)
self:changeItemSelect(item,true)

if isjump then
self.roleListPanel:jumpToLockX(cur)
end
end

function UINPCRelationWin:refreshInfo()
local npcid=self.selectNPC
local imagecfg=npcModel:getNPCImageCfg(npcid)

local actorWidget=self.actorInfoItem:getWidgetBase()
comHelper.setChildModelRawImage_npc(actorWidget,imagecfg.id,0,0,eHeadCenterType.eHead)
actorWidget:SetChildText(1,imagecfg.name)


local relations=npcModel:getNPCRelations(npcid)
local grids=self.friendListPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]

local idx=i%3
if idx==0 then idx=3 end
local side=1
if i>3 then side=2 end

local npcid_=relations[side][idx]
local unlock=npcid_~=nil and npcModel:checkNPCUnlock(npcid_)
item:SetChildActive(2,unlock)
item:SetChildActive(3,not unlock)
item:SetChildActive(4,unlock)
item:SetChildActive(5,unlock)
if unlock then
local imagecfg_=npcModel:getNPCImageCfg(npcid_)

comHelper.setChildModelRawImage_npc(item,imagecfg_.id,2,0,eHeadCenterType.eHead)

item:SetChildText(4,imagecfg_.name)

local str=side==1 and'友好'or'厌恶'
item:SetChildText(6,str)
end

item:SetChildButtonClick(1,function()
self:onItemClick(npcid_,i)
end)
end
end

function UINPCRelationWin:onItemClick(npcid,index)
local unlock=npcid~=nil and npcModel:checkNPCUnlock(npcid)
if not unlock then return end

local cur=self:getNPCIndex(npcid)
if cur==nil then return end

local checkIn=self.roleListPanel:checkInShow(cur)
self:onChangeSelect(self.selectIndex,cur,not checkIn)
self.selectNPC=npcid
local func=function()
if _this==nil then return end
_this:refreshInfo()
end
self:playAnim2(index,func)
end

function UINPCRelationWin:playAnim1()
self.actorInfoItem:setChildCanvasGroupAlpha(0)
self.actorInfoItem:setScale(Vector3(0.5,0.5,0.5))
local func=function()
if _this==nil then return end
_this:playAnimEx()
end
self.actorInfoItem:setChildDOScale(1,0.15,func)
self.actorInfoItem:setChildCanvasGroupDOFade(1,0.15,nil)

local grids=self.friendListPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
item:SetChildActive(0,false)
item:SetChildCanvasGroupAlpha(1,0)
item:SetChildAnchoredPosition(1,Vector2.New(0,0))
end
end

function UINPCRelationWin:playAnim2(index,callback)
self.actorInfoItem:setChildCanvasGroupAlpha(0)

local func=function()
if _this==nil then return end
local item_=_this.friendListPanel:getChildCommonLayoutGroupWidgetItem(index-1)
item_:SetChildCanvasGroupAlpha(1,0)
item_:SetChildAnchoredPosition(1,Vector2.New(0,0))
item_:SetChildScale(1,Vector3(1,1,1))
item_:SetChildActive(4,true)
item_:SetChildActive(5,true)

_this.actorInfoItem:setChildCanvasGroupAlpha(1)
_this:playAnimEx(callback)
end
local grids=self.friendListPanel:getChildCommonLayoutGroupWidgetList()
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

function UINPCRelationWin:playAnimEx(callback)
if callback then
callback()
end
local func2=function()
if _this==nil then return end
local grids__=_this.friendListPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids__.Count do
local item__=grids__[i-1]
item__:SetChildActive(0,true)
end
end
local grids_=self.friendListPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids_.Count do
local item_=grids_[i-1]
local f=i==1 and func2 or nil
item_:SetChildCanvasGroupDOFade(1,1,0.25,nil)
item_:SetChildDOAnchorPos(1,Vector2.New(-232,0),0.25,f)
end
end