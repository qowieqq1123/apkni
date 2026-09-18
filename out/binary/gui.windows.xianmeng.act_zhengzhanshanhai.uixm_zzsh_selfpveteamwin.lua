







def_class("UIXM_ZZSH_selfPVETeamWin",UIWindowBase)









function UIXM_ZZSH_selfPVETeamWin:bindComponents()

self.mask=UIObject.get(self,0)
self.titleTxt=UIText.get(self,1)
self.itemScrollView=UIObject.get(self,2)
self.noSign=UIObject.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.itemPanel=UIObject.get(self,5)
self.uiPanel=UIObject.get(self,6)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXM_ZZSH_selfPVETeamWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.itemScrollView);self.itemScrollView=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.uiPanel);self.uiPanel=nil;
end
















local _this


function UIXM_ZZSH_selfPVETeamWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onZZSHPvEWaiPaiChange,self.onZZSHPvEWaiPaiChange)

self.mapView=UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','getMapView')
end

function UIXM_ZZSH_selfPVETeamWin:getMapView()
return self.mapView
end


function UIXM_ZZSH_selfPVETeamWin:__delete()
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


function UIXM_ZZSH_selfPVETeamWin:onHide()

end




function UIXM_ZZSH_selfPVETeamWin:onShow(argtable,afterOnloaded)
self:playEnterAnim()
self:refreshMyWaiPai()

if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshAllTeamItemTime()
end)
end
end

function UIXM_ZZSH_selfPVETeamWin:playEnterAnim()
self.uiPanel:setChildCanvasGroupAlpha(0)
self.uiPanel:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-618,2))
self.uiPanel:setChildDOAnchorPosX(1,0.2,nil)
end

function UIXM_ZZSH_selfPVETeamWin:playLeaveAnim()
self.uiPanel:setChildDOAnchorPosX(-618,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil
self:closeSelf()
end)
end

function UIXM_ZZSH_selfPVETeamWin:refreshMyWaiPai()
self.mPvEWaiPaiList=zhengzhanshanhaiModel:getMyPvEWaiPaiList()
local cur=#self.mPvEWaiPaiList
local max=zhengzhanshanhaiModel:getMaxWaiPaiNum()

local num_str=FMT.fmt('外派队伍({0}/{1})',cur,max)
self.titleTxt:setText(num_str)

local isshow=cur>0
self.itemScrollView:setActive(isshow)
self.noSign:setActive(not isshow)
if isshow then
self.itemPanel:setChildLayoutGroupCreateItems(cur,function(idx)
if _this==nil then return end
local item=_this.itemPanel:getChildLayoutGroupGridItem(idx-1)
local wpData=_this.mPvEWaiPaiList[idx]

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onWaiPaiClick(idx)
end)

item:SetChildText(1,tostring(idx))

local state_str=''
local teamData=wpData:getTeamData()
if teamData then
local state=teamData:getState()
state_str=state
else
state_str=''
end
local name_str=wpData:getColorName2('【{0}】')
state_str=FMT.fmt('{0}　　　{1}',state_str,name_str)
item:SetChildText(2,state_str)

local infotype=wpData:get_infotype()
local signIonc
if infotype==zhengzhanshanhaiModel.qbType.eMonster then
signIonc='icon_shsjdwui_1'
else
signIonc='icon_shsjdwui_2'
end
item:SetChildCSImageSprite(5,globalABLookup.zzshicons,signIonc)

local dzlist=wpData.guidList or{}
local dznum=5
item:SetChildLayoutGroupCreateItems(6,dznum)
local grids=item:GetChildLayoutGroupGridList(6)
for i=1,dznum do
local dzguid=dzlist[i]
local dzitem=grids[i-1]
local has=dzguid~=nil and tostring(dzguid)~='0'
local image=UIDiscipleModel:getDiscipleImageInfo(dzguid)
if has then
image=UIDiscipleModel:getDiscipleImageInfo(dzguid)
has=image~=nil
end
dzitem:SetChildActive(0,not has)
dzitem:SetChildActive(1,has)
dzitem:SetChildButtonClick(-1,function()
if _this==nil then return end
_this:onHeadClick(idx)
end)
if has then

comHelper.setChildModelHeadIconBGByColor(dzitem,1,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(2,dzitem,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
dzitem:SetChildCSImageSprite(3,globalABLookup.global,jobicon)
end
end

local showLook=false
local showBack=false
if infotype==zhengzhanshanhaiModel.qbType.eMonster then
showLook=true
else
showBack=true
end
item:SetChildActive(7,showLook)
item:SetChildActive(8,showBack)
item:SetChildButtonClick(7,function()
if _this==nil then return end
_this:onWaiPaiClick(idx)
end)
item:SetChildButtonClick(8,function()
if _this==nil then return end
_this:onBackClick(idx)
end)

_this:refreshTeamItemInfo(item,idx,true)

_this:refreshTeamItemTime(item,idx)

_this:refreshTeamItemSelect(item,idx)
end)
end
end

function UIXM_ZZSH_selfPVETeamWin:refreshTeamItemSelect(item,idx)
if item==nil then
item=self.itemPanel:getChildLayoutGroupGridItem(idx-1)
end
if item==nil then return end
local wpData=self.mPvEWaiPaiList[idx]
local isSelect=wpData.guid==self.curSelect
local icon=isSelect and'image_shsjdwui_4'or'image_shsjdwui_3'
item:SetChildCSImageSprite(0,globalABLookup.zzshicons,icon)
end

function UIXM_ZZSH_selfPVETeamWin:refreshTeamItemInfo(item,idx,isInit)
if item==nil then
item=self.itemPanel:getChildLayoutGroupGridItem(idx-1)
end
if item==nil then return end
local wpData=self.mPvEWaiPaiList[idx]
local infotype=wpData:get_infotype()
local qbData=wpData:getQingBaoData()
local detail
if qbData then
local check=isInit==true
detail=qbData:getDetail(check)
end
local teamData=wpData:getTeamData()

local showLife=false
if infotype==zhengzhanshanhaiModel.qbType.eMonster and teamData~=nil and detail~=nil then
showLife=true
end
item:SetChildActive(9,showLife)
if showLife then
local percent=detail.percent
item:SetChildIconFillAmount(10,percent/10000)
local rate_str=FMT.fmt('{0}%',percent/100)
item:SetChildText(11,rate_str)
end

local showRes=false
if infotype==zhengzhanshanhaiModel.qbType.eResource and teamData~=nil and detail~=nil then
showRes=true
end
item:SetChildActive(12,showRes)
if showRes then
self:refreshTeamItemInfoRes(item,qbData,teamData,wpData,detail)
end

if isInit and teamData~=nil and detail==nil then
if qbData then
zhengzhanshanhaiModel:reqQingBaoDetail(qbData)
end
end
end

function UIXM_ZZSH_selfPVETeamWin:refreshTeamItemInfoRes(item,qbData,teamData,wpData,detail)
local cfg=qbData:getCfg()
local speed,keep=wpData:getDZGroupCollectCfg2()
local res,add=wpData:getDZGroupCollectCfg(cfg.moneytype)
local state,time=teamData:getState()
local cur
if teamData.sec>0 then
cur=math.floor(speed*time)
else
cur=0
end
local lerp=detail:getLerpRes()

local max_=math.min(cur+lerp,keep)
local rate
if max_==0 then
rate=0
cur=0
else
if cur>max_ then cur=max_ end
rate=cur/max_
end
item:SetChildIconFillAmount(13,rate)
local rate_str=FMT.fmt('{0}/{1}',mathHelper.formatNumber4(cur,2),mathHelper.formatNumber4(max_,2))
item:SetChildText(14,rate_str)

local str=FMT.fmt('{0}/每分钟',math.floor(speed*60))
if add[1]>0 then
str=FMT.fmt('{0}<color=#ca631d>(+{1}%)</color>',str,add[1])
end
item:SetChildText(4,str)
end

function UIXM_ZZSH_selfPVETeamWin:findItemIndex(guid)
if self.mPvEWaiPaiList then
for idx,v in ipairs(self.mPvEWaiPaiList)do
if v.guid==guid then
return idx
end
end
end
return nil
end

function UIXM_ZZSH_selfPVETeamWin:refreshAllTeamItemTime()
if self.mPvEWaiPaiList then
local num=#self.mPvEWaiPaiList
if num>0 then
for idx,v in ipairs(self.mPvEWaiPaiList)do
self:refreshTeamItemTime(nil,idx)
end
end
end
end

function UIXM_ZZSH_selfPVETeamWin:refreshTeamItemTime(item,idx)
if item==nil then
item=self.itemPanel:getChildLayoutGroupGridItem(idx-1)
end
if item==nil then return end
local wpData=self.mPvEWaiPaiList[idx]
local teamData=wpData:getTeamData()
if teamData==nil then return end

local state,time=teamData:getState(true)
local time_str
if time>=0 then
time_str=timeHelper.format_time_stamp3(time)
else
time_str=''
end
item:SetChildText(3,time_str)

local detail
local qbData=wpData:getQingBaoData()
if qbData then
detail=qbData:getDetail()
end
if detail==nil then return end
local infotype=wpData:get_infotype()

local showRes=false
if infotype==zhengzhanshanhaiModel.qbType.eResource and teamData~=nil and detail~=nil then
showRes=true
end
if showRes then
self:refreshTeamItemInfoRes(item,qbData,teamData,wpData,detail)
end
end

function UIXM_ZZSH_selfPVETeamWin:onHeadClick(idx)
if self.closeLock then return end
self:onWaiPaiClick(idx)
end

function UIXM_ZZSH_selfPVETeamWin:onWaiPaiClick(idx)
if self.closeLock then return end
local wpData=self.mPvEWaiPaiList[idx]
local qbData=wpData:getQingBaoData()
if qbData==nil then return end
local guid=wpData.guid
if guid~=self.curSelect then
local old=self.curSelect
self.curSelect=guid
if old then
local idx_=self:findItemIndex(old)
if idx_ then
self:refreshTeamItemSelect(nil,idx_)
end
end
self:refreshTeamItemSelect(nil,idx)
end

local infotype=wpData:get_infotype()
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

function UIXM_ZZSH_selfPVETeamWin:onBackClick(idx)
if self.closeLock then return end
local wpData=self.mPvEWaiPaiList[idx]
local qbData=wpData:getQingBaoData()
if qbData==nil then return end
local guid=wpData.guid
local content='是否确认撤回该队伍？'
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=function()
if _this==nil then return end
local wpData_=_this.mPvEWaiPaiList[idx]
if wpData_ and wpData_.guid==guid then
local qbData_=wpData_:getQingBaoData()
if qbData_ then
zhengzhanshanhaiController:reqPvETeamBack(guid)
end
end
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end

function UIXM_ZZSH_selfPVETeamWin:onClickMask()
if self.closeLock then return end
self:onCloseBtn()
end

function UIXM_ZZSH_selfPVETeamWin:onCloseBtn()
if self.closeLock then return end
self:playLeaveAnim()
end

function UIXM_ZZSH_selfPVETeamWin:rcv_qbDetail(guid)
local idx=self:findItemIndex(guid)
if idx then
self:refreshTeamItemInfo(nil,idx)
end
end

function UIXM_ZZSH_selfPVETeamWin.onZZSHPvEWaiPaiChange(opType,qbGuid)
if _this==nil or not _this.isVisible then return end

_this:refreshMyWaiPai()
end