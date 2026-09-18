







def_class("UIXM_ZZSH_selectTeamWin",UIWindowBase)









function UIXM_ZZSH_selectTeamWin:bindComponents()

self.maskBlock=UIButton.get(self,0)
self.frameSp=UIObject.get(self,1)
self.pageSp=UIObject.get(self,2)
self.lockBtn=UIButton.get(self,3)
self.myTeamBtn=UIButton.get(self,4)
self.select2Obj=UIObject.get(self,5)
self.selectObj=UIObject.get(self,6)
self.maskFreeBtn=UIButton.get(self,7)
self.noSign=UIObject.get(self,8)
self.money1Root=UIObject.get(self,9)
self.closeBtn=UIButton.get(self,10)
self.root=UIObject.get(self,11)
self.lockImg=UIImage.get(self,12)
self.lockTxt=UIText.get(self,13)
self.maskFreeMark=UIImage.get(self,14)
self.atkPageGrid=UIObject.get(self,15)
self.atkTeamNumTxt=UIText.get(self,16)
self.atkDetailBtn=UIButton.get(self,17)
self.defDetailBtn=UIButton.get(self,18)
self.defTeamNumTxt=UIText.get(self,19)
self.teamScrollView=UIEnhancedScrollerLua.get(self,20)
self.atkScrollView=UIEnhancedScrollerLua.get(self,21)
self.defScrollView=UIEnhancedScrollerLua.get(self,22)

self.maskBlock:setButtonClick(function()self:onMaskBlock()end)

self.lockBtn:setButtonClick(function()self:onLockBtn()end)

self.myTeamBtn:setButtonClick(function()self:onMyTeamBtn()end)

self.maskFreeBtn:setButtonClick(function()self:onMaskFreeBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.atkDetailBtn:setButtonClick(function()self:onAtkDetailBtn()end)

self.defDetailBtn:setButtonClick(function()self:onDefDetailBtn()end)



end


function UIXM_ZZSH_selectTeamWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.maskBlock);self.maskBlock=nil;
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.pageSp);self.pageSp=nil;
_UIObject_release(self.lockBtn);self.lockBtn=nil;
_UIObject_release(self.myTeamBtn);self.myTeamBtn=nil;
_UIObject_release(self.select2Obj);self.select2Obj=nil;
_UIObject_release(self.selectObj);self.selectObj=nil;
_UIObject_release(self.maskFreeBtn);self.maskFreeBtn=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.money1Root);self.money1Root=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.lockImg);self.lockImg=nil;
_UIObject_release(self.lockTxt);self.lockTxt=nil;
_UIObject_release(self.maskFreeMark);self.maskFreeMark=nil;
_UIObject_release(self.atkPageGrid);self.atkPageGrid=nil;
_UIObject_release(self.atkTeamNumTxt);self.atkTeamNumTxt=nil;
_UIObject_release(self.atkDetailBtn);self.atkDetailBtn=nil;
_UIObject_release(self.defDetailBtn);self.defDetailBtn=nil;
_UIObject_release(self.defTeamNumTxt);self.defTeamNumTxt=nil;
_UIObject_release(self.teamScrollView);self.teamScrollView=nil;
_UIObject_release(self.atkScrollView);self.atkScrollView=nil;
_UIObject_release(self.defScrollView);self.defScrollView=nil;
end
















local UITeamScroller=simple_class(UIEnhancedScroller)
local UIAtkScroller=simple_class(UIEnhancedScroller)
local UIDefScroller=simple_class(UIEnhancedScroller)
local _this=nil


function UIXM_ZZSH_selectTeamWin:onLoaded(...)
_this=self
self:bindComponents()
self.scrollscript=UITeamScroller(self.teamScrollView:getGameObject(),self.teamScrollView:getCSharpObject(),nil,nil)
self.scrollscript_atk=UIAtkScroller(self.atkScrollView:getGameObject(),self.atkScrollView:getCSharpObject(),nil,nil)
self.scrollscript_def=UIDefScroller(self.defScrollView:getGameObject(),self.defScrollView:getCSharpObject(),nil,nil)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIXM_ZZSH_selectTeamWin:__delete()
_this=nil
self:unbindComponents()
UIManager:closeWindow('UIXM_ZZSH_teamInfoOneWin')
end


function UIXM_ZZSH_selectTeamWin:onHide()

end

function UIXM_ZZSH_selectTeamWin.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end
if moneyType==_this.costType then
_this:refreshMoney()
end
end




function UIXM_ZZSH_selectTeamWin:onShow(argtable,afterOnloaded)
local costType=zhengzhanshanhaiModel:getReverLingLiCostType()
self.costType=costType
local myActorid=playerModel:getActorID()
self.isManager=xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptZZSHSign)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(5285,1,{},0,false,false,0,function()
if _this==nil then return end

_this.root:setChildCanvasGroupDOFade(1,0.25,nil)

end)
self.pageSp:setChildUIModelShowTarget(5286,1,{},0,false,false,0,nil)
end
self.showFree=false
self.selectAtkPage=1
self:refreshView()
self:initMoney()


if self.isManager and self:checkState()then
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
if zrData:checkWillLost()then
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZZSHPvPtips)
if not check then
local content='当前阵容存在7天未登录的祖师的弟子队伍，是否自动卸下？\n(7天未登录的弟子队伍会直接判负)'
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=function()
zhengzhanshanhaiController:reqChangeAllPvPTeamAuto()
end,
showclosebtn=true,
choosetext="今日不再提示",
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZZSHPvPtips,flag)
end,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end
end
end
end

function UIXM_ZZSH_selectTeamWin:checkState(isWarning)
local raceState=zhengzhanshanhaiModel:getLunState()
if raceState==eZZSH_State.ePVPFight then
if isWarning then
UIManager.error('战争期无法进行此操作')
end
return false
end
return true
end

function UIXM_ZZSH_selectTeamWin:checkClickLock()
if self.clickLockTime~=nil and gameUtilityModel.getServerShortTime()-self.clickLockTime<zhengzhanshanhaiModel.clickBtnCoolTime then
return false
end
self.clickLockTime=gameUtilityModel.getServerShortTime()
return true
end

function UIXM_ZZSH_selectTeamWin:refreshView()
self:initAtkGrid()
self:refreshAtkNum()
self:refreshDefNum()
self:refreshTeamsSV()
self:refreshAtkTeamsSV()
self:refreshDefTeamsSV()
self:refreshMaskFreeBtn()
self:refreshLockBtn()
end

function UIXM_ZZSH_selectTeamWin:refreshAtkNum()
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
local num=zrData:getAtkTeamNum()
local max=zhengzhanshanhaiModel:getAtkTeamMaxNum()
local str=FMT.fmt('({0}/{1})',num,max)
self.atkTeamNumTxt:setText(str)
end

function UIXM_ZZSH_selectTeamWin:refreshDefNum()
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
local num=zrData:getDefTeamNum()
local max=zhengzhanshanhaiModel:getDefTeamMaxNum()
local str=FMT.fmt('({0}/{1})',num,max)
self.defTeamNumTxt:setText(str)
end

function UIXM_ZZSH_selectTeamWin:initAtkGrid()
local max=zhengzhanshanhaiModel:getMaxWaiPaiNum_pvp()
self.atkPageGrid:setChildLayoutGroupCreateItems(max)
local grids=self.atkPageGrid:getChildLayoutGroupGridList()
for i=1,max do
local item=grids[i-1]

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onAtkGridItemClick(i)
end)

local name_str=FMT.fmt('仙阵{0}',i)
item:SetChildText(1,name_str)
self:refreshAtkGridItemSelect(item,i,i==self.selectAtkPage)
self:refreshAtkGridItemReddot(item,i)
end
end

function UIXM_ZZSH_selectTeamWin:refreshAtkGridItemSelect(item,idx,flag)
if item==nil then
item=self.atkPageGrid:getChildLayoutGroupGridItem(idx-1)
end
local icon=flag==true and'button_shsjbianjixzui_2'or'button_shsjbianjixzui_1'
item:SetChildCSImageSprite(0,globalABLookup.zzshicons,icon)
end

function UIXM_ZZSH_selectTeamWin:refreshAtkGridItemReddot(item,idx)
if item==nil then
item=self.atkPageGrid:getChildLayoutGroupGridItem(idx-1)
end
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
local num=zrData:getAtkTeamNumEx(idx)
local isshow=num>0
item:SetChildActive(2,isshow)
if isshow then
item:SetChildText(3,tostring(num))
end
end

function UIXM_ZZSH_selectTeamWin:onAtkGridItemClick(idx)
if self.selectAtkPage==idx then
return
end
self:closeSelectObj()
if self.selectAtkPage then
self:refreshAtkGridItemSelect(nil,self.selectAtkPage,false)
end
self:refreshAtkGridItemSelect(nil,idx,true)
self.selectAtkPage=idx
self:refreshAtkTeamsSV(true)
end

function UIXM_ZZSH_selectTeamWin:refreshAllAtkGridItemReddot()
local max=zhengzhanshanhaiModel:getMaxWaiPaiNum_pvp()
local grids=self.atkPageGrid:getChildLayoutGroupGridList()
for i=1,max do
local item=grids[i-1]
self:refreshAtkGridItemReddot(item,i)
end
end

function UIXM_ZZSH_selectTeamWin:activeSelectObj(flag,item,dataIndex)
if flag then
if self.selectTeamIndex==dataIndex then
return
end
self:activeSelectObj2(false)
if self.selectTeamIndex then
self.scrollscript:refreshItemSelect(self.selectTeamIndex,nil,false)
self.selectTeamIndex=nil
end
local flag_=self.scrollscript:refreshItemSelect(dataIndex,item,true)
if flag_ then
self.selectTeamIndex=dataIndex
end
if flag_ then
self.teamScrollView:setChildScrollRectEnable(false)
self.selectObj:setActive(true)
local widget=self.selectObj:getWidgetBase()
local pos=item:GetChildScreenPointToLocalPointRectangle(-1)
widget:SetChildLocalPos(-1,pos.x,pos.y,0)
local data=self.teamsList[dataIndex]
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
local d=zrData:getSelected(data.teamguid_str)
local isSelect=d~=nil
local isSupport=data.actorData:checkSupport()
widget:SetChildActive(0,not isSelect)
widget:SetChildActive(1,not isSelect)
widget:SetChildActive(2,isSelect)
widget:SetChildActive(3,not isSelect and isSupport)
if isSelect then
widget:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onCancelArrow()
end)
else
if isSupport then
widget:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onBackArrow()
end)
else
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onLeftArrow()
end)
widget:SetChildButtonClick(1,function()
if _this==nil then return end
_this:onRightArrow()
end)
end
end
end
else
local ischange=false
if self.selectTeamIndex then
self.teamScrollView:setChildScrollRectEnable(true)
self.scrollscript:refreshItemSelect(self.selectTeamIndex,item,false)
self.selectTeamIndex=nil
ischange=true
end
if ischange then
self.selectObj:setActive(false)
end
end
end

function UIXM_ZZSH_selectTeamWin:onLeftArrow()
local dataIndex=self.selectTeamIndex
if dataIndex then
local data=self.teamsList[dataIndex]
if data then
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
local d=zrData:getSelected(data.teamguid_str)
local isSelect=d~=nil
if not isSelect then
local num=zrData:getAtkTeamNum()
local max=zhengzhanshanhaiModel:getAtkTeamMaxNum()
if num>=max then
UIManager.info(FMT.fmt('总攻击队伍数不能超过{0}',max))
else
local teamtype=self.selectAtkPage
num=zrData:getAtkTeamNumEx(teamtype)
if num>=max then
UIManager.info(FMT.fmt('单一仙阵队伍数不能超过{0}',max))
else
local idx=zrData:getInsertIndex(teamtype,data.teamfight_num)
if idx then
zhengzhanshanhaiController:reqChangePvPTeam(data.teamguid,teamtype,idx)
end
end
end
end
end
end
self:closeSelectObj()
end

function UIXM_ZZSH_selectTeamWin:onRightArrow()
local dataIndex=self.selectTeamIndex
if dataIndex then
local data=self.teamsList[dataIndex]
if data then
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
local d=zrData:getSelected(data.teamguid_str)
local isSelect=d~=nil
if not isSelect then
local num=zrData:getDefTeamNum()
local max=zhengzhanshanhaiModel:getDefTeamMaxNum()
if num>=max then
UIManager.info(FMT.fmt('总防守队伍数不能超过{0}',max))
else
local teamtype=0
local idx=zrData:getInsertIndex(teamtype,data.teamfight_num)
if idx then
zhengzhanshanhaiController:reqChangePvPTeam(data.teamguid,teamtype,idx)
end
end
end
end
end
self:closeSelectObj()
end

function UIXM_ZZSH_selectTeamWin:onCancelArrow()
local dataIndex=self.selectTeamIndex
if dataIndex then
local data=self.teamsList[dataIndex]
if data then
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
local d=zrData:getSelected(data.teamguid_str)
local isSelect=d~=nil
if isSelect then
zhengzhanshanhaiController:reqChangePvPTeam(data.teamguid,d.teamtype,-1)
end
end
end
self:closeSelectObj()
end

function UIXM_ZZSH_selectTeamWin:onBackArrow()
local dataIndex=self.selectTeamIndex
if dataIndex then

end
self:closeSelectObj()
end

function UIXM_ZZSH_selectTeamWin:activeSelectObj2(flag,item,dataIndex,typo)
if flag then
if typo==1 then
if self.selectAtkIndex==dataIndex then
return
end
else
if self.selectDefIndex==dataIndex then
return
end
end
self:activeSelectObj(false)
if self.selectAtkIndex then
if typo==2 then
self.atkScrollView:setChildScrollRectEnable(true)
end
self.scrollscript_atk:refreshItemSelect(self.selectAtkIndex,nil,false)
self.selectAtkIndex=nil
end
if self.selectDefIndex then
if typo==1 then
self.defScrollView:setChildScrollRectEnable(true)
end
self.scrollscript_def:refreshItemSelect(self.selectDefIndex,nil,false)
self.selectDefIndex=nil
end
local flag_
if typo==1 then
flag_=self.scrollscript_atk:refreshItemSelect(dataIndex,item,true)
if flag_ then
self.selectAtkIndex=dataIndex
end
else
flag_=self.scrollscript_def:refreshItemSelect(dataIndex,item,true)
if flag_ then
self.selectDefIndex=dataIndex
end
end
if flag_ then
if typo==1 then
self.atkScrollView:setChildScrollRectEnable(false)
else
self.defScrollView:setChildScrollRectEnable(false)
end
self.select2Obj:setActive(true)
local widget=self.select2Obj:getWidgetBase()
local pos=item:GetChildScreenPointToLocalPointRectangle(-1)
widget:SetChildLocalPos(-1,pos.x,pos.y,0)
widget:SetChildActive(0,typo==2)
widget:SetChildActive(1,typo==1)
if typo==1 then
widget:SetChildButtonClick(1,function()
if _this==nil then return end
_this:onCancelArrow2()
end)
else
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onCancelArrow2()
end)
end
local n
if typo==1 then
n=#self.teamsList_atk
else
n=#self.teamsList_def
end
local showUp=dataIndex>1
local showDown=dataIndex<n
widget:SetChildActive(2,showUp)
widget:SetChildActive(3,showDown)
if showUp then
widget:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onUpArrow()
end)
end
if showDown then
widget:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onDownArrow()
end)
end
end
else
local ischange=false
if self.selectAtkIndex then
self.atkScrollView:setChildScrollRectEnable(true)
self.scrollscript_atk:refreshItemSelect(self.selectAtkIndex,item,false)
self.selectAtkIndex=nil
ischange=true
end
if self.selectDefIndex then
self.defScrollView:setChildScrollRectEnable(true)
self.scrollscript_def:refreshItemSelect(self.selectDefIndex,item,false)
self.selectDefIndex=nil
ischange=true
end
if ischange then
self.select2Obj:setActive(false)
end
end
end

function UIXM_ZZSH_selectTeamWin:onCancelArrow2()
local data
local teamtype
if self.selectAtkIndex then
data=self.teamsList_atk[self.selectAtkIndex]
teamtype=self.selectAtkPage
elseif self.selectDefIndex then
data=self.teamsList_def[self.selectDefIndex]
teamtype=0
end
if data then
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
local d=zrData:getSelected(data.teamguid_str)
local isSelect=d~=nil
if isSelect then
zhengzhanshanhaiController:reqChangePvPTeam(data.teamguid,teamtype,-1)
end
end
self:closeSelectObj()
end

function UIXM_ZZSH_selectTeamWin:onUpArrow()
local data
local teamtype
local dataIndex
if self.selectAtkIndex then
data=self.teamsList_atk[self.selectAtkIndex]
teamtype=self.selectAtkPage
dataIndex=self.selectAtkIndex
elseif self.selectDefIndex then
data=self.teamsList_def[self.selectDefIndex]
teamtype=0
dataIndex=self.selectDefIndex
end
if data then
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
local d=zrData:getSelected(data.teamguid_str)
local isSelect=d~=nil
if isSelect then
if dataIndex>1 then
zhengzhanshanhaiController:reqChangePvPTeam(data.teamguid,teamtype,dataIndex-1)
else
UIManager.info('当前位置已处于最顶部')
end
return
end
end
self:closeSelectObj()
end

function UIXM_ZZSH_selectTeamWin:onDownArrow(dataIndex)
local data
local teamtype
local dataIndex
local typo
if self.selectAtkIndex then
data=self.teamsList_atk[self.selectAtkIndex]
teamtype=self.selectAtkPage
dataIndex=self.selectAtkIndex
typo=1
elseif self.selectDefIndex then
data=self.teamsList_def[self.selectDefIndex]
teamtype=0
dataIndex=self.selectDefIndex
typo=2
end
if data then
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
local d=zrData:getSelected(data.teamguid_str)
local isSelect=d~=nil
if isSelect then
local n
if typo==1 then
n=#self.teamsList_atk
else
n=#self.teamsList_def
end
if dataIndex<n then
zhengzhanshanhaiController:reqChangePvPTeam(data.teamguid,teamtype,dataIndex+1)
else
UIManager.info('当前位置已处于最底部')
end
return
end
end
self:closeSelectObj()
end

function UIXM_ZZSH_selectTeamWin:closeSelectObj()
self:activeSelectObj(false)
self:activeSelectObj2(false)
end



function UIXM_ZZSH_selectTeamWin:findTeamIndex(teamguid_str)
for i,data in ipairs(self.teamsList)do
if data.teamguid_str==teamguid_str then
return i
end
end
return nil
end

function UIXM_ZZSH_selectTeamWin:refreshTeamsSV()
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
local temp={}
local showFree=self.showFree
for teamguid_str,data in pairs(zrData.detailLookup)do
if showFree then
if zrData.allTamsLookup[teamguid_str]==nil then
table.insert(temp,data)
end
else
table.insert(temp,data)
end
end
table.sort(temp,function(a,b)
return a.teamfight_num>b.teamfight_num
end)
self.teamsList=temp

local c=#self.teamsList
self.scrollscript:initData(nil,148,c)
local has=c>0
self.noSign:setActive(not has)
end

function UITeamScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UITeamScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UITeamScroller:RefreshCell(dataIndex,cellIndex,item)
if _this==nil then return end
if item==nil then
item=self:GetCell(dataIndex-1)
end
if item==nil then return end
local data=_this.teamsList[dataIndex]

item:SetChildButtonClick(0,function()
self:onItemClick(dataIndex)
end)
item:SetChildLongTouch(0,dataIndex,0.5,function(...)
self:onItemLongClick(dataIndex)
end)

item:SetChildText(1,mathHelper.formatNumber6(data.teamfight_num))

item:SetChildText(2,data.actorData.actorname)

item:SetChildButtonClick(3,function()
self:onItemLQClick(dataIndex)
end)
self:refreshItemLQ(dataIndex,item)

local dzlist=data.discipleList or{}
local dznum=5
item:SetChildLayoutGroupCreateItems(6,dznum)
local grids=item:GetChildLayoutGroupGridList(6)
for i=1,dznum do
local netData=dzlist[i]
local dzitem=grids[i-1]
local has=netData~=nil and netData.flag>0
dzitem:SetChildActive(0,not has)
dzitem:SetChildActive(1,has)
if has then
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)

comHelper.setChildModelHeadIconBGByColor(dzitem,1,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(2,dzitem,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
dzitem:SetChildCSImageSprite(3,globalABLookup.global,jobicon)
end
end

local outline_str=data.actorData:getOutlineStr()
local showOutline=outline_str~=nil
item:SetChildActive(9,showOutline)
if showOutline then
item:SetChildText(10,outline_str)
end

local signab,signIcon=data.actorData:getSignIcon()
local showSign=signIcon~=nil
item:SetChildActive(12,showSign)
if showSign then
item:SetChildCSImageSprite(12,signab,signIcon)
end

self:refreshItemBlack(dataIndex,item)

local isSelect=dataIndex==_this.selectTeamIndex
self:refreshItemSelect(dataIndex,item,isSelect)
end

function UITeamScroller:refreshItemLQ(dataIndex,item)
if _this==nil then return end
if item==nil then
item=self:GetCell(dataIndex-1)
end
if item==nil then return end
local data=_this.teamsList[dataIndex]
if data==nil then return end
local cur=data.power
local max=zhengzhanshanhaiModel.maxLingLi
local rate=cur/max
if rate>1 then rate=1 end
item:SetChildIconFillAmount(4,rate)
item:SetChildText(5,data.power)
end

function UITeamScroller:refreshItemBlack(dataIndex,item)
if _this==nil then return end
if item==nil then
item=self:GetCell(dataIndex-1)
end
if item==nil then return end
local data=_this.teamsList[dataIndex]
if data==nil then return end

local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
local d=zrData:getSelected(data.teamguid_str)
local isSelect=d~=nil
item:SetChildActive(7,isSelect)
if isSelect then

local team_name
if d.teamtype==0 then
team_name='防守'
else
team_name=FMT.fmt('仙阵{0}',d.teamtype)
end
item:SetChildText(8,team_name)
end
end

function UITeamScroller:refreshItemSelect(dataIndex,item,flag)
if _this==nil then return end
if item==nil then
item=self:GetCell(dataIndex-1)
end
if item==nil then return end
item:SetChildActive(11,flag)
return true
end

function UITeamScroller:onItemLongClick(dataIndex)
if _this==nil then return end
local data=_this.teamsList[dataIndex]
if data==nil then return end
_this:closeSelectObj()
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
local d=zrData:getSelected(data.teamguid_str)
local typo
if d~=nil then
if d.teamtype>0 then
typo=1
else
typo=2
end
else
typo=3
end
zhengzhanshanhaiController:showOtherPlayerRivalInfo(data.actorid,data.idx,typo,data.server_id)
end

function UITeamScroller:onItemClick(dataIndex)
if _this==nil then return end
local data=_this.teamsList[dataIndex]
if data==nil then
_this:closeSelectObj()
return
end
local canSetup=_this.isManager or(data.ismy and not zhengzhanshanhaiModel:checkMyPvPZhenRongLock())
canSetup=canSetup and _this:checkState()
if canSetup then
local item=self:GetCell(dataIndex-1)
if item then
if _this.selectTeamIndex~=dataIndex then
local idx=self:getStartCellViewIndex()
local idx2=self:getEndCellViewIndex()
if idx+1==dataIndex then
self:jumpToDataIndex(dataIndex-1,0,0,true,0,0,nil)
elseif idx2+1==dataIndex then
local idx3=dataIndex-3
if idx3<1 then idx3=1 end
self:jumpToDataIndex(idx3-1,0,0,true,0,0,nil)
end
_this:activeSelectObj(true,item,dataIndex)
else
_this:activeSelectObj(false,item,dataIndex)
end
end
else
_this:closeSelectObj()














end
end

function UITeamScroller:onItemLQClick(dataIndex)
if _this==nil then return end
local item=self:GetCell(dataIndex-1)
if item==nil then return end
local data=_this.teamsList[dataIndex]
if data==nil then return end
_this:closeSelectObj()
local pos=item:GetChildScreenPointToLocalPointRectangle(4)
zhengzhanshanhaiController:openLingLiTips(nil,data.teamguid_str,2,pos.x,pos.y,25,0)
end

function UIXM_ZZSH_selectTeamWin:refreshTeamItem(teamguid_str)
local idx=self:findTeamIndex(teamguid_str)
if idx then
self.scrollscript:RefreshCell(idx,nil,nil)
end
end

function UIXM_ZZSH_selectTeamWin:refreshTeamItemLQ(teamguid_str)
local idx=self:findTeamIndex(teamguid_str)
if idx then
self.scrollscript:refreshItemLQ(idx,nil)
end
end





function UIXM_ZZSH_selectTeamWin:findAtkTeamIndex(teamguid_str)
for i,data in ipairs(self.teamsList_atk)do
if data.teamguid_str==teamguid_str then
return i
end
end
return nil
end

function UIXM_ZZSH_selectTeamWin:refreshAtkTeamsSV(isInit)
local page=self.selectAtkPage
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
local temp={}
local list=zrData.teamLookup[page]or{}
for i,d in ipairs(list)do
local data=zrData.detailLookup[d.teamguid_str]
table.insert(temp,data)
end
self.teamsList_atk=temp
if not self.initAtkSV then
self.initAtkSV=true
local max=zhengzhanshanhaiModel:getAtkTeamMaxNum()
self.scrollscript_atk:initData(nil,116,max)
else
self.scrollscript_atk:doRefreshActiveCellViews()
if isInit then
self.scrollscript_atk:jumpToDataIndex(0,0,0,true,0,0,nil)
end
end
end

function UIAtkScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIAtkScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIAtkScroller:RefreshCell(dataIndex,cellIndex,item)
if _this==nil then return end
if item==nil then
item=self:GetCell(dataIndex-1)
end
if item==nil then return end
local data=_this.teamsList_atk[dataIndex]
local hasData=data~=nil

item:SetChildButtonClick(0,function()
self:onItemClick(dataIndex)
end)
item:SetChildLongTouch(0,dataIndex,0.5,function(...)
self:onItemLongClick(dataIndex)
end)

item:SetChildActive(1,hasData)
if hasData then

item:SetChildText(2,mathHelper.formatNumber6(data.teamfight_num))

item:SetChildText(3,data.actorData.actorname)

item:SetChildButtonClick(4,function()
self:onItemLQClick(dataIndex)
end)
self:refreshItemLQ(dataIndex,item)

local dzitem=item:GetChildWidgetBase(7)
local netData=data.showDZ
local has=netData~=nil
dzitem:SetChildActive(0,not has)
dzitem:SetChildActive(1,has)
if has then
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)

comHelper.setChildModelHeadIconBGByColor(dzitem,1,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(2,dzitem,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
dzitem:SetChildCSImageSprite(3,globalABLookup.global,jobicon)
end

local outline_str=data.actorData:getOutlineStr()
local showOutline=outline_str~=nil
item:SetChildActive(8,showOutline)
if showOutline then
item:SetChildText(9,outline_str)
end

local isSelect=dataIndex==_this.selectAtkIndex
self:refreshItemSelect(dataIndex,item,isSelect)
end

local showSign=false
local signab,signIcon
if hasData then
signab,signIcon=data.actorData:getSignIcon()
showSign=signIcon~=nil
end
item:SetChildActive(11,showSign)
if showSign then
item:SetChildCSImageSprite(11,signab,signIcon)
end
end

function UIAtkScroller:refreshItemLQ(dataIndex,item)
if _this==nil then return end
if item==nil then
item=self:GetCell(dataIndex-1)
end
if item==nil then return end
local data=_this.teamsList_atk[dataIndex]
if data==nil then return end
local cur=data.power
local max=zhengzhanshanhaiModel.maxLingLi
local rate=cur/max
if rate>1 then rate=1 end
item:SetChildIconFillAmount(5,rate)
item:SetChildText(6,data.power)
end

function UIAtkScroller:refreshItemSelect(dataIndex,item,flag)
if _this==nil then return end
if item==nil then
item=self:GetCell(dataIndex-1)
end
if item==nil then return end
item:SetChildActive(10,flag)
return true
end

function UIAtkScroller:onItemLongClick(dataIndex)
if _this==nil then return end
local data=_this.teamsList_atk[dataIndex]
if data==nil then return end
_this:closeSelectObj()
zhengzhanshanhaiController:showOtherPlayerRivalInfo(data.actorid,data.idx,1,data.server_id)
end

function UIAtkScroller:onItemClick(dataIndex)
if _this==nil then return end
local data=_this.teamsList_atk[dataIndex]
if data==nil then
_this:closeSelectObj()
return
end
local canSetup=_this.isManager or(data.ismy and not zhengzhanshanhaiModel:checkMyPvPZhenRongLock())
canSetup=canSetup and _this:checkState()
if canSetup then
local item=self:GetCell(dataIndex-1)
if item then
local idx=self:getStartCellViewIndex()
local idx2=self:getEndCellViewIndex()
if idx+1==dataIndex then
self:jumpToDataIndex(dataIndex-1,0,0,true,0,0,nil)
elseif idx2+1==dataIndex then
local idx3=dataIndex-2
if idx3<1 then idx3=1 end
self:jumpToDataIndex(idx3-1,0,0,true,0,0,nil)
end
if _this.selectAtkIndex~=dataIndex then
_this:activeSelectObj2(true,item,dataIndex,1)
else
_this:activeSelectObj2(false,item)
end
end
else
_this:closeSelectObj()


end
end

function UIAtkScroller:onItemLQClick(dataIndex)
if _this==nil then return end
local item=self:GetCell(dataIndex-1)
if item==nil then return end
local data=_this.teamsList_atk[dataIndex]
if data==nil then return end
_this:closeSelectObj()
local pos=item:GetChildScreenPointToLocalPointRectangle(4)
zhengzhanshanhaiController:openLingLiTips(nil,data.teamguid_str,2,pos.x,pos.y,25,0)
end

function UIXM_ZZSH_selectTeamWin:refreshAtkTeamItem(teamguid_str)
local idx=self:findAtkTeamIndex(teamguid_str)
if idx then
self.scrollscript_atk:RefreshCell(idx,nil,nil)
end
end

function UIXM_ZZSH_selectTeamWin:refreshAtkTeamItemLQ(teamguid_str)
local idx=self:findAtkTeamIndex(teamguid_str)
if idx then
self.scrollscript_atk:refreshItemLQ(idx,nil)
end
end





function UIXM_ZZSH_selectTeamWin:findDefTeamIndex(teamguid_str)
for i,data in ipairs(self.teamsList_def)do
if data.teamguid_str==teamguid_str then
return i
end
end
return nil
end

function UIXM_ZZSH_selectTeamWin:refreshDefTeamsSV()
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
local temp={}
local list=zrData.teamLookup[0]or{}
for i,d in ipairs(list)do
local data=zrData.detailLookup[d.teamguid_str]
table.insert(temp,data)
end
self.teamsList_def=temp
if not self.initDefSV then
self.initDefSV=true
local max=zhengzhanshanhaiModel:getDefTeamMaxNum()
self.scrollscript_def:initData(nil,116,max)
else
self.scrollscript_def:doRefreshActiveCellViews()
end
end

function UIDefScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIDefScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIDefScroller:RefreshCell(dataIndex,cellIndex,item)
if _this==nil then return end
if item==nil then
item=self:GetCell(dataIndex-1)
end
if item==nil then return end
local data=_this.teamsList_def[dataIndex]
local hasData=data~=nil

item:SetChildButtonClick(0,function()
self:onItemClick(dataIndex)
end)
item:SetChildLongTouch(0,dataIndex,0.5,function(...)
self:onItemLongClick(dataIndex)
end)

item:SetChildActive(1,hasData)
if hasData then

item:SetChildText(2,mathHelper.formatNumber6(data.teamfight_num))

item:SetChildText(3,data.actorData.actorname)

item:SetChildButtonClick(4,function()
self:onItemLQClick(dataIndex)
end)
self:refreshItemLQ(dataIndex,item)

local dzitem=item:GetChildWidgetBase(7)
local netData=data.showDZ
local has=netData~=nil
dzitem:SetChildActive(0,not has)
dzitem:SetChildActive(1,has)
if has then
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)

comHelper.setChildModelHeadIconBGByColor(dzitem,1,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(2,dzitem,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
dzitem:SetChildCSImageSprite(3,globalABLookup.global,jobicon)
end

local outline_str=data.actorData:getOutlineStr()
local showOutline=outline_str~=nil
item:SetChildActive(8,showOutline)
if showOutline then
item:SetChildText(9,outline_str)
end

local isSelect=dataIndex==_this.selectDefIndex
self:refreshItemSelect(dataIndex,item,isSelect)
end

local showSign=false
local signab,signIcon
if hasData then
signab,signIcon=data.actorData:getSignIcon()
showSign=signIcon~=nil
end
item:SetChildActive(11,showSign)
if showSign then
item:SetChildCSImageSprite(11,signab,signIcon)
end
end

function UIDefScroller:refreshItemLQ(dataIndex,item)
if _this==nil then return end
if item==nil then
item=self:GetCell(dataIndex-1)
end
if item==nil then return end
local data=_this.teamsList_def[dataIndex]
if data==nil then return end
local cur=data.power
local max=zhengzhanshanhaiModel.maxLingLi
local rate=cur/max
if rate>1 then rate=1 end
item:SetChildIconFillAmount(5,rate)
item:SetChildText(6,data.power)
end

function UIDefScroller:refreshItemSelect(dataIndex,item,flag)
if _this==nil then return end
if item==nil then
item=self:GetCell(dataIndex-1)
end
if item==nil then return end
item:SetChildActive(10,flag)
return true
end

function UIDefScroller:onItemLongClick(dataIndex)
if _this==nil then return end
local data=_this.teamsList_def[dataIndex]
if data==nil then return end
_this:closeSelectObj()
zhengzhanshanhaiController:showOtherPlayerRivalInfo(data.actorid,data.idx,2,data.server_id)
end

function UIDefScroller:onItemClick(dataIndex)
if _this==nil then return end
local data=_this.teamsList_def[dataIndex]
if data==nil then
_this:closeSelectObj()
return
end
local canSetup=_this.isManager or(data.ismy and not zhengzhanshanhaiModel:checkMyPvPZhenRongLock())
canSetup=canSetup and _this:checkState()
if canSetup then
local item=self:GetCell(dataIndex-1)
if item then
local idx=self:getStartCellViewIndex()
local idx2=self:getEndCellViewIndex()
if idx+1==dataIndex then
self:jumpToDataIndex(dataIndex-1,0,0,true,0,0,nil)
elseif idx2+1==dataIndex then
local idx3=dataIndex-3
if idx3<1 then idx3=1 end
self:jumpToDataIndex(idx3-1,0,0,true,0,0,nil)
end
if _this.selectDefIndex~=dataIndex then
_this:activeSelectObj2(true,item,dataIndex,2)
else
_this:activeSelectObj2(false,item)
end
end
else
_this:closeSelectObj()


end
end

function UIDefScroller:onItemLQClick(dataIndex)
if _this==nil then return end
local item=self:GetCell(dataIndex-1)
if item==nil then return end
local data=_this.teamsList_def[dataIndex]
if data==nil then return end
_this:closeSelectObj()
local pos=item:GetChildScreenPointToLocalPointRectangle(4)
zhengzhanshanhaiController:openLingLiTips(nil,data.teamguid_str,1,pos.x,pos.y,-25,0)
end

function UIXM_ZZSH_selectTeamWin:refreshDefTeamItem(teamguid_str)
local idx=self:findDefTeamIndex(teamguid_str)
if idx then
self.scrollscript_def:RefreshCell(idx,nil,nil)
end
end

function UIXM_ZZSH_selectTeamWin:refreshDefTeamItemLQ(teamguid_str)
local idx=self:findDefTeamIndex(teamguid_str)
if idx then
self.scrollscript_def:refreshItemLQ(idx,nil)
end
end





function UIXM_ZZSH_selectTeamWin:initMoney()
local widget=self.money1Root:getWidgetBase()
local moneyType=self.costType
local moneyVal=moneyModel.getMoney(moneyType)
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(1,iconHelper.getIconName(moneyType),false)
widget:SetChildText(2,moneyStr)
widget:SetChildActive(3,true)
widget:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onAddClick(moneyType)
end)
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:clickMoney(moneyType)
end)
end

function UIXM_ZZSH_selectTeamWin:refreshMoney()
local widget=self.money1Root:getWidgetBase()
local moneyType=self.costType
local moneyVal=moneyModel.getMoney(moneyType)
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildText(2,moneyStr)
end

function UIXM_ZZSH_selectTeamWin:onAddClick(moneyType)
self:clickMoney(moneyType)
end

function UIXM_ZZSH_selectTeamWin:clickMoney(moneyType)
gainControl:showGainWin(moneyType)
end



function UIXM_ZZSH_selectTeamWin:onCloseBtn()
self:closeSelf()
end

function UIXM_ZZSH_selectTeamWin:onMaskBlock()
self:closeSelectObj()
end

function UIXM_ZZSH_selectTeamWin:refreshLockBtn()
local islock=zhengzhanshanhaiModel:checkMyPvPZhenRongLock()
local icon,str,moveX
if islock then
icon='button_kaiguan_1'
str='关'
moveX=34
else
icon='button_kaiguan_2'
str='开'
moveX=74
end
local icon=islock and'button_kaiguan_1'or'button_kaiguan_2'
self.lockImg:setSprite(globalABLookup.global,icon)
self.lockTxt:setText(str)
self.lockTxt:setLocalPosX(moveX)
end

function UIXM_ZZSH_selectTeamWin:onLockBtn()
self:closeSelectObj()
if not self:checkState(true)then
return
end
if not self.isManager then
UIManager.error('只有盟主或副盟主可以锁定')
return
end
if not self:checkClickLock()then
return
end
local islock=zhengzhanshanhaiModel:checkMyPvPZhenRongLock()
local content
if islock then
content='解除锁定后，全员均可自由安排自己的弟子队伍'
else
content='锁定阵容后，只允许盟主或副盟主安排仙盟所有的弟子队伍'
end
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=function()

if islock then
zhengzhanshanhaiController:reqLock(0)
else
zhengzhanshanhaiController:reqLock(1)
end
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end

function UIXM_ZZSH_selectTeamWin:onMyTeamBtn()
self:closeSelectObj()
if not self:checkClickLock()then
return
end
zhengzhanshanhaiController.setupDefTeams()
end

function UIXM_ZZSH_selectTeamWin:refreshMaskFreeBtn()
local icon=self.showFree and'image_dygou_2'or'image_dygou_1'
self.maskFreeMark:setSprite(globalABLookup.global,icon)
end

function UIXM_ZZSH_selectTeamWin:onMaskFreeBtn()
self:closeSelectObj()
if not self:checkClickLock()then
return
end
self.showFree=not self.showFree
self:refreshMaskFreeBtn()
self:refreshTeamsSV()
end

function UIXM_ZZSH_selectTeamWin:onAtkDetailBtn()
self:closeSelectObj()
local teamtype=self.selectAtkPage
UIManager:showWindow('UIXM_ZZSH_teamInfoOneWin',{teamtype=teamtype})
end

function UIXM_ZZSH_selectTeamWin:onDefDetailBtn()
self:closeSelectObj()
local teamtype=0
UIManager:showWindow('UIXM_ZZSH_teamInfoOneWin',{teamtype=teamtype})
end

function UIXM_ZZSH_selectTeamWin:rec_data()
self:closeSelectObj()
self:refreshAtkNum()
self:refreshDefNum()
self:refreshTeamsSV()
self:refreshAtkTeamsSV()
self:refreshDefTeamsSV()
self:refreshLockBtn()
self:refreshAllAtkGridItemReddot()
end

function UIXM_ZZSH_selectTeamWin:rec_setup(teamguid,teamtype)
local teamguid_str=tostring(teamguid)
self:refreshTeamItem(teamguid_str)
if teamtype>0 then
self:refreshAtkNum()
self:refreshAtkGridItemReddot(nil,teamtype)
else
self:refreshDefNum()
end
if teamtype>0 then
if self.selectAtkPage==teamtype then
local teamguid_str_old
if self.selectAtkIndex then
local data=self.teamsList_atk[self.selectAtkIndex]
if data then
teamguid_str_old=data.teamguid_str
end
self:closeSelectObj()
end

local teamguid_str=tostring(teamguid)
local idx_old=self:findAtkTeamIndex(teamguid_str)
local idx=self.scrollscript_atk:getStartCellViewIndex()
local idx2=self.scrollscript_atk:getEndCellViewIndex()
self:refreshAtkTeamsSV()

local idx_=self:findAtkTeamIndex(teamguid_str)
if idx_ then

if teamguid_str_old==teamguid_str then
if idx_<=idx+1 then
self.scrollscript_atk:jumpToDataIndex(idx_-1,0,0,true,0,0,nil)
elseif idx_>=idx2+1 then
local idx3=idx_-2
if idx3<1 then idx3=1 end
self.scrollscript_atk:jumpToDataIndex(idx3-1,0,0,true,0,0,nil)
end
local item=self.scrollscript_atk:GetCell(idx_-1)
if item then
self:activeSelectObj2(true,item,idx_,1)
end
end
end
end
else
local teamguid_str_old
if self.selectDefIndex then
local data=self.teamsList_def[self.selectDefIndex]
if data then
teamguid_str_old=data.teamguid_str
end
self:closeSelectObj()
end

local teamguid_str=tostring(teamguid)
local idx_old=self:findDefTeamIndex(teamguid_str)
local idx=self.scrollscript_def:getStartCellViewIndex()
local idx2=self.scrollscript_def:getEndCellViewIndex()
self:refreshDefTeamsSV()

local idx_=self:findDefTeamIndex(teamguid_str)
if idx_ then

if teamguid_str_old==teamguid_str then
if idx_<=idx+1 then
self.scrollscript_def:jumpToDataIndex(idx_-1,0,0,true,0,0,nil)
elseif idx_>=idx2+1 then
local idx3=idx_-3
if idx3<1 then idx3=1 end
self.scrollscript_def:jumpToDataIndex(idx3-1,0,0,true,0,0,nil)
end
local item=self.scrollscript_def:GetCell(idx_-1)
if item then
self:activeSelectObj2(true,item,idx_,2)
end
end
end
end
end

function UIXM_ZZSH_selectTeamWin:rec_setup2(teamtype)
if teamtype>0 then
self:refreshAtkNum()
self:refreshAtkGridItemReddot(nil,teamtype)
if self.selectAtkPage==teamtype then
self:refreshAtkTeamsSV()
end
else
self:refreshDefNum()
self:refreshDefTeamsSV()
end
end

function UIXM_ZZSH_selectTeamWin:rec_lingli(lp)
for teamguid_str,v in pairs(lp)do
self:refreshTeamItemLQ(teamguid_str)
self:refreshAtkTeamItemLQ(teamguid_str)
self:refreshDefTeamItemLQ(teamguid_str)
end
end