







def_class("UIAssetLoadSceneWin",UIWindowBase)









function UIAssetLoadSceneWin:bindComponents()

self.DownContent=UIText.get(self,0)
self.DownProgress=UIObject.get(self,1)
self.ProgressTip=UIText.get(self,2)
self.ProgressBar=UIProgress.get(self,3)
self.StateTip=UIText.get(self,4)
self.WarnTip=UIText.get(self,5)
self.BtnTitle=UIText.get(self,6)
self.PersentTip=UIText.get(self,7)
self.DownFile=UIText.get(self,8)



end


function UIAssetLoadSceneWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.DownContent);self.DownContent=nil;
_UIObject_release(self.DownProgress);self.DownProgress=nil;
_UIObject_release(self.ProgressTip);self.ProgressTip=nil;
_UIObject_release(self.ProgressBar);self.ProgressBar=nil;
_UIObject_release(self.StateTip);self.StateTip=nil;
_UIObject_release(self.WarnTip);self.WarnTip=nil;
_UIObject_release(self.BtnTitle);self.BtnTitle=nil;
_UIObject_release(self.PersentTip);self.PersentTip=nil;
_UIObject_release(self.DownFile);self.DownFile=nil;
end



















function UIAssetLoadSceneWin:onLoaded(...)
self:bindComponents()
end


function UIAssetLoadSceneWin:__delete()
self:unbindComponents()
end




function UIAssetLoadSceneWin:onShow(argtable,afterOnloaded)
UIManager:closeWindow('UIAssetLoadWin')
self:flushData()
end


function UIAssetLoadSceneWin:onHide()

end




function UIAssetLoadSceneWin:flushData()
if downAssetManager.forceDownFinish then
local content=string.format("<color=#945f3c>%s下载完成,下载<color=#562b1c>%d</color>个文件</color>",downAssetManager.forceDownLoadName or'场景',downAssetManager.forceGroupFileCount)
self:setDownContent(content)
self:setWarnTipVis(false)
self:setDownContentVis(true)
self:setStateTipVis(false)
self:setBtnTitle('确定')
self:flushProgress(true)
else
local content=string.format("<color=#945f3c>下载场景%s,需要<color=#562b1c>%d</color>个文件</color>",downAssetManager.forceDownLoadName or'场景',downAssetManager.forceGroupFileCount)
self:setDownContent(content)
self:setWarnTipVis(false)
self:setDownContentVis(true)
self:setStateTipVis(false)
self:setBtnTitle('确定')
self:flushProgress(false)
end
end



function UIAssetLoadSceneWin:flushProgress(finish)
if finish then
local name=downAssetManager.forceDownLoadName or'场景'
local packNunInfo=name.."下载完成"
local total








total=downAssetManager.forceGroupFileCount
self:setProgressTip(packNunInfo)
self:setProgressBar(total,total)
local persentTip=string.format("%d/%d",total,total)
self:setPersentTip(persentTip)

else
local name=downAssetManager.forceDownLoadName or'场景'
local packNunInfo="下载"..name.."中"
local cur,total











cur=downAssetManager.forceGroupFileCountDown
total=downAssetManager.forceGroupFileCount
self:setProgressTip(packNunInfo)
self:setProgressBar(downAssetManager.simulationProgress,100)
local persentTip=string.format("%d/%d",cur,total)
self:setPersentTip(persentTip)

end
end

function UIAssetLoadSceneWin:onClickClose()
UIManager:closeWindow('UIAssetLoadSceneWin')
downAssetManager:closeAssetLoadEnter()
end

function UIAssetLoadSceneWin:onClickBnt()
UIManager:closeWindow('UIAssetLoadSceneWin')
downAssetManager:closeAssetLoadEnter()
end


function UIAssetLoadSceneWin:setDownContent(text)
self.DownContent:setText(text)
end

function UIAssetLoadSceneWin:setDownContentVis(active)
self.DownContent:setActive(active)
end

function UIAssetLoadSceneWin:setDownProgressVis(active)
self.DownProgress:setActive(active)
end

function UIAssetLoadSceneWin:setProgressTip(text)
self.ProgressTip:setText(text)
end

function UIAssetLoadSceneWin:setProgressTipVis(active)
self.ProgressTip:setActive(active)
end

function UIAssetLoadSceneWin:setProgressBar(curval,maxval)
self.winlua:SetChildProgress(self.ProgressBar:getID(),curval,maxval)
end

function UIAssetLoadSceneWin:setStateTip(text)
self.StateTip:setText(text)
end

function UIAssetLoadSceneWin:setStateTipVis(active)
self.StateTip:setActive(active)
end

function UIAssetLoadSceneWin:setWarnTipVis(active)
self.WarnTip:setActive(active)
end

function UIAssetLoadSceneWin:setBtnTitle(text)
self.BtnTitle:setText(text)
end

function UIAssetLoadSceneWin:setPersentTip(text)
self.PersentTip:setText(text)
end
