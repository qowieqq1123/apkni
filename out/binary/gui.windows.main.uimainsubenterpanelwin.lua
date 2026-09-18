







def_class("UIMainSubEnterPanelWin",UIWindowBase)









function UIMainSubEnterPanelWin:bindComponents()

self.mask=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.enterList=UIObject.get(self,2)
self.arrow=UIObject.get(self,3)
self.uiRoot=UIObject.get(self,4)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIMainSubEnterPanelWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.enterList);self.enterList=nil;
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end



















function UIMainSubEnterPanelWin:onLoaded(...)
self:bindComponents()
end


function UIMainSubEnterPanelWin:__delete()

self:checkWinState()

self:releaseAllButton()
self:unbindComponents()
end




function UIMainSubEnterPanelWin:onShow(argtable,afterOnloaded)
self.btnList=argtable and argtable.btnList or{}
self.pos=argtable and argtable.pos or{0,0}
self.posType=argtable and argtable.posType or 1
self.closeCallback=argtable and argtable.closeCallback
self:refresh()
end


function UIMainSubEnterPanelWin:onHide()
self:checkWinState()
self:releaseAllButton()
end

function UIMainSubEnterPanelWin:checkWinState()
UIManager:invokeUIMethod('UIMain','checkStateAndLeave')
end

function UIMainSubEnterPanelWin:refresh()
self.activeBtnList=self:getActiveBtnList()
self:createGroupBtns()

local grids=self.enterList:getChildCommonLayoutGroupWidgetList()
local activeBtnCount=#self.activeBtnList
for i=1,grids.Count do
local widget=grids[i-1]
local isShow=i<=activeBtnCount
widget:SetChildActive(-1,isShow)
end

self:setRootPos()
end

function UIMainSubEnterPanelWin:createGroupBtns()
local index=self.enterList:getID()
local configs=self:getBtnCfgs()
local indexArray={}
local parentIndexArray={}
local keys={}
for i,v in ipairs(configs)do
indexArray[i]=v.UIPrefabIndex
parentIndexArray[i]=i-1
keys[i]=v.key
end
self.winlua:SetCreatChildClonePrefabEx(index,indexArray,parentIndexArray,keys)
self.list={}
if not self.iconLuaObjectLookup then
self.iconLuaObjectLookup={}
end

local lookup=self.iconLuaObjectLookup
local temp={}
for k,v in pairs(lookup)do
temp[k]=v
end
for i=1,#configs do
local config=configs[i]
local key=config.key
local iconType=config.iconType
local luaObjet=lookup[key]
temp[key]=nil
local isFadeIn=iconType and not systemIconFlyControl.isFly(iconType)or false

local widget=self.winlua:GetChildCloneWidget(index,i-1)
local isInit=luaObjet==nil
if isInit then
mainBtnConfig.PreloadCtor(config)
local ctor=config.ctor
luaObjet=ctor(widget,i,config)
lookup[key]=luaObjet
luaObjet:onLoaded()
else
luaObjet:init(widget,i,config)
end
local list=self.list
list[#list+1]=luaObjet
luaObjet:onShow(isInit)
luaObjet:setChildCanvasGroupAlpha(-1,isFadeIn and 0 or 1)
local comName=FMT.fmt('{0}.click',keys[i])
luaObjet:setNewBieComponentId(1,comName)
luaObjet:setChildWeakGuideComponentId(1,comName)
end

for key,luaObjet in pairs(temp)do
lookup[key]=nil
if luaObjet and luaObjet.release then
luaObjet:release()
end
end
end

function UIMainSubEnterPanelWin:releaseAllButton()
for _,luaObjet in pairs(self.iconLuaObjectLookup)do
if luaObjet and luaObjet.release then
luaObjet:release()
end
end
self.iconLuaObjectLookup={}
end

function UIMainSubEnterPanelWin:getLuaObjectByKey(key)
return self.iconLuaObjectLookup[key]
end


function UIMainSubEnterPanelWin:getBtnCfgs()
local configs={}
for i,btnType in ipairs(self.activeBtnList)do
local cfg=mainBtnConfig.getBtnCfg(btnType)
configs[#configs+1]=cfg
end

return configs
end

function UIMainSubEnterPanelWin:getActiveBtnList()
local activeBtnList={}
for i,btnType in ipairs(self.btnList)do
if mainBtnConfig.isActive(btnType)then
activeBtnList[#activeBtnList+1]=btnType
end
end

return activeBtnList
end


function UIMainSubEnterPanelWin:setRootPos()
if self.pos then
local originalPos_x=self.pos[1]or 0
local originalPos_y=self.pos[2]or 0
local scaleFactor=CS.CSGUIManager.Instance.CanvasScaleValue
local activeBtnCount=#self.activeBtnList

local rt=self.uiRoot:getCommonComponent('RectTransform')



local pos_x
local pos_y
local arrowPos_x
local arrowPos_y

if self.posType==1 then
self.enterList:setChildPivot(Vector2.New(0.5,0.5))
self.arrow:setAnchors(0.5,0,0.5,1)
self.root:setAnchors(0.5,0.5,0.5,0)

local itemWidth=activeBtnCount*(80+20)-20+40
local itemHeight=100
local halfItemWidth=itemWidth/2
local halfItemHeight=itemHeight/2
local anchorMinX=rt.anchorMin.x
local anchorMaxX=rt.anchorMax.x
local uiWidth=UnityEngine.Screen.width/scaleFactor.x
local leftOffset=uiWidth*(anchorMinX-0)
local rightOffset=uiWidth*(1-anchorMaxX)
originalPos_x=originalPos_x-leftOffset/2+rightOffset/2
pos_x=originalPos_x
pos_y=originalPos_y

local halfWidth=(uiWidth-leftOffset-rightOffset)/2
local halfHeight=UnityEngine.Screen.height/scaleFactor.y/2
if pos_x-halfItemWidth<-halfWidth then
pos_x=-halfWidth+halfItemWidth
end
if pos_x+halfItemWidth>halfWidth then
pos_x=halfWidth-halfItemWidth
end

if pos_y-halfItemHeight<-halfHeight then
pos_y=-halfHeight+halfItemHeight
end
if pos_y+halfItemHeight>halfHeight then
pos_y=halfHeight-halfItemHeight
end
arrowPos_x=originalPos_x-pos_x
arrowPos_y=17
elseif self.posType==2 then

pos_x=-40
pos_y=originalPos_y
self.enterList:setChildPivot(Vector2.New(1,0.5))
self.arrow:setAnchors(1,0,0.5,1)
self.root:setAnchors(1,0.5,0.5,0)
arrowPos_x=-40
arrowPos_y=17
end

self.root:setChildAnchoredPos(pos_x,pos_y)


self.arrow:setChildAnchoredPos(arrowPos_x,arrowPos_y)
end
end




function UIMainSubEnterPanelWin:onMask()
if self.closeCallback then
local cb=self.closeCallback
cb()
end

self:closeSelf()
end

