







def_class("UIXM_ZZSH_teamInfoThreeWin",UIWindowBase)









function UIXM_ZZSH_teamInfoThreeWin:bindComponents()

self.maskBlock=UIButton.get(self,0)
self.frameSp=UIObject.get(self,1)
self.infoPanel=UIObject.get(self,2)
self.teamNumTxt=UIText.get(self,3)
self.pageGrid=UIObject.get(self,4)
self.noSign=UIObject.get(self,5)
self.closeBtn=UIButton.get(self,6)
self.money1Root=UIObject.get(self,7)
self.teamScrollView=UIEnhancedScrollerLua.get(self,8)
self.reverAllBtn=UIButton.get(self,9)
self.cancelBtn=UIButton.get(self,10)
self.commitBtn=UIButton.get(self,11)
self.commitBtnTxt=UIText.get(self,12)
self.reverCostNumTxt=UIText.get(self,13)
self.reverIconImg=UIImage.get(self,14)

self.maskBlock:setButtonClick(function()self:onMaskBlock()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.reverAllBtn:setButtonClick(function()self:onReverAllBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)



end


function UIXM_ZZSH_teamInfoThreeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.maskBlock);self.maskBlock=nil;
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.teamNumTxt);self.teamNumTxt=nil;
_UIObject_release(self.pageGrid);self.pageGrid=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.money1Root);self.money1Root=nil;
_UIObject_release(self.teamScrollView);self.teamScrollView=nil;
_UIObject_release(self.reverAllBtn);self.reverAllBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.commitBtnTxt);self.commitBtnTxt=nil;
_UIObject_release(self.reverCostNumTxt);self.reverCostNumTxt=nil;
_UIObject_release(self.reverIconImg);self.reverIconImg=nil;
end
















local UITeamScroller=simple_class(UIEnhancedScroller)
local _this=nil


function UIXM_ZZSH_teamInfoThreeWin:onLoaded(...)
_this=self
self:bindComponents()
self.scrollscript=UITeamScroller(self.teamScrollView:getGameObject(),self.teamScrollView:getCSharpObject(),nil,nil)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.onZZSHOrderChange,self.onZZSHOrderChange)
end


function UIXM_ZZSH_teamInfoThreeWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_ZZSH_teamInfoThreeWin:onHide()

end

function UIXM_ZZSH_teamInfoThreeWin.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end
if moneyType==_this.costType then
_this:refreshMoney()
end
end




function UIXM_ZZSH_teamInfoThreeWin:onShow(argtable,afterOnloaded)
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

self.guildid=argtable.guildid
self.domainid=argtable.domainid
self.hasTarget=self.guildid~=nil or self.domainid~=nil
self.curOrderTeam=zhengzhanshanhaiModel:checkHasOrder(self.guildid,self.domainid)
local teamtypeList={}
local max=zhengzhanshanhaiModel:getMaxWaiPaiNum_pvp()
for teamtype_=1,max do
table.insert(teamtypeList,teamtype_)
end
self.teamtypeList=teamtypeList
self.selectPage=nil
if#teamtypeList>0 then
for i,teamtype_ in ipairs(teamtypeList)do
if self.curOrderTeam==teamtype_ then
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

function UIXM_ZZSH_teamInfoThreeWin:checkState(isWarning)
local raceState=zhengzhanshanhaiModel:getLunState()
if raceState~=eZZSH_State.ePVPStandby then
if isWarning then
UIManager.error('只有备战期可下达指令')
end
return false
end
return true
end

function UIXM_ZZSH_teamInfoThreeWin:checkClickLock()
if self.clickLockTime~=nil and gameUtilityModel.getServerShortTime()-self.clickLockTime<zhengzhanshanhaiModel.clickBtnCoolTime then
return false
end
self.clickLockTime=gameUtilityModel.getServerShortTime()
return true
end

function UIXM_ZZSH_teamInfoThreeWin:refreshView()
self:initPageGrid()
self:refreshTeamsSV()
end

function UIXM_ZZSH_teamInfoThreeWin:initPageGrid()
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
self:refreshGridItemSign(item,i)
end
end

function UIXM_ZZSH_teamInfoThreeWin:findPageTeamtype(teamtype)
for i,teamtype_ in ipairs(self.teamtypeList)do
if teamtype_==teamtype then
return i
end
end
end

function UIXM_ZZSH_teamInfoThreeWin:refreshGridItemSelect(item,idx,flag)
if item==nil then
item=self.pageGrid:getChildLayoutGroupGridItem(idx-1)
end
local icon=flag==true and'button_shsjzrxxui_1'or'button_shsjzrxxui_2'
item:SetChildCSImageSprite(0,globalABLookup.zzshicons,icon)
end

function UIXM_ZZSH_teamInfoThreeWin:refreshGridItemReddot(item,idx)
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

function UIXM_ZZSH_teamInfoThreeWin:refreshGridItemReddot2(teamtype)
local idx=self:findPageTeamtype(teamtype)
if idx then
self:refreshGridItemReddot(nil,idx)
end
end

function UIXM_ZZSH_teamInfoThreeWin:refreshGridItemSign(item,idx)
if item==nil then
item=self.pageGrid:getChildLayoutGroupGridItem(idx-1)
end
local teamtype=self.teamtypeList[idx]
local icon
if self.curOrderTeam==teamtype then
icon='icon_dangqian_1'
elseif zhengzhanshanhaiModel:getOrder(teamtype)~=nil then
icon='icon_yizhanyong_1'
end
local showSign=icon~=nil
item:SetChildActive(4,showSign)
if showSign then
item:SetChildCSImageSprite(4,globalABLookup.zzshicons,icon)
end
end

function UIXM_ZZSH_teamInfoThreeWin:refreshGridItemSign2(teamtype)
local idx=self:findPageTeamtype(teamtype)
if idx then
self:refreshGridItemSign(nil,idx)
end
end

function UIXM_ZZSH_teamInfoThreeWin:onGridItemClick(idx)
if self.selectPage==idx then
return
end
if self.selectPage then
self:refreshGridItemSelect(nil,self.selectPage,false)
end
self:refreshGridItemSelect(nil,idx,true)
self.selectPage=idx
self:refreshTeamsSV()
if self.teamsListNum>0 then
self.scrollscript:jumpToDataIndex(0,0,0,true,0,0,nil)
end
end

function UIXM_ZZSH_teamInfoThreeWin:refreshAllGridItemReddot()
local num=#self.teamtypeList
local grids=self.pageGrid:getChildLayoutGroupGridList()
for i=1,num do
local item=grids[i-1]
self:refreshAtkGridItemReddot(item,i)
end
end



function UIXM_ZZSH_teamInfoThreeWin:findTeamIndex(teamguid_str)
for i,data in ipairs(self.teamsList)do
if data.teamguid_str==teamguid_str then
return i
end
end
return nil
end

function UIXM_ZZSH_teamInfoThreeWin:refreshTeamsSV()
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
self:refreshOrderBtn()
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

local signab,signIcon=data.actorData:getSignIcon()
local showSign=signIcon~=nil
item:SetChildActive(7,showSign)
if showSign then
item:SetChildCSImageSprite(7,signab,signIcon)
end
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

function UITeamScroller:onItemClick(dataIndex)
if _this==nil then return end
local data=_this.teamsList[dataIndex]
if data==nil then
return
end
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

function UITeamScroller:onItemLQClick(dataIndex)
if _this==nil then return end
local item=self:GetCell(dataIndex-1)
if item==nil then return end
local data=_this.teamsList[dataIndex]
if data==nil then return end
local pos=item:GetChildScreenPointToLocalPointRectangle(3)
zhengzhanshanhaiController:openLingLiTips(nil,data.teamguid_str,2,pos.x,pos.y,25,0)
end

function UIXM_ZZSH_teamInfoThreeWin:refreshTeamItem(teamguid_str)
local idx=self:findTeamIndex(teamguid_str)
if idx then
self.scrollscript:RefreshCell(idx,nil,nil)
end
end

function UIXM_ZZSH_teamInfoThreeWin:refreshTeamItemLQ(teamguid_str)
local idx=self:findTeamIndex(teamguid_str)
if idx then
self.scrollscript:refreshItemLQ(idx,nil)
end
end





function UIXM_ZZSH_teamInfoThreeWin:initMoney()
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

function UIXM_ZZSH_teamInfoThreeWin:refreshMoney()
local widget=self.money1Root:getWidgetBase()
local moneyType=self.costType
local moneyVal=moneyModel.getMoney(moneyType)
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildText(2,moneyStr)
end

function UIXM_ZZSH_teamInfoThreeWin:onAddClick(moneyType)
self:clickMoney(moneyType)
end

function UIXM_ZZSH_teamInfoThreeWin:clickMoney(moneyType)
gainControl:showGainWin(moneyType)
end



function UIXM_ZZSH_teamInfoThreeWin:onMaskBlock()
self:closeSelf()
end

function UIXM_ZZSH_teamInfoThreeWin:onCloseBtn()
self:closeSelf()
end

function UIXM_ZZSH_teamInfoThreeWin:onReverAllBtn()
local costType=self.costType
local costNum,list
local teamtype
if self.selectPage then
teamtype=self.teamtypeList[self.selectPage]
end
if teamtype then
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
local contentStr=FMT.fmt("是否消耗{0}恢复阵容[{1}]所有队伍精力",costStr,teamname)
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

function UIXM_ZZSH_teamInfoThreeWin:refreshReverAllBtn()
local costType=self.costType
local costNum
local teamtype
if self.selectPage then
teamtype=self.teamtypeList[self.selectPage]
end
if teamtype then
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

function UIXM_ZZSH_teamInfoThreeWin:onCancelBtn()
if not self:checkState(true)then
return
end
if not self:checkClickLock()then
return
end

local teamtype
if self.selectPage then
teamtype=self.teamtypeList[self.selectPage]
end
if teamtype and self.isManager then
if zhengzhanshanhaiModel:getOrder(teamtype)then
zhengzhanshanhaiController:reqOrderEx(teamtype)
end
end
end

function UIXM_ZZSH_teamInfoThreeWin:onCommitBtn()
if not self:checkState(true)then
return
end
if not self:checkClickLock()then
return
end

local teamtype
if self.selectPage then
teamtype=self.teamtypeList[self.selectPage]
end
if teamtype and self.isManager then
if not zhengzhanshanhaiModel:getOrder(teamtype)and self.hasTarget then
local guildid=self.guildid
local domainid=self.domainid
if domainid then
if zhengzhanshanhaiModel:getOrderNum(2)>0 then
UIManager.error('每轮只能下达一次攻占领地指令')
return
end
end
if not zhengzhanshanhaiModel:checkPvPOrder(guildid,domainid,true)then
return
end
if domainid then
if zhengzhanshanhaiModel:getMyLDData()then
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZZSHPvPtips2)
if not check then
local content='仙盟已有领地，若继续发起指令，\n战争期开始时便会放弃当前领地\n 是否确认？'
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=function()
zhengzhanshanhaiController:reqOrderEx(teamtype,guildid,domainid)
end,
showclosebtn=true,
choosetext="今日不再提示",
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZZSHPvPtips2,flag)
end,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
return
end
end
end
zhengzhanshanhaiController:reqOrderEx(teamtype,guildid,domainid)
end
end
end

function UIXM_ZZSH_teamInfoThreeWin:refreshOrderBtn()
local showCommit=false
local showCancel=false
local teamtype
if self.selectPage then
teamtype=self.teamtypeList[self.selectPage]
end
if teamtype and self.isManager and self:checkState()then
if zhengzhanshanhaiModel:getOrder(teamtype)then
showCancel=true
elseif self.hasTarget then
showCommit=true
end
end
self.commitBtn:setActive(showCommit)
if showCommit then
local commit_str
if self.guildid then
commit_str='前往掠夺'
else
commit_str='前往占领'
end
self.commitBtnTxt:setText(commit_str)
end
self.cancelBtn:setActive(showCancel)
end

function UIXM_ZZSH_teamInfoThreeWin:rec_data()
self:refreshTeamsSV()
self:refreshAllGridItemReddot()
end

function UIXM_ZZSH_teamInfoThreeWin:rec_setup(teamguid,teamtype)
local teamtype_
if self.selectPage then
teamtype_=self.teamtypeList[self.selectPage]
end
self:refreshGridItemReddot2(teamtype)
if teamtype_==teamtype then
self:refreshTeamsSV()
end
end

function UIXM_ZZSH_teamInfoThreeWin:rec_setup2(teamtype)
local teamtype_
if self.selectPage then
teamtype_=self.teamtypeList[self.selectPage]
end
self:refreshGridItemReddot2(teamtype)
if teamtype_==teamtype then
self:refreshTeamsSV()
end
end

function UIXM_ZZSH_teamInfoThreeWin:rec_lingli(lp)
for teamguid_str,v in pairs(lp)do
self:refreshTeamItemLQ(teamguid_str)
end
self:refreshReverAllBtn()
end

function UIXM_ZZSH_teamInfoThreeWin.onZZSHOrderChange(opType,order)
if _this==nil then return end




local teamtype=order.teamtype
_this:refreshGridItemSign2(teamtype)
local teamtype_
if _this.selectPage then
teamtype_=_this.teamtypeList[_this.selectPage]
end
if teamtype_==teamtype then
_this:refreshOrderBtn()
end
end