







def_class("UIDLRoomWin",UIWindowBase)








function UIDLRoomWin:bindComponents()

self.infoPanel=UIObject.get(self,0)
self.selectBtn=UIButton.get(self,1)
self.txtDzSpeak_2=UIText.get(self,2)
self.effectDL=UIObject.get(self,3)
self.dzSpeak_2=UIObject.get(self,4)
self.dzSpeak_1=UIObject.get(self,5)
self.effectXL=UIObject.get(self,6)
self.effectSX=UIObject.get(self,7)
self.singleBg=UIImage.get(self,8)
self.dzEmpty=UIObject.get(self,9)
self.jiuzhiRedot=UIObject.get(self,10)
self.levelUpTime=UIText.get(self,11)
self.txtUpgradeBtn=UIText.get(self,12)
self.txtDzSpeak_1=UIText.get(self,13)
self.txtLevel=UIText.get(self,14)
self.btnSwitch=UIObject.get(self,15)
self.btnSelect=UIObject.get(self,16)
self.dzModel_2=UIObject.get(self,17)
self.dzModel_1=UIObject.get(self,18)
self.gongfengtai=UIObject.get(self,19)
self.danlu=UIObject.get(self,20)
self.shanguang=UIObject.get(self,21)
self.linghunImg=UIObject.get(self,22)
self.jiuzhiImg=UIButton.get(self,23)
self.zuohuaImg=UIButton.get(self,24)
self.singlePanel=UIObject.get(self,25)
self.levelUpBg=UIObject.get(self,26)
self.btnUpgrade=UIButton.get(self,27)
self.icon=UIObject.get(self,28)
self.changeNameBtn=UIButton.get(self,29)
self.buildNameText=UIText.get(self,30)
self.txtbdLevel=UIText.get(self,31)
self.dongFuRoot=UIObject.get(self,32)
self.txtEffect=UIText.get(self,33)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.jiuzhiImg:setButtonClick(function()self:onJiuzhiImg()end)

self.zuohuaImg:setButtonClick(function()self:onZuohuaImg()end)

self.btnUpgrade:setButtonClick(function()self:onBtnUpgrade()end)

self.changeNameBtn:setButtonClick(function()self:onChangeNameBtn()end)
self.txtDzSpeak={
self.txtDzSpeak_1,
self.txtDzSpeak_2,
}
self.dzSpeak={
self.dzSpeak_1,
self.dzSpeak_2,
}
self.dzModel={
self.dzModel_1,
self.dzModel_2,
}



end


function UIDLRoomWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.txtDzSpeak_2);self.txtDzSpeak_2=nil;
_UIObject_release(self.effectDL);self.effectDL=nil;
_UIObject_release(self.dzSpeak_2);self.dzSpeak_2=nil;
_UIObject_release(self.dzSpeak_1);self.dzSpeak_1=nil;
_UIObject_release(self.effectXL);self.effectXL=nil;
_UIObject_release(self.effectSX);self.effectSX=nil;
_UIObject_release(self.singleBg);self.singleBg=nil;
_UIObject_release(self.dzEmpty);self.dzEmpty=nil;
_UIObject_release(self.jiuzhiRedot);self.jiuzhiRedot=nil;
_UIObject_release(self.levelUpTime);self.levelUpTime=nil;
_UIObject_release(self.txtUpgradeBtn);self.txtUpgradeBtn=nil;
_UIObject_release(self.txtDzSpeak_1);self.txtDzSpeak_1=nil;
_UIObject_release(self.txtLevel);self.txtLevel=nil;
_UIObject_release(self.btnSwitch);self.btnSwitch=nil;
_UIObject_release(self.btnSelect);self.btnSelect=nil;
_UIObject_release(self.dzModel_2);self.dzModel_2=nil;
_UIObject_release(self.dzModel_1);self.dzModel_1=nil;
_UIObject_release(self.gongfengtai);self.gongfengtai=nil;
_UIObject_release(self.danlu);self.danlu=nil;
_UIObject_release(self.shanguang);self.shanguang=nil;
_UIObject_release(self.linghunImg);self.linghunImg=nil;
_UIObject_release(self.jiuzhiImg);self.jiuzhiImg=nil;
_UIObject_release(self.zuohuaImg);self.zuohuaImg=nil;
_UIObject_release(self.singlePanel);self.singlePanel=nil;
_UIObject_release(self.levelUpBg);self.levelUpBg=nil;
_UIObject_release(self.btnUpgrade);self.btnUpgrade=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.changeNameBtn);self.changeNameBtn=nil;
_UIObject_release(self.buildNameText);self.buildNameText=nil;
_UIObject_release(self.txtbdLevel);self.txtbdLevel=nil;
_UIObject_release(self.dongFuRoot);self.dongFuRoot=nil;
_UIObject_release(self.txtEffect);self.txtEffect=nil;
self.txtDzSpeak=nil;
self.dzSpeak=nil;
self.dzModel=nil;
end



















local _this
local _initModel
local _format=string.format

local AIType={
walk=1,
practitioners=2,
totalNum=2
}


function UIDLRoomWin:onLoaded(...)
self:bindComponents()
_this=self
self.chuiweiLastType={}
end


function UIDLRoomWin:__delete()

self:removesingleBT()
self:removesingleChuiweiId()
uiAIManager:clearUIWinData('UIDLRoomWin')
self.chuiweiLastType=nil
self:unbindComponents()

notifySystem:removelistener(notifyConfig.onDaoLvChange,self.on_building_event)
notifySystem:removelistener(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
end




function UIDLRoomWin:onShow(argtable,afterOnloaded)


self:onShowArgRecv(argtable,afterOnloaded)
end

function UIDLRoomWin:onShowArgRecv(argtable,afterOnloaded)
notifySystem:listenNotify(notifyConfig.onDaoLvChange,self.on_building_event)
notifySystem:listenNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
self:refresh(argtable)
self:refreshBgModel()
end


function UIDLRoomWin:onHide()
notifySystem:removelistener(notifyConfig.onDaoLvChange,self.on_building_event)
notifySystem:removelistener(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
self:removesingleBT()
self:removesingleChuiweiId()
uiAIManager:clearUIWinData('UIDLRoomWin')
end


function UIDLRoomWin.onDiscipleStateChange()
_this:refreshLeft()
_this:refreshRight()
end


function UIDLRoomWin:refreshBgModel()
local bgModelId=5383
if bgModelId then
local animId=eAnimationID.stand
self.singleBg:setChildUIModelShowTarget(bgModelId,1,{},animId,false,false,0)
self.singleBg:setActive(true)
else
self.singleBg:setActive(false)
self.singleBg:setChildUIModelRemoveTarget()
end
end

function UIDLRoomWin:switchRoom(argtable)
uiAIManager:clearUIWinData('UIDLRoomWin')
self:refresh(argtable)
UIManager:invokeUIMethod('UIBottomMaskWin','setTitle',self.config.name)
end

function UIDLRoomWin:refresh(argtable)

if argtable then
local guid=argtable.entityId
self.sfId=mapIdType.zhufeng
self.homeType=argtable.showPage
self.bdData=zongmenModel:findBuildingByEntityId(guid)
self.coupleIdList=DiscipleCoupleModel:getCoupleLiveId(self.bdData.un_build_id)
self.cave_config=cfgHelper.get2(cfg_monijydaolvcaveconfig_get,self.bdData.build_id,self.bdData.level)

if self.coupleIdList then
self.dzId1=self.coupleIdList.dizi_id_1
self.dzId2=self.coupleIdList.dizi_id_2
end
end
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)

self:refreshLeft()
self:refreshRight()
end

function UIDLRoomWin:refreshLeft()
local curLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level)
local mdata_cur=isometricMapSystem:getModelByStatus(self.bdData.build_id,curLvCfg.level,0,nil,nil,nil,self.bdData.un_build_id,nil,true)
local model=mdata_cur.model
local scale=isometricMapSystem:getModelScale(model,true)
self.icon:setChildUIModelShowTarget(model,scale*0.7,nil,eAnimationID.bd_stand)
local nameStr='洞府'

self.txtLevel:setText(_format('%s级%s',curLvCfg.level,nameStr))
self.txtbdLevel:setText(_format('%s当前：<color=#7d3b17ff>%s级</color>',nameStr,curLvCfg.level))
self.txtEffect:setText(curLvCfg.effects_desc or'')
end

function UIDLRoomWin:refreshRight()
self:refreshCouplePanel()
self:refreshLevelUp()
local buildName=self.bdData.name or'暂无名字'
self:refreshBuildName(buildName)
end

function UIDLRoomWin:refreshBuildName(name)
self.buildNameText:setText(name)
end

function UIDLRoomWin:refreshLevelUp()
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)
if nextLvCfg then
self.txtUpgradeBtn:setText('升级')
if self.bdData.flag==0 then
self.levelUpBg:setActive(false)
self.txtbdLevel:setActive(true)
self:stopLevelUpTimer()
elseif self.bdData.flag==2 then
local beginTime=self.bdData.begintime-self.bdData.reducetime
if beginTime>0 then
local needTime=nextLvCfg.uplevel_times
local func=function()
local curTime=gameUtilityModel.getServerShortTime()
local dtime=curTime-beginTime
if dtime<needTime then
self.levelUpTime:setText(_format('%s',timeHelper.format_time_stamp3(needTime-dtime)))
self.txtUpgradeBtn:setText('加速升级')
else
self:stopLevelUpTimer()
self.levelUpBg:setActive(false)
self.txtbdLevel:setActive(true)
self.txtUpgradeBtn:setText('完成升级')
end
end
func()
self:stopLevelUpTimer()
self.levelUpTimer=self:setTimer(1,0,func)
self.levelUpBg:setActive(true)
self.txtbdLevel:setActive(false)
end
end
else
self:stopLevelUpTimer()
self.txtUpgradeBtn:setText('建筑信息')
self.levelUpBg:setActive(false)
self.txtbdLevel:setActive(true)
end
end

function UIDLRoomWin:stopLevelUpTimer()
if self.levelUpTimer then
self:stopTimerByID(self.levelUpTimer)
self.levelUpTimer=nil
end
end


function UIDLRoomWin:refreshCouplePanel(notfreshmodel)
self.singlePanel:setActive(true)

if self.coupleIdList then
local dzIdStr=tostring(self.dzId1)
local haveDz=dzIdStr~='0'
self.btnSelect:setActive(not haveDz)
self.btnSwitch:setActive(haveDz)
self.dzModel_1:setActive(haveDz)
self.dzModel_2:setActive(haveDz)
self.jiuzhiImg:setActive(haveDz)

if haveDz then
self.singleDzId=self.dzId1
if not notfreshmodel then
if not _initModel then
_initModel=true
self:delayDo(0.5,function(...)
self:refreshCoupleDzModel(self.dzId1,1)
self:refreshCoupleDzModel(self.dzId2,2)
end)
else
self:refreshCoupleDzModel(self.dzId1,1)
self:refreshCoupleDzModel(self.dzId2,2)
end
end
local check=self:checkChuiWei(self.dzId1)
local chuiweiType,num=UIDiscipleModel:checkChuiWeiDiscipleType(self.dzId1)
local cantZuoHua=self:checkCantZuoHua(self.dzId1)
self.jiuzhiImg:setActive(check)


if check then
local jzReddot=self:checkJiuzhiDisciple(self.dzId1)
self.jiuzhiRedot:setActive(jzReddot)
end
else
self:removesingleBT()
self:removesingleChuiweiId()
end
end
end

function UIDLRoomWin:refreshCoupleDzModel(dizi_id,index)
if tostring(dizi_id)~='0'then
self:removesingleBT(index)
self:removesingleChuiweiId()
local tran=self.dzModel[index]:getCommonComponent('Transform')
local pos=Vector2.New(-24,-118)
local chuiweiType=UIDiscipleModel:checkChuiWeiDiscipleType(dizi_id)
if chuiweiType==DISCIPLE_CHUIWEI_TYPE.eInjury then
self:createChuiWeiDZ(dizi_id,tran,pos,function(id)
self.singleChuiweiId=id
end)
else
if not self.singleBT then
self.singleBT={}
end
self:createSingleDZ(tran,dizi_id,pos,function(bt)
self.singleBT[index]=bt
end)
end
else
self.winlua:SetChildUIModelRemoveTarget(self.dzModel[index]:getID())
end
end

function UIDLRoomWin:getSingleBTData()
local stand=math.random(0,1)
local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
standPos=stand,
offset={0,0},
leftPos={-94,-118},
rightPos={24,-118},
waitflip=0,
}
return initData
end

function UIDLRoomWin:createSingleDZ(tran,dzId,pos,callback)
local initData=self:getSingleBTData()
local state=UIDiscipleModel:getDiscipleState(dzId)
local scale=0.8
if state==DISCIPLE_STATE_TYPE.eChuiWei then
scale=1
end
local otherData={
scale=scale,
}
uiAIManager:createUIDisciple('UIDLRoomWin','bt_ui_dldfRoom',dzId,tran,pos,initData,otherData,function(bt)
callback(bt)
end)
end

function UIDLRoomWin:removesingleBT(index)
if not self.singleBT then return end
if index then
if self.singleBT[index]then
uiAIManager:removeUIInstance(self.singleBT[index])
self.singleBT[index]=nil
end
else
for k,v in ipairs(self.singleBT)do
if v then
uiAIManager:removeUIInstance(v)
v=nil
end
self.singleBT={}
end
end
end

function UIDLRoomWin:removesingleChuiweiId()
if self.singleChuiweiId then
_InstantiateManager.RemoveInstance(self.singleChuiweiId)
self.singleChuiweiId=nil
end
end


function UIDLRoomWin:checkChuiWei(dzId)
local state=UIDiscipleModel:getDiscipleState(dzId)
return state==DISCIPLE_STATE_TYPE.eChuiWei
end

function UIDLRoomWin:createChuiWeiDZ(dzId,tran,pos,callback)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(dzId)
local body=imageInfo.sex==SEX_TYPE.eMale and 1114105 or 1114106
_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDisciple,tran,function(id)
local dzWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
dzWidget:SetChildAnchoredPosition(0,pos)
local dzScale=isometricMapSystem:getModelScale(body,true)
dzWidget:SetChildUIModelShowTarget(0,body,dzScale*0.8,nil,eAnimationID.stand)
dzWidget:SetChildUIModelShowFlipX(0,true)
callback(id)
end)
end


function UIDLRoomWin:checkJiuzhiDisciple(dzId)
local chuiweiType=UIDiscipleModel:checkChuiWeiDiscipleType(dzId)
local list={}
if chuiweiType==DISCIPLE_CHUIWEI_TYPE.eInjury then
list=itemsLookup:get_function_items(item_funtion_type.liaoshang)or{}
elseif chuiweiType==DISCIPLE_CHUIWEI_TYPE.eShouYuan then
list=itemsLookup:get_function_items(item_funtion_type.shouyuan)or{}
end
local itemList={}
for k,v in pairs(list)do
local num=bagModel.getItemCountById(v.id)
if num>0 then
table.insert(itemList,v)
break
end
end
if next(itemList)then
return true
else
return false
end
end

function UIDLRoomWin:jiuzhiDisciple(dzId)
self:jumpDZChuiWei(dzId)
end


function UIDLRoomWin:checkCantZuoHua(dzId,isWarning)
if not UIDiscipleModel:checkCanKickOutDzAndTips(dzId,isWarning,2)then
return true
end
return false
end

function UIDLRoomWin:zuohuaDisciple(dzId)
if self:checkCantZuoHua(dzId,true)then
return
end

self:jumpDZChuiWei(dzId)
end

function UIDLRoomWin:jumpDZChuiWei(dzId)
local dzId_str=tostring(dzId)
local selectFunc=function(netData)
return UIDiscipleModel:checkDiscipleState2(netData.discipleguid,DISCIPLE_STATE_TYPE.eChuiWei)
end
local sortFunc=function(a,b)
local aFight=UIDiscipleModel:getDiscipleFightValue(a.discipleguid)
local bFight=UIDiscipleModel:getDiscipleFightValue(b.discipleguid)
return aFight>bFight
end
local temp=UIDiscipleModel:getSortList(selectFunc,sortFunc)
if#temp>0 then
local list={}
for i,netData in ipairs(temp)do
local data=UIDiscipleModel:getDiscipleDataX(netData.discipleguid)
if netData.discipleguidStr~=dzId_str then
table.insert(list,data)
end
end
local cur=UIDiscipleModel:getDiscipleDataX(dzId)
table.insert(list,1,cur)
UIFullDiscipleMainControl:showWindowInfo({dis_guid=dzId,disciplelist=list})
end
end

function UIDLRoomWin:onBtnAddBig()
self:onClickAdd()
end

function UIDLRoomWin:onBtnSwitchBig()
self:onClickSwitch()
end

function UIDLRoomWin:onClickAdd()
local titleName="道侣安排"
local args={
bdData=self.bdData,
coupleList=self.coupleIdList,
callback=function(dzId)
if tostring(dzId.man)~="0"then
local desclist1=UIDiscipleModel:getDiscipleSpecialityConfig(dzId.man,true)
local desclist2=UIDiscipleModel:getDiscipleSpecialityConfig(dzId.woman,true)

local flag1,name1=self:isHaveEccent(desclist1)
local flag2,name2=self:isHaveEccent(desclist2)

if flag1 or flag2 then
local str
if flag1 then
str=string.format("因怪癖%s不能入住道侣洞府",name1)
elseif flag2 then
str=string.format("因怪癖%s不能入住道侣洞府",name2)
end
UIManager.error(str)
end
end

DiscipleCoupleController.reqLiveDaoLv(self.bdData.un_build_id,dzId.man,dzId.woman)
UIManager:closeWindow('UICommonDragonBoneWin')
end
}
discipleSelectController:openDiscipleSelect(args,titleName,"UIMDiscipleSelect_Couple2")
end

function UIDLRoomWin:isHaveEccent(datas)
local enter_cond=self.cave_config.enter_cond
for i,j in ipairs(enter_cond)do
for k,v in ipairs(datas)do
if v.typo==j[1]and v.id==j[2]then
return true,v.name
end
end
end
return false
end

function UIDLRoomWin.on_building_event(etype,ubdId,args1,args2)
if etype==buildingEvent.levelUpStart then
_this:refreshLevelUp()
elseif etype==buildingEvent.levelUpComplete then
_this:refreshLeft()
_this:refreshRight()
elseif etype==buildingEvent.speedUpComplete then
_this:refreshLevelUp()
elseif etype==buildingEvent.switchRoomDizi then
if _this.bdData.un_build_id==ubdId then
_this.coupleIdList=DiscipleCoupleModel:getCoupleLiveId(_this.bdData.un_build_id)
if _this.coupleIdList then
_this.dzId1=_this.coupleIdList.dizi_id_1
_this.dzId2=_this.coupleIdList.dizi_id_2
else
_this.dzId1=0
_this.dzId2=0
end
_this:refreshCouplePanel()
end
end
end

function UIDLRoomWin:getSpeakText(bt,tkey,index)
local speakList
local voc=UIDiscipleModel:getDiscipleJob(self.coupleIdList.dizi_id_1)
speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'daolv')
speakList=self:getChuiWeiSpeakText(self.coupleIdList.dizi_id_1,voc,speakList)

local speakStr=speakList[math.random(1,#speakList)]
bt:setSharedVar(tkey,speakStr)
end

function UIDLRoomWin:getChuiWeiSpeakText(dzId,voc,speakList)
local check=self:checkChuiWei(dzId)
if check then
local textList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'dyingidlewalk')
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(dzId)
speakList=textList[imageInfo.sex]or textList[1]
end
return speakList
end




function UIDLRoomWin:onSelectBtn()
local args={}
args.titleName='住房列表'
args.pos=1
args.extraWin='UIRoomSelectWin'
args.extraParams=self.bdData
UIManager:showWindow('UICommonPageWin',args)
end


function UIDLRoomWin:onJiuzhiImg()
local guid
local chuiwei1=UIDiscipleModel:checkDiscipleState2(self.dzId1,DISCIPLE_STATE_TYPE.eChuiWei)
local chuiwei2=UIDiscipleModel:checkDiscipleState2(self.dzId2,DISCIPLE_STATE_TYPE.eChuiWei)
if chuiwei1 then
guid=self.dzId1
elseif chuiwei2 then
guid=self.dzId2
end
if guid then
self:jiuzhiDisciple(guid)
end
end


function UIDLRoomWin:onZuohuaImg()
local slots=self.bdData.caveGeziList
if slots and slots[1]then
local data=slots[1]
self:zuohuaDisciple(data.dizi_id)
end
end


function UIDLRoomWin:onBtnUpgrade()
UIManager:showWindow('UIBuildingInfoWin',self.bdData)
end


function UIDLRoomWin:onChangeNameBtn()
local rename_conf=cfgHelper.get2(cfg_monijybuildconfig_get,self.bdData.build_id,'rename_conf')
if rename_conf==nil then
UIManager.error('该建筑没有改名配置')
return
end
UIManager:showWindow('UIBuildChangeNameWin',{sfId=self.sfId,bdData=self.bdData})
UIManager:showWindow('UITopMoneyWin',{{eMoneyType.mtLingShi},{eMoneyType.mtLingYu},{eMoneyType.mtXianYu}})
end

