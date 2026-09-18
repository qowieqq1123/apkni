







def_class("UISectPalaceInfoWin",UIWindowBase)









function UISectPalaceInfoWin:bindComponents()

self.lingpaiIcon=UIImage.get(self,0)
self.bdSkinReddot=UIObject.get(self,1)
self.discipleRoot=UIObject.get(self,2)
self.tipsText=UIText.get(self,3)
self.postIcon=UIImage.get(self,4)
self.buildModel=UIObject.get(self,5)
self.descText1=UIText.get(self,6)
self.descText2=UIText.get(self,7)
self.bdSkinBtn=UIButton.get(self,8)
self.levelText=UIText.get(self,9)
self.levelupBtn=UIText.get(self,10)
self.levelupReddot=UIObject.get(self,11)
self.posBtnText=UIText.get(self,12)
self.lingpaiNum=UIText.get(self,13)
self.xiuweiNum=UIText.get(self,14)
self.frdNum=UIText.get(self,15)

self.bdSkinBtn:setButtonClick(function()self:onBdSkinBtn()end)



end


function UISectPalaceInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.lingpaiIcon);self.lingpaiIcon=nil;
_UIObject_release(self.bdSkinReddot);self.bdSkinReddot=nil;
_UIObject_release(self.discipleRoot);self.discipleRoot=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.postIcon);self.postIcon=nil;
_UIObject_release(self.buildModel);self.buildModel=nil;
_UIObject_release(self.descText1);self.descText1=nil;
_UIObject_release(self.descText2);self.descText2=nil;
_UIObject_release(self.bdSkinBtn);self.bdSkinBtn=nil;
_UIObject_release(self.levelText);self.levelText=nil;
_UIObject_release(self.levelupBtn);self.levelupBtn=nil;
_UIObject_release(self.levelupReddot);self.levelupReddot=nil;
_UIObject_release(self.posBtnText);self.posBtnText=nil;
_UIObject_release(self.lingpaiNum);self.lingpaiNum=nil;
_UIObject_release(self.xiuweiNum);self.xiuweiNum=nil;
_UIObject_release(self.frdNum);self.frdNum=nil;
end
















local _this=nil


function UISectPalaceInfoWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
self:addNotify(notifyConfig.onProsperityChange,function(...)self:onProsperityChange(...)end)
end


function UISectPalaceInfoWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end


function UISectPalaceInfoWin:onHide()

end

function UISectPalaceInfoWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if _this==nil then return end
if etype==buildingEvent.levelUpStart then
_this:refreshLevelView()
elseif etype==buildingEvent.levelUpComplete then
_this:refreshLevelView()
elseif etype==buildingEvent.speedUpComplete then
_this:refreshLevelView()
end
end

function UISectPalaceInfoWin:onProsperityChange()
self:refreshView()
end




function UISectPalaceInfoWin:onShow(argtable,afterOnloaded)

local entityID=argtable.entityID
self.sfId=mapIdType.zhufeng
self.entityID=entityID
local bdData=zongmenModel:findBuildingByEntityId(self.entityID)
self.postType=eZongMenPostType.eZhangMen


local pIcon=UISectPalaceModel:getPostIcon(self.postType)
self.postIcon:setSprite(globalABLookup.diciplemain,pIcon)

self:my_onShow()
end

function UISectPalaceInfoWin:my_onShow()
local list=UIDiscipleModel:getDiscipleByZongMenPost(self.postType)or{}
self.hasZhangMen=#list>0
if self.hasZhangMen then
self.zhangmen_data=list[1]
end

self:refreshZhangMenInfo()
self:refreshView()
self:refreshLevelView()
end

function UISectPalaceInfoWin:onShowArgRecv(argtable)
self:my_onShow()
end

function UISectPalaceInfoWin:refreshView()
local bdData=zongmenModel:findBuildingByEntityId(self.entityID)

local mdata=isometricMapSystem:getModelByStatus(bdData.build_id,bdData.level,0,nil,nil,nil,bdData.un_build_id,nil,true)



local modelID=mdata.model
local scale=isometricMapSystem:getModelScale(modelID,true)

if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.buildModel:getID(),true,true,true)
end
self.buildModel:setChildUIModelShowTarget(modelID,scale*0.8,nil,eAnimationID.stand)

self.descText1:setText(cfgHelper.get1(cfg_lang_get,'sectpalace_desc_1'))
self.descText2:setText(cfgHelper.get1(cfg_lang_get,'sectpalace_desc_2'))

self.lingpaiIcon:setImageIcon(moneyModel.getIconNameEx(eMoneyType.mtLingPai),true)
local lpmax=moneyModel.getMoneyMax(eMoneyType.mtLingPai)
local lp_str=FMT.fmt('宗门令牌存储上限：    <color=#7d3b17>{0}</color>',lpmax)
local add=moneyModel.getMoneyMaxAdd(eMoneyType.mtLingPai)
if add~=nil and add>0 then
lp_str=FMT.fmt('{0}<color=#549327>(+{1})</color>',lp_str,add)
end
self.lingpaiNum:setText(lp_str)

local xw_rate=0
if self.hasZhangMen then
local jjlv=self.zhangmen_data.jingjielv
local rate=cfgHelper.get3(cfg_guildposconfig_get,eZongMenPostType.eZhangMen,'effect_xiuwei',jjlv)
xw_rate=rate or 0
end
self.xiuweiNum:setText(FMT.fmt('弟子修为获取效率：<color=#7d3b17>{0}%</color>',xw_rate))


local isShowFrd=systemModel.isOpen(SYSTEM_DEFINE.eProsperity)
self.frdNum:setActive(isShowFrd)
if isShowFrd then
local frdData=prosperityModel:getBuildingProsperityValueByGuid(bdData.un_build_id)
self.frdNum:setText(FMT.fmt('宗门大殿繁荣度：<color=#7d3b17>{0}</color>',frdData.totalFR))
end


self:refreshBdSkinBtn()
end

function UISectPalaceInfoWin:refreshZhangMenInfo()
self.discipleRoot:setActive(self.hasZhangMen)
local rootWidget=self.discipleRoot:getChildWidgetBase()
if self.hasZhangMen then
local netData=self.zhangmen_data
local dis_guid=netData.discipleguid

rootWidget:SetChildUIModelRemoveTarget(0)
comHelper.setChildInSideModel2(rootWidget,dis_guid,0,0.85,nil,0,0,false,true,-1)

local dis_name=UIDiscipleModel:getDiscipleName(dis_guid)
rootWidget:SetChildText(1,dis_name)

rootWidget:SetChildActive(2,true)
local infoWidget=rootWidget:GetChildWidgetBase(2)

local sectstr=UISettingModel:getZMName()
if sectstr==nil or sectstr==''then sectstr='暂无'end
infoWidget:SetChildText(0,FMT.fmt('<color=#7d3b17>门派：</color>{0}',sectstr))

local jobstr=UIDiscipleModel:getJobNameX(dis_guid)
infoWidget:SetChildText(1,FMT.fmt('<color=#7d3b17>职业：</color>{0}',jobstr))

local jjlv=netData.jingjielv
local jjstr=UIDiscipleModel:getJJName4(jjlv)
infoWidget:SetChildText(3,FMT.fmt('<color=#7d3b17>境界：</color>{0}',jjstr))

local ltlv=netData.liantilv
local ltstr=UIDiscipleModel:getLTName4(ltlv)
infoWidget:SetChildText(2,FMT.fmt('<color=#7d3b17>炼体：</color>{0}',ltstr))


self.tipsText:setText('')
else

rootWidget:SetChildUIModelRemoveTarget(0)
rootWidget:SetChildActive(2,false)

self.tipsText:setText('尚未委任掌门')
end
local btn_str=self.hasZhangMen and'更换'or'委任'
self.posBtnText:setText(btn_str)
end

function UISectPalaceInfoWin:onPosBtnClick()
local bdData=zongmenModel:findBuildingByEntityId(self.entityID)
UIFullSectPalaceControl:showMyWindow(FULL_TAB_TYPE.eSectPalacePost,{entityID=bdData.entityId})
end

function UISectPalaceInfoWin:onLvUpClick()
local bdData=zongmenModel:findBuildingByEntityId(self.entityID)
UIManager:showWindow('UIBuildingInfoWin',bdData)
end

function UISectPalaceInfoWin:refreshLevelView()
local bdData=zongmenModel:findBuildingByEntityId(self.entityID)
local lv=bdData.level
self.nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,lv+1)
if self.nextLvCfg then
if bdData.flag==buildingStateType.eUpgrading then
self:refreshUpgradePanel()
else
self.levelupBtn:setText('建筑升级')
self:refreshLevelDesc(FMT.fmt('{0}级',lv))


local reddot=zongmenControl:checkLevelUp(self.nextLvCfg)
self.levelupReddot:setActive(reddot)
end
else
self.levelupBtn:setText('建筑信息')
self:refreshLevelDesc(FMT.fmt('{0}级',lv))


self.levelupReddot:setActive(false)
end
end

function UISectPalaceInfoWin:refreshUpgradePanel()
local bdData=zongmenModel:findBuildingByEntityId(self.entityID)
local beginTime=bdData.begintime
if beginTime>0 then
local upgrade_need_time=self.nextLvCfg.uplevel_times
local delta_time=gameUtilityModel.getServerShortTime()-beginTime+bdData.reducetime
local ctime=upgrade_need_time-delta_time
if ctime>0 then
self:stopLevelUpTimer()
local endtime=os.time()+ctime
local tick=function()
local dtime=endtime-os.time()
if dtime>0 then
self:refreshLevelDesc(timeHelper.format_time_stamp4(dtime),false)
else
self:stopLevelUpTimer()
self:refreshUpgradePanel()
end
end
tick()
self.levelupBtn:setText('加速升级')
self.levelUpTimer=self:setTimer(1,0,tick)


self.levelupReddot:setActive(false)
return
end
end

self:stopLevelUpTimer()
self.levelupBtn:setText('完成升级')
self:refreshLevelDesc('完成升级')


self.levelupReddot:setActive(false)
end

function UISectPalaceInfoWin:refreshLevelDesc(str,prefix)
local fmt_str
if prefix~=false then
fmt_str='大殿等级：<color=#7d3b17>{0}</color>'
else
fmt_str='<color=#7d3b17>{0}</color>'
end
self.levelText:setText(FMT.fmt(fmt_str,str))
end

function UISectPalaceInfoWin:stopLevelUpTimer()
if self.levelUpTimer then
self:stopTimerByID(self.levelUpTimer)
self.levelUpTimer=nil
end
end

function UISectPalaceInfoWin:refreshBdSkinBtn()
local reddot=false
local isShowSkinBtn=false
local bdData=UISectPalaceController:getBuildData()
if bdData then
local build_id=bdData.build_id
isShowSkinBtn=bdData and buildSkinModel:checkBuildCanChangeSkin(build_id)or false
if isShowSkinBtn then
reddot=buildSkinModel:checkBuildSkinUnLockReddotByBuildId(build_id)
end
end
self.bdSkinBtn:setActive(isShowSkinBtn)
self.bdSkinReddot:setActive(reddot)
end

function UISectPalaceInfoWin:onBdSkinBtn()
local activeUI=fullScreenUI.activeUI
local argstable=activeUI.attach
if activeUI.attach then
argstable=activeUI.attach
else
argstable={}
end
local guid=argstable.entityId or argstable.entityID
if guid then
local bdData=zongmenModel:findBuildingByEntityId(guid)
if bdData then
local build_id=bdData.build_id
local un_build_id=bdData.un_build_id

buildSkinController:showBuildSkinListWin(build_id,un_build_id)
end
end
end