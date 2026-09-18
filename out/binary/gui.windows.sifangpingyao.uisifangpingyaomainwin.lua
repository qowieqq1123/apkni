







def_class("UISiFangPingYaoMainWin",UIWindowBase)









function UISiFangPingYaoMainWin:bindComponents()

self.backEffect=UIObject.get(self,0)
self.ButtonCloseBg=UIButton.get(self,1)
self.mapname=UIText.get(self,2)
self.teamRoot=UIObject.get(self,3)
self.RoleListPanel=UIObject.get(self,4)
self.teamChangeButton=UIButton.get(self,5)
self.topRoot2=UIObject.get(self,6)
self.wingDir=UIText.get(self,7)
self.skillIcon=UIImage.get(self,8)
self.skillDescTxt=UIText.get(self,9)
self.fazepanel=UIObject.get(self,10)
self.jianlibtn=UIButton.get(self,11)
self.fazebtn=UIButton.get(self,12)
self.yaowbtn=UIButton.get(self,13)
self.tiaozhanbtn=UIButton.get(self,14)
self.jlreddot=UIObject.get(self,15)
self.tgjdtxt=UIText.get(self,16)
self.pointScroller=UIObject.get(self,17)
self.Content=UIObject.get(self,18)
self.pointItem=UIObject.get(self,19)
self.tipsbtn=UIButton.get(self,20)
self.diziModel=UIObject.get(self,21)
self.diziflag=UIImage.get(self,22)
self.bgModel=UIObject.get(self,23)
self.modelitem=UIObject.get(self,24)
self.teamtips=UIText.get(self,25)
self.ButtonTeamShow=UIButton.get(self,26)
self.ButtonTeamHide=UIButton.get(self,27)
self.jljdnowtxt=UIText.get(self,28)
self.jdspine=UIObject.get(self,29)
self.jdspine2=UIObject.get(self,30)
self.ytgimg=UIObject.get(self,31)
self.arrow1=UIObject.get(self,32)
self.arrowbtn=UIButton.get(self,33)
self.faZeList=UIObject.get(self,34)
self.fazeMask=UIButton.get(self,35)
self.arrow2=UIObject.get(self,36)
self.dzflag1=UIObject.get(self,37)
self.dzflag2=UIObject.get(self,38)
self.dzflag3=UIObject.get(self,39)
self.climg=UIObject.get(self,40)
self.tgeffect=UIObject.get(self,41)
self.dhMask=UIObject.get(self,42)
self.TXZBtn=UIButton.get(self,43)
self.TXZReddot=UIObject.get(self,44)
self.jljdnowtxt2=UIText.get(self,45)
self.dizipoint=UIObject.get(self,46)
self.dizinewpoint=UIObject.get(self,47)
self.dhmask=UIObject.get(self,48)
self.qyeffect=UIObject.get(self,49)

self.ButtonCloseBg:setButtonClick(function()self:onButtonCloseBg()end)

self.teamChangeButton:setButtonClick(function()self:onTeamChangeButton()end)

self.jianlibtn:setButtonClick(function()self:onJianlibtn()end)

self.fazebtn:setButtonClick(function()self:onFazebtn()end)

self.yaowbtn:setButtonClick(function()self:onYaowbtn()end)

self.tiaozhanbtn:setButtonClick(function()self:onTiaozhanbtn()end)

self.tipsbtn:setButtonClick(function()self:onTipsbtn()end)

self.ButtonTeamShow:setButtonClick(function()self:onButtonTeamShow()end)

self.ButtonTeamHide:setButtonClick(function()self:onButtonTeamHide()end)

self.arrowbtn:setButtonClick(function()self:onArrowbtn()end)

self.fazeMask:setButtonClick(function()self:onFazeMask()end)

self.TXZBtn:setButtonClick(function()self:onTXZBtn()end)


self.sprite_button_jljilu_1=0
self.sprite_button_jljilu_2=1
self.spriteAnim_mysterySkill=0
self.spriteAnim_mysterySkill2=1

end


function UISiFangPingYaoMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backEffect);self.backEffect=nil;
_UIObject_release(self.ButtonCloseBg);self.ButtonCloseBg=nil;
_UIObject_release(self.mapname);self.mapname=nil;
_UIObject_release(self.teamRoot);self.teamRoot=nil;
_UIObject_release(self.RoleListPanel);self.RoleListPanel=nil;
_UIObject_release(self.teamChangeButton);self.teamChangeButton=nil;
_UIObject_release(self.topRoot2);self.topRoot2=nil;
_UIObject_release(self.wingDir);self.wingDir=nil;
_UIObject_release(self.skillIcon);self.skillIcon=nil;
_UIObject_release(self.skillDescTxt);self.skillDescTxt=nil;
_UIObject_release(self.fazepanel);self.fazepanel=nil;
_UIObject_release(self.jianlibtn);self.jianlibtn=nil;
_UIObject_release(self.fazebtn);self.fazebtn=nil;
_UIObject_release(self.yaowbtn);self.yaowbtn=nil;
_UIObject_release(self.tiaozhanbtn);self.tiaozhanbtn=nil;
_UIObject_release(self.jlreddot);self.jlreddot=nil;
_UIObject_release(self.tgjdtxt);self.tgjdtxt=nil;
_UIObject_release(self.pointScroller);self.pointScroller=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.pointItem);self.pointItem=nil;
_UIObject_release(self.tipsbtn);self.tipsbtn=nil;
_UIObject_release(self.diziModel);self.diziModel=nil;
_UIObject_release(self.diziflag);self.diziflag=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.modelitem);self.modelitem=nil;
_UIObject_release(self.teamtips);self.teamtips=nil;
_UIObject_release(self.ButtonTeamShow);self.ButtonTeamShow=nil;
_UIObject_release(self.ButtonTeamHide);self.ButtonTeamHide=nil;
_UIObject_release(self.jljdnowtxt);self.jljdnowtxt=nil;
_UIObject_release(self.jdspine);self.jdspine=nil;
_UIObject_release(self.jdspine2);self.jdspine2=nil;
_UIObject_release(self.ytgimg);self.ytgimg=nil;
_UIObject_release(self.arrow1);self.arrow1=nil;
_UIObject_release(self.arrowbtn);self.arrowbtn=nil;
_UIObject_release(self.faZeList);self.faZeList=nil;
_UIObject_release(self.fazeMask);self.fazeMask=nil;
_UIObject_release(self.arrow2);self.arrow2=nil;
_UIObject_release(self.dzflag1);self.dzflag1=nil;
_UIObject_release(self.dzflag2);self.dzflag2=nil;
_UIObject_release(self.dzflag3);self.dzflag3=nil;
_UIObject_release(self.climg);self.climg=nil;
_UIObject_release(self.tgeffect);self.tgeffect=nil;
_UIObject_release(self.dhMask);self.dhMask=nil;
_UIObject_release(self.TXZBtn);self.TXZBtn=nil;
_UIObject_release(self.TXZReddot);self.TXZReddot=nil;
_UIObject_release(self.jljdnowtxt2);self.jljdnowtxt2=nil;
_UIObject_release(self.dizipoint);self.dizipoint=nil;
_UIObject_release(self.dizinewpoint);self.dizinewpoint=nil;
_UIObject_release(self.dhmask);self.dhmask=nil;
_UIObject_release(self.qyeffect);self.qyeffect=nil;
end

















local _this
local globalab='ui/sharedtextures/uiglobalspriteatlas_1.ab'
local zjidx=
{
[0]="第一章",
[1]="第一章",
[2]="第二章",
[3]="第三章",
}
local pointAll=
{

[1000]=0,
[1]=15,[2]=14,[3]=13,[4]=12,[5]=11,[6]=10,[7]=9,[8]=8,[9]=7,[10]=6,[11]=5,[12]=4,[13]=3,[14]=2,[15]=1,
[16]=16,
}
local pointSingle=
{
1,2,3,4,5,6,7,8,9
}
local pointSmall=
{
1,2,3,4,5,6,7,8,9
}
local pointSmall2=
{
[1]=14,[2]=15,[3]=16,[4]=17,[5]=18,[6]=19,[7]=20,[8]=21,[9]=22,
}

local dianicon=
{
[1]="image_sifangpingyao_08",
[2]="image_sifangpingyao_09",
[3]="image_sifangpingyao_06",
[4]="image_sifangpingyao_07",
[5]="image_sifangpingyao_11",
[6]="image_sifangpingyao_10",
}
local dianlien=
{
[1]="frame_sifangpingyao_02",
[2]="frame_sifangpingyao_01",
}
local ab_name="ui/windows/sifangpingyao/sifangpingyao_atlas_pak.ab"

local normalpointh=120
local shoulingpoint=1000
local iconSize=
{
[1]={65,65},
[2]={57,57},
[3]={56,56},
[4]={56,56},
[5]={60,60},
[6]={60,60},
}

local yg_systemid=
{
[1]=174,
[2]=177,
[3]=178,
[4]=179,
[5]=180,
}
local qyeffect=
{
[5]=20369,
[4]=20370,
[3]=20371,
}




function UISiFangPingYaoMainWin:onLoaded(...)
_this=self
self:bindComponents()
self.RoleListPanel:setChildScrollViewInit(0.5,true,function(...)self:onTeamItemClick(...)end,nil)
self.changeBloodtimer={}
notifySystem:listenNotify(notifyConfig.onTYTXZRewardChange,self.onTYTXZRewardChange)
end


function UISiFangPingYaoMainWin:__delete()
notifySystem:removelistener(notifyConfig.onTYTXZRewardChange,self.onTYTXZRewardChange)
self:unbindComponents()
_this=nil
end




function UISiFangPingYaoMainWin:onShow(argtable,afterOnloaded)
self.demons_id=SiFangPingYaoModel:getMapIdex()
self.chapter_id=SiFangPingYaoModel:getZhangjieIdex()

if self.chapter_id==0 then
self.chapter_id=1
end
self.thisresult=0
if argtable then
if argtable.demons_id then
self.demons_id=argtable.demons_id
end
if argtable.chapter_id then
self.chapter_id=argtable.chapter_id
end

self.perfightback=argtable.perfightback
self.perfightgo=argtable.perfightgo
self.qiyuback=argtable.qiyuback
self.thisresult=argtable.thisresult or 0

end
self.TeamHide=false
self.layoutid=0
self.weizhiidx=0
self.selectJDid=0


self.ygcfg=cfg_foursideskilldemonsconfig_get(self.demons_id)
self.ygzjcfg=cfg_foursideskilldemonschapterconfig()


local map_name=self.ygcfg.name or""
local strname=FMT.fmt('离开{0}',map_name)
self.mapname:setText(strname)


local modelid=self.ygcfg.ygimg[2]or 5366
self.bgModel:setChildUIModelShowTarget(modelid,1,{},eAnimationID.stand,false,false,0,function()
local finishlist2=SiFangPingYaoModel:getPointFinishList()
local progress=#finishlist2*0.0023

if deviceHelper.getAPILevel()>=40 then
_this.winlua:SetChildModelAnimationStateWithProgress(_this.bgModel:getID(),eAnimationID.stand,progress,0)
_this.winlua:SetChildUIModelAnimationSpeed(_this.bgModel:getID(),0)
else
_this.bgModel:setChildModelAnimationState(eAnimationID.stand,0,nil)
end
end)

self.jdspine:setChildUIModelShowTarget(5431,1,nil,eAnimationID.stand)
self.jdspine2:setChildUIModelShowTarget(5429,1,nil,eAnimationID.stand)


self:refreshzj(self.chapter_id)

self:refreshfaze(self.demons_id,self.chapter_id)


self:initTeamList()

self:refreshSingledizi()

self:refreshTXZData()



local doing_point_id=SiFangPingYaoModel:getdoingpointid()
if doing_point_id and doing_point_id~=0 then
local allpointlist=self:getzjJinduStrut(self.demons_id,self.chapter_id)
local allpointbuxian=self:getzjJinduBuXian(self.demons_id,self.chapter_id)
self.selectJDid=doing_point_id
self.weizhiidx=allpointbuxian[doing_point_id]
for k,v in ipairs(allpointlist)do
for i,j in ipairs(v)do
if j==doing_point_id then
self.layoutid=k
break
end
end
end

end

if self.perfightback and doing_point_id==0 then
local this_point_id=self.perfightback.this_point_id
if this_point_id then
local allpointlist=self:getzjJinduStrut(self.demons_id,self.chapter_id)
local allpointbuxian=self:getzjJinduBuXian(self.demons_id,self.chapter_id)
self.selectJDid=this_point_id
self.weizhiidx=allpointbuxian[this_point_id]
for k,v in ipairs(allpointlist)do
for i,j in ipairs(v)do
if j==this_point_id then
self.layoutid=k
break
end
end
end

end
end


self:refreshzjjindu()



if doing_point_id and doing_point_id~=0 then
local point_data=SiFangPingYaoController:getPointJiaoHuData(doing_point_id)
local point_type=point_data.point_type
if point_type==sfpyPointType.huifu then













self:showWindow("UISiFangPingYaotiaozhanWin",{parentwin=self,tag=2,this_pointid=doing_point_id})
else
self:delayDo(0.5,function()
if _this==nil then return end
self:dopointidx(doing_point_id)
end)
end
end


if self.perfightback and doing_point_id==0 then
local this_point_id=self.perfightback.this_point_id
if this_point_id then
SiFangPingYaoModel:setdoingpointid(this_point_id)
self:dopointidx(this_point_id)
self.perfightback=nil
end
end



if self.perfightgo and doing_point_id==0 then
local this_point_id=self.perfightgo.this_point_id
if this_point_id then
SiFangPingYaoController.send_34_65(this_point_id)
SiFangPingYaoModel:setTeamChangeRecord(nil)
self.perfightgo=nil
end
end



local seltfz_list=SiFangPingYaoModel:getSeltFZ_list()
if seltfz_list and#seltfz_list>0 then
self:delayDo(0.8,function()
if _this==nil then return end
self:fazeget(seltfz_list)
end)
end



if seltfz_list and#seltfz_list>0 then
else
local choice_bits=SiFangPingYaoModel:getchoice_bits()
local bitflag=bitHelper.check_pos(choice_bits,0)

if bitflag then
self:changefaze()
end
end


if seltfz_list and#seltfz_list>0 then
else
local choice_bits=SiFangPingYaoModel:getchoice_bits()
local bitflag=bitHelper.check_pos(choice_bits,0)

if not bitflag then
if self.chapter_id<3 then
local nowjd=self:getzjNowJindu()
local newjd=self:getzjdangqianJindu(self.demons_id,self.chapter_id)
if nowjd>=newjd then
self:onNextZJ()
end
end
end
end




local dzalldead=true
local list=SiFangPingYaoModel:getDZTeamList()
for k,v in ipairs(list)do
if tonumber(tostring(v.param_1))~=0 then
if tonumber(tostring(v.param_2))>0 then
dzalldead=false
break
end
end
end
local choice_bits=SiFangPingYaoModel:getchoice_bits()
local bitflag=bitHelper.check_pos(choice_bits,1)
local ftresult=SiFangPingYaoModel:getfightresult()

platformSDK.printSDK('sfpymainwinprint1',dzalldead,ftresult,bitflag)
if ftresult==2 or bitflag then


SiFangPingYaoModel:setfightresult(0)
local newbitflag=bitHelper.set_0(choice_bits,1)
SiFangPingYaoModel:setchoice_bits(newbitflag)
local chapter_id=self.chapter_id
if chapter_id==1 then
self:showWindow("UISFPYreFightWin",{parentwin=self,rechallenge=1,iscanClose=true,flag=2,chapter_id=self.chapter_id})
else
self:showWindow("UISFPYresetWin",{parentwin=self,reflag=1,chapter_id=self.chapter_id})
end
end


self:delayDo(1,function()
if _this==nil then return end
local ygzjlist=userActorArraySetting.get(ACTOR_SETTING_TYPE.eSiFangPingYao,'ygzjlist',nil)
if ygzjlist then

local flag=ygzjlist[self.demons_id][self.chapter_id]
if flag==0 then

local checkOpen=SiFangPingYaoController:checkOpen(yg_systemid[self.demons_id])

if checkOpen then
UIManager:showWindow("UISiFangPingYaoOpenWin",{flag=2,infoidx=self.demons_id,infoidx2=self.chapter_id})
ygzjlist[self.demons_id][self.chapter_id]=1
userActorArraySetting.set(ACTOR_SETTING_TYPE.eSiFangPingYao,'ygzjlist',ygzjlist)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eSiFangPingYao)
end
end
end
end)

end


function UISiFangPingYaoMainWin:onNextZJ()
local nowjd=_this:getzjNowJindu()
local alljd=_this:getzjdangqianJindu(_this.demons_id,_this.chapter_id)

if nowjd>=alljd and _this.chapter_id<3 then
SiFangPingYaoController.send_34_66()
end
end


function UISiFangPingYaoMainWin:onRefreshInfo()
UIManager:closeWindow("UISiFangPingYaotiaozhanWin")

self.demons_id=SiFangPingYaoModel:getMapIdex()
self.chapter_id=SiFangPingYaoModel:getZhangjieIdex()

self:refreshzj(self.chapter_id)
self:refreshfaze(self.demons_id,self.chapter_id)

self.layoutid=0
self.weizhiidx=0
self.selectJDid=0


self:refreshfaze(self.demons_id,self.chapter_id)
self:refreshzjjindu()
end


function UISiFangPingYaoMainWin:openNewZhangjiewin()


self:delayDo(0.2,function()
if _this==nil then return end
local ygzjlist=userActorArraySetting.get(ACTOR_SETTING_TYPE.eSiFangPingYao,'ygzjlist',nil)
if ygzjlist then

local flag=ygzjlist[self.demons_id][self.chapter_id]
if flag==0 then

local checkOpen=SiFangPingYaoController:checkOpen(yg_systemid[self.demons_id])

if checkOpen then
UIManager:showWindow("UISiFangPingYaoOpenWin",{flag=2,infoidx=self.demons_id,infoidx2=self.chapter_id})
ygzjlist[self.demons_id][self.chapter_id]=1
userActorArraySetting.set(ACTOR_SETTING_TYPE.eSiFangPingYao,'ygzjlist',ygzjlist)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eSiFangPingYao)
end
end
end
end)
end


function UISiFangPingYaoMainWin:openTGZhangjiewin()
local tgflag=SiFangPingYaoModel:gettgflag()

if tgflag and tgflag==1 then
local demons_id=SiFangPingYaoModel:getMapIdex()
local cfg=cfg_foursideskilldemonsconfig_get(demons_id)
local specialtBoard=cfg.specialtBoard

local fun2=function()

self:delayDo(0.2,function()
if _this==nil then return end
self.tgeffect:setChildShowEffect(0,false)
self.tgeffect:setChildShowEffect(20367,true)
end)

self:delayDo(2,function()
if _this==nil then return end
self.tgeffect:setChildShowEffect(0,false)
local nextygid=self.demons_id+1
self:showWindow("UISFPYtongguanWin",{thisygid=self.demons_id,nextygid=nextygid})
end)
end
local call=function()

local flag=userActorArraySetting.get(ACTOR_SETTING_TYPE.eSiFangPingYao,'sfpytgarry',nil)
if specialtBoard and flag and flag[demons_id]and flag[demons_id]==0 then
if specialtBoard~=0 then
local args={groupid=specialtBoard,callback=fun2,isFullOpen=false}
gameplotController:showPlotBoard(args)
end
else
fun2()
end
end
local plotBoardid=SiFangPingYaoModel:getplotBoardback()
if plotBoardid~=0 then
local args={groupid=plotBoardid,callback=call,isFullOpen=false}
gameplotController:showPlotBoard(args)
end
end
end


function UISiFangPingYaoMainWin:onShowArgRecv(argtable)
UIManager:closeWindow("UISiFangPingYaotiaozhanWin")
self.demons_id=SiFangPingYaoModel:getMapIdex()
self.chapter_id=SiFangPingYaoModel:getZhangjieIdex()
self:refreshzj(self.chapter_id)
self:refreshfaze(self.demons_id,self.chapter_id)


self.layoutid=0
self.weizhiidx=0
self.selectJDid=0

self.dhMask:setActive(false)


local doing_point_id=SiFangPingYaoModel:getdoingpointid()
if doing_point_id and doing_point_id~=0 then
local allpointlist=self:getzjJinduStrut(self.demons_id,self.chapter_id)
local allpointbuxian=self:getzjJinduBuXian(self.demons_id,self.chapter_id)
self.selectJDid=doing_point_id
self.weizhiidx=allpointbuxian[doing_point_id]
for k,v in ipairs(allpointlist)do
for i,j in ipairs(v)do
if j==doing_point_id then
self.layoutid=k
break
end
end
end

end

if self.perfightback and doing_point_id==0 then
local this_point_id=self.perfightback.this_point_id
if this_point_id then
local allpointlist=self:getzjJinduStrut(self.demons_id,self.chapter_id)
local allpointbuxian=self:getzjJinduBuXian(self.demons_id,self.chapter_id)
self.selectJDid=this_point_id
self.weizhiidx=allpointbuxian[this_point_id]
for k,v in ipairs(allpointlist)do
for i,j in ipairs(v)do
if j==this_point_id then
self.layoutid=k
break
end
end
end

end
end


self:refreshzjjindu()

if argtable and argtable.isqiehuan then
self:qiehuanpoint()
end


local seltfz_list=SiFangPingYaoModel:getSeltFZ_list()
if seltfz_list and#seltfz_list>0 then
else
local choice_bits=SiFangPingYaoModel:getchoice_bits()
local bitflag=bitHelper.check_pos(choice_bits,0)

if bitflag then
self:changefaze()
end
end

local dzalldead=true
local list=SiFangPingYaoModel:getDZTeamList()
for k,v in ipairs(list)do
if tonumber(tostring(v.param_1))~=0 then
if tonumber(tostring(v.param_2))>0 then
dzalldead=false
break
end
end
end
local choice_bits=SiFangPingYaoModel:getchoice_bits()
local bitflag=bitHelper.check_pos(choice_bits,1)
local ftresult=SiFangPingYaoModel:getfightresult()
platformSDK.printSDK('sfpymainwinprint2',dzalldead,ftresult,bitflag)
if ftresult==2 or bitflag then


SiFangPingYaoModel:setfightresult(0)
local newbitflag=bitHelper.set_0(choice_bits,1)
SiFangPingYaoModel:setchoice_bits(newbitflag)
local chapter_id=self.chapter_id
if chapter_id==1 then
self:showWindow("UISFPYreFightWin",{parentwin=self,rechallenge=1,iscanClose=true,flag=2,chapter_id=self.chapter_id})
else
self:showWindow("UISFPYresetWin",{parentwin=self,reflag=1,chapter_id=self.chapter_id})
end
end
end


function UISiFangPingYaoMainWin:reshauxinspine()
local demons_id=SiFangPingYaoModel:getMapIdex()
local ygcfg=cfg_foursideskilldemonsconfig_get(demons_id)

local modelid=ygcfg.ygimg[2]or 5366
_this.bgModel:setChildUIModelShowTarget(modelid,1,{},eAnimationID.stand,false,false,0,function()
if deviceHelper.getAPILevel()>=40 then
_this.winlua:SetChildUIModelAnimationSpeed(_this.bgModel:getID(),0)
else
_this.bgModel:setChildModelAnimationState(eAnimationID.stand,0,nil)
end
end)
end


function UISiFangPingYaoMainWin:qiehuanpoint()
local doing_point_id=SiFangPingYaoModel:getdoingpointid()

if doing_point_id and doing_point_id~=0 then
local point_data=SiFangPingYaoController:getPointJiaoHuData(doing_point_id)
local point_type=point_data.point_type
if point_type==sfpyPointType.huifu then













self:showWindow("UISiFangPingYaotiaozhanWin",{parentwin=self,tag=2,this_pointid=doing_point_id})
else
self:delayDo(0.5,function()
if _this==nil then return end
self:dopointidx(doing_point_id)
end)
end
end
end


function UISiFangPingYaoMainWin:onHide()

self.pointScroller:setActive(false)
end


function UISiFangPingYaoMainWin:refreshzj(chapter_id)
_this.wingDir:setText(zjidx[chapter_id])
end


function UISiFangPingYaoMainWin:refreshfaze(demons_id,chapter_id)
local ygzj_cfg=cfg_foursideskilldemonschapterconfig_get(demons_id)[chapter_id]
local faze_list=ygzj_cfg.faze_list2
local fazeData=faze_list[1]or{}
_this:showfazeSkill(fazeData)
end

function UISiFangPingYaoMainWin:showfazeSkill(fazeData)
local txParam=fazeData
local fazeID=txParam[1]
local fazeCfg=cfgHelper.getSSlawRule(fazeID)
local icon=fazeCfg.image
_this.skillIcon:setImageIcon(icon,false)
end


function UISiFangPingYaoMainWin:initTeamList()
self.probeTeam=SiFangPingYaoModel:getDZTeamList()or{}
local dzlist=SiFangPingYaoController:getzhanweilist(self.probeTeam)
local teamSize=#dzlist

if teamSize>0 then
self.RoleListPanel:setChildScrollViewCreateGrids(teamSize,teamSize)
local grids=self.RoleListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local guiddata=dzlist[i]
local guid=guiddata.param_1
local blood=tonumber(tostring(guiddata.param_2))
local item=grids[i-1]

item:SetChildProgress(2,blood,10000)

item:SetChildText(0,UIDiscipleModel:getDiscipleName(guid))
item:SetChildActive(2,true)

local imageInfo=UIDiscipleModel:getDiscipleInsideModelInfo(guid)
local headCenter=cfgHelper.get2(cfg_dbbodyconfig_get,imageInfo.body,'headCenter')or{}
local head=headCenter[eHeadCenterType.eHead]
imageInfo.headCenter={head[1],head[2]-20,head[3]}
comHelper.setChildModelRawImageEx(3,item,imageInfo,0,nil,blood<=0)

if UIDiscipleModel:checkInjuryType(guid,eInjuryType.eHealth)then
item:SetChildActive(8,false)
else
item:SetChildActive(8,true)
local injury=UIDiscipleModel:getDiscipleInjury(guid)
local injury_icon=eInjuryType:getIcon(injury)
item:SetChildCSImageSprite(5,globalab,injury_icon)
end
item:SetChildActive(12,false)

if blood<=0 then
local emotList=cfgHelper.get2(cfg_secretscenebaseconfig_get,1,"deadFace")
local emot=emotList[math.random(1,#emotList)]
item:SetChildActive(6,true)
item:SetChildUIModelShowTarget(6,emot,1,{},eAnimationID.stand)
else
item:SetChildActive(6,false)
end
end
end


local fhflag=SiFangPingYaoModel:getdizifhflag()
if fhflag then
SiFangPingYaoModel:setdizifhflag(nil)
self:showfuhuotxt()
end

self:refreshjlreddot()
end

function UISiFangPingYaoMainWin:showfuhuotxt()
local txtarry=SiFangPingYaoModel:getdizifhtxt()
if txtarry and#txtarry>0 then
local delay=0.1
for k,v in ipairs(txtarry)do
_this:delayDo(delay,function()
UIManager.info(v)
end)
delay=delay+0.15
end
SiFangPingYaoModel:setdizifhtxt(nil)
end
end


function UISiFangPingYaoMainWin:refreshSingledizi()
if self.probeTeam then
local dzlist=SiFangPingYaoController:getzhanweilist(self.probeTeam)
local teamSize=#dzlist
if teamSize>0 then
local guiddata=dzlist[1]
for k,v in ipairs(dzlist)do
local blood=tonumber(tostring(v.param_2))
if blood>0 then
guiddata=v
break
end
end

local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(guiddata.param_1,false,1)
local scale=1
local boold=tonumber(tostring(guiddata.param_2))
if boold<=0 then
local sex=UIDiscipleModel:getDiscipleSex(guiddata.param_1)
modelParams.body=sex==1 and 1114103 or 1114104
modelParams.componets=nil
scale=1.8
end
_this.winlua:SetChildUIModelShowTarget(_this.diziModel:getID(),modelParams.body,scale,modelParams.componets,eAnimationID.stand)
_this.winlua:SetChildUIModelShowFlipX(_this.diziModel:getID(),true)
end
end
end


function UISiFangPingYaoMainWin:showTeamEffect(index,effectId)
local grid=self.RoleListPanel:getChildScrollViewItemWidget(index-1)
if grid then
grid:SetChildShowEffect(13,effectId,true)
end
end


function UISiFangPingYaoMainWin:bloodChange(index,value,isRelive)
if _this.changeBloodtimer[index]then
return
end
if index then
local grid=_this.RoleListPanel:getChildScrollViewItemWidget(index-1)
if grid then
if value>0 then
_this.changeBloodTween=grid:SetChildDOLocalMoveY(7,85,1,nil)
_this:showTeamEffect(index,10099)
else
_this.changeBloodTween=grid:SetChildDOLocalMoveY(7,65,1,nil)
end
if not isRelive then
local str=_this.converNum(value)
grid:SetChildText(7,str)
grid:SetChildLocalPosY(7,72)
grid:SetChildCanvasGroupDOFade(7,1,0.1,nil)
local func=function()
if _this and not _this.isClose then
if _this.changeBloodTween~=nil then
_this.changeBloodTween:Complete()
_this.changeBloodTween=nil
end
_this.changeBloodTween=grid:SetChildCanvasGroupDOFade(7,0,0.2,nil)
end
_this.changeBloodtimer[index]=nil
end
if _this and not _this.isClose then
_this.changeBloodtimer[index]=timer.new()
_this.changeBloodtimer[index]:start(1,function()
if _this and not _this.isClose then
func()
end
end,1)
end
end
end
end
end
local charMap={['0']='A',['1']='B',['2']='C',['3']='D',['4']='E',['5']='F',['6']='G',['7']='H',['8']='I',['9']='J',['%']='K'}
function UISiFangPingYaoMainWin.converNum(num)
local str=''
local isAdd=false
if num>0 then
isAdd=true
str='+'
end
local row=math.ceil(num/100)
local numStr=tostring(row)
local len=string.len(numStr)
for i=1,len do
local n=string.sub(numStr,i,i)
if isAdd then
local c=charMap[n]
if c~=nil then
str=str..c
else
str=str..n
end
else
str=str..n
end
end


if num<0 then
str=FMT.fmt('-{0}%',math.abs(num/100))
end
if num>0 then
str=str..'K'
end

return str
end


function UISiFangPingYaoMainWin:onTeamItemClick(id,index)
self.probeTeam=SiFangPingYaoModel:getDZTeamList()or{}
local dzlist=SiFangPingYaoController:getzhanweilist(self.probeTeam)
local teamSize=#dzlist
local discipleList={}

if teamSize>0 then
local guiddata=dzlist[index+1]
if guiddata and guiddata.param_1 then
for k,v in ipairs(dzlist)do
table.insert(discipleList,UIDiscipleModel:getDiscipleDataX(v.param_1))
end
if#discipleList>0 then
local closeCallback=function()
UIFullSiFangPingYaoControl:showSiFangPingYaoMainWin()
end
UIFullDiscipleMainControl:showWindowInfo({dis_guid=guiddata.param_1,disciplelist=discipleList})
if closeCallback then
fullScreenUI.setNextActiveUICallback(closeCallback)
end
end
end
end
end


function UISiFangPingYaoMainWin:refreshbtntxt()

local all_yg_jd=0
for i=1,5 do
all_yg_jd=all_yg_jd+SiFangPingYaoController:getzjdqallJindu(i)
end

local txzcfg=cfgHelper.get1(cfg_passportconfig_get,3)
local demons_rewards=txzcfg.target_rewards
local thisgk=0
local maxjd=0
for k,v in ipairs(demons_rewards)do
if all_yg_jd>=v[1]then
thisgk=k
end
end
local nexgk=thisgk+1
if demons_rewards[nexgk]then
maxjd=demons_rewards[nexgk][1]
else
maxjd=demons_rewards[thisgk][1]
end
self.jljdnowtxt2:setText(FMT.fmt('{0}/<color=#aae252>{1}关</color>',all_yg_jd,maxjd))
end


function UISiFangPingYaoMainWin:clearjindu()
local widget=self.pointItem:getWidgetBase()
for i=0,14 do
if i==0 then
widget:SetChildActive(pointAll[shoulingpoint],false)
local pointSjitem=widget:GetChildWidgetBase(pointAll[shoulingpoint])
pointSjitem:SetChildActive(7,false)
pointSjitem:SetChildIconFillAmount(7,0)
else
widget:SetChildActive(pointAll[i],false)
local pointSjitem=widget:GetChildWidgetBase(pointAll[i])
pointSjitem:SetChildCanvasGroupAlpha(12,1)
pointSjitem:SetChildActive(10,false)
for j=1,9 do
pointSjitem:SetChildActive(pointSingle[j],false)
local pointitem_1=pointSjitem:GetChildWidgetBase(pointSingle[j])
pointitem_1:SetChildDOTweenAnimation_DOPause(10)
pointitem_1:SetChildScale(10,Vector3.New(1,1,1))
pointitem_1:SetChildActive(11,false)
pointitem_1:SetChildCSImageSprite(10,ab_name,"image_sifangpingyao_04")
for k=1,9 do
pointitem_1:SetChildActive(pointSmall[k],false)
pointitem_1:SetChildActive(pointSmall2[k],false)
pointitem_1:SetChildIconFillAmount(pointSmall2[k],0)
end
end
end
end
end


function UISiFangPingYaoMainWin:refreshzjjindu()
self.chapter_id=SiFangPingYaoModel:getZhangjieIdex()
if self.chapter_id==0 then
self.chapter_id=1
end

if self.selectJDid==0 then
local doing_point_id=SiFangPingYaoModel:getdoingpointid()
if doing_point_id and doing_point_id==0 then
self:isshowluxian(true)
end
end
self:clearjindu()
local ygzj_cfg=cfg_foursideskilldemonschapterconfig_get(self.demons_id)[self.chapter_id]
local islastzj=false
self.ytgimg:setActive(false)
local alljd=self:getzjAllJindu(self.demons_id,self.chapter_id)
local nowjd=self:getzjNowJindu()
local str=FMT.fmt('总通关进度: {0}/{1}',nowjd,alljd)
if self.chapter_id>1 then
local num=self.chapter_id-1
local newjd=self:getzjdangqianJindu(self.demons_id,self.chapter_id)
local nowalljd=nowjd+(newjd*num)
str=FMT.fmt('总通关进度: {0}/{1}',nowalljd,alljd)
if nowalljd>=alljd then
islastzj=true
self.ytgimg:setActive(true)
self:isshowluxian(false)
self:openTGZhangjiewin()
end
end
self.tgjdtxt:setText(str)
self:refreshbtntxt()


local widget=self.pointItem:getWidgetBase()
self.allpointlist=self:getzjJinduStrut(self.demons_id,self.chapter_id)
self.allpointbuxian=self:getzjJinduBuXian(self.demons_id,self.chapter_id)
local allpointdata=SiFangPingYaoModel:getPointList()
local finishlist=SiFangPingYaoModel:getPointFinishFlagList()
local finishlist2=SiFangPingYaoModel:getPointFinishList()
local layout=#finishlist2





local seltfz_list=SiFangPingYaoModel:getSeltFZ_list()
local isyaowang=false
self.pointScroller:setActive(true)
for k,v in ipairs(self.allpointlist)do
local data=v

if data[1]==shoulingpoint and self.chapter_id==3 then
isyaowang=true
local pointid_1=data[1]
widget:SetChildActive(pointAll[shoulingpoint],true)
local pointSjitem=widget:GetChildWidgetBase(pointAll[shoulingpoint])
if self.demons_id==SiFangPingYaoController.sfpyWuYgid then
if k>1 then
if k>layout+1 then
pointSjitem:SetChildCanvasGroupAlpha(1,0)
pointSjitem:SetChildActive(5,true)
else
local wuyaoguo=SiFangPingYaoModel:getwuyaoguo()

if#wuyaoguo>0 and wuyaoguo[1]~=0 and k>wuyaoguo[1]then
pointSjitem:SetChildCanvasGroupAlpha(1,0)
pointSjitem:SetChildActive(5,false)
end
end
end
end

local bossimg=ygzj_cfg.bossimg
if bossimg then
pointSjitem:SetChildActive(3,true)
pointSjitem:SetChildCSImageSprite(3,ab_name,bossimg)
if islastzj then
pointSjitem:SetChildActive(4,true)
end
end
pointSjitem:SetChildActive(2,true)
local isfinish=finishlist[pointid_1]
if isfinish then
pointSjitem:SetChildActive(7,true)
pointSjitem:SetChildIconFillAmount(7,1)

end


pointSjitem:SetChildButtonClick(3,function()
self:onClickShow(k,pointid_1,5)
end)
else
widget:SetChildActive(pointAll[k],true)
local pointSjitem=widget:GetChildWidgetBase(pointAll[k])
if self.demons_id==SiFangPingYaoController.sfpyWuYgid then
if k>1 then
if k>layout+1 then
pointSjitem:SetChildCanvasGroupAlpha(12,0)
pointSjitem:SetChildActive(10,true)
else
local wuyaoguo=SiFangPingYaoModel:getwuyaoguo()

if#wuyaoguo>0 and wuyaoguo[1]~=0 and k>wuyaoguo[1]then
pointSjitem:SetChildCanvasGroupAlpha(12,0)
pointSjitem:SetChildActive(10,true)
end
end
end
end

if#data==1 then

local pointid_1=data[1]
local weizhiidx=self.allpointbuxian[pointid_1]
pointSjitem:SetChildActive(pointSingle[weizhiidx],true)
local pointitem_1=pointSjitem:GetChildWidgetBase(pointSingle[weizhiidx])


local point_data=SiFangPingYaoController:getPointJiaoHuData(pointid_1)
local point_type=point_data.point_type
pointitem_1:SetChildCSImageSprite(13,ab_name,dianicon[point_type])
local Size=iconSize[point_type]
pointitem_1:SetChildSizeDelta(13,Size[1],Size[2])


local buxiantable=self:getJieDianQZ(self.demons_id,self.chapter_id,pointid_1)
for k_,v_ in ipairs(buxiantable)do
local weizhi=self.allpointbuxian[v_]
if v_==0 then weizhi=5 end
pointitem_1:SetChildActive(pointSmall[weizhi],true)
local isfinish=self:getiscolorline(v_,finishlist[pointid_1],finishlist[v_])
self:Animalines(isfinish,weizhi,pointitem_1,pointid_1,k,weizhiidx)
end


local _data=SiFangPingYaoModel:gettwofinishlinepoid()
if _data and#_data>0 then
else
if finishlist[pointid_1]then
_this:delayDo(0.3,function()
if _this==nil then return end
pointitem_1:SetChildCSImageSprite(10,ab_name,"image_sifangpingyao_05")
end)
end
end

pointitem_1:SetChildActive(11,self.selectJDid==pointid_1)


if k==layout+1 then
local iswalk=self:checkifTank(self.demons_id,self.chapter_id,pointid_1,k)
if self.selectJDid~=pointid_1 and iswalk then
pointitem_1:SetChildScale(10,Vector3.New(1,1,1))
pointitem_1:SetChildDOTweenAnimation_DOPlay(10)
end
end


pointitem_1:SetChildButtonClick(10,function()
self:onClickShow(k,pointid_1,weizhiidx)
end)

elseif#data==2 then
local pointid_1=data[1]
local weizhiidx1=self.allpointbuxian[pointid_1]
local pointid_2=data[2]
local weizhiidx2=self.allpointbuxian[pointid_2]
pointSjitem:SetChildActive(pointSingle[weizhiidx1],true)
pointSjitem:SetChildActive(pointSingle[weizhiidx2],true)
local pointitem_1=pointSjitem:GetChildWidgetBase(pointSingle[weizhiidx1])
local pointitem_2=pointSjitem:GetChildWidgetBase(pointSingle[weizhiidx2])


local point_data1=SiFangPingYaoController:getPointJiaoHuData(pointid_1)
local point_type1=point_data1.point_type
pointitem_1:SetChildCSImageSprite(13,ab_name,dianicon[point_type1])
local Size1=iconSize[point_type1]
pointitem_1:SetChildSizeDelta(13,Size1[1],Size1[2])
local point_data2=SiFangPingYaoController:getPointJiaoHuData(pointid_2)
local point_type2=point_data2.point_type
pointitem_2:SetChildCSImageSprite(13,ab_name,dianicon[point_type2])
local Size2=iconSize[point_type2]
pointitem_2:SetChildSizeDelta(13,Size2[1],Size2[2])


local buxiantable1=self:getJieDianQZ(self.demons_id,self.chapter_id,pointid_1)
for k_,v_ in ipairs(buxiantable1)do
local weizhi=self.allpointbuxian[v_]
if v_==0 then weizhi=5 end
pointitem_1:SetChildActive(pointSmall[weizhi],true)
local isfinish=self:getiscolorline(v_,finishlist[pointid_1],finishlist[v_])
self:Animalines(isfinish,weizhi,pointitem_1,pointid_1,k,weizhiidx1)
end
local buxiantable2=self:getJieDianQZ(self.demons_id,self.chapter_id,pointid_2)
for k_,v_ in ipairs(buxiantable2)do
local weizhi=self.allpointbuxian[v_]
if v_==0 then weizhi=5 end
pointitem_2:SetChildActive(pointSmall[weizhi],true)
local isfinish=self:getiscolorline(v_,finishlist[pointid_2],finishlist[v_])
self:Animalines(isfinish,weizhi,pointitem_2,pointid_2,k,weizhiidx2)
end


local _data=SiFangPingYaoModel:gettwofinishlinepoid()
if _data and#_data>0 then
else
if finishlist[pointid_1]then
_this:delayDo(0.3,function()
pointitem_1:SetChildCSImageSprite(10,ab_name,"image_sifangpingyao_05")
end)
end
if finishlist[pointid_2]then
_this:delayDo(0.3,function()
pointitem_2:SetChildCSImageSprite(10,ab_name,"image_sifangpingyao_05")
end)
end
end


pointitem_1:SetChildActive(11,self.selectJDid==pointid_1)
pointitem_2:SetChildActive(11,self.selectJDid==pointid_2)

if k==layout+1 then
local iswalk1=self:checkifTank(self.demons_id,self.chapter_id,pointid_1,k)
if self.selectJDid~=pointid_1 and iswalk1 then
pointitem_1:SetChildScale(10,Vector3.New(1,1,1))
pointitem_1:SetChildDOTweenAnimation_DOPlay(10)
end
local iswalk2=self:checkifTank(self.demons_id,self.chapter_id,pointid_2,k)
if self.selectJDid~=pointid_2 and iswalk2 then
pointitem_2:SetChildScale(10,Vector3.New(1,1,1))
pointitem_2:SetChildDOTweenAnimation_DOPlay(10)
end

end

pointitem_1:SetChildButtonClick(10,function()
self:onClickShow(k,pointid_1,weizhiidx1)
end)
pointitem_2:SetChildButtonClick(10,function()
self:onClickShow(k,pointid_2,weizhiidx2)
end)

elseif#data==3 then
local pointid_1=data[1]
local weizhiidx1=self.allpointbuxian[pointid_1]
local pointid_2=data[2]
local weizhiidx2=self.allpointbuxian[pointid_2]
local pointid_3=data[3]
local weizhiidx3=self.allpointbuxian[pointid_3]

pointSjitem:SetChildActive(pointSingle[weizhiidx1],true)
pointSjitem:SetChildActive(pointSingle[weizhiidx2],true)
pointSjitem:SetChildActive(pointSingle[weizhiidx3],true)
local pointitem_1=pointSjitem:GetChildWidgetBase(pointSingle[weizhiidx1])
local pointitem_2=pointSjitem:GetChildWidgetBase(pointSingle[weizhiidx2])
local pointitem_3=pointSjitem:GetChildWidgetBase(pointSingle[weizhiidx3])


local point_data1=SiFangPingYaoController:getPointJiaoHuData(pointid_1)
local point_type1=point_data1.point_type
pointitem_1:SetChildCSImageSprite(13,ab_name,dianicon[point_type1])
local Size1=iconSize[point_type1]
pointitem_1:SetChildSizeDelta(13,Size1[1],Size1[2])
local point_data2=SiFangPingYaoController:getPointJiaoHuData(pointid_2)
local point_type2=point_data2.point_type
pointitem_2:SetChildCSImageSprite(13,ab_name,dianicon[point_type2])
local Size2=iconSize[point_type2]
pointitem_2:SetChildSizeDelta(13,Size2[1],Size2[2])
local point_data3=SiFangPingYaoController:getPointJiaoHuData(pointid_3)
local point_type3=point_data3.point_type
pointitem_3:SetChildCSImageSprite(13,ab_name,dianicon[point_type3])
local Size3=iconSize[point_type3]
pointitem_3:SetChildSizeDelta(13,Size3[1],Size3[2])


local buxiantable1=self:getJieDianQZ(self.demons_id,self.chapter_id,pointid_1)
for k_,v_ in ipairs(buxiantable1)do
local weizhi=self.allpointbuxian[v_]
if v_==0 then weizhi=5 end
pointitem_1:SetChildActive(pointSmall[weizhi],true)
local isfinish=self:getiscolorline(v_,finishlist[pointid_1],finishlist[v_])
self:Animalines(isfinish,weizhi,pointitem_1,pointid_1,k,weizhiidx1)
end
local buxiantable2=self:getJieDianQZ(self.demons_id,self.chapter_id,pointid_2)
for k_,v_ in ipairs(buxiantable2)do
local weizhi=self.allpointbuxian[v_]
if v_==0 then weizhi=5 end
pointitem_2:SetChildActive(pointSmall[weizhi],true)
local isfinish=self:getiscolorline(v_,finishlist[pointid_2],finishlist[v_])
self:Animalines(isfinish,weizhi,pointitem_2,pointid_2,k,weizhiidx2)
end
local buxiantable3=self:getJieDianQZ(self.demons_id,self.chapter_id,pointid_3)
for k_,v_ in ipairs(buxiantable3)do
local weizhi=self.allpointbuxian[v_]
if v_==0 then weizhi=5 end
pointitem_3:SetChildActive(pointSmall[weizhi],true)
local isfinish=self:getiscolorline(v_,finishlist[pointid_3],finishlist[v_])
self:Animalines(isfinish,weizhi,pointitem_3,pointid_3,k,weizhiidx3)
end


local _data=SiFangPingYaoModel:gettwofinishlinepoid()
if _data and#_data>0 then
else
if finishlist[pointid_1]then
_this:delayDo(0.3,function()
pointitem_1:SetChildCSImageSprite(10,ab_name,"image_sifangpingyao_05")
end)
end
if finishlist[pointid_2]then
_this:delayDo(0.3,function()
pointitem_2:SetChildCSImageSprite(10,ab_name,"image_sifangpingyao_05")
end)
end
if finishlist[pointid_3]then
_this:delayDo(0.3,function()
pointitem_3:SetChildCSImageSprite(10,ab_name,"image_sifangpingyao_05")
end)
end
end


pointitem_1:SetChildActive(11,self.selectJDid==pointid_1)
pointitem_2:SetChildActive(11,self.selectJDid==pointid_2)
pointitem_3:SetChildActive(11,self.selectJDid==pointid_3)

if k==layout+1 then
local iswalk1=self:checkifTank(self.demons_id,self.chapter_id,pointid_1,k)
if self.selectJDid~=pointid_1 and iswalk1 then
pointitem_1:SetChildScale(10,Vector3.New(1,1,1))
pointitem_1:SetChildDOTweenAnimation_DOPlay(10)
end
local iswalk2=self:checkifTank(self.demons_id,self.chapter_id,pointid_2,k)
if self.selectJDid~=pointid_2 and iswalk2 then
pointitem_2:SetChildScale(10,Vector3.New(1,1,1))
pointitem_2:SetChildDOTweenAnimation_DOPlay(10)
end
local iswalk3=self:checkifTank(self.demons_id,self.chapter_id,pointid_3,k)
if self.selectJDid~=pointid_3 and iswalk3 then
pointitem_3:SetChildScale(10,Vector3.New(1,1,1))
pointitem_3:SetChildDOTweenAnimation_DOPlay(10)
end
end

pointitem_1:SetChildButtonClick(10,function()
self:onClickShow(k,pointid_1,weizhiidx1)
end)
pointitem_2:SetChildButtonClick(10,function()
self:onClickShow(k,pointid_2,weizhiidx2)
end)
pointitem_3:SetChildButtonClick(10,function()
self:onClickShow(k,pointid_3,weizhiidx3)
end)

elseif#data==4 then
local pointid_1=data[1]
local weizhiidx1=self.allpointbuxian[pointid_1]
local pointid_2=data[2]
local weizhiidx2=self.allpointbuxian[pointid_2]
local pointid_3=data[3]
local weizhiidx3=self.allpointbuxian[pointid_3]
local pointid_4=data[4]
local weizhiidx4=self.allpointbuxian[pointid_4]


pointSjitem:SetChildActive(pointSingle[weizhiidx1],true)
pointSjitem:SetChildActive(pointSingle[weizhiidx2],true)
pointSjitem:SetChildActive(pointSingle[weizhiidx3],true)
pointSjitem:SetChildActive(pointSingle[weizhiidx4],true)
local pointitem_1=pointSjitem:GetChildWidgetBase(pointSingle[weizhiidx1])
local pointitem_2=pointSjitem:GetChildWidgetBase(pointSingle[weizhiidx2])
local pointitem_3=pointSjitem:GetChildWidgetBase(pointSingle[weizhiidx3])
local pointitem_4=pointSjitem:GetChildWidgetBase(pointSingle[weizhiidx4])


local point_data1=SiFangPingYaoController:getPointJiaoHuData(pointid_1)
local point_type1=point_data1.point_type
pointitem_1:SetChildCSImageSprite(13,ab_name,dianicon[point_type1])
local Size1=iconSize[point_type1]
pointitem_1:SetChildSizeDelta(13,Size1[1],Size1[2])
local point_data2=SiFangPingYaoController:getPointJiaoHuData(pointid_2)
local point_type2=point_data2.point_type
pointitem_2:SetChildCSImageSprite(13,ab_name,dianicon[point_type2])
local Size2=iconSize[point_type2]
pointitem_2:SetChildSizeDelta(13,Size2[1],Size2[2])
local point_data3=SiFangPingYaoController:getPointJiaoHuData(pointid_3)
local point_type3=point_data3.point_type
pointitem_3:SetChildCSImageSprite(13,ab_name,dianicon[point_type3])
local Size3=iconSize[point_type3]
pointitem_3:SetChildSizeDelta(13,Size3[1],Size3[2])
local point_data4=SiFangPingYaoController:getPointJiaoHuData(pointid_4)
local point_type4=point_data4.point_type
pointitem_4:SetChildCSImageSprite(13,ab_name,dianicon[point_type4])
local Size4=iconSize[point_type4]
pointitem_4:SetChildSizeDelta(13,Size4[1],Size4[2])


local buxiantable1=self:getJieDianQZ(self.demons_id,self.chapter_id,pointid_1)
for k_,v_ in ipairs(buxiantable1)do
local weizhi=self.allpointbuxian[v_]
if v_==0 then weizhi=5 end
pointitem_1:SetChildActive(pointSmall[weizhi],true)
local isfinish=self:getiscolorline(v_,finishlist[pointid_1],finishlist[v_])
self:Animalines(isfinish,weizhi,pointitem_1,pointid_1,k,weizhiidx1)
end
local buxiantable2=self:getJieDianQZ(self.demons_id,self.chapter_id,pointid_2)
for k_,v_ in ipairs(buxiantable2)do
local weizhi=self.allpointbuxian[v_]
if v_==0 then weizhi=5 end
pointitem_2:SetChildActive(pointSmall[weizhi],true)
local isfinish=self:getiscolorline(v_,finishlist[pointid_2],finishlist[v_])
self:Animalines(isfinish,weizhi,pointitem_2,pointid_2,k,weizhiidx2)
end
local buxiantable3=self:getJieDianQZ(self.demons_id,self.chapter_id,pointid_3)
for k_,v_ in ipairs(buxiantable3)do
local weizhi=self.allpointbuxian[v_]
if v_==0 then weizhi=5 end
pointitem_3:SetChildActive(pointSmall[weizhi],true)
local isfinish=self:getiscolorline(v_,finishlist[pointid_3],finishlist[v_])
self:Animalines(isfinish,weizhi,pointitem_3,pointid_3,k,weizhiidx3)
end
local buxiantable4=self:getJieDianQZ(self.demons_id,self.chapter_id,pointid_4)
for k_,v_ in ipairs(buxiantable4)do
local weizhi=self.allpointbuxian[v_]
if v_==0 then weizhi=5 end
pointitem_4:SetChildActive(pointSmall[weizhi],true)
local isfinish=self:getiscolorline(v_,finishlist[pointid_4],finishlist[v_])
self:Animalines(isfinish,weizhi,pointitem_4,pointid_4,k,weizhiidx4)
end


local _data=SiFangPingYaoModel:gettwofinishlinepoid()
if _data and#_data>0 then
else
if finishlist[pointid_1]then
_this:delayDo(0.3,function()
pointitem_1:SetChildCSImageSprite(10,ab_name,"image_sifangpingyao_05")
end)
end
if finishlist[pointid_2]then
_this:delayDo(0.3,function()
pointitem_2:SetChildCSImageSprite(10,ab_name,"image_sifangpingyao_05")
end)
end
if finishlist[pointid_3]then
_this:delayDo(0.3,function()
pointitem_3:SetChildCSImageSprite(10,ab_name,"image_sifangpingyao_05")
end)
end
if finishlist[pointid_4]then
_this:delayDo(0.3,function()
pointitem_4:SetChildCSImageSprite(10,ab_name,"image_sifangpingyao_05")
end)
end
end


pointitem_1:SetChildActive(11,self.selectJDid==pointid_1)
pointitem_2:SetChildActive(11,self.selectJDid==pointid_2)
pointitem_3:SetChildActive(11,self.selectJDid==pointid_3)
pointitem_4:SetChildActive(11,self.selectJDid==pointid_4)

if k==layout+1 then
local iswalk1=self:checkifTank(self.demons_id,self.chapter_id,pointid_1,k)
if self.selectJDid~=pointid_1 and iswalk1 then
pointitem_1:SetChildScale(10,Vector3.New(1,1,1))
pointitem_1:SetChildDOTweenAnimation_DOPlay(10)
end
local iswalk2=self:checkifTank(self.demons_id,self.chapter_id,pointid_2,k)
if self.selectJDid~=pointid_2 and iswalk2 then
pointitem_2:SetChildScale(10,Vector3.New(1,1,1))
pointitem_2:SetChildDOTweenAnimation_DOPlay(10)
end
local iswalk3=self:checkifTank(self.demons_id,self.chapter_id,pointid_3,k)
if self.selectJDid~=pointid_3 and iswalk3 then
pointitem_3:SetChildScale(10,Vector3.New(1,1,1))
pointitem_3:SetChildDOTweenAnimation_DOPlay(10)
end
local iswalk4=self:checkifTank(self.demons_id,self.chapter_id,pointid_4,k)
if self.selectJDid~=pointid_4 and iswalk4 then
pointitem_4:SetChildScale(10,Vector3.New(1,1,1))
pointitem_4:SetChildDOTweenAnimation_DOPlay(10)
end
end

pointitem_1:SetChildButtonClick(10,function()
self:onClickShow(k,pointid_1,weizhiidx1)
end)
pointitem_2:SetChildButtonClick(10,function()
self:onClickShow(k,pointid_2,weizhiidx2)
end)
pointitem_3:SetChildButtonClick(10,function()
self:onClickShow(k,pointid_3,weizhiidx3)
end)
pointitem_4:SetChildButtonClick(10,function()
self:onClickShow(k,pointid_4,weizhiidx4)
end)
end
end
end


local now_yg_zjjd=self:getzjdangqianJindu(self.demons_id,self.chapter_id)
if self.demons_id then
local _height=normalpointh*now_yg_zjjd+100
if isyaowang then
_height=_height+140
end
local Content_weight=self.winlua:GetChildSizeDeltaX(self.Content:getID())
self.winlua:SetChildSizeDelta(self.Content:getID(),Content_weight,_height)


local point_height=self.winlua:GetChildSizeDeltaY(self.pointScroller:getID())

local nowheight=point_height
if nowjd<=2 then
nowheight=_height-point_height
else
nowheight=_height-normalpointh*(nowjd-2)-point_height-150
end

self.winlua:SetChildAnchoredPosition(self.Content:getID(),Vector3.New(0,nowheight,0))
end


if _this.selectJDid~=0 then
for i=0,14 do
if i==0 then
else
local pointSjitem=widget:GetChildWidgetBase(pointAll[i])
for j=1,9 do
local pointitem_1=pointSjitem:GetChildWidgetBase(pointSingle[j])
pointitem_1:SetChildScale(10,Vector3.New(1,1,1))
pointitem_1:SetChildDOTweenAnimation_DOPause(10)
end
end
end
end


if seltfz_list and#seltfz_list>0 then
else
self:Animayunwu(self.demons_id,self.chapter_id)
end
end


function UISiFangPingYaoMainWin:Animaywlines()

local widget=_this.pointItem:getWidgetBase()
local pointSjitem=widget:GetChildWidgetBase(pointAll[shoulingpoint])
local finishlist=SiFangPingYaoModel:getPointFinishFlagList()
local isfinish=finishlist[shoulingpoint]
if isfinish then
pointSjitem:SetChildActive(7,true)
_this:delayDo(0.3,function()
if _this==nil then return end
pointSjitem:SetChildImageDOFillAmount(7,1,0.5,nil)
end)
end
end

function UISiFangPingYaoMainWin:Animalines(isfinish,weizhi,pointitem_1,pointid_1,k,weizhiidx)
if isfinish then
pointitem_1:SetChildActive(pointSmall2[weizhi],true)
local finishlinepoid=SiFangPingYaoModel:getfinishlinepoid()

if finishlinepoid~=0 and finishlinepoid==pointid_1 then
local seltfz_list=SiFangPingYaoModel:getSeltFZ_list()
if seltfz_list and#seltfz_list>0 then
local temp={isfinish,weizhi,pointid_1,k,weizhiidx}
SiFangPingYaoModel:settwofinishlinepoid(temp)
else
_this:delayDo(0.3,function()
if _this==nil then return end
pointitem_1:SetChildImageDOFillAmount(pointSmall2[weizhi],1,0.5,nil)
SiFangPingYaoModel:setfinishlinepoid(0)
end)
end
else
pointitem_1:SetChildIconFillAmount(pointSmall2[weizhi],1)
end
end
end

function UISiFangPingYaoMainWin:AnimaTwolines()
local _data=SiFangPingYaoModel:gettwofinishlinepoid()

if _data and _data[1]and _data[2]and _data[3]and _data[4]and _data[5]then
local widget=_this.pointItem:getWidgetBase()
local pointSjitem=widget:GetChildWidgetBase(pointAll[_data[4]])
local pointitem_1=pointSjitem:GetChildWidgetBase(pointSingle[_data[5]])
_this:Animalines(_data[1],_data[2],pointitem_1,_data[3])
_this:delayDo(0.3,function()
if _this==nil then return end
pointitem_1:SetChildCSImageSprite(10,ab_name,"image_sifangpingyao_05")
end)
SiFangPingYaoModel:settwofinishlinepoid({})
end
end


function UISiFangPingYaoMainWin:Animayunwu(demons_id,chapter_id)
if demons_id==SiFangPingYaoController.sfpyWuYgid and chapter_id~=0 then
_this:delayDo(0.3,function()
if _this==nil then return end
local wuyaoguo=SiFangPingYaoModel:getwuyaoguo()

if#wuyaoguo>0 and wuyaoguo[1]~=0 then
if wuyaoguo[2]and wuyaoguo[2]==1 then
self:setLayoutYunpoint(demons_id,chapter_id,wuyaoguo[1])
elseif wuyaoguo[2]and wuyaoguo[2]==2 then
self:setLayoutYaopoint()
end
end
SiFangPingYaoModel:setwuyaoguo({})
end)
end
end

function UISiFangPingYaoMainWin:setLayoutYunpoint(demons_id,chapter_id,_layout)
local layout=_layout+1
local allpointlist=_this:getzjJinduStrut(demons_id,chapter_id)

if layout and layout~=0 and layout<=#allpointlist then
local widget=_this.pointItem:getWidgetBase()
local pointSjitem=widget:GetChildWidgetBase(pointAll[layout])
pointSjitem:SetChildCanvasGroupAlpha(12,1)


if _this==nil then return end
pointSjitem:SetChildSpineAnimation(11,2020,1,nil)
_this:delayDo(1,function()
if _this==nil then return end
pointSjitem:SetChildActive(10,false)
pointSjitem:SetChildSpineAnimation(11,0,1,nil)
end)

end
end

function UISiFangPingYaoMainWin:setLayoutYaopoint()
local widget=_this.pointItem:getWidgetBase()
local pointSjitem=widget:GetChildWidgetBase(pointAll[shoulingpoint])
pointSjitem:SetChildCanvasGroupAlpha(1,1)
pointSjitem:SetChildActive(5,true)

if _this==nil then return end
pointSjitem:SetChildSpineAnimation(6,2020,1,nil)
_this:delayDo(1,function()
if _this==nil then return end
pointSjitem:SetChildActive(5,false)
pointSjitem:SetChildSpineAnimation(6,0,1,nil)
end)

end


function UISiFangPingYaoMainWin:getiscolorline(v_,point1,point2)
local isfinish=false
if v_==0 then
if point1 then
isfinish=true
end
else
if point1 and point2 then
isfinish=true
end
end
return isfinish
end


function UISiFangPingYaoMainWin:isstoppoint()

if _this.selectJDid~=0 then
local widget=_this.pointItem:getWidgetBase()
for i=0,14 do
if i==0 then
else
local pointSjitem=widget:GetChildWidgetBase(pointAll[i])
for j=1,9 do
local pointitem_1=pointSjitem:GetChildWidgetBase(pointSingle[j])
pointitem_1:SetChildScale(10,Vector3.New(1,1,1))
pointitem_1:SetChildDOTweenAnimation_DOPause(10)
end
end
end
end
end


function UISiFangPingYaoMainWin:onClickShow(layoutid,pointid,weizhiidx)

local doing_point_id=SiFangPingYaoModel:getdoingpointid()
if doing_point_id and doing_point_id~=0 then
UIManager.info("请先完成当前关卡")
return
end
if self.selectJDid==pointid then
return
end
local finishlist=SiFangPingYaoModel:getPointFinishFlagList()
if finishlist[pointid]then
UIManager.info("已完成该关卡")
return
end
local finishlist2=SiFangPingYaoModel:getPointFinishList()
local layout=#finishlist2+1
if layoutid>layout then
local point_data=SiFangPingYaoController:getPointJiaoHuData(pointid)
if point_data.point_type==sfpyPointType.xiaoguai or point_data.point_type==sfpyPointType.jingyin or point_data.point_type==sfpyPointType.yaowang then
local chapter_id=SiFangPingYaoModel:getZhangjieIdex()
if pointid~=1000 then
UIManager.info("前方似有阵阵妖气传来")
end
if pointid==1000 and chapter_id<3 then
UIManager.info("前方似有阵阵妖气传来")
end
if pointid==1000 and chapter_id==3 then
UIManager.info("此乃妖王所在之地")
end
elseif point_data.point_type==sfpyPointType.shijian then
UIManager.info("前路凶吉未卜，须多加谨慎")
elseif point_data.point_type==sfpyPointType.juqing then
UIManager.info("此处似有一丝妖王的气息")
elseif point_data.point_type==sfpyPointType.huifu then
UIManager.info("一阵充沛的灵气从前路传来")
end
return
end
local iswalk=UISiFangPingYaoMainWin:checkifTank(self.demons_id,self.chapter_id,pointid,layoutid)
if not iswalk then
UIManager.info("无法选择该关卡")
return
end


local widget=self.pointItem:getWidgetBase()
if self.layoutid~=0 and self.weizhiidx~=0 then
local pointSjitem_old=widget:GetChildWidgetBase(pointAll[self.layoutid])
local pointitem_old=pointSjitem_old:GetChildWidgetBase(pointSingle[self.weizhiidx])
pointitem_old:SetChildActive(11,false)
pointitem_old:SetChildDOTweenAnimation_DOPlay(10)
end


self.selectJDid=pointid
self.layoutid=layoutid
self.weizhiidx=weizhiidx
if pointid==shoulingpoint and self.chapter_id==3 then
else
local pointSjitem_new=widget:GetChildWidgetBase(pointAll[layoutid])
local pointitem_new=pointSjitem_new:GetChildWidgetBase(pointSingle[weizhiidx])
pointitem_new:SetChildActive(11,true)
pointitem_new:SetChildDOTweenAnimation_DOPause(10)
pointitem_new:SetChildScale(10,Vector3.New(1,1,1))
end

self:isshowluxian(false)
self:dopointidx(pointid)

end


function UISiFangPingYaoMainWin:isshowluxian(flag)

_this.climg:setActive(flag)
end

function UISiFangPingYaoMainWin:outisshowluxian()
local doing_point_id=SiFangPingYaoModel:getdoingpointid()
if doing_point_id and doing_point_id==0 then
_this:isshowluxian(true)
end
end


function UISiFangPingYaoMainWin:getzjAllJindu(demons_id,chapter_id)
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


function UISiFangPingYaoMainWin:getzjdangqianJindu(demons_id,chapter_id)
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


function UISiFangPingYaoMainWin:getzjNowJindu()
local pointendlist=SiFangPingYaoModel:getPointFinishList()
local lenght=0
for k,v in pairs(pointendlist)do
lenght=lenght+1
end
return lenght
end


function UISiFangPingYaoMainWin:getzjJinduStrut(demons_id,chapter_id)
local map_id=cfg_foursideskilldemonschapterconfig_get(demons_id)[chapter_id].map_id
local mapcfg=cfg_foursideskilldemonsmapconfig_get(map_id)
local map_idx=SiFangPingYaoModel:getmap_idx()
local allpointlist={}
if map_idx>0 then
local mapdata=mapcfg.routes[map_idx][1]

local rout=mapdata[1]
for k,v in ipairs(rout)do
local list={v}
allpointlist[#allpointlist+1]=list
end
for i=1,3 do
local rout2=mapdata[i+1]or{}
for k,v in ipairs(rout2)do
local data=allpointlist[k]
if data[#data]~=v then
data[#data+1]=v
allpointlist[k]=data
end
end
end
end
return allpointlist
end


function UISiFangPingYaoMainWin:getzjJinduBuXian(demons_id,chapter_id)
local map_id=cfg_foursideskilldemonschapterconfig_get(demons_id)[chapter_id].map_id
local mapcfg=cfg_foursideskilldemonsmapconfig_get(map_id)
local map_idx=SiFangPingYaoModel:getmap_idx()
local mapdata={}
if map_idx>0 then
mapdata=mapcfg.routes[map_idx][3]

end
return mapdata
end


function UISiFangPingYaoMainWin:getJieDianQZ(demons_id,chapter_id,pointid)

local map_id=cfg_foursideskilldemonschapterconfig_get(demons_id)[chapter_id].map_id
local mapcfg=cfg_foursideskilldemonsmapconfig_get(map_id)
local map_idx=SiFangPingYaoModel:getmap_idx()
local newtemp={}
if map_idx>0 then
local mapdata=mapcfg.routes
local root1=mapdata[map_idx][1][1]or{}
local root2=mapdata[map_idx][1][2]or{}
local root3=mapdata[map_idx][1][3]or{}
local root4=mapdata[map_idx][1][4]or{}

local temp={}
for k,v in ipairs(root1)do
if pointid==v then
if root1[k-1]then
temp[#temp+1]=root1[k-1]
else
temp[#temp+1]=0
end
break
end
end
for k,v in ipairs(root2)do
if pointid==v then
if root2[k-1]then
temp[#temp+1]=root2[k-1]
else
temp[#temp+1]=0
end
break
end
end
for k,v in ipairs(root3)do
if pointid==v then
if root3[k-1]then
temp[#temp+1]=root3[k-1]
else
temp[#temp+1]=0
end
break
end
end
for k,v in ipairs(root4)do
if pointid==v then
if root4[k-1]then
temp[#temp+1]=root4[k-1]
else
temp[#temp+1]=0
end
break
end
end

if#temp>0 then
local exist={}
for k,v in pairs(temp)do
exist[v]=true
end
for k,v in pairs(exist)do
table.insert(newtemp,k)
end
end

end
return newtemp
end


function UISiFangPingYaoMainWin:checkifTank(demons_id,chapter_id,pointid,layoutid)
local finishlist=SiFangPingYaoModel:getPointFinishFlagList()
local finishlist2=SiFangPingYaoModel:getPointFinishList()
local layout=#finishlist2+1
local uppoint=self:getJieDianQZ(demons_id,chapter_id,pointid)
local iswalk=false
for k,v in ipairs(uppoint)do
if finishlist[v]and layout==layoutid then
iswalk=true
break
end
end

if layout==1 then
local allpointlist=UISiFangPingYaoMainWin:getzjJinduStrut(demons_id,chapter_id)
if allpointlist and#allpointlist>0 then
local firstlist=allpointlist[1]
for k,v in ipairs(firstlist)do
if pointid==v then
iswalk=true
break
end
end
end
end

return iswalk
end


function UISiFangPingYaoMainWin:HandlePointFun(point_id)
local point_data=SiFangPingYaoController:getPointJiaoHuData(point_id)
local point_type=point_data.point_type
if point_type==sfpyPointType.xiaoguai then
self:fightMonster(point_data)
elseif point_type==sfpyPointType.jingyin then
self:fightMonster(point_data)
elseif point_type==sfpyPointType.shijian then
self:qiyushijain(point_data)
elseif point_type==sfpyPointType.juqing then
self:qiyushijain(point_data)
elseif point_type==sfpyPointType.huifu then
self:fuhuo(point_data)
elseif point_type==sfpyPointType.yaowang then
self:fightBigMonster(point_data)
end
end


function UISiFangPingYaoMainWin:fightMonster(point_data)

if deviceHelper.getAPILevel()>=40 then
_this.winlua:SetChildUIModelAnimationSpeed(_this.bgModel:getID(),0.15)
end
self.diziModel:setChildCanvasGroupAlpha(1)
self.diziModel:setChildModelAnimationState(eAnimationID.run,1,nil)
self.dhMask:setActive(true)
local widget=self.modelitem:getWidgetBase()
local newepos=self.dizinewpoint:getChildPosition()
local tweener=self.diziModel:setChildDOMove(newepos,0.8,function()
if _this==nil then return end
self.diziModel:setChildModelAnimationState(eAnimationID.stand,1,nil)
if deviceHelper.getAPILevel()>=40 then
_this.winlua:SetChildUIModelAnimationSpeed(_this.bgModel:getID(),0)
end


widget:SetChildShowEffect(0,11001,true)
_this:delayDo(0.4,function()
self.dzflag1:setActive(false)
self.dzflag2:setActive(true)
self.dzflag3:setActive(false)
_this.diziflag:setChildCanvasGroupAlpha(0)
_this.diziflag:setChildCanvasGroupDOFade(1,0.5,nil)
end)

_this:delayDo(0.5,function()
widget:SetChildCanvasGroupAlpha(1,0)
widget:SetChildCanvasGroupAlpha(8,0)
widget:SetChildActive(8,true)
widget:SetChildActive(1,true)
local modelParams=comHelper.getMonsterGroupModelParams(point_data.point_value)
local scaleParam=isometricMapSystem:getModelScales2Pram(modelParams.body,21)
widget:SetChildUIModelShowTarget(1,modelParams.body,scaleParam[1],modelParams.componets,eAnimationID.stand,false,false,0,nil)
widget:SetChildUIModelShowTargetOffset(1,scaleParam[2],scaleParam[3])
widget:SetChildCanvasGroupDOFade(1,1,0.5,nil)
_this:delayDo(0.8,function()
widget:SetChildModelAnimationState(1,eAnimationID.attack1)
end)
widget:SetChildCanvasGroupDOFade(8,1,0.5,function()
widget:SetChildUIModelShowTarget(8,4737,1,nil,eAnimationID.stand)
end)
end)
_this:delayDo(2,function()
if _this==nil then return end
_this.dhMask:setActive(false)
local sfpyFighttype=SiFangPingYaoModel:gettwofight()
if sfpyFighttype then
if sfpyFighttype==1 then
local point_id=point_data.point_id
local mosterGroupId=point_data.point_value
local mcfg=cfgHelper.get(cfg_monstergroup_get,mosterGroupId)
local guidList=SiFangPingYaoController:getlivedzteamList()
local dzcountLeast=0
if guidList then
for i,v in pairs(guidList)do
local guidnum=tonumber(tostring(v))
if guidnum>0 then
dzcountLeast=dzcountLeast+1
end
end
end
local mapname=_this.ygcfg.name
local selectDiscipleCallBack=function(guidList,zhenfaId)
local tlist={}
local newdz=table.weakCopy(guidList)
local deaddz=SiFangPingYaoController:getdeaddzteamList()
if#deaddz>0 then
local idx=1
for k,v in ipairs(newdz)do
if v[1]==0 and deaddz[idx]then
v[2]=deaddz[idx]
idx=idx+1
end
end
end
for i,v in ipairs(newdz)do
table.insert(tlist,v[2])
end

SiFangPingYaoModel:setTeamChangeRecord(nil)
SiFangPingYaoModel:setTeamChangeRecord({2,point_data})
SiFangPingYaoController.send_34_52(#tlist,tlist)

local temp={}
for k,v in pairs(tlist)do
table.insert(temp,{fightPreSelectModel.teamEntityType.dizi,v})
end
local isahngzhen=SiFangPingYaoController:checkshangzhendz()
local mapId=mcfg.mapId
if isahngzhen and mcfg.secomdmapId then
mapId=mcfg.secomdmapId
end
fightLaunchController:sendFight(eBattleLaunch.sifangpingyao,temp,mapId or 0,nil,{point_id})
end
local CancelCallBack=function()
UIFullSiFangPingYaoControl:showSiFangPingYaoMainWinNoCloud({perfightback={this_point_id=point_id}})
end
local winArgs=
{
enterTxt=mapname,
closeByCloud=true,
lockSelect=guidList,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
isHomeBattle=false,
showZhenFa=false,
editorTeam=false,
dzCountLeast=dzcountLeast,
monsterList=mcfg.monList,
groupId=mosterGroupId,
cancelCallBack=CancelCallBack,
enterCallBack=selectDiscipleCallBack,
}
fightController.showPrepareWin(fightPreSelectModel.fightType.sifangpingyao,winArgs,function(...)
end)

elseif sfpyFighttype==2 then

local point_id=point_data.point_id
local mosterGroupId=point_data.point_value
local func=function()
local mcfg=cfgHelper.get(cfg_monstergroup_get,mosterGroupId)
local teamList=SiFangPingYaoController:getFSZteamList()
local temp={}
for k,v in pairs(teamList)do
table.insert(temp,{fightPreSelectModel.teamEntityType.dizi,v})
end
local isahngzhen=SiFangPingYaoController:checkshangzhendz()
local mapId=mcfg.mapId
if isahngzhen and mcfg.secomdmapId then
mapId=mcfg.secomdmapId
end
fightLaunchController:sendFight(eBattleLaunch.sifangpingyao,temp,mapId or 0,nil,{point_id})
end
loadingControl.openCloud(func,1.5)
SiFangPingYaoModel:settwofight(nil)
end
else
logErr('怪物挑战节点的存储有问题，不应为nil，前端检查')
end
widget:SetChildShowEffect(0,-1,false)
end)
end)
tweener:SetEase(_Ease.Linear)
end


function UISiFangPingYaoMainWin:qiyushijain(point_data)

if deviceHelper.getAPILevel()>=40 then
_this.winlua:SetChildUIModelAnimationSpeed(_this.bgModel:getID(),0.15)
end
self.diziModel:setChildCanvasGroupAlpha(1)
self.diziModel:setChildModelAnimationState(eAnimationID.run,1,nil)
self.dhMask:setActive(true)
local widget=self.modelitem:getWidgetBase()
local newepos=self.dizinewpoint:getChildPosition()
local oldepos=self.dizipoint:getChildPosition()
local tweener=self.diziModel:setChildDOMove(newepos,0.8,function()
if _this==nil then return end
self.diziModel:setChildModelAnimationState(eAnimationID.stand,1,nil)
if deviceHelper.getAPILevel()>=40 then
_this.winlua:SetChildUIModelAnimationSpeed(_this.bgModel:getID(),0)
end


if point_data.point_type==sfpyPointType.shijian then
self.dzflag1:setActive(false)
self.dzflag2:setActive(true)
self.dzflag3:setActive(false)
widget:SetChildCSImageSprite(9,ab_name,"image_sifangpingyao_06")
elseif point_data.point_type==sfpyPointType.juqing then
self.dzflag1:setActive(true)
self.dzflag2:setActive(false)
self.dzflag3:setActive(false)
widget:SetChildCSImageSprite(9,ab_name,"image_sifangpingyao_11")
end
widget:SetChildCanvasGroupAlpha(9,0)
_this.diziflag:setChildCanvasGroupAlpha(0)
widget:SetChildCanvasGroupDOFade(9,1,0.5,nil)
_this.diziflag:setChildCanvasGroupDOFade(1,0.5,nil)
_this:delayDo(0.2,function()
_this.qyeffect:setChildShowEffect(-1,false)
_this.qyeffect:setChildShowEffect(qyeffect[point_data.point_type],true)
end)
_this:delayDo(1.4,function()
if _this==nil then return end

local groupId=point_data.point_value
local point_id=point_data.point_id
local teamlist={}
local guidList=SiFangPingYaoController:getFSZteamList()
for i,v in ipairs(guidList)do
if mathHelper.int64_to_number(v)~=0 then
table.insert(teamlist,{unitType=1,unitId=v})
end
end

MysteryEventSystem.event_start(SYSTEM_DEFINE.eJiuChongTianJie1,groupId,teamlist,{7,point_id},true)

_this.dhMask:setActive(false)
_this.diziModel:setChildCanvasGroupDOFade(0,0.5,function()
widget:SetChildCanvasGroupAlpha(9,0)
_this.diziflag:setChildCanvasGroupAlpha(0)
_this.diziModel:setChildPosition(oldepos)
end)
_this:delayDo(2,function()
if _this==nil then return end
_this.diziModel:setChildCanvasGroupDOFade(1,0.5,nil)
end)
end)
end)
tweener:SetEase(_Ease.Linear)
end


function UISiFangPingYaoMainWin:clearspine()
local widget=_this.modelitem:getWidgetBase()
widget:SetChildActive(8,false)
widget:SetChildActive(1,false)
widget:SetChildUIModelRemoveTarget(8)
widget:SetChildCanvasGroupAlpha(8,0)
widget:SetChildCanvasGroupAlpha(1,0)

_this.diziflag:setChildCanvasGroupAlpha(0)
widget:SetChildCanvasGroupAlpha(9,0)
end


function UISiFangPingYaoMainWin:fuhuo(point_data)

if deviceHelper.getAPILevel()>=40 then
_this.winlua:SetChildUIModelAnimationSpeed(_this.bgModel:getID(),0.15)
end
self.diziModel:setChildCanvasGroupAlpha(1)
self.diziModel:setChildModelAnimationState(eAnimationID.run,1,nil)
self.dhMask:setActive(true)
local widget=self.modelitem:getWidgetBase()
local newepos=self.dizinewpoint:getChildPosition()
local oldepos=self.dizipoint:getChildPosition()
local tweener=self.diziModel:setChildDOMove(newepos,0.8,function()
if _this==nil then return end
self.diziModel:setChildModelAnimationState(eAnimationID.stand,1,nil)
if deviceHelper.getAPILevel()>=40 then
_this.winlua:SetChildUIModelAnimationSpeed(_this.bgModel:getID(),0)
end

self.dzflag1:setActive(false)
self.dzflag2:setActive(false)
self.dzflag3:setActive(true)
widget:SetChildCSImageSprite(9,ab_name,"image_sifangpingyao_07")
widget:SetChildCanvasGroupAlpha(9,0)
_this.diziflag:setChildCanvasGroupAlpha(0)
widget:SetChildCanvasGroupDOFade(9,1,0.5,nil)
_this.diziflag:setChildCanvasGroupDOFade(1,0.5,nil)
_this:delayDo(0.2,function()
_this.qyeffect:setChildShowEffect(-1,false)
_this.qyeffect:setChildShowEffect(qyeffect[point_data.point_type],true)
end)
_this:delayDo(1.4,function()
if _this==nil then return end
_this.dhMask:setActive(false)












self:showWindow("UISiFangPingYaotiaozhanWin",{parentwin=self,tag=2,this_pointid=point_data.point_id})
_this.diziModel:setChildCanvasGroupDOFade(0,0.5,function()
widget:SetChildCanvasGroupAlpha(9,0)
_this.diziflag:setChildCanvasGroupAlpha(0)
_this.diziModel:setChildPosition(oldepos)
end)
_this:delayDo(2,function()
if _this==nil then return end
_this.diziModel:setChildCanvasGroupDOFade(1,0.5,nil)
end)
end)
end)
tweener:SetEase(_Ease.Linear)
end


function UISiFangPingYaoMainWin:fightBigMonster(point_data)

if deviceHelper.getAPILevel()>=40 then
_this.winlua:SetChildUIModelAnimationSpeed(_this.bgModel:getID(),0.15)
end
self.diziModel:setChildCanvasGroupAlpha(1)
self.diziModel:setChildModelAnimationState(eAnimationID.run,1,nil)
self.dhMask:setActive(true)
local widget=self.modelitem:getWidgetBase()
local newepos=self.dizinewpoint:getChildPosition()
local tweener=self.diziModel:setChildDOMove(newepos,0.8,function()
if _this==nil then return end
self.diziModel:setChildModelAnimationState(eAnimationID.stand,1,nil)
if deviceHelper.getAPILevel()>=40 then
_this.winlua:SetChildUIModelAnimationSpeed(_this.bgModel:getID(),0)
end


widget:SetChildShowEffect(0,11001,true)
_this:delayDo(0.2,function()
self.dzflag1:setActive(false)
self.dzflag2:setActive(true)
self.dzflag3:setActive(false)
_this.diziflag:setChildCanvasGroupAlpha(0)
_this.diziflag:setChildCanvasGroupDOFade(1,0.5,nil)
end)

_this:delayDo(0.5,function()
widget:SetChildCanvasGroupAlpha(1,0)
widget:SetChildCanvasGroupAlpha(8,0)
widget:SetChildActive(8,true)
widget:SetChildActive(1,true)
local modelParams=comHelper.getMonsterGroupModelParams(point_data.point_value)
local scaleParam=isometricMapSystem:getModelScales2Pram(modelParams.body,21)
widget:SetChildUIModelShowTarget(1,modelParams.body,scaleParam[1],modelParams.componets,eAnimationID.stand,false,false,0,nil)
widget:SetChildUIModelShowTargetOffset(1,scaleParam[2],scaleParam[3])
widget:SetChildCanvasGroupDOFade(1,1,0.5,nil)
_this:delayDo(0.8,function()
widget:SetChildModelAnimationState(1,eAnimationID.attack1)
end)
widget:SetChildCanvasGroupDOFade(8,1,0.5,function()
widget:SetChildUIModelShowTarget(8,4737,1,nil,eAnimationID.stand)
end)
end)
_this:delayDo(2,function()
if _this==nil then return end
_this.dhMask:setActive(false)
local sfpyFighttype=SiFangPingYaoModel:gettwofight()
if sfpyFighttype then
local chapter_id=SiFangPingYaoModel:getZhangjieIdex()
if sfpyFighttype==1 then
local point_id=point_data.point_id
local mosterGroupId=point_data.point_value
local mCfg=cfgHelper.get1(cfg_monstergroup_get,mosterGroupId)
local guidList=SiFangPingYaoController:getlivedzteamList()
local dzcountLeast=0
if guidList then
for i,v in pairs(guidList)do
local guidnum=tonumber(tostring(v))
if guidnum>0 then
dzcountLeast=dzcountLeast+1
end
end
end
local mapname=_this.ygcfg.name
local selectDiscipleCallBack=function(guidList,zhenfaId)
UIManager:closeWindow('UISFPYYWExtraWin')
local tlist={}
local newdz=table.weakCopy(guidList)
local deaddz=SiFangPingYaoController:getdeaddzteamList()
if#deaddz>0 then
local idx=1
for k,v in ipairs(newdz)do
if v[1]==0 and deaddz[idx]then
v[2]=deaddz[idx]
idx=idx+1
end
end
end
for i,v in ipairs(newdz)do
table.insert(tlist,v[2])
end

SiFangPingYaoModel:setTeamChangeRecord(nil)
SiFangPingYaoModel:setTeamChangeRecord({2,point_data})
SiFangPingYaoController.send_34_52(#tlist,tlist)

local temp={}
for k,v in pairs(tlist)do
table.insert(temp,{fightPreSelectModel.teamEntityType.dizi,v})
end
local isahngzhen=SiFangPingYaoController:checkshangzhendz()
local mapId=mCfg.mapId
if isahngzhen and mCfg.secomdmapId then
mapId=mCfg.secomdmapId
end
fightLaunchController:sendFight(eBattleLaunch.sifangpingyao,temp,mapId or 0,nil,{point_id})
SiFangPingYaoModel:settwofight(nil)
end
local CancelCallBack=function()
UIManager:closeWindow('UISFPYYWExtraWin')
UIFullSiFangPingYaoControl:showSiFangPingYaoMainWinNoCloud({perfightback={this_point_id=point_id}})
end
local winArgs=
{
enterTxt=mapname,
closeByCloud=true,
lockSelect=guidList,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
isHomeBattle=false,
showZhenFa=false,
editorTeam=false,
dzCountLeast=dzcountLeast,
monsterList=mCfg.monList,
groupId=mosterGroupId,
cancelCallBack=CancelCallBack,
enterCallBack=selectDiscipleCallBack,
}
fightController.showPrepareWin(fightPreSelectModel.fightType.sifangpingyao,winArgs,function(...)
if chapter_id==3 and point_data.point_id==1000 then
UIFullFightPrepareControl:showWindow("UISFPYYWExtraWin")
end
end)
end
else
logErr('怪物挑战节点的存储有问题，不应为nil，前端检查')
end
widget:SetChildShowEffect(0,-1,false)
end)
end)
tweener:SetEase(_Ease.Linear)
end


function UISiFangPingYaoMainWin:fazeget(seltfz_list)
self:showWindow("UISFPYRuleSelectWin",{list=seltfz_list})
end


function UISiFangPingYaoMainWin:changefaze()

self:showWindow("UISiFangPingYaotiaozhanWin",{parentwin=self,tag=1})
end


function UISiFangPingYaoMainWin:dopointidx(point_id)

if UIManager:isActive('UISiFangPingYaotiaozhanWin')then
UIManager:closeWindow("UISiFangPingYaotiaozhanWin")
end
self:showWindow("UISiFangPingYaotiaozhanWin",{parentwin=self,tag=2,this_pointid=point_id})
end


function UISiFangPingYaoMainWin:refreshjlreddot()
local reddot1=false
local reddot2=SiFangPingYaoController:cjallreddot()
self.jlreddot:setActive(reddot1 or reddot2)
end



function UISiFangPingYaoMainWin:onButtonCloseBg()
local ygcfg=cfg_foursideskilldemonsconfig_get(_this.demons_id)
local map_name=""
if ygcfg and ygcfg.name then
map_name=FMT.fmt('即将离开<color=#ca631d>{0}</color>，请问师尊是打算？',ygcfg.name)
end
local show_data=
{
title='提示',
_okText="撤离队伍",
_cancelText="返回",
tipsText=map_name,
cellcallback=function()
_this:showWindow("UISFPYreFightWin",{parentwin=_this,flag=1,chapter_id=_this.chapter_id})
end,
cellcallback2=function()
UIFullSiFangPingYaoControl:showSiFangPingYaoMapWin()
end,
}
UIManager:showWindow('UIDialougeNormalTip',show_data)
end

function UISiFangPingYaoMainWin:onTeamChangeButton()

local demons_id=SiFangPingYaoModel:getMapIdex()
local mapconfig=cfg_foursideskilldemonsconfig_get(demons_id)
local mapname=mapconfig.name
local ygmapid=mapconfig.ygmapid or 818002
local guidList=SiFangPingYaoController:getguidteamList()
local dzcountLeast=#guidList

local enterCallBack=function(guidList)
UIManager.info("调整成功")
local func=function()
local tlist={}
for i,v in ipairs(guidList)do
table.insert(tlist,v[2])
end
SiFangPingYaoModel:setTeamChangeRecord(nil)
SiFangPingYaoModel:setTeamChangeRecord({1,nil})
SiFangPingYaoController.send_34_52(#tlist,tlist)
UIFullSiFangPingYaoControl:showSiFangPingYaoMainWinNoCloud()
fightController:closeSelectStage(false)
end
loadingControl.openCloud(func,2)
end
local winArgs=
{
enterCallBack=enterCallBack,
enterTxt=mapname,
mapId=ygmapid,
closeByCloud=true,
lockSelect=guidList,
dzCountLeast=dzcountLeast,
skipDiscipleStateCheck=true,
statePriorityCheck=true,
skipDiscipleInjuryCheck=true,
skipShouYuanCheck=true,
cancelCallBack=function()
fightController:closeSelectStage()
UIFullSiFangPingYaoControl:showSiFangPingYaoMainWinNoCloud()
end,
sureBodyid=2068,
sureBodyAnim=eAnimationID.dog_idle_1,
dontCloseStage=true,
notNeedDealOverTime=true,
}

fightController.showPrepareWin(fightPreSelectModel.fightType.sifangpingyao,winArgs,function()
end)
end

function UISiFangPingYaoMainWin:onJianlibtn()
self:showWindow("UISFPYRewardWintwo")
end

function UISiFangPingYaoMainWin:onFazebtn()
self:showWindow("UISFPYRuleBagWin",{parentwin=self,changefa=false})
end

function UISiFangPingYaoMainWin:onYaowbtn()
self:showWindow("UISFPYBossNQWin")
end

function UISiFangPingYaoMainWin:onTiaozhanbtn()

local chapter_id=self.chapter_id
if chapter_id==1 then
self:showWindow("UISFPYreFightWin",{parentwin=self,rechallenge=1,flag=3,chapter_id=self.chapter_id})
else
self:showWindow("UISFPYresetWin",{parentwin=self,reflag=2,chapter_id=self.chapter_id})
end
end


function UISiFangPingYaoMainWin:onTipsbtn()
local d={}
d.mode=3
d.title="规则介绍"
d.name='UISiFangPingYaoMainWin_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end


function UISiFangPingYaoMainWin:onButtonTeamHide()
if not self.TeamHide then
self:onButtonTeam()
end
end


function UISiFangPingYaoMainWin:onButtonTeamShow()
if self.TeamHide then
self:onButtonTeam()
end
end
function UISiFangPingYaoMainWin:onButtonTeam()
if self.teamRoot:getTransform()then
self.TeamHide=self.TeamHide or false
self.teamRoot:setChildDOAnchorPosX(self.TeamHide and-617 or-1500,0.3,function()
if self and not self.isClose then
self.TeamHide=not self.TeamHide
self.ButtonTeamHide:setActive(not self.TeamHide)
self.ButtonTeamShow:setActive(self.TeamHide)
end
end)
end
end

function UISiFangPingYaoMainWin:onArrowbtn()
self.arrow1:setActive(false)
self.arrow2:setActive(true)
self:showEntGroupList()
end

function UISiFangPingYaoMainWin:showEntGroupList()
self:showWindow("UISFPYfazetipsWin")
end

function UISiFangPingYaoMainWin:onFazeMask()

self.arrow1:setActive(true)
self.arrow2:setActive(false)
end


function UISiFangPingYaoMainWin.onTYTXZRewardChange(passport_guid)

if passport_guid==_this.passport_guid then
_this:refreshTXZBtn()
end
end

function UISiFangPingYaoMainWin:isHideTxzBtn()
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

function UISiFangPingYaoMainWin:refreshTXZData()
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

function UISiFangPingYaoMainWin:refreshTXZBtn()
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
function UISiFangPingYaoMainWin:onTXZBtn()
if self.passport_guid then
UITYTongXingZhengController:showTXZWin(self.passport_guid,passportDefine.eSFPY)
end
end