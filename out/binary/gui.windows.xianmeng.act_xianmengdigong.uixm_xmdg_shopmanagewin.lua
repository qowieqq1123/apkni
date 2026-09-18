







def_class("UIXM_XMDG_ShopManageWin",UIWindowBase)









function UIXM_XMDG_ShopManageWin:bindComponents()

self.btnClose=UIButton.get(self,0)
self.cancelBtn=UIButton.get(self,1)
self.manageContent=UIEnhancedScrollerLua.get(self,2)
self.okBtn=UIButton.get(self,3)
self.title=UIText.get(self,4)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.okBtn:setButtonClick(function()self:onOkBtn()end)



end


function UIXM_XMDG_ShopManageWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.manageContent);self.manageContent=nil;
_UIObject_release(self.okBtn);self.okBtn=nil;
_UIObject_release(self.title);self.title=nil;
end
















local _this
local UIXM_XMDG_ShopManage_Scroller=simple_class(UIEnhancedScroller)




function UIXM_XMDG_ShopManageWin:onLoaded(...)
self:bindComponents()
_this=self

self.scrollscript=UIXM_XMDG_ShopManage_Scroller(self.manageContent:getGameObject(),self.manageContent:getCSharpObject(),nil,nil)
end


function UIXM_XMDG_ShopManageWin:__delete()
self:unbindComponents()

_this=nil
end




function UIXM_XMDG_ShopManageWin:onShow(argtable,afterOnloaded)
local reddot=userActorArraySetting.get(ACTOR_SETTING_TYPE.eOneTimeReddot,'xmdgShopManage',0)==0
if reddot then
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eOneTimeReddot,'xmdgShopManage',1,0)
reddotControl.on_change_catch_type(CATCH_TYPE.eXMDGShopManage)
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eXianMengDiGong)
end

self.manageList=xianmengdigongModel:getXMDG_shopManageList()
local limitList=xianmengdigongModel:getXMDG_shopLimitList()

self.selectCnt={}
self.selectInitCnt={}
for i,v in ipairs(self.manageList)do
local id=v.id
local max=math.abs(v.limit_num)
if limitList[id]then
self.selectCnt[id]=limitList[id].limit
else
self.selectCnt[id]=max
end
self.selectInitCnt[id]={self.selectCnt[id],max}
end

self:refresh()
end

function UIXM_XMDG_ShopManageWin:refresh()
local len=#self.manageList
local isShow=len>0

self.manageContent:setActive(isShow)

if isShow then
self.scrollscript:initData(self.manageList,110,len)
end
end


function UIXM_XMDG_ShopManageWin:onHide()

end

function UIXM_XMDG_ShopManage_Scroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIXM_XMDG_ShopManage_Scroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIXM_XMDG_ShopManage_Scroller:RefreshCell(dataIndex,cellIndex,item)
if _this==nil then return end
local cfg=_this.manageList[dataIndex]
local itemId=cfg.id
local itemConf={itemid=itemId,itemcount="",showCountBG=false,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
item:SetChildPropData(0,itemProp)
item:SetBaseItemClickEvent(0,function(id)
if _this==nil then return end
itemsComponentHelper.onItemClick(id)
end)

local max=math.abs(cfg.limit_num)
local min=1
_this.selectCnt[itemId]=_this.selectCnt[itemId]or min

local func=function(value)
_this.selectCnt[itemId]=value

item:SetChildText(3,FMT.fmt("{0}个",_this.selectCnt[itemId]))
end
item:SetChildImageRaycast(2,max>min)
item:SetChildSliderInit(1,_this.selectCnt[itemId],min,max,func)
item:SetChildSliderValue(1,_this.selectCnt[itemId])

item:SetChildButtonClick(4,function()
if _this.selectCnt[itemId]<=min then
return
end
_this.selectCnt[itemId]=_this.selectCnt[itemId]-1
item:SetChildSliderValue(1,_this.selectCnt[itemId])
end)

item:SetChildButtonClick(5,function()
if min>=max then
return
end
if _this.selectCnt[itemId]>=max then
return
end
_this.selectCnt[itemId]=_this.selectCnt[itemId]+1
item:SetChildSliderValue(1,_this.selectCnt[itemId])
end)
end





function UIXM_XMDG_ShopManageWin:onBtnClose()
self:closeSelf()
end



function UIXM_XMDG_ShopManageWin:onCancelBtn()
self:closeSelf()
end



function UIXM_XMDG_ShopManageWin:onOkBtn()
local limitList={}
for id,num in pairs(_this.selectCnt)do
local old=self.selectInitCnt[id][1]
local max=self.selectInitCnt[id][2]
if num~=old or num~=max then
table.insert(limitList,{id,num})
end
end
local len=#limitList

local contentStr='是否将执行当前仙盟物资每日\n限制兑换次数？'
local show_data={
type='UIDialouge',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
okcallback=function()
if _this==nil then return end
if lingxuwenjianModel:isLeader()then
xianmengdigongController:reqShopLimitList(len,limitList)
else
UIManager.error("只有盟主和副盟主才能设置物资管理")
end
_this:closeSelf()
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

