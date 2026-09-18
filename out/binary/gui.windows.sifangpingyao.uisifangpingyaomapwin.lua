







def_class("UISiFangPingYaoMapWin",UIWindowBase)









function UISiFangPingYaoMapWin:bindComponents()

self.mapicons=UIObject.get(self,0)
self.mapitems=UIObject.get(self,1)
self.rewardReddot=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.rewardBtn=UIButton.get(self,4)
self.helpBtn=UIButton.get(self,5)
self.TXZBtn=UIButton.get(self,6)
self.TXZReddot=UIObject.get(self,7)
self.closeBtnmain=UIButton.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.TXZBtn:setButtonClick(function()self:onTXZBtn()end)

self.closeBtnmain:setButtonClick(function()self:onCloseBtnmain()end)



end


function UISiFangPingYaoMapWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mapicons);self.mapicons=nil;
_UIObject_release(self.mapitems);self.mapitems=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.TXZBtn);self.TXZBtn=nil;
_UIObject_release(self.TXZReddot);self.TXZReddot=nil;
_UIObject_release(self.closeBtnmain);self.closeBtnmain=nil;
end
















local _this
local mapitemidex=
{
itemself=0,
icon=1,
tzimg=2,
namebg=3,
name=4,
jdimg=5,
jdtxt=6,
tgimg=7,
btn=8,
spine=9,
lock=10,
djs=11,
djstxt=12,
}
local ab_name=""
local zjidx=
{
[0]="第一章",
[1]="第一章",
[2]="第二章",
[3]="第三章",
}

local yg_systemid=
{
[1]=174,
[2]=177,
[3]=178,
[4]=179,
[5]=180,
}




function UISiFangPingYaoMapWin:onLoaded(...)
self:bindComponents()
_this=self
self:setnewzhangjie()
notifySystem:listenNotify(notifyConfig.onTYTXZRewardChange,self.onTYTXZRewardChange)
end


function UISiFangPingYaoMapWin:__delete()
notifySystem:removelistener(notifyConfig.onTYTXZRewardChange,self.onTYTXZRewardChange)
self:unbindComponents()
_this=nil
end




function UISiFangPingYaoMapWin:onShow(argtable,afterOnloaded)

self:inihMapWidgetinfo()
self:refreshTXZData()
end


function UISiFangPingYaoMapWin:onShowArgRecv(argtable)

self:inihMapWidgetinfo()
end


function UISiFangPingYaoMapWin:showNewYGopen(Flag,Idx)
UIManager:showWindow("UISiFangPingYaoOpenWin",{flag=Flag,infoidx=Idx})
end


function UISiFangPingYaoMapWin:setnewzhangjie()
local ygzjlist=userActorArraySetting.get(ACTOR_SETTING_TYPE.eSiFangPingYao,'ygzjlist',nil)
if not ygzjlist then
local temp=
{
[1]={0,0,0},
[2]={0,0,0},
[3]={0,0,0},
[4]={0,0,0},
[5]={0,0,0},
}
userActorArraySetting.set(ACTOR_SETTING_TYPE.eSiFangPingYao,'ygzjlist',temp)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eSiFangPingYao)
end
local sfpytgarry=userActorArraySetting.get(ACTOR_SETTING_TYPE.eSiFangPingYao,'sfpytgarry',nil)
if not sfpytgarry then
local temp2=
{
[1]=0,
[2]=0,
[3]=0,
[4]=0,
[5]=0,
}
userActorArraySetting.set(ACTOR_SETTING_TYPE.eSiFangPingYao,'sfpytgarry',temp2)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eSiFangPingYao)
end
end



function UISiFangPingYaoMapWin:onHide()

end


function UISiFangPingYaoMapWin:inihMapWidgetinfo()
local mapitem=self.mapitems:getWidgetBase()
local teamlist=SiFangPingYaoModel:getDZTeamList()

local mapidex=SiFangPingYaoModel:getMapIdex()
local chapter_id=SiFangPingYaoModel:getZhangjieIdex()
local ygopenlist={}

for i=1,5 do
local widget=mapitem:GetChildWidgetBase(i-1)
local mapconfig=cfg_foursideskilldemonsconfig_get(i)
local isinit=mapidex==i and#teamlist>0
local ygimg=mapconfig.ygimg

local ygname=mapconfig.name
widget:SetChildText(mapitemidex.name,ygname)
widget:SetChildActive(mapitemidex.tzimg,isinit)

local allygjd=SiFangPingYaoModel:getYGJingDuData()
local isopen=true

if i>1 then
local all_oldyg_jd=SiFangPingYaoController:getzjdqallJindu(i-1)
if all_oldyg_jd>0 then
local max_jd=self:getzjAllJindu(i-1,1)
if all_oldyg_jd<max_jd then
isopen=false
end
else
isopen=false
end
end
local checkOpen2=SiFangPingYaoController:checkOpen(yg_systemid[i])
if not checkOpen2 then
isopen=false
end


if isopen then
widget:SetChildActive(mapitemidex.lock,false)
widget:SetChildActive(mapitemidex.icon,false)
widget:SetChildActive(mapitemidex.spine,true)
widget:SetChildUIModelShowTarget(mapitemidex.spine,ygimg[1],1,nil,eAnimationID.stand)

ygopenlist[#ygopenlist+1]=i
else
widget:SetChildActive(mapitemidex.lock,true)
widget:SetChildActive(mapitemidex.icon,true)
widget:SetChildGray(mapitemidex.icon,true)
widget:SetChildActive(mapitemidex.spine,false)
end


local all_yg_jd=SiFangPingYaoController:getzjdqallJindu(i)
if all_yg_jd>0 then
local now_jd=all_yg_jd
local max_jd=self:getzjAllJindu(i,1)
if now_jd>=max_jd then
widget:SetChildActive(mapitemidex.jdimg,false)
widget:SetChildActive(mapitemidex.tgimg,true)
else

if mapidex==i then
local nowjd=self:getzjNowJindu()
local str_jd=FMT.fmt("{0}/{1}",nowjd,max_jd)
local this_chapter_id=allygjd[i].param_2
if isinit and chapter_id>0 then
this_chapter_id=chapter_id
end
if this_chapter_id>1 then
local num=this_chapter_id-1
local newjd=self:getzjSingleJindu(i,this_chapter_id)
str_jd=FMT.fmt('{0}/{1}',nowjd+(newjd*num),max_jd)
end
widget:SetChildActive(mapitemidex.jdimg,true)
widget:SetChildText(mapitemidex.jdtxt,str_jd)
else
local singleline=UISiFangPingYaoMapWin:getzjSingleJindu(i,1)
local ygjd=SiFangPingYaoModel:getYGJingDuData()
local ygjd_data=ygjd[i]

local _chapter_id=ygjd_data.param_2
local maxnum=(_chapter_id-1)*singleline
local str_jd=FMT.fmt("{0}/{1}",maxnum,singleline*3)





widget:SetChildActive(mapitemidex.jdimg,true)
widget:SetChildText(mapitemidex.jdtxt,str_jd)
end
end
else
widget:SetChildActive(mapitemidex.jdimg,false)
if i==1 then
local max_jd=self:getzjAllJindu(i,1)
local str_jd=FMT.fmt("{0}/{1}",0,max_jd)
widget:SetChildActive(mapitemidex.jdimg,true)
widget:SetChildText(mapitemidex.jdtxt,str_jd)
end
end


local checkOpen=SiFangPingYaoController:checkOpen(yg_systemid[i])

if checkOpen then
widget:SetChildActive(mapitemidex.djs,false)
else
widget:SetChildActive(mapitemidex.djs,true)
local coldDay=SiFangPingYaoController:getColdDay(yg_systemid[i])

if coldDay>0 then
widget:SetChildText(mapitemidex.djstxt,FMT.fmt("{0}天后开启",coldDay))
else
widget:SetChildText(mapitemidex.djstxt,SiFangPingYaoController:getOpenTips(yg_systemid[i])or'')
end
end


widget:SetChildButtonClick(mapitemidex.btn,function()
if _this==nil then return end
_this:OnMapItemClick(i,isopen,isinit)
end)
end

self:refreshjlreddot()



if#ygopenlist>0 then
local ygopen=userActorArraySetting.get(ACTOR_SETTING_TYPE.eSiFangPingYao,'ygopen',{})
if#ygopenlist>#ygopen then


local newygid=ygopenlist[#ygopenlist]
if newygid then
local checkOpen=SiFangPingYaoController:checkOpen(yg_systemid[newygid])
if checkOpen then
self:showNewYGopen(1,newygid)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eSiFangPingYao,'ygopen',ygopenlist)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eSiFangPingYao)
end
end
end
end
end


function UISiFangPingYaoMapWin:getzjNowJindu()
local pointendlist=SiFangPingYaoModel:getPointFinishList()
local lenght=0
for k,v in pairs(pointendlist)do
lenght=lenght+1
end
return lenght
end


function UISiFangPingYaoMapWin:onCloseBtn()

jumpManager:jump({id=JUMP_TYPE.eJiuChongTianJie,args={sysType=JIUCHONGTIANJIE_SYS_TYPE.eZhanChenYuan}})
end

function UISiFangPingYaoMapWin:onCloseBtnmain()
local func=function()
UIFullSiFangPingYaoControl:closeUI()
end
loadingControl.openCloud(func,nil,true)
end


function UISiFangPingYaoMapWin:onRewardBtn()
self:showWindow("UISFPYRewardWintwo")
end


function UISiFangPingYaoMapWin:onHelpBtn()
local d={}
d.mode=3
d.title="规则介绍"
d.name='UISiFangPingYaoMapWin_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UISiFangPingYaoMapWin:refreshjlreddot()
local reddot1=false
local reddot2=SiFangPingYaoController:cjallreddot()
self.rewardReddot:setActive(reddot1 or reddot2)
end


function UISiFangPingYaoMapWin:OnMapItemClick(ygid,isopen,isinit)
local demons_id=SiFangPingYaoModel:getMapIdex()
local teamlist=SiFangPingYaoModel:getDZTeamList()


local checkOpen=SiFangPingYaoController:checkOpen(yg_systemid[ygid])
if not checkOpen then
local coldDay=SiFangPingYaoController:getColdDay(yg_systemid[ygid])

if coldDay>0 then
UIManager.info(FMT.fmt('<color=#000000>{0}</color>',coldDay))
else
UIManager.info(FMT.fmt('<color=#000000>{0}</color>',SiFangPingYaoController:getOpenTips(yg_systemid[ygid])))
end
return
end


if not isopen then
local nextid=ygid-1
local cfgdata=cfg_foursideskilldemonsconfig_get(nextid)
if cfgdata then
local nextname=cfgdata.name
UIManager.info(FMT.fmt('请先通关<color=#ca631d>{0}</color>',nextname))
end
return
end

if demons_id~=0 and#teamlist>0 then
if isopen and demons_id~=ygid then

local chapter_id=SiFangPingYaoModel:getZhangjieIdex()or 1
local newygcfg=cfg_foursideskilldemonsconfig_get(ygid)
local oldygcfg=cfg_foursideskilldemonsconfig_get(demons_id)
local tips=""
if newygcfg and newygcfg.name and oldygcfg and oldygcfg.name then
local oldygname=oldygcfg.name
local oldygzj=zjidx[chapter_id]
local newygname=newygcfg.name
tips=FMT.fmt('当前队伍在挑战<color=#ca631d>{0}{1}</color>，是否撤离队伍挑战<color=#ca631d>{2}</color>？',oldygname,oldygzj,newygname)
end
local show_data=
{
title='提示',
_okText="确定",
_cancelText="取消",
tipsText=tips,
closetopbtn=true,
cellcallback=function()
SiFangPingYaoModel:setmapcheli(ygid)
SiFangPingYaoController.send_34_63(1)
end,
}
UIManager:showWindow('UIDialougeNormalTip',show_data)
return
end
end


if ygid and#teamlist>0 then
local _demons_id=SiFangPingYaoModel:getMapIdex()
if _demons_id and _demons_id==0 then
SiFangPingYaoController:showbuzhenwin(ygid)
else
local func=function()
UIFullSiFangPingYaoControl:showSiFangPingYaoMainWinNoCloud({isqiehuan=true})
end
loadingControl.openCloud(func,nil,true)
end
else

SiFangPingYaoController:showbuzhenwin(ygid)
end
end


function UISiFangPingYaoMapWin:showbuzhenwin(ygid)

SiFangPingYaoModel:setdizisortygid(ygid)
local mapconfig=cfg_foursideskilldemonsconfig_get(ygid)
local mapname=mapconfig.name
local ygmapid=mapconfig.ygmapid or 818002
local selectDiscipleCallBack=function(guidList,zhenfaId)
local func=function()
UIManager:closeWindow('UISiFangPingYaoExtraWin')
local tlist={}
for i,v in ipairs(guidList)do
table.insert(tlist,v[2])
end
SiFangPingYaoModel:setMapIdex(ygid)
SiFangPingYaoModel:setTeamChangeRecord(nil)
SiFangPingYaoController.send_34_52(#tlist,tlist)
UIFullSiFangPingYaoControl:showSiFangPingYaoMainWinNoCloud()
fightController:closeSelectStage(false)
end
loadingControl.openCloud(func,2)
end
local CancelCallBack=function()
UIManager:closeWindow('UISiFangPingYaoExtraWin')
UIFullSiFangPingYaoControl:showSiFangPingYaoMapWinNoCloud()
end

local winArgs=
{
enterTxt=mapname,
mapId=ygmapid,
closeByCloud=true,
sfpy_enter=true,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
isHomeBattle=false,
showZhenFa=false,
checkDZTopSortFunc=SiFangPingYaoController.checkDZTopSortFunc,
cancelCallBack=CancelCallBack,
enterCallBack=selectDiscipleCallBack,
}


fightController.showPrepareWin(fightPreSelectModel.fightType.sifangpingyao,winArgs,function(...)
UIFullFightPrepareControl:showWindow("UISiFangPingYaoExtraWin",{demons_id=ygid})
end)
end


function UISiFangPingYaoMapWin:getzjAllJindu(demons_id,chapter_id)
local map_id=cfg_foursideskilldemonschapterconfig_get(demons_id)[chapter_id].map_id
local mapcfg=cfg_foursideskilldemonsmapconfig_get(map_id)
local mapdata=mapcfg.routes
local Singlerout=mapdata[1][1][1]
local lenght=0
for k,v in pairs(Singlerout)do
lenght=lenght+1
end
return lenght*3
end


function UISiFangPingYaoMapWin:getzjSingleJindu(demons_id,chapter_id)
local map_id=cfg_foursideskilldemonschapterconfig_get(demons_id)[chapter_id].map_id
local mapcfg=cfg_foursideskilldemonsmapconfig_get(map_id)
local mapdata=mapcfg.routes
local Singlerout=mapdata[1][1][1]
local lenght=0
for k,v in pairs(Singlerout)do
lenght=lenght+1
end
return lenght
end


function UISiFangPingYaoMapWin:testtttttips(a,b,c)
UIManager:showWindow("UISiFangPingYaoOpenWin",{flag=a,infoidx=b,infoidx2=c})
end


function UISiFangPingYaoMapWin:testtttt()
UIManager:showWindow("UISFPYYWExtraWin")
end
function UISiFangPingYaoMapWin:testtttt2()
UIManager:closeWindow("UISFPYYWExtraWin")
end
function UISiFangPingYaoMapWin:testttttnb()
UIManager:showWindow("UISFPYBossNQWin")
end
function UISiFangPingYaoMapWin:testttttnb2()
UIManager:closeWindow("UISFPYBossNQWin")
end
function UISiFangPingYaoMapWin:testtttttg()
UIManager:showWindow("UISFPYtongguanWin",{thisygid=1,nextygid=2})
end
function UISiFangPingYaoMapWin:testtttnuqizhi(value)
SiFangPingYaoModel:setbossanger(value)
end
function UISiFangPingYaoMapWin:testtttwenben(attrdesc,descparm,level)
local desc=attrdesc
local descparm=descparm
if descparm and descparm[level]and next(descparm[level])then
desc=string.format(desc,unpack(descparm[level]))
end

end







function UISiFangPingYaoMapWin.onTYTXZRewardChange(passport_guid)

if passport_guid==_this.passport_guid then
_this:refreshTXZBtn()
end
end

function UISiFangPingYaoMapWin:refreshTXZData()
self.passParm=UITYTongXingZhengController.getBaseInfo(passportDefine.eSFPY,'passParm')
self.iconParm=UITYTongXingZhengController.getBaseInfo(passportDefine.eSFPY,'iconParm')

local passporttype=self.passParm[1]
local sys_id=self.passParm[2]
local sub_sys_id=self.passParm[3]
self.passport_guid=UITYTongXingZhengModel:getGuidBySysID(passporttype,sys_id,sub_sys_id)

if self.passport_guid then
self:refreshTXZBtn()
else
_this.TXZBtn:setActive(false)
end
end

function UISiFangPingYaoMapWin:isHideTxzBtn()
self.passParm=UITYTongXingZhengController.getBaseInfo(passportDefine.eSFPY,'passParm')
self.iconParm=UITYTongXingZhengController.getBaseInfo(passportDefine.eSFPY,'iconParm')

local passporttype=self.passParm[1]
local sys_id=self.passParm[2]
local sub_sys_id=self.passParm[3]
local guid=UITYTongXingZhengModel:getGuidBySysID(passporttype,sys_id,sub_sys_id)
local txzId=UITYTongXingZhengModel:getTXZId(guid)

if not guid or not txzId then
local str=string.format("系統id：%s-%s 拿取guid或通行证id有误，请联系前端排查！！！",sys_id,sub_sys_id)
logErr(str)
end

if UITYTongXingZhengModel:isReceiveFullIncludeCharge(guid,txzId)then
local config=cfgHelper.get2(cfg_passportconfig_get,txzId,'drop_id')
if not config then
return false
end
end
return true
end

function UISiFangPingYaoMapWin:refreshTXZBtn()
local iconname=_this.iconParm[1]
local abname=_this.iconParm[2]
local reddot=UITYTongXingZhengController:checkReddot(_this.passport_guid)
_this.TXZReddot:setActive(reddot)

local flag=self:isHideTxzBtn()
if not flag then
UIManager:invokeUIMethod("UITYTXZRewardsWin","onCloseBtn")
end
_this.TXZBtn:setActive(flag)


end

function UISiFangPingYaoMapWin:onTXZBtn()
if self.passport_guid then
UITYTongXingZhengController:showTXZWin(self.passport_guid,passportDefine.eSFPY)
end
end
