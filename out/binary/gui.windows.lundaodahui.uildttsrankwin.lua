







def_class("UILDTTSRankWin",UIWindowBase)









function UILDTTSRankWin:bindComponents()

self.nohaveReward=UIText.get(self,0)
self.scrollerView1=UIObject.get(self,1)
self.myRankItem=UIObject.get(self,2)
self.scrollerView2=UIObject.get(self,3)
self.panelText2=UIText.get(self,4)
self.noHaveRankList=UIObject.get(self,5)
self.ToggleGroup=UIObject.get(self,6)
self.title=UIText.get(self,7)
self.closeButton=UIButton.get(self,8)
self.panel1=UIObject.get(self,9)
self.panel2=UIObject.get(self,10)
self.panel3=UIObject.get(self,11)
self.guessSuccessLayout=UIObject.get(self,12)
self.guessFailLayout=UIObject.get(self,13)
self.guessSuccessList=UIObject.get(self,14)
self.guessFailList=UIObject.get(self,15)
self.amountText=UIText.get(self,16)
self.nullGuessTips=UIText.get(self,17)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UILDTTSRankWin")end)



end


function UILDTTSRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.nohaveReward);self.nohaveReward=nil;
_UIObject_release(self.scrollerView1);self.scrollerView1=nil;
_UIObject_release(self.myRankItem);self.myRankItem=nil;
_UIObject_release(self.scrollerView2);self.scrollerView2=nil;
_UIObject_release(self.panelText2);self.panelText2=nil;
_UIObject_release(self.noHaveRankList);self.noHaveRankList=nil;
_UIObject_release(self.ToggleGroup);self.ToggleGroup=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.panel1);self.panel1=nil;
_UIObject_release(self.panel2);self.panel2=nil;
_UIObject_release(self.panel3);self.panel3=nil;
_UIObject_release(self.guessSuccessLayout);self.guessSuccessLayout=nil;
_UIObject_release(self.guessFailLayout);self.guessFailLayout=nil;
_UIObject_release(self.guessSuccessList);self.guessSuccessList=nil;
_UIObject_release(self.guessFailList);self.guessFailList=nil;
_UIObject_release(self.amountText);self.amountText=nil;
_UIObject_release(self.nullGuessTips);self.nullGuessTips=nil;
end


















local _this=nil
local menu_slot_name='button_dytab'
local pageList=
{
{
title="名次奖励",
name="名次",
clickFunc=function(self)
self:onClickReward()
end,
},
{
title="竞猜名次",
name="竞猜",
clickFunc=function(self)
self:onClickJingCai()
end,
},
{
title="竞猜记录",
name="记录",
clickFunc=function(self)
self:onClickRecord()
end,
},
}


local ttsIdList={7,7,6,5,4,3,2}

local guessItemIndex={
matchTypeIcon=0,
player1=1,
player2=2,
moneyText=3,
moneyIcon=4,
bg=5,
}

local playerItemIndex={
iconHeadItem=0,
serverName=1,
playerName=2,
isWinner=3,
nohead=4,
}

local matchTypeIconConfig={
[1]={
iconName="image_ldjswz_3",
abName="ui/windows/lundaodahui/lundaodahui_atlas_pak.ab",
bgImgName="image_jingcaipaihang_4",
},
[2]={
iconName="image_ldjswz_2",
abName="ui/windows/lundaodahui/lundaodahui_atlas_pak.ab",
bgImgName="image_jingcaipaihang_4",
},
[3]={
iconName="image_ldjswz_1",
abName="ui/windows/lundaodahui/lundaodahui_atlas_pak.ab",
bgImgName="image_jingcaipaihang_3",
},
[4]={
iconName="image_ldjswz_5",
abName="ui/windows/lundaodahui/lundaodahui_atlas_pak.ab",
bgImgName="image_jingcaipaihang_3",
},
[5]={
iconName="image_ldjswz_6",
abName="ui/windows/lundaodahui/lundaodahui_atlas_pak.ab",
bgImgName="image_jingcaipaihang_2",
},
[6]={
iconName="image_ldjswz_7",
abName="ui/windows/lundaodahui/lundaodahui_atlas_pak.ab",
bgImgName="image_jingcaipaihang_1",
},
}

local UIPrepareEnScroller=simple_class(UIEnhancedScroller)


function UILDTTSRankWin:onLoaded(...)
self:bindComponents()
_this=self
local jcMax=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"jcRankMax")
self.panelText2:setText(FMT.fmt("至少参与一场竞猜且仙筹数量前{0}名可上榜",jcMax))
notifySystem:listenNotify(notifyConfig.serverZoneFresh,function()
self:onRefreshJingCai()
end)

self.enhancedscrollscript=UIPrepareEnScroller(self.scrollerView2:getGameObject(),self.scrollerView2:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self
end


function UILDTTSRankWin:__delete()
self:unbindComponents()
_this=nil
end




function UILDTTSRankWin:onShow(argtable,afterOnloaded)
self.selectPage=argtable or 1
self:loadBtns()
self:onSelectPage(self.selectPage)
end


function UILDTTSRankWin:onHide()

end

function UILDTTSRankWin:loadBtns()
local len=#pageList
self.ToggleGroup:setChildScrollViewCreateGrids(len,1)
self.selectPage=self.selectPage or 1
local items=self.ToggleGroup:getChildScrollViewItemWidgets()
for i=1,len do
local name=pageList[i].name
local sitem=items[i-1]
local item=sitem:GetChildWidgetBase(0)
item:SetChildButtonClickWithID(0,self.onToggleChange,i,true)
item:SetChildText(1,name)

local isSelected=self.selectPage==i
local func=function()
if isSelected then

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,isSelected and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
end
item:SetChildUIModelShowTarget(2,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)
end
end

function UILDTTSRankWin.onToggleChange(idx)
if _this.selectPage~=idx then
if _this.selectPage then
_this:setToggleOn(_this.selectPage,false)
end
_this:setToggleOn(idx,true)

_this:onSelectPage(idx)
end
end

function UILDTTSRankWin:setToggleOn(index,on)
local sitem=self.ToggleGroup:getChildScrollViewItemWidget(index-1)
local item=sitem:GetChildWidgetBase(0)
if on then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,on and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UILDTTSRankWin:onSelectPage(idx)
self.selectPage=idx

local title=pageList[idx].title
self.title:setText(title)
pageList[idx].clickFunc(self)

end

local abName="ui/windows/lundaodahui/lundaodahui_atlas_pak.ab"

function UILDTTSRankWin:onClickReward()
self.panel1:setActive(true)
self.panel2:setActive(false)
self.panel3:setActive(false)
if not self.initReward then
local idListLen=#ttsIdList
self.scrollerView1:setChildScrollViewCreateGrids(idListLen,1)
local items=self.scrollerView1:getChildScrollViewItemWidgets()
for i=1,idListLen do
local item=items[i-1]
local id=ttsIdList[i]
local cfg=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,id)
local rewardList=cfg.reward

if rewardList then
if id==7 then
rewardList=rewardList[i]
end
if i<4 then
item:SetChildCSImageSprite(0,abName,FMT.fmt("imge_lundaopm_{0}",i))
else
item:SetChildCSImageSprite(0,abName,FMT.fmt("image_ldjswz_{0}",i-3))
end
local rLen=#rewardList
item:SetChildLayoutGroupCreateItems(1,rLen)
local gridList=item:GetChildLayoutGroupGridList(1)
for ii=1,rLen do
local grid=gridList[ii-1]
if grid then
local reward=rewardList[ii]
local itemid=reward[1]
local count=reward[2]
local conf={itemid=itemid,itemcount=count<=1 and""or count,showCountBG=count>1,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
grid:SetChildActive(-1,true)
grid:SetChildPropData(0,prop)
grid:SetBaseItemClickEvent(0,function(...)
self:onClickItem(...)
end)
end
end
end
end
self.initReward=true
end
end

function UILDTTSRankWin:onClickItem(itemid,index,guid,attach)

if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=guid,move=TIPS_MOVE_POS.eCenter})
end

function UILDTTSRankWin:onClickJingCai()
self.panel1:setActive(false)
self.panel2:setActive(true)
self.panel3:setActive(false)
if not self.initJingCai then
if self.waitToData then
return
end
if not self.jingCaiData then
lundaodahuiController.req_17_25()
self.waitToData=true
else
self:onRefreshJingCai()
end
end
end

function UILDTTSRankWin:onRecvJingCai(rankData,jcbNum)
local jingCaiRankData={}
local jcMax=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"jcRankMax")
if rankData then
local playerId=playerModel:getActorID()
local playerRankData=nil
local lastRank=0
local lastRankData=nil
for i,v in ipairs(rankData)do
if tostring(playerId)==tostring(v.playerId)then
playerRankData=v
end
if v.rank>0 then
table.insert(jingCaiRankData,v)
end
if v.rank>lastRank then
lastRank=v.rank
lastRankData=v
end
end

if lastRankData and not playerRankData and jcbNum==lastRankData.jcbNum then
local name=playerModel:getOtherActorName(playerModel:getActorName())
local pData={serverId=playerModel:getActorServerID(),playerId=playerId,name=name,iconInfo=playerModel:getActorIconInfo(),jcbNum=jcbNum,rank=lastRankData.rank}
table.insert(jingCaiRankData,pData)
playerRankData=pData
end


table.sort(jingCaiRankData,self.sortRank)
local num=#jingCaiRankData

if num<jcMax then
for i=num+1,jcMax do
table.insert(jingCaiRankData,{serverId=-1,playerId=-1,name="虚位以待",icon=-1,jcbNum=0,rank=i})
end
end
self.playerRankData=playerRankData
else
for i=1,jcMax do
table.insert(jingCaiRankData,{serverId=-1,playerId=-1,name="虚位以待",icon=-1,jcbNum=0,rank=i})
end
end
self.jingCaiData=jingCaiRankData
self.jcbNum=jcbNum
self:onRefreshJingCai()
end

function UILDTTSRankWin.sortRank(a,b)
return a.rank<b.rank
end
local doufataiabName='ui/windows/doufatai/doufatai_atlas_pak.ab'
function UILDTTSRankWin:onRefreshJingCai()
self.initJingCai=true
local jingCaiRankData=self.jingCaiData
local playerRankData=self.playerRankData


local rewardLists=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"jcRankReward")







self.enhancedscrollscript:initData(jingCaiRankData,92,#jingCaiRankData)

self.noHaveRankList:setActive(#jingCaiRankData==0)

local playerItem=self.myRankItem:getChildWidgetBase()
local hItem=playerItem:GetChildWidgetBase(5)
local myServer=playerModel:getActorServerID()
local myName=playerModel:getActorName()
lundaodahuiController:setHead(hItem)
local serverName=loginModel:getServerName(myServer)
playerItem:SetChildText(2,FMT.fmt("{0}\n{1}",serverName,myName))

local have=lundaodahuiModel:getJcbNum()

local notHaveReward=false
local rewardList
if playerRankData then
local rank=playerRankData.rank
playerItem:SetChildText(1,rank)

for i,v in ipairs(rewardLists)do
if rank>=v[1]and rank<=v[2]then
rewardList=v[3]
end
end
if rank<4 then
local imgName=FMT.fmt('icon_phbmingci_{0}',rank)
playerItem:SetChildCSImageSprite(0,doufataiabName,imgName)
end
local noRank=false
if not rewardList then
noRank=true
rewardList=rewardLists[#rewardLists][3]
end

if not noRank then
playerItem:SetChildText(6,FMT.fmt("{0}仙筹",playerRankData.jcbNum))
else
playerItem:SetChildText(1,"未上榜")

playerItem:SetChildText(6,FMT.fmt("{0}仙筹",self.jcbNum)or"")
end
else
playerItem:SetChildText(1,"未上榜")
playerItem:SetChildText(6,FMT.fmt("{0}仙筹",self.jcbNum)or"")

if not rewardList then
rewardList=rewardLists[#rewardLists][3]
end
end
local rLen=#rewardList
playerItem:SetChildLayoutGroupCreateItems(4,rLen)
local gridList=playerItem:GetChildLayoutGroupGridList(4)
for ii=1,rLen do
local grid=gridList[ii-1]
if grid then
local reward=rewardList[ii]
local itemid=reward[1]
local count=reward[2]
local conf={itemid=itemid,itemcount=count<=1 and""or count,showCountBG=count>1,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
grid:SetChildActive(-1,true)
grid:SetChildPropData(0,prop)
grid:SetBaseItemClickEvent(0,function(...)
self:onClickItem(...)
end)
end
end

self.nohaveReward:setActive(notHaveReward)
end

function UILDTTSRankWin:onRefreshRankItem(item,jingCaiData)
local rewardLists=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"jcRankReward")
local rank=jingCaiData.rank

item:SetChildText(1,rank)
if rank<4 then
item:SetChildActive(0,true)
local imgName=FMT.fmt('icon_phbmingci_{0}',rank)
item:SetChildCSImageSprite(0,doufataiabName,imgName)
else
item:SetChildActive(0,false)
end
local name=playerModel:getOtherActorName(jingCaiData.name)
if jingCaiData.serverId==-1 or jingCaiData.serverId==0 then
item:SetChildActive(5,false)
item:SetChildActive(7,true)
item:SetChildText(6,"")
item:SetChildText(2,name)
else
local serverName=loginModel:getServerName(jingCaiData.serverId)
if not jingCaiData.name or jingCaiData.name==""then
item:SetChildText(2,FMT.fmt("{0}\n{1}","未知区服",name))
item:SetChildActive(5,false)
item:SetChildActive(7,true)
else
item:SetChildText(2,FMT.fmt("{0}\n{1}",serverName,name))
item:SetChildActive(5,true)
item:SetChildActive(7,false)
local hItem=item:GetChildWidgetBase(5)
lundaodahuiController:setHead(hItem,jingCaiData.iconInfo)
end
item:SetChildText(6,FMT.fmt("{0}仙筹",jingCaiData.jcbNum))
end

local rewardList
for i,v in ipairs(rewardLists)do
if rank>=v[1]and rank<=v[2]then
rewardList=v[3]
end
end
if rewardList then
local rLen=#rewardList
item:SetChildLayoutGroupCreateItems(4,rLen)
local gridList=item:GetChildLayoutGroupGridList(4)
for ii=1,rLen do
local grid=gridList[ii-1]
if grid then
local reward=rewardList[ii]
local itemid=reward[1]
local count=reward[2]
local conf={itemid=itemid,itemcount=count<=1 and""or count,showCountBG=count>1,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
grid:SetChildActive(-1,true)
grid:SetChildPropData(0,prop)
grid:SetBaseItemClickEvent(0,function(...)
self:onClickItem(...)
end)
end
end
else
item:SetChildLayoutGroupCreateItems(4,0)
end
end

function UILDTTSRankWin:onClickRecord()
self.panel1:setActive(false)
self.panel2:setActive(false)
self.panel3:setActive(true)
if not self.initRecord then
if self.waitToRecordData then
return
end
if not self.recordData then

lundaodahuiController.req_17_34()
self.waitToRecordData=true
else

self:onRefreshRecord()
end
end
end

function UILDTTSRankWin:onRefreshRecord()
self.initRecord=true
local isShowNullTips=true
local recordData=self.recordData
local amountMoneyChange=0

local successList=recordData.successList
if successList and next(successList)then
self.guessSuccessLayout:setActive(true)
local count=#successList
self.guessSuccessList:setChildLayoutGroupCreateItems(count)
local grids=self.guessSuccessList:getChildLayoutGroupGridList()
for i=1,grids.Count do
local item=grids[i-1]
local data=successList[i]
self:refreshGuessRecordItem(item,data)
amountMoneyChange=amountMoneyChange+data.jcbChange
end
isShowNullTips=false
else
self.guessSuccessLayout:setActive(false)
end


local failList=recordData.failList
if failList and next(failList)then
self.guessFailLayout:setActive(true)
local count=#failList
self.guessFailList:setChildLayoutGroupCreateItems(count)
local grids=self.guessFailList:getChildLayoutGroupGridList()
for i=1,grids.Count do
local item=grids[i-1]
local data=failList[i]
self:refreshGuessRecordItem(item,data)
amountMoneyChange=amountMoneyChange+data.jcbChange
end
isShowNullTips=false
else
self.guessFailLayout:setActive(false)
end

self.nullGuessTips:setActive(isShowNullTips)
self.amountText:setActive(not isShowNullTips)
if not isShowNullTips then
local moneyStr
if amountMoneyChange>=0 then

moneyStr=FMT.cfmt(FONT_COLOR.eGreenColor,"+{0}",amountMoneyChange)
else

moneyStr=FMT.cfmt(FONT_COLOR.eRedColor,"{0}",amountMoneyChange)
end
self.amountText:setText(moneyStr)
end

end

function UILDTTSRankWin:onRecvRecord(recordList)
local recordData={}
recordData.successList={}
recordData.failList={}
local fightIdWeightList={

[1]=10,[2]=10,[3]=10,[4]=10,
[9]=10,[10]=10,[11]=10,[12]=10,
[17]=10,[18]=10,[19]=10,[20]=10,
[25]=10,[26]=10,[27]=10,[28]=10,

[5]=20,[6]=20,[13]=20,[14]=20,
[21]=20,[22]=20,[29]=20,[30]=20,

[7]=30,[15]=30,[23]=30,[31]=30,

[8]=40,[16]=40,

[24]=50,

[32]=60,
}
if recordList then

table.sort(recordList,function(a,b)
local weight_a=fightIdWeightList[a.fightId]or 0
local weight_b=fightIdWeightList[b.fightId]or 0
return weight_a>weight_b
end)


for i,v in ipairs(recordList)do
local weight=fightIdWeightList[v.fightId]or 0
v.matchType=weight/10
if v.jcbChange>=0 then

table.insert(recordData.successList,v)
else

table.insert(recordData.failList,v)
end
end
end
self.recordData=recordData
self:onRefreshRecord()
end


function UILDTTSRankWin:refreshGuessRecordItem(widget,data)
if not widget or not data then
return
end

local matchType=data.matchType
local matchTypeIconCfg=matchTypeIconConfig[matchType]
if matchTypeIconCfg then

widget:SetChildCSImageSprite(guessItemIndex.matchTypeIcon,matchTypeIconCfg.abName,matchTypeIconCfg.iconName)

widget:SetChildCSImageSprite(guessItemIndex.bg,matchTypeIconCfg.abName,matchTypeIconCfg.bgImgName)
end


local playerWidget_1=widget:GetChildWidgetBase(guessItemIndex.player1)
local headItem_1=playerWidget_1:GetChildWidgetBase(playerItemIndex.iconHeadItem)
lundaodahuiController:setHead(headItem_1,data.iconInfo1)
if not data.name1 or data.name1==""then
local name=playerModel:getOtherActorName(data.name1)
playerWidget_1:SetChildText(playerItemIndex.playerName,name)
playerWidget_1:SetChildText(playerItemIndex.serverName,FMT.fmt("[{0}]",'未知区服'))
playerWidget_1:SetChildActive(playerItemIndex.nohead,true)
else
playerWidget_1:SetChildText(playerItemIndex.playerName,data.name1)
local serverName1=loginModel:getServerName(data.serverId1)or"未知区服"
playerWidget_1:SetChildText(playerItemIndex.serverName,FMT.fmt("[{0}]",serverName1))
playerWidget_1:SetChildActive(playerItemIndex.nohead,false)
end

playerWidget_1:SetChildActive(playerItemIndex.isWinner,data.winPlayer==1)


local playerWidget_2=widget:GetChildWidgetBase(guessItemIndex.player2)
local headItem_2=playerWidget_2:GetChildWidgetBase(playerItemIndex.iconHeadItem)
lundaodahuiController:setHead(headItem_2,data.iconInfo2)
if not data.name2 or data.name2==""then
local name=playerModel:getOtherActorName(data.name2)
playerWidget_2:SetChildText(playerItemIndex.playerName,name)
playerWidget_2:SetChildText(playerItemIndex.serverName,FMT.fmt("[{0}]","未知区服"))
playerWidget_2:SetChildActive(playerItemIndex.nohead,true)
else
playerWidget_2:SetChildText(playerItemIndex.playerName,data.name2)
local serverName2=loginModel:getServerName(data.serverId2)or"未知区服"
playerWidget_2:SetChildText(playerItemIndex.serverName,FMT.fmt("[{0}]",serverName2))
playerWidget_2:SetChildActive(playerItemIndex.nohead,false)
end

playerWidget_2:SetChildActive(playerItemIndex.isWinner,data.winPlayer==2)


local moneyStr
if data.jcbChange>=0 then

moneyStr=FMT.cfmt(FONT_COLOR.eGreenColor,"+{0}",data.jcbChange)
else

moneyStr=FMT.cfmt(FONT_COLOR.eRedColor,"{0}",data.jcbChange)
end
widget:SetChildText(guessItemIndex.moneyText,moneyStr)
local moneyType=eMoneyType.mtJingCaiBi
local moneyIcon=iconHelper.getIconName(moneyType)
widget:SetChildIcon(guessItemIndex.moneyIcon,moneyIcon,false)
end

function UILDTTSRankWin:onClickItem(itemid,index,guid,attach)

if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=guid,move=TIPS_MOVE_POS.eCenter})
end

function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end


function UIPrepareEnScroller:RefreshCell(i,cellIndex,item)
local jingCaiData=self.window.jingCaiData[i]
self.window:onRefreshRankItem(item,jingCaiData)
end


