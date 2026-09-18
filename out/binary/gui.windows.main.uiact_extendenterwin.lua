







def_class("UIAct_ExtendEnterWin",UIWindowBase)









function UIAct_ExtendEnterWin:bindComponents()

self.layoutRoot=UIObject.get(self,0)
self.uiScrollView=UIObject.get(self,1)
self.uiRoot=UIObject.get(self,2)
self.limitActRoot=UIObject.get(self,3)
self.limitNormalActCreatorRoot1=UIObject.get(self,4)
self.limitActCreater1=UIGameobjectClone.new(self,5)
self.limitBigActCreatorRoot=UIObject.get(self,6)
self.bigActCreater=UIGameobjectClone.new(self,7)
self.limitNormalActCreatorRoot2=UIObject.get(self,8)
self.limitActCreater2=UIGameobjectClone.new(self,9)
self.gameWayRoot=UIObject.get(self,10)
self.gameActCreatorRoot=UIObject.get(self,11)
self.gameActCreater=UIGameobjectClone.new(self,12)
self.closeBtn=UIButton.get(self,13)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIAct_ExtendEnterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.layoutRoot);self.layoutRoot=nil;
_UIObject_release(self.uiScrollView);self.uiScrollView=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.limitActRoot);self.limitActRoot=nil;
_UIObject_release(self.limitNormalActCreatorRoot1);self.limitNormalActCreatorRoot1=nil;
self.limitActCreater1:deleteSelf();self.limitActCreater1=nil;
_UIObject_release(self.limitBigActCreatorRoot);self.limitBigActCreatorRoot=nil;
self.bigActCreater:deleteSelf();self.bigActCreater=nil;
_UIObject_release(self.limitNormalActCreatorRoot2);self.limitNormalActCreatorRoot2=nil;
self.limitActCreater2:deleteSelf();self.limitActCreater2=nil;
_UIObject_release(self.gameWayRoot);self.gameWayRoot=nil;
_UIObject_release(self.gameActCreatorRoot);self.gameActCreatorRoot=nil;
self.gameActCreater:deleteSelf();self.gameActCreater=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end
















local titleHeight=46
local bigActRoot_SHeight=200
local normalActRoot_SHeight=100

local MaxWidth=430

local MaxLine=4
local BToNPlaceNum=2

local bigActRightPadding=-15
local bigActSpaceX=5
local bigActWidth=97





function UIAct_ExtendEnterWin:onLoaded(...)
self:bindComponents()
end


function UIAct_ExtendEnterWin:__delete()
self:unbindComponents()
end




function UIAct_ExtendEnterWin:onShow(argtable,afterOnloaded)
self:refresh()
self:doAnimation()
end


function UIAct_ExtendEnterWin:onHide()

end





function UIAct_ExtendEnterWin:onCloseBtn()
self:doAnimation()
end

function UIAct_ExtendEnterWin:refresh()


self.bigExtendEnterData=enterManager:getExtendAllBigEnterData()

self.normalExtendEnterData=enterManager:getExtendAllNormalData()
self.gameActExtendEnterData=enterManager:getExtendGameEnterData()
self.bigActNum=#self.bigExtendEnterData
self.normalActNum=#self.normalExtendEnterData
self.gameActNum=#self.gameActExtendEnterData

self.limitActPart1List={}
self.limitActPart2List={}

self:sliceNormalData()
self:calculateRootsSizeDelta()

self:freshCreator()
self:freshAllItem()
end


function UIAct_ExtendEnterWin:sliceNormalData()
if self.normalActNum>0 then
local bigRawPlaceNum=self.bigActNum%MaxLine
local limitPart1PlaceNum=(MaxLine-bigRawPlaceNum)*BToNPlaceNum
if bigRawPlaceNum>0 then
self.limitActPart1List=table.sub(self.normalExtendEnterData,1,limitPart1PlaceNum)
if self.normalActNum-limitPart1PlaceNum>0 then
self.limitActPart2List=table.sub(self.normalExtendEnterData,limitPart1PlaceNum+1,self.normalActNum)
end
else
self.limitActPart2List=self.normalExtendEnterData
end
end
end

function UIAct_ExtendEnterWin:calculateRootsSizeDelta()


local limitPart1Height=0
local limitPart2Height=0
local bigPartHeight=0


local limitPart1Width=0
local limitPart2Width=0
local bigPartWidth=0


local limitPart1_PosX=0
local limitPart1_PosY=0

local bigPart_PosX=0
local bigPart_PosY=0

local limitPart2_PosX=0
local limitPart2_PosY=0


local limitPart1ActiveState=false
local limitPart2ActiveState=false
local limitBigPartActiveState=false

local bigActLineNum=Mathf.Min(MaxLine,self.bigActNum)
local bigRawPlaceNum=Mathf.Ceil(self.bigActNum/MaxLine)
local limitPart1PlaceNum=(MaxLine-self.bigActNum%MaxLine)*BToNPlaceNum
local bigActFullPlaceNum=Mathf.Floor(self.bigActNum/MaxLine)


if bigActLineNum>0 then

limitBigPartActiveState=true
if self.normalActNum>0 then
if self.normalActNum>limitPart1PlaceNum then

limitPart1ActiveState=true
limitPart2ActiveState=true
else

limitPart1ActiveState=true
end
end
else

limitPart2ActiveState=true
end


if limitBigPartActiveState then
bigPartHeight=bigActRoot_SHeight*bigRawPlaceNum
bigPartWidth=bigActLineNum>1 and MaxWidth or MaxWidth
bigPart_PosX=0
bigPart_PosY=-titleHeight

self.limitBigActCreatorRoot:setChildSizeDelta(bigPartWidth,bigPartHeight)
self.limitBigActCreatorRoot:setChildAnchoredPos(bigPart_PosX,bigPart_PosY)
end

if limitPart1ActiveState then

limitPart1Height=bigActRoot_SHeight
limitPart1Width=(MaxLine-self.bigActNum%MaxLine)*(MaxWidth/MaxLine)
limitPart1_PosX=-(self.bigActNum%MaxLine)*bigActWidth+(bigRawPlaceNum>0 and bigActRightPadding or 0)-(bigRawPlaceNum-1)*bigActSpaceX
limitPart1_PosY=-titleHeight-bigActRoot_SHeight*bigActFullPlaceNum


self.limitNormalActCreatorRoot1:setChildSizeDelta(limitPart1Width,limitPart1Height)
self.limitNormalActCreatorRoot1:setChildAnchoredPos(limitPart1_PosX,limitPart1_PosY)
end

if limitPart2ActiveState then


local limitActMoreNum=#self.limitActPart2List
limitPart2Height=normalActRoot_SHeight*Mathf.Ceil(limitActMoreNum/MaxLine)
limitPart2Width=MaxWidth

limitPart2_PosX=0
limitPart2_PosY=-titleHeight-(limitBigPartActiveState and bigPartHeight or 0)
self.limitNormalActCreatorRoot2:setChildSizeDelta(limitPart2Width,limitPart2Height)
self.limitNormalActCreatorRoot2:setChildAnchoredPos(limitPart2_PosX,limitPart2_PosY)

end


local limitActRootHeight=titleHeight
if limitBigPartActiveState then
limitActRootHeight=limitActRootHeight+bigPartHeight
end

if limitPart1ActiveState and not limitBigPartActiveState then
limitActRootHeight=limitActRootHeight+limitPart1Height
end

if limitPart2ActiveState then
limitActRootHeight=limitActRootHeight+limitPart2Height
end

self.limitActRoot:setChildSizeDelta(MaxWidth,limitActRootHeight)

local gameWayRootHeight=titleHeight
local gameActRootHeight=0
if self.gameActNum>0 then
gameActRootHeight=(Mathf.Ceil(self.gameActNum/MaxLine))*normalActRoot_SHeight
gameWayRootHeight=gameWayRootHeight+gameActRootHeight
end
self.gameWayRoot:setChildSizeDelta(MaxWidth,gameWayRootHeight)
self.gameActCreatorRoot:setChildSizeDelta(MaxWidth,gameActRootHeight)
self.gameActCreatorRoot:setChildAnchoredPos(0,-titleHeight)

local uiRootHeight=limitActRootHeight+gameWayRootHeight
self.uiRoot:setChildSizeDelta(MaxWidth,uiRootHeight)

local isCanScroll=uiRootHeight>550
self.uiScrollView:setChildScrollRectEnable(isCanScroll)
end



function UIAct_ExtendEnterWin:freshCreator()
local part1Ret=self:compare(self.limitActPart1List,self.nomalPart1Data or{},self.nomalPart1Len or 0)
local part1Num=#self.limitActPart1List
self.nomalPart1Data={}
self.nomalPart1Len=part1Num
self.nomalPart1List={}

if part1Ret then
self.limitActCreater1:recycleAll()
local parentIdx=self.limitActCreater1:getID()
for i,info in ipairs(self.limitActPart1List)do
local args={info=info}
local guid=info._guid
self.nomalPart1Data[guid]=true
local enterIconType=info.enterIconType
local enterType=info.enterType
local cfg=enterConfig.getConfig(enterIconType,enterType)
local luaid=self.limitActCreater1:createObject(cfg.creator,parentIdx,i,args)
self.nomalPart1List[guid]=luaid
end
else
if next(self.nomalPart1List or{})then
for guid,luaid in pairs(self.nomalPart1List)do
local luaObjet=self.limitActCreater1:getLuaObject(luaid)
local enterInfo=enterManager:getInfo(guid)
if luaObjet and luaObjet.onShow and enterInfo then
luaObjet:onShow({info=enterInfo,isEx=true})
end
end
end
end

local part2Ret=self:compare(self.limitActPart2List,self.nomalPart2Data or{},self.nomalPart2Len or 0)
local part2Num=#self.limitActPart1List
self.nomalPart2Data={}
self.nomalPart2Len=part2Num
self.nomalPart2List={}

if part2Ret then
self.limitActCreater2:recycleAll()
local parentIdx=self.limitActCreater2:getID()
for i,info in ipairs(self.limitActPart2List)do
local args={info=info}
local guid=info._guid
self.nomalPart2Data[guid]=true
local enterIconType=info.enterIconType
local enterType=info.enterType
local cfg=enterConfig.getConfig(enterIconType,enterType)
local luaid=self.limitActCreater2:createObject(cfg.creator,parentIdx,i,args)
self.nomalPart2List[guid]=luaid
end
else
if next(self.nomalPart2List or{})then
for guid,luaid in pairs(self.nomalPart2List)do
local luaObjet=self.limitActCreater2:getLuaObject(luaid)
local enterInfo=enterManager:getInfo(guid)
if luaObjet and luaObjet.onShow and enterInfo then
luaObjet:onShow({info=enterInfo,isEx=true})
end
end
end
end

local bigRet=self:compare(self.bigExtendEnterData,self.bigData or{},self.bigLen or 0)
local part2Num=#self.bigExtendEnterData
self.bigData={}
self.bigLen=part2Num
self.bigList={}

if bigRet then
self.bigActCreater:recycleAll()
local parentIdx=self.bigActCreater:getID()
for i,info in ipairs(self.bigExtendEnterData)do
local args={info=info}
local guid=info._guid
self.bigData[guid]=true
local enterIconType=info.enterIconType
local enterType=info.enterType
local cfg=enterConfig.getConfig(enterIconType,enterType)
local luaid=self.bigActCreater:createObject(cfg.creator,parentIdx,i,args)
self.bigList[guid]=luaid
end
else
if next(self.bigList or{})then
for guid,luaid in pairs(self.bigList)do
local luaObjet=self.bigActCreater:getLuaObject(luaid)
local enterInfo=enterManager:getInfo(guid)
if luaObjet and luaObjet.onShow and enterInfo then
luaObjet:onShow({info=enterInfo,isEx=true})
end
end
end
end

local gameActRet=self:compare(self.gameActExtendEnterData,self.gameActData or{},self.gameActLen or 0)
local gameActNum=#self.gameActExtendEnterData
self.gameActData={}
self.gameActLen=gameActNum
self.gameActList={}

if gameActRet then
self.gameActCreater:recycleAll()
local parentIdx=self.gameActCreater:getID()
for i,info in ipairs(self.gameActExtendEnterData)do
local args={info=info}
local guid=info._guid
self.gameActData[guid]=true
local enterIconType=info.enterIconType
local enterType=info.enterType
local cfg=enterConfig.getConfig(enterIconType,enterType)
local luaid=self.gameActCreater:createObject(cfg.creator,parentIdx,i,args)
self.gameActList[guid]=luaid
end
else
if next(self.gameActList or{})then
for guid,luaid in pairs(self.gameActList)do
local luaObjet=self.gameActCreater:getLuaObject(luaid)
local enterInfo=enterManager:getInfo(guid)
if luaObjet and luaObjet.onShow and enterInfo then
luaObjet:onShow({info=enterInfo,isEx=true})
end
end
end
end

end

function UIAct_ExtendEnterWin:compare(table,lookup,len)
if table==nil and len>0 then return true end
if#table~=len then return true end
for i=1,#table do
if not lookup[table[i]._guid]then return true end
end
return false
end

function UIAct_ExtendEnterWin:getLuaObject(guid)
if self.nomalPart1List[guid]then
return self.limitActCreater1:getLuaObject(self.nomalPart1List[guid])
end

if self.nomalPart2List[guid]then
return self.limitActCreater2:getLuaObject(self.nomalPart2List[guid])
end

if self.bigList[guid]then
return self.bigActCreater:getLuaObject(self.bigList[guid])
end

if self.gameActList[guid]then
return self.gameActCreater:getLuaObject(self.gameActList[guid])
end
end

function UIAct_ExtendEnterWin:freshAllItem()
if next(self.nomalPart1List or{})then
for guid,luaid in pairs(self.nomalPart1List)do
local luaObjet=self.limitActCreater1:getLuaObject(luaid)
local enterInfo=enterManager:getInfo(guid)
if luaObjet and luaObjet.onShow and enterInfo then
luaObjet:onShow({info=enterInfo,isEx=true})
end
end
end

if next(self.nomalPart2List or{})then
for guid,luaid in pairs(self.nomalPart2List)do
local luaObjet=self.limitActCreater2:getLuaObject(luaid)
local enterInfo=enterManager:getInfo(guid)
if luaObjet and luaObjet.onShow and enterInfo then
luaObjet:onShow({info=enterInfo,isEx=true})
end
end
end

if next(self.bigList or{})then
for guid,luaid in pairs(self.bigList)do
local luaObjet=self.bigActCreater:getLuaObject(luaid)
local enterInfo=enterManager:getInfo(guid)
if luaObjet and luaObjet.onShow and enterInfo then
luaObjet:onShow({info=enterInfo,isEx=true})
end
end
end

if next(self.gameActList or{})then
for guid,luaid in pairs(self.gameActList)do
local luaObjet=self.gameActCreater:getLuaObject(luaid)
local enterInfo=enterManager:getInfo(guid)
if luaObjet and luaObjet.onShow and enterInfo then
luaObjet:onShow({info=enterInfo,isEx=true})
end
end
end
end


function UIAct_ExtendEnterWin:freshByInfo(enterInfo)
if enterInfo==nil then return end
local guid=enterInfo._guid
local luaObjet=self:getLuaObject(guid)
if luaObjet and luaObjet.onShow then
luaObjet:onShow({info=enterInfo,isEx=true})
end
end

function UIAct_ExtendEnterWin:freshFuncByByInfo(funcName,enterInfo)
if enterInfo==nil then return end
local guid=enterInfo._guid
local luaObjet=self:getLuaObject(guid)
if luaObjet and luaObjet[funcName]then
return luaObjet[funcName](luaObjet)
end
end

function UIAct_ExtendEnterWin:doAnimation()

if not self.doOut and not self.doIn then

if self.isEntered then
self.doOut=true
self.layoutRoot:setChildDOAnchorPosX(600,0.5,function()
self.doOut=false
self.isEntered=not self.isEntered
self:closeSelf()
end)
else
self.doIn=true
self.layoutRoot:setChildDOAnchorPosX(0,0.5,function()
self.doIn=false
self.isEntered=not self.isEntered
end)
end
end
end