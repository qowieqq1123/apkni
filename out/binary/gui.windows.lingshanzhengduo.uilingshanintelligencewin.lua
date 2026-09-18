







def_class("UILingShanIntelligenceWin",UIWindowBase)









function UILingShanIntelligenceWin:bindComponents()

self.itemScrollView=UIComboScrollView.get(self,0)
self.jumpBtn=UIButton.get(self,1)
self.noSign=UIObject.get(self,2)
self.root=UIObject.get(self,3)
self.sortTypeDropdown=UIDropdown.get(self,4)
self.uiPanel=UIObject.get(self,5)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)



end


function UILingShanIntelligenceWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.itemScrollView);self.itemScrollView=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.uiPanel);self.uiPanel=nil;
end



















function UILingShanIntelligenceWin:onLoaded(...)
self:bindComponents()

self.abName='ui/windows/lingshanzhengduo/lszd_atlas_pak.ab'

self.typesDatas={
{2,'混元灵山'},
{1,'素尘灵山'},
}

self.mtypeToIndex={}
for i,v in ipairs(self.typesDatas)do
self.mtypeToIndex[v[1]]=i
end

self.iconNames={
'image_lingshanzhengduo_8',
'image_lingshanzhengduo_9'
}

local _mainClickAction=function(...)self:mainClickAction(...)end
local _subClickAction=function(...)self:subClickAction(...)end
local _mainCreateAction=function(...)self:mainCreateAction(...)end
local _subCreateAction=function(...)self:subCreateAction(...)end
local _onExpandAction=function(...)self:onExpandAction(...)end
self.itemScrollView:setAction(_mainClickAction,_subClickAction,_mainCreateAction,_subCreateAction,_onExpandAction)

end


function UILingShanIntelligenceWin:__delete()
self:unbindComponents()
end




function UILingShanIntelligenceWin:onShow(argtable,afterOnloaded)
local data=argtable.data
if data then
self.mount_type=data.mount_type
end

UIManager:closeWindow('UIXM_ZZSH_monsterInfoWin')
UIManager:closeWindow('UIXM_ZZSH_resourceInfoWin')

self:hideReddot()

self:refresh()

if afterOnloaded and argtable.isInit then
self:playEnterAnim()
end
end

function UILingShanIntelligenceWin:getSelectMpuntType()
local info=self.typesDatas[self.selectMainIndex or 1]
return info[1]
end

function UILingShanIntelligenceWin:refresh()


self.itemScrollView:removeAllGrids()
self.datas=self:getDatas()
self.itemScrollView:createMainGrids(#self.datas,1,true)
end

function UILingShanIntelligenceWin:hideReddot()
local check=UILSZDControl:checkQingBaoReddot()
if check then
UILSZDControl:setQingBaoReddot()
UIManager:callWindowFunc('UIXM_ZZSH_entitySelectWin','refreshAllMenuItemReddot')
UIManager:callWindowFunc('UIXM_ZZSH_PvEMainWin','refreshQingBaoReddot')
end
end

function UILingShanIntelligenceWin:getDatas()
local datas=UILSZDControl:getDatas()
local list={}
for i,v in ipairs(self.typesDatas)do
local lsd={
type=v[1],
name=v[2]
}
local dlist={}
for k,vv in pairs(datas)do
if vv.mountType==v[1]then
table.insert(dlist,vv)
end
end
lsd.list=dlist
table.insert(list,lsd)
end
return list
end

function UILingShanIntelligenceWin:playEnterAnim()
if not newbieControl.isInNewbie()then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-393,-1))
self.uiPanel:setChildDOAnchorPosX(118,0.2,nil)
end
UIManager:invokeUIMethod('UIXM_ZZSH_entitySelectWin','playEnterAnim')
end

function UILingShanIntelligenceWin:playLeaveAnim()
self.uiPanel:setChildDOAnchorPosX(-393,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil
self:closeSelf()
end)
end


function UILingShanIntelligenceWin:onHide()

end

function UILingShanIntelligenceWin:refreshSubItemSelect(subItem,mainIndex,subIndex,flag)
if subItem==nil then
subItem=self.itemScrollView:getSubItem(mainIndex-1,subIndex-1)
end
if subItem then
subItem:SetChildActive(0,flag)
end
end

function UILingShanIntelligenceWin:mainClickAction(mainItem)
local index=mainItem.Index+1

if self.selectSubIndex then
local item=self.itemScrollView:getSubItem(self.selectMainIndex-1,self.selectSubIndex-1)
item:SetChildActive(0,false)
end

if self.selectMainIndex then
local item=self.itemScrollView:getMainItem(self.selectMainIndex-1)
item:SetChildActive(1,true)
item:SetChildActive(2,false)
end

self.selectMainIndex=index

if mainItem.isExpanded then
mainItem:SetChildActive(1,false)
mainItem:SetChildActive(2,true)
end
end

function UILingShanIntelligenceWin:subClickAction(subItem)
local index=subItem.Index+1
local mainIndex=subItem.Mainindex+1

if self.selectSubIndex then
local item=self.itemScrollView:getSubItem(self.selectMainIndex-1,self.selectSubIndex-1)
item:SetChildActive(0,false)
end

self.selectSubIndex=index
self.selectMainIndex=mainIndex

subItem:SetChildActive(0,true)

local data=self.datas[mainIndex]
local mdata=data.list[index]
local ent=zhengzhanshanhaiModel:getEntity(mdata.ojbID)
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','move2GridPos',ent.g_x,ent.g_y,0,false,0,function()
UILSZDControl:showLSZDWinEx({mountId=mdata.mountId},true)
end)
end

function UILingShanIntelligenceWin:mainCreateAction(mainItem)
local index=mainItem.Index+1
local data=self.datas[index]
mainItem:SetAddExpandColumCount(#data.list)
mainItem:SetChildText(0,data.name)
mainItem:SetChildActive(1,true)
mainItem:SetChildActive(2,false)
if index==#self.datas then
if self.mount_type then
local sid=self.mtypeToIndex[self.mount_type]
self.itemScrollView:clickItem(sid-1)
self.mount_type=nil
else
local sid
for i,v in ipairs(self.datas)do
if#v.list>0 then
sid=i
break
end
end
if sid then
self.itemScrollView:clickItem(sid-1)
end
end
end
end

function UILingShanIntelligenceWin:subCreateAction(subItem)
local index=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local data=self.datas[mainIndex]
local mdata=data.list[index]
subItem:SetChildCSImageSprite(1,self.abName,self.iconNames[mdata.mountType])
subItem:SetChildText(2,mdata.mountName)
local num=UILSZDControl:getMountTeamNum(mdata.mountId)
local max=UILSZDControl:getMountMaxTeamNum(mdata.mountId)
subItem:SetChildText(3,FMT.fmt('{0}/{1}',num,max))
local check=UILSZDControl:hasMyTeam(mdata.mountId)
subItem:SetChildActive(4,check)
end

function UILingShanIntelligenceWin:onExpandAction(index)

end

function UILingShanIntelligenceWin:onDropdownChange(index)

end





function UILingShanIntelligenceWin:onJumpBtn()
end

