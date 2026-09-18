







def_class("UIXianShiChoukaSelectWin",UIWindowBase)









function UIXianShiChoukaSelectWin:bindComponents()

self.ScrollerScript=UIEnhancedScrollerLua.get(self,0)
self.Button=UIObject.get(self,1)
self.bgModel=UIObject.get(self,2)
self.left=UIObject.get(self,3)
self.right=UIObject.get(self,4)
self.bgModel2=UIObject.get(self,5)



end


function UIXianShiChoukaSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
_UIObject_release(self.Button);self.Button=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.right);self.right=nil;
_UIObject_release(self.bgModel2);self.bgModel2=nil;
end



















local UISelectScroller=simple_class(UIEnhancedScroller)
local this
local ab="ui/windows/activities/sub_xianshichouka/xianshichoukarole_atlas_pak.ab"


function UIXianShiChoukaSelectWin:onLoaded(...)
self:bindComponents()
self.enhancedscrollscript=UISelectScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
this=self
end


function UIXianShiChoukaSelectWin:__delete()
self:unbindComponents()
this=nil
end




function UIXianShiChoukaSelectWin:onShow(argtable,afterOnloaded)
self.actID=argtable.actID
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

self.sub_cfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.winlua:SetChildCanvasGroupDOFade(0,1,1)
self.bgModel:setChildUIModelShowTarget(5361,1,{},eAnimationID.enter,false,false,0.3,function()
self:delayDo(0.3,function()
if this then
this:initSelectClassPanel()
end
end)
end)
self.bgModel2:setChildUIModelShowTarget(5362,1,{},eAnimationID.enter,false,false,0.3,function()
self:delayDo(0.3,function()
if this then
this:initSelectClassPanel()
end
end)
end)
end


function UIXianShiChoukaSelectWin:onHide()

end

function UIXianShiChoukaSelectWin.onItemClick(itemid,index,itemguid,attach)

UIRecruitControl:showItemDiscipleInfoByItemId2(itemid)
end

local cellComponent=
{
Widget=0,
Widget1=1,
Widget2=2,
text=3,
icon=4,
yixuanzheImage=5,
button=6,
}
local WidgetIndex=
{
NameText=0,
chengwei=1,
}
local maxItem=3

function UIXianShiChoukaSelectWin:onCloseClick()
if self.myData.period_idx==0 then
UIManager.info("请先选择仙缘弟子组合")
return
end
self:closeSelf()
end

function UIXianShiChoukaSelectWin:initSelectClassPanel()

self.Button:setActive(self.myData.period_idx~=0)
self.left:setActive(true)
self.right:setActive(true)
local dataNumindex=0
local serverOpenDay=self.myData.record_server_day
for i,v in ipairs(this.sub_cfg.disciple)do
if serverOpenDay>=v[1]then
dataNumindex=dataNumindex+1
end
end
self.enhancedscrollscript:initData({},443,dataNumindex)
end


function UISelectScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UISelectScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UISelectScroller:RefreshCell(dataIndex,cellIndex,cell)
local disciple=this.sub_cfg.disciple
local curdiscipleShow=this.sub_cfg.discipleShow[dataIndex]
local vociconList=curdiscipleShow.vocicon
local nameList=curdiscipleShow.name
local itemIdList=curdiscipleShow.showItemId
for i=1,maxItem do
local Widget=cell:GetChildWidgetBase(i-1)
local itemid=itemIdList[i]
local vocicon=vociconList[i]
Widget:SetItemID(itemid)
Widget:SetClickEvent(this.onItemClick)
Widget:SetChildCSImageSprite(WidgetIndex.chengwei,ab,vocicon)
Widget:SetChildText(WidgetIndex.NameText,nameList[i]or"")
end
cell:SetChildCSImageSprite(cellComponent.icon,ab,curdiscipleShow.BgIcon)
if this.myData.period_idx~=0 and dataIndex==this.myData.period_idx then
cell:SetChildActive(cellComponent.button,false)
cell:SetChildActive(cellComponent.yixuanzheImage,true)
else
cell:SetChildActive(cellComponent.button,true)
cell:SetChildActive(cellComponent.yixuanzheImage,false)
cell:SetChildText(cellComponent.text,"选择")
end
end

function UISelectScroller:onCellClick(cellIndex,dataIndex,cell,exchangeIndex)

activitiesController:sendProtocol(actSendType.eComonReqHandle,this.actID,this.subType,this.subid,jsonHelper.encode({1,dataIndex,this.myData.itemid}))

UIManager.info("选择成功")
end

function UISelectScroller.onItemClick(cellIndex,dataIndex,cell,exchangeIndex)

end
