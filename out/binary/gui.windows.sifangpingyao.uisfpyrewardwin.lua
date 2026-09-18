







def_class("UISFPYRewardWin",UIWindowBase)









function UISFPYRewardWin:bindComponents()

self.titleTxt=UIText.get(self,0)
self.menuGridPanel=UIObject.get(self,1)
self.rankScrollView=UIObject.get(self,2)
self.rankItem=UIObject.get(self,3)
self.rewardScrollView=UIObject.get(self,4)
self.tipsTxt=UIText.get(self,5)
self.noItemTips=UIText.get(self,6)
self.rewardGridPanel=UIObject.get(self,7)
self.rankGridPanel=UIObject.get(self,8)
self.tipsTxt2=UIText.get(self,9)
self.tipIcon=UIImage.get(self,10)
self.closeBtn=UIButton.get(self,11)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISFPYRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
_UIObject_release(self.rankScrollView);self.rankScrollView=nil;
_UIObject_release(self.rankItem);self.rankItem=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.rewardGridPanel);self.rewardGridPanel=nil;
_UIObject_release(self.rankGridPanel);self.rankGridPanel=nil;
_UIObject_release(self.tipsTxt2);self.tipsTxt2=nil;
_UIObject_release(self.tipIcon);self.tipIcon=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end
















local pageConfig=
{
[1]={
name='排行榜',
checkReddot=function()
return false
end,
open=function(self_)
self_:openMemberPage()
end,
close=function(self_)
self_:closeMemberPage()
end,
},
[2]={
name='奖励',
checkReddot=function()
return YiYuHuiYouController:yyhyRankReddot()
end,
open=function(self_)
self_:openRewardPage()
end,
close=function(self_)
self_:closeRewardPage()
end,
},
}
local _this=nil
local menu_slot_name='button_dytab'
local abname_yyhy='ui/windows/yiyuhuiyou/yyhyimage_atlas_pak.ab'


function UISFPYRewardWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UISFPYRewardWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end

if flag then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,flag and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UISFPYRewardWin:refreshMenuItemReddot(item,idx)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local cfg=pageConfig[idx]
local isReddot=cfg.checkReddot()
item:SetChildActive(3,isReddot)
end


function UISFPYRewardWin:onMenuItemClick(page)
if page==self.curPage then
return
end

local old=self.curPage
self.curPage=page
if old~=nil then
self:refreshMenuItemSelect(nil,old,false)
self:refreshMenuPage(old,false)
end
self:refreshMenuItemSelect(nil,page,true)
self:refreshMenuPage(page,true)
end


function UISFPYRewardWin:refreshMenuPage(page,flag)
local cfg=pageConfig[page]
if flag then
cfg.open(self)
self:refreshTips()
else
cfg.close(self)
end
end


function UISFPYRewardWin:__delete()
_this=nil
self:unbindComponents()
end


function UISFPYRewardWin:onHide()

end




function UISFPYRewardWin:onShow(argtable,afterOnloaded)
local page=1
self.refreshMark={}
local level=0
local titleName
if level>0 then
titleName=xianmengModel:getLevelName_TYSC(level)
else
titleName=''
end
local title_str=FMT.fmt('排行榜')
self.titleTxt:setText(title_str)

if afterOnloaded then
local cnt=#pageConfig
self.menuGridPanel:setChildLayoutGroupCreateItems(cnt)
local grids=self.menuGridPanel:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
local cfg=pageConfig[i]
item:SetChildText(1,cfg.name)
local isSelected=i==page
local func=function()
if _this==nil then return end
if isSelected then

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,isSelected and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
end
item:SetChildUIModelShowTarget(2,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)
self:refreshMenuItemSelect(item,i,i==page)
self:refreshMenuItemReddot(item,i)
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)
end
end

_this.jifenname=cfg_yiyuhuiyoubaseconfig_get(1).jifen_icon
self:onMenuItemClick(page)
end


function UISFPYRewardWin:getRankReward(typo,rank,look)
if self.rankRewardLookup==nil then
self.rankRewardLookup={}
end
if self.rankRewardLookup[typo]==nil then
self.rankRewardLookup[typo]={}
end
if self.rankRewardLookup[typo][rank]==nil then
for i,v in ipairs(look)do
if rank>=v[1]and rank<=v[2]then
self.rankRewardLookup[typo][rank]=v[3]
return v[3]
end
end
end
return self.rankRewardLookup[typo][rank]
end

function UISFPYRewardWin:openXianMengPage()
local level=xianmengModel:getLevelEx_TYSC()
local cfg=cfgHelper.get1(cfg_skyshouchaojibieconfig_get,level)
self.rankList=xianmengModel:getXMRankList_TYSC()
local num=#self.rankList
local isShow=num>0
self.rankScrollView:setActive(isShow)
self.noItemTips:setActive(not isShow)
self.rankItem:setActive(isShow)
self.curRank=nil
self.curScore=nil
if isShow then
for i,data in ipairs(self.rankList)do
if xianmengModel:isMyXM(data.xmGuid)then
self.curRank=data.rank
self.curScore=data.jifen
break
end
end
local func=function(i)
if _this==nil then return end
local item=_this.rankGridPanel:getChildLayoutGroupGridItem(i-1)
local data=_this.rankList[i]

local rank=data.rank

local rankIcon
local rank_str=tostring(rank)
if rank<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
end
local showRankIcon=rankIcon~=nil
item:SetChildActive(6,showRankIcon)
item:SetChildActive(0,not showRankIcon)
if showRankIcon then
item:SetChildCSImageSprite(6,globalABLookup.rankList,rankIcon)
item:SetChildText(12,rank_str)
else
item:SetChildText(0,rank_str)
end

local hasXM=data.xmName~=''
item:SetChildActive(13,hasXM)
local tips2_str=''
if hasXM then

item:SetChildActive(7,true)
local image=xianmengModel.splitGuildIcon(data.xmIcon)
local abname=globalABLookup.xianmengicons

item:SetChildCSImageSprite(8,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

item:SetChildCSImageSprite(7,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

item:SetChildCSImageSprite(9,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

item:SetChildText(1,data.xmName)

local icon=moneyModel.getIconNameEx(eMoneyType.mtTianYuanJiFen)

item:SetChildText(3,data.jifen)
else
tips2_str='该仙盟已解散'
end
item:SetChildText(14,tips2_str)

playerController:setHeadIcon(item,11,nil)

local rewardList=_this:getRankReward(1,data.rank,cfg.xmRank)
local c=0
if rewardList~=nil then
c=#rewardList
end
local showReward=c>0
item:SetChildActive(4,showReward)
item:SetChildActive(5,not showReward)
if showReward then
item:SetChildLayoutGroupCreateItems(4,c)
local grids2=item:GetChildLayoutGroupGridList(4)
for i=1,c do
local rewardItem=grids2[i-1]
local itemid=rewardList[i][1]
local itemnum=rewardList[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end
end
self.rankGridPanel:setChildLayoutGroupCreateItems(num,func)

self:refreshRankItem()
else
self.noItemTips:setText('暂无排名信息')
end
end

function UISFPYRewardWin:closeXianMengPage()
self.rankScrollView:setActive(false)
self.rankItem:setActive(false)
end


function UISFPYRewardWin:openMemberPage()
local cfg=cfg_yiyuhuiyoubaseconfig_get(1)
self.rankList=YiYuHuiYouModel:getmemberRankList_YYHY()
local num=#self.rankList
local isShow=num>0
self.rankScrollView:setActive(isShow)
self.noItemTips:setActive(not isShow)
self.rankItem:setActive(isShow)
self.curRank=nil
self.curScore=nil
if isShow then
local self_idx=YiYuHuiYouModel:getself_idx()
if self_idx>0 then
if self_idx>num then
self.curRank=self_idx
else
for i,data in ipairs(self.rankList)do
if playerModel:getActorName()==data.name then
self.curRank=i
self.curScore=data.score
self.serverid=data.server_id
break
end
end
end
end
local func=function(i)
if _this==nil then return end
local item=_this.rankGridPanel:getChildLayoutGroupGridItem(i-1)
local data=_this.rankList[i]


local rank=i
local rankIcon
local rank_str=tostring(rank)
if rank<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
end
local showRankIcon=rankIcon~=nil
item:SetChildActive(6,showRankIcon)
item:SetChildActive(0,not showRankIcon)
if showRankIcon then
item:SetChildCSImageSprite(6,globalABLookup.rankList,rankIcon)
item:SetChildText(12,rank_str)
else
item:SetChildText(0,rank_str)
end

local hasMember=data.name~=''
item:SetChildActive(13,hasMember)
local tips2_str=''
local headParams
if hasMember then

item:SetChildActive(7,false)

headParams={iconInfo=data.iconInfo,scale=0.8}

local str=FMT.fmt('{0}',data.name)
if data.server_id and data.server_id==0 then
str=FMT.fmt('{0}',data.name)
elseif data.server_id and data.server_id>0 then
local serverName=loginModel:getServerName(data.server_id)
str=FMT.fmt('{0}\n[{1}]',data.name,serverName)
end
item:SetChildText(1,str)

local icon=moneyModel.getIconNameEx(eMoneyType.mtYuBi)
item:SetChildCSImageSprite(2,abname_yyhy,'yyhy_jifen')
item:SetChildText(3,data.score)
else
tips2_str=''
end
item:SetChildText(14,tips2_str)

playerController:setHeadIcon(item,11,headParams)

local rewardList=_this:getRankReward(2,i,cfg.week_rank_rewards)
local c=0
if rewardList~=nil then
c=#rewardList
end
local showReward=c>0
item:SetChildActive(4,showReward)
item:SetChildActive(5,not showReward)
if showReward then
item:SetChildLayoutGroupCreateItems(4,c)
local grids2=item:GetChildLayoutGroupGridList(4)
for i=1,c do
local rewardItem=grids2[i-1]
local itemid=rewardList[i][1]
local itemnum=rewardList[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end
end
self.rankGridPanel:setChildLayoutGroupCreateItems(num,func)

self:refreshRankItem()
else
self.noItemTips:setText('暂无排名信息')
end
end

function UISFPYRewardWin:closeMemberPage()
self.rankScrollView:setActive(false)
self.rankItem:setActive(false)
end


function UISFPYRewardWin:refreshTips()
local tips_str
if self.curPage==2 then
local num=YiYuHuiYouModel:getWeek_reward_val()or 0
tips_str=FMT.fmt('本周个人渔获积分：')
self.tipsTxt:setText(tips_str)
self.tipsTxt2:setText(FMT.fmt('{0}',num))
self.tipIcon:setActive(true)
_this.winlua:SetChildCSImageSprite(10,abname_yyhy,'yyhy_jifen')
else
tips_str='排行榜每周日24:00结算奖励，奖励将通过邮件发放'
self.tipsTxt:setText(tips_str)
self.tipsTxt2:setText('')
self.tipIcon:setActive(false)
end

end


function UISFPYRewardWin:refreshRankItem()
local item=self.rankItem:getChildWidgetBase()


local cfg=cfg_yiyuhuiyoubaseconfig_get(1)
local rewardList
local name_str
local score=self.curScore
local image
local headid=false

if self.curRank then
rewardList=self:getRankReward(2,self.curRank,cfg.week_rank_rewards)
end
name_str=playerModel:getActorName()


if score==nil then

score=YiYuHuiYouModel:getlYYHYRankBsetScore()
if score<YiYuHuiYouModel:getlYYHYRankMaxScore()then
score=YiYuHuiYouModel:getlYYHYRankMaxScore()
end
else

if score<YiYuHuiYouModel:getlYYHYRankMaxScore()then
score=YiYuHuiYouModel:getlYYHYRankMaxScore()
end
end
headid=true


local rank=self.curRank
local rankIcon
local rank_str
if rank==nil then
rank_str='未上榜'
else
rank_str=tostring(rank)
end
if rank~=nil and rank<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
end
local showRankIcon=rankIcon~=nil
item:SetChildActive(6,showRankIcon)
item:SetChildActive(0,not showRankIcon)
if showRankIcon then
item:SetChildCSImageSprite(6,globalABLookup.rankList,rankIcon)
item:SetChildText(12,rank_str)
else
item:SetChildText(0,rank_str)
end


item:SetChildActive(7,image~=nil)
if image~=nil then
local abname=globalABLookup.xianmengicons

item:SetChildCSImageSprite(8,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

item:SetChildCSImageSprite(7,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

item:SetChildCSImageSprite(9,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
end

local args
if headid then
args={iconInfo=nil,scale=0.8}
end
playerController:setHeadIcon(item,11,args)

local str=FMT.fmt('{0}',name_str)
if _this.serverid and _this.serverid==0 then
str=FMT.fmt('{0}',name_str)
elseif _this.serverid and _this.serverid>0 then
local serverName=loginModel:getServerName(_this.serverid)
str=FMT.fmt('{0}\n[{1}]',name_str,serverName)
end
item:SetChildText(1,str)


item:SetChildCSImageSprite(2,abname_yyhy,'yyhy_jifen')
item:SetChildText(3,score)

local c=0
if rewardList~=nil then
c=#rewardList
end
local showReward=c>0
item:SetChildActive(4,showReward)
item:SetChildActive(5,not showReward)
if showReward then
item:SetChildLayoutGroupCreateItems(4,c)
local grids2=item:GetChildLayoutGroupGridList(4)
for i=1,c do
local rewardItem=grids2[i-1]
local itemid=rewardList[i][1]
local itemnum=rewardList[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end
end



function UISFPYRewardWin:getRewardPageSortList()
local list={}
local level=1
local jifenReward
if level>0 then

jifenReward=cfg_yiyuhuiyoubaseconfig_get(1).week_rewards

local score=YiYuHuiYouModel:getWeek_reward_val()or 0

local prizetag=YiYuHuiYouModel:getWeek_reward_flag()or 0
local indexs=YiYuHuiYouModel:getRankList_YYHY_idxs()
for i,v in ipairs(jifenReward)do
local fix=score>=v[1]
local flag=mathHelper.getBitValue(prizetag,i-1)
local state=flag==true and 0 or 1
if flag~=true then
if indexs[i]and indexs[i]==1 then
state=0
flag=true
end
end
local weight=state*100000+(100000-v[1])
table.insert(list,{v,fix,flag,weight})
end
table.sort(list,function(a,b)
return a[4]>b[4]
end)
end
return list
end


function UISFPYRewardWin:openRewardPage()
local rankList=self:getRewardPageSortList()
local num=#rankList
local isShow=num>0
self.rewardScrollView:setActive(isShow)
self.noItemTips:setActive(not isShow)
if isShow then
local func=function(i)
if _this==nil then return end
local item=_this.rewardGridPanel:getChildLayoutGroupGridItem(i-1)
local data=rankList[i]
local cfg=data[1]
local fix=data[2]
local flag=data[3]

local icon=moneyModel.getIconNameEx(eMoneyType.mtTianYuanJiFen)

item:SetChildCSImageSprite(5,abname_yyhy,'yyhy_jifen')

item:SetChildText(0,FMT.fmt('累计渔获积分{0}',cfg[1]))

local rewardList=cfg[2]
local c=0
if rewardList~=nil then
c=#rewardList
end
local showReward=c>0
item:SetChildActive(1,showReward)
if showReward then
item:SetChildLayoutGroupCreateItems(1,c)
local grids2=item:GetChildLayoutGroupGridList(1)
for i=1,c do
local rewardItem=grids2[i-1]
local itemid=rewardList[i][1]
local itemnum=rewardList[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end

local showBtn=fix and not flag
item:SetChildActive(2,showBtn)
item:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onRewardBtn(cfg)
end)

item:SetChildActive(3,flag)

item:SetChildActive(4,not fix and not flag)
end
self.rewardGridPanel:setChildLayoutGroupCreateItems(num,func)
else
self.noItemTips:setText('暂无渔获积分奖励')
end
end

function UISFPYRewardWin:closeRewardPage()
self.rewardScrollView:setActive(false)
end


function UISFPYRewardWin:onRewardBtn(cfg)

if cfg and cfg[3]then
YiYuHuiYouController.send_248_61(cfg[3])
end
end

function UISFPYRewardWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UISFPYRewardWin:onCloseBtn()
self:closeSelf()
end



function UISFPYRewardWin:recv_reward()
if self.curPage==2 then
self:openRewardPage()
self:refreshTips()
self:refreshMenuItemReddot(nil,2)
end
end

