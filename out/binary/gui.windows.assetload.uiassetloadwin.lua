







def_class("UIAssetLoadWin",UIWindowBase)









function UIAssetLoadWin:bindComponents()

self.DownContent=UIText.get(self,0)
self.DownProgress=UIObject.get(self,1)
self.ProgressTip=UIText.get(self,2)
self.ProgressBar=UIProgress.get(self,3)
self.StateTip=UIText.get(self,4)
self.warnTip=UIText.get(self,5)
self.BtnTitle=UIText.get(self,6)
self.PersentTip=UIText.get(self,7)
self.DownFile=UIText.get(self,8)
self.up=UIObject.get(self,9)
self.down=UIObject.get(self,10)



end


function UIAssetLoadWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.DownContent);self.DownContent=nil;
_UIObject_release(self.DownProgress);self.DownProgress=nil;
_UIObject_release(self.ProgressTip);self.ProgressTip=nil;
_UIObject_release(self.ProgressBar);self.ProgressBar=nil;
_UIObject_release(self.StateTip);self.StateTip=nil;
_UIObject_release(self.warnTip);self.warnTip=nil;
_UIObject_release(self.BtnTitle);self.BtnTitle=nil;
_UIObject_release(self.PersentTip);self.PersentTip=nil;
_UIObject_release(self.DownFile);self.DownFile=nil;
_UIObject_release(self.up);self.up=nil;
_UIObject_release(self.down);self.down=nil;
end



















function UIAssetLoadWin:onLoaded(...)
self:bindComponents()
end


function UIAssetLoadWin:__delete()
self:unbindComponents()
end

function UIAssetLoadWin:onShow(argtable,afterOnloaded)
self:flushData()
end


function UIAssetLoadWin:onHide()

end




function UIAssetLoadWin:flushData()
local packNum=downAssetManager.totalPackage
local packIndex=packNum-downAssetManager.remainPackage+1

local curGroupDownSize=downAssetManager.curGroupFileDownCount
local curPackDown=downAssetManager.curPackDownCount+curGroupDownSize
local packTotal=downAssetManager.curPackFileCount
local downSize=downAssetManager.curDownTotalFileCount+curPackDown
local totalSize=downAssetManager.packageTotalFileCount
if downAssetManager.packageDownFinish==true then
if packNum==0 then packNum=1 end
if totalSize==0 then totalSize=1 end
if packTotal==0 then packTotal=1 end
self:setStateTipVis(false)
self:flushProgress(packNum,packNum,totalSize,totalSize,packTotal,packTotal,true)




self:setDownContent("<color=#945f3c>资源补充包已下载完成</color>")
self:setBtnTitle('确定')

else
local content=string.format("<color=#945f3c>体验新的游戏内容需要下载资源补充包,还需下载<color=#562b1cff>%d</color>个文件(Wifi环境下自动下载)</color>",totalSize)
self:setDownContent(content)
local currentNetState=downAssetManager.curNetType
if downAssetManager.hasPackageDownLoading then
if currentNetState==eNetworkReachability.ViaCarrierData then
if downAssetManager.allowCarrierNetDown then
self:setDownProgressVis(true)
self:setStateTipVis(false)
self:setWarnTipVis(false)
self:flushProgress(packIndex,packNum,downSize,totalSize,curPackDown,packTotal,false)

self:setBtnTitle('确定')
else
self:setDownProgressVis(false)
self:setWarnTipVis(false)

self:setBtnTitle('确定')
end
else
self:setWarnTipVis(false)
self:setDownProgressVis(true)
self:setStateTipVis(true)
self:flushProgress(packIndex,packNum,downSize,totalSize,curPackDown,packTotal,false)

self:setBtnTitle('确定')
end
else
if currentNetState==eNetworkReachability.ViaCarrierData then
self:setDownProgressVis(false)
self:setWarnTipVis(false)

self:setBtnTitle('确定')
else
self:setWarnTipVis(false)
self:setDownProgressVis(true)
self:setStateTipVis(true)
self:flushProgress(packIndex,packNum,downSize,totalSize,curPackDown,packTotal,false)

self:setBtnTitle('确定')
end
end
end
end

function UIAssetLoadWin:flushProgress(curPackID,totalPackNum,curDown,total,packDown,packTotal,done)
if done then
self:setProgressTipVis(false)
self:setProgressBar(packDown,packTotal)
self:setPersentTip("完成")
else
local packNunInfo=string.format("更新资源文件包 %d/%d （%.1f%%）",curPackID,totalPackNum,100*curDown/total)
self:setProgressTipVis(true)
self:setProgressTip(packNunInfo)
self:setProgressBar(packDown,packTotal)
local persentTip=string.format("%d/%d",packDown,packTotal)
self:setPersentTip(persentTip)
end
end

function UIAssetLoadWin:onClickClose()
UIManager:closeWindow('UIAssetLoadWin')
downAssetManager:closeAssetLoadEnter()
end

function UIAssetLoadWin:onClickBtn()































UIManager:closeWindow('UIAssetLoadWin')
downAssetManager:closeAssetLoadEnter()


end


function UIAssetLoadWin:setDownContent(text)
self.DownContent:setText(text)
end

function UIAssetLoadWin:setDownContentVis(active)
self.DownContent:setActive(active)
end

function UIAssetLoadWin:setDownProgressVis(active)
self.DownProgress:setActive(active)
end

function UIAssetLoadWin:setProgressTip(text)
self.ProgressTip:setText(text)
end

function UIAssetLoadWin:setProgressTipVis(active)
self.ProgressTip:setActive(active)
end

function UIAssetLoadWin:setProgressBar(curval,maxval)
self.winlua:SetChildProgress(self.ProgressBar:getID(),curval,maxval)
end

function UIAssetLoadWin:setStateTip(text)
self.StateTip:setText(text)
end

function UIAssetLoadWin:setStateTipVis(active)
self.StateTip:setActive(active)
end

function UIAssetLoadWin:setWarnTip(text)
self.warnTip:setText(text)
end

function UIAssetLoadWin:setWarnTipVis(active)
self.warnTip:setActive(active)
end

function UIAssetLoadWin:setBtnTitle(text)
self.BtnTitle:setText(text)
end

function UIAssetLoadWin:setPersentTip(text)
self.PersentTip:setText(text)
end

function UIAssetLoadWin:setDownFile(text)
self.DownFile:setText(text)
end

function UIAssetLoadWin:setDownVis(active)
self.down:setActive(active)
end