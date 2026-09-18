







def_class("UILingZhenHHGameExWin",UIWindowBase)









function UILingZhenHHGameExWin:bindComponents()

self.helpBtn=UIButton.get(self,0)
self.gamePanel=UIObject.get(self,1)
self.time=UIText.get(self,2)
self.skillBtnC=UIButton.get(self,3)
self.skillBtnB=UIButton.get(self,4)
self.skillBtnA=UIButton.get(self,5)
self.rpos=UIObject.get(self,6)
self.itemRoot=UIObject.get(self,7)
self.bpos_6=UIObject.get(self,8)
self.bpos_7=UIObject.get(self,9)
self.bpos_4=UIObject.get(self,10)
self.bpos_3=UIObject.get(self,11)
self.bpos_2=UIObject.get(self,12)
self.bpos_1=UIObject.get(self,13)
self.bpos_5=UIObject.get(self,14)
self.topScore=UIText.get(self,15)
self.currScore=UIText.get(self,16)
self.scoreArea=UIObject.get(self,17)
self.closeBtn=UIButton.get(self,18)
self.remainingNumA=UIText.get(self,19)
self.remainingNumB=UIText.get(self,20)
self.remainingNumC=UIText.get(self,21)
self.skillNameA=UIText.get(self,22)
self.skillNameB=UIText.get(self,23)
self.skillNameC=UIText.get(self,24)
self.remainingNumRootA=UIObject.get(self,25)
self.remainingNumRootB=UIObject.get(self,26)
self.remainingNumRootC=UIObject.get(self,27)
self.rposScrollView=UIObject.get(self,28)
self.bgModel=UIObject.get(self,29)
self.bottomModel=UIObject.get(self,30)
self.bottomClick=UIButton.get(self,31)
self.loadingText=UIText.get(self,32)
self.rposMoveList=UIObject.get(self,33)
self.rposClickMask=UIObject.get(self,34)
self.speakObj=UIObject.get(self,35)
self.speakText=UIText.get(self,36)
self.speakBg1=UIObject.get(self,37)
self.speakBg2=UIObject.get(self,38)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.skillBtnC:setButtonClick(function()self:onSkillBtnC()end)

self.skillBtnB:setButtonClick(function()self:onSkillBtnB()end)

self.skillBtnA:setButtonClick(function()self:onSkillBtnA()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.bottomClick:setButtonClick(function()self:onBottomClick()end)
self.bpos={
self.bpos_1,
self.bpos_2,
self.bpos_3,
self.bpos_4,
self.bpos_5,
self.bpos_6,
self.bpos_7,
}



end


function UILingZhenHHGameExWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.gamePanel);self.gamePanel=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.skillBtnC);self.skillBtnC=nil;
_UIObject_release(self.skillBtnB);self.skillBtnB=nil;
_UIObject_release(self.skillBtnA);self.skillBtnA=nil;
_UIObject_release(self.rpos);self.rpos=nil;
_UIObject_release(self.itemRoot);self.itemRoot=nil;
_UIObject_release(self.bpos_6);self.bpos_6=nil;
_UIObject_release(self.bpos_7);self.bpos_7=nil;
_UIObject_release(self.bpos_4);self.bpos_4=nil;
_UIObject_release(self.bpos_3);self.bpos_3=nil;
_UIObject_release(self.bpos_2);self.bpos_2=nil;
_UIObject_release(self.bpos_1);self.bpos_1=nil;
_UIObject_release(self.bpos_5);self.bpos_5=nil;
_UIObject_release(self.topScore);self.topScore=nil;
_UIObject_release(self.currScore);self.currScore=nil;
_UIObject_release(self.scoreArea);self.scoreArea=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.remainingNumA);self.remainingNumA=nil;
_UIObject_release(self.remainingNumB);self.remainingNumB=nil;
_UIObject_release(self.remainingNumC);self.remainingNumC=nil;
_UIObject_release(self.skillNameA);self.skillNameA=nil;
_UIObject_release(self.skillNameB);self.skillNameB=nil;
_UIObject_release(self.skillNameC);self.skillNameC=nil;
_UIObject_release(self.remainingNumRootA);self.remainingNumRootA=nil;
_UIObject_release(self.remainingNumRootB);self.remainingNumRootB=nil;
_UIObject_release(self.remainingNumRootC);self.remainingNumRootC=nil;
_UIObject_release(self.rposScrollView);self.rposScrollView=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.bottomModel);self.bottomModel=nil;
_UIObject_release(self.bottomClick);self.bottomClick=nil;
_UIObject_release(self.loadingText);self.loadingText=nil;
_UIObject_release(self.rposMoveList);self.rposMoveList=nil;
_UIObject_release(self.rposClickMask);self.rposClickMask=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.speakBg1);self.speakBg1=nil;
_UIObject_release(self.speakBg2);self.speakBg2=nil;
self.bpos=nil;
end















local _this
local _maxRposItemCount=7
local _brightnessRate=0.5
local _minBrightness=0.2




function UILingZhenHHGameExWin:onLoaded(...)
self:bindComponents()
_this=self

self.selectFunc=function(id)
self:handleItemClick(id)
end

self.itemWidth=86
self.itemHeight=86
self.halfItemWidth=self.itemWidth/2
self.halfItemHeight=self.itemHeight/2
self.spaceWidth=5
self.spaceHeight=5
self.itemPool={}
self.combineList={}
self.recordList={}
self.selectQueue={}
self.recordItemCount=0

self.score=splitNumber.New(0)
self.skillCount={0,0,0,0}

self.loadRecord={}

UIManager.enableTopHourceTips(false)
UIManager.enableMidHourceTips(false)

UIManager.closeTopHourceLamp()
end


function UILingZhenHHGameExWin:__delete()
UIManager.enableTopHourceTips(true)
UIManager.enableMidHourceTips(true)
_this=nil
if not self.ignoreSave then
if not self.isCreatingMap then

local createList=self.createList
local itemList=self.itemList
local combineList=self.combineList
local selectQueue=self.selectQueue
local recordList=self.recordList
local skillCount=self.skillCount
local score=self.score:getValue()or 0
local mapExpireTime=self.mapExpireTime
local selectMapId=self.selectMapId
self.info:setLingZhenPengZhuangGameData(createList,itemList,combineList,selectQueue,recordList,skillCount,score,mapExpireTime,selectMapId)
end
else
self.info:clearLingZhenPengZhuangGameData()
end

self:unbindComponents()
self:clearComboModeTimer()
self:clearTimer()
self:clearExpireTimer()
self:clearSpeakTimer()
for k,v in pairs(self.loadRecord)do
_InstantiateManager.RemoveInstance(k)
end
self.loadRecord=nil
end




function UILingZhenHHGameExWin:onShow(argtable,afterOnloaded)

self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)

local cfg=cfgHelper.get1(cfg_lingzhenhuihuaconfig_get,self.subid)
self.cbNum=cfg.num
self.cbScore=cfg.score
self.comboTime=cfg.comboTime or 2
self.comboScore=cfg.comboScore or self.cbScore

self.selectMapId,self.mapExpireTime=self.info:getTodayMapData()
if not self.selectMapId then
logErr("找不到灵阵碰撞地图id")
return
end
if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5293,1,{},eAnimationID.stand)
self.winlua:SetChildUIModelShowTarget(self.bottomModel:getID(),5294,1,{},eAnimationID.stand)
end

local npcSpeakParam=cfgHelper.get(cfg_lingzhenhuihuaconfig_get,self.subid,"catSpeakParam")
self.maxClickCatNum=npcSpeakParam.maxCount
self.npcTalkShowTime=npcSpeakParam.showTime
self.lastSpeakIndex=nil
self.clickCatNum=nil

self.mapCfg=cfgHelper.get(cfg_lingzhenhuihuamapconfig_get,self.selectMapId)
self.mapIconNameList=cfgHelper.get(cfg_lingzhenhuihuaconfig_get,self.subid,"mapIconName")
self.createList=self:initData()
self.isComboMode=false
self.ignoreSave=false
self:createItemList()
self:initAddScoreShow()
self:refreshSkillBtn()




local nowTopScore=self.info:getTopScore()
local score=self.score:getValue()or 0
if nowTopScore<score then
nowTopScore=score
end
self.topScore:setText(nowTopScore)
end


function UILingZhenHHGameExWin:onHide()
self:clearComboModeTimer()
self:clearTimer()
self:clearSpeakTimer()
end

function UILingZhenHHGameExWin:initData()
local list={}
local maxTypeCount=self.mapCfg.typeCount
local maxSelectTypeCount=self.mapCfg.selectTypeCount
local maxItemCount=self.mapCfg.gridCount
local typeItemCount=maxItemCount/maxSelectTypeCount
if typeItemCount%1>0 then
typeItemCount=math.floor(typeItemCount)
logErr(FMT.fmt("当前格子类型数量不能整除，格子总数:{0}，选择类型数量:{1}",maxItemCount,maxSelectTypeCount))
end

for i=1,maxTypeCount do
list[#list+1]=i
end
local useTypeList={}
for i=1,maxSelectTypeCount do
local index=math.random(1,#list)
table.insert(useTypeList,{type=list[index],count=0})
table.remove(list,index)
end
local createList={}
for i=1,maxItemCount do
local index=math.random(1,#useTypeList)
local td=useTypeList[index]
createList[#createList+1]=td.type
td.count=td.count+1
if td.count>=typeItemCount then
table.remove(useTypeList,index)
end
end
return createList
end

function UILingZhenHHGameExWin:countPos(index,layer,needCountMinPos)
local layerData=self.mapData[layer]
local col=layerData.col
local itemRow=math.floor(index/col)
local itemCol=index%col
if itemCol>0 then
itemRow=itemRow+1
else
itemCol=col
end
local rectMinX,rectMinY
if needCountMinPos then
rectMinX,rectMinY=self:countTopLeftByData(layer)
else
rectMinX=self.rectMinX
rectMinY=self.rectMinY
end
local x=rectMinX+(itemCol-1)*(self.itemWidth+self.spaceWidth)
local y=rectMinY-(itemRow-1)*(self.itemHeight+self.spaceHeight)
return x,y
end

function UILingZhenHHGameExWin:setCreateData()

self.mapData=self.mapCfg and self.mapCfg.mapData or{}
self.layer=#self.mapData
self.layerData=self.mapData[self.layer]
self.sIndex=0
end

function UILingZhenHHGameExWin:countTopLeft()
local x,y=self:countTopLeftByData(self.layer)
self.rectMinX=x
self.rectMinY=y
end

function UILingZhenHHGameExWin:countTopLeftByData(layer)
local layerData=self.mapData[layer]
local col=layerData.col
local row=layerData.num/col
local rectWidth=col*self.itemWidth+(col-1)*self.spaceWidth
local rectHeight=row*self.itemHeight+(row-1)*self.spaceHeight
local rectMinX=-rectWidth/2+self.halfItemWidth
local rectMinY=rectHeight/2-self.halfItemHeight
return rectMinX,rectMinY
end

function UILingZhenHHGameExWin:getNextIndex()
if self.changeLayer then
self.changeLayer=false
self.sIndex=0
self.layer=self.layer-1
self.layerData=self.mapData[self.layer]
end
if self.layerData then
self:countTopLeft()
else
return
end
local find=false
for i=1,self.layerData.num do
self.sIndex=self.sIndex+1
local check=self.layerData.dataArray[self.sIndex]
if check then
find=true
break
end
end
local index=self.sIndex
local layer=self.layer
if self.sIndex>=self.layerData.num then
self.changeLayer=true
end
if find then
return index,layer
else
return self:getNextIndex()
end
end

function UILingZhenHHGameExWin:createItemList()
self.isPlaying=true
self.isCreatingMap=true
self.isInAnim=true
self.itemList={}
self.layerItems={}
self:clearTimer()
self:setCreateData()

local saveGameData=self.info:getLingZhenPengZhuangGameData()
local isLoadSaveData=false
local itemDataList
if saveGameData and next(saveGameData)then
local selectMapId=saveGameData.selectMapId
if self.selectMapId==selectMapId then

self.createList=saveGameData.createList
itemDataList=saveGameData.itemDataList
isLoadSaveData=true
self.skillCount=saveGameData.skillUseCount or{0,0,0,0}
self.mapExpireTime=saveGameData.mapExpireTime or 0
local score=saveGameData.score or 0
self:setScore(score)
end
end

local createCount=0
self.finishCreateItemCount=0
self.loadingText:setText("灵阵绘画中…0%")
self.loadingText:setActive(true)
local onComplete=function()
if not _this then return end


for i,v in pairs(self.itemList)do
v.widget:SetChildCanvasGroupDOFade(-1,1,1.5)
end


for i,v in pairs(self.recordList)do
v.widget:SetChildCanvasGroupDOFade(-1,1,1.5)
end


for i,v in pairs(self.combineList)do
v.widget:SetChildCanvasGroupDOFade(-1,1,1.5)
end
self.loadingText:setActive(false)
self.isPlaying=false
self.isCreatingMap=false
self.isInAnim=false
self:setAllItemStackUp()
self:checkNeedHandleSkillList()


self:checkAndCombine()
end

local setItemFunc=function(id,widget,type,x,y,index,layer,isSelect,posIdx,selectIdx,isRecordItem)
self.finishCreateItemCount=self.finishCreateItemCount+1
local num=math.floor(self.finishCreateItemCount/self.maxCreateItemCount*100)
self.loadingText:setText(FMT.fmt("灵阵绘画中…{0}%",num))


widget:SetChildText(0,type)
widget:SetChildCanvasGroupAlpha(-1,0)
if not isSelect and not isRecordItem then
widget:SetChildLocalPos(-1,x,y,0)
widget:SetChildButtonClickWithID(1,self.selectFunc,id)
elseif isSelect then
local pw=self.bpos[posIdx]
local tp=pw:getChildPosition()
widget:SetChildPosition(-1,tp)
widget:SetChildButtonClickWithID(1,nil,0,true,0)
elseif isRecordItem then
local clickFunc=function(id)
local data=self.recordList[id]
self:recaptionItem(data)
end
widget:SetChildButtonClickWithID(1,clickFunc,id)
end

local iconName=self.mapIconNameList[type]
if iconName then
widget:SetChildCSImageIcon(2,iconName,true)
end
local data={
id=id,
x=x,
y=y,
val=type,
index=index,
layer=layer,
widget=widget
}

if not isSelect and not isRecordItem then
self:addToItemList(data)
elseif isSelect then
data.bActive=true
self.combineList[posIdx]=data
self.selectQueue[selectIdx]=data
elseif isRecordItem then
data.isRecordItem=true
self.recordList[id]=data
self.recordItemCount=self.recordItemCount+1
local parent=self.rpos:getTransform()
self:refreshRecordScrollView()
local tran=widget:GetCommonComponent(-1,'Transform')
tran.parent=parent
end

if createCount<=0 then
onComplete()
end
end

local root=self.gamePanel:getTransform()
local parent=self.itemRoot:getTransform()
local count=0







self.maxCreateItemCount=0
for i=1,#self.createList do
count=count+1
local type=self.createList[count]
local index,layer=self:getNextIndex()
local isCreate=true
local isSelect=false
local isRecordItem=false
if isLoadSaveData then
isCreate=false
if itemDataList[layer]and itemDataList[layer][index]then
isCreate=true
end
end

if isCreate then
self.maxCreateItemCount=self.maxCreateItemCount+1
if self.layerData then
local x,y=self:countPos(index,layer)
local selectIdx
local posIdx
if isLoadSaveData then
local data=itemDataList[layer][index]
if data.val then

type=data.val
end
isSelect=data.isSelect or false
isRecordItem=data.isRecordItem or false
if isSelect then
posIdx=data.posIdx
selectIdx=data.selectIdx
end


end
local id,widget=self:getItemFromPool()
if id then
local tran=widget:GetCommonComponent(-1,'Transform')

tran.parent=root
tran.parent=parent
setItemFunc(id,widget,type,x,y,index,layer,isSelect,posIdx,selectIdx,isRecordItem)
else
createCount=createCount+1
local rid=_InstantiateManager.AddInstance(INSTANCE_TYPE.eLZPZItem,parent,function(_id)
local _widget=_InstantiateManager.GetComponent(_id,'CSGUIWidgetBase')
createCount=createCount-1
setItemFunc(_id,_widget,type,x,y,index,layer,isSelect,posIdx,selectIdx,isRecordItem)
end)
self.loadRecord[rid]=true
end
else
self:clearTimer()
end
end
end
end

function UILingZhenHHGameExWin:clearTimer()
if self.timerId then
self:stopTimerByID(self.timerId)
self.timerId=nil
end
end

function UILingZhenHHGameExWin:addToItemList(data,checkStack)
self.itemList[data.id]=data
local lt=self.layerItems[data.layer]or{}
lt[data.id]=data
self.layerItems[data.layer]=lt
if checkStack then
self:setChangeItemStackUp(data,true)
end
end

function UILingZhenHHGameExWin:removeFormItemList(data,checkStack)
self.itemList[data.id]=nil
self.layerItems[data.layer][data.id]=nil
if checkStack then
self:setChangeItemStackUp(data)
end
end

function UILingZhenHHGameExWin:setAllItemStackUp()
local len=#self.layerItems
local maxLayer
local topLayer
local layerCount=0
local layerIndexList_lookup={}
for layer,lt in pairs(self.layerItems)do
if lt and next(lt)then
layerCount=layerCount+1
if not maxLayer or maxLayer<layer then
maxLayer=layer
end

if not topLayer or topLayer>layer then
topLayer=layer
end
layerIndexList_lookup[layer]=layerCount
end
end

if topLayer+1<=maxLayer then
for i=topLayer+1,maxLayer do
local ltA=self.layerItems[i]or{}

for k,v in pairs(ltA)do
local check=false
check=self:checkStackUp_allUpLayer(v)

local bv=check and(1-((layerIndexList_lookup[v.layer]-1)/layerCount))*_brightnessRate+_minBrightness or 1
v.bActive=not check
v.widget:SetChildDoBrightness(-1,bv,0,nil)

local hasUnder=self:checkHasUnderItem(v)
v.widget:SetChildActive(3,hasUnder and not check)
end
end
end


local lt=self.layerItems[topLayer]
if lt then
for k,v in pairs(lt)do
v.bActive=true
v.widget:SetChildDoBrightness(-1,1,0,nil)

local hasUnder=self:checkHasUnderItem(v)
v.widget:SetChildActive(3,hasUnder)
end
end
end

function UILingZhenHHGameExWin:setChangeItemStackUp(data,checkAdd)
local layer=data.layer
local maxLayer
local topLayer
local layerCount=0
local hasUpLayer=false
local bottomLayerItemList={}
local layerIndexList_lookup={}
for itemLayer,lt in pairs(self.layerItems)do
if lt and next(lt)then
layerCount=layerCount+1
if not maxLayer or maxLayer<itemLayer then
maxLayer=itemLayer
end

if not topLayer or topLayer>itemLayer then
topLayer=itemLayer
end
layerIndexList_lookup[itemLayer]=layerCount

if itemLayer<layer then

if checkAdd and not hasUpLayer then
for i,v in pairs(lt)do
if self:checkStackUp(v,data)then
hasUpLayer=true
break
end
end
end
elseif itemLayer>layer then

for i,v in pairs(lt)do
if self:checkStackUp(data,v)then
table.insert(bottomLayerItemList,v)
end
end
end
end
end

if hasUpLayer then

local bv=(1-((layerIndexList_lookup[data.layer]-1)/layerCount))*_brightnessRate+_minBrightness
data.bActive=false
data.widget:SetChildDoBrightness(-1,bv,0,nil)
end

local hasUnder=self:checkHasUnderItem(data)
data.widget:SetChildActive(3,hasUnder)

if bottomLayerItemList and next(bottomLayerItemList)then
for _,v in pairs(bottomLayerItemList)do
local check=false
if checkAdd then

check=true
else
check=self:checkStackUp_allUpLayer(v)
end


local bv=check and(1-((layerIndexList_lookup[v.layer]-1)/layerCount))*_brightnessRate+_minBrightness or 1
v.bActive=not check
v.widget:SetChildDoBrightness(-1,bv,0,nil)

local hasUnder=self:checkHasUnderItem(v)
v.widget:SetChildActive(3,hasUnder and not check)
end
end


























end

function UILingZhenHHGameExWin:checkStackUp(dataA,dataB)













local itemX=dataB.x
local itemY=dataB.y

local checkItemX=dataA.x
local checkItemY=dataA.y
local checkItemStrX=tostring(checkItemX)
local checkItemStrY=tostring(checkItemY)

local checkPosList={}
local posNumStr_X=tostring(itemX)
local posNumStr_Y=tostring(itemY)
local posNumStr_X_L=tostring(itemX-self.halfItemWidth-self.spaceWidth/2)
local posNumStr_X_R=tostring(itemX+self.halfItemWidth+self.spaceWidth/2)
local posNumStr_Y_B=tostring(itemY-self.halfItemHeight-self.spaceHeight/2)
local posNumStr_Y_U=tostring(itemY+self.halfItemHeight+self.spaceHeight/2)

checkPosList[posNumStr_X]={}
checkPosList[posNumStr_X_L]={}
checkPosList[posNumStr_X_R]={}

checkPosList[posNumStr_X][posNumStr_Y]=true
checkPosList[posNumStr_X_L][posNumStr_Y]=true
checkPosList[posNumStr_X_R][posNumStr_Y]=true
checkPosList[posNumStr_X][posNumStr_Y_B]=true
checkPosList[posNumStr_X][posNumStr_Y_U]=true
checkPosList[posNumStr_X_L][posNumStr_Y_B]=true
checkPosList[posNumStr_X_L][posNumStr_Y_U]=true
checkPosList[posNumStr_X_R][posNumStr_Y_B]=true
checkPosList[posNumStr_X_R][posNumStr_Y_U]=true

if checkPosList[checkItemStrX]and checkPosList[checkItemStrX][checkItemStrY]then
return true
end
return false
end

function UILingZhenHHGameExWin:checkStackUp_allUpLayer(data)
local itemLayer=data.layer
local itemX=data.x
local itemY=data.y

local checkPosList={}
local posNumStr_X=tostring(itemX)
local posNumStr_Y=tostring(itemY)
local posNumStr_X_L=tostring(itemX-self.halfItemWidth-self.spaceWidth/2)
local posNumStr_X_R=tostring(itemX+self.halfItemWidth+self.spaceWidth/2)
local posNumStr_Y_B=tostring(itemY-self.halfItemHeight-self.spaceHeight/2)
local posNumStr_Y_U=tostring(itemY+self.halfItemHeight+self.spaceHeight/2)

checkPosList[posNumStr_X]={}
checkPosList[posNumStr_X_L]={}
checkPosList[posNumStr_X_R]={}

checkPosList[posNumStr_X][posNumStr_Y]=true
checkPosList[posNumStr_X_L][posNumStr_Y]=true
checkPosList[posNumStr_X_R][posNumStr_Y]=true
checkPosList[posNumStr_X][posNumStr_Y_B]=true
checkPosList[posNumStr_X][posNumStr_Y_U]=true
checkPosList[posNumStr_X_L][posNumStr_Y_B]=true
checkPosList[posNumStr_X_L][posNumStr_Y_U]=true
checkPosList[posNumStr_X_R][posNumStr_Y_B]=true
checkPosList[posNumStr_X_R][posNumStr_Y_U]=true

for layer,lt in pairs(self.layerItems)do
if layer<itemLayer then
for i,checkItemData in pairs(lt)do
local posStrX=tostring(checkItemData.x)
local posStrY=tostring(checkItemData.y)
if checkPosList[posStrX]and checkPosList[posStrX][posStrY]then
return true
end
end
end
end

return false
end

function UILingZhenHHGameExWin:checkHasUnderItem(data)
local itemLayer=data.layer
local itemX=data.x
local itemY=data.y

for layer,lt in pairs(self.layerItems)do
if layer>itemLayer then

for i,checkItemData in pairs(lt)do
if checkItemData.x==itemX and checkItemData.y==itemY then
return true
elseif self:checkStackUp(data,checkItemData)then

return false
end
end
end
end

return false
end

function UILingZhenHHGameExWin:handleItemClick(id)
if self.isPlaying or self.isInAnim then
return
end

if#self.combineList>=7 then
return
end

local data=self.itemList[id]

if not data.bActive then
return
end

self:removeFormItemList(data,true)
self:addToCombineList(data)
end

function UILingZhenHHGameExWin:addToCombineList(data)
self.isPlaying=true
local parent=self.gamePanel:getTransform()
local tran=data.widget:GetCommonComponent(-1,'Transform')
tran.parent=parent


data.widget:SetChildButtonClickWithID(1,nil,0,true,0)


data.widget:SetChildActive(3,false)

local check1=0
local check2=false
local playIndex=1
for i,v in ipairs(self.combineList)do
if check1==1 and v.val~=data.val then
table.insert(self.combineList,i,data)
check2=true
playIndex=i
break
end
if v.val==data.val then
check1=1
end
end

if not check2 then
table.insert(self.combineList,data)
playIndex=#self.combineList
end

self:addToQueue(data)

self.isPlaying=false
self:playMoveAnim(playIndex,function()
self:checkAndCombine()
end)
end

function UILingZhenHHGameExWin:playMoveAnim(index,callback)
local len=#self.combineList
local check
for i,v in ipairs(self.combineList)do
if i>=index then
local pw=self.bpos[i]
if pw then
local tp=pw:getChildPosition()
local cb=i==len and callback or nil
v.widget:SetChildDOMove(-1,tp,0.25,cb)
check=true
end
end
end
if not check then
if callback then
callback()
end
end
end

function UILingZhenHHGameExWin:checkAndCombine()
local rval=-1
local index=-1
local count=0
for i,v in ipairs(self.combineList)do
if rval~=v.val then
rval=v.val
index=i
count=1
else
count=count+1
if count>=3 then
break
end
end
end

if count>=self.cbNum then
local list={}
for i=1,count do
local pw=self.bpos[index+i-1]
pw:setChildShowEffect(10219,true)

local data=self.combineList[index]
table.insert(list,data)
table.remove(self.combineList,index)
self:removeFormQueue(data.id)
end
for i,v in ipairs(list)do
_InstantiateManager.RemoveInstance(v.id)
self.loadRecord[v.id]=nil
end
local addScore=self.cbScore
if self.isComboMode then
addScore=self.comboScore
end
self:addScore(addScore)
self:addScoreShow(addScore)
self:enterComboMode()

self.isPlaying=false

self:delayDo(0.3,function()
if not _this then return end
return self:playMoveAnim(index,function()

local k,v=next(self.itemList)
if not k then
self:handleSuccess()
end
end)
end)
else
self.isPlaying=false
if#self.combineList>=7 then
self:handleFailure()
end
end
end

function UILingZhenHHGameExWin:addScore(score)
self:setScore(self.score:getValue()+score)
end

function UILingZhenHHGameExWin:enterComboMode()
self.isComboMode=true
self:clearComboModeTimer()
self.comboModeTimer=self:delayDo(self.comboTime,function()
if not _this then return end
self.isComboMode=false
end)
end

function UILingZhenHHGameExWin:clearComboModeTimer()
if self.comboModeTimer then
self:stopTimerByID(self.comboModeTimer)
self.comboModeTimer=nil
end
end

function UILingZhenHHGameExWin:clearComboMode()
self:clearComboModeTimer()
self.isComboMode=false
end

function UILingZhenHHGameExWin:setScore(score)
self.score:setValue(score)
local nowTopScore=self.info:getTopScore()
if score>nowTopScore then
nowTopScore=score
end
self.topScore:setText(nowTopScore)
self.currScore:setText(self.score:getValue())
end

function UILingZhenHHGameExWin:addToQueue(data)
table.insert(self.selectQueue,1,data)
end

function UILingZhenHHGameExWin:removeFormQueue(id)
for i,v in ipairs(self.selectQueue)do
if v.id==id then
table.remove(self.selectQueue,i)
return
end
end
end

function UILingZhenHHGameExWin:pushToPool(id,widget)
widget:SetChildActive(-1,false)
self.itemPool[id]=widget
end

function UILingZhenHHGameExWin:getItemFromPool()
local id,widget=next(self.itemPool)
if widget then
self.itemPool[id]=nil
widget:SetChildActive(-1,true)
end
return id,widget
end

function UILingZhenHHGameExWin:handleSuccess()

self:clearComboMode()
local score=self.score:getValue()
local originalTopScore=self.info:getTopScore()or 0
self.ignoreSave=true
activitiesHandle_lingzhendiaoke:reqSetScore(_this.actid,_this.subType,_this.subid,score)
local callback=function()
UIFullLingZhenHuiHuaControl:showMainWinNoCloud(_this.activityArgs)
if not _this then return end
self:closeSelf()
end
local data=activitiesModel:getSubActInfoData(_this.actid,_this.subType,_this.subid,score)
local topScore=0
if data then
topScore=data.topScore or 0
end
local temp=
{
success=true,
score=score,
originalTopScore=originalTopScore,
roletopScore=topScore,
callback=callback,
act_id=_this.actid,
sub_act_type=_this.subType,
sub_act_id=_this.subid,
}
self:showWindow('UILZHHResultWin',temp)
end

function UILingZhenHHGameExWin:handleFailure()
self:clearComboMode()
local count=self.skillCount[4]
local skillId=4
local cfg=cfgHelper.get1(cfg_lzhhskillinfoconfig_get,skillId)
local max=cfg.maxUseCount or-1
if max==-1 or(max>0 and count<max)then
self:showSkillWin(skillId)
else
self:showFailureWin()
end
end

function UILingZhenHHGameExWin:showFailureWin()

local score=self.score:getValue()
local originalTopScore=self.info:getTopScore()or 0
self.ignoreSave=true
activitiesHandle_lingzhendiaoke:reqSetScore(_this.actid,_this.subType,_this.subid,score)
local callback=function()
UIFullLingZhenHuiHuaControl:showMainWinNoCloud(_this.activityArgs)
if not _this then return end
self:closeSelf()
end
local data=activitiesModel:getSubActInfoData(_this.actid,_this.subType,_this.subid,score)
local topScore=0
if data then
topScore=data.topScore or 0
end
local temp=
{
success=false,
score=score,
originalTopScore=originalTopScore,
roletopScore=topScore,
callback=callback,
act_id=_this.actid,
sub_act_type=_this.subType,
sub_act_id=_this.subid,
}
self:showWindow('UILZHHResultWin',temp)
end

function UILingZhenHHGameExWin:showSkillWin(id)

self:showWindow('UILZHHSkillWin',{id=id,count=self.skillCount[id],act_id=self.actid,sub_act_type=self.subType,sub_act_id=self.subid})

end

function UILingZhenHHGameExWin:handleSkill(id)
if self.isCreatingMap or self.isInAnim then

if not self.needHandleSkillList then
self.needHandleSkillList={}
end
self.needHandleSkillList[#self.needHandleSkillList+1]=id
return
end

if id==1 then
local removeCount=3
self:removeItem(removeCount)
elseif id==2 then
self:revocationItem()
elseif id==3 then
self:randomItemList()
elseif id==4 then
self:clearCombineList()
end
self.skillCount[id]=self.skillCount[id]+1
self:refreshSkillBtn()
end

function UILingZhenHHGameExWin:checkNeedHandleSkillList()
if self.needHandleSkillList and next(self.needHandleSkillList)then
local skillId=self.needHandleSkillList[1]
table.remove(self.needHandleSkillList,1)
return self:handleSkill(skillId)
end
end

function UILingZhenHHGameExWin:refreshSkillBtn()
local allSkillCfg=cfg_lzpzskillinfoconfig()
local skillId=1
local maxUseCountA=allSkillCfg[skillId]and allSkillCfg[skillId].maxUseCount or-1
local skillNameA=allSkillCfg[skillId]and allSkillCfg[skillId].name or""
local isShowRemainingNumA=maxUseCountA>0
self.skillNameA:setText(skillNameA)
self.remainingNumRootA:setActive(isShowRemainingNumA)
if isShowRemainingNumA then
local useCount=self.skillCount[skillId]or 0
local remainingNum=maxUseCountA-useCount
if remainingNum<0 then
remainingNum=0
end
self.remainingNumA:setText(remainingNum)
end

local skillId=2
local maxUseCountB=allSkillCfg[skillId]and allSkillCfg[skillId].maxUseCount or-1
local skillNameB=allSkillCfg[skillId]and allSkillCfg[skillId].name or""
local isShowRemainingNumB=maxUseCountB>0
self.skillNameB:setText(skillNameB)
self.remainingNumRootB:setActive(isShowRemainingNumB)
if isShowRemainingNumB then
local useCount=self.skillCount[skillId]or 0
local remainingNum=maxUseCountB-useCount
if remainingNum<0 then
remainingNum=0
end
self.remainingNumB:setText(remainingNum)
end

local skillId=3
local maxUseCountC=allSkillCfg[skillId]and allSkillCfg[skillId].maxUseCount or-1
local skillNameC=allSkillCfg[skillId]and allSkillCfg[skillId].name or""
local isShowRemainingNumC=maxUseCountC>0
self.skillNameC:setText(skillNameC)
self.remainingNumRootC:setActive(isShowRemainingNumC)
if isShowRemainingNumC then
local useCount=self.skillCount[skillId]or 0
local remainingNum=maxUseCountC-useCount
if remainingNum<0 then
remainingNum=0
end
self.remainingNumC:setText(remainingNum)
end
end

function UILingZhenHHGameExWin:removeItem(removeCount,isLast)
local list={}
local len=#self.combineList
local count=math.min(len,removeCount)








local originalList=self.combineList
local newList={}
for i=1,len do
local data=originalList[i]
local isRemoveItem=false
if isLast then
isRemoveItem=i>len-count
else
isRemoveItem=i<=count
end

if isRemoveItem then
table.insert(list,data)
self:removeFormQueue(data.id)
else
table.insert(newList,data)
end
end
self.combineList=newList

local clickFunc=function(id)
local data=self.recordList[id]
self:recaptionItem(data)
end

local onCompleteFunc=function()
if not _this then return end
_this:playMoveAnim(1)

_this.rposScrollView:setChildCanvasGroupDOFade(1,0.25,function()
if not _this then return end

if _this.cloneItemList and next(_this.cloneItemList)then
for i,v in ipairs(_this.cloneItemList)do
local id=v.id
if _this.loadRecord[id]then
_InstantiateManager.RemoveInstance(id)
_this.loadRecord[id]=nil
end
end
_this.cloneItemList=nil
end
_this.rposClickMask:setActive(false)
_this.isInAnim=false
_this:checkNeedHandleSkillList()
end)
end

local startMoveFunc=function()
if _this==nil then return end
local parent=self.rpos:getTransform()
local cloneParent=self.rposMoveList:getTransform()
self.cloneItemList={}
local listCount=#list
self.recordItemCount=self.recordItemCount+listCount
self:refreshRecordScrollView()
local rposScrollViewPos=self.rposScrollView:getChildLocalPosition()
local rposScrollViewWidth=self.rposScrollView:getChildSizeDeltaX()
local rposScrollViewLeftPosX=rposScrollViewPos.x-rposScrollViewWidth/2
self.cloneMoveCount=listCount
for i,v in ipairs(list)do
local tran=v.widget:GetCommonComponent(-1,'Transform')
local originalPos=v.widget:GetChildPosition(-1)
local moveTargetPosX=rposScrollViewLeftPosX+10+86/2+(86+2)*(i-1)


local rid=_InstantiateManager.AddInstance(INSTANCE_TYPE.eLZPZItem,cloneParent,function(_id)
tran.parent=parent
tran:SetSiblingIndex(i-1)
v.widget:SetChildButtonClickWithID(1,clickFunc,v.id)
_this.recordList[v.id]=v

local cloneWidget=_InstantiateManager.GetComponent(_id,'CSGUIWidgetBase')
if not _this then return end
_this.cloneItemList[i]={id=_id,widget=cloneWidget}
local itemType=v.val
local iconName=itemType and _this.mapIconNameList[itemType]or nil
if iconName then
cloneWidget:SetChildCSImageIcon(2,iconName,true)
end
cloneWidget:SetChildPosition(-1,originalPos)
local targetPos=Vector3.New(moveTargetPosX,rposScrollViewPos.y,rposScrollViewPos.z)
cloneWidget:SetChildDOLocalMove(-1,targetPos,0.25,function()
if not _this then return end
_this.cloneMoveCount=_this.cloneMoveCount-1
if _this.cloneMoveCount<=0 then
return onCompleteFunc()
end
end)
end)
self.loadRecord[rid]=true
end
end
self.isInAnim=true
self.rposClickMask:setActive(true)
self.rposScrollView:setChildCanvasGroupDOFade(0,0.25,startMoveFunc)
end

function UILingZhenHHGameExWin:removeSingleItemById(targetId)
local list={}
local len=#self.combineList
for i=1,len do
local data=self.combineList[i]
if data.id==targetId then
table.insert(list,data)
table.remove(self.combineList,i)
self:removeFormQueue(data.id)
break
end
end

local clickFunc=function(id)
local data=self.recordList[id]
self:recaptionItem(data)
end

local onCompleteFunc=function()
if not _this then return end
_this:playMoveAnim(1)

_this.rposScrollView:setChildCanvasGroupDOFade(1,0.25,function()
if not _this then return end

if _this.cloneItemList and next(_this.cloneItemList)then
for i,v in ipairs(_this.cloneItemList)do
local id=v.id
if _this.loadRecord[id]then
_InstantiateManager.RemoveInstance(id)
_this.loadRecord[id]=nil
end
end
_this.cloneItemList=nil
end
_this.rposClickMask:setActive(false)
_this.isInAnim=false
_this:checkNeedHandleSkillList()
end)
end

local startMoveFunc=function()
if _this==nil then return end
local parent=self.rpos:getTransform()
local cloneParent=self.rposMoveList:getTransform()
self.cloneItemList={}
local listCount=#list
self.recordItemCount=self.recordItemCount+listCount
self:refreshRecordScrollView()
local rposScrollViewPos=self.rposScrollView:getChildLocalPosition()
local rposScrollViewWidth=self.rposScrollView:getChildSizeDeltaX()
local rposScrollViewLeftPosX=rposScrollViewPos.x-rposScrollViewWidth/2
self.cloneMoveCount=listCount
for i,v in ipairs(list)do
local tran=v.widget:GetCommonComponent(-1,'Transform')
local originalPos=v.widget:GetChildPosition(-1)
local moveTargetPosX=rposScrollViewLeftPosX+10+86/2+(86+2)*(i-1)


local rid=_InstantiateManager.AddInstance(INSTANCE_TYPE.eLZPZItem,cloneParent,function(_id)
tran.parent=parent
tran:SetSiblingIndex(i-1)
v.widget:SetChildButtonClickWithID(1,clickFunc,v.id)
_this.recordList[v.id]=v

local cloneWidget=_InstantiateManager.GetComponent(_id,'CSGUIWidgetBase')
if not _this then return end
_this.cloneItemList[i]={id=_id,widget=cloneWidget}
local itemType=v.val
local iconName=itemType and _this.mapIconNameList[itemType]or nil
if iconName then
cloneWidget:SetChildCSImageIcon(2,iconName,true)
end
cloneWidget:SetChildPosition(-1,originalPos)
local targetPos=Vector3.New(moveTargetPosX,rposScrollViewPos.y,rposScrollViewPos.z)
cloneWidget:SetChildDOLocalMove(-1,targetPos,0.25,function()
if not _this then return end
_this.cloneMoveCount=_this.cloneMoveCount-1
if _this.cloneMoveCount<=0 then
return onCompleteFunc()
end
end)
end)
self.loadRecord[rid]=true
end
end
self.isInAnim=true
self.rposClickMask:setActive(true)
self.rposScrollView:setChildCanvasGroupDOFade(0,0.25,startMoveFunc)
end

function UILingZhenHHGameExWin:recaptionItem(data)
self.recordList[data.id]=nil
data.isRecordItem=true

self.recordItemCount=self.recordItemCount-1
self:refreshRecordScrollView()
self:addToCombineList(data)
end

function UILingZhenHHGameExWin:revocationItem()
local data=self.selectQueue[1]
if not data then
return
end
if data.isRecordItem then


self:removeSingleItemById(data.id)
else
table.remove(self.selectQueue,1)

local index=0
for i,v in ipairs(self.combineList)do
if v.id==data.id then
index=i
table.remove(self.combineList,i)
break
end
end

self:playMoveAnim(index)
local pwt=self.itemRoot:getTransform()
local tran=data.widget:GetCommonComponent(-1,'Transform')
tran.parent=pwt
local x,y=self:countPos(data.index,data.layer,true)
local tp=Vector3.New(x,y,0)
data.widget:SetChildDOLocalMove(-1,tp,0.25,function()
self:addToItemList(data,true)
data.widget:SetChildButtonClickWithID(1,self.selectFunc,data.id)
end)
end
end

function UILingZhenHHGameExWin:refreshRecordScrollView()
local isOverMax=self.recordItemCount>_maxRposItemCount

local width
local height=self.rposScrollView:getChildSizeDeltaY()
if isOverMax then
width=650
else
width=self.recordItemCount*(86+2)-2+20
end
self.rposScrollView:setChildSizeDelta(width,height)
end


function UILingZhenHHGameExWin:randomItemList()
local list={}
for k,v in pairs(self.itemList)do
list[#list+1]=v.val
end
local len=#list
for i=1,len do
local v=list[i]
local r=math.random(1,len)
list[i]=list[r]
list[r]=v
end

self.isPlaying=true
self.isCreatingMap=true
self.isInAnim=true


self.shuffleMaxCount=0
self.shuffleNowCount=0
self.redealIndex=nil
for k,data in pairs(self.itemList)do
self.shuffleMaxCount=self.shuffleMaxCount+1

data.widget:SetChildDoBrightness(-1,1,0,nil)

data.widget:SetChildActive(3,false)


local tp=Vector3.New(0,0,0)
data.widget:SetChildDOLocalMove(-1,tp,0.25,function()
if not _this then
return
end

self.shuffleNowCount=self.shuffleNowCount+1
if self.shuffleNowCount==self.shuffleMaxCount then

return self:redealItemList()
end
end)
if not self.redealIndex or k<self.redealIndex then
self.redealIndex=k
end
end


local count=0
for k,v in pairs(self.itemList)do
count=count+1
v.val=list[count]
v.widget:SetChildText(0,v.val)
local iconName=self.mapIconNameList[v.val]
if iconName then
v.widget:SetChildCSImageIcon(2,iconName,true)
end
end
end


function UILingZhenHHGameExWin:redealItemList()
self:clearTimer()


local onComplete=function()
self:clearTimer()
self.isPlaying=false
self.isCreatingMap=false
self.isInAnim=false
self:setAllItemStackUp()
end

self.timerId=self:setTimer(0.01,0,function()
local data=self.itemList[self.redealIndex]
self.redealIndex=self.redealIndex+1
if data then
self.shuffleNowCount=self.shuffleNowCount-1

local x,y=self:countPos(data.index,data.layer,true)
local tp=Vector3.New(x,y,0)
data.widget:SetChildDOLocalMove(-1,tp,0.25)

if self.shuffleNowCount<=0 then

return onComplete()
end
end
end)
end

function UILingZhenHHGameExWin:clearCombineList()

































local removeCount=#self.combineList
self:removeItem(removeCount)

self.combineList={}
self.selectQueue={}


end

function UILingZhenHHGameExWin:initAddScoreShow()
local maxScoreItemCount=10
self.scoreArea:setChildLayoutGroupCreateItems(maxScoreItemCount)
end


function UILingZhenHHGameExWin:addScoreShow(score)
local turnStrList={[0]='A','B','C','D','E','F','G','H','I','J'}
local numStrList={}
local num=score
while num>0 do
local posNum=num%10
local numStr=turnStrList[posNum]
table.insert(numStrList,1,numStr)
num=math.floor(num/10)
end
local finalNumStr=table.concat(numStrList)
local scoreStr=FMT.fmt("+{0}",finalNumStr)

local scoreItemIndex=self:getScoreItemIndex()
self.nowSelectScoreItemIndex=scoreItemIndex
local isCombo=self.isComboMode or false
local item=self.scoreArea:getChildLayoutGroupGridItem(scoreItemIndex-1)
if item then
item:SetChildText(1,scoreStr)
item:SetChildActive(3,false)
self:delayDo(0.1,function()
if not _this then return end
item:SetChildActive(2,isCombo)
item:SetChildActive(3,true)
end)
end
end

function UILingZhenHHGameExWin:getScoreItemIndex()
local nextIndex=self.nowSelectScoreItemIndex and self.nowSelectScoreItemIndex+1 or 1
if nextIndex>10 then
nextIndex=1
end

return nextIndex
end


function UILingZhenHHGameExWin:setExpireTimer()
self:clearExpireTimer()
local func=function()
local time=self.info:getEndLeftTime()
local isEnd=false
local endContent
local clickCallback
if time>0 then
if self.mapExpireTime then
local nowTime=timeHelper.getServerShortTime()
if nowTime>=self.mapExpireTime then
isEnd=true
endContent="灵阵绘画已结算，新一轮已开启"
clickCallback=function()
return self:onCloseClick()
end
end
end
else
isEnd=true
endContent="灵阵绘画已结算"
clickCallback=function()
return UIFullLingZhenHuiHuaControl:closeUI(true)
end
end

if isEnd then

self:clearExpireTimer()


local show_data={
type='UIDialouge',
title='提示',
content=endContent,
oktext='确定',
okcallback=clickCallback,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
end

self.expireTimer=self:setTimer(1,0,func)

func()
end



function UILingZhenHHGameExWin:clearExpireTimer()
if self.expireTimer then
self:stopTimerByID(self.expireTimer)
self.expireTimer=nil
end
end




function UILingZhenHHGameExWin:doSpeaking()
self:clearSpeakTimer()

if not self.clickCatNum then
self.clickCatNum=0
end
local isSpecialSpeak=self.clickCatNum>=self.maxClickCatNum
if isSpecialSpeak then
self.clickCatNum=0
end
self.clickCatNum=self.clickCatNum+1

local speakLib=cfgHelper.get(cfg_lingzhenhuihuaconfig_get,_this.subid,"catSpeakLib")
local specialSpeakLib=cfgHelper.get(cfg_lingzhenhuihuaconfig_get,_this.subid,"catSpecialSpeakLib")
local selectSpeakLib
if isSpecialSpeak then
selectSpeakLib=table.weakCopy(specialSpeakLib)
else
selectSpeakLib=table.weakCopy(speakLib)
if self.lastSpeakIndex and selectSpeakLib[self.lastSpeakIndex]then
table.remove(selectSpeakLib,self.lastSpeakIndex)
end
end
local rand
if#selectSpeakLib>1 then
rand=math.random(1,#selectSpeakLib)
else
rand=1
end
local speakStr=selectSpeakLib[rand]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self.speakBg1:setActive(not isSpecialSpeak)
self.speakBg2:setActive(isSpecialSpeak)
self:doTalkAnim()
end


function UILingZhenHHGameExWin:doTalkAnim()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
self.speakObj:setScale(Vector3.zero)
self:delayDo(0.5,function()
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
return _this:talkEnd()
end)
end)
end)
end


function UILingZhenHHGameExWin:talkEnd()
self:clearSpeakTimer()
self.speakShowTimer=self:delayDo(self.npcTalkShowTime,function()

self.speakObj:setScale(Vector3.zero)
end)
end


function UILingZhenHHGameExWin:clearSpeakTimer()
if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end



function UILingZhenHHGameExWin:onHelpBtn()
local langId=cfgHelper.get(cfg_lingzhenhuihuaconfig_get,self.subid,"ruleLangId")or''
local d={}
d.title='规则'
d.mode=3
d.name=langId
self:showWindow('UIRuleWin',d)
end

function UILingZhenHHGameExWin:onSkillBtnC()
if self.isCreatingMap or self.isInAnim then

return
end

self:showSkillWin(3)
end

function UILingZhenHHGameExWin:onSkillBtnB()
if self.isCreatingMap or self.isInAnim then

return
end

if#self.combineList>0 then
self:showSkillWin(2)
else
UIManager.info('暂无灵阵可撤回')
end
end

function UILingZhenHHGameExWin:onSkillBtnA()
if self.isCreatingMap or self.isInAnim then

return
end

if#self.combineList>0 then
self:showSkillWin(1)
else
UIManager.info('暂无灵阵可移出')
end
end

function UILingZhenHHGameExWin:onCloseClick()


UIFullLingZhenHuiHuaControl:showMainWinNoCloud(_this.activityArgs)
self:closeSelf()
end

function UILingZhenHHGameExWin:onCloseBtn()
self:onCloseClick()
end

function UILingZhenHHGameExWin:onBottomClick()
self.bottomModel:setChildModelAnimationState(eAnimationID.touch)
self:doSpeaking()
end


function UILingZhenHHGameExWin:test_printSelectMapId()
UIManager.info(FMT.fmt("当前地图id：{0}",self.selectMapId))
end


function UILingZhenHHGameExWin:test_finishGame(score)
self.score:setValue(score)
self:handleSuccess()
end
