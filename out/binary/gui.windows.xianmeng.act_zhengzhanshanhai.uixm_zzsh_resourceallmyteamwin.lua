







def_class("UIXM_ZZSH_resourceAllMyTeamWin",UIWindowBase)









function UIXM_ZZSH_resourceAllMyTeamWin:bindComponents()

self.cliskMask=UIButton.get(self,0)
self.itemScrollView=UIObject.get(self,1)
self.noSign=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.gotoBtn=UIButton.get(self,4)
self.itemPanel=UIObject.get(self,5)
self.infoPaixu=UIButton.get(self,9)
self.distancePaixu=UIButton.get(self,10)
self.fightPaixu=UIButton.get(self,11)
self.showBtn=UIButton.get(self,12)

self.cliskMask:setButtonClick(function()self:onCliskMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.infoPaixu:setButtonClick(function()self:onInfoPaixu()end)

self.distancePaixu:setButtonClick(function()self:onDistancePaixu()end)

self.fightPaixu:setButtonClick(function()self:onFightPaixu()end)

self.showBtn:setButtonClick(function()self:onShowBtn()end)



end


function UIXM_ZZSH_resourceAllMyTeamWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cliskMask);self.cliskMask=nil;
_UIObject_release(self.itemScrollView);self.itemScrollView=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.infoPaixu);self.infoPaixu=nil;
_UIObject_release(self.distancePaixu);self.distancePaixu=nil;
_UIObject_release(self.fightPaixu);self.fightPaixu=nil;
_UIObject_release(self.showBtn);self.showBtn=nil;
end


















local _this

function UIXM_ZZSH_resourceAllMyTeamWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onZZSHPvEQingBaoChange,self.onZZSHPvEQingBaoChange)

end


function UIXM_ZZSH_resourceAllMyTeamWin:__delete()
UIManager:invokeUIMethod('UIXM_ZZSH_PvEMainWin','refreshMyXMJiJie')

self:unbindComponents()
end




function UIXM_ZZSH_resourceAllMyTeamWin:onShow(argtable,afterOnloaded)

self.info_paixu=0
self.Distance_paixu=0
self.Fight_paixu=0
self.showflag=false
self:paixu_moren()
self:refreshInfo()
end


function UIXM_ZZSH_resourceAllMyTeamWin:onHide()

end
local fightIcon=
{
'button_tybukepailie',
'button_tykepailie_2',
'button_tykepailie_1',
}

local cmp=
{
joinbtn=0,
backbtn=1,
findbtn=2,
modelIcon=3,
nametext=4,
fight=5,
signicon=6,
teamnum=7,
time=8,
icontag=9,
PKnotpk=10,
mybg=11,
myicon=12,
model=13,
}

function UIXM_ZZSH_resourceAllMyTeamWin:baseSet()


end


function UIXM_ZZSH_resourceAllMyTeamWin:paixu_moren()
self.teamsList=zhengzhanshanhaiModel:getPvEResourceDatasList()
local num=#self.teamsList
if num>1 then
table.sort(self.teamsList,function(a,b)

if not zhengzhanshanhaiModel:checkInMyWaiPai(a.guid)and zhengzhanshanhaiModel:checkInMyWaiPai(b.guid)then
return false
elseif zhengzhanshanhaiModel:checkInMyWaiPai(a.guid)and not zhengzhanshanhaiModel:checkInMyWaiPai(b.guid)then
return true
else
local qbData1=zhengzhanshanhaiModel:getQingBaoData(a.guid)
local cfg1=qbData1.cfg
local qbData2=zhengzhanshanhaiModel:getQingBaoData(b.guid)
local cfg2=qbData2.cfg
return cfg1.stage>cfg2.stage
end
end)
self:changepaixu(1,1)
end
self.infoPaixu:setSprite(globalABLookup.global,fightIcon[1])
self.fightPaixu:setSprite(globalABLookup.global,fightIcon[3])
self.distancePaixu:setSprite(globalABLookup.global,fightIcon[3])
end
function UIXM_ZZSH_resourceAllMyTeamWin:refreshInfo()
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
if not qbData then
return
end
local cfg=qbData.cfg

item:SetChildButtonClick(cmp.findbtn,function()
if _this==nil then return end
zhengzhanshanhaiModel:checkQingBaoDetail(team.guid,nil)
UIManager:invokeUIMethod('UIXM_ZZSH_noteWin','onClickClose')
end)

local nameStr=qbData:getName()

item:SetChildText(cmp.nametext,FMT.fmt("<color={0}>{1}</color>",FONT_COLOR_VAL[cfg.stage],nameStr))
local showModelIcon=cfg.modelIcon~=nil
item:SetChildActive(cmp.modelIcon,showModelIcon)
local showModel=cfg.model~=nil
item:SetChildActive(cmp.model,showModel)

if showModel then
local modelParams=comHelper.getMonsterModelParamsEx(cfg.model)
local size=0.75
item:SetChildUIModelShowTarget(cmp.model,modelParams.body,size,modelParams.componets,eAnimationID.stand)
end

if showModelIcon then
item:SetChildCSImageSprite(cmp.modelIcon,globalABLookup.zzshentityicons,cfg.modelIcon)
end
item:SetChildCSImageIcon(cmp.icontag,moneyModel.getIconNameEx(cfg.moneytype),true)
local teamnumstr=""
if team.gathernum>=cfg.max then
teamnumstr=string.format("<color=#c82c2c>%d/%d</color>",tonumber(tostring(team.gathernum)),cfg.max)
else
teamnumstr=string.format("<color=#549327>%d/%d</color>",tonumber(tostring(team.gathernum)),cfg.max)
end
item:SetChildText(cmp.teamnum,teamnumstr)

item:SetChildText(cmp.fight,mathHelper.formatNumber5(tonumber(tostring(team.fight)),2))

local costTime=zhengzhanshanhaiModel:getQingBaoWayTime(qbData)
local time_str=timeHelper.format_time_stamp3(costTime)
item:SetChildText(cmp.time,time_str)

local waipaiflag=zhengzhanshanhaiModel:checkInMyWaiPai(team.guid)
item:SetChildActive(cmp.backbtn,waipaiflag)
item:SetChildActive(cmp.joinbtn,not waipaiflag)
item:SetChildActive(cmp.mybg,waipaiflag)
item:SetChildActive(cmp.myicon,waipaiflag)

item:SetChildButtonClick(cmp.joinbtn,function()
if _this==nil then return end
_this:ClickCommitBtn(team.guid)
end)

item:SetChildButtonClick(cmp.backbtn,function()
if _this==nil then return end
_this:ClickBackBtn(team.guid)
end)

local gather=zhengzhanshanhaiController:getZZSHCfg('gather')
local stage=cfg.stage
local icon=(stage<=gather[2])and 2 or 1
item:SetChildCSImageSprite(cmp.PKnotpk,globalABLookup.zzshicons,FMT.fmt('button_shanhaisjlbtp_{0}',icon))

item:SetChildButtonClick(cmp.PKnotpk,function()
if _this==nil then return end
_this:onPKorNotBtn(stage)
end)

end)
end
end




function UIXM_ZZSH_resourceAllMyTeamWin:ClickCommitBtn(qbGuid)

zhengzhanshanhaiModel:checkQingBaoDetail(qbGuid,nil,1)
UIManager:invokeUIMethod('UIXM_ZZSH_noteWin','onClickClose')
end

function UIXM_ZZSH_resourceAllMyTeamWin:ClickBackBtn(qbGuid)

zhengzhanshanhaiModel:checkQingBaoDetail(qbGuid,nil,0)
UIManager:invokeUIMethod('UIXM_ZZSH_noteWin','onClickClose')
end

function UIXM_ZZSH_resourceAllMyTeamWin:paixuInfo1()

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

function UIXM_ZZSH_resourceAllMyTeamWin:paixuInfo2()

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



function UIXM_ZZSH_resourceAllMyTeamWin:onInfoPaixu()
local num=#self.teamsList
if num>1 then
if self.info_paixu==1 then
self:paixuInfo1()
self:changepaixu(1,2)
self.infoPaixu:setSprite(globalABLookup.global,fightIcon[2])
self.fightPaixu:setSprite(globalABLookup.global,fightIcon[3])
self.distancePaixu:setSprite(globalABLookup.global,fightIcon[3])
else

self:paixuInfo2()
self:changepaixu(1,1)
self.infoPaixu:setSprite(globalABLookup.global,fightIcon[1])
self.fightPaixu:setSprite(globalABLookup.global,fightIcon[3])
self.distancePaixu:setSprite(globalABLookup.global,fightIcon[3])
end
end
self:refreshInfo()
end

function UIXM_ZZSH_resourceAllMyTeamWin:paixuDistance1()
table.sort(self.teamsList,function(a,b)

if not zhengzhanshanhaiModel:checkInMyWaiPai(a.guid)and zhengzhanshanhaiModel:checkInMyWaiPai(b.guid)then
return false
elseif zhengzhanshanhaiModel:checkInMyWaiPai(a.guid)and not zhengzhanshanhaiModel:checkInMyWaiPai(b.guid)then
return true
end
local qbData1=zhengzhanshanhaiModel:getQingBaoData(a.guid)
local time1=zhengzhanshanhaiModel:getQingBaoWayTime(qbData1)
local qbData2=zhengzhanshanhaiModel:getQingBaoData(b.guid)
local time2=zhengzhanshanhaiModel:getQingBaoWayTime(qbData2)
return time1<time2
end)
end

function UIXM_ZZSH_resourceAllMyTeamWin:paixuDistance2()
table.sort(self.teamsList,function(a,b)

if not zhengzhanshanhaiModel:checkInMyWaiPai(a.guid)and zhengzhanshanhaiModel:checkInMyWaiPai(b.guid)then
return false
elseif zhengzhanshanhaiModel:checkInMyWaiPai(a.guid)and not zhengzhanshanhaiModel:checkInMyWaiPai(b.guid)then
return true
end
local qbData1=zhengzhanshanhaiModel:getQingBaoData(a.guid)
local time1=zhengzhanshanhaiModel:getQingBaoWayTime(qbData1)
local qbData2=zhengzhanshanhaiModel:getQingBaoData(b.guid)
local time2=zhengzhanshanhaiModel:getQingBaoWayTime(qbData2)
return time1>time2
end)
end


function UIXM_ZZSH_resourceAllMyTeamWin:onDistancePaixu()
local num=#self.teamsList
if num>1 then
if self.Distance_paixu==1 then
self:paixuDistance1()
self:changepaixu(2,2)
self.distancePaixu:setSprite(globalABLookup.global,fightIcon[2])
self.fightPaixu:setSprite(globalABLookup.global,fightIcon[3])
self.infoPaixu:setSprite(globalABLookup.global,fightIcon[3])
else
self:paixuDistance2()
self:changepaixu(2,1)
self.distancePaixu:setSprite(globalABLookup.global,fightIcon[1])
self.fightPaixu:setSprite(globalABLookup.global,fightIcon[3])
self.infoPaixu:setSprite(globalABLookup.global,fightIcon[3])
end
end
self:refreshInfo()
end


function UIXM_ZZSH_resourceAllMyTeamWin:paixu_teamnum()
local num=#self.teamsList
if num>1 then
table.sort(self.teamsList,function(a,b)
return a.gathernum<b.gathernum
end)
end
self:refreshInfo()
end

function UIXM_ZZSH_resourceAllMyTeamWin:paixuFight1()
table.sort(self.teamsList,function(a,b)

if not zhengzhanshanhaiModel:checkInMyWaiPai(a.guid)and zhengzhanshanhaiModel:checkInMyWaiPai(b.guid)then
return false
elseif zhengzhanshanhaiModel:checkInMyWaiPai(a.guid)and not zhengzhanshanhaiModel:checkInMyWaiPai(b.guid)then
return true
end
return a.fight<b.fight
end)

end
function UIXM_ZZSH_resourceAllMyTeamWin:paixuFight2()
table.sort(self.teamsList,function(a,b)

if not zhengzhanshanhaiModel:checkInMyWaiPai(a.guid)and zhengzhanshanhaiModel:checkInMyWaiPai(b.guid)then
return false
elseif zhengzhanshanhaiModel:checkInMyWaiPai(a.guid)and not zhengzhanshanhaiModel:checkInMyWaiPai(b.guid)then
return true
end
return a.fight>b.fight
end)
end

function UIXM_ZZSH_resourceAllMyTeamWin:onFightPaixu()
local num=#self.teamsList
if num>1 then
if self.Fight_paixu==1 then
self:paixuFight1()
self:changepaixu(3,2)
self.fightPaixu:setSprite(globalABLookup.global,fightIcon[1])
self.distancePaixu:setSprite(globalABLookup.global,fightIcon[3])
self.infoPaixu:setSprite(globalABLookup.global,fightIcon[3])
else
self:paixuFight2()
self:changepaixu(3,1)
self.fightPaixu:setSprite(globalABLookup.global,fightIcon[2])
self.distancePaixu:setSprite(globalABLookup.global,fightIcon[3])
self.infoPaixu:setSprite(globalABLookup.global,fightIcon[3])
end
end
self:refreshInfo()
end


function UIXM_ZZSH_resourceAllMyTeamWin:onCliskMask()
end



function UIXM_ZZSH_resourceAllMyTeamWin:onCloseBtn()
UIManager:invokeUIMethod('UIXM_ZZSH_noteWin','onClickClose')
end



function UIXM_ZZSH_resourceAllMyTeamWin:onGotoBtn()
self:onCloseBtn()
UILSZDControl:closeUI(nil,true)
UIManager:showWindow('UIXM_ZZSH_entitySelectWin',{page=2})
end


function UIXM_ZZSH_resourceAllMyTeamWin:changepaixu(type,num)
self.info_paixu=0
self.Distance_paixu=0
self.Fight_paixu=0
if type==1 then
self.info_paixu=num
elseif type==2 then
self.Distance_paixu=num
elseif type==3 then
self.Fight_paixu=num
end

end


function UIXM_ZZSH_resourceAllMyTeamWin:onPKorNotBtn(stage)

local gather=zhengzhanshanhaiController:getZZSHCfg('gather')

if stage<=gather[2]then
self:showTips2()
else
self:showTips1()
end

end

function UIXM_ZZSH_resourceAllMyTeamWin:showTips1()
local args={}
args.desclist={}
local num=10
local name='zzsh_baodi_pk_rule_%d'
for i=1,num do
local str=cfgHelper.get1(cfg_lang_get,string.format(name,i))
if str~=nil then
table.insert(args.desclist,str)
end
end
args.title1="争斗宝地"

args.pos=Vector2(0,0)
UIManager:showWindow('UIDescribeTips7',args)
end


function UIXM_ZZSH_resourceAllMyTeamWin:showTips2()
local args={}
args.desclist={}
local num=10
local name='zzsh_baodi_safe_rule_%d'
for i=1,num do
local str=cfgHelper.get1(cfg_lang_get,string.format(name,i))
if str~=nil then
table.insert(args.desclist,str)
end
end
args.title1="安全宝地"

args.pos=Vector2(0,0)
UIManager:showWindow('UIDescribeTips7',args)
end
local showimg=
{
'image_dygou_1',
'image_dygou_2'
}

function UIXM_ZZSH_resourceAllMyTeamWin:onShowBtn()
self.showflag=not self.showflag

if self.showflag then

self.notMaxList={}
local i=1
for i=1,#self.teamsList do
local team=self.teamsList[i]
local qbData=zhengzhanshanhaiModel:getQingBaoData(team.guid)
local cfg=qbData.cfg
if team.gathernum<cfg.max then
self.notMaxList[#self.notMaxList+1]=team
end
end
self.teamsList=self.notMaxList
self.showBtn:setSprite(globalABLookup.global,showimg[2])
else
self:paixu_moren()
self.showBtn:setSprite(globalABLookup.global,showimg[1])
end
self:refreshInfo()

end


function UIXM_ZZSH_resourceAllMyTeamWin.onZZSHPvEQingBaoChange(opType,qbData)
if _this==nil or not _this.isVisible then return end
if opType==zhengzhanshanhaiModel.opType.eDel then
for k,v in pairs(_this.teamsList)do
if v.guid==qbData.guid then
if _this.info_paixu==1 then
_this:paixuInfo2()
elseif _this.info_paixu==2 then
_this:paixuInfo1()

elseif _this.Distance_paixu==1 then
_this:paixuDistance2()
elseif _this.Distance_paixu==2 then
_this:paixuDistance1()
elseif _this.Fight_paixu==1 then
_this:paixuFight2()
elseif _this.Fight_paixu==2 then
_this:paixuFight1()
end
end
end

end
end