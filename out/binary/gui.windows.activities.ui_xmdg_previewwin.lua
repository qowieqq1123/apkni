







def_class("UI_XMDG_PreviewWin",UIWindowBase)









function UI_XMDG_PreviewWin:bindComponents()

self.actTipsTxt=UIText.get(self,0)
self.btnGo=UIButton.get(self,1)
self.frameSp=UIObject.get(self,2)
self.root=UIObject.get(self,3)
self.titleImg=UIImage.get(self,4)

self.btnGo:setButtonClick(function()self:onBtnGo()end)



end


function UI_XMDG_PreviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.actTipsTxt);self.actTipsTxt=nil;
_UIObject_release(self.btnGo);self.btnGo=nil;
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titleImg);self.titleImg=nil;
end
















local _this=nil




function UI_XMDG_PreviewWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UI_XMDG_PreviewWin:__delete()
self:unbindComponents()
_this=nil
end




function UI_XMDG_PreviewWin:onShow(argtable,afterOnloaded)
self:updataView()
local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eXianMengDiGong)
userActorSetting.set('act_XMDG_preview_oldTime',tostring(actInfo.start_time))
userActorSetting.flush()

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.25,function()
self.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end
end


function UI_XMDG_PreviewWin:onHide()

end

function UI_XMDG_PreviewWin:updataView()
self.titleImg:setSprite(globalABLookup.actpreviewicons,"actpreview_title_2")

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.frameSp:getID(),false,true,false)
self.frameSp:setChildUIModelShowTarget(4218,1,{},2040,false,false,0,nil)

self:refreshDesc()
end

function UI_XMDG_PreviewWin:refreshDesc()
local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eXianMengDiGong)
local str=actInfo:getTimeDesc1()
str=FMT.fmt('活动时间:{0}',str)
self.actTipsTxt:setText(str)
end





function UI_XMDG_PreviewWin:onClickClose()
self:closeSelf()
end

function UI_XMDG_PreviewWin:onBtnGo()
local flag=jumpManager:jump({id=4500,args={actID=LIMIT_ACT_TYPE.eXianMengDiGong}},nil,JUMP_BACK.eNoBack)
if flag then
UIManager:closeWindow('UI_XMDG_PreviewWin')
end
end
