







def_class("tipsChildReportDisplay",UICloneObject)





tipsChildReportDisplay.abName="ui/windows/tips/child/tipschildreportdisplay.ab"

tipsChildReportDisplay.assetName="tipsChildReportDisplay"


function tipsChildReportDisplay:bindComponents()

self.root=UIObject.get(self,0)
self.button=UIButton.get(self,1)

self.button:setButtonClick(function()self:onButton()end)

end


function tipsChildReportDisplay:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.button);self.button=nil;
end









function tipsChildReportDisplay:onLoaded(...)
self:bindComponents()
end


function tipsChildReportDisplay:__delete()
self:unbindComponents()
end




function tipsChildReportDisplay:onShow(argtable,afterOnloaded)
local data=argtable.argtable
self.itemid=data.itemid
end


function tipsChildReportDisplay:onHide()

end




function tipsChildReportDisplay:onButton()
local itemCfg=itemsConfig.getConfig(self.itemid)
local info=itemCfg.display
local param={
reportId=info[1],
stageId=info[2],
}
UIManager:showWindow("UIReportDisplayWin",param)
end