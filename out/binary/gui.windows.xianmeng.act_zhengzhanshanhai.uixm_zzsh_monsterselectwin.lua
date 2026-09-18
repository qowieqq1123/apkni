







def_class("UIXM_ZZSH_monsterSelectWin",UIWindowBase)









function UIXM_ZZSH_monsterSelectWin:bindComponents()

self.uiPanel=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.itemScrollView=UIComboScrollView.get(self,2)
self.sortTypeDropdown=UIDropdown.get(self,3)
self.noSign=UIObject.get(self,4)
self.jumpBtn=UIButton.get(self,5)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)



end


function UIXM_ZZSH_monsterSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.uiPanel);self.uiPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.itemScrollView);self.itemScrollView=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
end
















local _this


function UIXM_ZZSH_monsterSelectWin:onLoaded(...)
_this=self
self:bindComponents()
local _mainClickAction=function(...)self:mainClickAction(...)end
local _subClickAction=function(...)self:subClickAction(...)end
local _mainCreateAction=function(...)self:mainCreateAction(...)end
local _subCreateAction=function(...)self:subCreateAction(...)end
local _onExpandAction=function(...)self:onExpandAction(...)end
self.itemScrollView:setAction(_mainClickAction,_subClickAction,_mainCreateAction,_subCreateAction,_onExpandAction)
self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
self.mapView=UIManager:invokeUIMethod('UIXM_ZZSH_entitySelectWin','getMapView')
end

function UIXM_ZZSH_monsterSelectWin:getMapView()
return self.mapView
end


function UIXM_ZZSH_monsterSelectWin:__delete()
_this=nil
self:unbindComponents()
UIManager:invokeUIMethod('UIXM_ZZSH_monsterInfoWin','refreshMask')
UIManager:invokeUIMethod('UIXM_ZZSH_resourceInfoWin','refreshMask')
local mapView=self.mapView
if mapView then
local check
if UIManager:isActive('UIXM_ZZSH_monsterInfoWin')then
check=true
elseif UIManager:isActive('UIXM_ZZSH_resourceInfoWin')then
check=true
end
if not check and mapView.isChange then
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','setMapView',mapView)
end
end
end


function UIXM_ZZSH_monsterSelectWin:onHide()

end




function UIXM_ZZSH_monsterSelectWin:onShow(argtable,afterOnloaded)
self.defaultMainIndex=1
if self.qbguid~=nil then
if not UIManager:invokeUIMethod('UIXM_ZZSH_monsterInfoWin','containQBGuid',self.qbguid)then
self.qbguid=nil
end
end
self.needtime={}
local names={'异兽等阶','出击路程'}
self.sortTypeDropdown:setOption(names)
self.sortType=1
self.sortCondition={}
self.sortOrder=eSortOrder.eDown
self.lockRefresh=true
self.sortTypeDropdown:setValue(self.sortType-1)
self.lockRefresh=false

self:setSubTimer()
self:initInfo()
self:refreshInfo()
if afterOnloaded and argtable.isInit then
self:playEnterAnim()
end
end

function UIXM_ZZSH_monsterSelectWin:playEnterAnim()
if not newbieControl.isInNewbie()then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-393,-1))
self.uiPanel:setChildDOAnchorPosX(118,0.2,nil)
end
UIManager:invokeUIMethod('UIXM_ZZSH_entitySelectWin','playEnterAnim')
end

function UIXM_ZZSH_monsterSelectWin:playLeaveAnim()
self.uiPanel:setChildDOAnchorPosX(-393,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil
self:closeSelf()
end)
end

function UIXM_ZZSH_monsterSelectWin:refreshView()
self.qbguid=nil
local isChange=self:initInfo(true)
if isChange then
self:refreshInfo(true)
end
end

function UIXM_ZZSH_monsterSelectWin:onDropdownChange(idx)
if self.closeLock then return end
if self.lockRefresh then return end
idx=idx+1
self.sortType=idx

self:refreshInfo(true)
end

function UIXM_ZZSH_monsterSelectWin:onSortConditionClick()
if self.closeLock then return end
local args={}
args.infotype=zhengzhanshanhaiModel.qbType.eMonster
args.callback=self.selecConditionBack
args.sortCondition=table.deepCopy(self.sortCondition)
UIManager:showWindow('UIXM_ZZSH_filterWin',args)
end

function UIXM_ZZSH_monsterSelectWin.selecConditionBack(sortCondition)
if _this==nil then
return
end
if sortCondition[1]and next(sortCondition[1])==nil then
sortCondition[1]=nil
end
_this.sortCondition=sortCondition

_this:refreshInfo(true)
end

function UIXM_ZZSH_monsterSelectWin:onSortOrderClick()
if self.closeLock then return end
self.sortOrder=not self.sortOrder
self:refreshInfo(true)
end

function UIXM_ZZSH_monsterSelectWin:getQBData(qbData)
local d={}
d.qbguid=qbData.guid
local cfg=qbData:getCfg()
d.stage=cfg.stage
d.costTime=zhengzhanshanhaiModel:getQingBaoWayTime(qbData)
return d
end

function UIXM_ZZSH_monsterSelectWin:sortList()
local list={}
for i,v in ipairs(self.qbPageList_old)do
local qblist=v.qblist
local temp={}
for i2,v2 in ipairs(v.qblist)do
local add=true
if self.sortCondition then
local add2=true
if self.sortCondition[1]then
local idx=6-v2.stage
add2=self.sortCondition[1][idx]==true
end
add=add and add2
add2=true
if self.sortCondition[2]then
add2=v2.costTime<=self.sortCondition[2]
end
add=add and add2
end
if add then
table.insert(temp,v2)
end
end
local n=#temp
if n>1 then
local sortType=self.sortType
local sortOrder=self.sortOrder
table.sort(temp,function(a,b)
if sortType==1 then
if a.reddot==b.reddot then

if a.stage==b.stage then
return helper.sortOrderComparis(a.costTime,b.costTime,sortOrder)
else
return helper.sortOrderComparis(a.stage,b.stage,sortOrder)
end
else
return a.reddot>b.reddot
end
else
if a.reddot==b.reddot then

if a.costTime==b.costTime then
return helper.sortOrderComparis(a.stage,b.stage,sortOrder)
else
return helper.sortOrderComparis(a.costTime,b.costTime,sortOrder)
end
else
return a.reddot>b.reddot
end
end
end)
end
if n>0 then
local page={name=v.name,qblist=temp}
table.insert(list,page)
end
end
return list
end

function UIXM_ZZSH_monsterSelectWin:initInfo(isInit)
local temp=UIManager:invokeUIMethod('UIXM_ZZSH_entitySelectWin','getQingBaoList',zhengzhanshanhaiModel.qbType.eMonster,isInit)
local isChange=temp~=nil
if not isChange then
return false
end

local lp={}
for i,v in ipairs(temp)do
local qbData=zhengzhanshanhaiModel:getQingBaoData(v[1])
local xmData,flag=qbData:getXM()
if xmData~=nil then
if xmData:checkMyXM()then
if lp[1]==nil then lp[1]={qblist={},name='专属异兽'}end
local qblist=lp[1].qblist
local d=self:getQBData(qbData)
d.reddot=v[2]
d.ZSflag=flag
table.insert(qblist,d)
end
else
if lp[2]==nil then lp[2]={qblist={},name='无主异兽'}end
local qblist=lp[2].qblist
local d=self:getQBData(qbData)
d.reddot=v[2]
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
return true
end

function UIXM_ZZSH_monsterSelectWin:refreshInfo(click)
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

function UIXM_ZZSH_monsterSelectWin:getQBIndex(guid)
for i,v in ipairs(self.qbPageList)do
for i2,v2 in ipairs(v.qblist)do
if v2.qbguid==guid then
return i,i2
end
end
end
return nil,nil
end



function UIXM_ZZSH_monsterSelectWin:refreshMainItemSelect(mainItem,mainIndex,flag)
if mainItem==nil then
mainItem=self.itemScrollView:getMainItem(mainIndex-1)
end
if mainItem then
mainItem:SetChildActive(1,not flag)
mainItem:SetChildActive(2,flag)
end
end

function UIXM_ZZSH_monsterSelectWin:refreshMainItemReddot(mainItem,mainIndex)
if mainItem==nil then
mainItem=self.itemScrollView:getMainItem(mainIndex-1)
end
if mainItem then
local isReddot=false
local page=self.qbPageList[mainIndex]
for i,d in ipairs(page.qblist)do
if d.reddot==1 then
isReddot=true
break
end
end
mainItem:SetChildActive(3,isReddot)
end
end

function UIXM_ZZSH_monsterSelectWin:refreshSubItemSelect(subItem,mainIndex,subIndex,flag)
if subItem==nil then
subItem=self.itemScrollView:getSubItem(mainIndex-1,subIndex-1)
end
if subItem then
subItem:SetChildActive(7,flag)
end
end

function UIXM_ZZSH_monsterSelectWin:refreshSubItemReddot(subItem,mainIndex,subIndex)
if subItem==nil then
subItem=self.itemScrollView:getSubItem(mainIndex-1,subIndex-1)
end
if subItem then
local isReddot=false
local page=self.qbPageList[mainIndex]
local d=page.qblist[subIndex]
if d and d.reddot==1 then
isReddot=true
end
subItem:SetChildActive(10,isReddot)
end
end

function UIXM_ZZSH_monsterSelectWin:mainClickAction(mainItem)
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

function UIXM_ZZSH_monsterSelectWin:subClickAction(subItem)
if self.closeLock then return end
local subIndex=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local page=self.qbPageList[mainIndex]
local d=page.qblist[subIndex]
local guid=d.qbguid
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData==nil then
UIManager.info('该异兽已被消灭')
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

local infotype=qbData.infotype
if infotype==zhengzhanshanhaiModel.qbType.eMonster then
if UIManager:isActive('UIXM_ZZSH_resourceInfoWin')then
UIManager:invokeUIMethod('UIXM_ZZSH_resourceInfoWin','clearMapView')
UIManager:closeWindow('UIXM_ZZSH_resourceInfoWin')
end
if not UIManager:invokeUIMethod('UIXM_ZZSH_monsterInfoWin','containQBGuid',guid)then
zhengzhanshanhaiModel:checkQingBaoDetail(guid)
end
else
if UIManager:isActive('UIXM_ZZSH_monsterInfoWin')then
UIManager:invokeUIMethod('UIXM_ZZSH_monsterInfoWin','clearMapView')
UIManager:closeWindow('UIXM_ZZSH_monsterInfoWin')
end
if not UIManager:invokeUIMethod('UIXM_ZZSH_resourceInfoWin','containQBGuid',guid)then
zhengzhanshanhaiModel:checkQingBaoDetail(guid)
end
end
end

function UIXM_ZZSH_monsterSelectWin:mainCreateAction(mainItem)

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

function UIXM_ZZSH_monsterSelectWin:subCreateAction(subItem)
local index=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local page=self.qbPageList[mainIndex]
local qblist=page.qblist
local d=qblist[index]
local guid=d.qbguid
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData==nil then return end
local cfg=qbData:getCfg()

local bgIcon=FMT.fmt('image_gwtouxiangpjk_{0}',cfg.stage)
subItem:SetChildCSImageSprite(0,globalABLookup.global,bgIcon)

local groupid=cfg.monster[1]
comHelper.setChildModelRawImage_monsterGroup(subItem,groupid,1,0,eHeadCenterType.eHead)

local stageBGIcon=FMT.fmt('image_gwtouxiangdjk_{0}',cfg.stage)
subItem:SetChildCSImageSprite(2,globalABLookup.global,stageBGIcon)
subItem:SetChildText(3,tostring(cfg.stage))





local nameStr=qbData:getName()



subItem:SetChildText(4,nameStr)

local time_str=timeHelper.format_time_stamp3(d.costTime)
subItem:SetChildText(6,time_str)



subItem:SetChildActive(11,d.ZSflag and d.ZSflag==1 or false)
if d.ZSflag==1 then
self:SetNeedTime(subItem)
local lerp=self:judetime()
if lerp>0 then
self:refreshMyQBTime(subItem,lerp)
end
end


self:refreshSubItemSelect(subItem,mainIndex,index,self.qbguid==guid)
self:refreshSubItemReddot(subItem,mainIndex,index)
end


function UIXM_ZZSH_monsterSelectWin:onExpandAction(index)


end



function UIXM_ZZSH_monsterSelectWin:onJumpBtn()
UIManager:invokeUIMethod('UIXM_ZZSH_entitySelectWin','onCloseBtn')
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','openWorldMap')
end


function UIXM_ZZSH_monsterSelectWin:SetNeedTime(subItem)
self.needtime[#self.needtime+1]=subItem

end

function UIXM_ZZSH_monsterSelectWin:setSubTimer()
local func
func=function()

local lerp=self:judetime()
if lerp>0 then

if next(self.needtime)then
for k,v in ipairs(self.needtime)do
self:refreshMyQBTime(v,lerp)
end
end

else

UIManager.error("活动已结束")
self.ZSTime=nil
end
end

func()
self.ZSTime=self:setTimer(1,0,func)

end



function UIXM_ZZSH_monsterSelectWin:refreshMyQBTime(subItem,lerp)




subItem:SetChildText(11,"限时:")
local time_str=FMT.fmt('{0}',timeHelper.format_time_stamp11(lerp))
subItem:SetChildText(12,time_str)
end

function UIXM_ZZSH_monsterSelectWin:judetime()
local remove=zhengzhanshanhaiController:getZZSHCfg('remove')
local y,m,d=timeHelper.getServerData()
local t1=timeHelper.timeServer(y,m,d,remove,0,0)
local cur=gameUtilityModel.getServerLongTime()
if cur>t1 then
local w=timeHelper.getWeakDateEx2(cur)
if w==5 then
t1=t1+(24-remove)*3600
else
t1=t1+86400
end
end
local lerp=t1-cur
return lerp
end
