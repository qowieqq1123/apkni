







def_class("UIXM_ZZSH_lingdiSelectWin",UIWindowBase)









function UIXM_ZZSH_lingdiSelectWin:bindComponents()

self.root=UIObject.get(self,0)
self.uiPanel=UIObject.get(self,1)
self.itemScrollView=UIComboScrollView.get(self,2)
self.noSign=UIObject.get(self,3)



end


function UIXM_ZZSH_lingdiSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.uiPanel);self.uiPanel=nil;
_UIObject_release(self.itemScrollView);self.itemScrollView=nil;
_UIObject_release(self.noSign);self.noSign=nil;
end
















local _this


function UIXM_ZZSH_lingdiSelectWin:onLoaded(...)
_this=self
self:bindComponents()
local _mainClickAction=function(...)self:mainClickAction(...)end
local _subClickAction=function(...)self:subClickAction(...)end
local _mainCreateAction=function(...)self:mainCreateAction(...)end
local _subCreateAction=function(...)self:subCreateAction(...)end
local _onExpandAction=function(...)self:onExpandAction(...)end
self.itemScrollView:setAction(_mainClickAction,_subClickAction,_mainCreateAction,_subCreateAction,_onExpandAction)
self.mapView=UIManager:invokeUIMethod('UIXM_ZZSH_entitySelectPvPWin','getMapView')
end


function UIXM_ZZSH_lingdiSelectWin:__delete()
_this=nil
self:unbindComponents()
local mapView=self.mapView
if mapView then
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','setMapView',mapView)
end
end


function UIXM_ZZSH_lingdiSelectWin:onHide()

end




function UIXM_ZZSH_lingdiSelectWin:onShow(argtable,afterOnloaded)
self.defaultMainIndex=1

self:initInfo()
self:refreshInfo()
if afterOnloaded and argtable.isInit then
self:playEnterAnim()
end
end

function UIXM_ZZSH_lingdiSelectWin:playEnterAnim()
if not newbieControl.isInNewbie()then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-393,-1))
self.uiPanel:setChildDOAnchorPosX(118,0.2,nil)
end
UIManager:invokeUIMethod('UIXM_ZZSH_entitySelectPvPWin','playEnterAnim')
end

function UIXM_ZZSH_lingdiSelectWin:playLeaveAnim()
self.uiPanel:setChildDOAnchorPosX(-393,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil
self:closeSelf()
end)
end

function UIXM_ZZSH_lingdiSelectWin:sortList()
local list={}
for i,v in ipairs(self.qbPageList_old)do
local qblist=v.qblist
local temp={}
for i2,v2 in ipairs(v.qblist)do
local add=true
if add then
table.insert(temp,v2)
end
end
local n=#temp
if n>1 then
local sortType=self.sortType
local sortOrder=self.sortOrder
table.sort(temp,function(a,b)
return helper.sortOrderComparis(a.costTime,b.costTime,eSortOrder.eUp)
end)
end
if n>0 then
local page={name=v.name,qblist=temp}
table.insert(list,page)
end
end
return list
end

function UIXM_ZZSH_lingdiSelectWin:initInfo()
local ldlp=zhengzhanshanhaiModel:getAllLDLookup()

local lp={}
local g_x,g_y=zhengzhanshanhaiModel:getMyXMGridPos()
if ldlp then
for k,v in pairs(ldlp)do
local cfg=zhengzhanshanhaiModel:getLingDiCfg(v.domainid)
local qblist
if cfg.type==1 then
if lp[1]==nil then lp[1]={typo=1,qblist={},name='洞天'}end
qblist=lp[1].qblist
else
if lp[2]==nil then lp[2]={typo=1,qblist={},name='福地'}end
qblist=lp[2].qblist
end
local d={}
d.domainid=v.domainid
d.name=cfg.name
d.costTime=zhengzhanshanhaiModel:calculateWayTime_pvp(g_x,g_y,v.x,v.y)
table.insert(qblist,d)
end
end
local list={}
for i=1,2 do
local page=lp[i]
if page then
table.insert(list,page)
end
end
self.qbPageList_old=list
end

function UIXM_ZZSH_lingdiSelectWin:refreshInfo(click)
self.qbPageList=self:sortList()
local c=#self.qbPageList
local isshow=c>0
self.itemScrollView:setActive(isshow)
self.noSign:setActive(not isshow)
if isshow then
self.itemScrollView:removeAllGrids()
self.mainIndex=nil
if click then
self.defaultMainIndex=1
end
self.itemScrollView:createMainGrids(c,1,true)
end
end

function UIXM_ZZSH_lingdiSelectWin:getQBIndex(guid)
for i,v in ipairs(self.qbPageList)do
for i2,v2 in ipairs(v.qblist)do
if v2.domainid==guid then
return i,i2
end
end
end
return nil,nil
end



function UIXM_ZZSH_lingdiSelectWin:refreshMainItemSelect(mainItem,mainIndex,flag)
if mainItem==nil then
mainItem=self.itemScrollView:getMainItem(mainIndex-1)
end
if mainItem then
mainItem:SetChildActive(1,not flag)
mainItem:SetChildActive(2,flag)
end
end

function UIXM_ZZSH_lingdiSelectWin:refreshMainItemReddot(mainItem,mainIndex)
if mainItem==nil then
mainItem=self.itemScrollView:getMainItem(mainIndex-1)
end
if mainItem then
local isReddot=false
mainItem:SetChildActive(3,isReddot)
end
end

function UIXM_ZZSH_lingdiSelectWin:refreshSubItemSelect(subItem,mainIndex,subIndex,flag)
if subItem==nil then
subItem=self.itemScrollView:getSubItem(mainIndex-1,subIndex-1)
end
if subItem then
subItem:SetChildActive(0,flag)
end
end

function UIXM_ZZSH_lingdiSelectWin:mainClickAction(mainItem)
local oldMainIndex=self.mainIndex
local index=mainItem.Index+1
if index==oldMainIndex then
if oldMainIndex~=nil then
self:refreshMainItemSelect(nil,oldMainIndex,false)
self:refreshMainItemReddot(nil,oldMainIndex)
self.mainIndex=nil
end
return
end
self.mainIndex=index
self:refreshMainItemSelect(mainItem,index,true)
self:refreshMainItemReddot(mainItem,index)
if oldMainIndex~=nil then
self:refreshMainItemSelect(nil,oldMainIndex,false)
self:refreshMainItemReddot(nil,oldMainIndex)
end
end

function UIXM_ZZSH_lingdiSelectWin:subClickAction(subItem)
if self.closeLock then return end
local subIndex=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local page=self.qbPageList[mainIndex]
local d=page.qblist[subIndex]
local guid=d.domainid
local ldData=zhengzhanshanhaiModel:getLDData(guid)
if ldData==nil then
return
end

local old_qbguid=self.qbguid
self.qbguid=guid
local ischange=old_qbguid~=guid
if ischange then
if old_qbguid~=nil then
local oldMainIndex,oldSubIndex=self:getQBIndex(old_qbguid)
self:refreshSubItemSelect(nil,oldMainIndex,oldSubIndex,false)
end
self:refreshSubItemSelect(subItem,mainIndex,subIndex,true)
end

UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','move2GridPos',ldData.x,ldData.y,0,false,2,function(view)
if _this==nil then return end
if _this.mapView then
_this.mapView.g_x=view.g_x
_this.mapView.g_y=view.g_y
end
end)
end

function UIXM_ZZSH_lingdiSelectWin:mainCreateAction(mainItem)
local index=mainItem.Index+1
local page=self.qbPageList[index]
if page then
local qblist=page.qblist
local name=page.name
mainItem:SetChildText(0,name)

self:refreshMainItemSelect(mainItem,index,false)

self:refreshMainItemReddot(mainItem,index)

mainItem:SetAddExpandColumCount(#qblist)
if index==#self.qbPageList then
if self.defaultMainIndex~=nil then
self.itemScrollView:clickItem(self.defaultMainIndex-1)
self.defaultMainIndex=nil
end
end
end
end

function UIXM_ZZSH_lingdiSelectWin:subCreateAction(subItem)
local index=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local page=self.qbPageList[mainIndex]
local qblist=page.qblist
local d=qblist[index]
local guid=d.domainid
local ldData=zhengzhanshanhaiModel:getLDData(guid)
if ldData==nil then
return
end


subItem:SetChildText(1,d.name)

local time_str=timeHelper.format_time_stamp3(d.costTime)
subItem:SetChildText(2,time_str)
local xmName
local ismy=false
local xmData=ldData:getXM()
if xmData then
ismy=xmData:checkMyXM()
xmName=FMT.fmt('归属：<color=#7d3b17>{0}</color>',xmData.guildname)
else
xmName='归属：无'
end
subItem:SetChildText(3,xmName)

local showSign=ismy
subItem:SetChildActive(4,showSign)
if showSign then
local icon='image_benmeng_1'
subItem:SetChildCSImageSprite(4,globalABLookup.zzshicons,icon)
end

local state_str
if zhengzhanshanhaiModel:checkHasOrder(nil,guid)then
state_str='即将进攻'
end
local showState=state_str~=nil
subItem:SetChildActive(5,showState)
if showState then
subItem:SetChildText(6,state_str)
end

self:refreshSubItemSelect(subItem,mainIndex,index,self.qbguid==guid)
end


function UIXM_ZZSH_lingdiSelectWin:onExpandAction(index)

end

