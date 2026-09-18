







def_class("UILingShouModelWin",UIWindowBase)









function UILingShouModelWin:bindComponents()

self.awakeBtn=UIButton.get(self,0)
self.changeNameBtn=UIButton.get(self,1)
self.liandonBtn=UIButton.get(self,2)
self.lingshoufight=UIText.get(self,3)
self.lingshouModel=UIObject.get(self,4)
self.lingshouName=UIText.get(self,5)
self.lingshouSign=UIImage.get(self,6)
self.lsDesc=UIText.get(self,7)
self.lsDescBg=UIButton.get(self,8)
self.lsDescObj=UIObject.get(self,9)
self.orderBtn=UIButton.get(self,10)
self.posFloatMark=UIObject.get(self,11)
self.root=UIObject.get(self,12)
self.shareBtn=UIButton.get(self,13)
self.ziZhiReduceStateBtn=UIButton.get(self,14)
self.czBtn=UIButton.get(self,15)

self.awakeBtn:setButtonClick(function()self:onAwakeBtn()end)

self.changeNameBtn:setButtonClick(function()self:onChangeNameBtn()end)

self.liandonBtn:setButtonClick(function()self:onLiandonBtn()end)

self.lsDescBg:setButtonClick(function()self:onLsDescBg()end)

self.orderBtn:setButtonClick(function()self:onOrderBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.ziZhiReduceStateBtn:setButtonClick(function()self:onZiZhiReduceStateBtn()end)

self.czBtn:setButtonClick(function()self:onCzBtn()end)



end


function UILingShouModelWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.awakeBtn);self.awakeBtn=nil;
_UIObject_release(self.changeNameBtn);self.changeNameBtn=nil;
_UIObject_release(self.liandonBtn);self.liandonBtn=nil;
_UIObject_release(self.lingshoufight);self.lingshoufight=nil;
_UIObject_release(self.lingshouModel);self.lingshouModel=nil;
_UIObject_release(self.lingshouName);self.lingshouName=nil;
_UIObject_release(self.lingshouSign);self.lingshouSign=nil;
_UIObject_release(self.lsDesc);self.lsDesc=nil;
_UIObject_release(self.lsDescBg);self.lsDescBg=nil;
_UIObject_release(self.lsDescObj);self.lsDescObj=nil;
_UIObject_release(self.orderBtn);self.orderBtn=nil;
_UIObject_release(self.posFloatMark);self.posFloatMark=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.ziZhiReduceStateBtn);self.ziZhiReduceStateBtn=nil;
_UIObject_release(self.czBtn);self.czBtn=nil;
end
















local _this=nil


function UILingShouModelWin:onLoaded(...)
self:bindComponents()

_this=self
notifySystem:listenNotify(notifyConfig.onLingShouAttrChange,self.onLingShouAttrChange)

local _onLingShouZiZhiRestore=function(lsGuid)
if _this==nil then return end
if _this.ls_guid and mathHelper.compareInt64(_this.ls_guid,lsGuid)then
_this.ziZhiReduceStateBtn:setActive(false)
end
end
self:addNotify(notifyConfig.onLingShouZiZhiRestore,_onLingShouZiZhiRestore)

self:addNotify(notifyConfig.onLingShouOrderChange,self.onLingShouOrderChange)

end


function UILingShouModelWin:__delete()
_this=nil
self:unbindComponents()
notifySystem:removelistener(notifyConfig.onLingShouAttrChange,self.onLingShouAttrChange)
end

function UILingShouModelWin.onLingShouAttrChange(guid,attrType)
if _this==nil then return end
if not mathHelper.compareInt64(guid,_this.ls_guid)then return end

_this:refreshFightView()
end


function UILingShouModelWin:onCzBtn()
lingshouController:showLingShouCZwin(self.ls_guid)
end




function UILingShouModelWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
self.ls_guid=argtable.ls_guid
self.preview=argtable.preview

if argtable.hideOrderBtn~=nil then
self.hideOrderBtn=argtable.hideOrderBtn and true or false
end

self.showShareBtn=argtable.showShareBtn and true or false
local canvas=argtable.canvas
if canvas then
self.winlua:SetCanvasIndex(-1,canvas)
end

self:refreshDiscipleInfo()
self:refreshPos()
if self.preview or self.hideOrderBtn then
self.orderBtn:setActive(false)
else
self.orderBtn:setActive(true)
self:refreshOrderBtn()
end
self.shareBtn:setActive(self.showShareBtn)

self:freshLingShouCZ()
end

function UILingShouModelWin:freshLingShouCZ()
local lsData=lingshouModel:getLingShouData(_this.ls_guid)
local flag=lingshouController:checkLingShouCZopen(lsData)
if flag then
_this.czBtn:setActive(true)
_this.ziZhiReduceStateBtn:setLocalPosY(-72)
else
_this.czBtn:setActive(false)
end
end

function UILingShouModelWin:onChangeLingShou(guid)
self:onShow({
ls_guid=guid,
preview=self.preview,
hideOrderBtn=self.hideOrderBtn,
showShareBtn=self.showShareBtn,
})

UIManager:closeWindow('UILingShouZiZhiRestoreTipsWin')
end

function UILingShouModelWin:refreshFightView()
local fight=lingshouModel:getFightValue(self.ls_guid)
self.lingshoufight:setText(tostring(fight))
end

function UILingShouModelWin:refreshDiscipleInfo()
local lsData=lingshouModel:getLingShouData(self.ls_guid)
local lsID=lsData.id
local lscfg=lsData.cfg

local name_str=lsData.name
self.lingshouName:setText(name_str)

self:refreshFightView()

self.lingshouModel:setChildUIModelRemoveTarget()
local modelParams=lingshouModel.getModelParamsEx(lscfg.model)
local scale=lscfg.modelScale
if not scale then

scale=isometricMapSystem:getModelScale(lscfg.model,true)
end
self.lingshouModel:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,0,false,true)
local offset=lscfg.modelOffset or{0,-150}
self.lingshouModel:setChildUIModelShowTargetOffset(offset[1],offset[2])









self.ziZhiReduceStateBtn:setActive(lingshouModel:checkLingshouZiZhiIsReduce(self.ls_guid))
self.changeNameBtn:setActive(not self.preview)


local isLDLS=liandonModel:getLianDonLinkageIdByLsId(lsID)>0
self.liandonBtn:setActive(isLDLS)
end


function UILingShouModelWin:refreshPos()
local guid=self.ls_guid
local posStr=lingshouModel:getStatePosStr(guid)


self.lsDesc:setText(posStr)










self:doLocalMoveY(true)
end

function UILingShouModelWin:doLocalMoveY(isFloat)
if isFloat then
if self.floatTweener==nil then
self.posFloatMark:setLocalPosY(0)
local tweener=self.posFloatMark:setChildDOLocalMoveY(-2.0,1.2)
tweener:SetEase(_Ease.InOutSine)
tweener:SetLoops(-1,_LoopType.Yoyo)
self.floatTweener=tweener

self.isImageFloat=true
end
else
if self.floatTweener~=nil then
self.floatTweener:Complete()
self.floatTweener:Kill()
self.floatTweener=nil
self.posFloatMark:setLocalPosY(0)
self.isImageFloat=nil
end
end
end

function UILingShouModelWin:onChangeNameBtn()

if houtaiModel:isForbidenChangeName('该功能正在升级维护中')then
return
end

local guid=self.ls_guid
local lsData=lingshouModel:getLingShouData(guid)
local func=function(changeName)
lingshouController:reqChangeName(guid,changeName)
end
local baseCfg=cfgHelper.get1(cfg_lingshoubasicconfig_get,1)
local cost
if baseCfg and baseCfg.change_name_cost then
cost=baseCfg.change_name_cost[1]
end

local limitMinLen=2
local limitMaxLen=baseCfg.name_len
local args={
changeNameType=changeNameType.eLingshou,
title='灵兽改名',
defaultName=lsData.name,
callback=func,
lenLimit={limitMinLen,limitMaxLen},
cost=cost,
}
UIManager:showWindow('UICommonChangeNameWin',args)
end

function UILingShouModelWin:onAwakeBtn()

jumpManager:jump({type=0,id=JUMP_TYPE.eLingShouJueXing})
end

function UILingShouModelWin:rec_changeName(guid,name)
self.lingshouName:setText(name)
end

function UILingShouModelWin:rec_awake(guid)
self:onShow({ls_guid=guid})
end

function UILingShouModelWin:onPosClick()

local closeUICallBack=function()

if UIManager:isActive('UILingShouMainWin')then
UIFullLingShouMainControl:closeUI()
end


if UIManager:isActive('UILingShouListSelectWin')then
UIFullDiscipleSelectControl:closeUI()
end
end


local guid=self.ls_guid
lingshouController:jumpToLingShouStatePos(guid,closeUICallBack)
end

function UILingShouModelWin:onLsDescBg()
return self:onPosClick()
end

function UILingShouModelWin:onZiZhiReduceStateBtn()
local args={}

args.item=self.ziZhiReduceStateBtn:getWidgetBase()
args.node='right'
args.lsGuid=self.ls_guid

self:showWindow('UILingShouZiZhiRestoreTipsWin',args)
end

function UILingShouModelWin:refreshOrderBtn()

local hasOrder=lingshouModel:checkLSHasOrder(self.ls_guid)
local icon=hasOrder and'button_guanzhu_2'or'button_guanzhu_1'
self.orderBtn:setCSImageSprite(globalABLookup.global,icon)
end

function UILingShouModelWin:onOrderBtn()
local hasOrder=lingshouModel:checkLSHasOrder(self.ls_guid)
local lsData=lingshouModel:getLingShouData(self.ls_guid)
if hasOrder then
lingshouController:reqLSRefreshOrder(self.ls_guid,0)
else
lingshouController:reqLSRefreshOrder(self.ls_guid,1)
end
end

function UILingShouModelWin.onLingShouOrderChange(lsGuid,oldOrder,order)
if _this==nil then return end
if not mathHelper.compareInt64(lsGuid,_this.ls_guid)then return end
if not oldOrder then
oldOrder=0
end
if oldOrder>0 and order==0 then
UIManager.info('已取消关注灵兽')
elseif oldOrder==0 and order>0 then
UIManager.info('已设置关注灵兽')
end

_this:refreshOrderBtn()
end

function UILingShouModelWin:onLiandonBtn()
local lsData=lingshouModel:getLingShouData(self.ls_guid)
local lsID=lsData.id
local linkageId=liandonModel:getLianDonLinkageIdByLsId(lsID)
UIManager:showWindow('UITipLianDonWin',{linkageId=linkageId})
end

function UILingShouModelWin:onShareBtn()
UIManager:showWindow('UIShareLingShouRoleInfoWin',{ls_guid=self.ls_guid})
end

