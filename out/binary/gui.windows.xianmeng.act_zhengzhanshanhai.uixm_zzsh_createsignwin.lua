







def_class("UIXM_ZZSH_createSignWin",UIWindowBase)









function UIXM_ZZSH_createSignWin:bindComponents()

self.nameTxt=UIText.get(self,0)
self.posXTxt=UIText.get(self,1)
self.posYTxt=UIText.get(self,2)
self.changeNameBtn=UIButton.get(self,3)

self.changeNameBtn:setButtonClick(function()self:onChangeNameBtn()end)



end


function UIXM_ZZSH_createSignWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.nameTxt);self.nameTxt=nil;
_UIObject_release(self.posXTxt);self.posXTxt=nil;
_UIObject_release(self.posYTxt);self.posYTxt=nil;
_UIObject_release(self.changeNameBtn);self.changeNameBtn=nil;
end
















local _this


function UIXM_ZZSH_createSignWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_ZZSH_createSignWin:__delete()
_this=nil
self:unbindComponents()
if UIManager:isActive('UICommonChangeNameWin')then
UIManager:closeWindow('UICommonChangeNameWin')
end
end


function UIXM_ZZSH_createSignWin:onHide()

end




function UIXM_ZZSH_createSignWin:onShow(argtable,afterOnloaded)
self.mData=argtable

self.nameTxt:setText(self.mData.name)
self.posXTxt:setText(tostring(self.mData.x))
self.posYTxt:setText(tostring(self.mData.y))
end

function UIXM_ZZSH_createSignWin:onChangeNameBtn()
local data=self.mData
local args={}
args.title='更改名称'
args.changeNameType=changeNameType.eZZSHSign
args.defaultName=data.name
args.crossCheck=true
args.callback=function(name)
if _this==nil then return end
UIManager.info('名字修改成功')
data.name=name
_this.nameTxt:setText(name)
end
UIManager:showWindow('UICommonChangeNameWin',args)
end

function UIXM_ZZSH_createSignWin:onSureBtn()
local data=self.mData
local checkSign=zhengzhanshanhaiModel:checkSignRecord(data.x,data.y)
if checkSign then
UIManager.error('已收藏该地点')
return
end
local d={x=data.x,y=data.y,name=data.name}
zhengzhanshanhaiModel:setSignRecord(d)
UIManager.info('地点收藏成功')
UIManager:invokeUIMethod('UIXM_ZZSH_signWin','handleSignRefresh')
UIManager:invokeUIMethod('UIXM_ZZSH_worldWin','handleSignRefresh')
UIManager:invokeUIMethod('UIXM_ZZSH_posInfoWin','refreshSignRecord')
self:closeSelf()
end