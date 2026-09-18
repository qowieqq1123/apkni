







def_class("UISubAct_fyslResultWin",UIWindowBase)









function UISubAct_fyslResultWin:bindComponents()

self.effect=UIObject.get(self,0)
self.FullScreenClose=UIButton.get(self,1)
self.liandanVal=UILinkImageText.get(self,2)
self.ScrollView1=UIObject.get(self,3)
self.Text=UILinkImageText.get(self,4)
self.ScrollView2=UIObject.get(self,5)
self.Content2=UIObject.get(self,6)
self.Content=UIObject.get(self,7)
self.bosstxt=UIText.get(self,8)
self.rangkIcon=UIImage.get(self,9)
self.rank2=UIText.get(self,10)
self.weitxt=UIText.get(self,11)
self.rankScrollView=UIObject.get(self,12)
self.rankGridPanel=UIObject.get(self,13)

self.FullScreenClose:setButtonClick(function()self:onFullScreenClose()end)



end


function UISubAct_fyslResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.FullScreenClose);self.FullScreenClose=nil;
_UIObject_release(self.liandanVal);self.liandanVal=nil;
_UIObject_release(self.ScrollView1);self.ScrollView1=nil;
_UIObject_release(self.Text);self.Text=nil;
_UIObject_release(self.ScrollView2);self.ScrollView2=nil;
_UIObject_release(self.Content2);self.Content2=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.bosstxt);self.bosstxt=nil;
_UIObject_release(self.rangkIcon);self.rangkIcon=nil;
_UIObject_release(self.rank2);self.rank2=nil;
_UIObject_release(self.weitxt);self.weitxt=nil;
_UIObject_release(self.rankScrollView);self.rankScrollView=nil;
_UIObject_release(self.rankGridPanel);self.rankGridPanel=nil;
end

















local _this
local ranksptxt=
{
[1]="伤害达{0}可进前一",
[2]="伤害达{0}可进前二",
[3]="伤害达{0}可进前三",
[4]="伤害达{0}可进前四",
}



function UISubAct_fyslResultWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_fyslResultWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_fyslResultWin:onShow(argtable,afterOnloaded)
if argtable then
self.actId=argtable[1]
self.subType=argtable[2]
self.subId=argtable[3]
self.bossid=argtable[4]or 1
self.mydata=activitiesModel:getSubActInfoData(self.actId,self.subType,self.subId)
local cfg=cfg_fuyaoshilianconfig_get(self.subId).boss
local mostergroupid=cfg[self.bossid][1][1][1]





local slnamecfg=cfg_fuyaoshilianconfig_get(self.subId).slname
local slname=slnamecfg[mostergroupid]or""
local str=FMT.fmt('<color=#fd8950>{0}</color>已结算，祖师的排名是',slname)
self.bosstxt:setText(str)
UISubAct_fyslResultWin:refreshdata()
end
end


function UISubAct_fyslResultWin:onHide()

end





function UISubAct_fyslResultWin:onFullScreenClose()
end

function UISubAct_fyslResultWin:onCloseWin()
self:closeSelf()
end



function UISubAct_fyslResultWin:refreshdata()
local AllRanklist=_this.mydata.AllRanklist

local bossid=_this.bossid
_this.rankList=AllRanklist[bossid]or{}
local boss_config_single=cfg_fuyaoshilianconfig_get(_this.subId).boss[_this.bossid]
local bossid=boss_config_single[7]
local num=#_this.rankList
local isShow=num>0
_this.rankScrollView:setActive(isShow)


_this.curRank=nil
_this.curScore=nil
if isShow then
local myActorid=playerModel:getActorID()
for i,data in ipairs(_this.rankList)do
if mathHelper.compareInt64(myActorid,data.actorid)then
_this.curRank=i
_this.curScore=data.totaldamage

break
end
end
if _this.curRank then

local rank=_this.curRank
local rankIcon
local rank_str=tostring(rank)
if rank<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
else
rankIcon=FMT.fmt('icon_phbmingci_4')
end
local showRankIcon=rankIcon~=nil
_this.rangkIcon:setActive(showRankIcon)
_this.weitxt:setActive(not showRankIcon)
if showRankIcon then
_this.winlua:SetChildCSImageSprite(_this.rangkIcon:getID(),globalABLookup.rankList,rankIcon)
_this.rank2:setText(rank_str)
else
_this.weitxt:setText(rank_str)
end
else
_this.rangkIcon:setActive(false)
_this.weitxt:setActive(true)
end

local func=function(i)
if _this==nil then return end
local item=_this.rankGridPanel:getChildLayoutGroupGridItem(i-1)
local data=_this.rankList[i]
local zwflag=data.flag
if not zwflag then

local rank=i
local rankIcon
local rank_str=tostring(rank)
if rank<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
else
rankIcon=FMT.fmt('icon_phbmingci_4')
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

headParams={iconInfo=data.iconInfo,scale=0.8}
local str=FMT.fmt('{0}',data.actorname)

item:SetChildText(1,str)
item:SetChildText(10,"")

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


local all_reward=boss_config_single[6]
local rewardList=_this:getRankReward(bossid,i,all_reward)
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
else
local rank=i
local rankIcon
local rank_str=tostring(rank)
if rank<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
else
rankIcon=FMT.fmt('icon_phbmingci_4')
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

item:SetChildText(1,"")
item:SetChildText(10,"")
item:SetChildText(3,"")
local zwidx=data.idx
if zwidx then
local _num=mathHelper.formatNumber(zwflag)
local strsp=FMT.fmt(ranksptxt[zwidx],_num)
item:SetChildText(15,strsp)
end
end
end
_this.rankGridPanel:setChildLayoutGroupCreateItems(num,func)

else

end
end


function UISubAct_fyslResultWin:getRankReward(typo,rank,look)
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

function UISubAct_fyslResultWin:onClickItem(itemId,index,guid,attach)
if itemId>0 then
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end
end
