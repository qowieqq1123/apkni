







def_class("UIBuildChangeNameWin",UIWindowBase)









function UIBuildChangeNameWin:bindComponents()

self.InputField=UIInputField.get(self,0)
self.randomBtn=UIButton.get(self,1)
self.costItem=UIBaseItem.get(self,2)
self.clearBtn=UIButton.get(self,3)
self.sureBtn=UIButton.get(self,4)

self.randomBtn:setButtonClick(function()self:onRandomBtn()end)

self.clearBtn:setButtonClick(function()self:onClearBtn()end)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)



end


function UIBuildChangeNameWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.InputField);self.InputField=nil;
_UIObject_release(self.randomBtn);self.randomBtn=nil;
_UIObject_release(self.costItem);self.costItem=nil;
_UIObject_release(self.clearBtn);self.clearBtn=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
end

















local _this


function UIBuildChangeNameWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIBuildChangeNameWin:__delete()
_this=nil
self:unbindComponents()
UIManager:hideWindow('UITopMoneyWin')
end




function UIBuildChangeNameWin:onShow(argtable,afterOnloaded)
self.sfId=argtable.sfId
self.bdData=argtable.bdData
self.rename_conf=cfgHelper.get2(cfg_monijybuildconfig_get,self.bdData.build_id,'rename_conf')
local GameVersion=pfwindowslController:getGameVersion()
self.rename_conf=self.rename_conf[GameVersion]or self.rename_conf[1]
local pfid=loginModel:getPfid()
self.rename_conf=self.rename_conf[pfid]or self.rename_conf[-1]
local lenLimit=self.rename_conf[2]
self.InputField:setInputCharacterLimit(lenLimit[2])
local costs=self.rename_conf[1]
local free=self.bdData.rename_flag==0 or costs==nil or#costs==0
self.costItem:setActive(not free)
if not free then
local cost=costs[1]
local itemid=cost[1]
local needCount=cost[2]
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=itemBagModel:getItemCountByItemID(itemid)
end
local countStr=needCount
if have<needCount then
countStr=FMT.fmt('<color=#E33021>{0}</color>',needCount)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.costItem:setChildPropData(prop)
local item=self.winlua:GetChildCSGUIBaseItem(self.costItem:getID())
item:SetChildActive(0,false)
end
if argtable.isHideRandom then
self.randomBtn:setActive(false)
self.winlua:SetChildLocalPosition(self.InputField:getID(),Vector3.New(16,25,0))
else
self.randomBtn:setActive(true)
self.winlua:SetChildLocalPosition(self.InputField:getID(),Vector3.New(0,25,0))
end
end


function UIBuildChangeNameWin:onHide()

end



function UIBuildChangeNameWin:onRandomBtn()
local idSection=self.rename_conf[3]
local startId=idSection[1]
local endId=idSection[2]
local randId=math.random(startId,endId)
local name=cfgHelper.get2(cfg_monijynamesconfig_get,randId,'name')
self.InputField:setInputFieldValue(name)
end

function UIBuildChangeNameWin:onClearBtn()
self.InputField:setInputFieldValue('')
end

function UIBuildChangeNameWin:onSureBtn()
local changeName=self.InputField:getInputFieldValue()
if changeName==nil or changeName==''then
UIManager.error('名字不能为空')
return
end
if self.rename_conf==nil then
UIManager.error('该建筑没有改名配置')
return
end

local lenLimit=self.rename_conf[2]
local inputLen=string.lenEx(changeName)
if inputLen<lenLimit[1]then
UIManager.error(FMT.fmt('最少输入{0}个字符',lenLimit[1]))
return
elseif inputLen>lenLimit[2]then
UIManager.error(FMT.fmt('最多输入{0}个字符',lenLimit[2]))
return
end

if pfwindowslController:checkIsGameVersion_guofu()then
if helper.check_spec_chars(changeName)or not helper.string_is_ChineseS(changeName)then
UIManager.error('名字中含有特殊字符')
return
end
end

local buildName=self.bdData.name
if(buildName and buildName~='')and changeName==buildName then
UIManager.error('不能取相同的名字')
return
end

self:doSend(changeName)
end

function UIBuildChangeNameWin:doSend(str)
local free=self.bdData.rename_flag==0
if not free then
local costs=self.rename_conf[1]
for i,v in ipairs(costs)do
local have=0
local itemid=v[1]
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=itemBagModel:getItemCountByItemID(itemid)
end
if have<v[2]then
local name=itemsConfig.getItemName(itemid)
UIManager.error(FMT.fmt('{0}不足',name))
gainControl:showGainWin(itemid)
return
end
end
end
self.changeName=str
local func=function(...)
if _this==nil then return end
_this:onCheckStringLegal(...)
end
chatProtocolControl.sendCheckLegalStr(str,func)
end

function UIBuildChangeNameWin:onCheckStringLegal(str,legalStr)
if legalStr~=_this.changeName then
UIManager.error('名字中含有敏感字符')
return
end
zongmenControl:reqBuildChangeName(_this.sfId,_this.bdData.un_build_id,_this.changeName)
end