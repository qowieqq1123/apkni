







def_class("UIXianJieExplorationMysteryWin",UIWindowBase)









function UIXianJieExplorationMysteryWin:bindComponents()

self.empty=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,2)
self.uiPanel=UIObject.get(self,3)



end


function UIXianJieExplorationMysteryWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.empty);self.empty=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
_UIObject_release(self.uiPanel);self.uiPanel=nil;
end















local _this=nil
local _itemCmp={
name=0,
progress=1,
image=2,
tansuo=3,
teshu=4,
nd=5,
tou=6,
reddot=7,
}
local bqabName="ui/windows/mystery/sharedtextures/mysterylistsprite.ab"
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)



function UIXianJieExplorationMysteryWin:onLoaded(...)
self:bindComponents()
_this=self

self.enhancedscrollscript=UIPrepareEnScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self

self:addNotify(notifyConfig.onXianJieResPointDataChange,self.onXianJieResPointDataChange)
end


function UIXianJieExplorationMysteryWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianJieExplorationMysteryWin:onShow(argtable,afterOnloaded)
self:refreshView()
if afterOnloaded and argtable.isInit then
self:playEnterAnim()
end
end


function UIXianJieExplorationMysteryWin:onHide()

end





function UIXianJieExplorationMysteryWin:playEnterAnim()
if not newbieControl.isInNewbie()then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-508,1))
self.uiPanel:setChildDOAnchorPosX(0,0.2,nil)
end
UIManager:invokeUIMethod('UIXianJieExplorationWin','playEnterAnim')
end
function UIXianJieExplorationMysteryWin:playLeaveAnim()
self.uiPanel:setChildDOAnchorPosX(-508,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil
self:closeSelf()
end)
end

function UIXianJieExplorationMysteryWin:refreshView()
self.datas=xianjieModel:getResPointDatasByType(XJ_ResPoint_TYPE.eMystery)
local count=#self.datas
self.empty:setActive(count<=0)
self.enhancedscrollscript:initData(self.datas,125,count)
end

function UIXianJieExplorationMysteryWin:refreshItem(item,index)
local data=self.datas[index]
local config=data:getCfg()
local mysteryId=config.mystery
local mysteryCfg=cfgHelper.get1(cfg_secretscenefubenconfig_get,mysteryId)

local difficulty_text_color=cfgHelper.get2(cfg_secretscenebaseconfig_get,1,"fb_quality")
local color_cfg=difficulty_text_color[mysteryCfg.color]
local colorStr=color_cfg[2]

local nameStr=""
local ent_key=data.ent_key
if ent_key then
local ent=xianjieController:getEntity(ent_key)
if ent then
nameStr=ent:getName()
end
end
nameStr=colorStr and FMT.fmt("<color=#{0}>{1}</color>",colorStr,nameStr)or nameStr

local percent=MysteryModel:getPercentListData(mysteryId)
local mjData=MysteryModel:get_mysteryFB_list_data_fbid(mysteryId)
local biaoqian=mysteryCfg.mjShowType
local sceneType=xianjieModel:sceneIndex2SceneType(data.sceneidx)
local sceneName=cfgHelper.get2(cfg_xianjiesceneconfig_get,sceneType,"name")
local tansuo_ing=xianjieModel:haveResPointMarch(data.rpGuid)

item:SetChildText(_itemCmp.name,nameStr)
item:SetChildText(_itemCmp.progress,FMT.fmt("{0}%",percent))
item:SetChildCSImageIcon(_itemCmp.image,mysteryCfg.image,false)
item:SetChildActive(_itemCmp.tansuo,tansuo_ing)
item:SetChildActive(_itemCmp.teshu,biaoqian~=nil)
item:SetChildCSImageSprite(_itemCmp.teshu,bqabName,FMT.fmt("icon_dsjmijingtp_{0}",biaoqian))
item:SetChildText(_itemCmp.nd,sceneName)
if tansuo_ing then
local march=xianjieModel:getResPointMarch(data.rpGuid)
if march then
local discipleList=march:getMarchData('dDiscipleList')
for i,v in ipairs(discipleList)do
if mathHelper.validInt64(v)and UIDiscipleModel:getDiscipleData(v)~=nil then
comHelper.setChildModelRawImage(item,v,_itemCmp.tou,0,eHeadCenterType.eHead,0.7)
return
end
end
end
end
end

function UIXianJieExplorationMysteryWin:onClickItem(index)
local data=self.datas[index]
local ent_key=data.ent_key
if ent_key then
local ent=xianjieController:getEntity(ent_key)
if ent then
ent:onClick()
end
end
end

function UIXianJieExplorationMysteryWin.onXianJieResPointDataChange(etype,guid,isInit)
if etype~=xjResPointChangeEventType.eUpdate and not isInit then
_this:refreshView()
end
end


function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:RefreshCell(dataIndex,cellIndex,item)
self.window:refreshItem(item,dataIndex)
end

function UIPrepareEnScroller:onItemClick(data,cellIndex,dataIndex,cell,exchangeIndex,withoutEnt)
self.window:onClickItem(dataIndex+1)
end