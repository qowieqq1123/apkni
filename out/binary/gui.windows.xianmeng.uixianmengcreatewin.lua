







def_class("UIXianMengCreateWin",UIWindowBase)









function UIXianMengCreateWin:bindComponents()

self.signBGIcon=UIImage.get(self,0)
self.signIcon=UIImage.get(self,1)
self.signKuangIcon=UIImage.get(self,2)
self.nameInput=UIInputField.get(self,3)
self.descObj=UIButton.get(self,4)
self.descTxt=UIText.get(self,5)
self.descInput=UIInputField.get(self,6)
self.costObj=UIButton.get(self,7)
self.costNumTxt=UIText.get(self,8)
self.costIcon=UIImage.get(self,9)
self.Placeholder=UIText.get(self,10)

self.descObj:setButtonClick(function()self:onDescObj()end)

self.costObj:setButtonClick(function()self:onCostObj()end)



end


function UIXianMengCreateWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.signBGIcon);self.signBGIcon=nil;
_UIObject_release(self.signIcon);self.signIcon=nil;
_UIObject_release(self.signKuangIcon);self.signKuangIcon=nil;
_UIObject_release(self.nameInput);self.nameInput=nil;
_UIObject_release(self.descObj);self.descObj=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.descInput);self.descInput=nil;
_UIObject_release(self.costObj);self.costObj=nil;
_UIObject_release(self.costNumTxt);self.costNumTxt=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.Placeholder);self.Placeholder=nil;
end
















local _this


function UIXianMengCreateWin:onLoaded(...)
_this=self
self:bindComponents()
self.lenLimit=cfgHelper.get2(cfg_guildbaseconfig_get,1,'namelen')
local ver=pfwindowslController:getGameVersion()
self.nameInput:setInputCharacterLimit(self.lenLimit[ver][2])
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_change)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
local desc="请输入仙盟名称"
if pfwindowslController:checkIsGameVersion_HWFT()then
desc="请输入仙盟名称 (6個中文或10個英文字母以内)"
end
self.Placeholder:setText(desc)
end


function UIXianMengCreateWin:__delete()

AudioManager.playCloseUI()
_this=nil
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_change)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
xianmengModel:setXMSignRecored(nil)
end


function UIXianMengCreateWin:onHide()

end




function UIXianMengCreateWin:onShow(argtable,afterOnloaded)
local lenMax=cfgHelper.get2(cfg_guildbaseconfig_get,1,"noticelen")
self.descInput:setInputCharacterLimit(lenMax)

self.signImage=xianmengModel.getDefualtGuildIamge()
local consume=cfgHelper.get3(cfg_guildbaseconfig_get,1,'consume',1)
local ver=pfwindowslController:getGameVersion()
local cost=consume[ver][1]
self.needItemID=cost[1]
self.needItemNum=cost[2]
local hasnum
if itemsConfig.isMoney(self.needItemID)then
hasnum=moneyModel.getMoney(self.needItemID)
else
hasnum=bagControl.invokeFuncByItemId(self.needItemID,'getItemCountByItemID',self.needItemID)
end
self.hasItemNum=hasnum

self:refreshSignView()
self:refreshCostView()
self:refreshNoticeView()
end

function UIXianMengCreateWin:refreshSignView()
local image=self.signImage
local abname=globalABLookup.xianmengicons

self.signIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

self.signBGIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

self.signKuangIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
end

function UIXianMengCreateWin:refreshCostView()
self:refreshCostView2()
local iconName=iconHelper.getIconName(self.needItemID)
self.costIcon:setImageIcon(iconName,false)
end

function UIXianMengCreateWin:refreshCostView2()
local numstr
if self.hasItemNum>=self.needItemNum then
numstr=FMT.fmt('<color=#7D3B17>{0}</color>',self.needItemNum)
else
numstr=FMT.fmt('<color=#c82c2c>{0}</color>',self.needItemNum)
end
self.costNumTxt:setText(FMT.fmt('消耗：     {0}',numstr))
end

function UIXianMengCreateWin:refreshNoticeView()
local checkopen=xianmengModel:checkOpenNotice()
self.descObj:setActive(not checkopen)
self.descInput:setActive(checkopen)
local defaultguildnotice=cfgHelper.get2(cfg_guildbaseconfig_get,1,'defaultguildnotice')or''
if checkopen then
self.descInput:setInputFieldValue(defaultguildnotice)
else
self.descTxt:setText(defaultguildnotice)
end
end

function UIXianMengCreateWin:getNoticeStr()
local checkopen=xianmengModel:checkOpenNotice()
if not checkopen then
local defaultguildnotice=cfgHelper.get2(cfg_guildbaseconfig_get,1,'defaultguildnotice')
return defaultguildnotice
else
return self.descInput:getInputFieldValue()
end
end

function UIXianMengCreateWin:onDescObj()


end

function UIXianMengCreateWin:onChangeBtn()
local onChangeFunc=function(image)
if _this==nil then return false end
return _this:onChangeIcon(image)
end

AudioManager.playBtnClick()
UIManager:showWindow('UIXianMengSignSetupWin',{onChangeFunc=onChangeFunc,changType=1})
end

function UIXianMengCreateWin:onChangeIcon(image)
local change=false
if self.signImage.icon~=image.icon then
change=true
self.signImage.icon=image.icon
end
if self.signImage.bg~=image.bg then
change=true
self.signImage.bg=image.bg
end
if self.signImage.kuang~=image.kuang then
change=true
self.signImage.kuang=image.kuang
end
if change then
xianmengModel:setXMSignRecored(table.deepCopy(self.signImage))
UIManager.info('更改成功')
self:refreshSignView()
return true
else
UIManager.info('请选择要改变的盟徽部件')
return false
end
end

function UIXianMengCreateWin:onCostObj()
itemsComponentHelper.onItemClickEx(self.needItemID,-1,-1,nil)
end

function UIXianMengCreateWin:onCreateBtn()
local result=self:createXianMeng()
if not result then

AudioManager.playBtnClick()
end
end

function UIXianMengCreateWin:createXianMeng()
if xianmengModel:hasXM()then
UIManager.info('已有仙盟')
return false
end


local inputname=self.nameInput:getInputFieldValue()
inputname=inputname or''
if inputname==''then
UIManager.info('请输入仙盟名称')
return false
end
local ver=pfwindowslController:getGameVersion()
if not pfwindowslController.checkNameLenInvalid(inputname,self.lenLimit[ver])then
return
end


local inputdesc=self:getNoticeStr()
inputdesc=inputdesc or''
if inputdesc==''then
UIManager.info('请输入仙盟公告')
return false
end
if self.isGuoFu then
if helper.check_spec_chars(inputdesc)then
UIManager.info('公告含敏感字符')
return false
end
end

local needItemName=itemsConfig.getItemName(self.needItemID)
if self.hasItemNum<self.needItemNum then































gainControl:showGainWin(self.needItemID)
return false
end

local guildicon=xianmengModel.composeGuildIcon(self.signImage)
















































local check=0
platformSDK:reqMsgSecCheck(1,inputname,function(reContent)
if reContent==inputname then
check=check+1
if check>=2 then
xianmengController:reqCreateXM(guildicon,inputname,inputdesc)
end
else
UIManager.error('名称含敏感字符')
end
end)
platformSDK:reqMsgSecCheck(1,inputdesc,function(reContent)
if reContent==inputdesc then
check=check+1
if check>=2 then
xianmengController:reqCreateXM(guildicon,inputname,inputdesc)
end
else
UIManager.error('公告含敏感字符')
end
end)

return true
end

function UIXianMengCreateWin.on_money_change(moneyType,lastVal,val)
if _this.needItemID==moneyType then
_this.hasItemNum=val
_this:refreshCostView2()
end
end

function UIXianMengCreateWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if _this.needItemID==itemid then
_this.hasItemNum=newcount
_this:refreshCostView2()
end
end