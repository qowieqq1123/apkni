







def_class("UIDiscipleRoleInfo2Win",UIWindowBase)









function UIDiscipleRoleInfo2Win:bindComponents()

self.changeNameBtn=UIButton.get(self,0)
self.colorSign=UIImage.get(self,1)
self.colorSignbtn=UIButton.get(self,2)
self.discipleDesc=UIText.get(self,3)
self.discipleDescBg=UIButton.get(self,4)
self.discipleDescObj=UIObject.get(self,5)
self.discipleFightTxt=UIText.get(self,6)
self.discipleJobBtn=UIButton.get(self,7)
self.discipleJobIcon=UIImage.get(self,8)
self.discipleModelRoot=UIObject.get(self,9)
self.discipleNameText=UIText.get(self,10)
self.dyskillList=UIObject.get(self,11)
self.fightroot=UIObject.get(self,12)
self.guanlianBtn=UIButton.get(self,13)
self.guanlianred=UIObject.get(self,14)
self.injuryIcon=UIImage.get(self,15)
self.injuryObj=UIObject.get(self,16)
self.injuryTxt=UIText.get(self,17)
self.ldLockObj=UIObject.get(self,18)
self.ldTxt=UIText.get(self,19)
self.liandonBtn=UIButton.get(self,20)
self.orderBtn=UIButton.get(self,21)
self.pdImg=UIImage.get(self,22)
self.pdRoot=UIObject.get(self,23)
self.pdVal=UIText.get(self,24)
self.posFloatMark=UIObject.get(self,25)
self.postIcon=UIImage.get(self,26)
self.rolespbtn=UIButton.get(self,27)
self.root=UIObject.get(self,28)
self.showLihuiBtn=UIButton.get(self,29)
self.signBtn=UIButton.get(self,30)
self.signBtnTx=UIText.get(self,31)
self.signEffect=UIObject.get(self,32)
self.skillContent=UIObject.get(self,33)
self.skillScrollView=UIObject.get(self,34)
self.tmskillList=UIObject.get(self,35)
self.tmskillroot=UIObject.get(self,36)
self.switchBtn=UIButton.get(self,37)
self.switchCdBg=UIObject.get(self,38)
self.switchCdText=UIText.get(self,39)
self.spBg=UIObject.get(self,40)
self.discipleJobIcon2=UIImage.get(self,41)

self.changeNameBtn:setButtonClick(function()self:onChangeNameBtn()end)

self.colorSignbtn:setButtonClick(function()self:onColorSignbtn()end)

self.discipleDescBg:setButtonClick(function()self:onDiscipleDescBg()end)

self.discipleJobBtn:setButtonClick(function()self:onDiscipleJobBtn()end)

self.guanlianBtn:setButtonClick(function()self:onGuanlianBtn()end)

self.liandonBtn:setButtonClick(function()self:onLiandonBtn()end)

self.orderBtn:setButtonClick(function()self:onOrderBtn()end)

self.rolespbtn:setButtonClick(function()self:onRolespbtn()end)

self.showLihuiBtn:setButtonClick(function()self:onShowLihuiBtn()end)

self.signBtn:setButtonClick(function()self:onSignBtn()end)

self.switchBtn:setButtonClick(function()self:onSwitchBtn()end)



end


function UIDiscipleRoleInfo2Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.changeNameBtn);self.changeNameBtn=nil;
_UIObject_release(self.colorSign);self.colorSign=nil;
_UIObject_release(self.colorSignbtn);self.colorSignbtn=nil;
_UIObject_release(self.discipleDesc);self.discipleDesc=nil;
_UIObject_release(self.discipleDescBg);self.discipleDescBg=nil;
_UIObject_release(self.discipleDescObj);self.discipleDescObj=nil;
_UIObject_release(self.discipleFightTxt);self.discipleFightTxt=nil;
_UIObject_release(self.discipleJobBtn);self.discipleJobBtn=nil;
_UIObject_release(self.discipleJobIcon);self.discipleJobIcon=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.discipleNameText);self.discipleNameText=nil;
_UIObject_release(self.dyskillList);self.dyskillList=nil;
_UIObject_release(self.fightroot);self.fightroot=nil;
_UIObject_release(self.guanlianBtn);self.guanlianBtn=nil;
_UIObject_release(self.guanlianred);self.guanlianred=nil;
_UIObject_release(self.injuryIcon);self.injuryIcon=nil;
_UIObject_release(self.injuryObj);self.injuryObj=nil;
_UIObject_release(self.injuryTxt);self.injuryTxt=nil;
_UIObject_release(self.ldLockObj);self.ldLockObj=nil;
_UIObject_release(self.ldTxt);self.ldTxt=nil;
_UIObject_release(self.liandonBtn);self.liandonBtn=nil;
_UIObject_release(self.orderBtn);self.orderBtn=nil;
_UIObject_release(self.pdImg);self.pdImg=nil;
_UIObject_release(self.pdRoot);self.pdRoot=nil;
_UIObject_release(self.pdVal);self.pdVal=nil;
_UIObject_release(self.posFloatMark);self.posFloatMark=nil;
_UIObject_release(self.postIcon);self.postIcon=nil;
_UIObject_release(self.rolespbtn);self.rolespbtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.showLihuiBtn);self.showLihuiBtn=nil;
_UIObject_release(self.signBtn);self.signBtn=nil;
_UIObject_release(self.signBtnTx);self.signBtnTx=nil;
_UIObject_release(self.signEffect);self.signEffect=nil;
_UIObject_release(self.skillContent);self.skillContent=nil;
_UIObject_release(self.skillScrollView);self.skillScrollView=nil;
_UIObject_release(self.tmskillList);self.tmskillList=nil;
_UIObject_release(self.tmskillroot);self.tmskillroot=nil;
_UIObject_release(self.switchBtn);self.switchBtn=nil;
_UIObject_release(self.switchCdBg);self.switchCdBg=nil;
_UIObject_release(self.switchCdText);self.switchCdText=nil;
_UIObject_release(self.spBg);self.spBg=nil;
_UIObject_release(self.discipleJobIcon2);self.discipleJobIcon2=nil;
end
















local _this=nil
local _signHandle={
{
signType=dzSignType.eTianMoJie,

getData=function()
return cfgHelper.get2(cfg_tianmojiebaseconfig_get,1,"discipleSign")
end
}
}

function UIDiscipleRoleInfo2Win:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onDiscipleAttrChange,self.onDiscipleAttrChange)
self:addNotify(notifyConfig.onDiscipleOrderChange,self.onDiscipleOrderChange)
self:addNotify(notifyConfig.onDiscipleNameChange,self.onDiscipleNameChange)
self:addNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
self:addNotify(notifyConfig.onDiscipleSignChange,self.onDiscipleSignChange)
self:addNotify(notifyConfig.onDiscipleSignTypeChange,self.onDiscipleSignTypeChange)
end


function UIDiscipleRoleInfo2Win:__delete()
if self.isImageFloat then
self:doLocalMoveY(false)
end
self:clearSwitchTimer()
_this=nil
self:unbindComponents()
end

function UIDiscipleRoleInfo2Win.onDiscipleAttrChange(dis_guid,attrType)
if _this==nil then return end
if not mathHelper.compareInt64(dis_guid,_this.disciple_guid)then return end

_this:refreshFightView()
end

function UIDiscipleRoleInfo2Win.onDiscipleOrderChange(dis_guid,oldOrder,order)
if _this==nil then return end
if not mathHelper.compareInt64(dis_guid,_this.disciple_guid)then return end

_this:rec_orderChange(oldOrder,order)
end

function UIDiscipleRoleInfo2Win.onDiscipleNameChange(dis_guid,oldName,name)
if _this==nil then return end
if not mathHelper.compareInt64(dis_guid,_this.disciple_guid)then return end

_this:refreshName()
end

function UIDiscipleRoleInfo2Win.onDiscipleStateChange(discipleguid,stateType,old,cur)
if _this==nil then return end
if mathHelper.compareInt64(_this.disciple_guid,discipleguid)and stateType==DISCIPLE_STATE_TYPE.eChuiWei then
_this:refreshDiscipleInfo()
_this:refreshPos()
end
end




function UIDiscipleRoleInfo2Win:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid
self.page=argtable.page or self.page
self.showType=UIDiscipleModel:getDiscipleType(self.disciple_guid)
self.glreddot=userActorSetting.get('changeyrWin',false)
self.defaultVersionId=pfwindowslController:getGameVersion()
self:refreshBotton()
self:refreshDiscipleInfo()
self:refreshOrderBtn()
self:refreshPos()
self:refreshDiscipleSign()
end

function UIDiscipleRoleInfo2Win:refreshShuWuInfo()
self:refreshBotton()
self:refreshDiscipleInfo()
end

function UIDiscipleRoleInfo2Win:onChangeDisciple(dis_guid)
self:onShow({guid=dis_guid})
end

function UIDiscipleRoleInfo2Win:refreshFightView()
self.discipleFightTxt:setText(UIDiscipleModel:getDiscipleFightValue(self.disciple_guid))
end

function UIDiscipleRoleInfo2Win:refreshName()

self.discipleNameText:setText(UIDiscipleModel:getDiscipleName(self.disciple_guid))
end

function UIDiscipleRoleInfo2Win:refresShuWuAddPDValue(dzData)
local pdval,ptype=UIDiscipleModel:countShuWUDZSelfPDAddValue(dzData)
self.pdImg:setSprite(globalABLookup.shuwusprite,shuWuPDImage[ptype])
self.pdVal:setText(FMT.fmt('+{0}%',pdval))
end

function UIDiscipleRoleInfo2Win:refreshDiscipleInfo()
self:clearSwitchTimer()
local guid=self.disciple_guid
local netData=UIDiscipleModel:getDiscipleData(guid)
local isSPdz=UIDiscipleModel:isSPDiscipleEx(guid)

self:refreshName()

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
self.discipleJobIcon:setSprite(globalABLookup.global,jobicon)
self.discipleJobIcon2:setActive(isSPdz)
self.spBg:setActive(isSPdz)
if isSPdz then
local switchidx=1
local switchJobIcon=UIDiscipleModel:getJobIconNameX(guid,switchidx)
self.discipleJobIcon2:setSprite(globalABLookup.global,switchJobIcon)
self.discipleJobIcon:setChildAnchoredPos(-10,10)
local scale=54/68
self.discipleJobIcon:setScale(Vector3(scale,scale,scale))
else
self.discipleJobIcon:setChildAnchoredPos(0,0)
self.discipleJobIcon:setScale(Vector3.one)
end

local isShuWuDZ=UIDiscipleModel:isShuWuDisciple(netData.id)
self.fightroot:setActive(not isShuWuDZ)
self.pdRoot:setActive(isShuWuDZ)
if isShuWuDZ then
self:refresShuWuAddPDValue(netData)
else
self:refreshFightView()
end

self.discipleModelRoot:setChildUIModelRemoveTarget()
local args={bgFisrt=true}
comHelper.setChildInSideModel(self.discipleModelRoot,guid,0.85,nil,0,0,false,false,nil,args)

local showPost=true
local pIcon
if self.showType==dicipleType.eTemp then
showPost=false
end
if showPost then
local pos=UIDiscipleModel:getDisciplePost(guid)
pIcon=UISectPalaceModel:getPostIcon(pos)
showPost=pIcon~=nil
end
self.postIcon:setActive(showPost)
if showPost then
self.postIcon:setSprite(globalABLookup.diciplemain,pIcon)
end

local color=UIDiscipleModel:getDiscipleColor(guid)
local color_icon=FMT.fmt('image_pinjishibie_{0}',color)
self.colorSign:setSprite(globalABLookup.global,color_icon)


























local showChangeName=false
if self.showType==dicipleType.eSystem then
if not UIDiscipleModel:isPlotDisciple(guid)then
showChangeName=true
end
end


local guid=self.disciple_guid
if UIDiscipleModel:isSpecialDZEx(guid,discipleconfigFlag.forbidGaiMing)then
showChangeName=false
end

self.changeNameBtn:setActive(showChangeName)

local injury=UIDiscipleModel:getDiscipleInjury(guid)
local isChuiwei=UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)
local injuryIcon
local injuryDesc
if isChuiwei then
injuryIcon='icon_chuiwei'
injuryDesc='<color=#9BB7FF>垂危</color>'
else
local icon_=eInjuryType:getIcon(injury)
if icon_~=nil then
injuryIcon='icon_fushang'
injuryDesc=FMT.fmt('<color=#FD7474>{0}</color>',eInjuryType:getName(injury))
end
end
local showChuiWei=injuryIcon~=nil
self.injuryObj:setActive(showChuiWei)
if showChuiWei then
self.injuryIcon:setSprite(globalABLookup.global,injuryIcon)
self.injuryTxt:setText(injuryDesc)
end

local isLDLock=UIDiscipleModel:checkDZClientState(guid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
self.ldLockObj:setActive(isLDLock or false)

local dzId=UIDiscipleModel:getDiscipleID(guid)
local isLDDZ=liandonModel:getLianDonLinkageIdByDZId(dzId)>0
self.liandonBtn:setActive(isLDDZ)

local showGlBtn=false
local isShowbtn=cfgHelper.get2(cfg_linkageresourceconfig_get,liandongZY.dizi,"isShowbtn")
if isShowbtn and isShowbtn[self.defaultVersionId]then
local glDiziID=liandonModel:CheckDiZi_Guanlian(dzId)
local guanLianDzIDList=isShowbtn[self.defaultVersionId]
for _,v in ipairs(guanLianDzIDList)do
if v==dzId or v==glDiziID then
showGlBtn=true
break
end
end
end

self.guanlianBtn:setActive(showGlBtn)
self:refreshGLreddot()



self.switchBtn:setActive(isSPdz)
if isSPdz then
local lastTime=UIDiscipleModel:getSPDiscipleLastSwitchTimeStamp()
local cd=cfgHelper.get(cfg_globalconfig_get,1,"spDiscipleSwitchCd")
local nowTime=timeHelper.getServerShortTime()
local isInCd=nowTime<lastTime+cd
self.switchCdBg:setActive(isInCd)
if isInCd then
local deltaTime=lastTime+cd-nowTime
self.switchCdText:setText(timeHelper.format_time_stamp(deltaTime,true))
self.switchTimer=self:setTimer(1,0,function()
local lastTime=UIDiscipleModel:getSPDiscipleLastSwitchTimeStamp()
local cd=cfgHelper.get(cfg_globalconfig_get,1,"spDiscipleSwitchCd")
local nowTime=timeHelper.getServerShortTime()
local isInCd=nowTime<lastTime+cd
self.switchCdBg:setActive(isInCd)
if isInCd then
local deltaTime=lastTime+cd-nowTime
self.switchCdText:setText(timeHelper.format_time_stamp(deltaTime,true))
else
return self:clearSwitchTimer()
end
end)
end
end





end

function UIDiscipleRoleInfo2Win:refreshGLreddot()
self.guanlianred:setActive(not self.glreddot)
end

function UIDiscipleRoleInfo2Win:refreshOrderBtn()
local showBtn=true
if self.showType==dicipleType.eTemp then
showBtn=false
end
if showBtn then
local hasOrder=UIDiscipleModel:checkDZHasOrder(self.disciple_guid)
local icon=hasOrder and'button_guanzhu_2'or'button_guanzhu_1'
self.orderBtn:setCSImageSprite(globalABLookup.global,icon)
end
end

function UIDiscipleRoleInfo2Win:onInjuryClick()
local offset=Vector2.New(-15,25)
commonTipsHelper.showDiscipleInjuryHelp(self.injuryObj,offset,1)
end

function UIDiscipleRoleInfo2Win:onChangeNameBtn()
UIManager:showWindow('UIDiscipleChangeNameWin',{guid=self.disciple_guid})
end

function UIDiscipleRoleInfo2Win:onColorSignbtn()
UIManager:showWindow('UIDiscipleAttrColorWin',{guid=self.disciple_guid})
end

function UIDiscipleRoleInfo2Win:onOrderBtn()
local hasOrder=UIDiscipleModel:checkDZHasOrder(self.disciple_guid)
if hasOrder then
UIDiscipleController:reqDZRefreshOrder(self.disciple_guid,0)
else
UIDiscipleController:reqDZRefreshOrder(self.disciple_guid,1)
end
end

function UIDiscipleRoleInfo2Win:rec_orderChange(old,cur)
if old>0 and cur==0 then
UIManager.info('已取消关注弟子')
elseif old==0 and cur>0 then
UIManager.info('已设置关注弟子')
end
self:refreshOrderBtn()
end


function UIDiscipleRoleInfo2Win:onPosClick()



local guid=self.disciple_guid
local closeUICallBack=function()

if UIManager:isActive('UIDiscipleMainWin')then
UIFullDiscipleMainControl:closeUI()
end


if UIManager:isActive('UIDiscipleSelectWin')then
UIFullDiscipleSelectControl:closeUI()
end
end

UIDiscipleController:jumpToDiscipleStatePos(guid,closeUICallBack)
end


function UIDiscipleRoleInfo2Win:refreshPos()
local guid=self.disciple_guid
local posStr=UIDiscipleModel:getDiscipleStateDesc2(guid)


self.discipleDesc:setText(posStr)
local len=#posStr/3

local hight=len*22+5+35
if pfwindowslController:checkIsGameVersion_yuenan()then
hight=45
elseif pfwindowslController:checkIsGameVersion_oumei()then
hight=55
end
local width=self.discipleDescBg:getChildSizeDeltaX()
self.discipleDescBg:setChildSizeDelta(width,hight)



self:doLocalMoveY(true)
end

function UIDiscipleRoleInfo2Win:doLocalMoveY(isFloat)
if isFloat then
if self.floatTweener==nil then
self.posFloatMark:setLocalPosY(0)
local tweener=self.posFloatMark:setChildDOLocalMoveY(-2.0,1.2)
tweener:SetEase(_Ease.InOutSine)
tweener:SetLoops(-1,_LoopType.Yoyo)
self.floatTweener=tweener

self.isImageFloat=true
end
else
if self.floatTweener~=nil then
self.floatTweener:Complete()
self.floatTweener:Kill()
self.floatTweener=nil
self.posFloatMark:setLocalPosY(0)
self.isImageFloat=nil
end
end
end

function UIDiscipleRoleInfo2Win:onShowLihuiBtn()
UIRecruitControl:showItemDiscipleInfoByItemId3(self.disciple_guid)
end


function UIDiscipleRoleInfo2Win:hideDiscipleModel()
self.discipleModelRoot:setActive(false)
end


function UIDiscipleRoleInfo2Win:showDiscipleModel()
self.discipleModelRoot:setActive(true)
end

function UIDiscipleRoleInfo2Win:onDiscipleJobBtn()
local dzID=UIDiscipleModel:getDiscipleID(self.disciple_guid)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(self.disciple_guid)
local jobid=imageInfo.job
local args={}
args.posItem=self.discipleJobIcon
args.pos=Vector2.New(0,-20)
commonTipsHelper.showDiscipleJpbTips(dzID,jobid,args)
end

function UIDiscipleRoleInfo2Win:onLiandonBtn()
local dzId=UIDiscipleModel:getDiscipleID(self.disciple_guid)
local linkageId=liandonModel:getLianDonLinkageIdByDZId(dzId)
UIManager:showWindow('UITipLianDonWin',{linkageId=linkageId})
end

local skillIconIds={30001,30002,30003,30004,30005,30006}
function UIDiscipleRoleInfo2Win:refreshBotton()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local isShuWuDZ=UIDiscipleModel:isShuWuDisciple(netData.id)
local isOpenDaoYan=UIDiscipleModel:checkOpenDaoYan(netData)
local dyList
if isOpenDaoYan then
dyList=UIDiscipleModel:getDaoYanSkillByGuid(self.disciple_guid)
end
local dylistlen=dyList and#dyList or 0
self.tmskillroot:setActive(netData.tmlistlen~=0 or isShuWuDZ or dylistlen~=0)
self.dyskillList:setActive(dylistlen~=0)
local gruds=self.tmskillList:getChildCommonLayoutGroupWidgetList()
if isShuWuDZ then
local swcfg=UIDiscipleModel:getShuWuDZConfig(netData.id)
for index=1,5 do
local item=gruds[index-1]
local skillId=swcfg.skill[index]
local bShow=skillId~=nil
item:SetChildActive(-1,bShow)
if bShow then
local level=netData.swList[index]
local isActive=level>0
local info=cfgHelper.get1(cfg_discipleshuwuskillinfoconfig_get,skillId)
local icon=iconHelper.getSkillIcon(info.icon)
item:SetChildCSImageIcon(0,icon,false)
item:SetChildImageExGray(0,not isActive)
item:SetChildActive(1,not isActive)
item:SetBaseItemClickEvent(-1,function()
UIManager:showWindow('UIDiscipleShuWuSkillTipsWin',{id=skillId,level=level,dzId=self.disciple_guid})
end)
local check=UIDiscipleController:checkShuWuDZSkillReddot(netData,index)
item:SetChildActive(2,check)
end
end
else
if netData.tmlistlen~=0 then
for index=1,5 do
local item=gruds[index-1]
item:SetChildActive(-1,true)
local tmId=netData.tmList[index]
local tmCfg=cfgHelper.get1(cfg_discipletianmingconfig_get,tmId)
local tmLvCfg=cfgHelper.get1(cfg_discipletianminglevelconfig_get,netData.tmlv)
local tmFloor=tmLvCfg.floor
local jobid=UIDiscipleModel:getDiscipleJob(self.disciple_guid)
local skillIconId=UIDiscipleModel.getTianMingSkillIconId(tmCfg,jobid,netData)

local skillIconName=iconHelper.getSkillIcon(skillIconId)

item:SetChildCSImageIcon(0,skillIconName,false)
item:SetChildImageExGray(0,index-1>tmFloor)
item:SetChildActive(1,index-1>tmFloor)
item:SetChildActive(0,true)
item:SetChildActive(2,false)

item:SetBaseItemClickEvent(-1,function()
self:showWindow("UIDiscipleTianMingSkillTipsWin",{tmId=tmId,tmLv=netData.tmlv,tmIndex=index,guid=self.disciple_guid,skillIconId=skillIconId})
end)
end



















end

if dylistlen~=0 then
local dylv=UIDiscipleModel:getDaoYanLevelEx(netData)
local grids=self.dyskillList:getChildCommonLayoutGroupWidgetList()
for index=1,3 do
local item=grids[index-1]
item:SetChildActive(-1,true)

local skillId=dyList[index][1]
local limit=dyList[index][2]
local isActive=dylv>=limit
local skillCfg=cfg_skillconfig_get(skillId)
local skillIconName=iconHelper.getSkillIcon(skillCfg.icon)

item:SetChildCSImageIcon(0,skillIconName,false)
item:SetChildImageExGray(0,not isActive)
item:SetChildActive(1,not isActive)
item:SetChildActive(0,true)
item:SetChildActive(2,false)

item:SetBaseItemClickEvent(-1,function()
self:showWindow("UIDiscipleDaoYanSkillTipsWin",{skillId=skillId,isActive=isActive,limit=limit,guid=self.disciple_guid})
end)
end
end
end
self.skillScrollView:setChildScrollRectEnable(false)
self.skillContent:setLocalPosX(230)
self.skillScrollView:setChildScrollRectEnable(dylistlen~=0)
end

function UIDiscipleRoleInfo2Win:onDiscipleDescBg()
self:onPosClick()
end

function UIDiscipleRoleInfo2Win:onRolespbtn()
roleAudioController:playRoleSpeak(self.disciple_guid,roleAudioNodeType.ClickLiHui)
end

function UIDiscipleRoleInfo2Win:refreshDiscipleSign()
if self.page==1 then
for i,v in ipairs(_signHandle)do
if UIDiscipleModel:haveDiscipleSign(self.disciple_guid,v.signType)then
self.signType=v.signType
self.signData=v.getData()

self.winlua:SetChildCSImageSprite(self.signBtn:getID(),self.signData.button[1],self.signData.button[2])

self.signBtn:setActive(true)

return
end
end
end
self.signData=nil
self.signBtn:setActive(false)

end

function UIDiscipleRoleInfo2Win:onSignBtn()
if self.signType and self.signData then
local endTime=UIDiscipleModel:getDiscipleSignEndTime(self.disciple_guid,self.signType)
local args={
parentWin=self,
name=self.signData.name,
desc=self.signData.desc,
icon=self.signData.icon,
endTime=endTime,
rootPos={
pivot=Vector2.up,
anchoredPos=Vector2.New(-520,-149),
},
arrowPos={
anchoredPos=Vector2.New(51,9),
anchorsMin=Vector2.up,
anchorsMax=Vector2.up,
rotation=Vector3.forward*180,
}
}
self:showWindow("UIDiscipleSignTipsWin",args)
end
end

function UIDiscipleRoleInfo2Win.onDiscipleSignChange(signType,guidList)
if signType==dzSignType.eTianMoJie then
for i,v in ipairs(guidList)do
if mathHelper.compareInt64(_this.disciple_guid,v)then
_this:refreshDiscipleSign()
return
end
end
end
end

function UIDiscipleRoleInfo2Win.onDiscipleSignTypeChange(signType)
if signType==dzSignType.eTianMoJie then
_this:refreshDiscipleSign()
end
end


function UIDiscipleRoleInfo2Win:onGuanlianBtn()
local arg={}
if self.disciple_guid then
arg.dzguid=self.disciple_guid
end
UIManager:showWindow("UIGuanLianWin",arg)

if not self.glreddot then
userActorSetting.set('changeyrWin',true)
userActorSetting.flush()
self.glreddot=userActorSetting.get('changeyrWin',false)
self:refreshGLreddot()
end
end

function UIDiscipleRoleInfo2Win:onSwitchBtn()
local disciple_guid=self.disciple_guid
UIDiscipleController:reqSwitch(disciple_guid)
end

function UIDiscipleRoleInfo2Win:clearSwitchTimer()
if self.switchTimer then
self:stopTimerByID(self.switchTimer)
self.switchTimer=nil
end
end