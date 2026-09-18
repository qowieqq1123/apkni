







def_class("UIMainFuncBtnWin",UIWindowBase)









function UIMainFuncBtnWin:bindComponents()

self.UIMainFuncBtnWin=UIWindowLua.new(self,0)
self.top=UIObject.get(self,1)
self.rightRoot=UIObject.get(self,2)
self.btnRightArrow=UIButton.get(self,3)
self.btnReddot=UIImage.get(self,4)
self.right=UIObject.get(self,5)
self.lineRight=UIObject.get(self,6)
self.btnList=UIObject.get(self,7)

self.btnRightArrow:setButtonClick(function()self:onBtnRightArrow()end)



end


function UIMainFuncBtnWin:unbindComponents()
local _UIObject_release=UIObject.release
self.UIMainFuncBtnWin:deleteSelf();self.UIMainFuncBtnWin=nil;
_UIObject_release(self.top);self.top=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
_UIObject_release(self.btnRightArrow);self.btnRightArrow=nil;
_UIObject_release(self.btnReddot);self.btnReddot=nil;
_UIObject_release(self.right);self.right=nil;
_UIObject_release(self.lineRight);self.lineRight=nil;
_UIObject_release(self.btnList);self.btnList=nil;
end


















function UIMainFuncBtnWin:onLoaded(...)
self:bindComponents()


self:addNotify(notifyConfig.on_main_btn_state_changed,function(...)
self:onBtnStateChanged(...)
end)

self:addNotify(notifyConfig.iconUnlock,function(...)
self:onIconUnlock(...)
end)
self.iconLuaObjectLookup={}


if webGLHelper:isNeedAdaption()then
local pos=self.top:getChildAnchoredPosition3D()
self.top:setChildAnchoredPosition3D(Vector3.New(pos.x,-85,pos.z))
end
end

function UIMainFuncBtnWin:__delete()

self:endAllReddotPunchRotation()


self:releaseAllButton()

self:unbindComponents()
end

function UIMainFuncBtnWin:onShow(argtable,afterOnloaded)
self:freshGroupBtns()
if not afterOnloaded then
self:doCloneMove(0)
end
self:initRightPanel(true)
end

function UIMainFuncBtnWin:onHide()

end





function UIMainFuncBtnWin:onBtnRightArrow()
local isSimple=simpleModeControl:getRightSimple()
simpleModeControl:setRightSimple(not isSimple)
self:initRightPanel()
end


function UIMainFuncBtnWin:onIconUnlock(unlockIconTypes)
local len=#unlockIconTypes
local btnGroupType=MAIN_ICON_GROUP_TYPE.eRight
local iconTypes=mainConfig.getGroupIconTypeList(btnGroupType)
local flag=table.containsTableValue(iconTypes,unlockIconTypes)
if flag then
self:freshGroupBtns()
self:doCloneMove()
self:initRightPanel(true)
end
end

function UIMainFuncBtnWin:onBtnStateChanged(btnType,oldvis,newvis)
local cfgs=self.btnCfgs
local look=cfgs.look or{}
if look[btnType]==nil then return end
self:freshGroupBtns()
self:doCloneMove()
self:initRightPanel(true)
end



function UIMainFuncBtnWin:endAllReddotPunchRotation()
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return
end
for i,v in pairs(self.reddotTweenerList)do
if v~=nil then
v.tweener:Complete()
v.tweener:Kill()
local widget=v.widget
local componentIndex=v.componentIndex
widget:SetChildRotation(componentIndex,0,0,0)

self.reddotTweenerList[i]=nil
end
end
end



function UIMainFuncBtnWin:freshGroupBtns()
local iconGroupType=MAIN_ICON_GROUP_TYPE.eRight
local index=self.btnList:getID()
local list,configs=mainConfig.getRightGroupConfig()
self.btnCfgs=configs
local len=#list
self.listlen=len

local indexArray={}
local parentIndexArray={}
local keys={}

for i,v in ipairs(list)do
indexArray[i]=v.UIPrefabIndex
parentIndexArray[i]=i-1
keys[i]=v.key
end
self.winlua:SetCreatChildClonePrefabEx(index,indexArray,parentIndexArray,keys)

self.luaObjectList={}
if not self.iconLuaObjectLookup[iconGroupType]then
self.iconLuaObjectLookup[iconGroupType]={}
end

local lookup=self.iconLuaObjectLookup[iconGroupType]
local temp={}
for k,v in pairs(lookup)do
temp[k]=v
end
for i=1,#list do
local config=list[i]
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
local luaObjectList=self.luaObjectList
luaObjectList[#luaObjectList+1]=luaObjet
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


function UIMainFuncBtnWin:releaseAllButton()
for _,lookup in pairs(self.iconLuaObjectLookup)do
for _,luaObjet in pairs(lookup)do
if luaObjet and luaObjet.release then
luaObjet:release()
end
end
end
self.iconLuaObjectLookup={}
end

function UIMainFuncBtnWin:doCloneMove(duration)
local index=self.btnList:getID()
self.winlua:StartChildClonePrefabTween(index,duration or 0.5,DG.Tweening.Ease.InOutBack)
end


function UIMainFuncBtnWin:getWidgetByKey(key)
local btnGroupType=mainConfig.getIconGroupType(key)
if btnGroupType==MAIN_ICON_GROUP_TYPE.eRight then
local index=self.btnList:getID()
return self.winlua:GetChildCloneWidgetByKey(index,key)
end
end


function UIMainFuncBtnWin:getPositionByKey(key)
local btnGroupType=mainConfig.getIconGroupType(key)
if btnGroupType==MAIN_ICON_GROUP_TYPE.eRight then
local index=self.btnList:getID()
return self.winlua:GetChildClonePositionByKey(index,key)
end
end

function UIMainFuncBtnWin:getLuaObjectByKey(key)
for _,lookup in pairs(self.iconLuaObjectLookup)do
if lookup[key]then
return lookup[key]
end
end
end


function UIMainFuncBtnWin:doFadeNomal(key)
local luaObjet=self:getLuaObjectByKey(key)
if luaObjet then
luaObjet:setChildCanvasGroupAlpha(-1,1)
end
end


function UIMainFuncBtnWin:initRightPanel(isInit)
local cfgs=mainConfig.getRightGroupConfig()
local isOpen=not simpleModeControl:getRightSimple()
local hasbtn=self.listlen>0
local endVal=isOpen and hasbtn and-44 or 335
local rorate=isOpen and hasbtn and 90 or 0
self:freshBtnVis()
if isInit then
self.winlua:SetChildDORotation(self.btnRightArrow:getID(),Vector3(0,0,rorate),0.01)
self.winlua:SetChildLocalPosY(self.right:getID(),endVal)
else
self.winlua:SetChildDORotation(self.btnRightArrow:getID(),Vector3(0,0,rorate),0.5)
self.winlua:SetChildDOLocalMoveY(self.right:getID(),endVal,0.3)
end
if isOpen then
UIManager:invokeUIMethod("UIMainEntryWin","showEntryPanel",isInit)
else
UIManager:invokeUIMethod("UIMainEntryWin","hideEntryPanel",isInit)
end

self:freshSimpleBtnReddot()
end

function UIMainFuncBtnWin:freshBtnVis()
local hasbtn=self.listlen>0
local data=enterManager:getEnterData()
local bigdata=enterManager:getBigEnterData()
self.btnRightArrow:setActive(hasbtn or#data>0 or#bigdata>0)
end

function UIMainFuncBtnWin:freshSimpleBtnReddot()
local isOpen=simpleModeControl:getRightSimple()
if isOpen==false then
if self.rightMenuReddot~=isOpen then
self.rightMenuReddot=isOpen
self.btnReddot:setActive(false)
self.btnReddotIndex=self:doPunchRotation(self.widget,self.btnReddot:getID(),self.btnReddotIndex,false)
end
return
end
local reddot=mainConfig.getGroupReddot(MAIN_ICON_GROUP_TYPE.eRight)or
enterManager:getAllEnterReddot()
if self.rightMenuReddot~=reddot then
self.rightMenuReddot=reddot
self.btnReddot:setActive(reddot)
end
self.btnReddotIndex=self:doPunchRotation(self.widget,self.btnReddot:getID(),self.btnReddotIndex,reddot)
end

function UIMainFuncBtnWin:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
if webGLHelper:isHidePunchAni()then return end
if isReddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
if not reddotIndex then
reddotIndex=#self.reddotTweenerList+1
end

if self.reddotTweenerList[reddotIndex]==nil then
widget:SetChildRotation(componentIndex,0,0,0)
local tweener=widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
self.reddotTweenerList[reddotIndex].widget=widget
self.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
widget:SetChildRotation(componentIndex,0,0,0)
return nil
end
end
end
