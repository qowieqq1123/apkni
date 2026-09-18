







def_class("UIPrisonWin",UIWindowBase)









function UIPrisonWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.btnMoYu=UIObject.get(self,1)
self.btnSwitch=UIObject.get(self,2)
self.btnXianYu=UIObject.get(self,3)
self.descBg=UIObject.get(self,4)
self.detailsBtn=UIButton.get(self,5)
self.effect1=UIObject.get(self,6)
self.effect2=UIObject.get(self,7)
self.effect3=UIObject.get(self,8)
self.effect4=UIObject.get(self,9)
self.effect5=UIObject.get(self,10)
self.effect6=UIObject.get(self,11)
self.effect7=UIObject.get(self,12)
self.effect8=UIObject.get(self,13)
self.elder=UIObject.get(self,14)
self.flInfo=UIObject.get(self,15)
self.icon=UIObject.get(self,16)
self.iconMo=UIImage.get(self,17)
self.imgMo=UIObject.get(self,18)
self.imgTongJi=UIObject.get(self,19)
self.infoPanel=UIObject.get(self,20)
self.isMoYu=UIObject.get(self,21)
self.isXianYu=UIObject.get(self,22)
self.jingjie=UIText.get(self,23)
self.jiuyou=UIButton.get(self,24)
self.jyCost=UIText.get(self,25)
self.jyicon=UIButton.get(self,26)
self.jyRoot=UIObject.get(self,27)
self.liangti=UIText.get(self,28)
self.logBtn=UIButton.get(self,29)
self.moBg=UIObject.get(self,30)
self.moYuText=UIText.get(self,31)
self.Mreddot=UIObject.get(self,32)
self.Msuo=UIObject.get(self,33)
self.name=UIText.get(self,34)
self.nameMo=UIText.get(self,35)
self.pclick=UIButton.get(self,36)
self.prisonDesc=UIText.get(self,37)
self.rewards=UIObject.get(self,38)
self.rewardScrollview=UIObject.get(self,39)
self.rewardText=UIText.get(self,40)
self.ruleBtn=UIButton.get(self,41)
self.scrollview=UIObject.get(self,42)
self.selectRoot=UIObject.get(self,43)
self.seletBtn=UIButton.get(self,44)
self.sex1=UIObject.get(self,45)
self.sex2=UIObject.get(self,46)
self.shenwen=UIButton.get(self,47)
self.shifang=UIButton.get(self,48)
self.spine_back=UIObject.get(self,49)
self.stage=UIText.get(self,50)
self.state=UIText.get(self,51)
self.swText=UIText.get(self,52)
self.wanted=UIObject.get(self,53)
self.xianYuText=UIText.get(self,54)
self.Xsuo=UIObject.get(self,55)
self.zhaomu=UIButton.get(self,56)
self.zhenya=UIButton.get(self,57)
self.zyCost=UIText.get(self,58)
self.zyicon=UIButton.get(self,59)
self.zyRoot=UIObject.get(self,60)

self.detailsBtn:setButtonClick(function()self:onDetailsBtn()end)

self.jiuyou:setButtonClick(function()self:onJiuyou()end)

self.jyicon:setButtonClick(function()self:onJyicon()end)

self.logBtn:setButtonClick(function()self:onLogBtn()end)

self.pclick:setButtonClick(function()self:onPclick()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.seletBtn:setButtonClick(function()self:onSeletBtn()end)

self.shenwen:setButtonClick(function()self:onShenwen()end)

self.shifang:setButtonClick(function()self:onShifang()end)

self.zhaomu:setButtonClick(function()self:onZhaomu()end)

self.zhenya:setButtonClick(function()self:onZhenya()end)

self.zyicon:setButtonClick(function()self:onZyicon()end)
self.spine={
["back"]=self.spine_back,
}



end


function UIPrisonWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.btnMoYu);self.btnMoYu=nil;
_UIObject_release(self.btnSwitch);self.btnSwitch=nil;
_UIObject_release(self.btnXianYu);self.btnXianYu=nil;
_UIObject_release(self.descBg);self.descBg=nil;
_UIObject_release(self.detailsBtn);self.detailsBtn=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.effect3);self.effect3=nil;
_UIObject_release(self.effect4);self.effect4=nil;
_UIObject_release(self.effect5);self.effect5=nil;
_UIObject_release(self.effect6);self.effect6=nil;
_UIObject_release(self.effect7);self.effect7=nil;
_UIObject_release(self.effect8);self.effect8=nil;
_UIObject_release(self.elder);self.elder=nil;
_UIObject_release(self.flInfo);self.flInfo=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.iconMo);self.iconMo=nil;
_UIObject_release(self.imgMo);self.imgMo=nil;
_UIObject_release(self.imgTongJi);self.imgTongJi=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.isMoYu);self.isMoYu=nil;
_UIObject_release(self.isXianYu);self.isXianYu=nil;
_UIObject_release(self.jingjie);self.jingjie=nil;
_UIObject_release(self.jiuyou);self.jiuyou=nil;
_UIObject_release(self.jyCost);self.jyCost=nil;
_UIObject_release(self.jyicon);self.jyicon=nil;
_UIObject_release(self.jyRoot);self.jyRoot=nil;
_UIObject_release(self.liangti);self.liangti=nil;
_UIObject_release(self.logBtn);self.logBtn=nil;
_UIObject_release(self.moBg);self.moBg=nil;
_UIObject_release(self.moYuText);self.moYuText=nil;
_UIObject_release(self.Mreddot);self.Mreddot=nil;
_UIObject_release(self.Msuo);self.Msuo=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.nameMo);self.nameMo=nil;
_UIObject_release(self.pclick);self.pclick=nil;
_UIObject_release(self.prisonDesc);self.prisonDesc=nil;
_UIObject_release(self.rewards);self.rewards=nil;
_UIObject_release(self.rewardScrollview);self.rewardScrollview=nil;
_UIObject_release(self.rewardText);self.rewardText=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.selectRoot);self.selectRoot=nil;
_UIObject_release(self.seletBtn);self.seletBtn=nil;
_UIObject_release(self.sex1);self.sex1=nil;
_UIObject_release(self.sex2);self.sex2=nil;
_UIObject_release(self.shenwen);self.shenwen=nil;
_UIObject_release(self.shifang);self.shifang=nil;
_UIObject_release(self.spine_back);self.spine_back=nil;
_UIObject_release(self.stage);self.stage=nil;
_UIObject_release(self.state);self.state=nil;
_UIObject_release(self.swText);self.swText=nil;
_UIObject_release(self.wanted);self.wanted=nil;
_UIObject_release(self.xianYuText);self.xianYuText=nil;
_UIObject_release(self.Xsuo);self.Xsuo=nil;
_UIObject_release(self.zhaomu);self.zhaomu=nil;
_UIObject_release(self.zhenya);self.zhenya=nil;
_UIObject_release(self.zyCost);self.zyCost=nil;
_UIObject_release(self.zyicon);self.zyicon=nil;
_UIObject_release(self.zyRoot);self.zyRoot=nil;
self.spine=nil;
end
















local _cellItemIndex=
{
name=0,
time=1,
fulu=2,
shenwen=3,
lock=4,
men=5,
gongci=6,
xf_tips0=7,
tipsbg=8,
xf_tips1=9,
null_tips=11,
namebg=12,
recruit=13,
shifang_root=14,
shifang_text=15,
effectRoot=16,
item_self=17,
moxiu=18,
stage=19,
stageText=20,
jiuyou_root=21,
jiuyou_text=22,
jiuyou_left=23,
jiuyou_right=24,
}

local _this
local gcPos={{-103,0},{75,-60}}

local unLockImg={'image_laoyu_3','image_laoyumen_1'}
local unLockAndNilImg={'image_laoyu_3','image_laoyumen_2'}
local LockImg={'image_laoyu_4','image_laoyumen_3'}

local abname='ui/windows/xianjie/xianjiemain_hud_atlas_pak.ab'
local prisonAB='ui/windows/prison/sharedtextures/prison_atlas.ab'

local imageType=
{
[1]="image_xjbs_mowu1",
[2]="image_xjbs_mowu2",
[3]="image_xjbs_mowu3",
[4]="image_xjbs_mowu4",
[0]="image_xjbs_mowu5",
}




function UIPrisonWin:onLoaded(...)
self:bindComponents()

_this=self

self.moyuLock=UIPrisonModel:getMoYuLockState()
self.timers={}

self.pclick:setActive(false)

self.scrollview:setChildScrollViewInit(0.5,true,self.on_item_click,nil)
self.rewardScrollview:setChildScrollViewInit(0.5,true,nil,nil)

notifySystem:listenNotify(notifyConfig.onDisciplePosChange,self.on_pos_change)

self.timerTable={}

self.initNewBie=true
self.isZhaomuing={}
self.isZhaomuing_dzid={}
self.zhaomuState={true,true,true,true,true,true,true,true}
end


function UIPrisonWin:__delete()
self:unbindComponents()

_this=nil
self.initNewBie=nil

UIPrisonModel:setInfoIndex(nil)
notifySystem:removelistener(notifyConfig.onDisciplePosChange,self.on_pos_change)
end

function UIPrisonWin.on_pos_change(guid,pos)
if _this==nil or _this.isClose then return end
_this:setElder()
end


function UIPrisonWin.on_item_click(clicknum,index)
_this.isClick=true
_this:onSelectItem(index)
_this.isClick=false
end




function UIPrisonWin:onShow(argtable,afterOnloaded)
self.prisonLayer=argtable.prisonLayer or 1
self.baseCfg=cfg_laoyubaseconfig_get(1)
self.costCfg=self.baseCfg.mwzyitem
self.jyCfg=self.baseCfg.sjjy
self.isXianJie=systemModel.isOpen(SYSTEM_DEFINE.eXianJieXianYu)

self.bdData=argtable.data
self.infoPanel:setActive(false)
self:refreshAllCell()
local iskw=UIPrisonModel:existEmptyRoom()
if iskw then
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXDTNaoYuTiXing,true)
end
if argtable.select then
self:onSelectItem(argtable.select)
end
self:setElder()

UIPrisonModel:setshenWenStateList()

self:refreshSelectLayer()

if argtable.args and argtable.args.weakGuide then
weakGuideController:beginGuide(argtable.args.weakGuide)
end
end


function UIPrisonWin:onHide()

end

function UIPrisonWin:setSelectLayer(value)
self.prisonLayer=value
end

function UIPrisonWin:playNewBie()
if not UIPrisonModel:isFirstOpenMoyu()then
UIPrisonModel:saveOpenMoyuState(true)
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.firstOpen_Laoyu_Moyu)
end
end

function UIPrisonWin:refreshSelectLayer()
self:refreshSelectBtn()

end

function UIPrisonWin:refreshSelectBtn()
local lock=UIPrisonModel:getMoYuLockState()
local flag=self.isXianJie

if flag then
self.bgModel:setActive(self.prisonLayer==1)
self.moBg:setActive(self.prisonLayer==2 and lock)

self.Msuo:setActive(not lock)
self.isXianYu:setActive(self.prisonLayer==1)
self.isMoYu:setActive(self.prisonLayer==2)

self.winlua:SetChildLocalPosY(self.xianYuText:getID(),0)

if lock then
self.Mreddot:setActive(false)
self.winlua:SetChildLocalPosY(self.moYuText:getID(),0)
else
local reddot=UIPrisonModel:getMoYuLockReddotState()
self.Mreddot:setActive(reddot)
end
else
self.Mreddot:setActive(false)
self.moBg:setActive(false)
end

self.selectRoot:setActive(flag)
end

function UIPrisonWin:refreshPrisonDesc()
local textCfg=self.baseCfg.xmDesc
if textCfg and textCfg[self.prisonLayer]then
self.prisonDesc:setText(textCfg[self.prisonLayer])
end
self.descBg:setActive(self.isXianJie)
end

function UIPrisonWin:getDatas()
local cfgs=cfg_laofangconfig()
local list={}
local stime=gameUtilityModel.getServerShortTime()
for i,v in ipairs(cfgs)do
local pd=UIPrisonModel:getPrisonData(v.id)
local swstate=0
if pd and pd.swEndTime>0 then
swstate=pd.swEndTime<stime and 2 or 1
end
table.insert(list,{cfg=v,data=pd,isUnlock=pd~=nil,swstate=swstate})
end
return list
end

function UIPrisonWin:getLFData(lfId)
for i,v in ipairs(self.datas)do
if v.cfg.id==lfId then
return v
end
end
end

function UIPrisonWin:setSWState(lfId,state)
local data=self:getLFData(lfId)
data.swstate=state
end

function UIPrisonWin:refreshAllCell(arg)
self.datas=self:getDatas()
self.scrollview:setChildScrollViewCreateGrids(4,2)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local index=self.prisonLayer==1 and i or i+4
local item=grids[i-1]
local data=self.datas[index]
self:refreshCell(item,data,i)
end
if arg and arg.lfId then
local lfId=arg.lfId
if self.prisonLayer==2 then
lfId=lfId-4
end

_this:playEffectById(lfId)
end
end

function UIPrisonWin:playEffectById(index)
if index==1 then
_this.effect1:setChildShowEffect(10554,true)
elseif index==2 then
_this.effect2:setChildShowEffect(10554,true)
elseif index==3 then
_this.effect3:setChildShowEffect(10554,true)
elseif index==4 then
_this.effect4:setChildShowEffect(10554,true)
elseif index==5 then
_this.effect5:setChildShowEffect(10555,true)
elseif index==6 then
_this.effect6:setChildShowEffect(10555,true)
elseif index==7 then
_this.effect7:setChildShowEffect(10555,true)
elseif index==8 then
_this.effect8:setChildShowEffect(10555,true)
end
end

function UIPrisonWin:stopPlayEffect()
_this.effect1:setChildShowEffect(10554,false)

_this.effect2:setChildShowEffect(10554,false)

_this.effect3:setChildShowEffect(10554,false)

_this.effect4:setChildShowEffect(10554,false)

_this.effect5:setChildShowEffect(10555,false)

_this.effect6:setChildShowEffect(10555,false)

_this.effect7:setChildShowEffect(10555,false)

_this.effect8:setChildShowEffect(10555,false)
end

function UIPrisonWin:refreshCellById(lfId,refreshInfo)
for i,v in ipairs(self.datas)do
if v.cfg.id==lfId then
local index=i-1
if self.prisonLayer==2 then index=index-4 end
local item=self.scrollview:getChildScrollViewItemWidget(index)
self:refreshCell(item,v)
if refreshInfo then
self:setInfoPanel(v,lfId)
end
return
end
end
end

function UIPrisonWin:playRecruit(lfId,success,guid)
for i,v in ipairs(self.datas)do
if v.cfg.id==lfId then
local index=i-1
if self.prisonLayer==2 then index=index-4 end
local item=self.scrollview:getChildScrollViewItemWidget(index)
local swguid=self.zmdzId
item:SetChildActive(_cellItemIndex.shenwen,true)
local info=UIDiscipleModel:getDiscipleOutsideModelInfo(swguid)
local scale=isometricMapSystem:getModelScale(info.body,true)
item:SetChildUIModelShowTarget(_cellItemIndex.shenwen,info.body,scale,info.componets,eAnimationID.stand)

item:SetChildActive(_cellItemIndex.xf_tips0,true)
local spk=item:GetChildWidgetBase(_cellItemIndex.xf_tips0)
spk:SetChildText(0,'......')

item:SetChildActive(_cellItemIndex.recruit,true)
local starttime=os.time()
local duration=5
item:SetChildUIProgressbar(_cellItemIndex.recruit,0,duration,false)
self.timerTable[guid]=self:setTimer(1,duration+3,function()
local dt=os.time()-starttime
if dt>duration then
if dt>duration+1 then
self:stopTimerByID(self.timerTable[guid])
if success then
local giftFunc=nil
local word=UIPrisonModel:randomLanguage(3)
local prizeList=systemZongMenModel:getTempRewards()or{}
local outgoer=UIDiscipleModel:getDiscipleData(guid)
giftFunc=function()
local args={
discipledata=outgoer.discipledata,
discipleimage=outgoer.discipleimage,
disciplename=outgoer.disciplename,
talkcontent=word,
callback=function()
showPrizeControl.showWindow(prizeList)
UIManager:closeWindow("UISystemZongMenDiscipleTalkWin")
self:refreshCellById(lfId)
end,
}
UIManager:showWindow("UISystemZongMenDiscipleTalkWin",args)
end

local viewArgs={disciple=guid,callback=giftFunc,isFullOpen=false,}
UIPrisonControl:showRecruitDiscipleWindow(viewArgs)
else
UIManager.error('招募失败')
self:refreshCellById(lfId)
end
self:set_isShow(lfId,true)

else
spk:SetChildText(0,chatEmotHelper.decodeEmot(success and'#14'or'#12'))
end
else
item:SetChildUIProgressbar(_cellItemIndex.recruit,dt,duration)
end
end)
return
end
end
end

function UIPrisonWin:refreshCell(item,data,index)
if self.initNewBie then
item:SetChildNewBieComponentId(_cellItemIndex.item_self,FMT.fmt('UIPrisonWin.lfItem_{0}',index))
self.initNewBie=false
end

local menImgName

if data.isUnlock then
item:SetChildActive(_cellItemIndex.lock,false)
item:SetChildActive(_cellItemIndex.men,true)
item:SetChildActive(_cellItemIndex.xf_tips0,false)
item:SetChildText(_cellItemIndex.xf_tips1,'')
item:SetChildActive(_cellItemIndex.tipsbg,false)

local flguid=data.data.fuluGuid

local isFInish=data.swstate==2
item:SetChildActive(_cellItemIndex.gongci,isFInish)

local pos=gcPos[self.prisonLayer]
local animPos=self.prisonLayer==1 and 10 or-50
local gcName=self.prisonLayer==1 and'image_lygongci'or'image_lygongci1'
item:SetChildLocalPosX(_cellItemIndex.gongci,pos[1])
item:SetChildLocalPosY(_cellItemIndex.gongci,pos[2])
item:SetChildCSImage(_cellItemIndex.gongci,prisonAB,gcName,true)

if isFInish then
self:playAnim(_cellItemIndex.gongci,item,data,animPos,index)
end

if tostring(flguid)~='0'then
menImgName=unLockImg[self.prisonLayer]

local stime=gameUtilityModel.getServerShortTime()
local yueyu=data.data.yyTime>0 and stime>=data.data.yyTime

item:SetChildActive(_cellItemIndex.fulu,not yueyu)

local name
local scale
local stage=0
local offset={0,0}
local isMoXiu=false
local modelParams

if self.prisonLayer==1 then
local ddata=UIDiscipleModel:getDiscipleDataTemp(flguid)
ddata=ddata.netData.net
name=ddata.disciplename
if ddata.xianmo_voc==2 then isMoXiu=true end
modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(flguid)
scale=isometricMapSystem:getModelScale(modelParams.body,true)
else
local mowuId=tonumber(tostring(flguid))
local mowuCfg=cfgHelper.get(cfg_fairylandinfoconfig003_get,mowuId)
local monsterGroupid=mowuCfg.monster[1]
local monsterGroupCfg=cfgHelper.get(cfg_monstergroup_get,monsterGroupid)
local monsterid
for k,v in ipairs(monsterGroupCfg.monList)do
if v>0 then
monsterid=v
break
end
end

local monsterCfg=cfgHelper.get(cfg_monsterconfig_get,monsterid)

name=monsterGroupCfg.name
stage=mowuCfg.stage

local scaleParam=monsterCfg.laoyuModelParam or{}
scale=scaleParam.scale or(monsterCfg.scale~=nil and monsterCfg.scale*0.8)or 0.6
offset=scaleParam.offset or{0,0}
modelParams=comHelper.getMonsterGroupModelParams(monsterGroupid)
end

local iconName='image_xjbs_mowu2'
local str=string.format("%s阶",stage)
item:SetChildText(_cellItemIndex.stageText,str)
item:SetChildCSImageSprite(_cellItemIndex.stage,abname,iconName)
item:SetChildActive(_cellItemIndex.stage,self.prisonLayer==2 or false)
item:SetChildActive(_cellItemIndex.moxiu,self.prisonLayer==1 and isMoXiu)

item:SetChildText(_cellItemIndex.name,name)
item:SetChildUIModelShowTarget(_cellItemIndex.fulu,modelParams.body,scale,modelParams.componets,eAnimationID.stand)
item:SetChildUIModelShowTargetOffset(_cellItemIndex.fulu,offset[1],offset[2])

if data.swstate==1 then
local swguid=data.data.dzGuidShenWen
item:SetChildActive(_cellItemIndex.shenwen,true)
local info2=UIDiscipleModel:getDiscipleOutsideModelInfo(swguid,false,nil,{clothingStar=1})
scale=isometricMapSystem:getModelScale(info2.body,true)
item:SetChildUIModelShowTarget(_cellItemIndex.shenwen,info2.body,scale,info2.componets,eAnimationID.stand)

local sex=UIDiscipleModel:getDiscipleSex(swguid)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(swguid)
local slotData=cfgHelper.get2(cfg_disciplevocationconfig_get,imageInfo.job,sex==1 and"lybslotname"or"jcslotname")
local weaponId=slotData[1]
local slotName=slotData[2]
if weaponId and slotName and info2.hideWeapon==nil then
local outSide=cfgHelper.get2(cfg_discipleweaponimageconfig_get,weaponId,'out_side')
item:SetChildLoadSlot(_cellItemIndex.shenwen,slotName,outSide)
end

local stime=gameUtilityModel.getServerShortTime()
local id=data.cfg.id
if self.prisonLayer==2 then id=id-4 end
self:startTimer(id,item,data.data.swEndTime-stime,info2.body,modelParams.body)
else
item:SetChildActive(_cellItemIndex.shenwen,false)
item:SetChildActive(_cellItemIndex.time,false)
self:clearTimer(data.cfg.id)
end
item:SetChildActive(_cellItemIndex.namebg,true)
item:SetChildText(_cellItemIndex.null_tips,'')
else
menImgName=unLockAndNilImg[self.prisonLayer]


item:SetChildActive(_cellItemIndex.fulu,false)
item:SetChildActive(_cellItemIndex.shenwen,false)
item:SetChildActive(_cellItemIndex.time,false)
item:SetChildActive(_cellItemIndex.tipsbg,false)
item:SetChildText(_cellItemIndex.null_tips,'空')
item:SetChildActive(_cellItemIndex.namebg,false)

item:SetChildActive(_cellItemIndex.stage,false)
item:SetChildActive(_cellItemIndex.moxiu,false)
end
item:SetChildCSImageSprite(_cellItemIndex.men,prisonAB,menImgName)
else
menImgName=LockImg[self.prisonLayer]

item:SetChildActive(_cellItemIndex.lock,true)
item:SetChildActive(_cellItemIndex.men,false)
item:SetChildActive(_cellItemIndex.gongci,false)
item:SetChildActive(_cellItemIndex.fulu,false)
item:SetChildActive(_cellItemIndex.shenwen,false)
item:SetChildActive(_cellItemIndex.namebg,false)
item:SetChildActive(_cellItemIndex.tipsbg,true)
if self:checkEnough(data.cfg.unlockItem)then
item:SetChildActive(_cellItemIndex.xf_tips0,true)
self:playAnim(_cellItemIndex.xf_tips0,item,data,15)
item:SetChildText(_cellItemIndex.xf_tips1,'点击可修复')
item:SetChildText(_cellItemIndex.null_tips,'')
else
item:SetChildActive(_cellItemIndex.xf_tips0,false)
item:SetChildText(_cellItemIndex.xf_tips1,'缺少材料修复')
item:SetChildText(_cellItemIndex.null_tips,'')
end
item:SetChildActive(_cellItemIndex.time,false)
item:SetChildActive(_cellItemIndex.stage,false)
item:SetChildActive(_cellItemIndex.moxiu,false)

item:SetChildCSImageSprite(_cellItemIndex.lock,prisonAB,menImgName)
end

item:SetChildActive(_cellItemIndex.recruit,false)
end

function UIPrisonWin:playZhenYa(lfId)
for i,v in ipairs(self.datas)do
if v.cfg.id==lfId then
local item=self.scrollview:getChildScrollViewItemWidget(i-1)
local swguid=self.zmdzId
local info=UIDiscipleModel:getDiscipleOutsideModelInfo(swguid)
local scale=isometricMapSystem:getModelScale(info.body,true)
item:SetChildUIModelShowTarget(_cellItemIndex.shenwen,info.body,scale,info.componets,eAnimationID.stand)

self:delayDo(1,3,function()
UIManager.info('俘虏已被放逐至虚空')
self:refreshCellById(lfId)
end)
return
end
end
end

function UIPrisonWin:onZhenYaRet(lfId)
self.infoPanel:setActive(false)

for i,v in ipairs(self.datas)do
if v.cfg.id==lfId then
local index=i-1
if self.prisonLayer==2 then index=index-4 end
local item=self.scrollview:getChildScrollViewItemWidget(index)
_this:playEffectById(lfId+4)
local str=UIPrisonModel:randomLanguage(2)
item:SetChildText(_cellItemIndex.shifang_text,str)
item:SetChildActive(_cellItemIndex.shifang_root,true)
item:SetChildChangeSlotDisplay(_cellItemIndex.fulu,"face","face",1110001)
item:SetChildModelAnimationState(_cellItemIndex.fulu,eAnimationID.hit,1,function()
item:SetChildModelAnimationState(_cellItemIndex.fulu,eAnimationID.hit,1,function()
item:SetChildCanvasGroupDOFade(_cellItemIndex.shifang_root,0,2,function()
item:SetChildCanvasGroupAlpha(_cellItemIndex.shifang_root,1)
end)
item:SetChildDOScale(_cellItemIndex.fulu,0.1,1)
item:SetChildDOLocalMoveY(_cellItemIndex.fulu,10,1)
item:SetChildDOLocalMoveX(_cellItemIndex.fulu,135,1)
item:SetChildDORotate(_cellItemIndex.fulu,Vector3.New(0,0,-360),1,DG.Tweening.RotateMode.FastBeyond360,function()
item:SetChildActive(_cellItemIndex.fulu,false)
item:SetChildDOScale(_cellItemIndex.fulu,1,0.05)
item:SetChildDOLocalMoveX(_cellItemIndex.fulu,0,0.05)
item:SetChildDOLocalMoveY(_cellItemIndex.fulu,-85.2,0.05)
item:SetChildActive(_cellItemIndex.shifang_root,false)
self:refreshCellById(lfId)
UIManager.info('俘虏已被放逐至虚空')
end)
end)
end)
return
end
end
end

function UIPrisonWin:playFreed(lfId)
self.infoPanel:setActive(false)
for i,v in ipairs(self.datas)do
if v.cfg.id==lfId then
local index=i-1
if self.prisonLayer==2 then index=index-4 end
local item=self.scrollview:getChildScrollViewItemWidget(index)
local callBack=function()
self.freedTweener=nil
if self.prisonLayer==1 then
local str=UIPrisonModel:randomLanguage(1)
item:SetChildText(_cellItemIndex.shifang_text,str)
item:SetChildActive(_cellItemIndex.shifang_root,true)
item:SetChildCanvasGroupDOFade(_cellItemIndex.shifang_root,0.8,2,function()
item:SetChildCanvasGroupDOFade(_cellItemIndex.shifang_root,0,1)
item:SetChildCanvasGroupDOFade(_cellItemIndex.fulu,0,1,function()
item:SetChildDOLocalMoveY(_cellItemIndex.men,0,1,function()
item:SetChildActive(_cellItemIndex.fulu,false)
item:SetChildCanvasGroupAlpha(_cellItemIndex.fulu,1)
item:SetChildActive(_cellItemIndex.shifang_root,false)
item:SetChildCanvasGroupAlpha(_cellItemIndex.shifang_root,1)
self:refreshCellById(lfId)
UIManager.info('俘虏已离开')
end)
end)
end)
else
item:SetChildCanvasGroupDOFade(_cellItemIndex.fulu,0,1,function()
item:SetChildDOLocalMoveY(_cellItemIndex.men,0,1,function()
item:SetChildActive(_cellItemIndex.fulu,false)
item:SetChildCanvasGroupAlpha(_cellItemIndex.fulu,1)
self:refreshCellById(lfId)
UIManager.info('俘虏已离开')
end)
end)
end
end
self.freedTweener=item:SetChildDOLocalMoveY(_cellItemIndex.men,125,1,callBack)
self.freedTweener:SetEase(DG.Tweening.Ease.Linear)
return
end
end
end

function UIPrisonWin:playAnim(index,item,data,ypos,itemIndex)
if data.tweener then
data.tweener:Kill()
end

if not self.gcTweener then self.gcTweener={}end
if itemIndex and self.gcTweener[itemIndex]then
self.gcTweener[itemIndex]:Kill()
end

data.tweener=item:SetChildDOLocalMoveY(index,ypos,1,nil)
data.tweener:SetEase(_Ease.InOutSine)
data.tweener:SetLoops(-1,_LoopType.Yoyo)

if index==_cellItemIndex.gongci and itemIndex then self.gcTweener[itemIndex]=data.tweener end
end
function UIPrisonWin:onSelectItem(index)
local index=self.prisonLayer==1 and index or index+4
local data=self.datas[index+1]

if data.isUnlock then






self.currSelect=index




local hfl=tostring(data.data.fuluGuid)~='0'

if not hfl then

else

if tonumber(UIPrisonModel:getShenWenState(index+1))==0 and self.zhaomuState[index+1]then
self:setInfoPanel(data,index+1)
else
self.datas=self:getDatas()
local data=self.datas[index+1]
if data.swstate~=2 then
local name={'俘虏','魔物'}
local name1={'审问','镇压'}
name=name[self.prisonLayer]
name1=name1[self.prisonLayer]
if not self.zhaomuState[index+1]then
UIManager.info(string.format('正在招募该%s',name))
elseif tonumber(UIPrisonModel:getShenWenState(index+1))>0 then
UIManager.info(string.format('正在%s该%s',name1,name))
end
end
end
end







if data.swstate==2 and self.isClick then
UIPrisonControl:reqFinishInterrogate(data.cfg.id,0)
return
end
else
UIManager:showWindow('UIPrisonCellUnlockWin',data.cfg.id)
self.infoPanel:setActive(false)
end
end

function UIPrisonWin:refreshMoney()
local zyItem=cfgHelper.get2(cfg_laoyubaseconfig_get,1,'zyItem')
local need=zyItem[2]
local itemid=zyItem[1]
local has=itemsModel.getCount(itemid)
local enough=has>=need
local hasStr=mathHelper.formatNumber(has)
self.zyicon:setIcon(iconHelper.getIconName(zyItem[1]),false)
self.zyCost:setText(enough and FMT.fmt('{0}/{1}',need,hasStr)or FMT.cfmt(FONT_COLOR.eRedColor,'{0}/{1}',need,hasStr))
end

function UIPrisonWin:setInfoPanel(data,index)
local args={}
args.pos=1

if data.isUnlock and tostring(data.data.fuluGuid)~='0'and data.swstate<2 then
UIPrisonModel:setInfoIndex(index)

local flId=data.data.fuluGuid
self.infoPanel:setActive(true)
self.pclick:setActive(true)


local cb=function()
self.flInfo:setChildCanvasGroupDOFade(0,0.4,function()
self.flInfo:setChildCanvasGroupDOFade(1,0.25,nil)
end
)
end
self.flInfo:setChildCanvasGroupAlpha(0)
self.spine_back:setChildUIModelShowTarget(5259,0.9,{},eAnimationID.enter,false,false,0,cb)

local key
local lt_str
local swBoxId
local sex=0

local name=''
local nameMo=''
local color=''
local swName='审问'

local descStr=''
local jj_str=''
local lt_lv_str=''
local stageStr=''

local flag=false
local isTongJi=false
local isWanted=false
local isMoXiu=false
local swState=false
local zmState=false
local zyState=false
local sfState=false
local jyState=false

if self.prisonLayer==1 then
local ddata=UIDiscipleModel:getDiscipleDataTemp(flId)
ddata=ddata.netData.net
local info=UIDiscipleModel:getDiscipleImageInfo(ddata.discipleguid)
if ddata.xianmo_voc==2 then isMoXiu=true end

swState=true
zmState=true and not isMoXiu
zyState=true and not isMoXiu
sfState=true and not isMoXiu
jyState=false or isMoXiu

sex=info.sex
color=info.color
key="color"..color
name=ddata.disciplename
descStr='此人似乎知道以下宝物下落'
local index=1
if isMoXiu then index=isWanted and 3 or 2 end
local cfg=cfg_laoyushenwenrewardconfig_get(index)
swBoxId=cfg[key][1][1]

local n,p,pN=UIDiscipleModel:getJJNameX(ddata.jingjielv)
if p~=nil then
jj_str=FMT.fmt('{0}{1}',n,pN)
else
jj_str=n
end

local n1,p1=UIDiscipleModel:getLTNameX(ddata.liantilv)

if p1~=nil then
lt_lv_str=FMT.fmt('{0}层',p1)
end
lt_str=FMT.fmt('{0}{1}',n1,lt_lv_str)

comHelper.setChildModelRawImage(self.winlua,flId,self.icon:getID(),0,eHeadCenterType.eHead)
else
swName='镇压'
sfState=true
swState=true
jyState=true

local mowuId=tonumber(tostring(flId))
local mowuCfg=cfgHelper.get(cfg_fairylandinfoconfig003_get,mowuId)
local monsterGroupid=mowuCfg.monster[1]
local monsterGroupCfg=cfgHelper.get(cfg_monstergroup_get,monsterGroupid)
local monsterid

if mowuCfg.flag==1 then isTongJi=true end

for k,v in ipairs(monsterGroupCfg.monList)do
if v>0 then
monsterid=v
break
end
end
local monsterCfg=cfgHelper.get(cfg_monsterconfig_get,monsterid)
local modelId=monsterCfg.modelid[1]

local DBCfg=cfgHelper.get(cfg_dbbodyconfig_get,modelId)
local iconId=DBCfg.icon_head
nameMo=monsterGroupCfg.name
color=mowuCfg.stage
local index=isWanted and 1 or 2
swBoxId=self.costCfg[index][color][1][1]
descStr='镇压魔物随机获得以下宝物'
stageStr=FMT.fmt('阶数：{0}阶',color)
flag=true
self.winlua:SetChildCSImageIcon(self.iconMo:getID(),iconId,true)
end

local judge=flag or isMoXiu
self.imgMo:setActive(isMoXiu)
self.state:setActive(not judge)
self.jingjie:setActive(not flag)
self.liangti:setActive(not judge)
self.detailsBtn:setActive(not judge)
self.wanted:setActive(isWanted)

self.shenwen:setActive(swState)
self.zhenya:setActive(zyState)
self.zhaomu:setActive(zmState)
self.shifang:setActive(sfState)
self.jiuyou:setActive(jyState)

self.icon:setActive(not flag)
self.iconMo:setActive(flag)


self.name:setText(name)
self.nameMo:setText(nameMo)
self.swText:setText(swName)
self.rewardText:setText(descStr)
self.sex1:setActive(sex==1)
self.sex2:setActive(sex==2)

self.jingjie:setText(jj_str)
self.liangti:setText(lt_str)
self.stage:setText(stageStr)

self.imgTongJi:setActive(isTongJi)

if judge and not isWanted then
self.winlua:SetChildLocalPosY(self.rewards:getID(),-55)
else
self.winlua:SetChildLocalPosY(self.rewards:getID(),-82.22)
end

if jyState then
local index
if self.prisonLayer==1 then
index=not isWanted and self.prisonLayer or self.prisonLayer+1
else
index=not isWanted and self.prisonLayer+1 or self.prisonLayer+2
end

local cost=self.jyCfg[self.prisonLayer][1][3]
cost=cost[1]
local itemId=cost[1]
local itemCount=cost[2]


self.zyRoot:setActive(false)
else
self.zyRoot:setActive(true)
end

self:setSWReward(swBoxId)

local serial=UIPrisonModel:getserialListByIndex(index)
if serial==0 then
self.state:setText("无")
else
local zmData=systemZongMenModel:getInfoData(serial)
local zmName=systemZongMenModel:getNameStr(zmData.id,zmData.nameIdx)
self.state:setText(zmName)
end

local check=data.data.zmNum>0
self.winlua:SetChildButtonEnable(self.zhaomu:getID(),true,check)
check=data.data.swNum>0
self.winlua:SetChildButtonEnable(self.shenwen:getID(),true,check)

if self.prisonLayer==1 then
check=true
else
check=data.data.swNum>0
end
self.winlua:SetChildButtonEnable(self.jiuyou:getID(),true,not check)

local zyItem=cfgHelper.get2(cfg_laoyubaseconfig_get,1,'zyItem')
local need=zyItem[2]
local itemid=zyItem[1]
local has=itemsModel.getCount(itemid)
local enough=has>=need
local hasStr=mathHelper.formatNumber(has)
self.zyicon:setIcon(iconHelper.getIconName(zyItem[1]),true)
self.zyCost:setText(enough and FMT.fmt('{0}/{1}',need,hasStr)or
FMT.cfmt(FONT_COLOR.eRedColor,'{0}/{1}',need,hasStr))
else
self.infoPanel:setActive(false)
self.pclick:setActive(false)

end
end

function UIPrisonWin:setElder()
local dis_list=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eZhenYu)or{}
if#dis_list>0 then
self.seletBtn:setActive(false)
self.elder:setActive(true)
self.btnSwitch:setActive(true)
local ddata=dis_list[1]
local guid=ddata.discipleguid

local info=UIDiscipleModel:getDiscipleOutsideModelInfo(guid)
local scale=isometricMapSystem:getModelScale(info.body,true)
self.elder:setChildUIModelShowTarget(info.body,scale,info.componets,eAnimationID.stand)
self.zlGuid=guid
else
self.seletBtn:setActive(true)
self.elder:setActive(false)
self.btnSwitch:setActive(false)
self.zlGuid=nil
end
end

function UIPrisonWin:hideInfoPanel()
self.pclick:setActive(false)
self.infoPanel:setActive(false)

UIPrisonModel:setInfoIndex(nil)
end

function UIPrisonWin:setSWReward(rwId)
if rwId>0 then

local dcfg=cfgHelper.get1(cfg_awardconfig_get,rwId)or{}
local rewards=dcfg.showItems or{}
self.rewardScrollview:setChildScrollViewCreateGrids(#rewards,4)
local grids=self.rewardScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local rw=rewards[i]
widgetHelper.setNormalRewardItem(item,0,{rw[1],rw[2]})
end
end
end

function UIPrisonWin:checkEnough(costs)
if costs==nil then return true end
for i,v in ipairs(costs)do
local itemId=v[1]
local itemCount=v[2]
local have
if moneyConfig.isMoney(itemId)then
have=moneyModel.getMoney(itemId)
else
have=bagModel.getItemCountById(itemId)
end
if have<itemCount then
return false
end
end
return true
end

function UIPrisonWin:startTimer(id,item,tcount,bodyId1,bodyId2)
self:clearTimer(id)

local endtime=tcount+os.time()
item:SetChildActive(_cellItemIndex.time,true)
item:SetChildActive(_cellItemIndex.tipsbg,true)
item:SetChildText(_cellItemIndex.time,self:format_time_stamp9(tcount))
local tickCnt=(tcount+3)*2

self.timers[id]=self:setTimer(0.5,tickCnt,function(id,time,count)
local dt=endtime-os.time()
if dt<0 then

self:clearTimer(id)
if self.prisonLayer==2 then id=id+4 end
self:setSWState(id,2)
self:refreshCellById(id,true)
return
end
item:SetChildText(_cellItemIndex.time,self:format_time_stamp9(dt))

local temp=(tickCnt-count)%8
if temp==5 then
item:SetChildModelAnimationState(_cellItemIndex.shenwen,eAnimationID[FMT.fmt("attack{0}",math.random(1,3))])
comHelper.setChildDiziExpression(item,_cellItemIndex.shenwen,2,bodyId1)
elseif temp==6 then
item:SetChildModelAnimationState(_cellItemIndex.fulu,eAnimationID.hit,1)
comHelper.setChildDiziExpression(item,_cellItemIndex.fulu,6,bodyId2)
elseif temp==7 then
comHelper.setChildDiziExpression(item,_cellItemIndex.fulu,0,bodyId2)
comHelper.setChildDiziExpression(item,_cellItemIndex.shenwen,0,bodyId1)
end
end)
end

function UIPrisonWin:clearTimer(id)
if self.timers[id]then
self:stopTimerByID(self.timers[id])
self.timers[id]=nil
end
end




function UIPrisonWin:onSeletBtn()
UIFullSectPalaceControl:showSectPalacePostInfo(eZongMenPostType.eZhenYu,self.zlGuid,true)
end

function UIPrisonWin:onClickSelect()
self:onSeletBtn()
end

function UIPrisonWin:onZhenya()
local data=self.datas[self.currSelect+1]
if data.swstate>0 then
UIManager.error('正在审问中')
return
end

local zyItem=cfgHelper.get2(cfg_laoyubaseconfig_get,1,'zyItem')
local itemid=zyItem[1]
local need=zyItem[2]
local has=itemsModel.getCount(itemid)
local itemName=itemsModel.getName(itemid)
if has<need then
UIManager.error(FMT.fmt('{0}不足',itemName))
gainControl:showGainWin(itemid)
return
end
local func=function()
UIPrisonControl:reqSuppress(data.cfg.id)
end
local desc=FMT.fmt('消耗<color=#991dc2>{0}*{1}</color>放逐该俘虏？\n（被放逐的俘虏将永远消失）',itemName,need)
UIDialogManager.getConfirmDialog3(nil,desc,func)
end

function UIPrisonWin:onZhaomu()
local data=self.datas[self.currSelect+1]
if data.swstate>0 then
UIManager.error('正在审问中')
return
end
if data.data.zmNum>0 then
UIManager.error('该俘虏声称宁死不加入我宗')
return
end

local cur=UIDiscipleModel:checkDiscipleCount()
local max=UIRecruitModel:getZongMenPeopleMax()
if cur>=max then
UIManager.error("宗门弟子数量已满")
return
end

local maxnum,havenum=UIPrisonModel:getSiXuSpeciality()
if maxnum and maxnum>0 then
if havenum>=maxnum then
UIManager.error('拥有思绪的弟子达到上限（10/10）')
return
end
end


local cfg=cfg_laoyubaseconfig_get(1)
local param_a=cfg.zmParam[1]
local param_b=cfg.zmParam[2]
local ddata=UIDiscipleModel:getDiscipleDataX(data.data.fuluGuid).netData.net
local dis_list__=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eZhenYu)or{}
local dis_list=dis_list__[1]
self.frjingjieLv=ddata.jingjielv





self:onPclick()
local isCanReqList={}
local shenWenList=UIPrisonModel:getshenWenStateList()
local fuluImageInfo=UIDiscipleModel:getDiscipleImageInfo(data.data.fuluGuid)
local ddata=UIDiscipleModel:getDiscipleDataX(data.data.fuluGuid).netData.net


local args={
openType=dzSelectWinOpenType.eManager,
bdData=self.bdData,
isShowCharm=1,
isPrison=true,
frjingjieLv=self.frjingjieLv,
exInfoFunc=function(dzdata)

local quality=fuluImageInfo.color
local lfId=self.currSelect+1
local val=dzdata.attrList[5]*param_a+quality*param_b
local name=UIDiscipleModel:getDiscipleData(dzdata.discipleguid).disciplename

if shenWenList[name]then
isCanReqList[dzdata.discipleguid]=false
return FMT.fmt('预测结果：<color=red>无</color>'),FMT.fmt('弟子在拷问中')
elseif dzdata.jingjielv<=ddata.jingjielv then
isCanReqList[dzdata.discipleguid]=false
return FMT.fmt('预测结果：<color=red>无</color>'),FMT.fmt('境界比目标低')
elseif UIDiscipleModel:getDiscipleStateDesc(dzdata.discipleguid,'',nil,nil)=="垂危中"then
isCanReqList[dzdata.discipleguid]=false
return FMT.fmt('预测结果：<color=red>无</color>')
elseif val>60 then
isCanReqList[dzdata.discipleguid]=true
return FMT.fmt('预测结果：<color=#599820>大概率</color>')
elseif val<=60 and val>30 then
isCanReqList[dzdata.discipleguid]=true
return FMT.fmt('预测结果：<color=#c98816>中概率</color>')
elseif val<=30 and val>=10 then
isCanReqList[dzdata.discipleguid]=true
return FMT.fmt('预测结果：<color=red>小概率</color>')
else
isCanReqList[dzdata.discipleguid]=true
return FMT.fmt('预测结果：<color=red>机会渺茫</color>')
end
end,
callback=function(dzId)
self.zmdzId=dzId
local name=UIDiscipleModel:getDiscipleData(dzId).disciplename

if shenWenList[name]then
UIManager.error("该弟子正在拷问俘虏")
return
end

if self.isZhaomuing[name]then
UIManager.error("该弟子正在招募俘虏")
return
end

if UIDiscipleModel:getDiscipleStateDesc(dzId,'',nil,nil)=="垂危中"then
UIManager.error("垂危弟子无法进行招募")
return
end

if not isCanReqList[dzId]then
UIManager.error("该弟子境界比目标俘虏低")
return
end

self.isZhaomuing_dzid[data.cfg.id]=dzId
UIPrisonControl:reqRecruit(data.cfg.id,dzId)
UIManager:closeWindow('UICommonDragonBoneWin')
end
}
discipleSelectController:openDiscipleSelect(args)
end

function UIPrisonWin:onShifang()
local name={'俘虏','魔物'}
local data=self.datas[self.currSelect+1]
if data.swstate>0 then
UIManager.error('正在审问中')
return
end
local contentStr=FMT.fmt('是否确定释放该{0}？\n（注：释放后{0}会从牢狱里永久离开）',name[self.prisonLayer])
local show_data={
type='UIDialouge',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
okcallback=function()
UIPrisonControl:reqFreed(data.cfg.id)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

function UIPrisonWin:countFightValue()
local datas=UIDiscipleModel:getAllDiscipleData()
local fvList={}
for k,v in pairs(datas)do
if v.disType==dicipleType.eSystem then
table.insert(fvList,UIDiscipleModel:getDiscipleFightValue(v.netData.net.discipleguid))
end
end
table.sort(fvList,function(a,b)
return a>b
end)

return(fvList[1]+fvList[2]+fvList[3]+fvList[4]+fvList[5])/10000
end

function UIPrisonWin:onShenwen()
local cfg=cfg_laoyubaseconfig_get(1)
local param_a=cfg.zmParam[1]
local param_b=cfg.zmParam[2]
local data=self.datas[self.currSelect+1]
if data.data.swNum>0 then
local text={'这名俘虏已身无长物了','魔物已被镇压'}
UIManager.error(text[self.prisonLayer])
return
end





local isShowCharm=2
if self.currSelect>3 then isShowCharm=3 end

self:onPclick()
local isCanReqList={}
local shenWenList=UIPrisonModel:getshenWenStateList()
local args={
openType=dzSelectWinOpenType.eManager,
bdData=self.bdData,
isShowCharm=isShowCharm,
isPrison=true,
exInfoFunc=function(dzdata)






local name=UIDiscipleModel:getDiscipleData(dzdata.discipleguid).disciplename
if shenWenList[name]then
isCanReqList[dzdata.discipleguid]=false
return nil,FMT.fmt('弟子在拷问中')
elseif self.isZhaomuing[dzdata.disciplename]then
isCanReqList[dzdata.discipleguid]=false
return nil,FMT.fmt('弟子在招募中')
end
end,
callback=function(dzId)
local name=UIDiscipleModel:getDiscipleData(dzId).disciplename

if shenWenList[name]then
UIManager.error("该弟子正在拷问俘虏")
return
end

if self.isZhaomuing[name]then
UIManager.error("该弟子正在招募俘虏")
return
end

if UIDiscipleModel:getDiscipleStateDesc(dzId,'',nil,nil)=="垂危中"then
UIManager.error("垂危弟子无法进行拷问")
return
end

UIPrisonControl:reqInterrogate(data.cfg.id,dzId)
UIManager:closeWindow('UICommonDragonBoneWin')
end
}
discipleSelectController:openDiscipleSelect(args)
end

function UIPrisonWin:playJiuYou(lfId)
_this.infoPanel:setActive(false)
for i,v in ipairs(_this.datas)do
if v.cfg.id==lfId then
local scale=1
local index=i-1
local flId=v.data.fuluGuid
UIPrisonModel:setHandInCaptive(lfId)

local layer=3
if _this.prisonLayer==2 then
index=index-4
local mowuId=tonumber(tostring(flId))
local mowuCfg=cfgHelper.get(cfg_fairylandinfoconfig003_get,mowuId)
local flag=mowuCfg.flag
if flag==1 then
layer=4
else
layer=3
end
else





layer=1
end
self.prizelist=_this:getJYRewardList(flId,layer)

local item=_this.scrollview:getChildScrollViewItemWidget(index)

if _this.prisonLayer==1 then
item:SetChildChangeSlotDisplay(_cellItemIndex.fulu,"face","face",1110010)
end

item:SetChildActive(_cellItemIndex.jiuyou_left,true)
item:SetChildUIModelShowTarget(_cellItemIndex.jiuyou_left,161023,scale,{},eAnimationID.stand)

item:SetChildActive(_cellItemIndex.jiuyou_right,true)
item:SetChildUIModelShowTarget(_cellItemIndex.jiuyou_right,160027,scale,{},eAnimationID.stand)

local callBack=function()
item:SetChildModelAnimationState(_cellItemIndex.jiuyou_left,eAnimationID.attack1)
item:SetChildModelAnimationState(_cellItemIndex.jiuyou_right,eAnimationID.attack1)
self.jyTimer=self:delayDo(0.4,function()
item:SetChildShowEffect(_cellItemIndex.effectRoot,20460,true)
self.jyTimer=nil
end)

local str=UIPrisonModel:randomLanguage(4,_this.prisonLayer)
if str then
item:SetChildText(_cellItemIndex.jiuyou_text,str)
end
item:SetChildActive(_cellItemIndex.jiuyou_root,true)
local callback=function()
item:SetChildCanvasGroupDOFade(_cellItemIndex.jiuyou_root,0,1,function()
if self.prizelist then
showPrizeControl.showWindow(self.prizelist)
self.prizelist=nil
end
item:SetChildCanvasGroupDOFade(_cellItemIndex.jiuyou_left,0,1,nil)
item:SetChildCanvasGroupDOFade(_cellItemIndex.jiuyou_right,0,1,nil)
item:SetChildCanvasGroupDOFade(_cellItemIndex.fulu,0,1,function()
item:SetChildDOLocalMoveY(_cellItemIndex.men,0,1,function()
item:SetChildActive(_cellItemIndex.fulu,false)
item:SetChildActive(_cellItemIndex.jiuyou_root,false)
item:SetChildActive(_cellItemIndex.jiuyou_left,false)
item:SetChildActive(_cellItemIndex.jiuyou_right,false)
item:SetChildCanvasGroupAlpha(_cellItemIndex.fulu,1)
item:SetChildCanvasGroupAlpha(_cellItemIndex.jiuyou_root,1)
item:SetChildCanvasGroupAlpha(_cellItemIndex.jiuyou_left,1)
item:SetChildCanvasGroupAlpha(_cellItemIndex.jiuyou_right,1)

_this:refreshCellById(lfId)
end)
end)
end)
end
self.jyTweener=item:SetChildCanvasGroupDOFade(_cellItemIndex.jiuyou_root,0.8,2,callback)
self.jyTweener:SetEase(DG.Tweening.Ease.Linear)
end
self.jyTweener=item:SetChildDOLocalMoveY(_cellItemIndex.men,170,1,callBack)
self.jyTweener:SetEase(DG.Tweening.Ease.Linear)
end
end
end

function UIPrisonWin:getJYRewardList(flId,layer)
local itemList
if _this.prisonLayer==1 then
local ddata=UIDiscipleModel:getDiscipleDataTemp(flId)
ddata=ddata.netData.net
local level=ddata.jingjielv

itemList=_this:getJYReward(level,layer)
else
local mowuId=tonumber(tostring(flId))

local mowuCfg=cfgHelper.get(cfg_fairylandinfoconfig003_get,mowuId)
local stage=mowuCfg.stage
itemList=_this:getJYReward(stage,layer)
end

return itemList
end

function UIPrisonWin:onJiuyou()
local lfId=self.currSelect+1
local data=self.datas[lfId]
if data.data.swNum<=0 and self.prisonLayer==2 then
UIManager.error('成功镇压后方能上交九渊')
return
end

local ignoreDialouge=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.ePrisonJY)

if ignoreDialouge then
UIPrisonControl:reqHandInCaptive(lfId)
else
local flId=data.data.fuluGuid
local layer=3
if _this.prisonLayer==2 then
local mowuId=tonumber(tostring(flId))
local mowuCfg=cfgHelper.get(cfg_fairylandinfoconfig003_get,mowuId)
local flag=mowuCfg.flag
if flag==1 then layer=4 else layer=3 end
else
layer=1
end
local itemList=self:getJYRewardList(flId,layer)

local contentStr=FMT.fmt('是否将俘虏上交给九幽，同时将获得\n')
local show_data={
type='UIDialouge',
title='提示',
itemList=itemList,
content=contentStr,
oktext='确定',
canceltext='取消',
canvasindex=9,

okcallback=function()
UIPrisonControl:reqHandInCaptive(lfId)
end,



}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
end

function UIPrisonWin:getJYReward(stage,layer)
local cost=self.jyCfg[layer]
for k,v in ipairs(cost)do
local minStage=v[1]
local maxStage=v[2]
local rewardList=table.deepCopy(v[3])

if stage>=minStage and stage<=maxStage then
return rewardList
end
end
end

function UIPrisonWin:onDetailsBtn()
local list={}
for k,v in pairs(self.datas)do
if v.isUnlock then

table.insert(list,v.data.fuluGuid)
end
end
local data=self.datas[self.currSelect+1]
local bdData=self.bdData
local select=self.currSelect


otherPlayerController:openSelfPlayerDZInfoWin(list,list[1])
local func=function()
UIPrisonControl:showPrisonWindow({data=bdData,select=select})
end
fullScreenUI.setNextActiveUICallback(func)
end

function UIPrisonWin:onLogBtn()
UIPrisonControl:reqLog()
end

function UIPrisonWin:onPclick()
self.infoPanel:setActive(false)
self.pclick:setActive(false)
end

function UIPrisonWin:onCloseClick()
UIPrisonControl:closeUI(true,true)
end

function UIPrisonWin:onRuleBtn()
local d={}
d.title='规则说明'
d.mode=3
d.name='UIPrison_rule_%d'
if self.isXianJie then d.name='UINewPrison_rule_%d'end





self:showWindow('UIRuleWin',d)
end

function UIPrisonWin:format_time_stamp9(inteval)
local day=math.floor(inteval/86400)
local hour=math.floor((inteval-day*86400)/3600)
local min=math.floor((inteval-day*86400-hour*3600)/60)
local sec=inteval-day*86400-hour*3600-min*60
if day>=1 then
if hour==0 then
return string.format('%d天',day)
end
return string.format('%d天%d时',day,hour)
elseif hour>0 then
return string.format('%s时%s分',hour,min)
else
return string.format('%d分%d秒',min,sec)
end
end

function UIPrisonWin:set_isShow(lfId,flag)
self.zhaomuState[lfId]=flag
local guid=self.isZhaomuing_dzid[lfId]
if guid then
local name=UIDiscipleModel:getDiscipleData(guid).disciplename
self.isZhaomuing[name]=not flag
else
self.isZhaomuing_dzid[lfId]=nil
end
end


function UIPrisonWin:onClickRewardItem()
local zyItem=cfgHelper.get2(cfg_laoyubaseconfig_get,1,'zyItem')
local itemId=zyItem[1]



gainControl:showGainWin(itemId)
end


function UIPrisonWin:onClickXianyu()
if self.prisonLayer==1 then return end

self.prisonLayer=1
self:clearAllState()
self:refreshAllCell()
self:refreshSelectLayer()
end

function UIPrisonWin:refreshMoyuState()
self.moyuLock=UIPrisonModel:getMoYuLockState()
end


function UIPrisonWin:onClickMoyu()
if self.prisonLayer==2 then return end

if self.moyuLock then
self.prisonLayer=2
self:clearAllState()
self:refreshAllCell()
self:refreshSelectLayer()
else
local cfg=self.baseCfg.moyuUnlock
if cfg then
UIManager:showWindow('UIPrisonMoUnlockWin',cfg)
end
end
end

function UIPrisonWin:clearAllState()
if self.prizelist then
showPrizeControl.showWindow(self.prizelist)
self.prizelist=nil
end

local grids=self.scrollview:getChildScrollViewItemWidgets()
for i=1,4 do
local item=grids[i-1]

if self.freedTweener then
self.freedTweener:Kill()
end

if self.jyTweener then
self.jyTweener:Kill()
end

if self.jyTimer then
self:stopTimerByID(self.jyTimer)
end


self:stopPlayEffect()


item:SetChildDOLocalMoveX(_cellItemIndex.fulu,0,0.05)
item:SetChildDOLocalMoveY(_cellItemIndex.fulu,-85.2,0.05)
item:SetChildActive(_cellItemIndex.shifang_root,false)


item:SetChildDOLocalMoveY(_cellItemIndex.men,0,0.05)


item:SetChildActive(_cellItemIndex.jiuyou_root,false)
item:SetChildShowEffect(_cellItemIndex.effectRoot,20460,false)
item:SetChildUIModelRemoveTarget(_cellItemIndex.jiuyou_left)
item:SetChildUIModelRemoveTarget(_cellItemIndex.jiuyou_right)
end
end