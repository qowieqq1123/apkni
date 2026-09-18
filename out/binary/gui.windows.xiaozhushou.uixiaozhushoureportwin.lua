







def_class("UIXiaoZhuShouReportWin",UIWindowBase)









function UIXiaoZhuShouReportWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.mask=UIButton.get(self,1)
self.reportContent=UIObject.get(self,2)
self.root=UIObject.get(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIXiaoZhuShouReportWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.reportContent);self.reportContent=nil;
_UIObject_release(self.root);self.root=nil;
end



















function UIXiaoZhuShouReportWin:onLoaded(...)
self:bindComponents()
end


function UIXiaoZhuShouReportWin:__delete()
self:unbindComponents()
end




function UIXiaoZhuShouReportWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6)
end
local reportList=xiaoZhuShouModel:getReportData()or{}
self.reportContent:setChildLayoutGroupCreateItems(#reportList,function(index)
local item=self.reportContent:getChildLayoutGroupGridItem(index-1)
local reportData=reportList[index]
local detailId=reportData.detailId
local detailCfg=cfg_xiaozhushoudetailconfig_get(detailId)
local desc=reportData.desc or''
local jumpParams=detailCfg.jump

item:SetChildCSImageSprite(0,"ui/windows/xiaozhushou/xzsiconsmall_pak.ab",string.format("image_zsjztps_%d",detailCfg.icon))
item:SetChildText(1,detailCfg.name)
item:SetChildText(2,desc)
item:SetChildButtonClick(3,function()
xiaoZhuShouModel:removeReportData(index)
xiaoZhuShouController:jumpReportWindow(jumpParams)
end)
end)
end



function UIXiaoZhuShouReportWin:onCloseBtn()
self:closeSelf()
end

function UIXiaoZhuShouReportWin:onMask()
self:closeSelf()
end

