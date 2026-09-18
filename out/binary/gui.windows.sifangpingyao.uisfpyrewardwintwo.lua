







def_class("UISFPYRewardWintwo",UIWindowBase)









function UISFPYRewardWintwo:bindComponents()

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
self.jlreddot=UIObject.get(self,18)
self.tgred=UIObject.get(self,19)
self.phmodel=UIObject.get(self,20)
self.cjmodel=UIObject.get(self,21)
self.tgmax=UIText.get(self,22)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.paihangbangbtn:setButtonClick(function()self:onPaihangbangbtn()end)

self.jianglibtn:setButtonClick(function()self:onJianglibtn()end)



end


function UISFPYRewardWintwo:unbindComponents()
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
_UIObject_release(self.jlreddot);self.jlreddot=nil;
_UIObject_release(self.tgred);self.tgred=nil;
_UIObject_release(self.phmodel);self.phmodel=nil;
_UIObject_release(self.cjmodel);self.cjmodel=nil;
_UIObject_release(self.tgmax);self.tgmax=nil;
end
















local pageConfig=
{














[1]={
name='成就',
checkReddot=function()
return false
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
local itemidx=
{
back=7,
name=2,
reddot=3,
icon=4,
select=5,
btn=6,
}
local ab_name="ui/windows/sifangpingyao/sifangpingyao_atlas_pak.ab"
local iconname=
{
[1]="button_sifangpingyao_05",
[2]="button_sifangpingyao_03",
[3]="button_sifangpingyao_04",
[4]="button_sifangpingyao_06",
[5]="button_sifangpingyao_07",
}


function UISFPYRewardWintwo:onLoaded(...)
_this=self
self:bindComponents()
self.topimg={0,1,2,3}
self.topimgpoint={4,5,6,7}
self.chenjilist={}
end


function UISFPYRewardWintwo:__delete()
self:unbindComponents()
_this=nil
end


function UISFPYRewardWintwo:onHide()

end




function UISFPYRewardWintwo:onShow(argtable,afterOnloaded)
local page=1
self.shoulingIdx=1
self.thetgindx=0
if argtable then
page=argtable[1]or 1
self.shoulingIdx=argtable[2]or 1
end


self.chenjilist={}
local demons_id=SiFangPingYaoModel:getMapIdex()

if demons_id and demons_id~=0 then
self.shoulingIdx=demons_id
end
self.ygcfg=cfg_foursideskilldemonsconfig()

self.showList=self.ygcfg
self:initShouLingList()

if afterOnloaded then
local func=function()
if _this==nil then return end
local isSelected=1==page
if isSelected then
self.winlua:SetChildUIModelShowSlotAttachment(self.phmodel:getID(),menu_slot_name,isSelected and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
end
local func2=function()
if _this==nil then return end
local isSelected=2==page
if isSelected then
self.winlua:SetChildUIModelShowSlotAttachment(self.cjmodel:getID(),menu_slot_name,isSelected and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
end
self.winlua:SetChildUIModelShowTarget(self.phmodel:getID(),2017,1,{},eAnimationID.common_window_enter,false,false,0,func)

end


self:onClickshowPanel(page)






self:refreshtgcjreddot()
end


function UISFPYRewardWintwo:initShouLingList()

local dataNum=#_this.showList

if dataNum<=0 then
_this.taskScroller:setActive(false)
else
_this.taskScroller:setActive(true)
_this.taskScroller:setChildScrollViewCreateGrids(dataNum,dataNum)
local grids=_this.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local ygdata=_this.showList[i]
local name=ygdata.name
item:SetChildText(itemidx.name,name)
item:SetChildCSImageSprite(itemidx.icon,ab_name,iconname[i])





item:SetChildActive(itemidx.select,self.shoulingIdx==i)







local reddot1=SiFangPingYaoController:tgreddot(i)
local reddot2=SiFangPingYaoController:cjreddot(i)
item:SetChildActive(itemidx.reddot,reddot1 or reddot2)
item:SetChildButtonClick(itemidx.btn,function(...)
if _this==nil then return end
_this:onShouLingClickItem(i,_this.curPage)
end)
end
end
end
end


function UISFPYRewardWintwo:refreshreddotall()

local dataNum=#_this.showList

if dataNum>0 then
local grids=_this.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then







local reddot2=SiFangPingYaoController:cjreddot(i)
item:SetChildActive(3,reddot2)
end
end
end





_this:refreshtgcjreddot()
end


function UISFPYRewardWintwo:refreshtgcjreddot()


local reddot2=SiFangPingYaoController:cjreddot(_this.shoulingIdx)
_this.tgred:setActive(reddot2)
end


function UISFPYRewardWintwo:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=_this.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
if flag then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,flag and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UISFPYRewardWintwo:refreshMenuItemReddot(item,idx)
if item==nil then
item=_this.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local cfg=pageConfig[idx]
local isReddot=cfg.checkReddot()
item:SetChildActive(3,isReddot)
end

function UISFPYRewardWintwo:onMenuItemClick(page)
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

function UISFPYRewardWintwo:refreshMenuPage(page,flag)
local cfg=pageConfig[page]
if flag then
cfg.open(self)


else
cfg.close(self)
end
end


function UISFPYRewardWintwo:getRankReward(typo,rank,look)
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


function UISFPYRewardWintwo:getJiangReward(typo,rank,look)
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


function UISFPYRewardWintwo:openMemberPage()
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





item:SetChildText(0,FMT.fmt('{0}',cfg[1]))

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
_this:onRewardBtn(_this.shoulingIdx,cfg)
end)

item:SetChildActive(3,flag)

item:SetChildActive(4,not fix and not flag)
end
self.rewardGridPanel:setChildLayoutGroupCreateItems(num,func)
else
self.noItemTips:setText('暂无积分奖励')
end

local all_yg_jd=SiFangPingYaoController:getzjdqallJindu(_this.shoulingIdx)
self.tgmax:setText(FMT.fmt("最高通关数：<color=#ca631d>{0}</color>",all_yg_jd))
end


function UISFPYRewardWintwo:closeMemberPage()

self.rewardScrollView:setActive(false)
self.rankItem:setActive(false)
end


function UISFPYRewardWintwo:getRewardPageSortList()
local list={}
local jifenReward=_this.showList[_this.shoulingIdx].demons_rewards


local recvaimid=SiFangPingYaoController:getzjNowxiabiao(_this.shoulingIdx)
local jindu=SiFangPingYaoController:getzjdangqianJindu(_this.shoulingIdx)


for i,v in ipairs(jifenReward)do
local fix=jindu>=v[1]
local flag=recvaimid>=i
if fix and not flag then
self.thetgindx=i
end
local state=flag==true and 0 or 1
local weight=state*100000000+(100000000-v[1])
table.insert(list,{v,fix,flag,weight,i,v[1]})
end

table.sort(list,function(a,b)
return a[4]>b[4]
end)
return list
end


function UISFPYRewardWintwo:getRewardPageSortCJList()
self.chenjilist={}
local list={}
local jifenReward=_this.showList[_this.shoulingIdx].achieve_list
local achieve_list=SiFangPingYaoModel:getachievelist()

for i,v in ipairs(jifenReward)do
local cjflag=0
for k,j in ipairs(achieve_list)do
if j.param_1==v then
cjflag=j.param_2
break
end
end
local fix=cjflag==1
local flag=cjflag==2
if fix and not flag then
self.chenjilist[#self.chenjilist+1]=v
end
local state1=fix==true and 1 or 0
local state=flag==true and 0 or 1
local weight=state*1000000+state1*10000+(10000-i)
table.insert(list,{v,fix,flag,weight,i})
end
table.sort(list,function(a,b)
return a[4]>b[4]
end)

return list
end


function UISFPYRewardWintwo:openRewardPage()
local rankList=self:getRewardPageSortCJList()
local num=#rankList
local isShow=num>0
self.rankScrollView:setActive(isShow)
self.noItemTips:setActive(not isShow)
if isShow then
local func=function(i)
if _this==nil then return end
local item=_this.rankGridPanel:getChildLayoutGroupGridItem(i-1)
local data=rankList[i]

local cjid=data[1]
local fix=data[2]
local flag=data[3]

local desc=cfg_foursideskilldemonsperiodachieveconfig_get(cjid).desc
item:SetChildText(0,FMT.fmt('{0}',desc))

local _reward=cfg_foursideskilldemonsperiodachieveconfig_get(cjid).rewards
local rewardList=_reward
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
_this:onRewardCJBtn(_this.shoulingIdx,cjid)
end)

item:SetChildActive(3,flag)

item:SetChildActive(4,not fix and not flag)
end
self.rankGridPanel:setChildLayoutGroupCreateItems(num,func)
else
self.noItemTips:setText('暂无积分奖励')
end
end


function UISFPYRewardWintwo:closeRewardPage()
self.rankScrollView:setActive(false)
end


function UISFPYRewardWintwo:onRewardBtn(ygid,cfg)

if cfg and cfg[3]and _this.thetgindx>0 then
local idx=_this.thetgindx
SiFangPingYaoController.send_34_58(ygid,idx)
end
end

function UISFPYRewardWintwo:onRewardCJBtn(ygid,cjid)

if _this.chenjilist and#_this.chenjilist>0 then
SiFangPingYaoController.send_34_68(#_this.chenjilist,_this.chenjilist)
end
end


function UISFPYRewardWintwo:onClickItem(itemId,index,guid,attach)
if itemId>0 then
tipsManager.showTips({itemid=itemId,itemguid=nil,showModel=true})
end
end
function UISFPYRewardWintwo:onCloseBtn()
self:closeSelf()
end

function UISFPYRewardWintwo:onJianglibtn()
UISFPYRewardWintwo:onClickshowPanel(2)
end
function UISFPYRewardWintwo:onPaihangbangbtn()
UISFPYRewardWintwo:onClickshowPanel(1)
end


function UISFPYRewardWintwo:onClickshowPanel(index)
if _this.curPage==index then
return
end
local old=_this.curPage
_this.curPage=index
if _this.curPage==1 then
_this.winlua:SetChildModelAnimationState(_this.phmodel:getID(),eAnimationID.common_window_dianji)
_this.winlua:SetChildUIModelShowSlotAttachment(_this.phmodel:getID(),menu_slot_name,true and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
_this.winlua:SetChildUIModelShowSlotAttachment(_this.cjmodel:getID(),menu_slot_name,false and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
else
_this.winlua:SetChildModelAnimationState(_this.cjmodel:getID(),eAnimationID.common_window_dianji)
_this.winlua:SetChildUIModelShowSlotAttachment(_this.cjmodel:getID(),menu_slot_name,true and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
_this.winlua:SetChildUIModelShowSlotAttachment(_this.phmodel:getID(),menu_slot_name,false and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end


if old~=nil then
_this:refreshMenuPage(old,false)
end
_this:refreshMenuPage(_this.curPage,true)
_this:refreshreddotall()
end


function UISFPYRewardWintwo:onShouLingClickItem(idx,page)
if idx and idx==_this.shoulingIdx then
return
end
local lastIdx=_this.shoulingIdx
_this.shoulingIdx=idx

if page==1 then
_this:openRewardPage()
elseif page==2 then
_this:openRewardPage()
end


local grids=_this.taskScroller:getChildScrollViewItemWidgets()
if lastIdx then
local lastitem=grids[lastIdx-1]
lastitem:SetChildActive(itemidx.select,false)

end
local item=grids[idx-1]
item:SetChildActive(itemidx.select,true)

_this:refreshtgcjreddot()


end




function UISFPYRewardWintwo:onClickhead(actorId)
otherPlayerController:openOtherPlayerInfoWin(actorId,nil,actorInterFromType.eCommon)
end



function UISFPYRewardWintwo:refreshTips()

end




function UISFPYRewardWintwo:recv_reward()

if _this.curPage==1 then
_this:openRewardPage()
_this:refreshreddotall()
end
end


function UISFPYRewardWintwo:recv_paihangbang(demons_id)

if _this.curPage==1 then


end
end


