







def_class("UITaiXuCangbattleLogWin",UIWindowBase)









function UITaiXuCangbattleLogWin:bindComponents()

self.beplunderIcon_1=UIImage.get(self,0)
self.beplunderIcon_2=UIImage.get(self,1)
self.beplunderNameText_1=UIText.get(self,2)
self.beplunderNameText_2=UIText.get(self,3)
self.beplunderProgressbar_1=UIProgress.get(self,4)
self.beplunderProgressbar_2=UIProgress.get(self,5)
self.closeBtn=UIButton.get(self,6)
self.plunderIcon_1=UIImage.get(self,7)
self.plunderIcon_2=UIImage.get(self,8)
self.plunderNameText_1=UIText.get(self,9)
self.plunderNameText_2=UIText.get(self,10)
self.plunderProgressbar_1=UIProgress.get(self,11)
self.plunderProgressbar_2=UIProgress.get(self,12)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.beplunderIcon={
self.beplunderIcon_1,
self.beplunderIcon_2,
}
self.beplunderNameText={
self.beplunderNameText_1,
self.beplunderNameText_2,
}
self.beplunderProgressbar={
self.beplunderProgressbar_1,
self.beplunderProgressbar_2,
}
self.plunderIcon={
self.plunderIcon_1,
self.plunderIcon_2,
}
self.plunderNameText={
self.plunderNameText_1,
self.plunderNameText_2,
}
self.plunderProgressbar={
self.plunderProgressbar_1,
self.plunderProgressbar_2,
}



end


function UITaiXuCangbattleLogWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.beplunderIcon_1);self.beplunderIcon_1=nil;
_UIObject_release(self.beplunderIcon_2);self.beplunderIcon_2=nil;
_UIObject_release(self.beplunderNameText_1);self.beplunderNameText_1=nil;
_UIObject_release(self.beplunderNameText_2);self.beplunderNameText_2=nil;
_UIObject_release(self.beplunderProgressbar_1);self.beplunderProgressbar_1=nil;
_UIObject_release(self.beplunderProgressbar_2);self.beplunderProgressbar_2=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.plunderIcon_1);self.plunderIcon_1=nil;
_UIObject_release(self.plunderIcon_2);self.plunderIcon_2=nil;
_UIObject_release(self.plunderNameText_1);self.plunderNameText_1=nil;
_UIObject_release(self.plunderNameText_2);self.plunderNameText_2=nil;
_UIObject_release(self.plunderProgressbar_1);self.plunderProgressbar_1=nil;
_UIObject_release(self.plunderProgressbar_2);self.plunderProgressbar_2=nil;
self.beplunderIcon=nil;
self.beplunderNameText=nil;
self.beplunderProgressbar=nil;
self.plunderIcon=nil;
self.plunderNameText=nil;
self.plunderProgressbar=nil;
end



















function UITaiXuCangbattleLogWin:onLoaded(...)
self:bindComponents()
local onNewDay5am=function()
self:refreshPanel()
end
self:addNotify(notifyConfig.onNewDay5am,onNewDay5am)
end


function UITaiXuCangbattleLogWin:__delete()
self:unbindComponents()
end




function UITaiXuCangbattleLogWin:onShow(argtable,afterOnloaded)
self:refreshPanel()
end

function UITaiXuCangbattleLogWin:refreshPanel()
local bdData=TaiXuCangModel:getBuildingData()
local level=bdData.level
local cfg=cfgHelper.get(cfg_taixucangconfig_get,level)
local plunderList=TaiXuCangModel:getPlunderList()
local beplunderList=TaiXuCangModel:getBeplunderList()

local plunderIdx=1
for plunderid,plunderMax in pairs(cfg.plunder)do
local plunderValue=plunderList[plunderid]or 0
self.plunderProgressbar[plunderIdx]:setProgressValue(plunderValue,plunderMax)
self.plunderProgressbar[plunderIdx]:setChildProgressText(FMT.fmt("{0}/{1}",plunderValue,plunderMax))
self.plunderNameText[plunderIdx]:setText(itemsConfig.getItemName(plunderid))
self.plunderIcon[plunderIdx]:setIcon(iconHelper.getIconName(plunderid),true)
plunderIdx=plunderIdx+1
end

local beplunderIdx=1
for beplunderid,beplunderMax in pairs(cfg.beplunder)do
local beplunderValue=beplunderList[beplunderid]or 0
self.beplunderProgressbar[beplunderIdx]:setProgressValue(beplunderValue,beplunderMax)
self.beplunderProgressbar[beplunderIdx]:setChildProgressText(FMT.fmt("{0}/{1}",beplunderValue,beplunderMax))
self.beplunderNameText[beplunderIdx]:setText(itemsConfig.getItemName(beplunderid))
self.beplunderIcon[beplunderIdx]:setIcon(iconHelper.getIconName(beplunderid),true)
beplunderIdx=beplunderIdx+1
end
end


function UITaiXuCangbattleLogWin:onHide()

end





function UITaiXuCangbattleLogWin:onCloseBtn()
self:closeSelf()
end

