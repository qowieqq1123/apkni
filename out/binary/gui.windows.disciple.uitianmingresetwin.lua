







def_class("UITianMingResetWin",UIWindowBase)









function UITianMingResetWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.ResetBtn=UIButton.get(self,3)
self.tianmingItem=UIObject.get(self,4)
self.oldAttrScrollView=UIObject.get(self,5)
self.newAttrScrollView=UIObject.get(self,6)
self.Empty=UIObject.get(self,7)
self.ItemRoot=UIObject.get(self,8)
self.ResetAgainBtn=UIButton.get(self,9)
self.ConfirmBtn=UIButton.get(self,10)
self.helpBtn=UIButton.get(self,11)
self.effect=UIObject.get(self,12)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.ResetBtn:setButtonClick(function()self:onResetBtn()end)

self.ResetAgainBtn:setButtonClick(function()self:onResetAgainBtn()end)

self.ConfirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)



end


function UITianMingResetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.ResetBtn);self.ResetBtn=nil;
_UIObject_release(self.tianmingItem);self.tianmingItem=nil;
_UIObject_release(self.oldAttrScrollView);self.oldAttrScrollView=nil;
_UIObject_release(self.newAttrScrollView);self.newAttrScrollView=nil;
_UIObject_release(self.Empty);self.Empty=nil;
_UIObject_release(self.ItemRoot);self.ItemRoot=nil;
_UIObject_release(self.ResetAgainBtn);self.ResetAgainBtn=nil;
_UIObject_release(self.ConfirmBtn);self.ConfirmBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.effect);self.effect=nil;
end



















local this
local itemIndex=
{
name=0,
desc=1,
icon=2,
icon_new=3,
tran=4,
descText=5,
}

local abname=globalABLookup.diciplecolorframe


function UITianMingResetWin:onLoaded(...)
self:bindComponents()
this=self
end


function UITianMingResetWin:__delete()
self:unbindComponents()
self:clearData()
this=nil
end




function UITianMingResetWin:onShow(argtable,afterOnloaded)
if argtable then
self.discipleGuid=argtable.discipleGuid
end

self.bgModel:setChildUIModelShowTarget(5396,1,{},eAnimationID.enter,false,
false,0)
self:delayDo(0.4,function()
self.root:setChildCanvasGroupDOFade(1,0.6,nil)
end)

self:refreshData()
self:refreshOldScrollview()
self:refreshNewScrollview()
self:refreshItemBase()
self:refreshBtn()
end

function UITianMingResetWin:refreshRecv()
self:refreshData()
self:refreshOldScrollview()
self:refreshNewScrollview()
self:letItemHide()
self:playEffect()
self:delayDo(0.1,function()self:moveItemSkip()end)
self:refreshItemBase()
self:refreshBtn()
end

function UITianMingResetWin:confirmRecv()
self:refreshData()
self:refreshOldScrollview()
self:refreshNewScrollview()
self:refreshItemBase()
self:refreshBtn()
self:onCloseBtn()
UIManager.info("弟子天命重归成功")
end


function UITianMingResetWin:refreshData()
self.config=cfg_discipletianmingconfig()
if self.config then
if self.config.const_def then
self.rerand=self.config.const_def.rerand
end
end

local netData=UIDiscipleModel:getDiscipleData(self.discipleGuid)
if netData then
self.oldData=netData.tmList
if netData.randlistlen>0 and netData.randtmList then
if not UIDiscipleModel:getIsUseRandtmList()then
self.newData=netData.randtmList
end
end
end

netData=UIDiscipleModel:getDiscipleTMResetList(self.discipleGuid)
if netData then self.newData=netData end

if self.oldData then
self.flagList={}
for k,v in ipairs(self.oldData)do
self.flagList[tostring(v)]=true
end
end


end

function UITianMingResetWin:clearData()
self.config=nil
self.oldData=nil
self.newData=nil
self.rerand=nil
self.discipleGuid=nil
end


function UITianMingResetWin:refreshBtn()
local flag=self.newData~=nil
self.ResetBtn:setActive(not flag)
self.ConfirmBtn:setActive(flag)
self.ResetAgainBtn:setActive(flag)
end


function UITianMingResetWin:refreshItemBase()
local widght=self.ItemRoot:getWidgetBase()
local datas=self.rerand[1][1]
local itemid=datas[1]
local useCount=datas[2]
local itemcount=itemsModel.getCount(itemid)

local countStr=''
local color="#F9F9F9"
local showCountBG=false
showCountBG=true
if itemcount<=0 then color="red"end
countStr=string.format('<color=%s>%s/%s</color>',color,mathHelper.formatNumber(itemcount),useCount)

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widght:SetChildPropData(0,prop)
widght:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end


function UITianMingResetWin:refreshOldScrollview()
local len=3
self.oldAttrScrollView:setChildScrollViewCreateGrids(len,1)
local grids=self.oldAttrScrollView:getChildScrollViewItemWidgets()

for i=1,len do
local widget=grids[i-1]
local id=self.oldData[i]
local data=self.config[id]
local name=data.name
local desc=data.desc[0]
local name_str=UIDiscipleModel.getTianMingName(name)
local icon_str=string.format("icon_dztianminggh_%s",i)
local descTextStr=comHelper.getCheckLayoutStr(widget:GetChildGameObject(itemIndex.descText),434,desc,true)

widget:SetChildText(itemIndex.name,name_str)
widget:SetChildText(itemIndex.desc,descTextStr)
widget:SetChildCSImageSprite(itemIndex.icon,abname,icon_str)
end
end


function UITianMingResetWin:refreshNewScrollview()
if not self.newData then
self.newAttrScrollView:setActive(false)
self.Empty:setActive(true)
return
end
self:delayDo(0.2,function()
self.Empty:setActive(false)
self.newAttrScrollView:setActive(true)
end)

local len=3
self.newAttrScrollView:setChildScrollViewCreateGrids(len,1)
local grids=self.newAttrScrollView:getChildScrollViewItemWidgets()

for i=1,len do
local widget=grids[i-1]
local id=self.newData[i]
local data=self.config[id]
local name=data.name
local desc=data.desc[0]
local name_str=UIDiscipleModel.getTianMingName(name)
local icon_str=string.format("icon_dztianminggh_%s",i)

if not self.flagList[tostring(id)]then
name_str=string.format('<color=#F1B964>%s</color>',name_str)
desc=string.format('<color=#F1B964>%s</color>',desc)
end
local descTextStr=comHelper.getCheckLayoutStr(widget:GetChildGameObject(itemIndex.descText),434,desc,true)
widget:SetChildText(itemIndex.name,name_str)
widget:SetChildText(itemIndex.desc,descTextStr)
widget:SetChildCSImageSprite(itemIndex.icon,abname,icon_str)
widget:SetChildActive(itemIndex.icon_new,not self.flagList[tostring(id)])
end
end


function UITianMingResetWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid})
end

function UITianMingResetWin:playEffect()
self.effect:setChildShowEffect(20239,true)
end

function UITianMingResetWin:letItemHide()
local x=-735
local grids=this.newAttrScrollView:getChildScrollViewItemWidgets()
local len=grids.Count

if len>0 then
for i=1,len do
local widget=grids[i-1]
local tweener=widget:SetChildDOAnchorPosX(itemIndex.tran,x,0.1,nil)
tweener:SetEase(_Ease.Linear)
end
end
end

function UITianMingResetWin:moveItemSkip()
local x=-245
local grids=self.newAttrScrollView:getChildScrollViewItemWidgets()
local len=grids.Count
if len>0 then
local i=1
local widget=grids[i-1]

local fun1=function()
local tweener=widget:SetChildDOAnchorPosX(itemIndex.tran,x,0.2,nil)
tweener:SetEase(_Ease.Linear)
end
local fun2=function()
i=2
widget=grids[i-1]
local tweener=widget:SetChildDOAnchorPosX(itemIndex.tran,x,0.2,nil)
tweener:SetEase(_Ease.Linear)
end
local fun3=function()
i=3
widget=grids[i-1]
local tweener=widget:SetChildDOAnchorPosX(itemIndex.tran,x,0.2,nil)
tweener:SetEase(_Ease.Linear)
end
self:delayDo(0.1,fun1)
self:delayDo(0.4,fun2)
self:delayDo(0.7,fun3)
end
end

function UITianMingResetWin:checkIsEnoughCost()
local datas=self.rerand[1][1]
local itemid=datas[1]
local itemcount=datas[2]
local haveCount=itemsModel.getCount(itemid)

if haveCount>=itemcount then
return true
else
gainControl:showGainWin(itemid)
return false
end
end


function UITianMingResetWin:onHide()

end




function UITianMingResetWin:onCloseBtn()
self:closeSelf()
end


function UITianMingResetWin:onResetBtn()
if self:checkIsEnoughCost()then
local datas=self.rerand[1][1]
local itemid=datas[1]
local itemName=itemsModel.getName(itemid)
local ignoreDialouge=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eTMResetFirst)
local contentStr=FMT.fmt('是否消耗<color=#CA631D>{0}</color>进行天命重归？',itemName)

if ignoreDialouge then
UIDiscipleController:reqTianMingReset(self.discipleGuid,0)
else
local okcallback=function(...)
UIDiscipleController:reqTianMingReset(self.discipleGuid,0)
end
UIDialogManager.getConfirmDialog3(nil,contentStr,okcallback,REPEAT_TYPE.eTMResetFirst)
end
end
end


function UITianMingResetWin:onResetAgainBtn()
if self.reqAgain then return end
local ignoreDialouge=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eTMReset)
local contentStr=FMT.fmt('有新的天命效果尚未应用,是否确认再\n次重归?')

if self.newData then
if ignoreDialouge then
if self:checkIsEnoughCost()then
self.reqAgain=true
self:delayDo(1.2,function()
self.reqAgain=false
end)
UIDiscipleController:reqTianMingReset(self.discipleGuid,1)
end
else
local okcallback=function(...)
if self:checkIsEnoughCost()then
self.reqAgain=true
self:delayDo(1.2,function()
self.reqAgain=false
end)
UIDiscipleController:reqTianMingReset(self.discipleGuid,1)
end
end
UIDialogManager.getConfirmDialog3(nil,contentStr,okcallback,REPEAT_TYPE.eTMReset)
end
else
if self:checkIsEnoughCost()then
self.reqAgain=true
self:delayDo(1.2,function()
self.reqAgain=false
end)
UIDiscipleController:reqTianMingReset(self.discipleGuid,1)
end
end
end


function UITianMingResetWin:onConfirmBtn()
local ignoreDialouge=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eLogin,REPEAT_TYPE.eTMResetUse)
local contentStr=FMT.fmt('是否应用新的天命效果?')

if ignoreDialouge then
UIDiscipleController:reqTianMingResetconfirm(self.discipleGuid)
else
local okcallback=function(...)
UIDiscipleController:reqTianMingResetconfirm(self.discipleGuid)
end
UIDialogManager.getConfirmDialog3(nil,contentStr,okcallback,REPEAT_TYPE.eTMResetUse)
end
end


function UITianMingResetWin:onHelpBtn()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='ui_tmcg_help_%s'})
end