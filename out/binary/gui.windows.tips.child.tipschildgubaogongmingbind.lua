







def_class("tipsChildGuBaoGongMingBind",UICloneObject)





tipsChildGuBaoGongMingBind.abName="ui/windows/tips/child/tipschildgubaogongmingbind.ab"

tipsChildGuBaoGongMingBind.assetName="tipsChildGuBaoGongMingBind"


function tipsChildGuBaoGongMingBind:bindComponents()

self.itemGroup=UIObject.get(self,0)

end


function tipsChildGuBaoGongMingBind:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.itemGroup);self.itemGroup=nil;
end









function tipsChildGuBaoGongMingBind:onLoaded(...)
self:bindComponents()
end


function tipsChildGuBaoGongMingBind:__delete()
self:unbindComponents()
end




function tipsChildGuBaoGongMingBind:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local diziguid=attach.diziguid
self.diziguid=diziguid
self.itemid=itemid
self.formType=data.formType
local itemConfig=itemsConfig.getConfig(itemid)

local gubaoList=itemConfig.gubao or{}
local itemGrids=self.itemGroup:getChildCommonLayoutGroupWidgetList()
for i=1,itemGrids.Count do
local widget=itemGrids[i-1]
local gbid=gubaoList[i]
if gbid then
widget:SetChildActive(-1,true)

local gbCfg=cfgHelper.get(cfg_gubaoconfig_get,gbid)


widget:SetChildText(6,gbCfg.name)


widget:SetChildCSImageIcon(2,gubaoModel:getGuBaoIconName(gbCfg.icon),false)


local isActive=gubaoModel:checkActive(gbid)
widget:SetChildActive(4,not isActive)


local isJueXing=isActive and gubaoModel:checkAwake(gbid)or false
widget:SetChildActive(3,isJueXing)


local gbData=gubaoModel:getDataByID(gbid)
local starlv=gbData and gbData.gubaostar or 0
local isShowStar=isActive and starlv>0 or false
widget:SetChildActive(5,isShowStar)
if isShowStar then
local starGrids=widget:GetChildCommonLayoutGroupWidgetList(5)
for i=1,starGrids.Count do
local startWidget=starGrids[i-1]
startWidget:SetChildActive(-1,starlv>=i)
end
end


local formType=self.formType
local tipsType=TIPS_TYPE.eCommonGubao
widget:SetChildButtonClick(0,function()
tipsManager.closeTips()
tipsManager.showTipsGB({formType=formType,tipsType=tipsType,itemid=gbid,bg=false})
end,true)

else
widget:SetChildActive(-1,false)
end
end
end


function tipsChildGuBaoGongMingBind:onHide()

end


