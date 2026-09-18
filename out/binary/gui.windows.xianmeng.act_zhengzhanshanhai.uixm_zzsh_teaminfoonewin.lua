







def_class("UIXM_ZZSH_teamInfoOneWin",UIWindowBase)









function UIXM_ZZSH_teamInfoOneWin:bindComponents()

self.maskBlock=UIButton.get(self,0)
self.frameSp=UIObject.get(self,1)
self.infoPanel=UIButton.get(self,2)
self.reverCostNumTxt=UIText.get(self,3)
self.reverIconImg=UIImage.get(self,4)
self.teamNumTxt=UIText.get(self,5)
self.pageGrid=UIObject.get(self,6)
self.noSign=UIObject.get(self,7)
self.selectObj=UIObject.get(self,8)
self.select2Obj=UIObject.get(self,9)
self.money1Root=UIObject.get(self,10)
self.closeBtn=UIButton.get(self,11)
self.teamScrollView=UIEnhancedScrollerLua.get(self,12)
self.sortBtn=UIButton.get(self,13)
self.reverAllBtn=UIButton.get(self,14)

self.maskBlock:setButtonClick(function()self:onMaskBlock()end)

self.infoPanel:setButtonClick(function()self:onInfoPanel()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.sortBtn:setButtonClick(function()self:onSortBtn()end)

self.reverAllBtn:setButtonClick(function()self:onReverAllBtn()end)



end


function UIXM_ZZSH_teamInfoOneWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.maskBlock);self.maskBlock=nil;
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.reverCostNumTxt);self.reverCostNumTxt=nil;
_UIObject_release(self.reverIconImg);self.reverIconImg=nil;
_UIObject_release(self.teamNumTxt);self.teamNumTxt=nil;
_UIObject_release(self.pageGrid);self.pageGrid=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.selectObj);self.selectObj=nil;
_UIObject_release(self.select2Obj);self.select2Obj=nil;
_UIObject_release(self.money1Root);self.money1Root=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.teamScrollView);self.teamScrollView=nil;
_UIObject_release(self.sortBtn);self.sortBtn=nil;
_UIObject_release(self.reverAllBtn);self.reverAllBtn=nil;
end
















local UITeamScroller=simple_class(UIEnhancedScroller)
local _this=nil


function UIXM_ZZSH_teamInfoOneWin:onLoaded(...)
_this=self
self:bindComponents()
self.scrollscript=UITeamScroller(self.teamScrollView:getGameObject(),self.teamScrollView:getCSharpObject(),nil,nil)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIXM_ZZSH_teamInfoOneWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_ZZSH_teamInfoOneWin:onHide()

end

function UIXM_ZZSH_teamInfoOneWin.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end
if moneyType==_this.costType then
_this:refreshMoney()
end
end




function UIXM_ZZSH_teamInfoOneWin:onShow(argtable,afterOnloaded)
local costType=zhengzhanshanhaiModel:getReverLingLiCostType()
self.costType=costType
local myActorid=playerModel:getActorID()
self.isManager=xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptZZSHSign)
if afterOnloaded then
self.infoPanel:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(5287,1,{},0,false,false,0,function()
if _this==nil then return end

_this.infoPanel:setChildCanvasGroupDOFade(1,0.25,nil)

end)
end

local teamtype=argtable.teamtype
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
local teamtypeList={}
local temp
local max=zhengzhanshanhaiModel:getMaxWaiPaiNum_pvp()
for teamtype_=1,max do
temp=zrData.teamLookup[teamtype_]
if temp and#temp>0 then
table.insert(teamtypeList,teamtype_)
end
end
temp=zrData.teamLookup[0]
if temp and#temp>0 then
table.insert(teamtypeList,0)
end
self.teamtypeList=teamtypeList
self.selectPage=nil
if#teamtypeList>0 then
for i,v in ipairs(teamtypeList)do
if teamtype==v then
self.selectPage=i
break
end
end
if self.selectPage==nil then
self.selectPage=1
end
end
self:refreshView()
self:initMoney()
end

function UIXM_ZZSH_teamInfoOneWin:checkState(isWarning)
local raceState=zhengzhanshanhaiModel:getLunState()
if raceState==eZZSH_State.ePVPFight then
if isWarning then
UIManager.error('战争期无法进行此操作')
end
return false
end
return true
end

function UIXM_ZZSH_teamInfoOneWin:checkClickLock()
if self.clickLockTime~=nil and gameUtilityModel.getServerShortTime()-self.clickLockTime<zhengzhanshanhaiModel.clickBtnCoolTime then
return false
end
self.clickLockTime=gameUtilityModel.getServerShortTime()
return true
end

function UIXM_ZZSH_teamInfoOneWin:refreshView()
self:initPageGrid()
self:refreshTeamsSV()
self:refreshSortBtn()
end

function UIXM_ZZSH_teamInfoOneWin:initPageGrid()
local num=#self.teamtypeList
self.pageGrid:setChildLayoutGroupCreateItems(num)
local grids=self.pageGrid:getChildLayoutGroupGridList()
for i=1,num do
local item=grids[i-1]

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onGridItemClick(i)
end)

local teamtype=self.teamtypeList[i]
local teamname=zhengzhanshanhaiModel:getTeamZhenRongName(teamtype)
item:SetChildText(1,teamname)
self:refreshGridItemSelect(item,i,i==self.selectPage)
self:refreshGridItemReddot(item,i)
end
end

function UIXM_ZZSH_teamInfoOneWin:findPageTeamtype(teamtype)
for i,teamtype_ in ipairs(self.teamtypeList)do
if teamtype_==teamtype then
return i
end
end
end

function UIXM_ZZSH_teamInfoOneWin:refreshGridItemSelect(item,idx,flag)
if item==nil then
item=self.pageGrid:getChildLayoutGroupGridItem(idx-1)
end
local icon=flag==true and'button_shsjzrxxui_1'or'button_shsjzrxxui_2'
item:SetChildCSImageSprite(0,globalABLookup.zzshicons,icon)
end

function UIXM_ZZSH_teamInfoOneWin:refreshGridItemReddot(item,idx)
if item==nil then
item=self.pageGrid:getChildLayoutGroupGridItem(idx-1)
end
local teamtype=self.teamtypeList[idx]
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
local num
if teamtype>0 then
num=zrData:getAtkTeamNumEx(teamtype)
else
num=zrData:getDefTeamNum()
end
local isshow=num>0
item:SetChildActive(2,isshow)
if isshow then
item:SetChildText(3,tostring(num))
end
end

function UIXM_ZZSH_teamInfoOneWin:refreshGridItemReddot2(teamtype)
local idx=self:findPageTeamtype(teamtype)
if idx then
self:refreshGridItemReddot(nil,idx)
end
end

function UIXM_ZZSH_teamInfoOneWin:onGridItemClick(idx)
if self.selectPage==idx then
return
end
self:closeSelectObj()
if self.selectPage then
self:refreshGridItemSelect(nil,self.selectPage,false)
end
self:refreshGridItemSelect(nil,idx,true)
self.selectPage=idx
self:refreshTeamsSV()
self:refreshSortBtn()
if self.teamsListNum>0 then
self.scrollscript:jumpToDataIndex(0,0,0,true,0,0,nil)
end
end

function UIXM_ZZSH_teamInfoOneWin:refreshAllGridItemReddot()
local num=#self.teamtypeList
local grids=self.pageGrid:getChildLayoutGroupGridList()
for i=1,num do
local item=grids[i-1]
self:refreshAtkGridItemReddot(item,i)
end
end

function UIXM_ZZSH_teamInfoOneWin:activeSelectObj(flag,item,dataIndex)
if flag then
if self.selectTeamIndex==dataIndex then
return
end
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
local isSupport=data.actorData:checkSupport()
widget:SetChildActive(0,not isSupport)
widget:SetChildActive(1,isSupport)
if isSupport then
widget:SetChildButtonClick(1,function()
if _this==nil then return end
_this:onBackArrow()
end)
else
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onRightArrow()
end)
end

self.select2Obj:setActive(true)
local widget2=self.select2Obj:getWidgetBase()
widget2:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onUpArrow()
end)
widget2:SetChildButtonClick(1,function()
if _this==nil then return end
_this:onDownArrow()
end)
self:refreshSelect2Obj(widget2)
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
self.select2Obj:setActive(false)
end
end
end

function UIXM_ZZSH_teamInfoOneWin:refreshSelect2Obj(widget)
if self.selectTeamIndex then
if widget==nil then
widget=self.select2Obj:getWidgetBase()
end
local n=#self.teamsList
local upArrowGray=self.selectTeamIndex<=1
local downArrowGray=self.selectTeamIndex>=n
widget:SetChildImageExGray(2,upArrowGray)
widget:SetChildImageExGray(3,downArrowGray)
end
end

function UIXM_ZZSH_teamInfoOneWin:onRightArrow()
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

function UIXM_ZZSH_teamInfoOneWin:onBackArrow()
local dataIndex=self.selectTeamIndex
if dataIndex then

end
self:closeSelectObj()
end

function UIXM_ZZSH_teamInfoOneWin:onUpArrow()
local dataIndex=self.selectTeamIndex
if dataIndex then
local data=self.teamsList[dataIndex]
if data then
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
local d=zrData:getSelected(data.teamguid_str)
local isSelect=d~=nil
if isSelect then
if dataIndex>1 then
zhengzhanshanhaiController:reqChangePvPTeam(data.teamguid,d.teamtype,dataIndex-1)
else
UIManager.info('当前位置已处于最顶部')
end
return
end
end
end
self:closeSelectObj()
end

function UIXM_ZZSH_teamInfoOneWin:onDownArrow(dataIndex)
local dataIndex=self.selectTeamIndex
if dataIndex then
local data=self.teamsList[dataIndex]
if data then
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
local d=zrData:getSelected(data.teamguid_str)
local isSelect=d~=nil
if isSelect then
local n=#self.teamsList
if dataIndex<n then
zhengzhanshanhaiController:reqChangePvPTeam(data.teamguid,d.teamtype,dataIndex+1)
else
UIManager.info('当前位置已处于最底部')
end
return
end
end
end
self:closeSelectObj()
end

function UIXM_ZZSH_teamInfoOneWin:closeSelectObj()
self:activeSelectObj(false)
end



function UIXM_ZZSH_teamInfoOneWin:findTeamIndex(teamguid_str)
for i,data in ipairs(self.teamsList)do
if data.teamguid_str==teamguid_str then
return i
end
end
return nil
end

function UIXM_ZZSH_teamInfoOneWin:refreshTeamsSV()
local oldNum=self.teamsListNum or 0
local teamtype
if self.selectPage then
teamtype=self.teamtypeList[self.selectPage]
end
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
local temp={}
if teamtype then
local list=zrData.teamLookup[teamtype]
if list then
for i,d in ipairs(list)do
local data=zrData.detailLookup[d.teamguid_str]
table.insert(temp,data)
end
end
end
self.teamsList=temp
self.teamsListNum=#temp
if oldNum==self.teamsListNum then
if self.teamsListNum==0 then
self.scrollscript:initData(nil,148,0)
else
self.scrollscript:doRefreshActiveCellViews()
end
else
self.scrollscript:initData(nil,148,self.teamsListNum)
end

local has=self.teamsListNum>0
self.noSign:setActive(not has)

local str=FMT.fmt('队伍：<color=#F7F7F7>{0}</color>',self.teamsListNum)
self.teamNumTxt:setText(str)

self:refreshReverAllBtn()
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
item:SetChildActive(7,showOutline)
if showOutline then
item:SetChildText(8,outline_str)
end

local signab,signIcon=data.actorData:getSignIcon()
local showSign=signIcon~=nil
item:SetChildActive(10,showSign)
if showSign then
item:SetChildCSImageSprite(10,signab,signIcon)
end

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

function UITeamScroller:refreshItemSelect(dataIndex,item,flag)
if _this==nil then return end
if item==nil then
item=self:GetCell(dataIndex-1)
end
if item==nil then return end
item:SetChildActive(9,flag)
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
local pos=item:GetChildScreenPointToLocalPointRectangle(3)
zhengzhanshanhaiController:openLingLiTips(nil,data.teamguid_str,2,pos.x,pos.y,25,0)
end

function UIXM_ZZSH_teamInfoOneWin:refreshTeamItem(teamguid_str)
local idx=self:findTeamIndex(teamguid_str)
if idx then
self.scrollscript:RefreshCell(idx,nil,nil)
end
end

function UIXM_ZZSH_teamInfoOneWin:refreshTeamItemLQ(teamguid_str)
local idx=self:findTeamIndex(teamguid_str)
if idx then
self.scrollscript:refreshItemLQ(idx,nil)
end
end





function UIXM_ZZSH_teamInfoOneWin:initMoney()
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

function UIXM_ZZSH_teamInfoOneWin:refreshMoney()
local widget=self.money1Root:getWidgetBase()
local moneyType=self.costType
local moneyVal=moneyModel.getMoney(moneyType)
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildText(2,moneyStr)
end

function UIXM_ZZSH_teamInfoOneWin:onAddClick(moneyType)
self:clickMoney(moneyType)
end

function UIXM_ZZSH_teamInfoOneWin:clickMoney(moneyType)
gainControl:showGainWin(moneyType)
end



function UIXM_ZZSH_teamInfoOneWin:onMaskBlock()
if self.selectTeamIndex then
self:closeSelectObj()
else
self:closeSelf()
end
end

function UIXM_ZZSH_teamInfoOneWin:onInfoPanel()
self:closeSelectObj()
end

function UIXM_ZZSH_teamInfoOneWin:onCloseBtn()
self:closeSelf()
end

function UIXM_ZZSH_teamInfoOneWin:onReverAllBtn()
self:closeSelectObj()
if not self:checkState(true)then
return
end
if not self:checkClickLock()then
return
end
local costType=self.costType
local costNum,list
local teamtype
if self.selectPage then
teamtype=self.teamtypeList[self.selectPage]
end
if teamtype and self.isManager then
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
costNum,list=zrData:getReverCost(teamtype,true)
end
if costNum then
local have=moneyModel.getMoney(costType)
local moneyName=moneyModel.getMoneyName(costType)
local colorStr=have>=costNum and"549327"or"FF0000"
local iconStr=iconHelper.getIconName(costType)
local costStr=FMT.fmt("<color=#{0}>{1}</color>{2}quad-icon={3}-quad",colorStr,costNum,moneyName,iconStr)
local teamname=zhengzhanshanhaiModel:getTeamZhenRongName(teamtype)
local contentStr=FMT.fmt("是否消耗{0}恢复阵容[{1}]所有队伍灵力",costStr,teamname)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',

okcallback=function(...)
if _this==nil then return end
if not moneyModel.checkEnoughMoney(costType,costNum)then
local str=FMT.fmt('{0}不足',moneyModel.getMoneyName(costType))
UIManager.error(str)
gainControl:showGainWin(costType)
return
end
zhengzhanshanhaiController:reqLingLi(list)
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end
end

function UIXM_ZZSH_teamInfoOneWin:refreshReverAllBtn()
local costType=self.costType
local costNum
local teamtype
if self.selectPage then
teamtype=self.teamtypeList[self.selectPage]
end
if teamtype and self.isManager then
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
costNum=zrData:getReverCost(teamtype)
end
local isShow=costNum~=nil and costNum>0
self.reverAllBtn:setActive(isShow)
if isShow then
self.reverIconImg:setImageIcon(moneyModel.getIconNameEx(costType),true)
self.reverCostNumTxt:setText(tostring(costNum))
end
end

function UIXM_ZZSH_teamInfoOneWin:onSortBtn()
self:closeSelectObj()
if not self:checkState(true)then
return
end
if not self:checkClickLock()then
return
end
local needSort
local teamtype
if self.selectPage then
teamtype=self.teamtypeList[self.selectPage]
end
if teamtype and self.isManager then
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
needSort=zrData:needSort(teamtype)
end
if needSort==true then
zhengzhanshanhaiController:reqChangeAllPvPTeam(teamtype)
end
end

function UIXM_ZZSH_teamInfoOneWin:refreshSortBtn()
local needSort
local teamtype
if self.selectPage then
teamtype=self.teamtypeList[self.selectPage]
end
if teamtype and self.isManager then
local zrData=zhengzhanshanhaiModel:getMyPvPZhenRong()
needSort=zrData:needSort(teamtype)
end
self.sortBtn:setActive(needSort==true)
end

function UIXM_ZZSH_teamInfoOneWin:rec_data()
self:closeSelectObj()
self:refreshTeamsSV()
self:refreshSortBtn()
self:refreshAllGridItemReddot()
end

function UIXM_ZZSH_teamInfoOneWin:rec_setup(teamguid,teamtype)
local teamtype_
if self.selectPage then
teamtype_=self.teamtypeList[self.selectPage]
end
self:refreshGridItemReddot2(teamtype)
if teamtype_==teamtype then
local teamguid_str_old
if self.selectTeamIndex then
local data=self.teamsList[self.selectTeamIndex]
if data then
teamguid_str_old=data.teamguid_str
end
self:closeSelectObj()
end

local teamguid_str=tostring(teamguid)
local idx_old=self:findTeamIndex(teamguid_str)
local idx=self.scrollscript:getStartCellViewIndex()
local idx2=self.scrollscript:getEndCellViewIndex()
self:refreshTeamsSV()
self:refreshSortBtn()

local idx_=self:findTeamIndex(teamguid_str)
if idx_ then

if teamguid_str_old==teamguid_str then
if idx_<=idx+1 then
self.scrollscript:jumpToDataIndex(idx_-1,0,0,true,0,0,nil)
elseif idx_>=idx2+1 then
local idx3=idx_-3
if idx3<1 then idx3=1 end
self.scrollscript:jumpToDataIndex(idx3-1,0,0,true,0,0,nil)
end
local item=self.scrollscript:GetCell(idx_-1)
if item then
self:activeSelectObj(true,item,idx_)
end
end
else

if idx_old and self.teamsListNum>0 then
if idx_old<idx then
local idx3=idx-1
if idx3<1 then idx3=1 end
self.scrollscript:jumpToDataIndex(idx3-1,0,0,true,0,0,nil)
elseif idx_old>idx2 then
local idx3=idx2-3
if idx3<1 then idx3=1 end
self.scrollscript:jumpToDataIndex(idx3-1,0,0,true,0,0,nil)
else
local idx3=idx-1
if idx3<1 then idx3=1 end
self.scrollscript:jumpToDataIndex(idx3-1,0,0,true,0,0,nil)
end
end
end
end
end

function UIXM_ZZSH_teamInfoOneWin:rec_setup2(teamtype)
local teamtype_
if self.selectPage then
teamtype_=self.teamtypeList[self.selectPage]
end
self:refreshGridItemReddot2(teamtype)
if teamtype_==teamtype then
self:refreshTeamsSV()
self:refreshSortBtn()
end
end

function UIXM_ZZSH_teamInfoOneWin:rec_lingli(lp)
for teamguid_str,v in pairs(lp)do
self:refreshTeamItemLQ(teamguid_str)
end
self:refreshReverAllBtn()
end