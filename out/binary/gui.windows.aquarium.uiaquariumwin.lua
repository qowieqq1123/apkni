








def_class("UIAquariumWin",UIWindowBase)









function UIAquariumWin:bindComponents()

self.sceneRoot=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.scene=UIObject.get(self,2)
self.center=UIObject.get(self,3)
self.visitPanel=UIObject.get(self,4)
self.putInPanel=UIObject.get(self,5)
self.normalPanel=UIObject.get(self,6)
self.sceneModel=UIObject.get(self,7)
self.placeOrigin=UIObject.get(self,8)
self.lockArea=UIObject.get(self,9)
self.screenUI=UIObject.get(self,10)
self.leaveBtn=UIButton.get(self,11)
self.putInBtn=UIButton.get(self,12)
self.closeBtn=UIButton.get(self,13)
self.topScrollView=UIObject.get(self,14)
self.lingYunBtn=UIButton.get(self,15)
self.managerBtn=UIButton.get(self,16)
self.helpBtn=UIObject.get(self,17)
self.tuJianBtn=UIButton.get(self,18)
self.lingYunRankBtn=UIButton.get(self,19)
self.yuCangBtn=UIButton.get(self,20)
self.xiangQingBtn=UIButton.get(self,21)
self.unlockScrollView=UIObject.get(self,22)
self.paizi=UIObject.get(self,23)
self.shop=UIObject.get(self,24)
self.managerRD=UIObject.get(self,25)
self.tujianRD=UIObject.get(self,26)
self.lingYunBtnText=UIText.get(self,27)
self.lingYunRD=UIObject.get(self,28)
self.shopBtn=UIButton.get(self,29)
self.level=UIText.get(self,30)
self.levelUpBtn=UIButton.get(self,31)
self.levelUpBtnText=UIText.get(self,32)
self.actorName=UIText.get(self,33)
self.saiqianBoxClick=UIButton.get(self,34)
self.saiqianReddot=UIObject.get(self,35)
self.accumulateText=UIText.get(self,36)
self.saiqianRuleBtn=UIButton.get(self,37)
self.saiqianBoxModel=UIObject.get(self,38)

self.leaveBtn:setButtonClick(function()self:onLeaveBtn()end)

self.putInBtn:setButtonClick(function()self:onPutInBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.lingYunBtn:setButtonClick(function()self:onLingYunBtn()end)

self.managerBtn:setButtonClick(function()self:onManagerBtn()end)

self.tuJianBtn:setButtonClick(function()self:onTuJianBtn()end)

self.lingYunRankBtn:setButtonClick(function()self:onLingYunRankBtn()end)

self.yuCangBtn:setButtonClick(function()self:onYuCangBtn()end)

self.xiangQingBtn:setButtonClick(function()self:onXiangQingBtn()end)

self.shopBtn:setButtonClick(function()self:onShopBtn()end)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)

self.saiqianBoxClick:setButtonClick(function()self:onSaiqianBoxClick()end)

self.saiqianRuleBtn:setButtonClick(function()self:onSaiqianRuleBtn()end)



end


function UIAquariumWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.sceneRoot);self.sceneRoot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scene);self.scene=nil;
_UIObject_release(self.center);self.center=nil;
_UIObject_release(self.visitPanel);self.visitPanel=nil;
_UIObject_release(self.putInPanel);self.putInPanel=nil;
_UIObject_release(self.normalPanel);self.normalPanel=nil;
_UIObject_release(self.sceneModel);self.sceneModel=nil;
_UIObject_release(self.placeOrigin);self.placeOrigin=nil;
_UIObject_release(self.lockArea);self.lockArea=nil;
_UIObject_release(self.screenUI);self.screenUI=nil;
_UIObject_release(self.leaveBtn);self.leaveBtn=nil;
_UIObject_release(self.putInBtn);self.putInBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.topScrollView);self.topScrollView=nil;
_UIObject_release(self.lingYunBtn);self.lingYunBtn=nil;
_UIObject_release(self.managerBtn);self.managerBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.tuJianBtn);self.tuJianBtn=nil;
_UIObject_release(self.lingYunRankBtn);self.lingYunRankBtn=nil;
_UIObject_release(self.yuCangBtn);self.yuCangBtn=nil;
_UIObject_release(self.xiangQingBtn);self.xiangQingBtn=nil;
_UIObject_release(self.unlockScrollView);self.unlockScrollView=nil;
_UIObject_release(self.paizi);self.paizi=nil;
_UIObject_release(self.shop);self.shop=nil;
_UIObject_release(self.managerRD);self.managerRD=nil;
_UIObject_release(self.tujianRD);self.tujianRD=nil;
_UIObject_release(self.lingYunBtnText);self.lingYunBtnText=nil;
_UIObject_release(self.lingYunRD);self.lingYunRD=nil;
_UIObject_release(self.shopBtn);self.shopBtn=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.levelUpBtnText);self.levelUpBtnText=nil;
_UIObject_release(self.actorName);self.actorName=nil;
_UIObject_release(self.saiqianBoxClick);self.saiqianBoxClick=nil;
_UIObject_release(self.saiqianReddot);self.saiqianReddot=nil;
_UIObject_release(self.accumulateText);self.accumulateText=nil;
_UIObject_release(self.saiqianRuleBtn);self.saiqianRuleBtn=nil;
_UIObject_release(self.saiqianBoxModel);self.saiqianBoxModel=nil;
end
















local _csguiManager=CS.CSGUIManager.Instance
local _saiqianBoxStateAnimIdList={eAnimationID.stand,eAnimationID.stand2,eAnimationID.stand3,2124}




function UIAquariumWin:onLoaded(...)
self:bindComponents()


self.fishDatas={}

self.normalPanel:setActive(true)
self.putInPanel:setActive(false)
self.visitPanel:setActive(false)

self.aiDiscipleList=aiManager:getAIDiscipleList(eAIDZType.eDefault)
self.currDZList={}
self.dzIndex=math.random(1,#self.aiDiscipleList)
self.visitorNum=0

self.fishTypeIndex={1,2,3,5,6}
self.fishType={
'icon_yuleijy_1',
'icon_yuleijy_2',
'icon_yuleijy_3',
'icon_yuleijy_4',
'icon_yuleijy_5',
'icon_yuleijy_6'
}

self.showModel=1

self.fishColor1=Color.New(0.95,1.0,1.0,1)
self.fishColor2=Color.New(0.29,0.64,0.79,1)
self.defColor1=Color.New(1,1,1,1)
self.defColor2=Color.New(0,0,0,1)


self.depthOffset=0
self.orderOffset=1300
self.baseScale=1
self.colorRate=0.002
self.floorValue=-275
self.saiqianBoxState=nil





self.abName='ui/windows/aquarium/aquarium_atlas_pak.ab'

self.sceneModel:setChildUIModelEnableInitUISpinePara(false,true)
self.sceneModel:setChildUIModelShowTarget(4200,1,nil,eAnimationID.stand)

self.topScrollView:setChildScrollViewInit(0.5,true,nil,nil)

self.unlockScrollView:setChildScrollViewInit(0.5,true,nil,nil)

self.scene:setChildUITouchEvent(function(...)self:onScreenClick(...)end)

self.on_building_event=function(...)self:onBuildingEvent(...)end
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end


function UIAquariumWin:__delete()
self:stopBgAudioSound()
self:unbindComponents()

for k,v in pairs(self.fishDatas)do
if v.hudId then
_InstantiateManager.RemoveInstance(v.hudId)
v.hudId=nil
end
end

self:clearAI()







notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end

function UIAquariumWin:clearAI()
uiAIManager:clearUIWinData('UIAquariumWin')
self.fishDatas={}









if self.visitor_manager then
behaviorManager:removeBehaviorTree(self.visitor_manager)
end
self.visitor_manager=nil

if self.manager then
behaviorManager:removeBehaviorTree(self.manager)
end
self.manager=nil

self.isInitAI=false
end

function UIAquariumWin:onBuildingEvent(etype,sfId,bdId,arg1,arg2)
if self.bdData.un_build_id~=bdId then
return
end
if etype==buildingEvent.replaceDisciple then
self:refreshManager(arg1,arg2)
elseif etype==buildingEvent.levelUpComplete then
self:clearAI()
self:refresh()
end
end


function UIAquariumWin:getFleePos(bt,pkey)
local simWidget=bt:getSharedVar('simWidget')
local cpos=bt:getSharedVar('clickPos')
local lpos=simWidget:GetChildLocalPosition(-1)
local dpos=Vector3.__sub(lpos,cpos)
dpos=Vector3.Normalize(dpos)
local args=bt:getSharedVar('cbtArgs')
local mpos=Vector3.__mul(dpos,args[1]+math.random()*(args[2]-args[1]))
mpos={lpos.x+mpos.x,lpos.y+mpos.y,lpos.z+mpos.z}
local fishItem=bt:getSharedVar('fishItem')

if not self:isPosInFishArea(fishItem,mpos)then
mpos=self:randomAPos(fishItem)
end
local info=UIAquariumControl:getInfoCfgByItemId(fishItem.itemid)
if info.move_bt==2 then
mpos[2]=self.floorValue
end
bt:setSharedVar(pkey,mpos)
end


function UIAquariumWin:getPlayAnimArgs(bt,animId1,animTime1,ptime,animId2,animTime2)
local args=bt:getSharedVar('cbtArgs')
bt:setSharedVar(animId1,args[1][1])
bt:setSharedVar(animTime1,args[1][2])
bt:setSharedVar(ptime,args[2])
bt:setSharedVar(animId2,args[3][1])
bt:setSharedVar(animTime2,args[3][2])
end

function UIAquariumWin:onScreenClick(num,pos)
local tran=self.scene:getCommonComponent('RectTransform')
local lpos=_csguiManager:ScreenPointToRectTransform(tran,pos,true)
for k,v in pairs(self.fishDatas)do
local state=v:getSharedVar('state')
if state==0 then
local fish=v:getSharedVar('fishItem')
local itemCfg=itemsConfig.getConfig(fish.itemid)
local info=cfgHelper.get1(cfg_ylcinfoconfig_get,itemCfg.info)
local simWidget=v:getSharedVar('simWidget')
local spos=simWidget:GetChildLocalPosition(-1)
local cdata=info.click_data
local crang=cdata and cdata[1]or 100
if cdata then
local offset=cdata[2]
spos.x=spos.x+offset[1]
spos.y=spos.y+offset[2]
end
local dis=Vector2.Distance(spos,lpos)
if dis<crang then
local cbt=info.click_bt
if cbt then
v:setSharedVar('clickPos',lpos)
local cstate=cbt[1]
if cstate==3 then
local rtype=cbt[2]
local datas=cbt[3]
local len=#datas
if rtype==1 then
local playIndex=v:getSharedVar('playIndex')or 0
local index=playIndex%len
v:setSharedVar('cbtArgs',datas[index+1])
playIndex=playIndex+1
v:setSharedVar('playIndex',playIndex)
elseif rtype==2 then
v:setSharedVar('cbtArgs',datas[math.random(1,len)])
end
v:setSharedVar('state',2)
else
v:setSharedVar('state',cstate)
v:setSharedVar('cbtArgs',cbt[2])
end
v:broke()
v:reset()
v:quicklyTick()
end
end
end
end
end




function UIAquariumWin:onShow(argtable,afterOnloaded)
if argtable and argtable.data then
self.bdData=argtable.data
else
self.bdData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eYueLongChi)
end

self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.sfId=zongmenModel:getMountainId()

self:refresh()

self:stopBgAudioSound()
self.bgAudioHandleId=nil

local fadeTime=0.75
self.bgAudioHandleId=AudioManager.playAudio(587,nil,nil,fadeTime)
end

function UIAquariumWin:getUnlockLevel(level)
local cfgs=cfg_yuelongchiconfig()
for i,v in ipairs(cfgs)do
if i>=level and v.lock_area then
return i
end
end
end

function UIAquariumWin:initArea()
local level=self:getBDLevel()
local cfgs=cfg_yuelongchiconfig()
local len=#cfgs
local isFull=level>=len
self.lockArea:setActive(not isFull)

local ulevel=self:getUnlockLevel(level)
local cfg=cfgHelper.get1(cfg_yuelongchiconfig_get,ulevel)
self.lockArea:setChildSizeDeltaEx(2,cfg.lock_area,0)

local nlist={}
for i=ulevel,len do
local ccfg=cfgs[i]
if ccfg.lock_area then
table.insert(nlist,ccfg)
end
end

if not isFull then
self:setUnlockInfo(nlist)
end

self:initAreaData(cfg.lock_area)
end

function UIAquariumWin:setUnlockInfo(datas)
local len=#datas-1
self.unlockScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.unlockScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local cfg=datas[i]
local ncfg=datas[i+1]
local width=cfg.lock_area-ncfg.lock_area
item:SetChildSizeDeltaEx(-1,2,width,0)
item:SetChildText(0,FMT.fmt('<color=#7d3b17>跃龙池</color>\n需达到{0}级',ncfg.id))
end

self.unlockScrollView:setActive(false)
self.unlockScrollView:setActive(true)
end

function UIAquariumWin:initAreaData(lockWidth)
local width=self.scene:getChildSizeDeltaX()
local half=width/2
self.placeArea={-1189,-295,1457,-170}
self.dragArea={-half,-375,half,-160}
self.bpos={x=-1572,y=-255,z=20}
self.tpos={x=1572,y=325,z=380}

local line=-half+(width-lockWidth)
self.placeArea[3]=math.min(line,self.placeArea[3])
self.dragArea[3]=math.min(line,self.dragArea[3])
self.tpos.x=math.min(line,self.tpos.x)
end


function UIAquariumWin:onHide()
self:stopBgAudioSound()
end

function UIAquariumWin:getBDLevel()
if self.showModel==2 then
return UIAquariumControl:getVisitLevel()
else
return self.bdData.level
end
end

function UIAquariumWin:enterVisitModelEx()
UIFullDouFaTaiControl:showWindow("UIFightPrepareLoading",{
startCallback=function()
self:enterVisitModel()
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
})
end

function UIAquariumWin:enterVisitModel()
self.showModel=2
self:clearAI()
self:initArea()
self:initAI()
self:setLevelPanel()
local str=FMT.fmt(FMT.fmt('<color=#7d3b17>{0}</color>的跃龙池',UIAquariumControl:getVisitActorName()))
self.actorName:setText(str)
self.normalPanel:setActive(false)
self.visitPanel:setActive(true)

self.shop:setActive(false)
self.levelUpBtn:setActive(false)

end

function UIAquariumWin:leaveVisitModelEx()
UIFullDouFaTaiControl:showWindow("UIFightPrepareLoading",{
startCallback=function()
self:leaveVisitModel()
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
})
end

function UIAquariumWin:leaveVisitModel()
self.showModel=1
self:clearAI()
self.normalPanel:setActive(true)
self.visitPanel:setActive(false)

self.shop:setActive(true)
self.levelUpBtn:setActive(true)

self:refresh()
end

function UIAquariumWin:refresh()
self:initArea()
self:initAI()
self:setLevelPanel()
self:setLingYun()
self:setTopInfo()
self:setReddot()
self:refreshSaiQianBox()
end

function UIAquariumWin:setReddot()
self.tujianRD:setActive(UIAquariumControl:checkHandleBookReddot())
self.managerRD:setActive(UIAquariumControl:checkFishManagerReddot())
self.lingYunRD:setActive(UIAquariumControl:checkLingYunNew())
end

function UIAquariumWin:delaySetReddot()
self:delayDo(0.001,function()
self:setReddot()
end)
end

function UIAquariumWin:setYLReddot()
self.lingYunRD:setActive(UIAquariumControl:checkLingYunNew())
end

function UIAquariumWin:setHBReddot()
self.tujianRD:setActive(UIAquariumControl:checkHandleBookReddot())
end

function UIAquariumWin:setTopInfo()
local countData=UIAquariumControl:getFishTypeCountData()
local len=#self.fishType-1
self.topScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.topScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local ftype=self.fishTypeIndex[i]


item:SetChildCSImageSprite(0,self.abName,self.fishType[ftype])
local cfg=cfgHelper.get1(cfg_yuelongchiconfig_get,self.bdData.level)
local exNum=UIAquariumControl:getExtendNumByType(ftype)
local max=cfg.max[ftype]+exNum
local curr=countData[ftype]or 0
item:SetChildText(1,FMT.fmt('{0}/{1}',curr,max))
item:SetChildActive(2,curr>=max)
end
end

function UIAquariumWin:setLingYun()
local lingyun=UIAquariumControl:countTotalLingyun()
self.lingYunBtnText:setText(lingyun)
end

function UIAquariumWin:setLevelPanel()
self.level:setText(FMT.fmt('{0}级{1}',self:getBDLevel(),self.config.name))
local cddata=buildingCDControl:getCDData(buildingCDType.build,self.bdData.un_build_id,true)
if cddata and cddata.complete then
self.levelUpBtnText:setText('完成升级')
return
end
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)
self.levelUpBtnText:setText(nextLvCfg~=nil and'建筑升级'or'建筑信息')
end

function UIAquariumWin:refreshSaiQianBox()

self.saiqianReddot:setActive(UIAquariumControl:checkSaiQianBoxReddot())

local accumulate=0
local moneyData=UIAquariumControl:getSaiQianBoxMoneyData()
if moneyData and next(moneyData)then
local cfg=cfgHelper.get1(cfg_yuelongchiconfig_get,self.bdData.level)
local storeList=cfg and cfg.store or{}
local allPercent=0
local moneyTypeCount=0
for moneyType,maxNum in pairs(storeList)do
local nowMoneyCount=moneyData[moneyType]or 0
allPercent=allPercent+nowMoneyCount/maxNum
moneyTypeCount=moneyTypeCount+1
end
accumulate=math.floor(allPercent*100/moneyTypeCount)
end
self.accumulateText:setText(FMT.fmt("收益累计：{0}%",accumulate))

local newState=1
if accumulate==0 then
newState=1
elseif accumulate>0 and accumulate<=40 then
newState=2
elseif accumulate>40 and accumulate<=80 then
newState=3
elseif accumulate>80 and accumulate<=100 then
newState=4
end
if not self.saiqianBoxState then

local modelId=4494
self.saiqianBoxState=newState
local animId=_saiqianBoxStateAnimIdList[newState]
self.saiqianBoxModel:setChildUIModelShowTarget(modelId,1,nil,animId)
elseif self.saiqianBoxState~=newState then

self.saiqianBoxState=newState
local animId=_saiqianBoxStateAnimIdList[newState]
self.saiqianBoxModel:setChildModelAnimationState(animId)
end
end

function UIAquariumWin:initAI()
if self.isInitAI then
return
end
self.isInitAI=true

self:loadAllFish()

local aicfg=cfgHelper.get1(cfg_yuelongchiaiconfig_get,1)

local initData={
entercd=aicfg.ui_enter_cd,
enterrate=aicfg.ui_enter_rate
}
self.visitor_manager=behaviorManager:addBehaviorTree('bt_ui_aquarium_manager',nil,true,initData)

if self.showModel==2 then
return
end





self:createManager()
end

function UIAquariumWin:getADisciple()
local len=#self.aiDiscipleList
local count=0
while(count<5)do
local dz=self.aiDiscipleList[self.dzIndex]
if not self.currDZList[dz]and tostring(self.bdData.dizi_id)~=tostring(dz)then
return dz
end
self.dzIndex=self.dzIndex+1
if self.dzIndex>len then
self.dzIndex=1
end
count=count+1
end
return nil
end

function UIAquariumWin:addAVisitor()
if self.visitorNum<10 then
self:createVisitor()
end
end

function UIAquariumWin:createVisitor()
local dzId=self:getADisciple()
if not dzId then
return
end
self.currDZList[tostring(dzId)]=true
self.visitorNum=self.visitorNum+1
local aicfg=cfgHelper.get1(cfg_yuelongchiaiconfig_get,1)
local tran=self.scene:getCommonComponent('Transform')
local pos=Vector3.New(0,0,0)
local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
offset={0,0},
speakTime=3,
speakRate=aicfg.ui_speak_rate_2,
speakCD=aicfg.ui_speak_cd_2,
}
local otherData={
order=1001,
}
uiAIManager:createUIDisciple('UIAquariumWin','bt_ui_aquarium_visitor',dzId,tran,pos,initData,otherData,function(bt)
self:setDepth(bt,nil,true)
local simWidget=bt:getSharedVar('simWidget')
local spos=Vector3.New(-1700,self.floorValue,-50)
simWidget:SetChildAnchoredPosition3D(-1,spos)
end)
end

function UIAquariumWin:getSpeakText(bt,tkey,stype)
local aicfg=cfgHelper.get1(cfg_yuelongchiaiconfig_get,1)
local datas=aicfg[string.format('ui_speak_%d',stype)]
local str=datas[math.random(1,#datas)]
bt:setSharedVar(tkey,str)
end

function UIAquariumWin:getPassInfo(bt,ipkey,opkey,tkey,dkey,spkey)
local aicfg=cfgHelper.get1(cfg_yuelongchiaiconfig_get,1)
local speedData=aicfg.ui_move_speed
local mspeed=speedData[1]+math.random()*speedData[2]
local etime=0.5
local dis=3342
local ptime=dis/mspeed
local xp=math.random(1,2)==1 and-1671 or 1671
local yp=self.floorValue
local zp=-(math.random(225,375))
bt:setSharedVar(ipkey,{xp,yp,zp})
bt:setSharedVar(opkey,{-xp,yp,zp})
bt:setSharedVar(tkey,etime)
bt:setSharedVar(dkey,ptime-etime)
bt:setSharedVar(spkey,mspeed)
end

function UIAquariumWin:dzLeave(bt)
local dzId=bt:getSharedVar('dzId')
uiAIManager:removeUIInstance(bt)
self.currDZList[dzId]=nil
self.visitorNum=self.visitorNum-1
end

function UIAquariumWin:refreshManager(newDzId,oldDzId)
local newDzIdStr=tostring(newDzId)
local oldDzIdStr=tostring(oldDzId)
if oldDzIdStr~='0'and self.manager then
uiAIManager:removeUIInstance(self.manager)
self.manager=nil
end
if newDzIdStr~='0'and not self.manager then
self:createManager(newDzId)
end
end

function UIAquariumWin:createManager(dzId)
local aicfg=cfgHelper.get1(cfg_yuelongchiaiconfig_get,1)
local tran=self.shop:getCommonComponent('Transform')
local pos=Vector3.New(0,0,0)
local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
offset={0,0},
speakTime=3,
speakRate=aicfg.ui_speak_rate_1,
speakCD=aicfg.ui_speak_cd_1,
}
local otherData={

}









uiAIManager:createEmptyObject('UIAquariumWin','bt_ui_aquarium_work',INSTANCE_TYPE.eUIDisciple,tran,
pos,initData,otherData,function(bt)
end)
end

function UIAquariumWin:loadAllFish()
local isVisitModel=self.showModel==2
local fishs
if isVisitModel then
fishs=UIAquariumControl:getVisitFishItems()
else
fishs=UIAquariumControl:getFishItems()
end
for k,v in pairs(fishs)do
self:loadObjectByItem(v,isVisitModel)
end
end

function UIAquariumWin:loadObjectByItem(item,isVisitModel)
local cfg=itemsConfig.getConfig(item.itemid)
if cfg.type1~=6 then
self:addFish(item)
else
local origin=self.placeOrigin:getChildLocalPosition()
local data
if isVisitModel then
data=UIAquariumControl:getVisitDecorationData(item.itemguid)
else
data=UIAquariumControl:getDecorationData(item.itemguid)
end
local pos={data.x+origin.x,data.y+origin.y,data.z+origin.z}
self:addDecoration(item,pos)
end
end

function UIAquariumWin:moveDecoration(item)
self.normalPanel:setActive(false)
self.putInPanel:setActive(true)


local data=self.fishDatas[tostring(item.itemguid)]
local stWidget=data:getSharedVar('stWidget')
local spos=self.scene:getChildAnchoredPosition()
local tpos=stWidget:GetChildAnchoredPosition(-1)
self.scene:setChildAnchoredPosition(Vector2.New(-tpos.x,spos.y))
self:setDecorationToLayoutState(data,stWidget)
self.placeState=2
end

function UIAquariumWin:toDecoration(item)
self.normalPanel:setActive(false)
self.putInPanel:setActive(true)
self:addDecoration(item,nil,function(data,stWidget)
self:setDecorationToLayoutState(data,stWidget)
end)
self.placeState=1
end

function UIAquariumWin:completeDecoration(posInfo)
self.normalPanel:setActive(true)
self.putInPanel:setActive(false)

local data=self.fishDatas[tostring(posInfo.catchguid)]
if data.hudId then
_InstantiateManager.RemoveInstance(data.hudId)
data.hudId=nil
end

local stWidget=data:getSharedVar('stWidget')
stWidget:SetChildActive(0,false)
UIManager:showWindow('UIAquariumManagerWin',{fishGuid=posInfo.catchguid})
end

function UIAquariumWin:setDecorationToLayoutState(data,stWidget)
stWidget:SetChildActive(0,true)
local hudParent=stWidget:GetCommonComponent(1,'Transform')
local hudId=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIMarkHUD,hudParent,function(hId)
local hudWidget=_InstantiateManager.GetComponent(hId,'CSGUIWidgetBase')
hudWidget:SetChildCSImageSprite(0,globalABLookup.global,'image_tyjiantou_1')
hudWidget:SetChildAnchoredPosition(-1,Vector2.New(0,100))
local tween=hudWidget:SetChildDOAnchorPosY(-1,80,1,nil)
tween:SetEase(_Ease.InOutSine)
tween:SetLoops(-1,_LoopType.Yoyo)

stWidget:SetChildSimulate3DActiveDragMode(-1,true)
local parea=self.placeArea
local darea=self.dragArea
local areaData={
parea[1],parea[2],parea[3],parea[4],
darea[1],darea[2],darea[3],darea[4],
50,0,50,0,
}
stWidget:SetChildSimulate3DDragArea(-1,true,Color.New(1,0,0,1),areaData)
end)
data.hudId=hudId
data:setSharedVar('state',1)
self.placeTarget=data
end

function UIAquariumWin:addDecoration(item,tpos,callback)




































local tran=self.scene:getCommonComponent('Transform')
local pos=Vector3.New(0,0,0)
local initData={
state=0,
}
local otherData={
order=self.orderOffset,
}

local itemCfg=itemsConfig.getConfig(item.itemid)
local cfg=cfgHelper.get1(cfg_ylcinfoconfig_get,itemCfg.info)
uiAIManager:createAquariunFish('UIAquariumWin','bt_ui_aquarium_decoration',cfg.model,tran,pos,initData,otherData,function(bt)
bt:setSharedVar('fishItem',item)

local stWidget=bt:getSharedVar('stWidget')
local stIndex=bt:getSharedVar('stIndex')

stWidget:SetChildSimulate3D(stIndex,self.depthOffset,self.baseScale,self.orderOffset,0.5,0.001,Vector2.New(0,0.001),nil)

stWidget:SetChildSimulate3DActiveCoverColor(stIndex,true,self.colorRate,self.fishColor1,self.fishColor2)

local rect=cfg.rect
if rect then
stWidget:SetChildLocalPos(0,rect[1],rect[2],0)
stWidget:SetChildSizeDelta(0,rect[3],rect[4])
end

local simWidget=stWidget:GetChildSimulateTargetComponent(stIndex,'CSGUIWidgetBase')
local simPos
if not tpos then
local spos=self.scene:getChildAnchoredPosition()
simPos=Vector3.New(-spos.x,self.floorValue,200)
else
simPos=Vector3.New(tpos[1],self.floorValue,tpos[3])
end
simWidget:SetChildAnchoredPosition3D(stIndex,simPos)

bt:setSharedVar('simWidget',simWidget)
bt:setSharedVar('simIndex',-1)

self.fishDatas[tostring(item.itemguid)]=bt

if callback then
callback(bt,stWidget)
end
end)


end

function UIAquariumWin:putInFish(item)
self:loadObjectByItem(item)
end

function UIAquariumWin:removeFish(guid)
local guidStr=tostring(guid)
local bt=self.fishDatas[guidStr]
if bt then
uiAIManager:removeUIInstance(bt)
self.fishDatas[guidStr]=nil




end
end

function UIAquariumWin:findActiveFeatureAICfg(item)
local fratures=item.itemData.featureList
local cfgs=cfg_ylcaifeatureconfig()
if fratures then
for i,v in ipairs(fratures)do
if cfgs[v]then
return cfgs[v]
end
end
end
return cfgs[0]
end

function UIAquariumWin:addFish(item)
local tran=self.scene:getCommonComponent('Transform')
local pos=Vector3.New(0,0,0)
local fcfg=self:findActiveFeatureAICfg(item)
local initData={
moveEase=_Ease.InOutSine,
state=0,
moveRate=fcfg.move_rate,
waitTime=fcfg.wait_time,
moveSpeed=fcfg.move_speed,
fleeSpeed=fcfg.flee_speed,
}
local otherData={
order=self.orderOffset,
}
local itemCfg=itemsConfig.getConfig(item.itemid)
local cfg=cfgHelper.get1(cfg_ylcinfoconfig_get,itemCfg.info)
uiAIManager:createAquariunFish('UIAquariumWin','bt_ui_aquarium_fish',cfg.model,tran,pos,initData,otherData,function(bt)
bt:setSharedVar('fishItem',item)
self:setDepth(bt,item,true)
self.fishDatas[tostring(item.itemguid)]=bt
end)
end























function UIAquariumWin:setDepth(bt,fishItem,bUpdate)
local isFish=fishItem~=nil
local size=isFish and UIAquariumControl:getFishSize(fishItem.itemguid)or 1
local stWidget=bt:getSharedVar('stWidget')
local stIndex=bt:getSharedVar('stIndex')

local scale
local color1
local color2
if isFish then
scale=UIAquariumControl:countScaleBySize(self.baseScale,size,fishItem.itemid)
color1=self.fishColor1
color2=self.fishColor2
stWidget:SetChildActive(0,false)
else
scale=self.baseScale*0.8
color1=self.defColor1
color2=self.defColor2
stWidget:SetChildActive(2,false)
end
stWidget:SetChildSimulate3D(stIndex,self.depthOffset,scale,self.orderOffset,0.5,0.001,Vector2.New(0,0.001),nil)
stWidget:SetChildSimulate3DActiveUpdate(stIndex,bUpdate)
stWidget:SetChildSimulate3DActiveCoverColor(stIndex,true,self.colorRate,color1,color2)
local simWidget=stWidget:GetChildSimulateTargetComponent(stIndex,'CSGUIWidgetBase')
bt:setSharedVar('simWidget',simWidget)
bt:setSharedVar('simIndex',-1)
if isFish then
local rp=self:randomAPos(fishItem)
local pos=Vector3.New(rp[1],rp[2],rp[3])
simWidget:SetChildAnchoredPosition3D(-1,pos)
end
end

function UIAquariumWin:getFishArea(fishItem)
local bpos=self.bpos
local tpos=self.tpos
local itemCfg=itemsConfig.getConfig(fishItem.itemid)
local limit=cfgHelper.get2(cfg_ylcinfoconfig_get,itemCfg.info,'move_limit')
if limit then
bpos={x=bpos.x+limit[1],y=bpos.y+limit[2],z=bpos.z+limit[3]}
tpos={x=tpos.x-limit[4],y=tpos.y-limit[5],z=tpos.z-limit[6]}
end
return bpos,tpos
end

function UIAquariumWin:isPosInFishArea(fishItem,pos)
local bpos,tpos=self:getFishArea(fishItem)
if pos[1]<bpos.x or pos[2]<bpos.y or pos[3]<bpos.z or pos[1]>tpos.x or pos[2]>tpos.y or pos[3]>tpos.z then
return false
end
return true
end

function UIAquariumWin:randomAPos(fishItem)
local bpos,tpos=self:getFishArea(fishItem)
local dx=tpos.x-bpos.x
local dy=tpos.y-bpos.y
local dz=tpos.z-bpos.z
local pos={
bpos.x+dx*math.random(),
bpos.y+dy*math.random(),
bpos.z+dz*math.random(),
}
local info=UIAquariumControl:getInfoCfgByItemId(fishItem.itemid)
if info.move_bt==2 then
pos[2]=self.floorValue
end
return pos
end



function UIAquariumWin:randomAMovePos(bt,pkey)
local fishItem=bt:getSharedVar('fishItem')
local pos=self:randomAPos(fishItem)
bt:setSharedVar(pkey,pos)
end

function UIAquariumWin:completeChangeSize(sizeInfo)
local bt=self.fishDatas[tostring(sizeInfo.catchguid)]
if bt then
local stWidget=bt:getSharedVar('stWidget')
local stIndex=bt:getSharedVar('stIndex')
local fish=UIAquariumControl:getFishItemByGuid(sizeInfo.catchguid)
local scale=UIAquariumControl:countScaleBySize(self.baseScale,sizeInfo.size,fish.itemid)
stWidget:SetChildSimulate3DBaseScale(stIndex,scale)
end
end




function UIAquariumWin:onLingYunBtn()
UIManager:showWindow('UIAquariumLingYunWin')
end

function UIAquariumWin:onTuJianBtn()
UIAquariumControl:openHandleBookWin()
end

function UIAquariumWin:onLingYunRankBtn()
if UIAquariumControl:checkRankTime()then
UIAquariumControl:reqRankData()
else
UIManager:showWindow('UIAquariumLYRankWin')
end
end

function UIAquariumWin:onYuCangBtn()
UIManager:showWindow('UIAquariumBagWin')
end

function UIAquariumWin:onXiangQingBtn()
UIManager:showWindow('UIAquariumDetailWin')
end

function UIAquariumWin:onManagerBtn()
UIManager:showWindow('UIAquariumManagerWin')
end

function UIAquariumWin:onShopBtn()

jumpManager:jump({id=JUMP_TYPE.eYueLongChiShop,args={page=3}})
end

function UIAquariumWin:onSwitchBtn()
zongmenControl:showSelectManagerWin(self.sfId,self.bdData,dzSelectWinOpenType.eManager)
end

function UIAquariumWin:onLevelUpBtn()
if buildingCDControl:isComplete(buildingCDType.build,self.bdData.un_build_id)then
zongmenControl:reqBuildingLevelUpComplete(self.sfId,self.bdData.un_build_id)
else
UIManager:showWindow('UIBuildingInfoWin',self.bdData)
end
end

function UIAquariumWin:onPutInBtn()
local data=self.placeTarget

local stWidget=data:getSharedVar('stWidget')
local lpos=stWidget:GetChildLocalPosition(-1)
if lpos.x>=self.placeArea[1]and lpos.x<=self.placeArea[3]and lpos.y>=self.placeArea[2]and lpos.y<=self.placeArea[4]then
stWidget:SetChildSimulate3DActiveDragMode(-1,false)
data:setSharedVar('state',0)
local simWidget=stWidget:GetChildSimulateTargetComponent(-1,'CSGUIWidgetBase')
local simpos=simWidget:GetChildAnchoredPosition3D(-1)
local origin=self.placeOrigin:getChildLocalPosition()
local fishItem=data:getSharedVar('fishItem')
local guid=fishItem.itemguid
local sdata={guid,simpos.x-origin.x,simpos.y-origin.y,simpos.z-origin.z}
if self.placeState==1 then
UIAquariumControl:reqDelivery(int64.new('0'),guid)
end
UIAquariumControl:reqPlaced(sdata)
else
UIManager.error('当前位置不能摆放，请重新规划摆件位置')
end
end

function UIAquariumWin:onLeaveBtn()
self:leaveVisitModelEx()
end

function UIAquariumWin:onCloseBtn()
fullScreenUI.closeActiveUI()
end

function UIAquariumWin:stopBgAudioSound()
if self.bgAudioHandleId then
local fadeTime=1
AudioManager.fadeOutStopAudioById(self.bgAudioHandleId,fadeTime,false)
self.bgAudioHandleId=nil
end
end

function UIAquariumWin:onSaiqianBoxClick()
local moneyData=UIAquariumControl:getSaiQianBoxMoneyData()
if not moneyData or not next(moneyData)then
UIManager.info("当前没有收益")
return
end

UIAquariumControl:reqGetSaiQianReward()
end

function UIAquariumWin:onSaiqianRuleBtn()
local d={}
d.title='聚宝贝规则'
d.mode=3
d.name='saiqianbox_help_%d'
UIManager:showWindow('UIRuleWin',d)
end
