







def_class("UIMainEntryWin",UIWindowBase)









function UIMainEntryWin:bindComponents()

self.creater1=UIGameobjectClone.new(self,0)
self.creater2=UIGameobjectClone.new(self,1)
self.layout=UIObject.get(self,2)
self.showArea=UIObject.get(self,3)


self.sprite_button_hdrk_0000=0

end


function UIMainEntryWin:unbindComponents()
local _UIObject_release=UIObject.release
self.creater1:deleteSelf();self.creater1=nil;
self.creater2:deleteSelf();self.creater2=nil;
_UIObject_release(self.layout);self.layout=nil;
_UIObject_release(self.showArea);self.showArea=nil;
end
















local _this
local _simleKey="UIMainEntryWin.showArea"



function UIMainEntryWin:onLoaded(...)
self:bindComponents()

_this=self

self.cache={}
self.nomalList={}
self.bigList={}
self.bigData={}
self.bigLen=0
self.nomalData={}
self.nomalLen=0
self.isShowEnterPanel=nil
self.needRefreshCount=0

self:addNotify(notifyConfig.onXianJieMainWinSimpleStateChange,self.onXianJieMainWinSimpleStateChange)
end

function UIMainEntryWin:__delete()
self.needRefreshCount=0
self.creater1:recycleAll()
self.creater2:recycleAll()
_this=nil
self:unbindComponents()
end

function UIMainEntryWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self:freshInfo()
end
self:initLayoutPos()
end

function UIMainEntryWin:onHide()

end




function UIMainEntryWin:refresh()

end

function UIMainEntryWin:freshInfo()
local func=function()
if self and not self.isClose then
self:freshNomal()
self:freshBig()
self.delayFlushTimer=nil
end
end
if self.delayFlushTimer==nil then
self.delayFlushTimer=FrameTimer.New(func,1,0)
self.delayFlushTimer:Start()
end
end

function UIMainEntryWin:freshNomal()
local enterData=enterManager:getEnterData()
local tNum=#enterData
local ret=self:compare(enterData,self.nomalData,self.nomalLen)
self.nomalData={}
self.nomalLen=tNum
self.nomalList={}
if ret then
self.creater1:recycleAll()
local parentIdx=self.creater1:getID()
local flag=false
for i,info in ipairs(enterData)do
local enterType=info.enterType
local args={info=info}
local guid=info._guid
self.nomalData[guid]=true
local enterIconType=info.enterIconType
local enterType=info.enterType
local cfg=enterConfig.getConfig(enterIconType,enterType)
local luaid=self.creater1:createObject(cfg.creator,parentIdx,i,args)
self.nomalList[guid]=luaid
local curData=enterManager:getEnterData()
if not flag and(curData[i]==nil or curData[i]._guid~=guid)then
flag=true
loggerUtil.logErrFMT('入口{0}放入管理器因条件不满足立刻被删，不满足不要放入管理器！否则此入口图标将无法删除/显示',enterType)
end
end
else
self:freshAllNomalItem()
end
end

function UIMainEntryWin:freshBig()
local enterData=enterManager:getBigEnterData()
local tNum=#enterData
local ret=self:compare(enterData,self.bigData,self.bigLen)
self.bigData={}
self.bigLen=tNum
self.bigList={}
if ret then
self.creater2:recycleAll()
local parentIdx=self.creater2:getID()
local flag=false
for i,info in ipairs(enterData)do
local enterType=info.enterType
local args={info=info}
local guid=info._guid
self.bigData[guid]=true
local enterIconType=info.enterIconType
local enterType=info.enterType
local cfg=enterConfig.getConfig(enterIconType,enterType)
local luaid=self.creater2:createObject(cfg.creator,parentIdx,i,args)
self.bigList[guid]=luaid
local curData=enterManager:getBigEnterData()
if not flag and(curData[i]==nil or curData[i]._guid~=guid)then
flag=true
loggerUtil.logErrFMT('入口{0}放入管理器因条件不满足立刻被删，不满足不要放入管理器！否则此入口图标将无法删除/显示',enterType)
end
end
else
self:freshAllBigItem()
end
end

function UIMainEntryWin:compare(table,lookup,len)
if table==nil and len>0 then return true end
if#table~=len then return true end
for i=1,#table do
if not lookup[table[i]._guid]then return true end
end
return false
end

function UIMainEntryWin:getLuaObject(guid)
local luaid=self.nomalList[guid]
if not luaid then
luaid=self.bigList[guid]
end
return self.creater1:getLuaObject(luaid)or self.creater2:getLuaObject(luaid)
end

function UIMainEntryWin:freshAllNomalItem()
for guid,luaid in pairs(self.nomalList)do
local luaObjet=self.creater1:getLuaObject(luaid)
local enterInfo=enterManager:getInfo(guid)
if luaObjet and luaObjet.onShow and enterInfo then
luaObjet:onShow({info=enterInfo})
end
end
end

function UIMainEntryWin:freshAllBigItem()
for guid,luaid in pairs(self.bigList)do
local luaObjet=self.creater1:getLuaObject(luaid)
if luaObjet and luaObjet.onShow then
local enterInfo=enterManager:getInfo(guid)
luaObjet:onShow({info=enterInfo})
end
end
end


function UIMainEntryWin:freshByInfo(enterInfo)
if enterInfo==nil then return end
local guid=enterInfo._guid
local luaObjet=self:getLuaObject(guid)
if luaObjet and luaObjet.onShow then
luaObjet:onShow({info=enterInfo})
end
end

function UIMainEntryWin:freshFuncByByInfo(funcName,enterInfo)
if enterInfo==nil then return end
local guid=enterInfo._guid
local luaObjet=self:getLuaObject(guid)
if luaObjet and luaObjet[funcName]then
return luaObjet[funcName](luaObjet)
end
end

function UIMainEntryWin:freshFuncByGuid(guid,funcName,args)
if guid==nil then return end
local luaObjet=self:getLuaObject(guid)
if luaObjet and luaObjet[funcName]then
return luaObjet[funcName](luaObjet,args)
end
end


function UIMainEntryWin:showEntryPanel(isInit)
if self.isShowEnterPanel then
return
end

local endVal=0
if isInit then
self.winlua:SetChildLocalPosX(self.layout:getID(),endVal)
else
self.winlua:SetChildDOLocalMoveX(self.layout:getID(),endVal,0.3)
end
self.isShowEnterPanel=true
end

function UIMainEntryWin:hideEntryPanel(isInit)
if not self.isShowEnterPanel then
return
end

local endVal=550
if isInit then
self.winlua:SetChildLocalPosX(self.layout:getID(),endVal)
else
self.winlua:SetChildDOLocalMoveX(self.layout:getID(),endVal,0.3)
end
self.isShowEnterPanel=false
end

function UIMainEntryWin:initLayoutPos()
local isxj=mainControl:isInScene(eSceneType.eXianJie)
if isxj then
self.isShowEnterPanel=not xianjieMainWinSimpleModeConfig:getRecordState(_simleKey)
else
self.isShowEnterPanel=not simpleModeControl:getRightSimple()
end
local endVal=self.isShowEnterPanel and 0 or 550
self.winlua:SetChildLocalPosX(self.layout:getID(),endVal)

local mapId=zongmenModel:getMountainId()
local iszm=mapId==mapIdType.zhufeng
local isxm=mapId==mapIdType.xianmeng


local posY=iszm and-100 or
isxm and-15 or
isxj and-120 or
-100


local posX=isxj and 15 or-89.5
if isxj then
local isOpenAct=xianJieArenaActModel:checkIsXJArenaActDoing()
local isOpen=xianJieArenaActModel:checkIsXJArenaActCanOpen()
if isOpenAct and isOpen then
posX=-89.5
posY=-126
end
end

self.winlua:SetChildLocalPosY(self.showArea:getID(),posY)
self.showArea:setLocalPosX(posX)
end

function UIMainEntryWin.onXianJieMainWinSimpleStateChange()
local simpleState=xianjieMainWinSimpleModeConfig:getRecordState(_simleKey)
if simpleState then
_this:hideEntryPanel()
else
_this:showEntryPanel()
end
end



