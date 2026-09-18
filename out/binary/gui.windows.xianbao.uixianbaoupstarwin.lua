







def_class("UIXianBaoUpStarWin",UIWindowBase)









function UIXianBaoUpStarWin:bindComponents()

self.dzbg=UIImage.get(self,0)
self.dzhead=UIObject.get(self,1)
self.dzname=UIText.get(self,2)
self.starItem=UIBaseItem.get(self,3)
self.titleName=UIImage.get(self,4)
self.starAttr_1=UIObject.get(self,5)
self.starAttr_2=UIObject.get(self,6)
self.star=UIObject.get(self,7)
self.jlTile=UIText.get(self,8)
self.btnJinglian=UIButton.get(self,9)
self.btnTuPo=UIButton.get(self,10)
self.jlItemCreater=UIObject.get(self,11)
self.jlCostTitle=UIText.get(self,12)
self.jldesc=UIText.get(self,13)
self.jlTab=UIObject.get(self,14)
self.starTab=UIObject.get(self,15)
self.jlAttr4=UIObject.get(self,16)
self.jlAttr2=UIObject.get(self,17)
self.jlAttr1=UIObject.get(self,18)
self.jlAttr3=UIObject.get(self,19)
self.model=UIObject.get(self,20)
self.dizi=UIButton.get(self,21)
self.modelClick=UIButton.get(self,22)
self.chongzhi=UIButton.get(self,23)
self.starItemCreater=UIObject.get(self,24)
self.starTitle=UIText.get(self,25)
self.stardesc=UIText.get(self,26)
self.btnStar=UIButton.get(self,27)
self.starCostTitle=UIText.get(self,28)
self.skill_2=UIObject.get(self,29)
self.skill_3=UIObject.get(self,30)
self.skill_1=UIObject.get(self,31)
self.tupo=UIText.get(self,32)
self.starSkill2=UIObject.get(self,33)
self.starSkill3=UIObject.get(self,34)
self.starSkill1=UIObject.get(self,35)
self.starPanel=UIObject.get(self,36)
self.jinglianPanel=UIObject.get(self,37)
self.ScrollView=UIScrollViewSlow.get(self,38)
self.shentongicon=UIButton.get(self,39)
self.Content=UIObject.get(self,40)
self.liandonBtn=UIButton.get(self,41)
self.starAttr_3=UIObject.get(self,42)
self.btnStarreddot=UIObject.get(self,43)
self.leftarrow=UIObject.get(self,44)
self.rightarrow=UIObject.get(self,45)

self.btnJinglian:setButtonClick(function()self:onBtnJinglian()end)

self.btnTuPo:setButtonClick(function()self:onBtnTuPo()end)

self.dizi:setButtonClick(function()self:onDizi()end)

self.modelClick:setButtonClick(function()self:onModelClick()end)

self.chongzhi:setButtonClick(function()self:onChongzhi()end)

self.btnStar:setButtonClick(function()self:onBtnStar()end)

self.shentongicon:setButtonClick(function()self:onShentongicon()end)

self.liandonBtn:setButtonClick(function()self:onLiandonBtn()end)
self.starAttr={
self.starAttr_1,
self.starAttr_2,
self.starAttr_3,
}
self.skill={
self.skill_1,
self.skill_2,
self.skill_3,
}



end


function UIXianBaoUpStarWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dzbg);self.dzbg=nil;
_UIObject_release(self.dzhead);self.dzhead=nil;
_UIObject_release(self.dzname);self.dzname=nil;
_UIObject_release(self.starItem);self.starItem=nil;
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.starAttr_1);self.starAttr_1=nil;
_UIObject_release(self.starAttr_2);self.starAttr_2=nil;
_UIObject_release(self.star);self.star=nil;
_UIObject_release(self.jlTile);self.jlTile=nil;
_UIObject_release(self.btnJinglian);self.btnJinglian=nil;
_UIObject_release(self.btnTuPo);self.btnTuPo=nil;
_UIObject_release(self.jlItemCreater);self.jlItemCreater=nil;
_UIObject_release(self.jlCostTitle);self.jlCostTitle=nil;
_UIObject_release(self.jldesc);self.jldesc=nil;
_UIObject_release(self.jlTab);self.jlTab=nil;
_UIObject_release(self.starTab);self.starTab=nil;
_UIObject_release(self.jlAttr4);self.jlAttr4=nil;
_UIObject_release(self.jlAttr2);self.jlAttr2=nil;
_UIObject_release(self.jlAttr1);self.jlAttr1=nil;
_UIObject_release(self.jlAttr3);self.jlAttr3=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.dizi);self.dizi=nil;
_UIObject_release(self.modelClick);self.modelClick=nil;
_UIObject_release(self.chongzhi);self.chongzhi=nil;
_UIObject_release(self.starItemCreater);self.starItemCreater=nil;
_UIObject_release(self.starTitle);self.starTitle=nil;
_UIObject_release(self.stardesc);self.stardesc=nil;
_UIObject_release(self.btnStar);self.btnStar=nil;
_UIObject_release(self.starCostTitle);self.starCostTitle=nil;
_UIObject_release(self.skill_2);self.skill_2=nil;
_UIObject_release(self.skill_3);self.skill_3=nil;
_UIObject_release(self.skill_1);self.skill_1=nil;
_UIObject_release(self.tupo);self.tupo=nil;
_UIObject_release(self.starSkill2);self.starSkill2=nil;
_UIObject_release(self.starSkill3);self.starSkill3=nil;
_UIObject_release(self.starSkill1);self.starSkill1=nil;
_UIObject_release(self.starPanel);self.starPanel=nil;
_UIObject_release(self.jinglianPanel);self.jinglianPanel=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.shentongicon);self.shentongicon=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.liandonBtn);self.liandonBtn=nil;
_UIObject_release(self.starAttr_3);self.starAttr_3=nil;
_UIObject_release(self.btnStarreddot);self.btnStarreddot=nil;
_UIObject_release(self.leftarrow);self.leftarrow=nil;
_UIObject_release(self.rightarrow);self.rightarrow=nil;
self.starAttr=nil;
self.skill=nil;
end


















local _row=1
local _menu_slot_name='button_dytab'
local _sortKey='daobingsortkey'
local _orderKey='daobingorderkey'

function UIXianBaoUpStarWin:onLoaded(...)
self:bindComponents()
self.ScrollView:setSlowClickAction(function(...)self:onClickGrid(...)end)
self.ScrollView:bindSlowWidget(function(...)
self:bindGrid(...)
end)

self:addNotify(notifyConfig.on_item_list_changed,function(...)self:onItemsChanged(...)end)
self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChanged(...)end)

self.needFocus=true
end

function UIXianBaoUpStarWin:__delete()
self:unbindComponents()
UIManager:hideWindow('UITopMoneyWin2')
end

function UIXianBaoUpStarWin:onShow(argtable,afterOnloaded)
self.leftarrow:setActive(false)
self.rightarrow:setActive(false)
local tabType=argtable and argtable.tabType or SEC_FULL_TAB_TYPE.xianbaoUpStar
self:initBagList(tabType)
local xbid=argtable and argtable.xbid or self.bagList[1]
self.tabType=tabType
self.xbid=xbid
self:freshInfo()
end

function UIXianBaoUpStarWin:initBagList(tabType)
local bagList=xianbaoModel:getUpStarList()
self.bagList=bagList
end

function UIXianBaoUpStarWin:onHide()

end

function UIXianBaoUpStarWin:onClickGrid(id,index,xbid,attach)

if self.xbid==id then return end
if not self:onSelectItem(id)then return end
if self.lastxbIndex then
self.ScrollView:freshSlowItem(self.lastxbIndex)
end
self.ScrollView:freshSlowItem(index)
self.lastxbIndex=index
self:freshBtnReddot()
end

function UIXianBaoUpStarWin:bindGrid(index,widget)
local xbId=self.bagList[index]
local xbCfg=xianbaoConfig.getXBCfg(xbId)
local isSelect=self.xbid==xbId
if isSelect then
self.lastxbIndex=index
end
local isEquiped=false
local starlv=0
local isLD=false
widget:SetChildQulaity(0,xbCfg.color)
widget:SetChildIcon(1,xianbaoConfig.getXianBaoIconName(xbId),false)
widget:SetChildActive(2,false)
widget:SetChildText(3,"")
widget:SetChildActive(4,isSelect)
widget:SetChildActive(5,isEquiped)
widget:SetChildStarNumber(6,starlv)
widget:SetChildActive(7,isLD)
widget:SetBaseItemChildID(-1,xbId)
widget:SetBaseItemChildGUID(-1,xbId)
if self.needFocus and isSelect then
self.needFocus=nil
self.ScrollView:jumpToSlowItem(index)
end
end

function UIXianBaoUpStarWin:onMoneyChanged(moneytype)






end

function UIXianBaoUpStarWin:onItemsChanged(argsTable)

self:freshBtnReddot()
self:freshRightPanel()
end

function UIXianBaoUpStarWin:freshBtns()
self.jlTab:setActive(false)
local tabType=SEC_FULL_TAB_TYPE.xianbaoUpStar
local vis=true
self.starTab:setActive(vis)
if vis then
local widget2=self.starTab:getChildWidgetBase()
local func=function()
widget2:SetChildUIModelShowSlotAttachment(0,_menu_slot_name,self.tabType==SEC_FULL_TAB_TYPE.xianbaoUpStar and'button_dytab_2'or'button_dytab_1')
end
local ret=xianbaoModel:checkUpStar(self.xbid)
widget2:SetChildUIModelShowTarget(0,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)
widget2:SetChildText(1,'升星')
widget2:SetChildActive(2,ret)
widget2:SetChildButtonClick(3,function()
self:onSelectTab(SEC_FULL_TAB_TYPE.xianbaoUpStar)
end,true)
end
end

function UIXianBaoUpStarWin:freshLeftPanel()


local rNum=#self.bagList

self.ScrollView:clearSlowItems()
self.ScrollView:freshSlowGrids(rNum,_row,rNum,true)
end


function UIXianBaoUpStarWin:onSelectTab(tabType)
if tabType==self.tabType then return end
self.tabType=tabType
local money=tabScreenConfig.getTabMoneyByConfig(self.tabType)
if money then
UIManager:showWindow('UITopMoneyWin2',money)
end
self:freshTabBtns()
self:freshRightPanel()
self:freshBtnReddot()
end

function UIXianBaoUpStarWin:freshMidPanel()
local xbid=self.xbid
local xbCfg=xianbaoConfig.getXBCfg(xbid)
local modelParams=xbCfg.model
local isMaxStar=xianbaoModel:checkIsMaxStar(xbid)
local isLD=false
self.liandonBtn:setActive(isLD)


self.titleName:setChildIcon(xbCfg.titleName,true)
local effectInfo=isMaxStar and modelParams[2]or modelParams[1]
self.model:setChildShowEffect(effectInfo[1],true)
self.dizi:setActive(false)

local len=#self.skill
for i=1,len do
local item=self.skill[i]
item:setActive(false)
end
end

function UIXianBaoUpStarWin:freshTabBtns()
local isSelect=self.tabType==SEC_FULL_TAB_TYPE.xianbaoUpStar
local widget=self.starTab:getChildWidgetBase()
if isSelect then
widget:SetChildModelAnimationState(0,eAnimationID.common_window_dianji)
end
widget:SetChildUIModelShowSlotAttachment(0,_menu_slot_name,isSelect and'button_dytab_2'or'button_dytab_1')
end


function UIXianBaoUpStarWin:onSelectItem(xbid)
if xbid==self.xbid then return end
self.xbid=xbid
self:freshMidPanel()
self:freshRightPanel()
return true
end


function UIXianBaoUpStarWin:freshBtnReddot()
local widget=self.starTab:getChildWidgetBase()
local ret=xianbaoModel:checkUpStar(self.xbid)
widget:SetChildActive(2,ret)
end






function UIXianBaoUpStarWin:onBtnTuPo()

end



function UIXianBaoUpStarWin:onBtnJinglian()

end



function UIXianBaoUpStarWin:onBtnStar()
local flag,itemId=xianbaoModel:checkUpStar(self.xbid)
if flag then
xianbaoController.req_16_33(self.xbid)
else
gainControl:showGainWin(itemId)
end
end

function UIXianBaoUpStarWin:onModelClick()
tipsManager.showTipsXB({formType=TIPS_FORM_TYPE.eXianBaoUpStar,tipsType=TIPS_TYPE.eCommonXianBao,itemid=self.xbid,bg=false,funType=TIPS_FUNC_TYPE.eXianBao})
end

function UIXianBaoUpStarWin:onShentongicon()
end

function UIXianBaoUpStarWin:onLiandonBtn()
end

function UIXianBaoUpStarWin:onSelectBenti()
end

function UIXianBaoUpStarWin:onDizi()
end

function UIXianBaoUpStarWin:freshInfo()
local money=tabScreenConfig.getTabMoneyByConfig(self.tabType)
if money then
UIManager:showWindow('UITopMoneyWin2',money)
end
self:freshBtns()
self:freshLeftPanel()
self:freshMidPanel()
self:freshRightPanel()
end

function UIXianBaoUpStarWin:freshRightPanel()
local visJinglian=false
local visStar=self.tabType==SEC_FULL_TAB_TYPE.xianbaoUpStar
self.jinglianPanel:setActive(visJinglian)
self.starPanel:setActive(visStar)
if visJinglian then
self:freshJinglianPanel()
end
if visStar then
self:freshStarPanel()
end

self.chongzhi:setActive(false)
end

function UIXianBaoUpStarWin:freshJinglianPanel()
end


function UIXianBaoUpStarWin:freshStarPanel()
local xbid=self.xbid
local xbCfg=xianbaoConfig.getXBCfg(xbid)
local maxlv=xianbaoConfig.getXBMaxStar(xbid)
local starlv=xianbaoModel:getXbStart(xbid)
local isMax=maxlv==starlv
local starXbCfg=xianbaoConfig.getXBStarCfg(xbid,starlv)

local widget=self.star:getChildWidgetBase()
widget:SetChildText(0,'星级：')
local len=isMax and starlv or starlv+1
widget:SetChildLayoutGroupCreateItems(1,len,function(idx)
local starItem=widget:GetChildLayoutGroupGridItem(1,idx-1)
starItem:SetChildActive(0,isMax or idx~=len)
end)

widget:SetChildActive(2,not isMax)
if not isMax then
widget:SetChildLayoutGroupCreateItems(3,len,function(idx)
local starItem=widget:GetChildLayoutGroupGridItem(3,idx-1)
starItem:SetChildActive(0,true)
end)
end
local curAttrs=starXbCfg.attrs

for i,v in ipairs(self.starAttr)do
local attr=curAttrs[i]
if attr then
local attrType=attr[1]
local attrValue=attr[2]
v:setActive(true)
local widget=v:getChildWidgetBase()
widget:SetChildText(0,FMT.fmt("{0}:",helper.getAttributeName(attrType)))
widget:SetChildText(1,helper.getAttributeStrEx(attrType,attrValue))
if isMax then
widget:SetChildActive(2,false)
else
local nextstarXbCfg=xianbaoConfig.getXBStarCfg(xbid,starlv+1)
local nextAttrs=nextstarXbCfg.attrs
local nextattr=nextAttrs[i]
if nextattr and nextattr[1]==attrType then
widget:SetChildActive(2,true)
widget:SetChildText(3,helper.getAttributeStrEx(nextattr[1],nextattr[2]))
else
widget:SetChildActive(2,false)
end
end
else
v:setActive(false)
end

end



self.shentongicon:setChildIcon(xbCfg.upStarIcon,false)

self.starSkill1:setActive(false)
self.starSkill2:setActive(true)
self.starSkill3:setActive(false)


local widget=self.starSkill2:getChildWidgetBase()
local upStarEffectDec=starXbCfg.upStarEffectDec
widget:SetChildText(0,upStarEffectDec[1])
widget:SetChildText(1,upStarEffectDec[2])
widget:SetChildActive(2,upStarEffectDec[3]~=nil)
if upStarEffectDec[3]~=nil then
widget:SetChildText(3,upStarEffectDec[3])
end

if isMax then
self.starItemCreater:setChildLayoutGroupClearAllItems()

self.starTitle:setText('升星已满级')
self.btnStar:setActive(false)
else
local nextstarXbCfg=xianbaoConfig.getXBStarCfg(xbid,starlv+1)
local costList=nextstarXbCfg.up_star_cost or{}
local len=#costList
self.starItemCreater:setChildLayoutGroupCreateItems(len)
local grids=self.starItemCreater:getChildLayoutGroupGridList()
for i=1,len do
local cost=costList[i]
local itemid=cost[1]
local count=cost[2]
local countStr=UIDanYaoModel:getItemCountStr(itemid,count)
local item=grids[i-1]
local conf={itemid=itemid,itemcount=countStr,showCountBG=true,showname=false,showStage=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(0,prop)
end


self.starTitle:setText('')
self.btnStar:setActive(true)
local reddot=xianbaoModel:checkUpStar(xbid)
self.btnStar:setGray(not reddot)
self.btnStarreddot:setGray(not reddot)
self.btnStarreddot:setActive(reddot)
end
end


function UIXianBaoUpStarWin:onStarRet(xbid,oldlv,newlv)
if self.tabType~=SEC_FULL_TAB_TYPE.xianbaoUpStar then return end
if xbid~=self.xbid then return end
self:freshRightPanel()
self:freshBtnReddot()
self.needFocus=true
self:freshLeftPanel()
if xianbaoModel:checkIsMaxStar(xbid)then
self:freshMidPanel()
end
end

function UIXianBaoUpStarWin:onChongzhi()
end

function UIXianBaoUpStarWin:onScrollChange()










local scrollW=self.ScrollView:getChildSizeDeltaX()
local contentW=self.Content:getChildSizeDeltaX()
local contentX=self.Content:getChildAnchoredPosition().x
local itemoffest=82
local showLen=4
if#self.bagList<=showLen then
return
end
if contentX<-itemoffest then
self.leftarrow:setActive(true)
else
self.leftarrow:setActive(false)
end
local moveX=math.abs(contentX)
if(math.abs(contentW)-math.abs(contentX))>(math.abs(scrollW)+itemoffest)then
self.rightarrow:setActive(true)
else
self.rightarrow:setActive(false)
end
end
