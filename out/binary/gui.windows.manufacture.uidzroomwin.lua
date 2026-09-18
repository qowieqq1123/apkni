







def_class("UIDzRoomWin",UIWindowBase)








function UIDzRoomWin:bindComponents()

self.arrowPanel=UIObject.get(self,0)
self.btnSelect=UIObject.get(self,1)
self.btnSwitch=UIObject.get(self,2)
self.btnUpgrade=UIButton.get(self,3)
self.buildNameText=UIText.get(self,4)
self.changeFloorRoot=UIObject.get(self,5)
self.changeNameBtn=UIButton.get(self,6)
self.danlu=UIObject.get(self,7)
self.downFloorButton=UIButton.get(self,8)
self.dzEmpty=UIObject.get(self,9)
self.dzItem_1=UIObject.get(self,10)
self.dzItem_2=UIObject.get(self,11)
self.dzItem_3=UIObject.get(self,12)
self.dzItem_4=UIObject.get(self,13)
self.dzModel=UIObject.get(self,14)
self.dzSpeak=UIObject.get(self,15)
self.effect_1=UIObject.get(self,16)
self.effect_10=UIObject.get(self,17)
self.effect_11=UIObject.get(self,18)
self.effect_12=UIObject.get(self,19)
self.effect_2=UIObject.get(self,20)
self.effect_3=UIObject.get(self,21)
self.effect_4=UIObject.get(self,22)
self.effect_5=UIObject.get(self,23)
self.effect_6=UIObject.get(self,24)
self.effect_7=UIObject.get(self,25)
self.effect_8=UIObject.get(self,26)
self.effect_9=UIObject.get(self,27)
self.effectDL=UIObject.get(self,28)
self.effectSX=UIObject.get(self,29)
self.effectXL=UIObject.get(self,30)
self.floorRoot=UIObject.get(self,31)
self.floorTxt_1=UIText.get(self,32)
self.floorTxt_2=UIText.get(self,33)
self.gongfengtai=UIObject.get(self,34)
self.icon=UIObject.get(self,35)
self.infoPanel=UIObject.get(self,36)
self.jiuzhiImg=UIButton.get(self,37)
self.jiuzhiRedot=UIObject.get(self,38)
self.leftArrow=UIButton.get(self,39)
self.levelPanel=UIObject.get(self,40)
self.levelUpBg=UIObject.get(self,41)
self.levelUpTime=UIText.get(self,42)
self.liandonBtn=UIButton.get(self,43)
self.linghunImg=UIObject.get(self,44)
self.model_1=UIObject.get(self,45)
self.model_2=UIObject.get(self,46)
self.model_3=UIObject.get(self,47)
self.model_4=UIObject.get(self,48)
self.multiPanel=UIObject.get(self,49)
self.rightArrow=UIButton.get(self,50)
self.scrollView=UIObject.get(self,51)
self.selectBtn=UIButton.get(self,52)
self.shanguang=UIObject.get(self,53)
self.singleBg=UIImage.get(self,54)
self.singlePanel=UIObject.get(self,55)
self.txtbdLevel=UIText.get(self,56)
self.txtDzSpeak=UIText.get(self,57)
self.txtEffect=UIText.get(self,58)
self.txtLevel=UIText.get(self,59)
self.txtUpgradeBtn=UIText.get(self,60)
self.upFloorButton=UIButton.get(self,61)
self.zuohuaImg=UIButton.get(self,62)

self.btnUpgrade:setButtonClick(function()self:onBtnUpgrade()end)

self.changeNameBtn:setButtonClick(function()self:onChangeNameBtn()end)

self.downFloorButton:setButtonClick(function()self:onDownFloorButton()end)

self.jiuzhiImg:setButtonClick(function()self:onJiuzhiImg()end)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.liandonBtn:setButtonClick(function()self:onLiandonBtn()end)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.upFloorButton:setButtonClick(function()self:onUpFloorButton()end)

self.zuohuaImg:setButtonClick(function()self:onZuohuaImg()end)
self.dzItem={
self.dzItem_1,
self.dzItem_2,
self.dzItem_3,
self.dzItem_4,
}
self.effect={
self.effect_1,
self.effect_2,
self.effect_3,
self.effect_4,
self.effect_5,
self.effect_6,
self.effect_7,
self.effect_8,
self.effect_9,
self.effect_10,
self.effect_11,
self.effect_12,
}
self.floorTxt={
self.floorTxt_1,
self.floorTxt_2,
}
self.model={
self.model_1,
self.model_2,
self.model_3,
self.model_4,
}



end


function UIDzRoomWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrowPanel);self.arrowPanel=nil;
_UIObject_release(self.btnSelect);self.btnSelect=nil;
_UIObject_release(self.btnSwitch);self.btnSwitch=nil;
_UIObject_release(self.btnUpgrade);self.btnUpgrade=nil;
_UIObject_release(self.buildNameText);self.buildNameText=nil;
_UIObject_release(self.changeFloorRoot);self.changeFloorRoot=nil;
_UIObject_release(self.changeNameBtn);self.changeNameBtn=nil;
_UIObject_release(self.danlu);self.danlu=nil;
_UIObject_release(self.downFloorButton);self.downFloorButton=nil;
_UIObject_release(self.dzEmpty);self.dzEmpty=nil;
_UIObject_release(self.dzItem_1);self.dzItem_1=nil;
_UIObject_release(self.dzItem_2);self.dzItem_2=nil;
_UIObject_release(self.dzItem_3);self.dzItem_3=nil;
_UIObject_release(self.dzItem_4);self.dzItem_4=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.dzSpeak);self.dzSpeak=nil;
_UIObject_release(self.effect_1);self.effect_1=nil;
_UIObject_release(self.effect_10);self.effect_10=nil;
_UIObject_release(self.effect_11);self.effect_11=nil;
_UIObject_release(self.effect_12);self.effect_12=nil;
_UIObject_release(self.effect_2);self.effect_2=nil;
_UIObject_release(self.effect_3);self.effect_3=nil;
_UIObject_release(self.effect_4);self.effect_4=nil;
_UIObject_release(self.effect_5);self.effect_5=nil;
_UIObject_release(self.effect_6);self.effect_6=nil;
_UIObject_release(self.effect_7);self.effect_7=nil;
_UIObject_release(self.effect_8);self.effect_8=nil;
_UIObject_release(self.effect_9);self.effect_9=nil;
_UIObject_release(self.effectDL);self.effectDL=nil;
_UIObject_release(self.effectSX);self.effectSX=nil;
_UIObject_release(self.effectXL);self.effectXL=nil;
_UIObject_release(self.floorRoot);self.floorRoot=nil;
_UIObject_release(self.floorTxt_1);self.floorTxt_1=nil;
_UIObject_release(self.floorTxt_2);self.floorTxt_2=nil;
_UIObject_release(self.gongfengtai);self.gongfengtai=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.jiuzhiImg);self.jiuzhiImg=nil;
_UIObject_release(self.jiuzhiRedot);self.jiuzhiRedot=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.levelPanel);self.levelPanel=nil;
_UIObject_release(self.levelUpBg);self.levelUpBg=nil;
_UIObject_release(self.levelUpTime);self.levelUpTime=nil;
_UIObject_release(self.liandonBtn);self.liandonBtn=nil;
_UIObject_release(self.linghunImg);self.linghunImg=nil;
_UIObject_release(self.model_1);self.model_1=nil;
_UIObject_release(self.model_2);self.model_2=nil;
_UIObject_release(self.model_3);self.model_3=nil;
_UIObject_release(self.model_4);self.model_4=nil;
_UIObject_release(self.multiPanel);self.multiPanel=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.shanguang);self.shanguang=nil;
_UIObject_release(self.singleBg);self.singleBg=nil;
_UIObject_release(self.singlePanel);self.singlePanel=nil;
_UIObject_release(self.txtbdLevel);self.txtbdLevel=nil;
_UIObject_release(self.txtDzSpeak);self.txtDzSpeak=nil;
_UIObject_release(self.txtEffect);self.txtEffect=nil;
_UIObject_release(self.txtLevel);self.txtLevel=nil;
_UIObject_release(self.txtUpgradeBtn);self.txtUpgradeBtn=nil;
_UIObject_release(self.upFloorButton);self.upFloorButton=nil;
_UIObject_release(self.zuohuaImg);self.zuohuaImg=nil;
self.dzItem=nil;
self.effect=nil;
self.floorTxt=nil;
self.model=nil;
end



















local _item_cmp_index={
dzRoomModel=0,
img_name=1,
txt_name=2,
btn_switch=3,
btn_add=4,
img_lock=5,
bg=6,
mask=7,
guanbi=8,
dzSpeakObj=9,
dzSpeakTxt=10,
jiuzhiImg=11,
zuohuaImg=12,
linghunImg=13,
jiuzhiRedot=14,
}

local _this
local _format=string.format
local abName='ui/windows/manufacture/homewall_atlas_pak.ab'
local _dzBTDict={}
local _initModel

local AIType={
walk=1,
practitioners=2,
totalNum=2
}

local SmokeEffectPos={
[1]={{{-212,73,0}},{{67.54,73,0}},{{-212,-195.7,0}},{{67.54,-196.2,0}}},
[2]={{{-223.1,74.4,0},{-65.7,72,0}},{{55.015,74.4,0},{213.6,72,0}},{{-223.1,-195,0},{-65.7,-197.4,0}},{{55.015,-195,0},{213.6,-197.4,0}}}
}

local _multipleFloorLimitRoomNum=4


function UIDzRoomWin:onLoaded(...)
self:bindComponents()
_this=self
self.multiBT={}
self.multiChuiweiId={}
self.chuiweiLastType={}
self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)

self.mutileRoomFloorMax=0
self.mutileRoomFloorCur=1

notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.onDiscipleInjuryChange,self.onDiscipleInjuryChange)
notifySystem:listenNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
end


function UIDzRoomWin:__delete()
_this=nil
_initModel=nil
self:removeAllMultiBT()
self:removeAllMultiId()
self:removesingleBT()
self:removesingleChuiweiId()
self.multiBT=nil
self.multiChuiweiId=nil
self.chuiweiLastType=nil

uiAIManager:clearUIWinData('UIDzRoomWin')

self:unbindComponents()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.onDiscipleInjuryChange,self.onDiscipleInjuryChange)
notifySystem:removelistener(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
end

function UIDzRoomWin.on_building_event(etype,sfId,ubdId,gzId,args1,args2)
if etype==buildingEvent.levelUpStart then
_this:refreshLevelUp()
elseif etype==buildingEvent.levelUpComplete then
_this:refresh(_this.bdData)


elseif etype==buildingEvent.speedUpComplete then
_this:refreshLevelUp()
elseif etype==buildingEvent.switchRoomFlag then
if args1==0 then
UIManager.info('房间已开启')
else
UIManager.info('房间已关闭')
end
_this:refreshByGzId(ubdId,gzId)
elseif etype==buildingEvent.switchRoomDizi then
_this.chuiweiLastType[tostring(args1)]=nil
_this.chuiweiLastType[tostring(args2)]=nil
_this:refreshByGzId(ubdId,gzId)
end
end

function UIDzRoomWin:refreshByGzId(ubdId,gzId)
local slots=self.bdData.caveGeziList
local data=slots[gzId]
if self.bdData.un_build_id==ubdId then
if self.bdType==15 then
local ridx=self:transLogicIndex(gzId)
local item=self.scrollView:getChildScrollViewItemWidget(ridx-1)
self:refreshMultiPanelItem(item,data,ridx)
self:refreshMultiModelIndex(data,ridx)
elseif self.bdType==16 then
self:refreshSinglePanel()
end
end
end

function UIDzRoomWin.onDiscipleInjuryChange(discipleguid,oldInjury,injury)
local state=UIDiscipleModel:getDiscipleState(discipleguid)
if state==DISCIPLE_STATE_TYPE.eChuiWei then
local recordType=_this.chuiweiLastType[tostring(discipleguid)]
local lastType=recordType[1]
local num=recordType[2]
local config=cfgHelper.get1(cfg_discipledyingconfig_get,1)
local injurySec=config.injury
local fresh=false
if lastType==DISCIPLE_CHUIWEI_TYPE.eShouYuan then
fresh=injury>=injurySec[2]
elseif lastType==DISCIPLE_CHUIWEI_TYPE.eInjury then
fresh=num>1
end
if fresh then
if _this.bdType==15 then
_this:refreshMultiScrollByDzId(discipleguid)
elseif _this.bdType==16 and mathHelper.compareInt64(_this.singleDzId,discipleguid)then
_this:refreshSinglePanel()
end
end
end
end

function UIDzRoomWin.onDiscipleStateChange(discipleguid,stateType,old,cur)
if stateType==DISCIPLE_STATE_TYPE.eChuiWei then
if _this.bdType==15 then
_this:refreshMultiScrollByDzId(discipleguid)
elseif _this.bdType==16 and _this.singleDzId==discipleguid then
_this:refreshSinglePanel()
end
end
end

function UIDzRoomWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
local itemConfig=itemsConfig.getConfig(itemid)
local funcparam=itemConfig.funcparam
if funcparam then
if funcparam.type==item_funtion_type.liaoshang or funcparam.type==item_funtion_type.shouyuan then
if _this.bdType==15 then
_this:refreshMultiPanel(true)
elseif _this.bdType==16 then
_this:refreshSinglePanel(true)
end
end
end
end




function UIDzRoomWin:onShow(argtable,afterOnloaded)
self:refresh(argtable)
end

function UIDzRoomWin:onShowArgRecv(argtable)
local oldId=self.entityId
local newId=argtable.entityId
if newId~=oldId then
self:__delete()
self:onLoaded()
_initModel=true
self:onShow(argtable)
end
end

function UIDzRoomWin:refresh(argtable)

if argtable then
local guid=argtable.entityId
self.entityId=guid
self.sfId=mapIdType.zhufeng
self.bdData=zongmenModel:findBuildingByEntityId(guid)
end
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.bdType=self.config.id

self.similarList=self:getSimilarList()
self.similarIndex=nil
for i,v in ipairs(self.similarList)do
local bdData=v.data
if bdData.un_build_id==self.bdData.un_build_id then
self.similarIndex=i
break
end
end

self:refreshLeft()
self:refreshRight()
end

function UIDzRoomWin:switchRoom(argtable)
uiAIManager:clearUIWinData('UIDzRoomWin')
self.mutileRoomFloorCur=1
self:refresh(argtable)
UIManager:invokeUIMethod('UIBottomMaskWin','setTitle',self.config.name)
end

function UIDzRoomWin:refreshLeft()
local curLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level)
local mdata_cur=isometricMapSystem:getModelByStatus(self.bdData.build_id,curLvCfg.level,0,nil,nil,nil,self.bdData.un_build_id,nil,true)


local offsetX=0
local offsetY=0
local nameStr=''
local model=mdata_cur.model
local scale=isometricMapSystem:getModelScale(model,true)

if self.bdType==15 then
nameStr='房舍'
elseif self.bdType==16 then
nameStr='洞府'
local param=isometricMapSystem:getModelScales2Pram(model,27)
scale=param[1]
offsetX=param[2]
offsetY=param[3]
end

self.icon:setChildUIModelShowTarget(model,scale*0.9,nil,eAnimationID.bd_stand)
self.icon:setChildUIModelShowTargetOffset(offsetX,offsetY)

self.txtLevel:setText(_format('%s级%s',curLvCfg.level,nameStr))
self.txtbdLevel:setText(_format('%s当前：<color=#7d3b17ff>%s级</color>',nameStr,curLvCfg.level))
self.txtEffect:setText(curLvCfg.effects_desc or'')

local linkageId
local skinId=self.bdData.build_appearance_id
if skinId and skinId>0 then
local skinCfg=cfgHelper.get(cfg_monijybuildappearanceconfig_get,skinId)
linkageId=skinCfg and skinCfg.linkageId or nil
else
linkageId=self.config.linkageId
end
self.liandonBtn:setActive(linkageId~=nil)
end

function UIDzRoomWin:refreshLevelPanelPos()
local pos=-177.5
local w=_this.txtEffect:getChildSizeDeltaY()

if w<50 then
pos=-150
end

self.levelPanel:setLocalPosY(pos)
end

function UIDzRoomWin:refreshRight()
if self.bdType==15 then
self:refreshMultiPanel()
self:freshMutipleFloorPart()
elseif self.bdType==16 then
self:refreshSinglePanel()
end
self:refreshLevelUp()
local buildName=self.bdData.name or'暂无名字'
self:refreshBuildName(buildName)
end


function UIDzRoomWin:onHide()

end

function UIDzRoomWin:onClickClose()
self:closeSelf()
end

function UIDzRoomWin:refreshBuildName(name)
self.buildNameText:setText(name)
end

function UIDzRoomWin:refreshLevelUp()
local maxLevel=zongmenModel:getBuildLimitMaxLv(self.bdData.build_id)
local isMaxLevel=self.bdData.level>=maxLevel

local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)
if(not isMaxLevel)and nextLvCfg then
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
self.levelUpTime:setText(_format('%s',timeHelper.format_time_stamp4(needTime-dtime)))
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

function UIDzRoomWin:stopLevelUpTimer()
if self.levelUpTimer then
self:stopTimerByID(self.levelUpTimer)
self.levelUpTimer=nil
end
end



function UIDzRoomWin:refreshMultiPanel(notfreshmodel)
self.multiPanel:setActive(true)
self.singlePanel:setActive(false)
local slots=self.bdData.caveGeziList
if slots then
self.mutileRoomFloorMax=Mathf.Ceil(#slots/_multipleFloorLimitRoomNum)
self.scrollView:setChildScrollViewCreateGrids(_multipleFloorLimitRoomNum,2)
self.grids=self.scrollView:getChildScrollViewItemWidgets()
local count=self.grids.Count
local item,dataIdx,data
for i=1,count do
item=self.grids[i-1]
dataIdx=self:transRealIndex(i)
data=slots[dataIdx]
self:refreshMultiPanelItem(item,data,i)
end
end
if not notfreshmodel then
if not _initModel then
_initModel=true
self:delayDo(0.5,function(...)
self:refreshMultiDzModel()
end)
else
self:refreshMultiDzModel()
end
end
self.arrowPanel:setActive(#self.similarList>1)
end

function UIDzRoomWin:refreshMultiPanelItem(item,data,index)
if data==nil then
self:refreshLockMultipleItem(item,index)
return
end
local dzId=data.dizi_id
local dzIdStr=tostring(dzId)
local haveDz=dzIdStr~='0'

item:SetChildActive(_item_cmp_index.img_name,haveDz)
item:SetChildActive(_item_cmp_index.btn_switch,not haveDz)
item:SetChildActive(_item_cmp_index.btn_switch,not haveDz and data.flag==1)
item:SetChildActive(_item_cmp_index.guanbi,not haveDz and data.flag==1)
item:SetChildActive(_item_cmp_index.btn_add,not haveDz and data.flag~=1)
item:SetChildActive(_item_cmp_index.img_lock,not haveDz and data.flag~=1)
item:SetChildActive(_item_cmp_index.mask,not haveDz and data.flag~=1)
item:SetChildActive(_item_cmp_index.jiuzhiImg,haveDz)
item:SetChildActive(_item_cmp_index.zuohuaImg,haveDz)
item:SetChildActive(_item_cmp_index.linghunImg,haveDz)
if haveDz then
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(dzId)
local sexImgName=cfgHelper.get4(cfg_monijyhomelvexlconfig_get,self.bdData.build_id,self.bdData.level,"wallbginfo",imageInfo.sex)
item:SetChildCSImageSprite(_item_cmp_index.bg,abName,sexImgName)
local name=UIDiscipleModel:getDiscipleName(dzId)
item:SetChildText(_item_cmp_index.txt_name,name)


local check=self:checkChuiWei(dzId)
local chuiweiType,num=UIDiscipleModel:checkChuiWeiDiscipleType(dzId)
local cantZuoHua=self:checkCantZuoHua(dzId)
item:SetChildActive(_item_cmp_index.jiuzhiImg,check)
item:SetChildActive(_item_cmp_index.zuohuaImg,check and not cantZuoHua)
item:SetChildGray(_item_cmp_index.bg,check)
item:SetChildButtonClick(_item_cmp_index.jiuzhiImg,function()
_this:jiuzhiDisciple(dzId)
end)
item:SetChildButtonClick(_item_cmp_index.zuohuaImg,function()
_this:zuohuaDisciple(dzId)
end)
local parent=self.dzItem[index]:getTransform()
item:SwitchChildParent(_item_cmp_index.zuohuaImg,parent,false)
item:SwitchChildParent(_item_cmp_index.jiuzhiImg,parent,false)
if check then
local jzReddot=self:checkJiuzhiDisciple(dzId)
item:SetChildActive(_item_cmp_index.jiuzhiRedot,jzReddot)
self.chuiweiLastType[dzIdStr]={chuiweiType,num}
else
self.chuiweiLastType[dzIdStr]=nil
end


item:SetChildActive(_item_cmp_index.linghunImg,chuiweiType==DISCIPLE_CHUIWEI_TYPE.eInjury)
local pos
if chuiweiType==DISCIPLE_CHUIWEI_TYPE.eInjury then
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(dzId)
pos=imageInfo.sex==SEX_TYPE.eMale and Vector2.New(-28,22)or Vector2.New(-50,-8)
item:SetChildAnchoredPosition(_item_cmp_index.linghunImg,pos)
elseif chuiweiType==DISCIPLE_CHUIWEI_TYPE.eShouYuan then

end

item:SetChildButtonClickWithID(_item_cmp_index.bg,function(index)
self:onClickAdd(index)
end,index)
else
local sexImgName=cfgHelper.get4(cfg_monijyhomelvexlconfig_get,self.bdData.build_id,self.bdData.level,"wallbginfo",1)
item:SetChildCSImageSprite(_item_cmp_index.bg,abName,sexImgName)

item:SetChildButtonClickWithID(_item_cmp_index.btn_switch,function(index)
self:onClickSwitch(index)
end,index)
item:SetChildButtonClickWithID(_item_cmp_index.img_lock,function(index)
self:onClickSwitch(index)
end,index)
item:SetChildButtonClickWithID(_item_cmp_index.btn_add,function(index)
self:onClickAdd(index)
end,index)
end
end

function UIDzRoomWin:refreshLockMultipleItem(item,index)
item:SetChildActive(_item_cmp_index.img_name,false)
item:SetChildActive(_item_cmp_index.btn_switch,false)
item:SetChildActive(_item_cmp_index.guanbi,true)
item:SetChildActive(_item_cmp_index.btn_add,false)
item:SetChildActive(_item_cmp_index.img_lock,false)
item:SetChildActive(_item_cmp_index.mask,false)
item:SetChildActive(_item_cmp_index.jiuzhiImg,false)
item:SetChildActive(_item_cmp_index.zuohuaImg,false)
item:SetChildActive(_item_cmp_index.linghunImg,false)

local model=self.model[index]
self.winlua:SetChildUIModelRemoveTarget(model:getID())
self.winlua:SetChildShowEffect(self.effect[index]:getID(),0,false)
self.winlua:SetChildShowEffect(self.effect[index+4]:getID(),0,false)
self.winlua:SetChildShowEffect(self.effect[index+8]:getID(),0,false)

item:SetChildButtonClickWithID(_item_cmp_index.guanbi,function(index)
UIManager.info("升级房舍后可扩展房间")
end,index)
end


function UIDzRoomWin:findMultiSlotDiziIndex(dzId)
local slots=self.bdData.caveGeziList
if slots then
for i,v in ipairs(slots)do
if v.dizi_id==dzId then
return i,v
end
end
end
end

function UIDzRoomWin:refreshMultiScrollByDzId(dzId)
local index,data=self:findMultiSlotDiziIndex(dzId)
if index then
local item=self.scrollView:getChildScrollViewItemWidget(index-1)
self:refreshMultiPanelItem(item,data,index)
self:refreshMultiModelIndex(data,index)
end
end


function UIDzRoomWin:refreshMultiDzModel()
local slots=self.bdData.caveGeziList
if slots then
local ridx,data,didx
for i=1,_multipleFloorLimitRoomNum do
didx=self:transRealIndex(i)
data=slots[didx]
ridx=self:transLogicIndex(didx)
self:refreshMultiModelIndex(data,ridx)
end
end
end

function UIDzRoomWin:refreshMultiModelIndex(data,i)
self:removeMultiBT(i)
self:removeMultiChuiweiId(i)

if data==nil then
local item=self.scrollView:getChildScrollViewItemWidget(i-1)
self:refreshLockMultipleItem(item,i)
return
end

if tostring(data.dizi_id)~='0'then
local tran=self.model[i]:getCommonComponent('Transform')
local pos=Vector2.New(0,-85)
local chuiweiType=UIDiscipleModel:checkChuiWeiDiscipleType(data.dizi_id)
self.winlua:SetChildScale(self.model[i]:getID(),Vector3.New(1,1,1))
self.winlua:SetChildShowEffect(self.effect[i]:getID(),10300,false)
self.winlua:SetChildShowEffect(self.effect[i+4]:getID(),10301,false)
self.winlua:SetChildShowEffect(self.effect[i+8]:getID(),10301,false)
if chuiweiType==DISCIPLE_CHUIWEI_TYPE.eInjury then
self:createChuiWeiDZ(data.dizi_id,tran,pos,function(id)
if self and not self.isClose then
self.multiChuiweiId[i]=id
end
end)
elseif chuiweiType==DISCIPLE_CHUIWEI_TYPE.eShouYuan then
self:createMultiDZ(tran,data.dizi_id,pos,i,function(bt)
if _this and not _this.isClose then
_this.multiBT[i]=bt
end
end)
else
if self.multiBT[i]==nil then
local type=math.random(1,AIType.totalNum)
self.winlua:SetChildUIModelRemoveTarget(self.model[i]:getID())
if type==AIType.walk then
self:createMultiDZ(tran,data.dizi_id,pos,i,function(bt)
if _this and not _this.isClose then
_this.multiBT[i]=bt
end
end)
elseif type==AIType.practitioners then
local modelParams=self:getModelInfo(data.dizi_id)
if deviceHelper.getAPILevel()>=3 and modelParams.componets[1]~=nil then
self.winlua:SetChildUIModelShowTarget(self.model[i]:getID(),modelParams.ChangeBody,modelParams.scale,nil,modelParams.anim,false,false,1.2,function()

_this:delayDo(0.5,function()
_this.winlua:SetChildShowEffect(_this.effect[i]:getID(),10300,true)
end)
end)
self.winlua:SetChildAddSkeletonSlot(self.model[i]:getID(),"tou1","head",modelParams.componets[1])
self.winlua:SetChildScale(self.model[i]:getID(),Vector3.New(0.7,0.7,0.7))
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(data.dizi_id)
self.winlua:SetChildShowEffect(self.effect[i+4]:getID(),10301,true)
local smokeeffectpos=SmokeEffectPos[imageInfo.sex]
self.winlua:SetChildLocalPos(self.effect[i+4]:getID(),smokeeffectpos[i][1][1],smokeeffectpos[i][1][2],smokeeffectpos[i][1][3])
if imageInfo.sex==SEX_TYPE.eFeMale then
self.winlua:SetChildShowEffect(self.effect[i+8]:getID(),10301,true)
self.winlua:SetChildLocalPos(self.effect[i+8]:getID(),smokeeffectpos[i][2][1],smokeeffectpos[i][2][2],smokeeffectpos[i][2][3])
end
else

self:createMultiDZ(tran,data.dizi_id,pos,i,function(bt)
if _this and not _this.isClose then
_this.multiBT[i]=bt
end
end)
end
self.winlua:SetChildUIModelShowTargetOffset(self.model[i]:getID(),195,-232)
end
end
end
else
if self.multiBT[i]==nil then
self:removeMultiBT(i)
end
self.winlua:SetChildUIModelRemoveTarget(self.model[i]:getID())
self.winlua:SetChildShowEffect(self.effect[i]:getID(),0,false)
self.winlua:SetChildShowEffect(self.effect[i+4]:getID(),0,false)
self.winlua:SetChildShowEffect(self.effect[i+8]:getID(),0,false)
end
end

function UIDzRoomWin:getModelInfo(guid)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(guid,false,1)

local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid)
local bodyid=imageInfo.sex==SEX_TYPE.eMale and 50001 or 50002
modelParams.ChangeBody=cfgHelper.get2(cfg_disciplebodyimageconfig_get,bodyid,'out_side')

return modelParams
end

function UIDzRoomWin:getMultiBTData(index)
local stand=math.random(0,1)
local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
standPos=stand,
offset={0,0},
leftPos={-80,-85},
rightPos={80,-85},
slotIndex=index,
waitflip=0,
}
return initData
end

function UIDzRoomWin:createMultiDZ(tran,dzId,pos,index,callback)
local initData=self:getMultiBTData(index)
local state=UIDiscipleModel:getDiscipleState(dzId)
local scale=0.7
if state==DISCIPLE_STATE_TYPE.eChuiWei then
scale=0.8
initData.rightPos[1]=10
end
local otherData={
scale=scale,
}
uiAIManager:createUIDisciple('UIDzRoomWin','bt_ui_room',dzId,tran,pos,initData,otherData,function(bt)
callback(bt)
end)
end

function UIDzRoomWin:removeMultiBT(index)
if self.multiBT[index]then
uiAIManager:removeUIInstance(self.multiBT[index])
self.multiBT[index]=nil
end
end

function UIDzRoomWin:removeAllMultiBT()
for i=1,4 do
self:removeMultiBT(i)
end
end



function UIDzRoomWin:refreshSinglePanel(notfreshmodel)
self.arrowPanel:setActive(#self.similarList>1)
self.multiPanel:setActive(false)
self.singlePanel:setActive(true)
local curLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level)
self.shanguang:setActive(curLvCfg.level>=5)
self.gongfengtai:setActive(curLvCfg.level>=4)
self.danlu:setActive(curLvCfg.level>=3)

if curLvCfg.level>=3 then
self.effectDL:setChildShowEffect(10028,true)
end
if curLvCfg.level>=4 then
self.gongfengtai:setChildUIModelShowTarget(2041,1,{},eAnimationID.common_window_stand)
self.effectXL:setChildShowEffect(10030,true)
end
if curLvCfg.level>=5 then
self.effectSX:setChildShowEffect(10029,true)
end

local slots=self.bdData.caveGeziList
if slots and slots[1]then
local data=slots[1]
local dzId=data.dizi_id
local dzIdStr=tostring(dzId)
local haveDz=dzIdStr~='0'
self.btnSelect:setActive(not haveDz)
self.btnSwitch:setActive(haveDz)
self.dzModel:setActive(haveDz)
self.jiuzhiImg:setActive(haveDz)
self.zuohuaImg:setActive(haveDz)
self.linghunImg:setActive(haveDz)
if haveDz then
self.singleDzId=dzId
if not notfreshmodel then
if not _initModel then
_initModel=true
self:delayDo(0.5,function(...)
self:refreshSingleDzModel(data)
end)
else
self:refreshSingleDzModel(data)
end
end
local check=self:checkChuiWei(dzId)
local chuiweiType,num=UIDiscipleModel:checkChuiWeiDiscipleType(dzId)
local cantZuoHua=self:checkCantZuoHua(dzId)
self.jiuzhiImg:setActive(check)
self.zuohuaImg:setActive(check and not cantZuoHua)
self.singleBg:setGray(check)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(dzId)
local sexImgName=cfgHelper.get4(cfg_monijyhomelvexlconfig_get,self.bdData.build_id,self.bdData.level,"wallbginfo",imageInfo.sex)
self.singleBg:setCSImageSprite("ui/windows/manufacture/sharedtextures/dongfu.ab",sexImgName)
if check then
local jzReddot=self:checkJiuzhiDisciple(dzId)
self.jiuzhiRedot:setActive(jzReddot)
self.chuiweiLastType[dzIdStr]={chuiweiType,num}
else
self.chuiweiLastType[dzIdStr]=nil
end
self.linghunImg:setActive(chuiweiType==DISCIPLE_CHUIWEI_TYPE.eInjury)
local pos
if chuiweiType==DISCIPLE_CHUIWEI_TYPE.eInjury then

pos=imageInfo.sex==SEX_TYPE.eMale and Vector2.New(-30,-16)or Vector2.New(-52,-48)
self.linghunImg:setChildAnchoredPosition(pos)
elseif chuiweiType==DISCIPLE_CHUIWEI_TYPE.eShouYuan then

end
else
self:removesingleBT()
self:removesingleChuiweiId()
end
end
end

function UIDzRoomWin:refreshSingleDzModel(data)
if tostring(data.dizi_id)~='0'then
self:removesingleBT()
self:removesingleChuiweiId()
local tran=self.dzEmpty:getCommonComponent('Transform')
local pos=Vector2.New(-24,-118)
local chuiweiType=UIDiscipleModel:checkChuiWeiDiscipleType(data.dizi_id)
if chuiweiType==DISCIPLE_CHUIWEI_TYPE.eInjury then
self:createChuiWeiDZ(data.dizi_id,tran,pos,function(id)
self.singleChuiweiId=id
end)
else

local type=math.random(1,AIType.totalNum)

self.winlua:SetChildUIModelRemoveTarget(self.dzEmpty:getID())

self:createSingleDZ(tran,data.dizi_id,pos,function(bt)
self.singleBT=bt
end)













end
else
self.winlua:SetChildUIModelRemoveTarget(self.dzEmpty:getID())
end
end

function UIDzRoomWin:getSingleBTData()
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

function UIDzRoomWin:createSingleDZ(tran,dzId,pos,callback)
local initData=self:getSingleBTData()
local state=UIDiscipleModel:getDiscipleState(dzId)
local scale=0.8
if state==DISCIPLE_STATE_TYPE.eChuiWei then
scale=1
end
local otherData={
scale=scale,
}
uiAIManager:createUIDisciple('UIDzRoomWin','bt_ui_room',dzId,tran,pos,initData,otherData,function(bt)
callback(bt)
end)
end

function UIDzRoomWin:removesingleBT()
if self.singleBT then
uiAIManager:removeUIInstance(self.singleBT)
self.singleBT=nil
end
end

function UIDzRoomWin:removesingleChuiweiId()
if self.singleChuiweiId then
_InstantiateManager.RemoveInstance(self.singleChuiweiId)
self.singleChuiweiId=nil
end
end


function UIDzRoomWin:getSpeakText(bt,tkey,index)
local slots=self.bdData.caveGeziList
local speakList
if self.bdType==15 then
local realIdx=self:transRealIndex(index)
local data=slots[realIdx]
local voc=UIDiscipleModel:getDiscipleJob(data.dizi_id)
speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'fangshe')
speakList=self:getChuiWeiSpeakText(data.dizi_id,voc,speakList)
elseif self.bdType==16 then
local data=slots[1]
local voc=UIDiscipleModel:getDiscipleJob(data.dizi_id)
speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'dongfu')
speakList=self:getChuiWeiSpeakText(data.dizi_id,voc,speakList)
end
local speakStr=speakList[math.random(1,#speakList)]
bt:setSharedVar(tkey,speakStr)
end

function UIDzRoomWin:getChuiWeiSpeakText(dzId,voc,speakList)
local check=self:checkChuiWei(dzId)
if check then
local textList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'dyingidlewalk')
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(dzId)
speakList=textList[imageInfo.sex]or textList[1]
end
return speakList
end



function UIDzRoomWin:checkChuiWei(dzId)
local state=UIDiscipleModel:getDiscipleState(dzId)
return state==DISCIPLE_STATE_TYPE.eChuiWei
end


function UIDzRoomWin:createChuiWeiDZ(dzId,tran,pos,callback)
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

function UIDzRoomWin:removeAllMultiId()
for i=1,4 do
self:removeMultiChuiweiId(i)
end
end

function UIDzRoomWin:removeMultiChuiweiId(index)
if self.multiChuiweiId[index]then
_InstantiateManager.RemoveInstance(self.multiChuiweiId[index])
self.multiChuiweiId[index]=nil
end
end

function UIDzRoomWin:checkCantZuoHua(dzId,isWarning)
if not UIDiscipleModel:checkCanKickOutDzAndTips(dzId,isWarning,2)then
return true
end
return false
end

function UIDzRoomWin:checkJiuzhiDisciple(dzId)
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

function UIDzRoomWin:jiuzhiDisciple(dzId)







self:jumpDZChuiWei(dzId)
end

function UIDzRoomWin:zuohuaDisciple(dzId)
if self:checkCantZuoHua(dzId,true)then
return
end


self:jumpDZChuiWei(dzId)
end

function UIDzRoomWin:jumpDZChuiWei(dzId)
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






function UIDzRoomWin:onBtnUpgrade()
UIManager:showWindow('UIBuildingInfoWin',self.bdData)
end

function UIDzRoomWin:onClickSwitch(index)
local rIndex=self:transRealIndex(index)
local data=self.bdData.caveGeziList[rIndex]
local flag=data.flag==1 and 0 or 1
zongmenControl:reqSwitchRoomFlag(self.sfId,self.bdData.un_build_id,rIndex,flag)
end

function UIDzRoomWin:onClickAdd(index)
local ridx=self:transRealIndex(index)
local grid=self.bdData.caveGeziList[ridx]












if grid then
local args={
openType=dzSelectWinOpenType.eRoommate,
bdData=self.bdData,
gridId=ridx,
callback=function(dzId)
zongmenControl:reqSwitchRoomDizi(self.sfId,self.bdData.un_build_id,ridx,dzId)
end
}
discipleSelectController:openDiscipleSelect(args)
end
end



function UIDzRoomWin:onLiandonBtn()
local skinId=self.bdData.build_appearance_id
if skinId and skinId>0 then
local skinCfg=cfgHelper.get(cfg_monijybuildappearanceconfig_get,skinId)
UIManager:showWindow('UITipLianDonWin',{linkageId=skinCfg.linkageId})
else
UIManager:showWindow('UITipLianDonWin',{linkageId=self.config.linkageId})
end
end

function UIDzRoomWin:onBtnSwitchBig()
self:onClickSwitch(1)
end

function UIDzRoomWin:onBtnAddBig()
self:onClickAdd(1)
end

function UIDzRoomWin:onBtnIconBig()
self:onClickAdd(1)
end

function UIDzRoomWin:onJiuzhiImg()
local slots=self.bdData.caveGeziList
if slots and slots[1]then
local data=slots[1]
self:jiuzhiDisciple(data.dizi_id)
end
end

function UIDzRoomWin:onZuohuaImg()
local slots=self.bdData.caveGeziList
if slots and slots[1]then
local data=slots[1]
self:zuohuaDisciple(data.dizi_id)
end
end

function UIDzRoomWin:onChangeNameBtn()
local rename_conf=cfgHelper.get2(cfg_monijybuildconfig_get,self.bdData.build_id,'rename_conf')
if rename_conf==nil then
UIManager.error('该建筑没有改名配置')
return
end
UIManager:showWindow('UIBuildChangeNameWin',{sfId=self.sfId,bdData=self.bdData})
UIManager:showWindow('UITopMoneyWin',{{eMoneyType.mtLingShi},{eMoneyType.mtLingYu},{eMoneyType.mtXianYu}})
end

function UIDzRoomWin:onSelectBtn()

local args={}
args.titleName='住房列表'
args.pos=1
args.extraWin='UIRoomSelectWin'
args.extraParams=self.bdData
UIManager:showWindow('UICommonPageWin',args)
end

function UIDzRoomWin:onLeftArrow()
if self.changeLock then return end
local similarIndex=self.similarIndex or 1
local index=similarIndex>1 and(similarIndex-1)or#self.similarList
local bdData=self.similarList[index].data
self:onShowArgRecv(bdData)
self.changeLock=true
self:delayDo(0.5,function()
self.changeLock=false
end)
end

function UIDzRoomWin:onRightArrow()
if self.changeLock then return end
local similarIndex=self.similarIndex or 1
local index=similarIndex>=#self.similarList and 1 or(similarIndex+1)
local bdData=self.similarList[index].data
self:onShowArgRecv(bdData)
self.changeLock=true
self:delayDo(0.5,function()
self.changeLock=false
end)
end

function UIDzRoomWin:isCanShow(bdData)
if emergenciesModel:isInRepairTime(bdData.un_build_id)then
return false
end
if emergenciesControl:isBuildingOnFire(bdData.entityId)then
return false
end
local ftype=zongmenModel:getBDFlagType(bdData.flag)
if ftype~=bdFlagType.normal then
return false
end
if self.config.is_connect_road==1 and not bdData.isLinkRoad then
return false
end
return true
end

function UIDzRoomWin:getSimilarList()
local datas=zongmenModel:getAllBuildingData(self.sfId)
local list={}
for k,v in pairs(datas)do
if v.build_id==SLG_SYSTEM_TYPE.eDanRen or v.build_id==SLG_SYSTEM_TYPE.eDuoRen then
if self:isCanShow(v)then
local data={}
data.name=v.name
data.level=v.level
local currNum=0
local maxNum=0
for ii,vv in ipairs(v.caveGeziList)do
if tostring(vv.dizi_id)~='0'then
currNum=currNum+1
end
maxNum=maxNum+1
end
data.currNum=currNum
data.maxNum=maxNum
data.isFull=currNum>=maxNum
data.data=v
table.insert(list,data)
end
end
end
table.sort(list,function(a,b)
if a.isFull and not b.isFull then
return false
elseif a.isFull==b.isFull then
return a.level>b.level
else
return true
end
end)
return list
end

function UIDzRoomWin:onUpFloorButton()
if self.mutileRoomFloorCur==self.mutileRoomFloorMax then return end
self.mutileRoomFloorCur=self.mutileRoomFloorCur+1
self:freshFloorOptionBtns()
uiAIManager:clearUIWinData('UIDzRoomWin')
self:refreshMultiPanel()
end

function UIDzRoomWin:onDownFloorButton()
if self.mutileRoomFloorCur==1 then return end
self.mutileRoomFloorCur=self.mutileRoomFloorCur-1
self:freshFloorOptionBtns()
uiAIManager:clearUIWinData('UIDzRoomWin')
self:refreshMultiPanel()
end

function UIDzRoomWin:freshFloorOptionBtns()
self.upFloorButton:setActive(self.mutileRoomFloorCur~=self.mutileRoomFloorMax)
self.downFloorButton:setActive(self.mutileRoomFloorCur~=1)
local floor_1=self.mutileRoomFloorCur*2-1
local floor_2=self.mutileRoomFloorCur*2

self.floorTxt_1:setText(FMT.fmt("{0}\n楼",mathHelper.numberToChinese(floor_1)))
self.floorTxt_2:setText(FMT.fmt("{0}\n楼",mathHelper.numberToChinese(floor_2)))
end

function UIDzRoomWin:freshMutipleFloorPart()
local isShow=self.mutileRoomFloorMax>1
self.changeFloorRoot:setActive(isShow)
self.floorRoot:setActive(isShow)
if isShow then
self:freshFloorOptionBtns()
end
end


local logicRoomIndexList={3,4,1,2}
function UIDzRoomWin:transRealIndex(index)
if self.mutileRoomFloorCur==1 then
return index
else
return(self.mutileRoomFloorCur-1)*_multipleFloorLimitRoomNum+logicRoomIndexList[index]
end
end


function UIDzRoomWin:transLogicIndex(index)
if index<=4 then
return index
else
local logicIdx=(index-1)%_multipleFloorLimitRoomNum+1
return logicRoomIndexList[logicIdx]
end
end