







def_class("UIXM_ZZSH_monsterAllMyTeamWin",UIWindowBase)









function UIXM_ZZSH_monsterAllMyTeamWin:bindComponents()

self.cliskMask=UIButton.get(self,0)
self.itemScrollView=UIObject.get(self,1)
self.noSign=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.gotoBtn=UIButton.get(self,4)
self.itemPanel=UIObject.get(self,5)
self.infoPaixu=UIButton.get(self,6)
self.fightPaixu=UIButton.get(self,7)
self.ybdsetBtn=UIButton.get(self,8)

self.cliskMask:setButtonClick(function()self:onCliskMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.infoPaixu:setButtonClick(function()self:onInfoPaixu()end)

self.fightPaixu:setButtonClick(function()self:onFightPaixu()end)

self.ybdsetBtn:setButtonClick(function()self:onYbdsetBtn()end)



end


function UIXM_ZZSH_monsterAllMyTeamWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cliskMask);self.cliskMask=nil;
_UIObject_release(self.itemScrollView);self.itemScrollView=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.infoPaixu);self.infoPaixu=nil;
_UIObject_release(self.fightPaixu);self.fightPaixu=nil;
_UIObject_release(self.ybdsetBtn);self.ybdsetBtn=nil;
end
















local _this


function UIXM_ZZSH_monsterAllMyTeamWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_ZZSH_monsterAllMyTeamWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_ZZSH_monsterAllMyTeamWin:onHide()

end




function UIXM_ZZSH_monsterAllMyTeamWin:onShow(argtable,afterOnloaded)
self:morenPaiXu()

if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshAllItem()
end)
end
end

function UIXM_ZZSH_monsterAllMyTeamWin:fingTeamIndex(guid)
for i,team in ipairs(self.teamsList)do
if team.guid==guid then
return i
end
end
return nil
end

function UIXM_ZZSH_monsterAllMyTeamWin:morenPaiXu()
self.teamsList=zhengzhanshanhaiModel:getPvEJiJieDatasList()
local num=#self.teamsList
if num>1 then
table.sort(self.teamsList,function(a,b)

if not zhengzhanshanhaiModel:checkInMyWaiPai(a.guid)and zhengzhanshanhaiModel:checkInMyWaiPai(b.guid)then
return false
elseif zhengzhanshanhaiModel:checkInMyWaiPai(a.guid)and not zhengzhanshanhaiModel:checkInMyWaiPai(b.guid)then
return true
end
local qbData1=zhengzhanshanhaiModel:getQingBaoData(a.guid)
local cfg1=qbData1.cfg
local qbData2=zhengzhanshanhaiModel:getQingBaoData(b.guid)
local cfg2=qbData2.cfg
return cfg1.stage>cfg2.stage
end)
end
self:refreshInfo()
self.info_paixu=1
end

function UIXM_ZZSH_monsterAllMyTeamWin:refreshInfo()
local num=#self.teamsList

local isshow=num>0
self.itemScrollView:setActive(isshow)
self.noSign:setActive(not isshow)
if isshow then
self.itemPanel:setChildLayoutGroupCreateItems(num,function(idx)
if _this==nil then return end
local item=self.itemPanel:getChildLayoutGroupGridItem(idx-1)
local team=self.teamsList[idx]
local qbData=zhengzhanshanhaiModel:getQingBaoData(team.guid)

local cfg=zhengzhanshanhaiModel:getQingBaoCfg(zhengzhanshanhaiModel.qbType.eMonster,qbData.ysid)

local bgIcon=FMT.fmt('image_gwtouxiangpjk_{0}',cfg.stage)
item:SetChildCSImageSprite(1,globalABLookup.global,bgIcon)

local groupid=cfg.monster[1]
comHelper.setChildModelRawImage_monsterGroup(item,groupid,2,0,eHeadCenterType.eHead)

local stageBGIcon=FMT.fmt('image_gwtouxiangdjk_{0}',cfg.stage)
item:SetChildCSImageSprite(3,globalABLookup.global,stageBGIcon)
item:SetChildText(4,tostring(cfg.stage))

local jjlv=zhengzhanshanhaiModel:getMonsterLv(cfg)



local nameStr=zhengzhanshanhaiModel:getQingBaoName(zhengzhanshanhaiModel.qbType.eMonster,cfg)
item:SetChildText(5,nameStr)

local xmData=qbData:getXM()
local hasXM=xmData~=nil
item:SetChildActive(7,hasXM)
local xmName_str
if hasXM then
xmName_str=xmData.guildname
local abname=globalABLookup.xianmengicons
local image=xianmengModel.splitGuildIcon(xmData.guildicon)

item:SetChildCSImageSprite(8,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

item:SetChildCSImageSprite(7,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

item:SetChildCSImageSprite(9,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
else
xmName_str='无'
end
item:SetChildText(10,xmName_str)

local box_icon=zhengzhanshanhaiController:getZZSHCfg_box(cfg.stage,'icon')
item:SetChildCSImageIcon(11,box_icon,true)
item:SetChildButtonClick(11,function()
if _this==nil then return end
_this:onItemBoxClick(idx)
end)

item:SetChildText(12,mathHelper.formatNumber5(team.fight_num,2))

item:SetChildButtonClick(15,function()
if _this==nil then return end
_this:onItemJoinClick(idx)
end)

item:SetChildIconFillAmount(18,tonumber(tostring(team.percent))/10000)
local rate_str=string.format("%d%%",tonumber(tostring(team.percent))/100)
item:SetChildText(19,rate_str)

item:SetChildButtonClick(20,function()
if _this==nil then return end
zhengzhanshanhaiModel:checkQingBaoDetail(team.guid,nil)
UIManager:invokeUIMethod('UIXM_ZZSH_noteWin','onClickClose')
end)
local myActorid=playerModel:getActorID()
item:SetChildActive(21,xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptZZSHSign))

item:SetChildButtonClick(21,function()
if _this==nil then return end
local guid=team.guid
local colorNameStr=FMT.fmt("<color={0}>【{1}阶{2}】</color>",FONT_COLOR_VAL[cfg.stage],cfg.stage,nameStr)
local content=FMT.fmt('是否解散参与{0}集结的队伍？',colorNameStr)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=function()
if _this==nil then return end
zhengzhanshanhaiController:reqMonsterJiJieDel(guid)
end,
showclosebtn=true,
}
_this.comfirmDialog=UIDialogManager.newDialog(showdata)
_this.comfirmDialog:show()
end)
end)
end
end

function UIXM_ZZSH_monsterAllMyTeamWin:refreshItem(item,idx)
if item==nil then
item=self.itemPanel:getChildLayoutGroupGridItem(idx-1)
end
if item==nil then return nil end
local team=self.teamsList[idx]
local teamData=zhengzhanshanhaiModel:getMyPvETeam(team.guid,zhengzhanshanhaiModel.qbType.eMonster)
item:SetChildActive(-1,teamData~=nil)
if teamData==nil then return false end


local state,time=zhengzhanshanhaiModel:getPvETeamState(zhengzhanshanhaiModel.qbType.eMonster,teamData.sec,true)
local maxNum,fixNum=zhengzhanshanhaiModel:getMaxMonsterTeamNum()
local cur=team.massnum
local max=team.setoutnum>0 and team.setoutnum or maxNum
local num_str=FMT.fmt('({0}/{1})',cur,max)
local state_str=FMT.fmt('{0} {1}',state,num_str)
item:SetChildText(13,state_str)

local time_str
if time>=0 then
time_str=timeHelper.format_time_stamp3(time)
else
time_str='--'
end
item:SetChildText(14,time_str)

local isMyWaiPai=zhengzhanshanhaiModel:checkInMyWaiPai(team.guid)
local isOut=teamData.sec>0
item:SetChildActive(15,not isOut and not isMyWaiPai)
item:SetChildActive(16,isMyWaiPai)
item:SetChildActive(17,isOut and not isMyWaiPai)
return true
end

function UIXM_ZZSH_monsterAllMyTeamWin:refreshAllItem()
if self.teamsList then
local num=#self.teamsList
if num>0 then
local rebuild=false
for idx,v in ipairs(self.teamsList)do
local flag=self:refreshItem(nil,idx)
if flag==false then
rebuild=true
break
end
end
if rebuild then
if self.Fight_paixu==1 then
self:paixuFight2()
elseif self.Fight_paixu==2 then
self:paixuFight1()
elseif self.info_paixu==1 then
self:PaixuInfo2()
elseif self.info_paixu==2 then
self:PaixuInfo1()
end


end
end
end
end

function UIXM_ZZSH_monsterAllMyTeamWin:refreshDelTeam()
self:morenPaiXu()
end

function UIXM_ZZSH_monsterAllMyTeamWin:onItemJoinClick(idx)
local team=self.teamsList[idx]
local guid=team.guid
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData then
UIManager:invokeUIMethod('UIXM_ZZSH_noteWin','onClickClose')
local needRefresh=zhengzhanshanhaiModel:checkQingBaoRefresh(qbData)
if needRefresh then
zhengzhanshanhaiModel:reqQingBaoDetail(qbData)
end
zhengzhanshanhaiModel:checkQingBaoDetail_xm(guid)
end
end

function UIXM_ZZSH_monsterAllMyTeamWin:onItemBoxClick(idx)
local team=self.teamsList[idx]
local guid=team.guid
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData then
zhengzhanshanhaiController:showMonsterReward(guid)
end
end

function UIXM_ZZSH_monsterAllMyTeamWin:onCliskMask()
self:onCloseBtn()
end

function UIXM_ZZSH_monsterAllMyTeamWin:onCloseBtn()
UIManager:invokeUIMethod('UIXM_ZZSH_noteWin','onClickClose')
end

function UIXM_ZZSH_monsterAllMyTeamWin:onGotoBtn()
self:onCloseBtn()
UILSZDControl:closeUI(nil,true)
UIManager:showWindow('UIXM_ZZSH_entitySelectWin')
end

function UIXM_ZZSH_monsterAllMyTeamWin:rec_changeJiJie(guid)
local idx=self:fingTeamIndex(guid)
if idx then
self:refreshItem(nil,idx)
end
end

local fightIcon=
{
'button_tybukepailie',
'button_tykepailie_2',
'button_tykepailie_1',
}

function UIXM_ZZSH_monsterAllMyTeamWin:paixuFight1()
table.sort(self.teamsList,function(a,b)

if not zhengzhanshanhaiModel:checkInMyWaiPai(a.guid)and zhengzhanshanhaiModel:checkInMyWaiPai(b.guid)then
return false
elseif zhengzhanshanhaiModel:checkInMyWaiPai(a.guid)and not zhengzhanshanhaiModel:checkInMyWaiPai(b.guid)then
return true
end
return a.fight_num<b.fight_num
end)
end

function UIXM_ZZSH_monsterAllMyTeamWin:paixuFight2()
table.sort(self.teamsList,function(a,b)

if not zhengzhanshanhaiModel:checkInMyWaiPai(a.guid)and zhengzhanshanhaiModel:checkInMyWaiPai(b.guid)then
return false
elseif zhengzhanshanhaiModel:checkInMyWaiPai(a.guid)and not zhengzhanshanhaiModel:checkInMyWaiPai(b.guid)then
return true
end
return a.fight_num>b.fight_num
end)
end
function UIXM_ZZSH_monsterAllMyTeamWin:onFightPaixu()
local num=#self.teamsList
if num>1 then
if self.Fight_paixu==1 then
self:paixuFight1()
self:changepaixu(3,2)
self.fightPaixu:setSprite(globalABLookup.global,fightIcon[1])
self.infoPaixu:setSprite(globalABLookup.global,fightIcon[3])
else
self:paixuFight2()
self:changepaixu(3,1)
self.fightPaixu:setSprite(globalABLookup.global,fightIcon[2])
self.infoPaixu:setSprite(globalABLookup.global,fightIcon[3])
end
end
self:refreshInfo()
end
function UIXM_ZZSH_monsterAllMyTeamWin:PaixuInfo1()
table.sort(self.teamsList,function(a,b)

if not zhengzhanshanhaiModel:checkInMyWaiPai(a.guid)and zhengzhanshanhaiModel:checkInMyWaiPai(b.guid)then
return false
elseif zhengzhanshanhaiModel:checkInMyWaiPai(a.guid)and not zhengzhanshanhaiModel:checkInMyWaiPai(b.guid)then
return true
end
local qbData1=zhengzhanshanhaiModel:getQingBaoData(a.guid)
local cfg1=qbData1.cfg
local qbData2=zhengzhanshanhaiModel:getQingBaoData(b.guid)
local cfg2=qbData2.cfg
return cfg1.stage<cfg2.stage
end)
end

function UIXM_ZZSH_monsterAllMyTeamWin:PaixuInfo2()
table.sort(self.teamsList,function(a,b)

if not zhengzhanshanhaiModel:checkInMyWaiPai(a.guid)and zhengzhanshanhaiModel:checkInMyWaiPai(b.guid)then
return false
elseif zhengzhanshanhaiModel:checkInMyWaiPai(a.guid)and not zhengzhanshanhaiModel:checkInMyWaiPai(b.guid)then
return true
end
local qbData1=zhengzhanshanhaiModel:getQingBaoData(a.guid)
local cfg1=qbData1.cfg
local qbData2=zhengzhanshanhaiModel:getQingBaoData(b.guid)
local cfg2=qbData2.cfg
return cfg1.stage>cfg2.stage
end)
end

function UIXM_ZZSH_monsterAllMyTeamWin:onInfoPaixu()
local num=#self.teamsList
if num>1 then
if self.info_paixu==1 then

self:PaixuInfo1()
self:changepaixu(1,2)
self.infoPaixu:setSprite(globalABLookup.global,fightIcon[2])
self.fightPaixu:setSprite(globalABLookup.global,fightIcon[3])
else

self:PaixuInfo2()
self:changepaixu(1,1)
self.infoPaixu:setSprite(globalABLookup.global,fightIcon[1])
self.fightPaixu:setSprite(globalABLookup.global,fightIcon[3])
end
end
self:refreshInfo()
end


function UIXM_ZZSH_monsterAllMyTeamWin:changepaixu(type,num)
self.info_paixu=0

self.Fight_paixu=0
if type==1 then
self.info_paixu=num
elseif type==3 then
self.Fight_paixu=num
end

end

function UIXM_ZZSH_monsterAllMyTeamWin:onYbdsetBtn()
self:showWindow("UIXMZZSH_YuBeiDuiSetWin")
end