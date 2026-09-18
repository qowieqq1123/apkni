







def_class("UIXianJie_selfZmInfoWin",UIWindowBase)









function UIXianJie_selfZmInfoWin:bindComponents()

self.backZmBtn=UIButton.get(self,0)
self.btnCreator=UIObject.get(self,1)
self.FHZBtn=UIButton.get(self,2)
self.headIconCreater=UIObject.get(self,3)
self.lymsPanel=UIButton.get(self,4)
self.mask=UIButton.get(self,5)
self.meHelpBtn=UIButton.get(self,6)
self.playerName=UIText.get(self,7)
self.posTxt=UIText.get(self,8)
self.recordBtn=UIButton.get(self,9)
self.root=UIObject.get(self,10)
self.ruleBtn=UIButton.get(self,11)
self.shareBtn=UIButton.get(self,12)
self.skinBtn=UIButton.get(self,13)
self.skinBtnReddot=UIObject.get(self,14)
self.xmItem=UIObject.get(self,15)
self.xyItem=UIObject.get(self,16)
self.xyNameText=UIText.get(self,17)
self.zmFightValueText=UIText.get(self,18)
self.zmNameText=UIText.get(self,19)
self.xjbjbtn=UIButton.get(self,20)
self.mjslpanel=UIObject.get(self,21)
self.mjslskill=UIObject.get(self,22)
self.slItem=UIObject.get(self,23)
self.slNameText=UIText.get(self,24)
self.mjtag=UIImage.get(self,25)

self.backZmBtn:setButtonClick(function()self:onBackZmBtn()end)

self.FHZBtn:setButtonClick(function()self:onFHZBtn()end)

self.lymsPanel:setButtonClick(function()self:onLymsPanel()end)

self.mask:setButtonClick(function()self:onMask()end)

self.meHelpBtn:setButtonClick(function()self:onMeHelpBtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.skinBtn:setButtonClick(function()self:onSkinBtn()end)

self.xjbjbtn:setButtonClick(function()self:onXjbjbtn()end)



end


function UIXianJie_selfZmInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backZmBtn);self.backZmBtn=nil;
_UIObject_release(self.btnCreator);self.btnCreator=nil;
_UIObject_release(self.FHZBtn);self.FHZBtn=nil;
_UIObject_release(self.headIconCreater);self.headIconCreater=nil;
_UIObject_release(self.lymsPanel);self.lymsPanel=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.meHelpBtn);self.meHelpBtn=nil;
_UIObject_release(self.playerName);self.playerName=nil;
_UIObject_release(self.posTxt);self.posTxt=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.skinBtn);self.skinBtn=nil;
_UIObject_release(self.skinBtnReddot);self.skinBtnReddot=nil;
_UIObject_release(self.xmItem);self.xmItem=nil;
_UIObject_release(self.xyItem);self.xyItem=nil;
_UIObject_release(self.xyNameText);self.xyNameText=nil;
_UIObject_release(self.zmFightValueText);self.zmFightValueText=nil;
_UIObject_release(self.zmNameText);self.zmNameText=nil;
_UIObject_release(self.xjbjbtn);self.xjbjbtn=nil;
_UIObject_release(self.mjslpanel);self.mjslpanel=nil;
_UIObject_release(self.mjslskill);self.mjslskill=nil;
_UIObject_release(self.slItem);self.slItem=nil;
_UIObject_release(self.slNameText);self.slNameText=nil;
_UIObject_release(self.mjtag);self.mjtag=nil;
end















local _this
local slskillidx=
{
skillbtn=0,
icon=1,
name=2,
djsbg=3,
djs=4
}



function UIXianJie_selfZmInfoWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onXianJieCameraMove,self.onXianJieCameraMove)
self:addNotify(notifyConfig.onXianJieCameraZoom,self.onXianJieCameraZoom)
self:addNotify(notifyConfig.onClickXianJiePlane,self.onClickXianJiePlane)
self:addNotify(notifyConfig.onXianJieMonsterChange,self.onXianJieMonsterChange)
self:addNotify(notifyConfig.onChangeXianGuanJob,self.onChangeXianGuanJob)
self:addNotify(notifyConfig.onXianJieBuffFresh,self.onXianJieBuffFresh)
self:addNotify(notifyConfig.onXianJieEntityDataChange,self.onXianJieEntityDataChange)
local openFlag=systemModel.isOpen(SYSTEM_DEFINE.eZongMengSuit)
self.skinBtn:setActive(openFlag)
if openFlag then
self:freshReddot()
self:addReddotNotify(REDDIT_TYPE.eHeadKuang,function(...)self:freshReddot()end)
end
self.teQuanCD={}
self:addNotify(notifyConfig.onChangeXianGuanJob,self.onChangeXianGuanJob)
end


function UIXianJie_selfZmInfoWin:__delete()
self:unbindComponents()
xianjieController:closeWin2('UIXianJie_selfZmInfoWin')
local zmData=xianjieModel:getMyZongMenData()
if zmData then
zmData:selectEntity(false)
end
self:stopSelfTimerMJSL()
_this=nil
end




function UIXianJie_selfZmInfoWin:onShow(argtable,afterOnloaded)
local zmData=xianjieModel:getMyZongMenData()
if zmData==nil then
self:closeSelf()
else
self:refreshInfo(zmData)
end
if afterOnloaded then
if zmData then
zmData:selectEntity(true)
end
end

if argtable.extra==1 then
self:onFHZBtn()
elseif argtable.extra==2 then
self:onMeHelpBtn()
end


if systemModel.isOpen(SYSTEM_DEFINE.eXianJieBiaoJi)then
self.xjbjbtn:setActive(false)
local actorid=playerModel:getActorID()
local pos=xianmengModel:getXMMemberPost(actorid)
if pos then
if pos==GUILD_POST_TYPE.gpAllyLeader or pos==GUILD_POST_TYPE.gpViceLeader then
self.xjbjbtn:setActive(true)
end
end
else
self.xjbjbtn:setActive(false)
end

self.FHZBtn:setActive(not xianjieController:checkInMoGongZhengDuo())
end

function UIXianJie_selfZmInfoWin.onChangeXianGuanJob()
_this:refreshLeftBtns()
end



function UIXianJie_selfZmInfoWin.onXianJieCameraMove()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end

function UIXianJie_selfZmInfoWin.onXianJieCameraZoom()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end

function UIXianJie_selfZmInfoWin.onClickXianJiePlane(gridX,gridZ,worldX,worldZ)
if _this==nil or not _this.isVisible then return end
_this:onCloseClick()
end

function UIXianJie_selfZmInfoWin.onXianJieMonsterChange(typo,infoguid)
if _this==nil or not _this.isVisible then return end
if typo==CHANGE_TYPE.eDelete then
if tostring(_this.infoguid)==tostring(infoguid)then
xianjieController:closeWin3()
end
end
end

function UIXianJie_selfZmInfoWin.onChangeXianGuanJob(jobInfo)
if _this==nil or not _this.isVisible then return end
if jobInfo.actorid==playerModel:getActorID()then
_this:refreshView()
end
end

function UIXianJie_selfZmInfoWin.onXianJieBuffFresh(buffid)
if _this==nil or not _this.isVisible then return end
_this:refreshView()
end

function UIXianJie_selfZmInfoWin.onXianJieEntityDataChange(posTable,actorid)
if _this==nil or not _this.isVisible then return end
if actorid==_this.actorId then
_this:refreshView()
end
end

function UIXianJie_selfZmInfoWin:freshReddot()
self.skinBtnReddot:setActive(UISettingModel:hasZongMenReddot())
end



function UIXianJie_selfZmInfoWin:onHide()

end

function UIXianJie_selfZmInfoWin:onShowArgRecv(argtable)
self:refreshView()
end

function UIXianJie_selfZmInfoWin:refreshView()
local zmData=xianjieModel:getMyZongMenData()
if zmData==nil then
self:closeSelf()
else
self:refreshInfo(zmData)
end
end

function UIXianJie_selfZmInfoWin:refreshInfo(zmData)
if zmData==nil then
zmData=xianjieModel:getMyZongMenData()
end
if zmData==nil then return end


local gridX_c,gridZ_c=zmData:getCenterGridPosFloor()
local pos_str=FMT.fmt('（X:{0},Y:{1}）',gridX_c,gridZ_c)
self.posTxt:setText(pos_str)
self.sharex=gridX_c
self.sharez=gridZ_c


playerController:setHeadIcon(self.winlua,self.headIconCreater:getID(),{iconInfo=nil,scale=0.82})


local nameStr=playerModel:getActorName()
self.playerName:setText(nameStr)


local zmName=UISettingModel:getZMName()
self.zmNameText:setText(zmName)


local fight=playerModel:getActorFightValue()
self.zmFightValueText:setText(mathHelper.formatNumber3(fight))


local hasXM=xianmengModel:hasXM()
local xmWidget=self.xmItem:getWidgetBase()
xmWidget:SetChildActive(1,hasXM)
xmWidget:SetChildActive(4,hasXM)
local xmName_str
if hasXM then
local xmData=xianmengModel:getMyXMDetialData()
xmName_str=xmData.guildname
local abname=globalABLookup.xianmengicons
local image=xianmengModel.splitGuildIcon(xmData.guildicon)

xmWidget:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

xmWidget:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

xmWidget:SetChildCSImageSprite(3,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))


local guildid=xmData.guildid
xmWidget:SetChildButtonClick(4,function()
return xianmengController:openXMDetailInfoWin(guildid)
end,true)
else
xmName_str='无'
end
xmWidget:SetChildText(0,xmName_str)


local ownersceneidx=zmData.ownersceneidx
if ownersceneidx and ownersceneidx~=0 then
local xyNameStr=xianjieController:getCrossServerNamebySCidx(ownersceneidx)
local selfSceneidx=xianjieModel:getXianYuSceneIndex()
if ownersceneidx~=selfSceneidx then

xyNameStr=FMT.cfmt(FONT_COLOR.eRedColor,"【异界】{0}",xyNameStr)
end
self.xyNameText:setText(xyNameStr)
self.xyItem:setActive(true)
else
self.xyItem:setActive(false)
end


self:refreshBtnPanel()


self:refreshLYMSPanel()

self:refreshLeftBtns()

self:freshMoJieShiLiItem()
self:freshMoJiePnael()
self:freshMoJieSkillPnael()
end

local on_tequan_click={
[XIANGUAN_PRIVILEGE_ENUM.eTqType_17]=function(self,btnInfo)
local actorId=playerModel:getActorID()
local zmData=xianjieModel:getZongMenData(actorId)
if zmData==nil then
UIManager.error('进入仙界后方可使用')
return
end
if not xianjieModel:checkMoJunTiaoZhanRange(zmData.gridX,zmData.gridZ,zmData.gridWidth,zmData.gridHeight)then
UIManager.error('无法在魔君挑战区域内使用')
return
end
local xgid=tianshudazhenModel:getXgJobId()
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_17

if not xianguanModel:callTeQuanObjFunc(xgid,tqid,'checkUseCondition')then
return
end
local func=function()
tianshudazhenModel:useShenDunTeQuan(actorId)
end
local isOpenTianShuShenDun=xianjieModel:isOpenTianShuShenDun(actorId)
local isOpenFangHuZhao=xianjieModel:isOpenFangHuZhao(actorId)

if isOpenTianShuShenDun or isOpenFangHuZhao then
local desc='使用天枢神盾可无视煞气入侵，\n立即激活<color=#c0703b>12小时</color>天枢大阵，\n是否立即使用？'
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,func)
return
end

local desc='使用天枢神盾可无视煞气入侵，\n立即激活<color=#c0703b>12小时</color>天枢大阵，\n是否立即使用？'
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,func)
end,
[XIANGUAN_PRIVILEGE_ENUM.eTqType_18]=function(self,btnInfo)
UIFullTeQuanUseRangeEditorController:enterQuanXianEditor(btnInfo)
end,
[XIANGUAN_PRIVILEGE_ENUM.eXianGuanCiFu]=function(self,btnInfo)
UIFullTeQuanUseRangeEditorController:enterQuanXianEditor(btnInfo)
end,
}

function UIXianJie_selfZmInfoWin:refreshLeftBtns()

local btnlist={}

local entityId=xianjieModel:getMyZongMenData():getID()

if tianshudazhenModel:hasXgsdTq()then
local xgid=tianshudazhenModel:getXgJobId()
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_17
local args={xgid=xgid,tqid=tqid,entityId=entityId,refreshCD=true}
btnlist[#btnlist+1]=args
end
if tianshudazhenModel:hasXgjlTq()then
local xgid=tianshudazhenModel:getXgJobId()
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_18
local args={xgid=xgid,tqid=tqid,entityId=entityId,refreshCD=true}
btnlist[#btnlist+1]=args
end

local isTeQuan=xianguanController:checkSelfHasTeQuanByType(XIANGUAN_PRIVILEGE_ENUM.eXianGuanCiFu,XIANGUAN_TYPE_ENUM.eFuLuXianShi)
local isFLXS,gzId=xianguanController:checkSelfHasJobByType(XIANGUAN_TYPE_ENUM.eFuLuXianShi)
if isFLXS and isTeQuan then
local tqid=XIANGUAN_PRIVILEGE_ENUM.eXianGuanCiFu

local args={xgid=gzId,tqid=tqid,entityId=entityId}
btnlist[#btnlist+1]=args
end



local len=#btnlist
self.btnlist=btnlist
self.winlua:SetChildLayoutGroupCreateItems(self.btnCreator:getID(),len,function(index)
local widget=self.winlua:GetChildLayoutGroupGridItem(self.btnCreator:getID(),index-1)
local btnInfo=btnlist[index]
self:refreshTqWidget(widget,btnInfo)
end)
end

function UIXianJie_selfZmInfoWin:refreshTqWidget(widget,btnInfo)
local short=timeHelper.getServerShortTime()
local xgid=btnInfo.xgid
local tqid=btnInfo.tqid
local abname=globalABLookup.xgbigicon
local maxcnt=xianguanModel:callTeQuanObjFunc(xgid,tqid,'getMaxTimes')
local cnt=xianguanModel:callTeQuanObjFunc(xgid,tqid,'getLeftTimes')
local tqCfg=cfg_xianguanprivilegeconfig_get(tqid)
local reset=tqCfg.reset

local useCntStr=''
if reset==1 or reset==2 then
useCntStr=cnt>0 and FMT.fmt('本日:<color=#aae252>{0}/{1}</color>',cnt,maxcnt)or
FMT.fmt('本日:<color=#c82c2c>{0}</color><color=#aae252>/{1}</color>',cnt,maxcnt)
elseif reset==3 or reset==4 then
useCntStr=cnt>0 and FMT.fmt('本周:<color=#aae252>{0}/{1}</color>',cnt,maxcnt)or
FMT.fmt('本周:<color=#c82c2c>{0}</color><color=#aae252>/{1}</color>',cnt,maxcnt)
elseif reset==0 then
useCntStr=cnt>0 and FMT.fmt('剩余:<color=#aae252>{0}</color>',cnt)or
'剩余:<color=#c82c2c>0</color>'
end
local bigicon=tqCfg.bigicon
widget:SetChildButtonClick(0,function()
if not self or self.isClose then return end
if on_tequan_click[tqid]then
on_tequan_click[tqid](self,btnInfo)
end
end,true)
widget:SetChildActive(1,true)
if btnInfo.refreshCD then
local leastTime=xianguanModel:callTeQuanObjFunc(xgid,tqid,'getCdLeft')or 0
if leastTime>0 then
self.teQuanCD[tqid]=short+leastTime
widget:SetChildText(2,FMT.fmt("<color=#F36666>{0}</color>",timeHelper.format_time_stamp(leastTime)))
if not self.cdTimer then
self:startCDTimer()
end
else
widget:SetChildText(2,useCntStr)
end
else
widget:SetChildText(2,useCntStr)
end

widget:SetChildActive(3,true)
widget:SetChildCSImageSprite(4,abname,bigicon)
end

function UIXianJie_selfZmInfoWin:startCDTimer()
self.cdTimer=self:setTimer(1,0,function()
self:updateCDTimer()
if not next(self.teQuanCD)then
self:stopTimerByID(self.cdTimer)
self.cdTimer=nil
end
end)
end

function UIXianJie_selfZmInfoWin:updateCDTimer()
local nowTime=timeHelper.getServerShortTime()
local btnlist=self.btnlist
local grids=self.winlua:GetChildLayoutGroupGridList(self.btnCreator:getID())
for i=1,grids.Count do
local widget=grids[i-1]
if widget then
local btnInfo=btnlist[i]
local tqid=btnInfo.tqid
local cd=self.teQuanCD[tqid]
if cd then
local leastTime=cd-nowTime
local temp=leastTime>0
if temp then
widget:SetChildText(2,FMT.fmt("<color=#F36666>{0}</color>",timeHelper.format_time_stamp(leastTime)))
else
self.teQuanCD[tqid]=nil
self:refreshTqWidget(widget,btnInfo)
end
end
end
end
end

function UIXianJie_selfZmInfoWin:refreshBtnPanel()

local isShowShareBtn=not xianjieController:checkInPlotScene2()
self.shareBtn:setActive(isShowShareBtn)
end

function UIXianJie_selfZmInfoWin:refreshLYMSPanel()

local jobType=XIANGUAN_TYPE_ENUM.eLingYinMiShi
local isLYMS,jobId=xianguanController:checkSelfHasJobByType(jobType)
local isShowLymsPanel=false
if isLYMS then
local privilegeId=XIANGUAN_PRIVILEGE_ENUM.eTianMuGeShi

local isHasTq=xianguanConfig.checkJobCfgHasTeQuan(jobId,privilegeId)
if isHasTq and xianguanHelper.checkTeQuanPlatformLimit(privilegeId)and xianguanHelper.checkSpecialUseCondition(jobId,privilegeId,false)then
self.lymsPanel:setActive(true)
isShowLymsPanel=true
local widget=self.lymsPanel:getWidgetBase()

widget:SetChildButtonClick(-1,function()
if _this==nil or not _this.isVisible then return end
return _this:onLYMSPanelClick()
end,true)


local privilegeCfg=cfgHelper.get1(cfg_xianguanprivilegeconfig_get,privilegeId)
local iconName=xianguanConfig.getTeQuanIconName(privilegeCfg.icon)
local abName="ui/icons/xianguantequan/xianguantequan_atlas_pak.ab"
widget:SetChildCSImageSprite(1,abName,iconName)


local actorId=playerModel:getActorID()
local isValid=xianjieModel:isZmInvisible(actorId)


local str
if isValid then
str="非战争狂热时，只有盟友可见"
else
str="战争狂热中，天幕隔世特权失效"
end
widget:SetChildText(2,str)
end
end
self.lymsPanel:setActive(isShowLymsPanel)
end




function UIXianJie_selfZmInfoWin:onRuleBtn()
local ruleLangIdList=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'ruleLangIdList')
local ruleType=xjRuleTipsType.eZongMen
local langId=ruleLangIdList and ruleLangIdList[ruleType]or''








local screenPos=self.ruleBtn:getChildUIScreenPos(false)
screenPos.x=screenPos.x-50
local winParams={
parentWin=self,
lang=langId,
num=nil,
screenPos=screenPos,
}
self:showWindow("UIXianJie_commonRuleWin",winParams)
end



function UIXianJie_selfZmInfoWin:onRecordBtn()
local zmData=xianjieModel:getMyZongMenData()
local zmName=playerModel:getActorName()
local temp=
{
gridX=self.sharex,
gridZ=self.sharez,
Point_Share=xianjie_Point_Share.zongmen,
nameStr=zmName,
sharename=zmName,
ishujian=false,
}
UIManager:showWindow("UIXianJieRecAddWin",temp)
end



function UIXianJie_selfZmInfoWin:onShareBtn()
local zmName=UISettingModel:getZMName()
local nameStr=playerModel:getActorName()
local _sceneType=xianjieModel:getScenceType()
local data=
{
x=self.sharex,
y=self.sharez,
icon1="icon_sjgdbiaoshi_1",
msgName=zmName,
shareType=xianjie_Point_Share.zongmen,
scenceType=_sceneType,
name=zmName,
shareName=nameStr,
}
local str=xianjieController:getShareStr(data)
str=chatLinkHelper.clearLink(str)
local sceneidx=xianjieModel:getSceneIndex(_sceneType)
local jsonStr=jsonHelper.encode({data.shareType,data.shareName,sceneidx,data.x,data.y})
local args={
channels={CHAT_CHANNNEL.eWorld,CHAT_CHANNNEL.eKuafu,CHAT_CHANNNEL.eXianmeng},
counterType=gameCounterType.eXianjiePointShareNum,
regexType=CHAT_REGEX_TYPE.csFairyLand,
descStr=str,
jsonStr=jsonStr,
title='坐标分享',
shareName=data.msgName,
sharePosStr=FMT.fmt('X <color=#171311>{0},</color> Y <color=#171311>{1}</color>',data.x,data.y)
}
UIManager:showWindow("UICommonShareTwoWin",args)
end

function UIXianJie_selfZmInfoWin:onFHZBtn()
self:showWindow('UITianShuDaZhenUseWin')
end



function UIXianJie_selfZmInfoWin:onZmBuffBtn()
end



function UIXianJie_selfZmInfoWin:onBackZmBtn()
mainControl:enterHome({eSceneType.eZongmen})
end



function UIXianJie_selfZmInfoWin:onSkinBtn()
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eSetting_ZongMen,{itemId=-1})
end

function UIXianJie_selfZmInfoWin:onMask()
xianjieController:closeWin('UIXianJie_selfZmInfoWin')
end

function UIXianJie_selfZmInfoWin:onMeHelpBtn()
local actorId=playerModel:getActorID()
YingXianGeController.reqZhiYuan(actorId)
UIManager:showWindow('UIYingXianGeWDYJWin')
end

function UIXianJie_selfZmInfoWin:onLYMSPanelClick()
local widget=self.lymsPanel:getWidgetBase()
local posVector2=widget:GetChildScreenPointToLocalPointRectangle(1)
local pos={posVector2.x,posVector2.y}
local offset={-210,85}
local privilegeId=XIANGUAN_PRIVILEGE_ENUM.eTianMuGeShi
local args={
privilegeId=privilegeId,
}
UIManager:showWindow("UIXianGuanPrivilegeTipsWin",{pos=pos,showData=args,offset=offset,arrowType=2,})
end

function UIXianJie_selfZmInfoWin:onXjbjbtn()
local _posx=self.sharex
local _posy=self.sharez
local _sceneidx=xianjieModel:getSceneIndex()
local cbid=xianjieController.getZuoBiaoType(2)
xianjieController.openBJwin(_posx,_posy,_sceneidx,cbid)
end


function UIXianJie_selfZmInfoWin:freshMoJiePnael()
local isMJtime=xianjieController:CheckMoJieSaiJieActityeTime()
if isMJtime then
self:freshMoJiBuffnum()
local widget=self.mjslpanel:getWidgetBase()
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMoJiBuffClick(widget)
end)
else
self.mjslpanel:setActive(false)
end
end

function UIXianJie_selfZmInfoWin:freshMoJiBuffnum()
local zmData=xianjieModel:getMyZongMenData()
local buffTemp={}
local buffNum=0

if zmData and zmData.bufflistlen>0 then
local buffList_lookup=zmData.buffList or{}
buffTemp,buffNum=xianjieController:handleFaZeDieJia(buffList_lookup)
end
local widget=self.mjslpanel:getWidgetBase()
widget:SetChildText(1,buffNum)
if buffTemp and next(buffTemp)then
self.mjslpanel:setActive(true)
else
self.mjslpanel:setActive(false)
end
end

function UIXianJie_selfZmInfoWin:onMoJiBuffClick(_posWidget)
local zmData=xianjieModel:getMyZongMenData()
local buffTemp={}
local buffNum=0
if zmData.bufflistlen>0 then
local buffList_lookup=zmData.buffList or{}
buffTemp,buffNum=xianjieController:handleFaZeDieJia(buffList_lookup)
end
local widget=_this.mjslpanel:getWidgetBase()
widget:SetChildText(1,buffNum)


if buffTemp and next(buffTemp)then
self:showWindow('UIMoJieShiLiBuffTips',{posWidget=_posWidget,posWidgetIndex=0,pos={x=-265,y=65},bufflsit=buffTemp})
else
UIManager.info('暂无获得的魔界势力状态')
end
end

function UIXianJie_selfZmInfoWin:freshMoJieShiLiItem()
local isopen=xianjieController:CheckMoJieShiLiSkillZongMenBtn()
if isopen then
local forceid=xianjieController:getForce()
if forceid and forceid>0 then
self.slItem:setActive(true)
local cfg=cfg_devildomforceconfig_get(forceid)
self.slNameText:setText(cfg.name)
local abname='ui/windows/xiangong/xiangong_atlas_pak.ab'
local Icons={[1]='image_xiangongrenwu_bs2',[2]='image_xiangongrenwu_bs3',[3]='image_xiangongrenwu_bs1'}
self.winlua:SetChildCSImageSprite(self.mjtag:getID(),abname,Icons[forceid])
else
self.slItem:setActive(false)
end
end
end



function UIXianJie_selfZmInfoWin:freshMoJieSkillPnael()
local isopen=xianjieController:CheckMoJieShiLiSkillZongMenBtn()
if isopen then
local forceid=xianjieController:getForce()
if forceid>0 and not xianjieController:getShiLiDebuffCheck(forceid)then
local Skillidx,Taskidx=xianjieController:getForceCfg()
if Skillidx==nil then
self.mjslskill:setActive(false)
logErr(FMT.fmt('获取势力配置为nil,查看魔界赛季配置表的force字段'))
return
end
self.mjslskill:setActive(true)
self.skillcfg=xianjieController:getForceSkillCfg(forceid,Skillidx)
local skillcfg=self.skillcfg
local widget=self.mjslskill:getWidgetBase()
widget:SetChildText(slskillidx.name,skillcfg.name)
local iconName=iconHelper.getSkillIcon(skillcfg.skillicon)
widget:SetChildCSImageIcon(slskillidx.icon,iconName,false)
widget:SetChildButtonClick(slskillidx.skillbtn,function()
if _this==nil then return end
_this:onUseMoJiSkillbtn()
end)
self:CheckUseMoJiSkillTime()
else
self.mjslskill:setActive(false)
end
else
self.mjslskill:setActive(false)
end
end

function UIXianJie_selfZmInfoWin:onUseMoJiSkillbtn()
local sceneidx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoJie(sceneidx)then
local lastsec=xianjieController:getForceLastsec()
local curTime=timeHelper.getServerShortTime()
local skilldata=self.skillcfg.skill
local lvl=xianjieController:getForceSkilllv()
local skill_data=skilldata[lvl]
local skill_time=skill_data[2]
local endTime=lastsec+skill_time
if endTime>curTime then
UIManager.info('技能冷却中')
return
end
local actorid=playerModel:getActorID()


local _fun=function()
xianjieController:useMoJieShiLiSkill(actorid)
end
local UseSkilldesc=self.skillcfg.UseSkilldesc
local skillname=self.skillcfg.name
local parem1=UseSkilldesc[1]
local parem2=UseSkilldesc[2][lvl]
local strdesc=''
xpcall(function()
strdesc=FMT.fmt(parem1,unpack(parem2))
end,function(err)
logErr(FMT.fmt('魔界势力技能参数报错，配置字段UseSkilldesc,技能名字：{0},技能等级：{1}',skillname,lvl))
end)
local str=FMT.fmt("是否使用<color=#ca631d>【{0}】</color>技能\n\n{1}",skillname,strdesc)
xianjieController:showUseSkillWin(_fun,str)
else
UIManager.info('势力技能只能在魔界使用')
end
end

function UIXianJie_selfZmInfoWin:serverMoJiSkill()
if _this==nil then return end
_this:CheckUseMoJiSkillTime()
local forceid=xianjieController:getForce()
if forceid==MJForceType.eJiuYuan then
local actorid=playerModel:getActorID()
local zmData=xianjieModel:getZongMenData(actorid)
if zmData then
xianjieController:onRefreshSkillJiuYuanAddEffect2(zmData)
end
end
end

function UIXianJie_selfZmInfoWin:CheckUseMoJiSkillTime()
local widget=self.mjslskill:getWidgetBase()
local lastsec=xianjieController:getForceLastsec()
local curTime=timeHelper.getServerShortTime()
local skilldata=self.skillcfg.skill
local lvl=xianjieController:getForceSkilllv()
local skill_data=skilldata[lvl]
local skill_time=skill_data[2]
local endTime=lastsec+skill_time
if endTime>curTime then

widget:SetChildActive(slskillidx.djsbg,true)
widget:SetChildGray(slskillidx.icon,true)
self:stopSelfTimerMJSL()
local timeStr=timeHelper.format_time_stamp(endTime-curTime,true)
widget:SetChildText(slskillidx.djs,timeStr)
local func=function()
local serTime=timeHelper.getServerShortTime()
local dtTime=endTime-serTime
local showTime=dtTime>=0 and dtTime or 0
timeStr=timeHelper.format_time_stamp(showTime,true)
widget:SetChildText(slskillidx.djs,timeStr)
if dtTime<=0 then
self:stopSelfTimerMJSL()
widget:SetChildActive(slskillidx.djsbg,false)
widget:SetChildGray(slskillidx.icon,false)
end
end
self.timermjsl=self:setTimer(1,0,func)
else
widget:SetChildActive(slskillidx.djsbg,false)
widget:SetChildGray(slskillidx.icon,false)
end
end
function UIXianJie_selfZmInfoWin:stopSelfTimerMJSL()
if self.timermjsl then
self:stopTimerByID(self.timermjsl)
self.timermjsl=nil
end
end

function UIXianJie_selfZmInfoWin:testtttt1()
local zmData=xianjieModel:getMyZongMenData()


end
function UIXianJie_selfZmInfoWin:testtttt2()
local list=
{






[1]={buffid=60209,endsec=0},
[2]={buffid=60209,endsec=0},
}
local buffTemp,buffNum=xianjieController:handleFaZeDieJia(list)


end
