







def_class("UIDownloadButtonWin",UIWindowBase)









function UIDownloadButtonWin:bindComponents()

self.btnOpen=UIButton.get(self,0)
self.Text=UIText.get(self,1)
self.reddot=UIObject.get(self,2)
self.info=UIObject.get(self,3)
self.memory=UIText.get(self,4)
self.infoText=UIText.get(self,5)
self.infoFPS=UIObject.get(self,6)
self.infoTextFPS=UIText.get(self,7)

self.btnOpen:setButtonClick(function()self:onBtnOpen()end)



end


function UIDownloadButtonWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnOpen);self.btnOpen=nil;
_UIObject_release(self.Text);self.Text=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.info);self.info=nil;
_UIObject_release(self.memory);self.memory=nil;
_UIObject_release(self.infoText);self.infoText=nil;
_UIObject_release(self.infoFPS);self.infoFPS=nil;
_UIObject_release(self.infoTextFPS);self.infoTextFPS=nil;
end

















local _this=nil
local writablePath=CS.GamePath.writablePath
local startKeyword='----'
local keywords={'exception','error'}
local nextKeyword='function'
local finishKeyword='----'

function UIDownloadButtonWin:onLoaded(...)
self:bindComponents()
_this=self
self.winlua:SetChildUIDragEvent(self.btnOpen:getID(),0,self.beginDragCallback,self.endDragCallback,self.dragCallback)
local sizeX=self.winlua:GetChildSizeDeltaX(self.btnOpen:getID())
local sizeY=self.winlua:GetChildSizeDeltaY(self.btnOpen:getID())
self.halfSizeX=sizeX*0.5
self.halfSizeY=sizeY*0.5
self:freshScreen()
self.errArray={}
self.logArray={}
self.errTxt=""
self.log=''
self.readErrIdx=0
self:registerMesg()
self:refreshReddot(false)
self.info:setActive(true)
self.infoFPS:setActive(false)




if deviceHelper.isRunWebGL()then
if webGLHelper:is_DouYinGame()then
return
end
local tmb=1024*1024
local tick=function()
if api_Available_GetRuntimeInfo()then
local infoStr=_WXInterface.GetRuntimeInfo()
local info=jsonHelper.decode(infoStr)
local dpi=info.dpi
dpi=string.format('%0.2f',dpi)
local dpr=info.dpr
dpr=string.format('%0.2f',dpr)
local fps=info.fps
fps=string.format('%0.1f',fps)
local tm=info.totalMemory
tm=math.floor(tm/tmb)
local dm=info.dynamicMemory
dm=math.floor(dm/tmb)
local um=info.unAllocatedMemory
um=math.floor(um/tmb)
local fstr='DPI:{0}\nDPR:{1}\nFPS:{2}\nTM:{3}\nDM:{4}\nUM:{5}'
self.infoText:setText(FMT.fmt(fstr,dpi,dpr,fps,tm,dm,um))
local avgFPS=info.avgFPS
avgFPS=string.format('%0.1f',avgFPS)
local minFPS=info.minFPS
minFPS=string.format('%0.1f',minFPS)
local maxFPS=info.maxFPS
maxFPS=string.format('%0.1f',maxFPS)
local fstrFPS='avgFPS:{0}\nminFPS:{1}\nmaxFPS:{2}'
self.infoTextFPS:setText(FMT.fmt(fstrFPS,avgFPS,minFPS,maxFPS))
else
local dpi=webGLHelper:getDPI()
dpi=string.format('%0.2f',dpi)
local dpr=webGLHelper:getDPR()
dpr=string.format('%0.2f',dpr)
local fps=webGLHelper:getFPS()
fps=string.format('%0.1f',fps)
local tm=_WXInterface.GetTotalMemorySize()
tm=math.floor(tm/tmb)
local dm=_WXInterface.GetDynamicMemorySize()
dm=math.floor(dm/tmb)
local um=_WXInterface.GetUnAllocatedMemorySize()
um=math.floor(um/tmb)
local fstr='DPI:{0}\nDPR:{1}\nFPS:{2}\nTM:{3}\nDM:{4}\nUM:{5}'
self.infoText:setText(FMT.fmt(fstr,dpi,dpr,fps,tm,dm,um))
end
end
self:setTimer(1,-1,tick)
else
local oldFrameCount=Time.frameCount
local oldTime=Time.realtimeSinceStartup
local frame=0
local tick=function()
local frameCount=Time.frameCount
local time=Time.realtimeSinceStartup
local left=time-oldTime
if left>=0.1 then
frame=(frameCount-oldFrameCount)/left
oldTime=time
oldFrameCount=frameCount
self.infoText:setText(math.floor(frame))
end
end
self:setTimer(0.5,-1,tick)
end
end

function UIDownloadButtonWin:__delete()
self:unregisterMesg()
self:unbindComponents()
_this=nil
end

function UIDownloadButtonWin:onShow(argtable,afterOnloaded)
self:freshMemeory()
end

function UIDownloadButtonWin:onHide()

end





function UIDownloadButtonWin:onBtnOpen()
if self.drag then return end
local args=self:read()
self.readErrIdx=#self.errArray
self:refreshReddot(false)
UIManager:showWindow('UIDownloadLogWin',args)
end

function UIDownloadButtonWin:onInfoClick()
self.showFPSInfo=not self.showFPSInfo
self.infoFPS:setActive(self.showFPSInfo)
end

function UIDownloadButtonWin.beginDragCallback(index,position)
_this.drag=true
_this:freshScreen()
end

function UIDownloadButtonWin.endDragCallback(index,position)
_this.drag=false
_this:freshScreen()
end

function UIDownloadButtonWin.dragCallback(index,position)
if _this.drag then
position=_this:modifyPosition(position)
_this.winlua:SetChildUIScreenPos(_this.btnOpen:getID(),position)
end
end

function UIDownloadButtonWin:freshScreen()
local _screen=UnityEngine.Screen
self.screenWidth=_screen.width
self.screenHeight=_screen.height
end

function UIDownloadButtonWin:modifyPosition(position)
local x=position.x
local y=position.y
local halfSizeX=self.halfSizeX
local halfSizeY=self.halfSizeY
local screenWidth=self.screenWidth
local screenHeight=self.screenHeight
local flag=false
if x>(screenWidth-halfSizeX)then
x=screenWidth-halfSizeX
flag=true
elseif x<halfSizeX then
x=halfSizeX
flag=true
end
if y>(screenHeight-halfSizeY)then
y=screenHeight-halfSizeY
flag=true
elseif y<halfSizeY then
y=halfSizeY
flag=true
end
if flag then
return Vector2.New(x,y)
end
return position
end

function UIDownloadButtonWin:checkNewErr()
if self.reddotFlag then return end
self:read()
local readErrIdx=#self.errArray
if readErrIdx~=self.readErrIdx then
self.reddotFlag=true
self.reddot:setActive(true)
end
self.readErrIdx=readErrIdx
end

function UIDownloadButtonWin:clearErrIdx()
self.readErrIdx=0
self.reddotFlag=false
end

function UIDownloadButtonWin:read()
self:readFile()
self:readErr()
local args={}
args.errArray=self.errArray
args.logArray=self.logArray
args.log=self.log
args.errTxt=self.errTxt
return args
end


function UIDownloadButtonWin:readFile()
self.errArray={}
self.logArray={}
self.errTxt=""
self.log=''
local filename='log.txt'
if api_Available_WriteLogContentToFile()then
filename='logErr.txt'
end
local path=writablePath..'/'..filename
local f=io.open(path,'r')
if f==nil then

return
end
for lineStr in f:lines()do
if not string.findStr(lineStr,'Data] not found')and
not string.findStr(lineStr,'Animation not found')then
self.logArray[#self.logArray+1]=lineStr
end
end
local content=table.concat(self.logArray,"\n")
self.log=content
f:close()
self.errTxt=content
end

if deviceHelper.isRunWebGL()then
UIDownloadButtonWin.readFile=function(self)
self.errArray={}
self.logArray={}
self.errTxt=""
self.log=''
local filename='log.txt'
if api_Available_WriteLogContentToFile()then
filename='logErr.txt'
end
local path=_WXInterface.USER_DATA_PATH..'/'..filename
local content=_WXInterface.ReadFileSync(path)or''
local cntArray=string.split(content,'\n')
for i,v in ipairs(cntArray)do
self.logArray[#self.logArray+1]=v
end
self.log=content
self.errTxt=content
end
end

function UIDownloadButtonWin:readErr()
local len=#self.logArray
local findErrStart=false
local contentTable={}
for i=1,len do
local lineStr=self.logArray[i]
if lineStr and lineStr~=''then
if not findErrStart then
if string.findStr(lineStr,startKeyword)then
findErrStart=true
end
elseif findErrStart then
if not string.findStr(lineStr,finishKeyword)then
contentTable[#contentTable+1]=lineStr
else
local content=table.concat(contentTable,'\n')
self.errArray[#self.errArray+1]=content
contentTable={}
findErrStart=false
end
end
end
end
end

function UIDownloadButtonWin:fresh()
local args=self:read()
UIManager:callWindowFunc('UIDownloadLogWin','onShow',args)
end

function UIDownloadButtonWin:freshMemeory()
if self.memoryTimer then
self:stopTimerByID(self.memoryTimer)
end
self.memoryTimer=nil

if appUtils.showMemory and
not deviceHelper.isRunNoneOrEditor()and
api_Available_GetRAMFreeSpace()then
self.memoryTimer=self:setTimer(1,0,function()
local freeSpace=CS.GameInterface.GetRAMFreeSpace()
local totalSpace=CS.GameInterface.GetRAMTotalSpace()
local free=tonumber(tostring(freeSpace))
local total=tonumber(tostring(totalSpace))
local use=total-free
local useStr=string.format('%0.2fM',use/1024/1024)
local totalStr=string.format('%0.2fM',total/1024/1024)
self.memory:setText(FMT.fmt('{0}/\n{1}',useStr,totalStr))
end)
else
self.memory:setText('')
end
end

function UIDownloadButtonWin:refreshReddot(reddot)
if self.reddotFlag==reddot then return end
self.reddotFlag=reddot
self.reddot:setActive(reddot)
end

function UIDownloadButtonWin:registerMesg()
if api_Available_SetErrLogCallback()then
CS.GameInterface.SetErrLogCallback(function()
self:refreshReddot(true)
end)
else
self:setTimer(10,0,function()
self:checkNewErr()
end)
end
end

function UIDownloadButtonWin:unregisterMesg()
if api_Available_SetErrLogCallback()then
CS.GameInterface.SetErrLogCallback(nil)
end
end