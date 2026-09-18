







def_class("UIXianGuan_fightExtraWin",UIWindowBase)









function UIXianGuan_fightExtraWin:bindComponents()

self.jobPanel=UIObject.get(self,0)



end


function UIXianGuan_fightExtraWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.jobPanel);self.jobPanel=nil;
end
















local _jobPanelCmpIndex={
jobIcon=0,
jobName=1,
privilegeName=2,
attrList=3,
attrTips=4,
attrPanel=5,
descPanel=6,
descText=7,
}




function UIXianGuan_fightExtraWin:onLoaded(...)
self:bindComponents()
end


function UIXianGuan_fightExtraWin:__delete()
self:unbindComponents()
end




function UIXianGuan_fightExtraWin:onShow(argtable,afterOnloaded)
self:refresh()
end


function UIXianGuan_fightExtraWin:onHide()

end

function UIXianGuan_fightExtraWin:refresh()
local isShowJobPanel=false
local xianGuanList=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,"notYZMarchXianGuanMsg")
if xianGuanList then
for _,v in ipairs(xianGuanList)do
local jobType=v[1]
local privilegeId=v[2]
local isShowAttr=v[3]and v[3]==1 or false
local isXianGuan,jobId=xianguanController:checkSelfHasJobByType(jobType)
if isXianGuan then
local isHasTq=xianguanConfig.checkJobCfgHasTeQuan(jobId,privilegeId)
if isHasTq and xianguanHelper.checkTeQuanPlatformLimit(privilegeId)and xianguanHelper.checkSpecialUseCondition(jobId,privilegeId,false)then
isShowJobPanel=true
return self:showJobPanel(jobId,privilegeId,isShowAttr)
end
end
end
end
self.jobPanel:setActive(false)
end

function UIXianGuan_fightExtraWin:showJobPanel(jobId,privilegeId,isShowAttr)
self.jobPanel:setActive(true)

local jobWidget=self.jobPanel:getChildWidgetBase()
local jobCfg=cfgHelper.get1(cfg_xianguanconfig_get,jobId)
local privilegeCfg=cfgHelper.get1(cfg_xianguanprivilegeconfig_get,privilegeId)
local jobIconName=xianguanConfig.getJobIconName(jobCfg.jobIcon)
jobWidget:SetChildCSImageSprite(_jobPanelCmpIndex.jobIcon,globalABLookup.xianguan,jobIconName)
jobWidget:SetChildText(_jobPanelCmpIndex.jobName,FMT.fmt("【{0}】",jobCfg.name))

jobWidget:SetChildText(_jobPanelCmpIndex.privilegeName,privilegeCfg.name)
jobWidget:SetChildActive(_jobPanelCmpIndex.attrPanel,isShowAttr or false)
jobWidget:SetChildActive(_jobPanelCmpIndex.descPanel,not isShowAttr)
if isShowAttr then
jobWidget:SetChildLayoutGroupCreateItems(_jobPanelCmpIndex.attrList,#privilegeCfg.effectArgs,function(index)
local item=jobWidget:GetChildLayoutGroupGridItem(3,index-1)
local attr=privilegeCfg.effectArgs[index]
item:SetChildText(0,helper.getAttributeStr(attr[1],attr[2],2,"{0}：+{1}"))
end)
else
local descStr=privilegeCfg.descEx
jobWidget:SetChildText(_jobPanelCmpIndex.descText,descStr)
end
end


