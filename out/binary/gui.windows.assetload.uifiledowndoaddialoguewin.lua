







def_class("UIFileDownDoadDialogueWin",UIWindowBase)









function UIFileDownDoadDialogueWin:bindComponents()

self.BtnTitle=UIText.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.desc=UIText.get(self,2)
self.downTxt=UIText.get(self,3)
self.progressBar=UIProgressBarAni.get(self,4)
self.progressTxt=UIText.get(self,5)
self.tryBtn=UIButton.get(self,6)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.tryBtn:setButtonClick(function()self:onTryBtn()end)



end


function UIFileDownDoadDialogueWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.BtnTitle);self.BtnTitle=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.downTxt);self.downTxt=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressTxt);self.progressTxt=nil;
_UIObject_release(self.tryBtn);self.tryBtn=nil;
end



















function UIFileDownDoadDialogueWin:onLoaded(...)
self:bindComponents()
end


function UIFileDownDoadDialogueWin:__delete()
self:unbindComponents()
end




function UIFileDownDoadDialogueWin:onShow(argtable,afterOnloaded)
local title=argtable.title
self.fileGroupid=argtable.fileGroupid
self.desc:setText(title)
self:refreshProgress(argtable)
self.tryBtn:setActive(false)
end


function UIFileDownDoadDialogueWin:onHide()

end





function UIFileDownDoadDialogueWin:onCloseBtn()
self:closeSelf()
end



function UIFileDownDoadDialogueWin:onTryBtn()
downloadAssetWithFileManager:stratDownLoad(self.fileGroupid,true)
end

function UIFileDownDoadDialogueWin:refreshProgress(args)
if self.fileGroupid~=args.fileGroupid then return end
local size=args.size
local tsize=args.tsize
local finish=size>=tsize
if finish then size=tsize end
local progress=math.floor(size*100/tsize)
self.progressBar:animateFiveParams(0,size,tsize,0,true)
self.progressTxt:setText(FMT.fmt('{0}%',progress))
self.downTxt:setText(string.format('%.1fM/%.1fM',size/1024/1024,tsize/1024/1024))
end

function UIFileDownDoadDialogueWin:onLoadFailed(fileGroupid)

if self.fileGroupid~=fileGroupid then return end
local fileCfg=cfg_downloadfilegroupconfig_get(fileGroupid)
self.desc:setText(FMT.fmt('{0}下载失败,请问祖师是否重新下载？',fileCfg.name))
self.tryBtn:setActive(true)
return true
end

function UIFileDownDoadDialogueWin:onLoadSuccess(fileGroupid,tsize)

if self.fileGroupid~=fileGroupid then return end
local size=tsize
self.progressBar:animateFiveParams(0,size,tsize,0,true)
self.progressTxt:setText('100%')
self.downTxt:setText(string.format('%.1fM/%.1fM',size/1024/1024,tsize/1024/1024))
local fileCfg=cfg_downloadfilegroupconfig_get(fileGroupid)
self.desc:setText(FMT.fmt('{0}下载完成',fileCfg.name))
self.tryBtn:setActive(false)
return true
end
