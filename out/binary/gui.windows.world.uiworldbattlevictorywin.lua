







def_class("UIWorldBattleVictoryWin",UIWindowBase)









function UIWorldBattleVictoryWin:bindComponents()

self.Pool=UIGameobjectClone.new(self,0)
self.ResIcon=UIImage.get(self,1)
self.ResTx=UIText.get(self,2)
self.ResRoot=UIObject.get(self,3)
self.ScrollView=UIScrollView.get(self,4)
self.otherserver=UIText.get(self,5)
self.othername=UIText.get(self,6)
self.selfserver=UIText.get(self,7)
self.selfname=UIText.get(self,8)
self.shareBtn=UIButton.get(self,9)
self.headIcontwo=UIButton.get(self,10)
self.headIcon=UIButton.get(self,11)
self.Middle=UIObject.get(self,12)
self.headdatapanel=UIObject.get(self,13)
self.centerTipsTx=UIText.get(self,14)
self.TipsTx=UIText.get(self,15)
self.progressBar=UIProgress.get(self,16)
self.TextNum=UIText.get(self,17)
self.TitleIcon=UIImage.get(self,18)
self.TitleTx=UIText.get(self,19)
self.Content=UIObject.get(self,20)
self.tgslpanel=UIObject.get(self,21)
self.tsglimg1=UIObject.get(self,22)
self.tsglimg2=UIObject.get(self,23)
self.tgsltxt1=UIText.get(self,24)
self.tgsltxt2=UIText.get(self,25)
self.tgsltxtup=UIObject.get(self,26)
self.tgsltxt3=UIText.get(self,27)
self.tgsltxtup3=UIObject.get(self,28)
self.tgsltxt4=UIText.get(self,29)
self.tgsltxtup4=UIObject.get(self,30)
self.tgslicon=UIImage.get(self,32)
self.tgsltxt5=UIText.get(self,33)
self.tgsltxtup6=UIImage.get(self,34)
self.tgslbtn=UIButton.get(self,35)
self.tgslgobtn=UIButton.get(self,36)
self.tgsltxtup2=UIObject.get(self,37)
self.tgsltxt7=UIText.get(self,38)
self.tgsltxtup7=UIImage.get(self,39)
self.tgsltxt6=UIText.get(self,40)
self.tgsliconbg=UIImage.get(self,41)
self.tgslpmpanel=UIObject.get(self,42)
self.tgslpmtxt=UIText.get(self,43)
self.tgslpmtxtup=UIObject.get(self,44)
self.tgslpmicon=UIImage.get(self,45)
self.tgslpmicontxt=UIText.get(self,46)
self.selfpanel=UIObject.get(self,47)
self.otherpanel=UIObject.get(self,48)
self.selffrightvalue=UIText.get(self,49)
self.otherfrightvalue=UIText.get(self,50)
self.sftycenterTxt=UIText.get(self,51)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.headIcontwo:setButtonClick(function()self:onHeadIcontwo()end)

self.headIcon:setButtonClick(function()self:onHeadIcon()end)

self.tgslbtn:setButtonClick(function()self:onTgslbtn()end)

self.tgslgobtn:setButtonClick(function()self:onTgslgobtn()end)



end


function UIWorldBattleVictoryWin:unbindComponents()
local _UIObject_release=UIObject.release
self.Pool:deleteSelf();self.Pool=nil;
_UIObject_release(self.ResIcon);self.ResIcon=nil;
_UIObject_release(self.ResTx);self.ResTx=nil;
_UIObject_release(self.ResRoot);self.ResRoot=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.otherserver);self.otherserver=nil;
_UIObject_release(self.othername);self.othername=nil;
_UIObject_release(self.selfserver);self.selfserver=nil;
_UIObject_release(self.selfname);self.selfname=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.headIcontwo);self.headIcontwo=nil;
_UIObject_release(self.headIcon);self.headIcon=nil;
_UIObject_release(self.Middle);self.Middle=nil;
_UIObject_release(self.headdatapanel);self.headdatapanel=nil;
_UIObject_release(self.centerTipsTx);self.centerTipsTx=nil;
_UIObject_release(self.TipsTx);self.TipsTx=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.TextNum);self.TextNum=nil;
_UIObject_release(self.TitleIcon);self.TitleIcon=nil;
_UIObject_release(self.TitleTx);self.TitleTx=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.tgslpanel);self.tgslpanel=nil;
_UIObject_release(self.tsglimg1);self.tsglimg1=nil;
_UIObject_release(self.tsglimg2);self.tsglimg2=nil;
_UIObject_release(self.tgsltxt1);self.tgsltxt1=nil;
_UIObject_release(self.tgsltxt2);self.tgsltxt2=nil;
_UIObject_release(self.tgsltxtup);self.tgsltxtup=nil;
_UIObject_release(self.tgsltxt3);self.tgsltxt3=nil;
_UIObject_release(self.tgsltxtup3);self.tgsltxtup3=nil;
_UIObject_release(self.tgsltxt4);self.tgsltxt4=nil;
_UIObject_release(self.tgsltxtup4);self.tgsltxtup4=nil;
_UIObject_release(self.tgslicon);self.tgslicon=nil;
_UIObject_release(self.tgsltxt5);self.tgsltxt5=nil;
_UIObject_release(self.tgsltxtup6);self.tgsltxtup6=nil;
_UIObject_release(self.tgslbtn);self.tgslbtn=nil;
_UIObject_release(self.tgslgobtn);self.tgslgobtn=nil;
_UIObject_release(self.tgsltxtup2);self.tgsltxtup2=nil;
_UIObject_release(self.tgsltxt7);self.tgsltxt7=nil;
_UIObject_release(self.tgsltxtup7);self.tgsltxtup7=nil;
_UIObject_release(self.tgsltxt6);self.tgsltxt6=nil;
_UIObject_release(self.tgsliconbg);self.tgsliconbg=nil;
_UIObject_release(self.tgslpmpanel);self.tgslpmpanel=nil;
_UIObject_release(self.tgslpmtxt);self.tgslpmtxt=nil;
_UIObject_release(self.tgslpmtxtup);self.tgslpmtxtup=nil;
_UIObject_release(self.tgslpmicon);self.tgslpmicon=nil;
_UIObject_release(self.tgslpmicontxt);self.tgslpmicontxt=nil;
_UIObject_release(self.selfpanel);self.selfpanel=nil;
_UIObject_release(self.otherpanel);self.otherpanel=nil;
_UIObject_release(self.selffrightvalue);self.selffrightvalue=nil;
_UIObject_release(self.otherfrightvalue);self.otherfrightvalue=nil;
_UIObject_release(self.sftycenterTxt);self.sftycenterTxt=nil;
end
















local _divTime=0.1

local this


function UIWorldBattleVictoryWin:onLoaded(...)
this=self
self:bindComponents()
self.ScrollView:setClickAction(itemsComponentHelper.onItemClick)
end


function UIWorldBattleVictoryWin:__delete()
self:unbindComponents()
end





























function UIWorldBattleVictoryWin:onShow(argtable,afterOnloaded)
self.argtable=argtable or{}
self.battleId=self.argtable.battleId

self.tgslpanel:setActive(false)
self:onshowtaigushilian()
local title=self.argtable.title
if title then
self.TitleTx:setActive(title.text~=nil)
if title.text then self.TitleTx:setText(title.text)end
self.TitleIcon:setActive(title.icon~=nil)
if title.icon then self.TitleIcon:setSprite(title.icon.abName,title.icon.assetName)end
self.TextNum:setActive(title.num~=nil)
if title.num then self.TextNum:setText(title.num)end
else
self.TitleTx:setActive(true)
self.TitleTx:setText("<color=#7D3B17>获得物品</color>")
end
if self.argtable and self.argtable.tgsldata then
self.TitleTx:setText("")
end

local tips=self.argtable.tips
self.TipsTx:setText(tips or"")

local center_tips=self.argtable.center_tips
self.centerTipsTx:setText(center_tips or"")
if center_tips then
self.Middle:setChildAnchoredPos(0,-63)
end
local progressData=self.argtable.progress
self.progressBar:setActive(progressData~=nil)
if progressData then
self.progressBar:setProgressValue(math.floor(progressData[1]/progressData[2]*10000),10000)
if progressData[3]then
self:delayDo(2,function()
self.progressBar:setProgress(math.floor(progressData[3]/progressData[2]*10000),10000)
end)
end
end

local money=self.argtable.money
self.ResRoot:setActive(money~=nil)
if money then
self.ResIcon:setActive(money.icon~=nil)
if money.icon then self.ResIcon:setSprite(money.icon.abName,money.icon.assetName)end
self.ResTx:setActive(money.text~=nil)
if money.text then self.ResTx:setText(money.text)end
end

local items=self.argtable.items
if items and#items>0 then











if items[1].sortWeight then
table.sort(items,function(a,b)
return a.sortWeight>b.sortWeight
end)
else
local list=table.deepCopy(items)
for i,v in pairs(list)do
local itemid=v.itemid
if not itemid then
itemid=v[1]
v.itemid=v[1]
v.num=v[2]
end

local itemguid=v.itemguid
if itemid==nil and itemguid then
itemid=itemsModel.getItem(itemguid).itemid
v.itemid=itemid
end
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local rareLv=itemsConfig.getRareLv(itemid)
local sortWeight=rareLv*10000
sortWeight=sortWeight+color*1000
if itemsConfig.isEquip(itemid)then
sortWeight=sortWeight+100
end
v.sortWeight=sortWeight
end

table.sort(list,function(a,b)
return a.sortWeight>b.sortWeight
end)
items=list
end

local cnt=#items
self.winlua:SetChildSizeDelta(self.Content:getID(),cnt*90+8,100)
if cnt<=7 then
self.Content:setAnchors(0.5,1,0.5,1)
end
local config={}

for i,v in ipairs(items)do
v.conf={showname=false}
local singleInfo={}
singleInfo.name='UIShowPrizeChildItem'
singleInfo.parentIdx=self.Content:getID()
singleInfo.order=i
singleInfo.delay=0.8+_divTime*(i-1)
singleInfo.args=v
config[#config+1]=singleInfo

end
self.Pool:createObjectList(config)
end


local headdata=self.argtable.headdata_param
this.headdata_param=self.argtable.headdata_param
if headdata and#headdata>0 then

self.headdatapanel:setActive(true)
self.TitleTx:setActive(false)
local headParams_self
headParams_self={iconInfo=headdata[3],scale=0.8}
playerController:setHeadIcon(self.winlua,self.headIcon:getID(),headParams_self)
self.selfname:setText(headdata[8])
local serverName=loginModel:getServerName(headdata[2])
local str=FMT.fmt('[{0}]',serverName)
self.selfserver:setText(str)

local headParams
headParams={iconInfo=headdata[6],scale=0.8}
playerController:setHeadIcon(self.winlua,self.headIcontwo:getID(),headParams)
self.othername:setText(headdata[7]or'')
local otherserverName=loginModel:getServerName(headdata[5])
local otherstr=FMT.fmt('[{0}]',otherserverName)
self.otherserver:setText(otherstr)
self.shareBtn:setActive(headdata[9])


local selfFright=headdata[10]
local otherFright=headdata[11]
if selfFright then
local value=mathHelper.int64_to_number(selfFright)
self.selfpanel:setActive(true)
self.selffrightvalue:setText(mathHelper.formatNumber(value))
else
self.selfpanel:setActive(false)
end
if otherFright then
local value=mathHelper.int64_to_number(otherFright)
self.otherpanel:setActive(true)
self.otherfrightvalue:setText(mathHelper.formatNumber(value))
else
self.otherpanel:setActive(false)
end
end


this.sfpyWin_tips=self.argtable.sfpyWin_tips
if this.sfpyWin_tips then
self.sftycenterTxt:setActive(true)
self.sftycenterTxt:setText(this.sfpyWin_tips)
self.TitleTx:setActive(false)
end

end


function UIWorldBattleVictoryWin:onHide()

end




function UIWorldBattleVictoryWin:onHeadIcon()

end
function UIWorldBattleVictoryWin:onHeadIcontwo()

end

function UIWorldBattleVictoryWin:onShareBtn()
UIManager:showWindow('UIShareQieCuoInfoWin',{guid=self.disciple_guid,headdata=this.headdata_param,result=1,zhanbao=nil})
end


function UIWorldBattleVictoryWin:onshowtaigushilian()
if self.argtable and self.argtable.tgsldata then
self.tgslpanel:setActive(true)
local abname='ui/windows/activities/sub_taigushilian/taigushilian_atlas_pak.ab'
local tgsldata=self.argtable.tgsldata[1]

if tgsldata then
self.TitleTx:setText("")
self.tsglimg1:setActive(false)
self.tsglimg2:setActive(false)
local result=tgsldata[10]
self.tgslactid=tgsldata[1]
self.tgslsubType=tgsldata[2]
self.tgslsubid=tgsldata[3]
self.tgslbossid=tgsldata[4]
this.winlua:SetChildCSImageSprite(this.tgsliconbg:getID(),abname,"image_shilianboss_19")
if result==1 then

local items=tgsldata[9]
if items then
local cnt=#items
self.winlua:SetChildSizeDelta(self.Content:getID(),cnt*90+8,100)
if cnt<=7 then
self.Content:setAnchors(0.5,1,0.5,1)
end
local config={}

for i,v in ipairs(items)do
v.itemid=v[1]
v.num=v[2]
v.conf={showname=false}
local singleInfo={}
singleInfo.name='UIShowPrizeChildItem'
singleInfo.parentIdx=self.Content:getID()
singleInfo.order=i
singleInfo.delay=1+_divTime*(i-1)
singleInfo.args=v
config[#config+1]=singleInfo

end
self.Pool:createObjectList(config)
end
self.tgsltxt1:setActive(true)
local tips='<color=#7D3B17>获得物品</color>'
self.TitleTx:setText("")
self.tgsltxt1:setText(tips)
local danage=FMT.fmt('挑战伤害：{0}',mathHelper.formatNumber(math.abs(tgsldata[7])))
self.tgsltxt4:setActive(true)
self.tgsltxtup4:setActive(true)
self.tgsltxt4:setText(danage)
else
local guankaIdx=tgsldata[5]

if guankaIdx<4 then
self.tgsltxt1:setActive(true)
local tips='<color=#7D3B17>挑战伤害</color>'
self.TitleTx:setText("")
self.tgsltxt1:setText(tips)
local historydamage_num=mathHelper.formatNumber(math.abs(tgsldata[8]))
local danage_num=mathHelper.formatNumber(math.abs(tgsldata[7]))
local historydamage=FMT.fmt('历史最高伤害：{0}',historydamage_num)
local danage=FMT.fmt('本次挑战伤害：{0}',danage_num)
if math.abs(tgsldata[7])>math.abs(tgsldata[8])then
self.tgsltxt2:setActive(true)
local str=FMT.fmt('<color=#161412>{0}</color>',danage)
self.tgsltxt2:setText(str)
self.tgsltxtup:setActive(true)
else
self.tgsltxt2:setActive(true)
local str=FMT.fmt('<color=#161412>{0}</color>',danage)
self.tgsltxt2:setText(str)
self.tgsltxtup2:setActive(true)

self.tgsltxt3:setActive(true)
self.tgsltxt3:setText(historydamage)
end
if math.abs(tgsldata[7])==0 then
self.tgsltxtup2:setActive(false)
end
if math.abs(tgsldata[8])==0 then
self.tgsltxt3:setActive(false)
this.winlua:SetChildLocalPosY(self.tgsltxt2:getID(),-50)
end

local tips2='<color=#7D3B17>很遗憾，祖师未能击败首领</color>'
self.tgsltxt4:setActive(true)
self.tgsltxt4:setText(tips2)
else

self.tgsltxt1:setActive(true)
local tips='<color=#7D3B17>挑战伤害</color>'
self.TitleTx:setText("")
self.tgsltxt1:setText(tips)
local historydamage_num=mathHelper.formatNumber(math.abs(tgsldata[8]))
local danage_num=mathHelper.formatNumber(math.abs(tgsldata[7]))
local historydamage=FMT.fmt('历史最高伤害：{0}',historydamage_num)
local danage=FMT.fmt('本次挑战伤害：{0}',danage_num)
if math.abs(tgsldata[7])>math.abs(tgsldata[8])then
self.tgsltxt2:setActive(true)
local str=FMT.fmt('<color=#161412>{0}</color>',danage)
self.tgsltxt2:setText(str)
self.tgsltxtup:setActive(true)

self.tgsltxt3:setActive(true)
self.tgsltxt3:setText(historydamage)
else
self.tgsltxt2:setActive(true)
local str=FMT.fmt('<color=#161412>{0}</color>',danage)
self.tgsltxt2:setText(str)
self.tgsltxtup2:setActive(true)

self.tgsltxt3:setActive(true)
self.tgsltxt3:setText(historydamage)
end
if math.abs(tgsldata[7])==0 then
local str=FMT.fmt('<color=#161412>{0}</color>',danage)
self.tgsltxt2:setText(str)
self.tgsltxtup:setActive(false)
end
if math.abs(tgsldata[8])==0 then
self.tgsltxt3:setActive(false)
this.winlua:SetChildLocalPosY(self.tgsltxt2:getID(),-50)
end

local isfysl=tgsldata[11]

local mydata=activitiesModel:getSubActInfoData(tgsldata[1],tgsldata[2],tgsldata[3])
local info=activitiesModel:getSubActInfo(tgsldata[1],tgsldata[2],tgsldata[3])
local start_time=info.start_time
local rankList=mydata.Ranklist
local myrank
if not isfysl then
for k,v in ipairs(rankList)do
if v and v.actorid and playerModel:checkActorId(v.actorid)then
myrank=k
break
end
end
if myrank and math.abs(tgsldata[7])>0 then
local bossidrank=userActorSetting.get(FMT.fmt('actid{0}_subid{1}_bossid{2}_time{3}_tgslrank',tgsldata[1],tgsldata[3],tgsldata[4],start_time),200)
if bossidrank~=myrank and myrank<bossidrank then
userActorSetting.set(FMT.fmt('actid{0}_subid{1}_bossid{2}_time{3}_tgslrank',tgsldata[1],tgsldata[3],tgsldata[4],start_time),myrank)
self.tgsltxt2:setActive(false)
local rank=myrank
local rankIcon
local rank_str=tostring(rank)
if rank<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
else
rankIcon=FMT.fmt('icon_phbmingci_4')
end
local showRankIcon=rankIcon~=nil
if showRankIcon then
self.winlua:SetChildCSImageSprite(self.tgslpmicon:getID(),globalABLookup.rankList,rankIcon)
self.tgslpmicontxt:setText(rank_str)
end

self.tgslpmpanel:setActive(true)
self.tgslpmtxt:setActive(true)
local str=FMT.fmt('<color=#161412>{0}</color>',danage)
self.tgslpmtxt:setText(str)
end
end
end


local bossid=tgsldata[4]
local severBosslist=mydata.severBosslist
local recvaimid=0
if severBosslist and severBosslist[bossid]then
recvaimid=severBosslist[bossid].recvaimid or 0
end
local idx
local damagelist
local normalidx,iconidx
local initimg
local initiconidx

if not isfysl then
idx=activitiesHandle_taiguBoss:getBossJieDuanDamegeIdx(tgsldata[1],tgsldata[2],tgsldata[3],bossid)
damagelist=activitiesHandle_taiguBoss:getBossJieDuanDamegelist(tgsldata[1],tgsldata[2],tgsldata[3],bossid)
normalidx,iconidx=activitiesHandle_taiguBoss:getBossNormalIdx(tgsldata[1],tgsldata[2],tgsldata[3],bossid)
initimg=cfg_taigushilianconfig_get(self.tgslsubid).initImg
initiconidx=initimg[bossid]
else
idx=activitiesHandle_fuyaoBoss:getBossJieDuanDamegeIdx(tgsldata[1],tgsldata[2],tgsldata[3],bossid)
damagelist=activitiesHandle_fuyaoBoss:getBossJieDuanDamegelist(tgsldata[1],tgsldata[2],tgsldata[3],bossid)
normalidx,iconidx=activitiesHandle_fuyaoBoss:getBossNormalIdx(tgsldata[1],tgsldata[2],tgsldata[3],bossid)
initimg=cfg_fuyaoshilianconfig_get(self.tgslsubid).initImg
initiconidx=initimg[bossid]
end

if iconidx==0 then
if initiconidx and math.abs(tgsldata[7])>0 then
this.tgsliconbg:setActive(true)
local iconName2=FMT.fmt('image_shilianzhandou_dj{0}',initiconidx)
this.winlua:SetChildCSImageSprite(this.tgslicon:getID(),abname,iconName2)
else
this.tgsliconbg:setActive(false)
end
else
this.tgsliconbg:setActive(true)
local iconName=FMT.fmt('image_shilianzhandou_dj{0}',iconidx)
this.winlua:SetChildCSImageSprite(this.tgslicon:getID(),abname,iconName)
end
local maxidx=#damagelist
if idx==maxidx and idx==recvaimid then

this.tgsltxt5:setActive(false)
end
if idx<maxidx and idx==recvaimid then

local nextdamage=damagelist[idx+1][1]
local chae=nextdamage-math.abs(tgsldata[7])
local numchae=mathHelper.formatNumber(chae)
local str=FMT.fmt('伤害再增加{0}可领取',numchae)
this.tgsltxt5:setActive(true)
this.tgsltxt5:setText(str)
this.tgsltxt6:setActive(true)
local iconName2=FMT.fmt('image_shilianzhandou_dj{0}',damagelist[idx+1][3])
this.winlua:SetChildCSImageSprite(this.tgsltxtup6:getID(),abname,iconName2)
this.tgslbtn:setActive(true)
end
if idx<maxidx and idx>recvaimid then

this.tgsltxt7:setActive(true)
this.tgslgobtn:setActive(true)
end
end
end
end
end
end


function UIWorldBattleVictoryWin:onTgslbtn()
if self.argtable and self.argtable.tgsldata then
local subType=self.tgslsubType
local subId=self.tgslsubid
local bossid=self.tgslbossid
local sub_actList=activitiesModel:getActSubList_subType_subid_doing(subType,subId)
if#sub_actList>0 then
local battle=fightModel:getBattle(self.battleId)
if battle then
battle.jump=true
battle:close(false)
end

jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=subType,subid=subId,extraParams={isopenjianli=true,jumpbossid=bossid or 1,}}},function()
jumpManager:clearJump()
UIManager:invokeUIMethod('UIFightPrepareWin','onCancelFunc')
fightController:closeSelectStage()
end)
else
UIManager.error("活动已结束")
end
end
end


function UIWorldBattleVictoryWin:onTgslgobtn()
if self.argtable and self.argtable.tgsldata then
local subType=self.tgslsubType
local subId=self.tgslsubid
local bossid=self.tgslbossid
local sub_actList=activitiesModel:getActSubList_subType_subid_doing(subType,subId)
if#sub_actList>0 then
local battle=fightModel:getBattle(self.battleId)

if battle then
battle.jump=true
battle:close(false)
end

jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=subType,subid=subId,extraParams={isopenjianli=true,jumpbossid=bossid or 1,}}},function()
jumpManager:clearJump()
UIManager:invokeUIMethod('UIFightPrepareWin','onCancelFunc')
fightController:closeSelectStage()
end)
else
UIManager.error("活动已结束")
end
end
end
