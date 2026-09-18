







def_class("UIDiscipleRoleInfoWin",UIWindowBase)









function UIDiscipleRoleInfoWin:bindComponents()

self.root=UIObject.get(self,0)
self.showLihuiBtn=UIButton.get(self,1)
self.colorSignbtn=UIButton.get(self,2)
self.colorSign=UIImage.get(self,3)
self.injuryObj=UIObject.get(self,4)
self.orderBtn=UIButton.get(self,5)
self.ldLockObj=UIObject.get(self,6)
self.postIcon=UIImage.get(self,7)
self.discipleDescObj=UIObject.get(self,8)
self.discipleDescBg=UIButton.get(self,9)
self.ldTxt=UIText.get(self,10)
self.injuryIcon=UIImage.get(self,11)
self.injuryTxt=UIText.get(self,12)
self.discipleDesc=UIText.get(self,13)
self.discipleJobIcon=UIImage.get(self,14)
self.discipleModelRoot=UIObject.get(self,15)
self.changeNameBtn=UIButton.get(self,16)
self.discipleJobBtn=UIButton.get(self,17)
self.discipleNameText=UIText.get(self,18)
self.discipleFightTxt=UIText.get(self,19)
self.posFloatMark=UIObject.get(self,20)
self.liandonBtn=UIButton.get(self,21)
self.switchBtn=UIButton.get(self,22)
self.discipleJobIcon2=UIImage.get(self,23)
self.switchCdBg=UIObject.get(self,24)
self.switchCdText=UIText.get(self,25)
self.spBg=UIObject.get(self,26)

self.showLihuiBtn:setButtonClick(function()self:onShowLihuiBtn()end)

self.colorSignbtn:setButtonClick(function()self:onColorSignbtn()end)

self.orderBtn:setButtonClick(function()self:onOrderBtn()end)

self.discipleDescBg:setButtonClick(function()self:onDiscipleDescBg()end)

self.changeNameBtn:setButtonClick(function()self:onChangeNameBtn()end)

self.discipleJobBtn:setButtonClick(function()self:onDiscipleJobBtn()end)

self.liandonBtn:setButtonClick(function()self:onLiandonBtn()end)

self.switchBtn:setButtonClick(function()self:onSwitchBtn()end)



end


function UIDiscipleRoleInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.showLihuiBtn);self.showLihuiBtn=nil;
_UIObject_release(self.colorSignbtn);self.colorSignbtn=nil;
_UIObject_release(self.colorSign);self.colorSign=nil;
_UIObject_release(self.injuryObj);self.injuryObj=nil;
_UIObject_release(self.orderBtn);self.orderBtn=nil;
_UIObject_release(self.ldLockObj);self.ldLockObj=nil;
_UIObject_release(self.postIcon);self.postIcon=nil;
_UIObject_release(self.discipleDescObj);self.discipleDescObj=nil;
_UIObject_release(self.discipleDescBg);self.discipleDescBg=nil;
_UIObject_release(self.ldTxt);self.ldTxt=nil;
_UIObject_release(self.injuryIcon);self.injuryIcon=nil;
_UIObject_release(self.injuryTxt);self.injuryTxt=nil;
_UIObject_release(self.discipleDesc);self.discipleDesc=nil;
_UIObject_release(self.discipleJobIcon);self.discipleJobIcon=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.changeNameBtn);self.changeNameBtn=nil;
_UIObject_release(self.discipleJobBtn);self.discipleJobBtn=nil;
_UIObject_release(self.discipleNameText);self.discipleNameText=nil;
_UIObject_release(self.discipleFightTxt);self.discipleFightTxt=nil;
_UIObject_release(self.posFloatMark);self.posFloatMark=nil;
_UIObject_release(self.liandonBtn);self.liandonBtn=nil;
_UIObject_release(self.switchBtn);self.switchBtn=nil;
_UIObject_release(self.discipleJobIcon2);self.discipleJobIcon2=nil;
_UIObject_release(self.switchCdBg);self.switchCdBg=nil;
_UIObject_release(self.switchCdText);self.switchCdText=nil;
_UIObject_release(self.spBg);self.spBg=nil;
end
















local _this=nil


function UIDiscipleRoleInfoWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onDiscipleAttrChange,self.onDiscipleAttrChange)
self:addNotify(notifyConfig.onDiscipleOrderChange,self.onDiscipleOrderChange)
self:addNotify(notifyConfig.onDiscipleNameChange,self.onDiscipleNameChange)
self:addNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
end


function UIDiscipleRoleInfoWin:__delete()
if self.isImageFloat then
self:doLocalMoveY(false)
end
self:clearSwitchTimer()
_this=nil
self:unbindComponents()
end

function UIDiscipleRoleInfoWin.onDiscipleAttrChange(dis_guid,attrType)
if _this==nil then return end
if not mathHelper.compareInt64(dis_guid,_this.disciple_guid)then return end

_this:refreshFightView()
end

function UIDiscipleRoleInfoWin.onDiscipleOrderChange(dis_guid,oldOrder,order)
if _this==nil then return end
if not mathHelper.compareInt64(dis_guid,_this.disciple_guid)then return end

_this:rec_orderChange(oldOrder,order)
end

function UIDiscipleRoleInfoWin.onDiscipleNameChange(dis_guid,oldName,name)
if _this==nil then return end
if not mathHelper.compareInt64(dis_guid,_this.disciple_guid)then return end

_this:refreshName()
end

function UIDiscipleRoleInfoWin.onDiscipleStateChange(discipleguid,stateType,old,cur)
if _this==nil then return end
if _this.disciple_guid==discipleguid and stateType==DISCIPLE_STATE_TYPE.eChuiWei then
_this:refreshDiscipleInfo()
_this:refreshPos()
end
end




function UIDiscipleRoleInfoWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid
self.showType=UIDiscipleModel:getDiscipleType(self.disciple_guid)

self:refreshDiscipleInfo()
self:refreshOrderBtn()
self:refreshPos()
end

function UIDiscipleRoleInfoWin:onChangeDisciple(dis_guid)
self:onShow({guid=dis_guid})
end

function UIDiscipleRoleInfoWin:refreshFightView()
self.discipleFightTxt:setText(UIDiscipleModel:getDiscipleFightValue(self.disciple_guid))
end

function UIDiscipleRoleInfoWin:refreshName()

self.discipleNameText:setText(UIDiscipleModel:getDiscipleName(self.disciple_guid))
end

function UIDiscipleRoleInfoWin:refreshDiscipleInfo()
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

self:refreshFightView()

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

function UIDiscipleRoleInfoWin:refreshOrderBtn()
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

function UIDiscipleRoleInfoWin:onInjuryClick()
local offset=Vector2.New(-15,25)
commonTipsHelper.showDiscipleInjuryHelp(self.injuryObj,offset,1)
end

function UIDiscipleRoleInfoWin:onChangeNameBtn()
UIManager:showWindow('UIDiscipleChangeNameWin',{guid=self.disciple_guid})
end

function UIDiscipleRoleInfoWin:onOrderBtn()
local hasOrder=UIDiscipleModel:checkDZHasOrder(self.disciple_guid)
if hasOrder then
UIDiscipleController:reqDZRefreshOrder(self.disciple_guid,0)
else
UIDiscipleController:reqDZRefreshOrder(self.disciple_guid,1)
end
end

function UIDiscipleRoleInfoWin:rec_orderChange(old,cur)
if old>0 and cur==0 then
UIManager.info('已取消关注弟子')
elseif old==0 and cur>0 then
UIManager.info('已设置关注弟子')
end
self:refreshOrderBtn()
end


function UIDiscipleRoleInfoWin:onPosClick()



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


function UIDiscipleRoleInfoWin:refreshPos()
local guid=self.disciple_guid
local posStr=UIDiscipleModel:getDiscipleStateDesc2(guid)


self.discipleDesc:setText(posStr)
local len=#posStr/3

local hight=len*22+5+35
if pfwindowslController:checkIsGameVersion_yuenan()then
hight=45
end
local width=self.discipleDescBg:getChildSizeDeltaX()
self.discipleDescBg:setChildSizeDelta(width,hight)



self:doLocalMoveY(true)
end

function UIDiscipleRoleInfoWin:doLocalMoveY(isFloat)
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

function UIDiscipleRoleInfoWin:onShowLihuiBtn()
UIRecruitControl:showItemDiscipleInfoByItemId3(self.disciple_guid)
end


function UIDiscipleRoleInfoWin:hideDiscipleModel()
self.discipleModelRoot:setActive(false)
end


function UIDiscipleRoleInfoWin:showDiscipleModel()
self.discipleModelRoot:setActive(true)
end

function UIDiscipleRoleInfoWin:onDiscipleJobBtn()
local dzID=UIDiscipleModel:getDiscipleID(self.disciple_guid)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(self.disciple_guid)
local jobid=imageInfo.job
local args={}
args.posItem=self.discipleJobIcon
args.pos=Vector2.New(0,-20)
commonTipsHelper.showDiscipleJpbTips(dzID,jobid,args)
end

function UIDiscipleRoleInfoWin:onLiandonBtn()
local dzId=UIDiscipleModel:getDiscipleID(self.disciple_guid)
local linkageId=liandonModel:getLianDonLinkageIdByDZId(dzId)
UIManager:showWindow('UITipLianDonWin',{linkageId=linkageId})
end

function UIDiscipleRoleInfoWin:onDiscipleDescBg()
self:onPosClick()
end

function UIDiscipleRoleInfoWin:onColorSignbtn()
UIManager:showWindow('UIDiscipleAttrColorWin',{guid=self.disciple_guid})
end

function UIDiscipleRoleInfoWin:forceDiscipleModel(body,components,scale,callback)
self.winlua:SetChildUIModelShowFadeToColor(self.discipleModelRoot:getID(),Color.New(1,1,1,0),0.25,0,function()

self.discipleModelRoot:setChildUIModelShowTarget(body,scale,components,eAnimationID.stand,false,false,0.25,callback)
end)
end

function UIDiscipleRoleInfoWin:resetDiscipleModel(callback)
local args={bgFisrt=true}
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfo(self.disciple_guid,args)
self.winlua:SetChildUIModelShowFadeToColor(self.discipleModelRoot:getID(),Color.New(1,1,1,0),0.25,0,function()

self.discipleModelRoot:setChildUIModelShowTarget(modelParams.body,0.85,modelParams.componets,eAnimationID.stand,false,false,0.25,callback)
end)
end

function UIDiscipleRoleInfoWin:onSwitchBtn()
local disciple_guid=self.disciple_guid
UIDiscipleController:reqSwitch(disciple_guid)
end

function UIDiscipleRoleInfoWin:clearSwitchTimer()
if self.switchTimer then
self:stopTimerByID(self.switchTimer)
self.switchTimer=nil
end
end
