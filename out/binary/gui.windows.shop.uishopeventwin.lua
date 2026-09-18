







def_class("UIShopEventWin",UIWindowBase)









function UIShopEventWin:bindComponents()

self.guizi=UIObject.get(self,0)
self.dizi=UIObject.get(self,1)
self.zuozi=UIObject.get(self,2)
self.rwPanel=UIObject.get(self,3)
self.click=UIButton.get(self,4)
self.title=UIText.get(self,5)
self.desc=UILinkImageText.get(self,6)
self.scrollview=UIObject.get(self,7)
self.rewardText=UIText.get(self,8)
self.showBtn=UIButton.get(self,9)
self.skillExpPanel=UIObject.get(self,10)
self.showBtnText=UIText.get(self,11)
self.moneyItems=UIObject.get(self,12)

self.click:setButtonClick(function()self:onClick()end)

self.showBtn:setButtonClick(function()self:onShowBtn()end)



end


function UIShopEventWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.guizi);self.guizi=nil;
_UIObject_release(self.dizi);self.dizi=nil;
_UIObject_release(self.zuozi);self.zuozi=nil;
_UIObject_release(self.rwPanel);self.rwPanel=nil;
_UIObject_release(self.click);self.click=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.rewardText);self.rewardText=nil;
_UIObject_release(self.showBtn);self.showBtn=nil;
_UIObject_release(self.skillExpPanel);self.skillExpPanel=nil;
_UIObject_release(self.showBtnText);self.showBtnText=nil;
_UIObject_release(self.moneyItems);self.moneyItems=nil;
end



















function UIShopEventWin:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIShopEventWin:__delete()
self:unbindComponents()
end

function UIShopEventWin:getParam(params)
local level=zongmenModel:getLevel()
for i,v in ipairs(params)do
if level>=v[1]and level<=v[2]then
return v[3]
end
end
return params[#params][3]
end

function UIShopEventWin:getEffectData(pdata,effect)
for i,v in ipairs(pdata)do
if v[1]==effect then
return v
end
end
return pdata[1]
end

function UIShopEventWin:getEffectDataChange(pdata,effect)
for i,v in ipairs(pdata)do
if v[1]==effect then
table.remove(pdata,i)
return v
end
end
return pdata[1]
end




function UIShopEventWin:onShow(argtable,afterOnloaded)
local ubdId=argtable[1]
local eventId=argtable[2]

local effectList=argtable[4]

local cfg=cfgHelper.get1(cfg_shangpueventconfig_get,eventId)
self.title:setText(cfg.title)
self.desc:setText(cfg.desc)



local data=zongmenModel:getBuildingData(ubdId)
if tostring(data.dizi_id)~='0'then
local info=UIDiscipleModel:getDiscipleInsideModelInfo(data.dizi_id)
local scale=isometricMapSystem:getModelScale(info.body,true)
self.dizi:setChildUIModelShowTarget(info.body,scale,info.componets,eAnimationID.stand)
end




self.checkList={}
for i,v in ipairs(effectList)do
self.checkList[v.effect]=true
end

self.moneyItems:setActive(self.checkList[1]or self.checkList[2])
self.rewardText:setActive(self.checkList[3]or self.checkList[7])

self.showBtn:setActive(self.checkList[4]or self.checkList[5])
self.skillExpPanel:setActive(self.checkList[6])
self.click:setActive(self.checkList[4])

self.moneyItems:setChildLayoutGroupCreateItems(1)
self.moneyItems:setChildLayoutGroupRemoveItem()
local size=self.moneyItems:getCommonComponent('RectTransform').sizeDelta

local funparam=self:getParam(cfg.funparam)
local copyParams={}
for i,v in ipairs(funparam)do
table.insert(copyParams,v)
end

for i,v in ipairs(effectList)do
local etype=v.effect
local param1=v.param_1
if etype==1 or etype==2 then
local height=i*size.y+(i-1)*-12
self.moneyItems:setChildSizeDelta(size.x,height)
local edata=UIShopEventWin:getEffectDataChange(copyParams,etype)
local mId=edata[2]
local name=moneyModel.getMoneyName(mId)
local color=etype==1 and'#549327'or'#c82c2c'
local val=param1
self.moneyItems:setChildLayoutGroupAddItem()
local grids=self.moneyItems:getChildLayoutGroupGridList()
local item=self.moneyItems:getChildLayoutGroupGridItem(grids.Count-1)
if item then
item:SetChildIcon(0,iconHelper.getIconName(mId),false)
item:SetChildText(1,FMT.fmt('{0} <color={3}>{1}{2}</color>',name,etype==1 and'+'or'-',val,color))
end
elseif etype==3 then
self.rewardText:setText(string.format('获得效果：%s',homeBuffModel:getBuffDescByStateId(param1)))
elseif etype==4 then
self.showBtnText:setText('收下奖励')
self.paramList=v.paramList
self.etype=etype
elseif etype==5 then
self.showBtnText:setText('前往捉拿')
self.paramList=v.paramList
self.etype=etype
local mdata=v.paramList[1]

self.target=isometricMapSystem:getSundriesDataByServerGuid(mdata.param_2)
_MapManager.SetTilemapObjectActive(self.target.guid,false)
elseif etype==6 then
local edata=self:getEffectData(funparam,etype)
local sktype=edata[2]
local netData=UIDiscipleModel:getDiscipleData(data.dizi_id)
local proskilllist=netData.proskillList
local d=proskilllist[sktype]
local explist=cfgHelper.getdef1(cfg_discipleproskillconfig,'exp')
local curexp=d.exp
local maxexp=explist[d.level]
local panel=self.skillExpPanel:getChildWidgetBase()
local name=UIDiscipleModel:getDiscipleName(data.dizi_id)
panel:SetChildText(0,FMT.fmt('执事弟子：<color=#171311>{0}</color>',name))
local skname=cfgHelper.get2(cfg_discipleproskillconfig_get,sktype,'name')
panel:SetChildText(1,FMT.fmt('{0}：',skname))
panel:SetChildUIProgressbar(2,curexp,maxexp)
panel:SetChildText(3,string.format('+%s',param1))
elseif etype==7 then
self.rewardText:setText('牢狱俘虏+1')
end
end

self:playAnimation()

self.target=argtable.target
end

function UIShopEventWin:playAnimation()
self.guizi:setScale(Vector3.New(0,0,1))
self.zuozi:setScale(Vector3.New(0,0,1))
self.rwPanel:setScale(Vector3.New(0,0,1))
self.dizi:setChildAnchoredPosition(Vector2.New(100,45))
self.dizi:setChildCanvasGroupAlpha(0)

local tweener=self.zuozi:setChildDOScale(1,0.25,nil)
tweener:SetEase(_Ease.OutBack)

tweener=self.dizi:setChildDOAnchorPosX(0,0.5)
tweener:SetEase(_Ease.Linear)
tweener=self.dizi:setChildCanvasGroupDOFade(1,0.5)
tweener:SetEase(_Ease.InQuart)

tweener=self.guizi:setChildDOScale(1,0.25,nil)
tweener:SetEase(_Ease.OutBack)
tweener:SetDelay(0.15)

tweener=self.guizi:setChildDOScale(1,0.25,nil)
tweener:SetEase(_Ease.OutBack)
tweener:SetDelay(0.15)

tweener=self.rwPanel:setChildDOScale(1,0.25,nil)
tweener:SetEase(_Ease.OutBack)
tweener:SetDelay(0.3)
end


function UIShopEventWin:onHide()

end




function UIShopEventWin:onShowBtn()
if self.etype==5 then
local pos=self.paramList[1]
local mapId=zongmenModel:getMountainId()
local wp=_MapManager.GetCellCenterWorld(mapId,_MapManager.ToVector3Int(pos.param_1,pos.param_2,0),mapLayer.Data)
local target=self.target
isometricMapSystem:moveCameraToPosition(wp,true,function()
_MapManager.SetTilemapObjectActive(target.guid,true)
_MapManager.PlayEffect(target.guid,20006,Vector3.New(0,0,0),true,true)
end)
self:onCloseClick()
elseif self.etype==4 then
self.showBtn:setActive(false)
self.scrollview:setActive(true)
self.scrollview:setChildScrollViewCreateGrids(#self.paramList,#self.paramList)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local rd=self.paramList[i+1]
local item=grids[i]
local itemid=rd.param_1
widgetHelper.setNormalRewardItem(item,0,{rd.param_1,rd.param_2})

local colorName=itemsConfig.getColorName(itemid)
local color=itemsConfig.getConfig(itemid).color
local itemCount=rd.param_2 or 1
UIManager.rewardInfo(nil,FMT.fmt('{0}<color={1}>X{2}</color>',colorName,FONT_COLOR_VAL[color],itemCount))
end
end
end

function UIShopEventWin:onClick()
self.click:setActive(false)
self:onShowBtn()
end

function UIShopEventWin:onCloseClick()
self:closeSelf()
end
