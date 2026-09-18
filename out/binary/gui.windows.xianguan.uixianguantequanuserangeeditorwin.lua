







def_class("UIXianGuanTeQuanUseRangeEditorWin",UIWindowBase)









function UIXianGuanTeQuanUseRangeEditorWin:bindComponents()

self.btnClose=UIButton.get(self,0)
self.btnUse=UIButton.get(self,1)
self.desc=UIText.get(self,2)
self.effect=UIObject.get(self,3)
self.nameEffect=UIObject.get(self,4)
self.selectText=UIText.get(self,5)
self.titleIcon=UIImage.get(self,6)
self.useCnt=UIText.get(self,7)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.btnUse:setButtonClick(function()self:onBtnUse()end)



end


function UIXianGuanTeQuanUseRangeEditorWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.btnUse);self.btnUse=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.nameEffect);self.nameEffect=nil;
_UIObject_release(self.selectText);self.selectText=nil;
_UIObject_release(self.titleIcon);self.titleIcon=nil;
_UIObject_release(self.useCnt);self.useCnt=nil;
end

















local _abName='ui/windows/xianguan/xgtequanedit_atlas_pak.ab'

local tipsType=
{
[XIANGUAN_TYPE_ENUM.eTianShuLongWei]='九御龙阵正在施法结阵中，剩余{0}秒',
[XIANGUAN_TYPE_ENUM.eFuLuXianShi]='仙官赐福正在施法结阵中，剩余{0}秒',
}



function UIXianGuanTeQuanUseRangeEditorWin:onLoaded(...)
self:bindComponents()
self:addNotify(notifyConfig.onTeQuanInfoChange,function(...)
self:onTeQuanInfoChange(...)
end)
end


function UIXianGuanTeQuanUseRangeEditorWin:__delete()
self:unbindComponents()
UIFullTeQuanUseRangeEditorController:onExitQuanXianEditor(self.argtable)
end




function UIXianGuanTeQuanUseRangeEditorWin:onShow(argtable,afterOnloaded)
self.argtable=argtable
local tqid=argtable.tqid
local xgid=argtable.xgid
self.descStr=argtable.descStr or nil
self.xgid=xgid
self.tqid=tqid
self.args=argtable
self.tqCfg=cfg_xianguanprivilegeconfig_get(tqid)
self:refreshInfo()
end


function UIXianGuanTeQuanUseRangeEditorWin:onHide()


end





function UIXianGuanTeQuanUseRangeEditorWin:onBtnClose()
local stamp=timeHelper.getServerShortTime()
if self.closeStamp and self.closeStamp>stamp then
local xgtype=xianguanConfig.getJobConfig2(self.xgid,"type")
UIManager.error(FMT.fmt(tipsType[xgtype],self.closeStamp-stamp))
return
end
UIFullTeQuanUseRangeEditorController:exitQuanXianEditor()
end



function UIXianGuanTeQuanUseRangeEditorWin:onBtnUse()
local ret=UIFullTeQuanUseRangeEditorController:useTeQuan(self.xgid,self.tqid,self.args)
if ret then
local delay=UIFullTeQuanUseRangeEditorController:getTeQuanEmisDelay(self.tqid)
self.closeStamp=timeHelper.getServerShortTime()+delay+1
self.closeStamp=math.floor(self.closeStamp)
end
end


function UIXianGuanTeQuanUseRangeEditorWin:refreshInfo()
local tqCfg=cfg_xianguanprivilegeconfig_get(self.tqid)
self.reset=tqCfg.reset
if not self.descStr then self.descStr=tqCfg.descEditor end

self:stopTickTimer()
local cd=xianguanModel:callTeQuanObjFunc(self.xgid,self.tqid,'getCd')
if cd>timeHelper.getServerShortTime()then
self.tickTimer=self:setTimer(1,0,function()
if not self:refreshCnt()then
self:stopTickTimer()
end
end)
end
self:refreshCnt()
self.desc:setText(self.descStr)
local editorArgs=cfgHelper.get2(cfg_xianguanprivilegeconfig_get,self.tqid,'editorArgs')
self.btnUse:setSprite(_abName,editorArgs[1])
self.titleIcon:setSprite(_abName,editorArgs[2])
end

function UIXianGuanTeQuanUseRangeEditorWin:stopTickTimer()
if self.tickTimer then
self:stopTimerByID(self.tickTimer)
self.tickTimer=nil
end
end

function UIXianGuanTeQuanUseRangeEditorWin:refreshCnt()
local useCntStr
local reset=self.reset
local stamp=timeHelper.getServerShortTime()
local cd=xianguanModel:callTeQuanObjFunc(self.xgid,self.tqid,'getCd')
local left=cd-stamp
local inCoolDown=left>0
local cnt=xianguanModel:callTeQuanObjFunc(self.xgid,self.tqid,'getLeftTimes')
if inCoolDown then
useCntStr=FMT.cfmt1(FONT_COLOR.eRedColor,timeHelper.format_time_stamp(left))
else
local maxcnt=xianguanModel:callTeQuanObjFunc(self.xgid,self.tqid,'getMaxTimes')
if reset==1 or reset==2 then
useCntStr=cnt>0 and FMT.fmt('每日:<color=#aae252>{0}/{1}</color>',cnt,maxcnt)or
FMT.fmt('本日:<color=#c82c2c>{0}</color><color=#aae252>/{1}</color>',cnt,maxcnt)
elseif reset==3 or reset==4 then
useCntStr=cnt>0 and FMT.fmt('每周:<color=#aae252>{0}/{1}</color>',cnt,maxcnt)or
FMT.fmt('本周:<color=#c82c2c>{0}</color><color=#aae252>/{1}</color>',cnt,maxcnt)
elseif reset==0 then
useCntStr=cnt>0 and FMT.fmt('剩余:<color=#aae252>{0}</color>',cnt)or
'剩余:<color=#c82c2c>0</color>'
end
end

self.useCnt:setText(useCntStr)
self.btnUse:setGray(inCoolDown or cnt<=0)
return inCoolDown
end

function UIXianGuanTeQuanUseRangeEditorWin:onTeQuanInfoChange(data)
if data.xgid==self.xgid and self.tqid==data.tqid then
self:refreshCnt()
self.effect:setChildShowEffect(20641,true)
if self.tqid==XIANGUAN_PRIVILEGE_ENUM.eXianGuanCiFu then
self.nameEffect:setChildShowEffect(22652,true)
end
local argtable=self.argtable
UIFullTeQuanUseRangeEditorController:onUse(argtable)
local delay=UIFullTeQuanUseRangeEditorController:getTeQuanEmisDelay(self.tqid)
self:delayDo(delay,function()
if self and not self.isClose then
UIFullTeQuanUseRangeEditorController:onEmis(argtable)
end
end)
local delay1=UIFullTeQuanUseRangeEditorController:getTeQuanEditorDelay(self.tqid)
self:delayDo(delay+delay1,function()
UIFullTeQuanUseRangeEditorController:exitQuanXianEditor()
end)
end
end
