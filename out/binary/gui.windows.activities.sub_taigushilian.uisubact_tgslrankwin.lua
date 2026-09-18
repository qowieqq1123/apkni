







def_class("UISubAct_tgslRankWin",UIWindowBase)









function UISubAct_tgslRankWin:bindComponents()

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
self.taskScroller=UIObject.get(self,12)
self.paihangbangbtn=UIButton.get(self,13)
self.jianglibtn=UIButton.get(self,14)
self.phbimg=UIImage.get(self,15)
self.jlimg=UIImage.get(self,16)
self.myshanghai=UIText.get(self,17)
self.myalldamage=UIText.get(self,18)
self.iconpanel=UIObject.get(self,19)
self.bosstime=UIText.get(self,20)
self.jlreddot=UIObject.get(self,21)
self.pjbtn=UIButton.get(self,22)
self.lines=UIObject.get(self,23)
self.timess=UIObject.get(self,24)
self.bosstips=UIObject.get(self,25)
self.bosstipss=UIObject.get(self,26)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.paihangbangbtn:setButtonClick(function()self:onPaihangbangbtn()end)

self.jianglibtn:setButtonClick(function()self:onJianglibtn()end)

self.pjbtn:setButtonClick(function()self:onPjbtn()end)



end


function UISubAct_tgslRankWin:unbindComponents()
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
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.paihangbangbtn);self.paihangbangbtn=nil;
_UIObject_release(self.jianglibtn);self.jianglibtn=nil;
_UIObject_release(self.phbimg);self.phbimg=nil;
_UIObject_release(self.jlimg);self.jlimg=nil;
_UIObject_release(self.myshanghai);self.myshanghai=nil;
_UIObject_release(self.myalldamage);self.myalldamage=nil;
_UIObject_release(self.iconpanel);self.iconpanel=nil;
_UIObject_release(self.bosstime);self.bosstime=nil;
_UIObject_release(self.jlreddot);self.jlreddot=nil;
_UIObject_release(self.pjbtn);self.pjbtn=nil;
_UIObject_release(self.lines);self.lines=nil;
_UIObject_release(self.timess);self.timess=nil;
_UIObject_release(self.bosstips);self.bosstips=nil;
_UIObject_release(self.bosstipss);self.bosstipss=nil;
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
name='阶段奖励',
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
local abname='ui/windows/activities/sub_taigushilian/taigushilian_atlas_pak.ab'
local abname2='ui/windows/activities/sub_suoyaoshilian/suoyaoshilian_atlas_pak.ab'
local rankstate=
{
unopen=0,
open=1,
finish=2,
}
local shoulingindex=
{
name=2,
reddot=3,
ywcimg=4,
yjsimg=5,
select=6,
btn=7,
numbg=8,
num=9,
black=10,
lock=11,
}
local ranksptxt=
{
[1]="伤害达{0}可进前一",
[2]="伤害达{0}可进前二",
[3]="伤害达{0}可进前三",
[4]="伤害达{0}可进前四",
}


function UISubAct_tgslRankWin:onLoaded(...)
_this=self
self:bindComponents()
self.topimg={0,1,2,3}
self.topimgpoint={4,5,6,7}
end


function UISubAct_tgslRankWin:__delete()
self:unbindComponents()
_this=nil
end


function UISubAct_tgslRankWin:onHide()

end




function UISubAct_tgslRankWin:onShow(argtable,afterOnloaded)
local page=1
if argtable then
self.actID=argtable[1]
self.subType=argtable[2]
self.subid=argtable[3]
page=argtable[4]or 1
self.shoulingIdx=argtable[5]or 1
end

self.titleTxt:setText('')
self.info=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
self.startday=self.info.start_day_idx
self.start_time=self.info.start_time
self.mydata=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.istworeward=false
self.thetgindx=0


self.showList={}
self.bossState=activitiesHandle_taiguBoss:checkbossOpen(_this.actID,_this.subType,_this.subid)
local boss_config=cfg_taigushilianconfig_get(_this.subid).boss
for k,v in ipairs(boss_config)do
if self.bossState[k]==rankstate.finish or self.bossState[k]==rankstate.open then
local mosterGroupid=v[1][1][1][1]



local slnamecfg=cfg_taigushilianconfig_get(_this.subid).slname
local slname=slnamecfg[mosterGroupid]or""
table.insert(self.showList,{v,slname,self.bossState[k]})
end
end
local num=#self.showList
local list2={}
local idxlist={}
if num>1 then
for i=1,num do
list2[i]=self.showList[num+1-i]
idxlist[i]=num+1-i
end
end
if#list2>0 then
self.showList=list2
self.shoulingIdx=idxlist[self.shoulingIdx]
end


local isflag=false
for k,v in ipairs(boss_config)do
if self.bossState[k]==rankstate.unopen then
if not isflag then
local mosterGroupid=v[1][1][1][1]



local slnamecfg=cfg_taigushilianconfig_get(_this.subid).slname
local slname=slnamecfg[mosterGroupid]or""
table.insert(self.showList,{v,slname,self.bossState[k]})
isflag=true
end
end
end


self.recvdata={}
for k,v in ipairs(self.showList)do
self.recvdata[k]=false
end
self:initShouLingList()


local reddot=activitiesHandle_taiguBoss:checkreddotBossAll(_this.actID,_this.subType,_this.subid)
_this.jlreddot:setActive(reddot)
UISubAct_tgslRankWin:onClickshowPanel(page)
UISubAct_tgslRankWin:refreshResidueTime()
end


function UISubAct_tgslRankWin:initShouLingList()

local dataNum=#_this.showList
if dataNum<=0 then
_this.taskScroller:setActive(false)
else
_this.taskScroller:setActive(true)
_this.taskScroller:setChildScrollViewCreateGrids(dataNum,1)
local grids=_this.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local Bossdata=_this.showList[i]
local bossState=Bossdata[3]

if bossState==rankstate.unopen then



item:SetChildText(shoulingindex.name,Bossdata[2])
item:SetChildCSImageSprite(shoulingindex.black,abname2,'button_zysltab_1')
item:SetChildActive(shoulingindex.reddot,false)
item:SetChildActive(shoulingindex.yjsimg,false)
item:SetChildActive(shoulingindex.ywcimg,false)
item:SetChildActive(shoulingindex.reddot,false)
item:SetChildActive(shoulingindex.numbg,false)


item:SetChildImageExGray(shoulingindex.black,true)
item:SetChildActive(shoulingindex.lock,true)
else
local bossid=Bossdata[1][7]
local flag,reddotlist=activitiesHandle_taiguBoss:checkreddotSingleBoss(_this.actID,_this.subType,_this.subid,bossid)


item:SetChildText(shoulingindex.name,Bossdata[2])
item:SetChildActive(shoulingindex.lock,false)
if _this.curPage==1 then

item:SetChildActive(shoulingindex.reddot,false)
item:SetChildActive(shoulingindex.ywcimg,false)
item:SetChildActive(shoulingindex.numbg,false)

item:SetChildActive(shoulingindex.yjsimg,Bossdata[3]==rankstate.finish)
if _this.shoulingIdx==i then
item:SetChildCSImageSprite(shoulingindex.black,abname2,'button_zysltab_2')
else
item:SetChildCSImageSprite(shoulingindex.black,abname2,'button_zysltab_1')
end
elseif _this.curPage==2 then

local ywc=0
local max=#reddotlist
if max>0 then
for k,v in ipairs(reddotlist)do
if v==1 then
ywc=ywc+1
end
end
end

item:SetChildActive(shoulingindex.yjsimg,false)
item:SetChildActive(shoulingindex.ywcimg,false)
item:SetChildActive(shoulingindex.reddot,false)
item:SetChildActive(shoulingindex.numbg,false)
if flag then
item:SetChildActive(shoulingindex.reddot,true)
item:SetChildActive(shoulingindex.ywcimg,false)
item:SetChildActive(shoulingindex.numbg,false)
else
if ywc>0 and ywc>=max then
item:SetChildActive(shoulingindex.ywcimg,true)
item:SetChildActive(shoulingindex.numbg,false)
else
item:SetChildActive(shoulingindex.ywcimg,false)
item:SetChildActive(shoulingindex.numbg,true)
item:SetChildText(shoulingindex.num,FMT.fmt("{0}/{1}",ywc,max))
end
end
if _this.shoulingIdx==i then
item:SetChildCSImageSprite(shoulingindex.black,abname2,'button_zysltab_2')
else
item:SetChildCSImageSprite(shoulingindex.black,abname2,'button_zysltab_1')
end
end
end
item:SetChildButtonClick(shoulingindex.btn,function(...)
if _this==nil then return end
_this:onShouLingClickItem(i,_this.curPage,bossState,Bossdata[1])
end)
end
end
end
end

function UISubAct_tgslRankWin:refreshShouLingList()
local grids=_this.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local Bossdata=_this.showList[i]
local bossState=Bossdata[3]
if bossState==rankstate.unopen then
item:SetChildActive(shoulingindex.reddot,false)
item:SetChildActive(shoulingindex.yjsimg,false)
item:SetChildActive(shoulingindex.ywcimg,false)
item:SetChildActive(shoulingindex.reddot,false)
item:SetChildActive(shoulingindex.numbg,false)
else
local bossid=Bossdata[1][7]
local flag,reddotlist=activitiesHandle_taiguBoss:checkreddotSingleBoss(_this.actID,_this.subType,_this.subid,bossid)

if _this.curPage==1 then
item:SetChildActive(shoulingindex.reddot,false)
item:SetChildActive(shoulingindex.ywcimg,false)
item:SetChildActive(shoulingindex.numbg,false)
item:SetChildActive(shoulingindex.yjsimg,Bossdata[3]==rankstate.finish)
if _this.shoulingIdx==i then
item:SetChildCSImageSprite(shoulingindex.black,abname2,'button_zysltab_2')
else
item:SetChildCSImageSprite(shoulingindex.black,abname2,'button_zysltab_1')
end

elseif _this.curPage==2 then
local ywc=0
local max=#reddotlist
if max>0 then
for k,v in ipairs(reddotlist)do
if v==1 then
ywc=ywc+1
end
end
end
item:SetChildActive(shoulingindex.yjsimg,false)
item:SetChildActive(shoulingindex.ywcimg,false)
item:SetChildActive(shoulingindex.numbg,false)
item:SetChildActive(shoulingindex.reddot,false)
if flag then
item:SetChildActive(shoulingindex.reddot,true)
item:SetChildActive(shoulingindex.ywcimg,false)
item:SetChildActive(shoulingindex.numbg,false)
else
item:SetChildActive(shoulingindex.reddot,false)
if ywc>0 and ywc>=max then
item:SetChildActive(shoulingindex.ywcimg,true)
item:SetChildActive(shoulingindex.numbg,false)
else
item:SetChildActive(shoulingindex.ywcimg,false)
item:SetChildActive(shoulingindex.numbg,true)
item:SetChildText(shoulingindex.num,FMT.fmt("{0}/{1}",ywc,max))
end
end
if _this.shoulingIdx==i then
item:SetChildCSImageSprite(shoulingindex.black,abname2,'button_zysltab_2')
else
item:SetChildCSImageSprite(shoulingindex.black,abname2,'button_zysltab_1')
end
end
end
end
end
end


function UISubAct_tgslRankWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=_this.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
if flag then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,flag and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UISubAct_tgslRankWin:refreshMenuItemReddot(item,idx)
if item==nil then
item=_this.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local cfg=pageConfig[idx]
local isReddot=cfg.checkReddot()
item:SetChildActive(3,isReddot)
end

function UISubAct_tgslRankWin:onMenuItemClick(page)
if page==_this.curPage then
return
end
local old=_this.curPage
_this.curPage=page
if old~=nil then
_this:refreshMenuPage(old,false)
end
_this:refreshMenuPage(page,true)
end

function UISubAct_tgslRankWin:refreshMenuPage(page,flag)
local cfg=pageConfig[page]
if flag then
cfg.open(self)

_this:refreshShouLingList()
else
cfg.close(self)
end
end


function UISubAct_tgslRankWin:getRankReward(typo,rank,look)
if self.rankRewardLookup==nil then
self.rankRewardLookup={}
end
if self.rankRewardLookup[typo]==nil then
self.rankRewardLookup[typo]={}
end
if self.rankRewardLookup[typo][rank]==nil then
for i,v in ipairs(look)do

if rank<=v[1]then
self.rankRewardLookup[typo][rank]=v[2]
return v[2]
end
end
end
return self.rankRewardLookup[typo][rank]
end


function UISubAct_tgslRankWin:getJiangReward(typo,rank,look)
if self.jiangRewardLookup==nil then
self.jiangRewardLookup={}
end
if self.jiangRewardLookup[typo]==nil then
self.jiangRewardLookup[typo]={}
end
if self.jiangRewardLookup[typo][rank]==nil then
for i,v in ipairs(look)do

if rank<=v[1]then
self.jiangRewardLookup[typo][rank]=v[2]
return v[2]
end
end
end
return self.rankRewardLookup[typo][rank]
end


function UISubAct_tgslRankWin:openMemberPage()
_this.istworeward=false
if not _this.recvdata[_this.shoulingIdx]then
local json_str=jsonHelper.encode({1,_this.shoulingIdx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
_this.recvdata[_this.shoulingIdx]=true
else
_this.bosstipss:setActive(false)
local AllRanklist=_this.mydata.AllRanklist
local boss_config_single=_this.showList[_this.shoulingIdx][1]
local bossid=boss_config_single[7]
_this.rankList=AllRanklist[bossid]or{}


local cfg_playerank=cfg_taigushilianconfig_get(_this.subid).playerank
local only_open_idx=cfg_playerank[1]or 50
local all_open_idx=only_open_idx
if cfg_playerank[2]then
all_open_idx=all_open_idx+#cfg_playerank[2]
end
local num=all_open_idx
local isShow=num>0
_this.rankScrollView:setActive(isShow)
_this.noItemTips:setActive(not isShow)
_this.rankItem:setActive(#_this.rankList>0)
_this.curRank=nil
_this.curScore=nil
if#_this.rankList>0 then
local myActorid=playerModel:getActorID()
for i,data in ipairs(_this.rankList)do
if data and data.actorid and mathHelper.compareInt64(myActorid,data.actorid)then
_this.curRank=i
_this.curScore=data.totaldamage
_this.serverid=data.server_id
break
end
end
local func=function(i)
if _this==nil then return end
local item=_this.rankGridPanel:getChildLayoutGroupGridItem(i-1)
local data=_this.rankList[i]
if data then
local zwflag=data.flag
if not zwflag then

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

local hasMember=data.actorname~=''
item:SetChildActive(13,hasMember)
local tips2_str=''
local headParams
if hasMember then

item:SetChildActive(7,false)

item:SetChildActive(11,true)
headParams={iconInfo=data.iconInfo,scale=0.8}
local str=FMT.fmt('{0}',data.actorname)
local zm_str=data.sectname



local serverType=activitiesModel:getServerType(_this.actID)
local _severid=data.serverid
if _severid and serverType==activitiesServerType.eKuafu then
local serverName=loginModel:getServerName(_severid)
zm_str=FMT.fmt('[{0}]',serverName)
end
item:SetChildText(1,str)
item:SetChildText(10,zm_str)

local num=0
if type(data.totaldamage)~="number"then
num=mathHelper.int64_to_number(data.totaldamage)
end
num=mathHelper.formatNumber(num)
item:SetChildText(3,tostring(num))

item:SetChildText(15,"")
else
tips2_str=''
end
item:SetChildText(14,tips2_str)

playerController:setHeadIcon(item,11,headParams)
item:SetChildButtonClick(16,function()
if data.actorid and not mathHelper.compareInt64(myActorid,data.actorid)then
self:onClickhead(data.actorid)
end
end)


local nextrank_under=0
if i>only_open_idx then
local idx=i-only_open_idx
if idx>0 and cfg_playerank[2]and cfg_playerank[2][idx]then
local arry=cfg_playerank[2][idx]
local nextrank_top=arry[1]
nextrank_under=arry[2]

item:SetChildText(0,FMT.fmt('{0}~{1}',nextrank_top,nextrank_under))

item:SetChildActive(13,false)
item:SetChildActive(17,true)

local num=nextrank_under-nextrank_top+1
local showNum=num>4 and 4 or num
item:SetChildLayoutGroupCreateItems(17,showNum)
local grids=item:GetChildLayoutGroupGridList(17)
for j=1,showNum do
local data=_this.rankList[nextrank_top+j-1]
if data then
local widget=grids[j-1]
if widget then
widget:SetChildActive(-1,true)
widget:SetChildButtonClick(2,function(...)
if data.actorid and not mathHelper.compareInt64(myActorid,data.actorid)then
self:onClickhead(data.actorid)
end
end)
playerController:setHeadIcon(widget,0,{scale=0.8,iconInfo=data.iconInfo})
end

end
end

end
end


local rewardidx=i
if nextrank_under>0 then
rewardidx=nextrank_under
end
local all_reward=boss_config_single[6]
local rewardList=_this:getRankReward(bossid,rewardidx,all_reward)
local c=0
if rewardList~=nil then
c=#rewardList
if c==2 and i==1 then
_this.istworeward=true
end
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
itemcount=mathHelper.formatNumber4(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local iseffecttrue=false
if rank<=3 then
iseffecttrue=true
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,colorEffect=iseffecttrue,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
if _this.istworeward then

end
end
else
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

item:SetChildActive(11,false)
item:SetChildText(1,"")
item:SetChildText(10,"")
item:SetChildText(3,"")
local zwidx=data.idx
if zwidx then
local _num=mathHelper.formatNumber(zwflag)
local strsp=FMT.fmt(ranksptxt[zwidx],_num)
item:SetChildText(15,strsp)
if data.flag and data.flag<=0 then
item:SetChildText(15,"虚位以待")
end
end


local all_reward=boss_config_single[6]
local rewardList=_this:getRankReward(bossid,i,all_reward)
local c=0
if rewardList~=nil then
c=#rewardList
if c==2 and i==1 then
_this.istworeward=true
end
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
itemcount=mathHelper.formatNumber4(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local iseffecttrue=false
if rank<=3 then
iseffecttrue=true
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,colorEffect=iseffecttrue,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
if _this.istworeward then

end
end
end
else

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

item:SetChildActive(11,false)
item:SetChildText(15,"虚位以待")
item:SetChildText(1,"")
item:SetChildText(10,"")
item:SetChildText(3,"")

local nextrank_under=0
if i>only_open_idx then
local idx=i-only_open_idx
if idx>0 and cfg_playerank[2]and cfg_playerank[2][idx]then
local arry=cfg_playerank[2][idx]
local nextrank_top=arry[1]
nextrank_under=arry[2]

item:SetChildText(0,FMT.fmt('{0}~{1}',nextrank_top,nextrank_under))
end
end


local rewardidx=i
if nextrank_under>0 then
rewardidx=nextrank_under
end
local all_reward=boss_config_single[6]
local rewardList=_this:getRankReward(bossid,rewardidx,all_reward)
local c=0
if rewardList~=nil then
c=#rewardList
if c==2 and i==1 then
_this.istworeward=true
end
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
itemcount=mathHelper.formatNumber4(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local iseffecttrue=false
if rank<=3 then
iseffecttrue=true
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,colorEffect=iseffecttrue,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
if _this.istworeward then

end
end
end
end
_this.rankGridPanel:setChildLayoutGroupCreateItems(num,func)
_this:refreshRankItem()
else
_this.noItemTips:setText('暂无排名信息')
end
end
end


function UISubAct_tgslRankWin:closeMemberPage()
self.rankScrollView:setActive(false)
self.rankItem:setActive(false)
end


function UISubAct_tgslRankWin:refreshRankItem()
local item=self.rankItem:getChildWidgetBase()
local rewardList
local name_str
local image
local headid=true
local boss_config_single=_this.showList[_this.shoulingIdx][1]
local bossid=boss_config_single[7]
local all_damage=_this.curScore or 0
local damagenum=0
if all_damage then
if all_damage and type(all_damage)~="number"then
all_damage=mathHelper.int64_to_number(all_damage)
end
end


if self.curRank then
local all_reward=boss_config_single[6]
rewardList=_this:getRankReward(bossid,self.curRank,all_reward)
end
name_str=playerModel:getActorName()


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
local zm_str=UISettingModel:getZMName()or""


local serverType=activitiesModel:getServerType(_this.actID)
local _severid=playerModel:getActorServerID()
if _severid and serverType==activitiesServerType.eKuafu then
local serverName=loginModel:getServerName(_severid)
zm_str=FMT.fmt('[{0}]',serverName)
end
item:SetChildText(1,str)
item:SetChildText(10,zm_str)


if all_damage and all_damage==0 then
item:SetChildText(3,"暂无")
else
local damage_num=mathHelper.formatNumber(all_damage)
item:SetChildText(3,tostring(damage_num))
end


local c=0
if rewardList~=nil then
c=#rewardList
end
local showReward=c>0
item:SetChildActive(4,showReward)

if showReward then
item:SetChildLayoutGroupCreateItems(4,c)
local grids2=item:GetChildLayoutGroupGridList(4)
for i=1,c do
local rewardItem=grids2[i-1]
local itemid=rewardList[i][1]
local itemnum=rewardList[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=mathHelper.formatNumber4(itemnum)
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
if _this.istworeward then

end
end


item:SetChildActive(13,false)
local Bossdata=_this.showList[_this.shoulingIdx]
local bossState=Bossdata[3]
if bossState==rankstate.finish then
if all_damage and all_damage==0 then

item:SetChildText(3,"")
item:SetChildActive(5,false)
item:SetChildActive(13,true)
end
end
end


function UISubAct_tgslRankWin:getRewardPageSortList()
local list={}
local boss_config_single=_this.showList[_this.shoulingIdx][1]
local bossid=boss_config_single[7]
local jifenReward={}
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local monlv=mydata.monlv
local monlv_cfg=boss_config_single[5]
if monlv_cfg then
for k,v in ipairs(monlv_cfg)do
if monlv<=v[1]then
jifenReward=v[2]
break
end
end
end
local severBosslist=_this.mydata.severBosslist
local recvaimid=0
if severBosslist and severBosslist[bossid]then
recvaimid=severBosslist[bossid].recvaimid or 0
end
local score=activitiesHandle_taiguBoss:getDamageRole(_this.actID,_this.subType,_this.subid,bossid)

for i,v in ipairs(jifenReward)do
local fix=score>=v[1]
local flag=recvaimid>=i
if fix and not flag then
self.thetgindx=i
end
local state=flag==true and 0 or 1
local weight=state*100000000+(100000000-v[1])
table.insert(list,{v,fix,flag,weight,bossid,v[1]})
end
table.sort(list,function(a,b)
return a[4]>b[4]
end)
return list
end


function UISubAct_tgslRankWin:openRewardPage()
local rankList=self:getRewardPageSortList()
local num=#rankList
local isShow=num>0
_this.rewardScrollView:setActive(isShow)
_this.noItemTips:setActive(not isShow)
local alldamage=0
local isshowchae=false
if isShow then
local boss_config_single=_this.showList[_this.shoulingIdx][1]
local bossid=boss_config_single[7]
alldamage=activitiesHandle_taiguBoss:getDamageRole(_this.actID,_this.subType,_this.subid,bossid)
if type(alldamage)~="number"then
alldamage=mathHelper.int64_to_number(alldamage)
end
local str_num=mathHelper.formatNumber(alldamage)
local str=FMT.fmt('我的最高伤害：{0}',str_num)
_this.myalldamage:setText(str)

local jdmax=1

local widget=_this.iconpanel:getChildWidgetBase()

local jianglilist=activitiesHandle_taiguBoss:getBossJieDuanDamegelist(_this.actID,_this.subType,_this.subid,bossid)
for k,v in ipairs(jianglilist)do
if v[3]then
local chenghaoTxt=FMT.fmt('image_shilianzhandou_dj{0}',v[3])
widget:SetChildCSImageSprite(_this.topimg[k],abname,chenghaoTxt)
end

local isflag=alldamage>=v[1]
widget:SetChildActive(_this.topimgpoint[k],isflag)
if isflag then
jdmax=k
end
end

local jdlist={0,0.35,0.668,1}
self.lines:setChildIconFillAmount(jdlist[jdmax])


self.bosstipss:setActive(false)
local allbossState=activitiesHandle_taiguBoss:checkbossOpen(_this.actID,_this.subType,_this.subid)
if jdlist[jdmax]and jdlist[jdmax]<1 then
local isJieShuan=allbossState[bossid]

if isJieShuan==rankstate.finish then
self.bosstipss:setActive(true)
else
self.bosstipss:setActive(false)
end
end

local isbosstipss=false
for i,j in ipairs(allbossState)do
if j==rankstate.finish then
isbosstipss=true
else
isbosstipss=false
break
end
end
if isbosstipss then
self.bosstipss:setActive(true)
end
end
if isShow then
local func=function(i)
if _this==nil then return end
local item=_this.rewardGridPanel:getChildLayoutGroupGridItem(i-1)
local data=rankList[i]
local cfg=data[1]
local fix=data[2]
local flag=data[3]
local bossid=data[5]

local chenghaoTxt=FMT.fmt('image_shilianzhandou_dj{0}',cfg[3])
item:SetChildCSImageSprite(5,abname,chenghaoTxt)

local shvalue=mathHelper.formatNumber(cfg[1])
item:SetChildText(0,FMT.fmt('累计伤害达{0}',shvalue))




if not isshowchae then
local chae=cfg[1]-alldamage
if chae<=0 then
item:SetChildText(7,"")
else
local chaenum=mathHelper.formatNumber(chae)
item:SetChildText(7,FMT.fmt('还差{0}',chaenum))
isshowchae=true
end
else
item:SetChildText(7,"")
end















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
itemcount=mathHelper.formatNumber4(itemnum)
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
_this:onRewardBtn(cfg,bossid)
end)

item:SetChildActive(3,flag)


item:SetChildActive(4,false)
item:SetChildActive(6,not fix and not flag)
item:SetChildButtonClick(6,function()
if _this==nil then return end

UIManager:showWindow('UISubAct_tgslEnterWin',{_this.actID,_this.subType,_this.subid,bossid})
self:closeSelf()
end)
end
self.rewardGridPanel:setChildLayoutGroupCreateItems(num,func)
else
self.noItemTips:setText('暂无伤害积分奖励')
end
end


function UISubAct_tgslRankWin:closeRewardPage()
self.rewardScrollView:setActive(false)
end


function UISubAct_tgslRankWin:onRewardBtn(cfg,bossid)

if cfg and _this.thetgindx>0 and bossid then
local idx=_this.thetgindx
local json_str=jsonHelper.encode({2,bossid,idx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end
end

function UISubAct_tgslRankWin:onClickItem(itemId,index,guid,attach)
if itemId>0 then
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end
end
function UISubAct_tgslRankWin:onCloseBtn()
self:closeSelf()
end

function UISubAct_tgslRankWin:onJianglibtn()
UISubAct_tgslRankWin:onClickshowPanel(2)
end
function UISubAct_tgslRankWin:onPaihangbangbtn()
UISubAct_tgslRankWin:onClickshowPanel(1)
end


function UISubAct_tgslRankWin:onClickshowPanel(index)
if _this.curPage==index then
return
end
if index==1 then
_this.timess:setActive(true)

else
_this.timess:setActive(false)

end
local old=_this.curPage
_this.curPage=index
if _this.curPage==1 then
_this.winlua:SetChildCSImageSprite(_this.phbimg:getID(),abname,'button_shilianboss_3')
_this.winlua:SetChildCSImageSprite(_this.jlimg:getID(),abname,'button_shilianboss_4')
else
_this.winlua:SetChildCSImageSprite(_this.phbimg:getID(),abname,'button_shilianboss_4')
_this.winlua:SetChildCSImageSprite(_this.jlimg:getID(),abname,'button_shilianboss_3')
end

if old~=nil then
_this:refreshMenuPage(old,false)
end
_this:refreshMenuPage(_this.curPage,true)
end


function UISubAct_tgslRankWin:onShouLingClickItem(shoulingidx,page,bossState,bossdata)
if shoulingidx and shoulingidx==_this.shoulingIdx then

return
end
if bossState==rankstate.unopen then


local boss_config_single=bossdata
local nowstamp=timeHelper.getServerShortTime()
local bossstart=boss_config_single[2]+_this.start_time
local bossend=boss_config_single[3]+_this.start_time
if nowstamp<bossstart then
local str=FMT.fmt("{0}后开启",UISubAct_tgslRankWin.format_time_stampbyboss((bossstart-nowstamp)))
UIManager.info(str)
end
return
end

local lastIdx=_this.shoulingIdx
_this.shoulingIdx=shoulingidx

if page==1 then
_this:openMemberPage()
_this.bosstipss:setActive(false)
elseif page==2 then
_this:openRewardPage()
end


local grids=_this.taskScroller:getChildScrollViewItemWidgets()

if lastIdx then
local item=grids[lastIdx-1]

item:SetChildCSImageSprite(shoulingindex.black,abname2,'button_zysltab_1')
end
local item=grids[shoulingidx-1]

item:SetChildCSImageSprite(shoulingindex.black,abname2,'button_zysltab_2')
UISubAct_tgslRankWin:refreshResidueTime()
end


function UISubAct_tgslRankWin:onPjbtn()
local boss_config_single=_this.showList[_this.shoulingIdx][1]
local bossid=boss_config_single[7]
UIManager:showWindow('UISubAct_tgslPinJitwoWin',{_this.actID,_this.subType,_this.subid,bossid})
end


function UISubAct_tgslRankWin:onClickhead(actorId)
otherPlayerController:openOtherPlayerInfoWin(actorId,nil,actorInterFromType.eCommon)
end


local _format=string.format
local _floor=math.floor
function UISubAct_tgslRankWin.format_time_stampbyboss(inteval)
local SS=inteval%60
local cc=_floor(inteval/60)
local mm=cc%60
cc=_floor(cc/60)
local HH=cc%24
cc=_floor(cc/24)
local DD=cc

if DD>0 then
return _format('%s天',DD)
else
if HH>0 then
return _format('%s小时',HH)
else
if mm>0 then
return _format('%s分',mm)
else
return _format('%s秒',SS)
end
end
end
end


function UISubAct_tgslRankWin:refreshResidueTime()
if _this.refreshTimeId then
_this:stopTimerByID(_this.refreshTimeId)
_this.refreshTimeId=nil
end
_this.refreshTimeFunc=function()
local boss_config_single=_this.showList[_this.shoulingIdx][1]
local nowstamp=timeHelper.getServerShortTime()
local bossstart=boss_config_single[2]+_this.start_time
local bossend=boss_config_single[3]+_this.start_time
if nowstamp>=bossend then
_this.bosstime:setText('已结算')

if _this.refreshTimeId then
_this:stopTimerByID(_this.refreshTimeId)
_this.refreshTimeId=nil
end
end
if nowstamp>=bossstart and nowstamp<bossend then
local str=FMT.fmt("{0}后结算",UISubAct_tgslRankWin.format_time_stampbyboss((bossend-nowstamp)))
_this.bosstime:setText(str)
end
end
_this.refreshTimeFunc()
_this.refreshTimeId=_this:setTimer(1,0,_this.refreshTimeFunc)
end


function UISubAct_tgslRankWin:refreshTips()

end




function UISubAct_tgslRankWin:recv_reward(actID,subType,subID)

if _this.actID==actID and _this.subType==subType and _this.subid==subID then
if _this.curPage==2 then
_this:openRewardPage()


local reddot=activitiesHandle_taiguBoss:checkreddotBossAll(_this.actID,_this.subType,_this.subid)
_this.jlreddot:setActive(reddot)
_this:refreshShouLingList()
end
end
end


function UISubAct_tgslRankWin:recv_paihangbang(actID,subType,subID)

if _this.actID==actID and _this.subType==subType and _this.subid==subID then
if _this.curPage==1 then
_this:openMemberPage()
end
end
end


