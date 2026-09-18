







def_class("UIXM_ZZSH_XMRankListWin",UIWindowBase)









function UIXM_ZZSH_XMRankListWin:bindComponents()

self.leftList=UIObject.get(self,0)
self.RankList=UIObject.get(self,1)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,2)
self.menuAnimGrid=UIObject.get(self,3)
self.menu_anim_1=UIObject.get(self,4)
self.menu_anim_2=UIObject.get(self,5)
self.menu_anim_3=UIObject.get(self,6)
self.saijiText=UIText.get(self,7)
self.serverPanel=UIObject.get(self,8)
self.hisPanel=UIObject.get(self,9)
self.S_ScrollView=UIScrollViewSlow.get(self,10)
self.HisScrollerScript=UIEnhancedScrollerLua.get(self,11)
self.RaceTitleImage=UIImage.get(self,12)
self.RaceTimeText=UIText.get(self,13)
self.localXMDataBtn=UIObject.get(self,14)
self.jifenBtn=UIObject.get(self,15)
self.localXMRankvalue=UIText.get(self,16)
self.Bg=UIButton.get(self,17)
self.jifenText=UIText.get(self,18)
self.notLog=UIObject.get(self,19)
self.seasonTips=UIObject.get(self,20)

self.Bg:setButtonClick(function()self:onBg()end)
self.menu_anim={
self.menu_anim_1,
self.menu_anim_2,
self.menu_anim_3,
}
self.S={
["ScrollView"]=self.S_ScrollView,
}



end


function UIXM_ZZSH_XMRankListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftList);self.leftList=nil;
_UIObject_release(self.RankList);self.RankList=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
_UIObject_release(self.menuAnimGrid);self.menuAnimGrid=nil;
_UIObject_release(self.menu_anim_1);self.menu_anim_1=nil;
_UIObject_release(self.menu_anim_2);self.menu_anim_2=nil;
_UIObject_release(self.menu_anim_3);self.menu_anim_3=nil;
_UIObject_release(self.saijiText);self.saijiText=nil;
_UIObject_release(self.serverPanel);self.serverPanel=nil;
_UIObject_release(self.hisPanel);self.hisPanel=nil;
_UIObject_release(self.S_ScrollView);self.S_ScrollView=nil;
_UIObject_release(self.HisScrollerScript);self.HisScrollerScript=nil;
_UIObject_release(self.RaceTitleImage);self.RaceTitleImage=nil;
_UIObject_release(self.RaceTimeText);self.RaceTimeText=nil;
_UIObject_release(self.localXMDataBtn);self.localXMDataBtn=nil;
_UIObject_release(self.jifenBtn);self.jifenBtn=nil;
_UIObject_release(self.localXMRankvalue);self.localXMRankvalue=nil;
_UIObject_release(self.Bg);self.Bg=nil;
_UIObject_release(self.jifenText);self.jifenText=nil;
_UIObject_release(self.notLog);self.notLog=nil;
_UIObject_release(self.seasonTips);self.seasonTips=nil;
self.menu_anim=nil;
self.S=nil;
end


















local this
local eBtnListType=
{



ServerList=1,
}
local eRoleRankType=
{
attack=1,
defend=2,
XMIntegral=3,
}

local CdTime=30


local typeList={eBtnListType.ServerList}
local typeName={"区服列表"}

local leftCmp={
owner=-1,
select=0,
name=1,
}


local UIXM_ZZSH_RaceXMRankItem=
{
rankframe=2,
rankNo=3,
serversName=4,
playerName=5,
jifenCount=6,
XMName=7,
itemList=8,
}

local UIXM_ZZSH_HisItem=
{
TitleText=0,
oneXMNameText=1,
twoXMNameText=2,
threeXMNameText=3,
oneXMScoreText=4,
oneXMScoreText=5,
oneXMScoreText=6,
}

local serverItemCmp=
{
ServerName=0,
XMname=1,
selfFlag=2,
bg=3,
selectBg=4,
}
local body_menu_id=2017
local menu_slot_name='button_dytab'

local UIXMEnScroller=simple_class(UIEnhancedScroller)

local UIhISEnScroller=simple_class(UIEnhancedScroller)

function UIXM_ZZSH_XMRankListWin:bindEnScroller()

self.enhancedscrollscript=UIXMEnScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self

self.hISenhancedscrollscript=UIhISEnScroller(self.HisScrollerScript:getGameObject(),self.HisScrollerScript:getCSharpObject(),nil,nil)
self.hISenhancedscrollscript.window=self

self.S_ScrollView:setSlowClickAction(function(...)self:onScrollItemClick(...)end)
self.S_ScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)
end


function UIXM_ZZSH_XMRankListWin:onLoaded(...)
this=self
self:bindComponents()
self:bindEnScroller()
self.localRankCfg=zhengzhanshanhaiController:getZZSHCfg('rank')
self.TimeRecord=zhengzhanshanhaiModel:getTimeRecord()

self.PanelList={self.serverPanel}
self.jifenpanle=false
self:shwoMenu_Anim()
self:refreshLeft()
self:onClickLeft(eBtnListType.ServerList)
end


function UIXM_ZZSH_XMRankListWin:__delete()
self:unbindComponents()
end




function UIXM_ZZSH_XMRankListWin:onShow(argtable,afterOnloaded)
local ret=zhengzhanshanhaiModel:saveServerListBrowsedSeasonId()
self:refreshRaceIcon()
self:refreshRaceTimer()

if ret then
UIManager:invokeUIMethod("UIXM_ZZSH_MapWin","refreshRace")
end
end


function UIXM_ZZSH_XMRankListWin:onHide()

end


function UIXM_ZZSH_XMRankListWin:refreshRaceTimer()
local actID=LIMIT_ACT_TYPE.eZhengZhanShanHai
local data=limitActivitiesModel:getActInfo(actID)
if data then
local startstr=timeHelper.getFiveFormatByStamp(data.start_time_l)
local endstr=timeHelper.getFiveFormatByStamp(data.end_time_l)
self.RaceTimeText:setText(string.format("%s-%s",startstr,endstr))
end
end


function UIXM_ZZSH_XMRankListWin:refreshRaceIcon()
local icon
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then
local raceIndex=zhengzhanshanhaiModel:getRaceIndex()
icon=cfgHelper.get2(cfg_zhengzhanshanhaisessionconfig_get,raceIndex,'mapicon')
else

icon=cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,shSeasonId,"seasonIconid")
end
self.RaceTitleImage:setSprite(globalABLookup.zzshtitleicons,FMT.fmt('image_shanhaishijiebt_{0}',icon))
end


local _colomn=4

function UIXM_ZZSH_XMRankListWin:freshServerGirds()
self.PanelList[self.selected]:setActive(true)
local isShowSeasonTips=false
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId>0 then
isShowSeasonTips=true
end
self.seasonTips:setActive(isShowSeasonTips)
local width=self.S_ScrollView:getChildSizeDeltaX()
local height=isShowSeasonTips and 440 or 480
self.S_ScrollView:setChildSizeDelta(width,height)

self.ServerList=zhengzhanshanhaiModel:getServerList()
local row=math.ceil(#self.ServerList/_colomn)
self.notLog:setActive(#self.ServerList==0)
self.S_ScrollView:freshSlowGrids(#self.ServerList,row,_colomn,not self.isSetZero)
self.isSetZero=true


end

function UIXM_ZZSH_XMRankListWin:onScrollItemClick(id,index,guid,attach)
if id==-1 then
return
end
end


function UIXM_ZZSH_XMRankListWin:bindGrid(index,serverItem)
local serverName
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
local sid=self.ServerList[index]
local isShowSelfFlag=false
if shSeasonId==-1 then

if deviceHelper.isRunNoneOrEditor()then
serverName=loginModel:getServerName(sid)

serverItem:SetChildText(serverItemCmp.XMname,serverName)
return
end

serverName=loginModel:getServerName(sid)
else

serverName=loginModel:getCrossZoneName(sid)or'未知区服'
local cross_sid=loginModel:getCrossServerId()
isShowSelfFlag=sid==cross_sid
end
serverItem:SetChildText(serverItemCmp.XMname,serverName)
serverItem:SetChildActive(serverItemCmp.selfFlag,isShowSelfFlag)
serverItem:SetChildActive(serverItemCmp.bg,not isShowSelfFlag)
serverItem:SetChildActive(serverItemCmp.selectBg,isShowSelfFlag)
end


function UIXM_ZZSH_XMRankListWin:shwoMenu_Anim()
for i,v in ipairs(self.menu_anim)do
if i<=1 then
local anim=self.menu_anim[i]
local func=function(...)
self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,1==i and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
anim:setChildUIModelShowTarget(body_menu_id,1,{},eAnimationID.common_window_enter,false,false,0,func)
end
end
end


function UIXM_ZZSH_XMRankListWin:refreshLeft()
self.leftList:setChildLayoutGroupCreateItems(#typeList,function(idx)
local leftItem=self.leftList:getChildLayoutGroupGridItem(idx-1)
local TitleName=typeName[idx]
leftItem:SetChildText(leftCmp.name,TitleName)
leftItem:SetChildButtonClickWithID(leftCmp.owner,function(index)
self:onClickLeft(index)
end,idx)
end)
end

function UIXM_ZZSH_XMRankListWin:onClickLeft(index)

if self.selected~=index then
if self.selected then
self.PanelList[self.selected]:setActive(false)
local anim=self.menu_anim[self.selected]
self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,FMT.fmt("{0}_{1}",menu_slot_name,1))
end
self.selected=index
local anim=self.menu_anim[self.selected]
if self.selected then
anim:setChildModelAnimationState(eAnimationID.common_window_dianji)
self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,FMT.fmt("{0}_{1}",menu_slot_name,2))
end

self:onClickHandle()
end
end




function UIXM_ZZSH_XMRankListWin:onClickHandle()
self.MomentumData=zhengzhanshanhaiModel:getMomentumData()
if self.selected==eBtnListType.XMRank then
local Recordid=self.selected*100
if self.TimeRecord[Recordid]and self.MomentumData then
local reqCd=((os.time()-self.TimeRecord[Recordid])>=CdTime)
if reqCd then
self.TimeRecord[Recordid]=os.time()
self:reqHandle()
else
self:refreshRight()
end
else
self.TimeRecord[Recordid]=os.time()
self:reqHandle()
end
elseif self.selected==eBtnListType.ServerList then
self:freshServerGirds()
else
local Recordid=self.selected*100
if self.TimeRecord[Recordid]and self.MomentumData then
local reqCd=((os.time()-self.TimeRecord[Recordid])>=CdTime)
if reqCd then
self.TimeRecord[Recordid]=os.time()
self:reqHandle()
else
self:refreshRight()
end
else
self.TimeRecord[Recordid]=os.time()
self:reqHandle()
end
end
end


function UIXM_ZZSH_XMRankListWin:reqHandle()
if self.selected==eBtnListType.XMRank then
zhengzhanshanhaiController:reqRaceXMRankData()
elseif self.selected==eBtnListType.hisList then
zhengzhanshanhaiController:reqHisData()
end
end


function UIXM_ZZSH_XMRankListWin:refreshRight()
self.PanelList[self.selected]:setActive(true)
self.MomentumData=zhengzhanshanhaiModel:getMomentumData()
if self.selected==eBtnListType.XMRank then
local str=self.MomentumData.myRaceXMRankIndex and self.MomentumData.myRaceXMRankIndex or"未上榜"
self.localXMRankvalue:setText(str)
self.notLog:setActive(#self.MomentumData.RaceXMRankList==0)
self.enhancedscrollscript:initData(self.MomentumData.RaceXMRankList,91,#self.MomentumData.RaceXMRankList)
elseif self.selected==eBtnListType.hisList then
self.notLog:setActive(#self.MomentumData.RacehisList==0)
self.hISenhancedscrollscript:initData(self.MomentumData.RacehisList,140,#self.MomentumData.RacehisList)
end
end





function UIXMEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIXMEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIXMEnScroller:RefreshCell(dataIndex,cellIndex,cell)
local curdata=this.MomentumData.RaceXMRankList[dataIndex]
local guildid=curdata.guildid
local guildname=curdata.guildname
local score=curdata.score

local itemCmp=cell
local frameName=rankListModel.getFrameName(dataIndex)
if frameName then
itemCmp:SetChildCSImageSprite(UIXM_ZZSH_RaceXMRankItem.rankframe,globalABLookup.rankList,frameName)
else
itemCmp:SetChildIcon(UIXM_ZZSH_RaceXMRankItem.rankframe,"",false)
end
itemCmp:SetChildText(UIXM_ZZSH_RaceXMRankItem.rankNo,dataIndex)
itemCmp:SetChildText(UIXM_ZZSH_RaceXMRankItem.serversName,guildname)
itemCmp:SetChildText(UIXM_ZZSH_RaceXMRankItem.jifenCount,score)

local rewardList={}
local curRankCfg=this.localRankCfg[eRoleRankType.XMIntegral]
local rankWewardCfg=curRankCfg[2]
for i=1,#rankWewardCfg do
if i==1 then
if dataIndex==1 then
rewardList=rankWewardCfg[i][2]
break
end
else
if dataIndex>rankWewardCfg[i-1][1]and dataIndex<=rankWewardCfg[i][1]then
rewardList=rankWewardCfg[i][2]
break
end
end
end
itemCmp:SetChildLayoutGroupCreateItems(UIXM_ZZSH_RaceXMRankItem.itemList,#rewardList)
local grids=itemCmp:GetChildLayoutGroupGridList(UIXM_ZZSH_RaceXMRankItem.itemList)
for i=1,#rewardList do
local widget=grids[i-1]
local reward=rewardList[i]
local itemid=reward[1]
local count=reward[2]
local conf={itemid=itemid,itemcount=mathHelper.formatNumber(count),showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
this:onClickItem(...)
end)
end
end

function UIXM_ZZSH_XMRankListWin:onClickItem(itemid,index,guid,attach)

if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=guid})
end

function UIXM_ZZSH_XMRankListWin:onCloseClick()
self:closeSelf()
end



function UIhISEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIhISEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end
function UIhISEnScroller:RefreshCell(dataIndex,cellIndex,cell)
local curdata=this.MomentumData.RacehisList[dataIndex]
local guildList=curdata.guildList
local seasonId=curdata.session
local isSeason=curdata.isSeason
local name
if not isSeason then
name=cfgHelper.get2(cfg_zhengzhanshanhaisessionconfig_get,seasonId,'name')
else

name=cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,seasonId,'name')
end
local str=string.format("第%s届  %s",dataIndex,name)
cell:SetChildText(UIXM_ZZSH_HisItem.TitleText,str)
for i=1,#guildList do
cell:SetChildText(i,guildList[i].param_1)
cell:SetChildText(i+3,string.format("%s分",guildList[i].param_2))
end
end


function UIXM_ZZSH_XMRankListWin:localXmClick()
zhengzhanshanhaiController:openUIXM_ZZSH_localXmDataWin()
end


function UIXM_ZZSH_XMRankListWin:ScoreClick()
self.jifenpanle=not self.jifenpanle
self.Bg:setActive(self.jifenpanle)
self.ruleText=zhengzhanshanhaiController:getZZSHCfg('RaceScorerRule')
self.jifenText:setText(self.ruleText)

end
function UIXM_ZZSH_XMRankListWin:onBg()
self:ScoreClick()
self.jifenpanle=false
end
function UIXM_ZZSH_XMRankListWin:onClosejifenClick()

end

