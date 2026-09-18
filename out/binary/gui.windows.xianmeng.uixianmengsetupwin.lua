







def_class("UIXianMengSetupWin",UIWindowBase)









function UIXianMengSetupWin:bindComponents()

self.joinToggle1=UIToggleButton.get(self,0)
self.joinToggle2=UIToggleButton.get(self,1)
self.inputLevelField=UIInputField.get(self,2)
self.inputFieldFrame=UIButton.get(self,3)
self.noticeInputField=UIInputField.get(self,4)
self.noticeTx=UIText.get(self,5)

self.inputFieldFrame:setButtonClick(function()self:onInputFieldFrame()end)



end


function UIXianMengSetupWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.joinToggle1);self.joinToggle1=nil;
_UIObject_release(self.joinToggle2);self.joinToggle2=nil;
_UIObject_release(self.inputLevelField);self.inputLevelField=nil;
_UIObject_release(self.inputFieldFrame);self.inputFieldFrame=nil;
_UIObject_release(self.noticeInputField);self.noticeInputField=nil;
_UIObject_release(self.noticeTx);self.noticeTx=nil;
end

















function UIXianMengSetupWin:onLoaded(...)
self:bindComponents()

self.inputLevelField:setChildInputFieldChange(true,function(...)self:onInputChange(...)end)


self.maxlv=150
end


function UIXianMengSetupWin:__delete()

AudioManager.playBtnClick()
self:unbindComponents()
end


function UIXianMengSetupWin:onHide()

end




function UIXianMengSetupWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
local detialData=xianmengModel:getMyXMDetialData()
local joinlimit=detialData.joinlimit
local levellimit=detialData.levellimit
self.old_joinlimit=detialData.joinlimit
self.old_levellimit=detialData.levellimit

local lenMax=cfgHelper.get2(cfg_guildbaseconfig_get,1,"exnoticelen")
self.noticeInputField:setInputCharacterLimit(lenMax)

self.old_notice=xianmengModel:getXMNotice2()
if self.old_notice==nil or self.old_notice==""then
self.old_notice=cfgHelper.get2(cfg_guildbaseconfig_get,1,'defaultexnotice')
end
self.checkNotice=xianmengModel:checkOpenNotice(true)
self.noticeInputField:setActive(self.checkNotice)
if self.checkNotice then
self.noticeInputField:setInputFieldValue(self.old_notice)
else
self.noticeTx:setText(self.old_notice)
end

self.joinlimit=joinlimit
self.levellimit=levellimit
self.joinToggle1:setToggle(mathHelper.getBitValue(joinlimit,0))
self.joinToggle2:setToggle(mathHelper.getBitValue(joinlimit,1))

self:refreshInput(levellimit)

self.joinToggle1:setToggleChange(function(...)
self:toggleChange1(...)
end)
self.joinToggle2:setToggleChange(function(...)
self:toggleChange2(...)
end)
end

function UIXianMengSetupWin:toggleChange1(name,isOn)
if isOn then
self.joinlimit=mathHelper.setbit(self.joinlimit,0)
else
self.joinlimit=mathHelper.clrbit(self.joinlimit,0)
end
end

function UIXianMengSetupWin:toggleChange2(name,isOn)
if isOn then
self.joinlimit=mathHelper.setbit(self.joinlimit,1)
else
self.joinlimit=mathHelper.clrbit(self.joinlimit,1)
end
end

function UIXianMengSetupWin:refreshInput(levellimit)
local num_str
if levellimit==0 then
num_str=''
else
num_str=tostring(levellimit)
end
self.inputLevelField:setInputFieldValue(num_str)
end

function UIXianMengSetupWin:onInputChange(str)
if str=='-'then return end
local old=self.levellimit
if str==nil or str==''then
self.levellimit=0
else
local num=tonumber(str)
if num<=0 then
self.levellimit=0
self:refreshInput(self.levellimit)
elseif num>self.maxlv then
self.levellimit=self.maxlv
self:refreshInput(self.levellimit)
else
self.levellimit=num
if self.levellimit~=old then
self:refreshInput(self.levellimit)
end
end
end
end






function UIXianMengSetupWin:onSubBtn()
local levellimit=self.levellimit
levellimit=levellimit-1
if levellimit<0 then
levellimit=0
end
if levellimit~=self.levellimit then
self.levellimit=levellimit
self:refreshInput(levellimit)
end
end


function UIXianMengSetupWin:onAddBtn()
local levellimit=self.levellimit
levellimit=levellimit+1
if levellimit>self.maxlv then
levellimit=self.maxlv
end
if levellimit~=self.levellimit then
self.levellimit=levellimit
self:refreshInput(levellimit)
end
end

function UIXianMengSetupWin:onSureBtn()
if self.checkNotice then
local new_notice=self.noticeInputField:getInputFieldValue()

if houtaiModel:isForbidenChangeName('该功能正在升级维护中')then
return
end

if new_notice~=self.old_notice then
if new_notice==''then
UIManager.info('请输入公告内容')
return
end
if helper.check_spec_chars(new_notice)then
UIManager.info('公告含敏感字符')
return
end

local len=string.lenEx(new_notice)
local lenMax=cfgHelper.get2(cfg_guildbaseconfig_get,1,"exnoticelen")
if len>lenMax then
UIManager.info(FMT.fmt('输入公告长度超长{0}',lenMax))
return
end

if not xianmengModel:checkNoticeStamp(true)then
UIManager.info("喝杯茶休息一下")
return
end

xianmengController:reqXMChangeNotice2(new_notice)
end
end

if self.old_joinlimit~=self.joinlimit or self.old_levellimit~=self.levellimit then
xianmengController:reqSetXMLimit(self.joinlimit,self.levellimit)
end

self.parentWin:onCloseClick()
end

function UIXianMengSetupWin:onInputFieldFrame()

local checkopen,code,value=xianmengModel:checkOpenNotice()
if not checkopen then
if code==1 then
UIManager.info(FMT.fmt('{0}天后才可修改公告',value-timeHelper.getServerOpenDay()))
elseif code==2 then
UIManager.info(FMT.fmt('宗门{0}级才可修改公告',value))
else
UIManager.error('暂未开启')
end
return
end
end