







def_class("UIDiscipleRoleInfoTwoWin",UIWindowBase)









function UIDiscipleRoleInfoTwoWin:bindComponents()

self.djLimit=UIObject.get(self,0)
self.djLimitText=UIObject.get(self,1)
self.jjAndLTBtn=UIButton.get(self,2)
self.jjbackEffect=UIObject.get(self,3)
self.jjBrokeBtn=UIButton.get(self,4)
self.jjBtnReddot=UIObject.get(self,5)
self.jjButton=UIButton.get(self,6)
self.jjLvText=UIText.get(self,7)
self.jjNameText=UIText.get(self,8)
self.jjProgress=UIImage.get(self,9)
self.jjProgressText=UIText.get(self,10)
self.LT=UIObject.get(self,11)
self.ltbackEffect=UIObject.get(self,12)
self.ltBrokeBtn=UIButton.get(self,13)
self.ltBtnReddot=UIObject.get(self,14)
self.ltButton=UIButton.get(self,15)
self.ltLock=UIButton.get(self,16)
self.ltLockTxt=UIText.get(self,17)
self.ltLvText=UIText.get(self,18)
self.ltNameText=UIText.get(self,19)
self.ltProgress=UIObject.get(self,20)
self.ltProgressText=UIText.get(self,21)
self.progressback=UIImage.get(self,22)
self.QJ=UIObject.get(self,23)
self.root=UIObject.get(self,24)

self.jjAndLTBtn:setButtonClick(function()self:onJjAndLTBtn()end)

self.jjBrokeBtn:setButtonClick(function()self:onJjBrokeBtn()end)

self.jjButton:setButtonClick(function()self:onJjButton()end)

self.ltBrokeBtn:setButtonClick(function()self:onLtBrokeBtn()end)

self.ltButton:setButtonClick(function()self:onLtButton()end)

self.ltLock:setButtonClick(function()self:onLtLock()end)



end


function UIDiscipleRoleInfoTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.djLimit);self.djLimit=nil;
_UIObject_release(self.djLimitText);self.djLimitText=nil;
_UIObject_release(self.jjAndLTBtn);self.jjAndLTBtn=nil;
_UIObject_release(self.jjbackEffect);self.jjbackEffect=nil;
_UIObject_release(self.jjBrokeBtn);self.jjBrokeBtn=nil;
_UIObject_release(self.jjBtnReddot);self.jjBtnReddot=nil;
_UIObject_release(self.jjButton);self.jjButton=nil;
_UIObject_release(self.jjLvText);self.jjLvText=nil;
_UIObject_release(self.jjNameText);self.jjNameText=nil;
_UIObject_release(self.jjProgress);self.jjProgress=nil;
_UIObject_release(self.jjProgressText);self.jjProgressText=nil;
_UIObject_release(self.LT);self.LT=nil;
_UIObject_release(self.ltbackEffect);self.ltbackEffect=nil;
_UIObject_release(self.ltBrokeBtn);self.ltBrokeBtn=nil;
_UIObject_release(self.ltBtnReddot);self.ltBtnReddot=nil;
_UIObject_release(self.ltButton);self.ltButton=nil;
_UIObject_release(self.ltLock);self.ltLock=nil;
_UIObject_release(self.ltLockTxt);self.ltLockTxt=nil;
_UIObject_release(self.ltLvText);self.ltLvText=nil;
_UIObject_release(self.ltNameText);self.ltNameText=nil;
_UIObject_release(self.ltProgress);self.ltProgress=nil;
_UIObject_release(self.ltProgressText);self.ltProgressText=nil;
_UIObject_release(self.progressback);self.progressback=nil;
_UIObject_release(self.QJ);self.QJ=nil;
_UIObject_release(self.root);self.root=nil;
end
















local _this=nil


function UIDiscipleRoleInfoTwoWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onDiscipleJJChange,self.onDiscipleJJChange)
self:addNotify(notifyConfig.onDiscipleLTChange,self.onDiscipleLTChange)
self:addNotify(notifyConfig.onDiscipleJJBroke,self.onDiscipleJJBroke)
self:addNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
self:addNotify(notifyConfig.onDiscipleQiZhenChange,self.onDiscipleQiZhenChange)
self:addNotify(notifyConfig.onDiscipleCuiTiChange,self.onDiscipleCuiTiChange)
self:addNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)

local sizeX=self.jjAndLTBtn:getChildSizeDeltaX()
local sizeY=self.jjAndLTBtn:getChildSizeDeltaY()
self.topBtnSize={sizeX,sizeY}

if self.throwExpTime==nil then
self.throwExpTime=Time.realtimeSinceStartup
end
local pos=self:getChildCanvas(-1)
self.defaultSortLayer=pos[1]
self.defaultSortOrder=pos[2]

self.m_cav=self:getChildCanvas(-1)
end


function UIDiscipleRoleInfoTwoWin:__delete()
_this=nil
self.jjbackEffect:setChildShowEffect(0,false)
self.ltbackEffect:setChildShowEffect(0,false)
self:unbindComponents()
end

function UIDiscipleRoleInfoTwoWin.onDiscipleLTChange(disguid,old_lv,liantilv,old_exp,liantiexp)
if _this==nil then return end
if _this.showWin then
if mathHelper.compareInt64(disguid,_this.disciple_guid)then
_this:refreshLTInfo()
end
end
end

function UIDiscipleRoleInfoTwoWin.onDiscipleJJChange(disguid,old_jjlv,jingjielv,old_jjexp,jingjieexp)
if _this==nil then return end
if _this.showWin then
if mathHelper.compareInt64(disguid,_this.disciple_guid)then
_this:refreshJJInfo()
_this:refreshJJInfoStatic()
if old_jjlv~=jingjielv then
if _this.isShuWuDZ then
_this:refreshQJInfo()
else
_this:refreshLTBroke()
_this:refreshLTOpen()
end
end
end
end
end

function UIDiscipleRoleInfoTwoWin.onDiscipleJJBroke(disguid,res)
if _this==nil then return end
if _this.showWin then
if mathHelper.compareInt64(disguid,_this.disciple_guid)then
_this:initTimer()
end
end
end

function UIDiscipleRoleInfoTwoWin.onDiscipleStateChange(discipleguid,stateType,old,cur)
if _this.disciple_guid==discipleguid and stateType==DISCIPLE_STATE_TYPE.eChuiWei then
_this:onShow({guid=discipleguid})
end
end

function UIDiscipleRoleInfoTwoWin.onDiscipleQiZhenChange(dis_guid)
if _this==nil then return end
if not mathHelper.compareInt64(dis_guid,_this.disciple_guid)then return end

_this:refreshLTReddot()
end

function UIDiscipleRoleInfoTwoWin.onDiscipleCuiTiChange(dis_guid)
if _this==nil then return end
if not mathHelper.compareInt64(dis_guid,_this.disciple_guid)then return end

_this:refreshLTReddot()
end

function UIDiscipleRoleInfoTwoWin.on_item_list_changed(argstable)
if not argstable or _this==nil then return end
local needRefreshLTReddot=false
for i,v in ipairs(argstable)do
local itemid=v[3]

local funcparam=itemsConfig.getConfig(itemid).funcparam
if funcparam then
if not needRefreshLTReddot and funcparam.type==item_funtion_type.lt_jingyandan then
needRefreshLTReddot=true
end
end

if needRefreshLTReddot then
break
end
end

if needRefreshLTReddot then

_this:refreshLTReddot()
end
end


function UIDiscipleRoleInfoTwoWin:onHide()
self:stopTimerByName('refreshTimer')
self:stopTimerByName('refreshDaoHengTimer')
end




function UIDiscipleRoleInfoTwoWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid

local dzData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
self.isShuWuDZ=UIDiscipleModel:isShuWuDisciple(dzData.id)

local w=self.topBtnSize[1]
local h=self.topBtnSize[2]
if self.isShuWuDZ then
w=w/2
end
self.jjAndLTBtn:setChildSizeDelta(w,h)

local isChuiwei=UIDiscipleModel:checkDiscipleState2(self.disciple_guid,DISCIPLE_STATE_TYPE.eChuiWei)
self.showWin=not isChuiwei
self.root:setActive(self.showWin)
if self.showWin then
if not self.isShuWuDZ then
self.ltbackEffect:setChildShowEffect(discipleLookup.confgs.ltbackeffectID,true)
end
self.showType=UIDiscipleModel:getDiscipleType(self.disciple_guid)
self:refreshInfos()

self:initTimer()
self:initDaoHengTimer()
else
self:stopTimerByName('refreshTimer')
self:stopTimerByName('refreshDaoHengTimer')
end

if argtable and argtable.subArgs and argtable.subArgs.isOpenSubJJWin then
self:onJjButton()
end








end

function UIDiscipleRoleInfoTwoWin:initTimer()
self:stopTimerByName('refreshTimer')
local show_broke=false
local show_jj_btn=false
if self.showType==dicipleType.eSystem then
show_broke=self:checkShowBroke()
show_jj_btn=not show_broke
end
local jjButtonReddot=UIDiscipleModel:checkDiscipleXianMoXinFaReddot(self.disciple_guid)or UIDiscipleModel:checkDiscipleXianMoTransferReddot(self.disciple_guid)
self.jjBtnReddot:setActive(jjButtonReddot)
self.jjBrokeBtn:setActive(show_broke)
self.jjButton:setActive(show_jj_btn)
if self.showType==dicipleType.eSystem and not show_broke then
local func=function()
self:refreshDiscipleTimer()
end
self.refreshTimer=self:setTimer(1,0,func)
end
end

function UIDiscipleRoleInfoTwoWin:onChangeDisciple(dis_guid)
self:onShow({guid=dis_guid})
end

function UIDiscipleRoleInfoTwoWin:initDaoHengTimer()
self:stopTimerByName('refreshDaoHengTimer')
self.discipleDaoHeng=nil
self:refreshXianMoDaoHengTimer()
local func=function()
self:refreshXianMoDaoHengTimer()
end
self.refreshDaoHengTimer=self:setTimer(10,0,func)
end

function UIDiscipleRoleInfoTwoWin:refreshXianMoDaoHengTimer()
local max=UIDiscipleModel:getDiscipleXinFaTotalExp(self.disciple_guid)
local lastDaoHeng=self.discipleDaoHeng
self.discipleDaoHeng=UIDiscipleModel:getDiscipleDaoHeng(self.disciple_guid)
if lastDaoHeng and lastDaoHeng~=self.discipleDaoHeng then
local str='道行+1'
commonTipsHelper.addThrowOutAndSliderTips(3,str,20,nil,self.defaultSortLayer,self.defaultSortOrder+3)
end
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)

local jjlv=netData.jingjielv
local isXianMo=UIDiscipleModel:checkDiscipleXianMoVoc(self.disciple_guid)
if isXianMo then
self.jjProgressText:setText(string.format("道行：%d年",self.discipleDaoHeng))
end
if self.discipleDaoHeng>=max or not isXianMo then
self:stopTimerByName('refreshDaoHengTimer')
end
end

function UIDiscipleRoleInfoTwoWin:refreshDiscipleTimer()
self:refreshJJInfo()

local curTime=Time.realtimeSinceStartup
local lerpTime=curTime-self.throwExpTime
if lerpTime>=5 then
self.throwExpTime=Time.realtimeSinceStartup
if worldController:checkNoticiateBlockOpen()then
local lerpExp=UIDiscipleModel:calculationJJTimeGrow(self.disciple_guid,5)
local str=FMT.fmt('+{0}修为',lerpExp)
commonTipsHelper.addThrowOutAndSliderTips(3,str,20,nil,self.defaultSortLayer,self.defaultSortOrder+3)
end

end

local show_broke=self:checkShowBroke()
if show_broke then
self:initTimer()
end
end

function UIDiscipleRoleInfoTwoWin:refreshJJInfo()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)

local jjlv=netData.jingjielv
local n,p,pN=UIDiscipleModel:getJJNameX(jjlv)
local jj_str=''
local jj_lv_str=FMT.fmt('{0}阶',p or 0)
if p~=nil then
if pfwindowslController:checkIsGameVersion_guofu()or pfwindowslController:checkIsGameVersion_HWFT()then
jj_str=FMT.fmt('{0}{1}',n,pN)
elseif pfwindowslController:checkIsGameVersion_oumei()then
jj_str=FMT.fmt('{0} {1}',n,pN)
else
jj_str=FMT.fmt('{0} {1}',n,pN)
end
else
jj_str=n
end
self.jjNameText:setText(jj_str)
self.jjLvText:setText(jj_lv_str)
local curjjexp=UIDiscipleModel:calculationJJExp(self.disciple_guid)
local nxjjexp=cfgHelper.get2(cfg_disciplejingjieconfig_get,jjlv,'exp')
local isfull=nxjjexp<=0
if not isfull then
if curjjexp>nxjjexp then
curjjexp=nxjjexp
end
else
curjjexp=1
nxjjexp=1
end

self.jjProgress:setChildIconFillAmount(curjjexp/nxjjexp)
local jj_p_str=''
if not isfull then
jj_p_str=FMT.fmt('{0}%',math.floor((curjjexp/nxjjexp)*100))
else
jj_p_str='已满级'
end
local isXianMo=UIDiscipleModel:checkDiscipleXianMoVoc(self.disciple_guid)
if not isXianMo then
self.jjProgressText:setText(jj_p_str)
end
end

function UIDiscipleRoleInfoTwoWin:refreshJJInfoStatic()
local iconProgressBack='image_dizijjrx_1'
local iconProgress='image_dizijjrx_2'
local dzXianMoVoc=UIDiscipleModel:getDiscipleXianMoVoc(self.disciple_guid)
if dzXianMoVoc==1 or dzXianMoVoc==2 then
iconProgressBack=dzXianMoVoc==1 and'image_xianrenjindu_1'or'image_mojindu_1'
iconProgress=dzXianMoVoc==1 and'image_xianrenjindu_2'or'image_mojindu_2'
elseif WenXinGuanModel:checkDzWXGState(self.disciple_guid)then
iconProgressBack='image_xianmoweixuan_1'
iconProgress='image_xianmoweixuan_2'
end
self.progressback:setSprite("ui/windows/xianmozhuanzhi/xianmozhuanzhi_pak.ab",iconProgressBack)
self.jjProgress:setSprite("ui/windows/xianmozhuanzhi/xianmozhuanzhi_pak.ab",iconProgress)


local jjlv=UIDiscipleModel:getDiscipleJJLevel(self.disciple_guid)
local check,sys,isHide=UIDiscipleModel:checkJJBrokeNeedSystem(jjlv)
if(not check and self:checkShowBroke())and not isHide and sys==SYSTEM_DEFINE.eJiuChongTianJieComplete and JiuChongTianJieEnterModel:getOpenTianJieSec()>0 then
self.jjbackEffect:setChildShowEffectEx(discipleLookup.confgs.jjbackeffectID2,self.m_cav[1],self.m_cav[2]+2,true)
self.djLimit:setActive(true)
local isGuoFu=pfwindowslController:checkIsGameVersion_guofu()
self.djLimitText:setActive(isGuoFu)
else
self.djLimit:setActive(false)
if dzXianMoVoc==1 or dzXianMoVoc==2 then
self.jjbackEffect:setChildAnchoredPosition(Vector2(0,0))
self.jjbackEffect:setChildShowEffect(dzXianMoVoc==1 and 20481 or 20482,true)
elseif WenXinGuanModel:checkDzWXGState(self.disciple_guid)then
self.jjbackEffect:setChildAnchoredPosition(Vector2(0,0))
self.jjbackEffect:setChildShowEffect(20483,true)
else
self.jjbackEffect:setChildAnchoredPosition(Vector2(5,-35))
self.jjbackEffect:setChildShowEffect(discipleLookup.confgs.jjbackeffectID,true)
end
end
end

function UIDiscipleRoleInfoTwoWin:checkShowBroke()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local jjlv=netData.jingjielv
local show_broke=UIDiscipleModel:isDiscipleJJLevelWillChangeX(netData)and UIDiscipleModel:checkNextJJNeedBroke(jjlv)and
UIDiscipleModel:checkJJBrokeByHand(jjlv)and jjlv<cfgHelper.getdef1(cfg_disciplejingjieconfig,'showMax')
return show_broke
end

function UIDiscipleRoleInfoTwoWin:refreshLTOpen()
local isOpen,tipStr=UIDiscipleModel:checkLTOpen(self.disciple_guid)
self.ltbackEffect:setActive(isOpen)
self.ltLock:setActive(not isOpen)
if not isOpen then
self.ltLockTxt:setText(tipStr)
end
end

function UIDiscipleRoleInfoTwoWin:refreshLTReddot()
local isReddot=UIDiscipleModel:checkDZQiZhenSystemReddot(self.disciple_guid)

self.ltBtnReddot:setActive(isReddot)
end

function UIDiscipleRoleInfoTwoWin:refreshLTInfo()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local ltlv=netData.liantilv
local n1,p1,pN=UIDiscipleModel:getLTNameX(ltlv)
local lt_lv_str=FMT.fmt('{0}层',p1 or 0)
local lt_str=FMT.fmt('{0}{1}',n1,pN)
if pfwindowslController:checkIsGameVersion_guofu()or pfwindowslController:checkIsGameVersion_HWFT()then
lt_str=FMT.fmt('{0}{1}',n1,pN)
elseif pfwindowslController:checkIsGameVersion_oumei()then
lt_str=FMT.fmt('{0} {1}',n1,pN)
else
lt_str=FMT.fmt('{0} {1}',n1,pN)
end
self.ltNameText:setText(lt_str)
self.ltLvText:setText(lt_lv_str)
local curltexp=netData.liantiexp
local nxltexp=cfgHelper.get2(cfg_disciplelianticonfig_get,ltlv,'exp')
local isfull=nxltexp<=0
if not isfull then
if curltexp>nxltexp then
curltexp=nxltexp
end
else
curltexp=1
nxltexp=1
end
self.ltProgress:setChildIconFillAmount(curltexp/nxltexp)
local lt_p_str=''
if not isfull then
lt_p_str=FMT.fmt('{0}%',math.floor((curltexp/nxltexp)*100))
else
lt_p_str='已满级'
end
self.ltProgressText:setText(lt_p_str)

self:refreshLTBroke()
self:refreshLTOpen()
self:refreshLTReddot()
end

function UIDiscipleRoleInfoTwoWin:refreshLTBroke()
local show_lt_broke=false
local show_lt_btn=false
if self.showType==dicipleType.eSystem then
local isOpen,tipStr=UIDiscipleModel:checkLTOpen(self.disciple_guid)
local needBroke=UIDiscipleModel:checkDiscipleLTNeedBroke(self.disciple_guid)
show_lt_broke=needBroke and isOpen
show_lt_btn=not needBroke and isOpen
end
self.ltBrokeBtn:setActive(show_lt_broke)
self.ltButton:setActive(show_lt_btn)
end

function UIDiscipleRoleInfoTwoWin:refreshQJInfo()
local slVal=UIDiscipleModel:getShuWuFightValue(self.disciple_guid)
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local qjLevel=netData.qiaojianglv
local swcfg=UIDiscipleModel:getShuWuDZConfig(netData.id)
local name,order=UIDiscipleModel:getShuWuQJLevelInfo(swcfg.bdId,qjLevel)
local widget=self.QJ:getChildWidgetBase()
widget:SetChildShowEffect(0,10519,true)
widget:SetChildText(1,name)
widget:SetChildText(2,FMT.fmt('{0}阶',order))

local lastVal=0
if qjLevel>1 then
lastVal=cfgHelper.get2(cfg_discipleqiaojiangconfig_get,qjLevel-1,'strength')
end
local strength=cfgHelper.get2(cfg_discipleqiaojiangconfig_get,qjLevel,'strength')
local dv=strength-lastVal
local cv=slVal-lastVal
widget:SetChildUIProgressbar(3,cv,dv,false)
local showWin=function()
UIManager:showWindow('UIDiscipleShuWuSkillWin',self.disciple_guid)
end
local check=UIDiscipleController:checkShuWuQJLevelUp(qjLevel,slVal,self.disciple_guid)

widget:SetChildActive(4,not check)
widget:SetChildActive(7,check)
local btnIndex=check and 7 or 4
widget:SetChildButtonClick(btnIndex,showWin)
widget:SetChildButtonClick(6,function()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='ui_shuwu_dizi_help_%s'})
end)
widget:SetChildText(8,slVal)
end

function UIDiscipleRoleInfoTwoWin:refreshInfos()

self:refreshJJInfo()
self:refreshJJInfoStatic()

self.LT:setActive(not self.isShuWuDZ)
self.QJ:setActive(self.isShuWuDZ)
if self.isShuWuDZ then
self:refreshQJInfo()
else

self:refreshLTInfo()
end
end

function UIDiscipleRoleInfoTwoWin:onJjButton()
local isLDLock=UIDiscipleModel:checkDZClientState(self.disciple_guid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end
UIManager:showWindow('UIDiscipleJingJieWin',{guid=self.disciple_guid})
end

function UIDiscipleRoleInfoTwoWin:onLtButton()
local isLDLock=UIDiscipleModel:checkDZClientState(self.disciple_guid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end
UIManager:showWindow('UIDiscipleLianTiWin',{guid=self.disciple_guid})
end

function UIDiscipleRoleInfoTwoWin:onJjAndLTBtn()
local args={}
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
args.jjlv=netData.jingjielv
args.ltlv=netData.liantilv
args.dzId=self.disciple_guid
UIManager:showWindow('UIDiscipleJJAndLTTips',args)
end

function UIDiscipleRoleInfoTwoWin:onJjBrokeBtn()
self:onJjButton()












































end

function UIDiscipleRoleInfoTwoWin:onLtBrokeBtn()
local isLDLock=UIDiscipleModel:checkDZClientState(self.disciple_guid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end

UIManager:showWindow('UIDiscipleLianTiWin',{guid=self.disciple_guid})
end

function UIDiscipleRoleInfoTwoWin:onLtLock()
UIDiscipleModel:checkLTOpen(self.disciple_guid,true)
end
