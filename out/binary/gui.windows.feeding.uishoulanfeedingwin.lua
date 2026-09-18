







def_class("UIShouLanFeedingWin",UIWindowBase)









function UIShouLanFeedingWin:bindComponents()

self.root=UIObject.get(self,0)
self.manager=UIObject.get(self,1)
self.spPanel=UIObject.get(self,2)
self.info=UIObject.get(self,3)
self.selectBtn=UIButton.get(self,4)
self.lsAddBtn=UIButton.get(self,5)
self.rewardInfoBtn=UIButton.get(self,6)
self.countDown=UIText.get(self,7)
self.rwScrollView=UIObject.get(self,8)
self.backBtn=UIButton.get(self,9)
self.scrollview=UIObject.get(self,10)
self.removeBtn=UIButton.get(self,11)
self.selectBtnText=UIText.get(self,12)
self.slVolume=UIText.get(self,13)
self.addBtn=UIButton.get(self,14)
self.volume2=UIText.get(self,15)
self.detailBtn=UIButton.get(self,16)
self.volume=UIText.get(self,17)
self.emScrollView=UIObject.get(self,18)
self.mood=UIText.get(self,19)
self.exp=UIText.get(self,20)
self.jingjie=UIText.get(self,21)
self.name=UIText.get(self,22)
self.helpBtn=UIButton.get(self,23)
self.spScrollView=UIObject.get(self,24)
self.dzTipsBtn=UIButton.get(self,25)
self.dzLevel=UIText.get(self,26)
self.dzName=UIText.get(self,27)
self.scene=UIObject.get(self,28)
self.volumeGroup=UIObject.get(self,29)
self.infoVolumeGroup=UIObject.get(self,30)
self.notRewardTips=UIObject.get(self,31)
self.dzModelPos=UIObject.get(self,32)
self.dzInfo=UIObject.get(self,33)
self.notDzInfo=UIObject.get(self,34)
self.infoModel=UIObject.get(self,35)
self.lsClickArea=UIButton.get(self,36)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.lsAddBtn:setButtonClick(function()self:onLsAddBtn()end)

self.rewardInfoBtn:setButtonClick(function()self:onRewardInfoBtn()end)

self.backBtn:setButtonClick(function()self:onBackBtn()end)

self.removeBtn:setButtonClick(function()self:onRemoveBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.detailBtn:setButtonClick(function()self:onDetailBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.dzTipsBtn:setButtonClick(function()self:onDzTipsBtn()end)

self.lsClickArea:setButtonClick(function()self:onLsClickArea()end)



end


function UIShouLanFeedingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.manager);self.manager=nil;
_UIObject_release(self.spPanel);self.spPanel=nil;
_UIObject_release(self.info);self.info=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.lsAddBtn);self.lsAddBtn=nil;
_UIObject_release(self.rewardInfoBtn);self.rewardInfoBtn=nil;
_UIObject_release(self.countDown);self.countDown=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.backBtn);self.backBtn=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.removeBtn);self.removeBtn=nil;
_UIObject_release(self.selectBtnText);self.selectBtnText=nil;
_UIObject_release(self.slVolume);self.slVolume=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.volume2);self.volume2=nil;
_UIObject_release(self.detailBtn);self.detailBtn=nil;
_UIObject_release(self.volume);self.volume=nil;
_UIObject_release(self.emScrollView);self.emScrollView=nil;
_UIObject_release(self.mood);self.mood=nil;
_UIObject_release(self.exp);self.exp=nil;
_UIObject_release(self.jingjie);self.jingjie=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.spScrollView);self.spScrollView=nil;
_UIObject_release(self.dzTipsBtn);self.dzTipsBtn=nil;
_UIObject_release(self.dzLevel);self.dzLevel=nil;
_UIObject_release(self.dzName);self.dzName=nil;
_UIObject_release(self.scene);self.scene=nil;
_UIObject_release(self.volumeGroup);self.volumeGroup=nil;
_UIObject_release(self.infoVolumeGroup);self.infoVolumeGroup=nil;
_UIObject_release(self.notRewardTips);self.notRewardTips=nil;
_UIObject_release(self.dzModelPos);self.dzModelPos=nil;
_UIObject_release(self.dzInfo);self.dzInfo=nil;
_UIObject_release(self.notDzInfo);self.notDzInfo=nil;
_UIObject_release(self.infoModel);self.infoModel=nil;
_UIObject_release(self.lsClickArea);self.lsClickArea=nil;
end
















local _this
local cmpVolumeItemIdx={
notSelect=0,
select=1,
green=2,
red=3,
}




function UIShouLanFeedingWin:onLoaded(...)
self:bindComponents()

_this=self

self.enterPos={-375,-360}
self.leavePos={-600,-360}

self.bShowInfo=false
self.manager:setActive(true)
self.info:setActive(false)
self.spPanel:setActive(false)

self.tweeners={}

self.lsList={}

self.loadingST={}
self.loadingSTM={}
self.loadingSTHUD={}
self.talking={}
self.info:setActive(false)

self.scrollview:setChildScrollViewInit(0.5,true,self.on_item_click,nil)
self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
self.emScrollView:setChildScrollViewInit(0,true,self.on_element_click,nil)
self.spScrollView:setChildScrollViewInit(0.5,true,nil,nil)

notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.onLingShouStateChange,self.onLingShouStateChange)
notifySystem:listenNotify(notifyConfig.onLingShouXinQingChanged,self.onLingShouXinQingChange)
end


function UIShouLanFeedingWin:__delete()
self:unbindComponents()

_this=nil

notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.onLingShouStateChange,self.onLingShouStateChange)
notifySystem:removelistener(notifyConfig.onLingShouXinQingChanged,self.onLingShouXinQingChange)

for k,v in pairs(self.loadingST)do
_InstantiateManager.RemoveInstance(v)
end
for k,v in pairs(self.loadingSTM)do
_InstantiateManager.RemoveInstance(v)
end
for i,v in ipairs(self.loadingSTHUD)do
_InstantiateManager.RemoveInstance(v)
end
uiAIManager:clearUIWinData('UIShouLanFeedingWin')
end

function UIShouLanFeedingWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if _this.bdData.un_build_id~=bdId then
return
end

if etype==buildingEvent.replaceDisciple then
_this:resetDZInfo()
_this:refreshAI(arg1,arg2)
end
end

function UIShouLanFeedingWin.onLingShouStateChange(lsGuid,stateType,o,c)
if stateType==eLingShouStateType.petBorn then
local mId=tostring(lsGuid)
local id=_this.loadingSTM[mId]
local bt=uiAIManager.uiDZDatas[id].bt
local hud=_this.loadingSTHUD[mId]
if c then
if id and not hud then
local stWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
local hudRoot=stWidget:GetChildGameObject(1).transform
bt:setSharedVar("show_hud",true)
_this.loadingSTHUD[mId]=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDiscipleTipsHUD,hudRoot,function(id)
bt:setSharedVar("show_hud",false)
end)
end
else
if id and hud then
_InstantiateManager.RemoveInstance(_this.loadingSTHUD[mId])
_this.loadingSTHUD[mId]=nil
end
end
end
end

function UIShouLanFeedingWin.onLingShouXinQingChange(guid,old_value,new_value)
if not _this.cmSelect or not _this.mdatas then
return
end
local data=_this.mdatas[_this.cmSelect+1]
if data.guid==guid then

local xqValue=lingshouModel:getLSXinQingValue(guid)

local xqMaxValue=lingshouModel.getLingShouPropertyValEx(guid,lingshouPropertyType.MOOD_MAXVAL)
if xqValue<xqMaxValue then



local addVal=lingshouModel.getLingShouPropertyValEx(guid,lingshouPropertyType.MOOD_CHANGE_VAL)






if addVal==0 then
_this.mood:setText(math.floor(xqValue))
else
local changeTypeStr=addVal>0 and"上升"or"下降"
_this.mood:setText(FMT.fmt('{0}（{1}/年{2}）',math.floor(xqValue),math.abs(addVal),changeTypeStr))
end
else
_this.mood:setText(math.floor(xqValue))
end
end
end

function UIShouLanFeedingWin.on_item_click(num,index)
if _this.cmSelect then
local item=_this.scrollview:getChildScrollViewItemWidget(_this.cmSelect)
item:SetChildActive(2,false)



end

_this.cmSelect=index

local item=_this.scrollview:getChildScrollViewItemWidget(_this.cmSelect)
item:SetChildActive(2,true)

local data=_this.mdatas[index+1]



_this:showMainMonster(index)
_this.currSelect=data.guid
_this:setMonsterInfo(_this.currSelect)
end

function UIShouLanFeedingWin.on_element_click(num,index)
local data=_this.elementData[index+1]
local widget=_this.emScrollView:getChildScrollViewItemWidget(index)
local pos=widget:GetChildUIScreenPos(0)






























UIShouLanControl:showElementInfoWin(pos,{0,-35},data[2],data[1]==1)
end




function UIShouLanFeedingWin:onShow(argtable,afterOnloaded)
if argtable then
local guid=argtable.entityId
if guid>0 then
self.entityId=guid
self.bdData=zongmenModel:findBuildingByEntityId(guid)
end
if argtable.unBuildID then
self.unBuildID=argtable.unBuildID
self.bdData=zongmenModel:getBuildingData(self.unBuildID)
end
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.buildCfg=cfgHelper.get(cfg_yunjiayingconfig_get,self.bdData.level)
end

self.sfId=zongmenModel:getMountainId()
self.slData=UIShouLanModel:getShouLanData(self.bdData.un_build_id)
self:resetDZInfo()
self:initAI()

self:refreshCount()

self.defSelect=argtable.mId
end


function UIShouLanFeedingWin:onHide()

end

function UIShouLanFeedingWin:onShowArgRecv()
if self.currSelect then
self:setMonsterInfo(self.currSelect)
end
end




function UIShouLanFeedingWin:refreshCount()
local slcfg=cfgHelper.get1(cfg_petbuildconfig_get,self.slData.build_id)
local curr=UIShouLanModel:getMonsterVolume(self.bdData.un_build_id)
local max=slcfg.volume
self.volume2:setText(FMT.fmt('{0}/{1}',curr,max))


self.addBtn:setActive(true)

self:refreshVolumePanel()
end


function UIShouLanFeedingWin:refreshVolumePanel()
local sldata=UIShouLanModel:getShouLanData(self.bdData.un_build_id)
local slcfg=cfgHelper.get1(cfg_petbuildconfig_get,sldata.build_id)
local buildVolume=slcfg.volume
local nowUseVolume=UIShouLanModel:getMonsterVolume(self.bdData.un_build_id)
local nowSelectVolume=0
local previewSelectCount=nowUseVolume+nowSelectVolume
local maxShowCount=buildVolume

self.volumeGroup:setChildLayoutGroupCreateItems(maxShowCount,function(index)
local widget=self.volumeGroup:getChildLayoutGroupGridItem(index-1)
local isSelect=index<=nowUseVolume
local isPreview=not isSelect and index<=previewSelectCount
local isGreen=isPreview and previewSelectCount<=buildVolume
local isRed=isPreview and previewSelectCount>buildVolume
local isNotSelect=not isSelect and not isPreview and index<=buildVolume

widget:SetChildActive(cmpVolumeItemIdx.notSelect,isNotSelect)
widget:SetChildActive(cmpVolumeItemIdx.select,isSelect)
widget:SetChildActive(cmpVolumeItemIdx.green,isGreen)
widget:SetChildActive(cmpVolumeItemIdx.red,isRed)
end)
end

function UIShouLanFeedingWin:randomAPos()
local pos={math.random(-480,480),math.random(-250,200)}
return pos
end

function UIShouLanFeedingWin:randomAMovePos(bt,pkey)
local randomPos=self:randomAPos()
bt:setSharedVar(pkey,randomPos)
end

function UIShouLanFeedingWin:getMonsterSpeakText(bt,tkey,lsId)
local speakStr='嗷呜'
local lscfg=cfgHelper.get1(cfg_lingshouconfig_get,lsId)
local race=lscfg and lscfg.race or nil
if race then
local lsAIBaseCfg=cfgHelper.get(cfg_lingshouaispeaklibconfig_get,race)
local speakLib=lsAIBaseCfg.slIdleSpeakLib
if speakLib then
local count=#speakLib
if count>1 then
local random=math.random(1,#speakLib)
speakStr=speakLib[random]
else
speakStr=speakLib[1]
end
else



end
else



end
bt:setSharedVar(tkey,speakStr)
end

function UIShouLanFeedingWin:showSpecialHUD(bt,show)
local lsStId=bt:getSharedVar("stId")
for i,v in pairs(self.loadingSTM)do
if v==lsStId then
local mId=i
local hudStId=self.loadingSTHUD[mId]
if hudStId then
local stWidget=_InstantiateManager.GetComponent(hudStId,'CSGUIWidgetBase')

if stWidget then
stWidget:SetChildActive(0,show)
end
end
return
end
end
end

function UIShouLanFeedingWin:initAI()
local dzId=self.bdData.dizi_id
local hasDZ=tostring(dzId)~='0'
if hasDZ then
self:createDZ(dzId,self.enterPos,function(bt)
self.currDZ=bt
self.currDZ:setSharedVar('objState',0)
self:setDZDepth(bt)
end)
end

self.loadingCount=0
self.loadedCount=0
for k,v in pairs(self.slData.petBaseInfoLookup)do
self:handleAddAMonster(v.guid)
end
end

function UIShouLanFeedingWin:endWork()
uiAIManager:removeUIInstance(self.lastDZ)
self.lastDZ=nil
end

function UIShouLanFeedingWin:addNewMonster(mId)
self:onBackBtn()
self:handleAddAMonster(mId,function()

end)
end

function UIShouLanFeedingWin:handleAddAMonster(mId,callback)
self:refreshCount()
self:createAMonster(mId,self:randomAPos(),function(bt)
self:setSTDepth(bt)
local stWidget=bt:getSharedVar('stWidget')
stWidget:SetChildButtonClick(2,function()
self:onMonsterClick(mId)
end)
self.lsList[tostring(mId)]=bt
self.loadedCount=self.loadedCount+1
if self.loadedCount>=self.loadingCount then
if self.defSelect then
self:onMonsterClick(self.defSelect)
self.defSelect=nil
end
end
if callback then
callback()
end
end)
self.loadingCount=self.loadingCount+1
end

function UIShouLanFeedingWin:getMonsterDatas()
local list={}
for k,v in pairs(self.slData.petBaseInfoLookup)do
table.insert(list,v)
end
return list
end

function UIShouLanFeedingWin:setMonsterList()
self.mdatas=self:getMonsterDatas()
self.scrollview:setChildScrollViewCreateGrids(#self.mdatas,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.mdatas[i]
local lsData=lingshouModel:getLingShouData(data.guid)


comHelper.setChildModelHeadIconBGByColor(item,0,lingshouModel.getColorEx(lsData))
comHelper.setChildModelRawImage_lingshou(item,lsData.id,1,0,eHeadCenterType.eHead,1)
item:SetChildActive(2,false)
end
end

function UIShouLanFeedingWin:setRewardList()
local sdata=self.mdatas[self.cmSelect+1]
local rewards=sdata.commItem
self.rwScrollView:setChildScrollViewCreateGrids(#rewards,0)
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local itemWidget=grids[i-1]
local data=rewards[i]
local itemId=data.param_1
local itemCount=data.param_2
local countStr=mathHelper.formatNumber(itemCount)
local showCountBG=true
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemWidget:SetChildActive(-1,true)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetBaseItemClickEvent(0,function(...)
UIShouLanControl:reqReveiveReward(self.bdData.un_build_id,1,{self.currSelect})
end)
end

self.notRewardTips:setActive(count<=0)
end

function UIShouLanFeedingWin:setDZDepth(bt)
self:setDepth(bt,'dzWidget','dzIndex')
end

function UIShouLanFeedingWin:setSTDepth(bt)
self:setDepth(bt,'stWidget','stIndex')
end

function UIShouLanFeedingWin:setDepth(bt,widget,index)
local stWidget=bt:getSharedVar(widget)
local stIndex=bt:getSharedVar(index)
stWidget:SetChildSimulateDepth(stIndex,-250,1500,0.5,0.001,0.001)
stWidget:SetChildSimulateDepthActiveUpdate(stIndex,true)
end

function UIShouLanFeedingWin:createAMonster(mId,pos,callback)

local tran=self.scene:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])
local dzstr=tostring(mId)
local lsdata=lingshouModel:getLingShouData(mId)
local lscfg=lsdata.cfg
local lsId=lsdata.id
local initData={
lsId=lsId,
mov_min_time=5,
mov_max_time=8,
spk_min_time=5,
spk_max_time=8,
moverate=0.5,
speakrate=0.2,
offset={0,0},
hudIndex=1,
show_hud=false,
}

local shouLanExScale=lscfg.shouLanExScale or 0.5
local otherData={
order=1001,
scale=shouLanExScale,
}
self.loadingSTM[dzstr]=uiAIManager:createALingShou('UIShouLanFeedingWin','bt_ui_sl_monster',mId,tran,vpos,initData,otherData,function(bt)

local shud=lingshouModel:checkStateExist(mId,eLingShouStateType.petBorn)

if shud then
local id=bt:getSharedVar("stId")
local stWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
local hudRoot=stWidget:GetChildGameObject(1).transform
bt:setSharedVar("show_hud",true)
self.loadingSTHUD[dzstr]=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDiscipleTipsHUD,hudRoot,function(id)
bt:setSharedVar("show_hud",false)
end)
end
callback(bt)
end)
end

function UIShouLanFeedingWin:removeAMonster(slId,mId)
if slId~=self.bdData.un_build_id then
return
end
self:refreshCount()
mId=tostring(mId)
local bt=self.lsList[mId]
if bt then
uiAIManager:removeUIInstance(bt)
self.lsList[mId]=nil
end
end

function UIShouLanFeedingWin:createDZ(dzId,pos,callback)
local aicfg=cfgHelper.get1(cfg_feedingaiconfig_get,1)
local initData={
enterPos=self.enterPos,
leavePos=self.leavePos,

centerPos={200,-360},
standPos=0,
speakParent=1,
movecd=aicfg.ui_move_cd,
moverate=aicfg.ui_move_rate,
speakcd=aicfg.ui_speak_cd,
speakrate=aicfg.ui_speak_rate,
}
local tran=self.root:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])
local dzstr=tostring(dzId)
local otherData={
order=1600
}
self.loadingST[dzstr]=uiAIManager:createUIDisciple('UIShouLanFeedingWin','bt_ui_feeding',dzId,tran,vpos,initData,otherData,function(bt)
self.loadingST[dzstr]=nil
callback(bt)
end)
end

function UIShouLanFeedingWin:getDZSpeakText(bt,tkey)
local curr=UIShouLanModel:getMonsterVolume(self.bdData.un_build_id)
local aicfg=cfgHelper.get1(cfg_feedingaiconfig_get,1)
local txts=curr>0 and aicfg.ui_speak_1 or aicfg.ui_speak_2
local str=txts[math.random(1,#txts)]
bt:setSharedVar(tkey,str)
end

function UIShouLanFeedingWin:refreshAI(newDzId,oldDzId)
local newDzIdStr=tostring(newDzId)
local oldDzIdStr=tostring(oldDzId)
if self.lastDZ then
uiAIManager:removeUIInstance(self.lastDZ)
self.lastDZ=nil
end
if oldDzIdStr~='0'and self.currDZ then
self.lastDZ=self.currDZ
self.currDZ=nil
self.lastDZ:setSharedVar('objState',3)
self.lastDZ:broke()
self.lastDZ:reset()
self.lastDZ:tick(0.5)
end
if newDzIdStr~='0'and not self.currDZ then
self.currDZ=self:createDZ(self.bdData.dizi_id,self.leavePos,function(bt)
self.currDZ=bt
self.currDZ:setSharedVar('objState',2)
self.currDZ:tick(0.5)
end)
end
end

function UIShouLanFeedingWin:resetDZInfo()
local dzId=self.bdData.dizi_id
local hasDZ=tostring(dzId)~='0'


if hasDZ then
self.selectBtnText:setText('更换')
else
self.selectBtnText:setText('安排')
end

self.dzInfo:setActive(hasDZ)
self.notDzInfo:setActive(not hasDZ)

if hasDZ then
local name=UIDiscipleModel:getDiscipleName(dzId)
self.dzName:setText(FMT.fmt('执事弟子：{0}',name))
local skillId=cfgHelper.get2(cfg_monijybuildconfig_get,self.bdData.build_id,'pro_skill_id')
local skillName=cfgHelper.get2(cfg_discipleproskillconfig_get,skillId,'name')
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skillId)
self.dzLevel:setText(FMT.fmt('{0}：{1}级',skillName,level))
else




end
end

function UIShouLanFeedingWin:refreshCurrSelect()
if self.currSelect then
self:setMonsterInfo(self.currSelect)
end
end

function UIShouLanFeedingWin:setMonsterInfo(guid)
local lsData=lingshouModel:getLingShouData(guid)
local lsName=lsData.name or lsData.cfg.name
self.name:setText(lsName)
self.jingjie:setText(lingshouModel:getJJName(guid,2))
local addXiuWei_sl=lingshouModel.getLingShouPropertyValEx(guid,lingshouPropertyType.XIUWEI_GET_RATE,0)
self.exp:setText(FMT.fmt('{0}点境界修为/年',addXiuWei_sl))

local volumeCount=lingshouModel.getLingShouPropertyValEx(lsData.guid,lingshouPropertyType.VOLUME)
self.infoVolumeGroup:setChildLayoutGroupCreateItems(volumeCount)

local xqValue=lingshouModel:getLSXinQingValue(guid)
if xqValue<lsData.cfg.max_love then



local addVal=lingshouModel.getLingShouPropertyValEx(guid,lingshouPropertyType.MOOD_CHANGE_VAL)






if addVal==0 then
self.mood:setText(math.floor(xqValue))
else
local changeTypeStr=addVal>0 and"上升"or"下降"
self.mood:setText(FMT.fmt('{0}（{1}/年{2}）',math.floor(xqValue),math.abs(addVal),changeTypeStr))
end
else
self.mood:setText(math.floor(xqValue))
end
self.elementData=feedingSystem:getElementDataM(lsData.cfg)
local attrs=feedingSystem:getElementDataSL(self.bdData.un_build_id,1)
local checklist={{},{}}
for i,v in ipairs(attrs)do
checklist[v[1]][v[2]]=true
end
feedingSystem:setElementList(self.winlua,self.emScrollView:getID(),self.elementData,checklist)
self:setRewardList()
self:setCountDown(lsData)
end

function UIShouLanFeedingWin:refreshCountDown(lsId)
if self.currSelect and lsId and mathHelper.compareInt64(self.currSelect,lsId)then
local lsData=lingshouModel:getLingShouData(lsId)
self:setCountDown(lsData)
end
end


function UIShouLanFeedingWin:refreshMonsterInfoByLsGuid(lsGuid)
if self.currSelect and lsGuid and mathHelper.compareInt64(self.currSelect,lsGuid)then
self:setMonsterInfo(lsGuid)
end
end

function UIShouLanFeedingWin:setCountDown(lsData)
self:clearCountDown()
if not self.bShowInfo then
return
end
local isNowSelectLs=false
if self.currSelect and mathHelper.compareInt64(self.currSelect,lsData.guid)then
isNowSelectLs=true
end
if not isNowSelectLs then
return
end

local cfg=cfgHelper.get1(cfg_lingshouconfig_get,lsData.id)
local data=UIShouLanModel:getMonsterData(self.bdData.un_build_id,lsData.guid)
if data then

local isShouLanStop,reasonStr=UIShouLanModel:isShouLanStop(self.bdData.un_build_id)
if isShouLanStop then
self.countDown:setText(reasonStr)
return
end
local xqValue=lingshouModel:getLSXinQingValueEx(lsData)
local xqLimitCfgVal=feedingSystem:getShouLanCreateXinQingLimitCfgValue()
if xqValue<xqLimitCfgVal then
self.countDown:setText(FMT.fmt("灵兽心情达到{0}点可生产兽材",xqLimitCfgVal))
return
end


local cdTime=data.sec
local endtime=data.begin_time+cdTime
local slId=self.bdData.un_build_id
local lsGuid=lsData.guid
local tick=function(isInit)
local nowTime=timeHelper.getServerShortTime()
local dt=endtime-nowTime

if dt>0 then
self.countDown:setText(FMT.fmt("距离下次产出材料：{0}",timeHelper.format_time_stamp11(dt)))
else
if isInit then
return self:clearCountDown()
else
return self:refreshCountDown(lsGuid)
end
end
end
self.timer=self:setTimer(1,0,tick)
tick(true)
end
end

function UIShouLanFeedingWin:clearCountDown()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIShouLanFeedingWin:onAddBtn()

local bdData=zongmenModel:getBuildingData(self.bdData.un_build_id)
local dzId=bdData.dizi_id
local hasDZ=tostring(dzId)~='0'
if not hasDZ then
UIManager.error("请先选择入驻弟子")

return self:onSelectBtn()
end


UIShouLanControl:showMonsterSelect({slId=self.bdData.un_build_id,stId=self.bdData.entityId})
end

function UIShouLanFeedingWin:onLsAddBtn()
self:onAddBtn()
end

function UIShouLanFeedingWin:onSelectBtn()
zongmenControl:showSelectManagerWin(self.sfId,self.bdData)
end

function UIShouLanFeedingWin:clearTweeners()
for k,v in pairs(self.tweeners)do
v:Kill()
end
self.tweeners={}
end

function UIShouLanFeedingWin:onMonsterClick(guid)
if not self.bShowInfo then
self.currSelect=guid
self.bShowInfo=true
self.manager:setActive(false)
self.info:setActive(true)
self:setMonsterList()
self:stopAllMonster()
self.scene:setActive(false)


local idstr=tostring(guid)
for i,v in ipairs(self.mdatas)do
if tostring(v.guid)==idstr then
self.on_item_click(0,i-1)
break
end
end
end
end

function UIShouLanFeedingWin:moveSceneTo(index)
self:clearTweeners()
local data=self.mdatas[index+1]
local bt=self.lsList[tostring(data.guid)]
local stWidget=bt:getSharedVar('stWidget')
local stIndex=bt:getSharedVar('stIndex')
local stpos=stWidget:GetChildLocalPosition(stIndex)
local scale=1+(stpos.y+250)*0.001

local lsdata=lingshouModel:getLingShouData(data.guid)
local lscfg=lsdata.cfg
local offset=lscfg.modelOffset or{0,-150}
local pos={-stpos.x*scale-216+offset[1],-stpos.y*scale+offset[2]}
self.tweeners[1]=self.scene:setChildDOScale(scale,0.35,nil)
self.tweeners[2]=self.scene:setChildDOLocalMove(Vector3.New(pos[1],pos[2],0),0.35,nil)
end

function UIShouLanFeedingWin:showMainMonster(index)
self:clearTweeners()
local data=self.mdatas[index+1]







local lsdata=lingshouModel:getLingShouData(data.guid)
local lscfg=lsdata.cfg
local scale=lscfg.modelScale
if not scale then

scale=isometricMapSystem:getModelScale(lscfg.model,true)
end













self.scene:setActive(false)
self.infoModel:setChildCanvasGroupAlpha(0)
local modelParams=lingshouModel.getModelParamsEx(lscfg.model)
self.infoModel:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,0,false,true)
local offset=lscfg.modelOffset or{0,-150}
self.infoModel:setChildUIModelShowTargetOffset(offset[1],offset[2])
self.tweeners[1]=self.infoModel:setChildCanvasGroupDOFade(1,0.35,nil)
end

function UIShouLanFeedingWin:showAllMonster(bShow)
for i,v in pairs(self.lsList)do
self:showMonster(v,bShow)
end
end

function UIShouLanFeedingWin:showMonster(bt,bShow)
local stWidget=bt:getSharedVar('stWidget')
local stIndex=bt:getSharedVar('stIndex')
stWidget:SetChildActive(stIndex,bShow)
end

function UIShouLanFeedingWin:showManager(bt,bShow)
if not bt then
return
end
if not bShow then
bt:broke()
end
local stWidget=bt:getSharedVar('dzWidget')
local stIndex=bt:getSharedVar('dzIndex')
stWidget:SetChildActive(stIndex,bShow)
if bShow then
bt:reset()
end
end

function UIShouLanFeedingWin:stopAllMonster()
for i,v in pairs(self.lsList)do
v:broke()
end
end

function UIShouLanFeedingWin:resetAllMonster()
for i,v in pairs(self.lsList)do
v:reset()
end
end

function UIShouLanFeedingWin:onBackBtn()
self.bShowInfo=false
self.currSelect=nil
self.cmSelect=nil
self.manager:setActive(true)
self.info:setActive(false)
self.infoModel:setChildUIModelRemoveTarget()


self.scene:setActive(true)
self:resetAllMonster()
self:clearTweeners()





end

function UIShouLanFeedingWin:onRemoveBtn()
local slId=self.bdData.un_build_id
local lsId=self.currSelect
feedingSystem:checkAndRemoveLingShou(slId,lsId,nil)
end

function UIShouLanFeedingWin:getShowReward()
local sdata=self.mdatas[self.cmSelect+1]
local lsData=lingshouModel:getLingShouData(sdata.guid)
local jjlevel=lsData.jj_lvl
local rwId
local index=1

local items=lsData.cfg.item_create
local unlockLookup={}
for i,v in ipairs(items)do
if jjlevel>=v[1]and jjlevel<=v[2]then
rwId=v[3]
index=i

unlockLookup[i]=true
end
end
local rwlist={}
for i=1,#items do
local v=items[i]
local unlock=unlockLookup[i]
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,v[3])
if rwcfg then
for ii,vv in ipairs(rwcfg.showItems)do
if not rwlist[vv[1]]then
rwlist[vv[1]]={vv,unlock,v[1]}
end
end
end
end
local rtlist={}
for i,v in pairs(rwlist)do
table_insert(rtlist,v)
end
table.sort(rtlist,function(a,b)
return a[2]==true
end)
return rtlist
end

function UIShouLanFeedingWin:onRewardInfoBtn()
local rwlist=self:getShowReward()
self.spPanel:setActive(true)
self.spScrollView:setChildScrollViewCreateGrids(#rwlist,0)
local grids=self.spScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local itemWidget=grids[i-1]
local data=rwlist[i]
local d=data[1]
local itemId=d[1]
local isLock=data[2]==false
local itemCount=not isLock and d[2]or 0
local range=d.range
local gailv=false
local countStr=""
local showCountBG=false
if itemCount>0 then
countStr=mathHelper.formatNumber(itemCount)
showCountBG=true
elseif range and next(range)then
showCountBG=true
else
gailv=true
end

local gray=isLock and 1 or 0
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,gray=gray,range=range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemWidget:SetChildActive(-1,true)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetBaseItemClickEvent(0,function(...)
if isLock then
UIManager.error(FMT.fmt('需要灵兽境界达到{0}',lingshouModel.getJJNameEx(data[3],2)))
end

return self:onClickRewardItem(...)
end)
itemWidget:SetChildActive(2,gailv)
end
end

function UIShouLanFeedingWin:onRWPanelClick()
self.spPanel:setActive(false)
end

function UIShouLanFeedingWin:onDzTipsBtn()
local dzId=self.bdData.dizi_id
local hasDZ=tostring(dzId)~='0'
local level
local index
if hasDZ then
local skillId=cfgHelper.get2(cfg_monijybuildconfig_get,self.bdData.build_id,'pro_skill_id')
level=UIDiscipleModel:getDiscipleJobLevel(dzId,skillId)
end

local datas={}
local cfgs=cfg_petxiulianconfig()
local check=-1
local count=0

for i=0,#cfgs do
local v=cfgs[i]
if v.add_xiulian>check then
check=v.add_xiulian
table.insert(datas,{i,FMT.fmt('{0}%',check)})
count=count+1
if level and level>=i then
index=count
end
end
end
local posVector2=self.dzTipsBtn:getChildScreenPointToLocalPointRectangle()
local args={
titles={'饲养等级','修炼效率'},
datas=datas,
pos={posVector2.x,posVector2.y-18},
selectIndex=index,
}
UIManager:showWindow('UIJobLevelEffectWin',args)
end

function UIShouLanFeedingWin:onHelpBtn()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='ui_shoulan_feeding_help_%s'})
end

function UIShouLanFeedingWin:onDetailBtn()

end

function UIShouLanFeedingWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end

function UIShouLanFeedingWin:onLsClickArea()
if self.cmSelect then
local sdata=self.mdatas[self.cmSelect+1]
local lsGuid=sdata.guid
local fromType=TIPS_FORM_TYPE.eNone
self:showWindow('UILingShouTipsWin',{ls_guid=lsGuid,fromType=fromType})
end
end
