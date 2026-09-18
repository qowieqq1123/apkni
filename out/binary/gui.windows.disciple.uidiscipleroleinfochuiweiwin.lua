







def_class("UIDiscipleRoleInfoChuiWeiWin",UIWindowBase)









function UIDiscipleRoleInfoChuiWeiWin:bindComponents()

self.root=UIObject.get(self,0)
self.zuoHuaBtn=UIObject.get(self,1)
self.jiuzhiBtn=UIObject.get(self,2)
self.jjNameText=UIText.get(self,3)
self.ltNameText=UIText.get(self,4)
self.chuiweiText=UIText.get(self,5)
self.ZuoHua=UIObject.get(self,6)



end


function UIDiscipleRoleInfoChuiWeiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.zuoHuaBtn);self.zuoHuaBtn=nil;
_UIObject_release(self.jiuzhiBtn);self.jiuzhiBtn=nil;
_UIObject_release(self.jjNameText);self.jjNameText=nil;
_UIObject_release(self.ltNameText);self.ltNameText=nil;
_UIObject_release(self.chuiweiText);self.chuiweiText=nil;
_UIObject_release(self.ZuoHua);self.ZuoHua=nil;
end

















local _this


function UIDiscipleRoleInfoChuiWeiWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
self:addNotify(notifyConfig.onDiscipleInjuryChange,self.onDiscipleInjuryChange)
end


function UIDiscipleRoleInfoChuiWeiWin:__delete()
_this=nil
self:unbindComponents()
end

function UIDiscipleRoleInfoChuiWeiWin.onDiscipleStateChange(discipleguid,stateType,old,cur)
if _this.disciple_guid==discipleguid and stateType==DISCIPLE_STATE_TYPE.eChuiWei then
_this:onShow({guid=discipleguid})
end
end

function UIDiscipleRoleInfoChuiWeiWin.onDiscipleInjuryChange(discipleguid,oldInjury,injury)
local config=cfgHelper.get1(cfg_discipledyingconfig_get,1)
local injurySec=config.injury
if _this.disciple_guid==discipleguid and injury<=injurySec[2]then
_this:onShow({guid=discipleguid})
end
end




function UIDiscipleRoleInfoChuiWeiWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid
local state=UIDiscipleModel:getDiscipleState(self.disciple_guid)
self.showWin=state==DISCIPLE_STATE_TYPE.eChuiWei
self.root:setActive(self.showWin)
if self.showWin then
self:flushDiscipleInfo()
end
end


function UIDiscipleRoleInfoChuiWeiWin:onHide()

end

function UIDiscipleRoleInfoChuiWeiWin:onChangeDisciple(dis_guid)
self:onShow({guid=dis_guid})
end

function UIDiscipleRoleInfoChuiWeiWin:flushDiscipleInfo()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)

local jjlv=netData.jingjielv
local jj_str=FMT.fmt('境界：<color=#181412>{0}</color>',UIDiscipleModel.getJJNameCommon(jjlv,4))
self.jjNameText:setText(jj_str)


local ltlv=netData.liantilv
local lt_str=FMT.fmt('炼体：<color=#181412>{0}</color>',UIDiscipleModel.getLTNameCommon(ltlv,2))
self.ltNameText:setText(lt_str)

local descStr=''
local chuiweiType=UIDiscipleModel:checkChuiWeiDiscipleType(self.disciple_guid)
if chuiweiType==DISCIPLE_CHUIWEI_TYPE.eInjury then
descStr='负伤过重'
elseif chuiweiType==DISCIPLE_CHUIWEI_TYPE.eShouYuan then
descStr='寿元已尽'
end
local chuiweiStr=FMT.fmt('弟子{0}，濒临垂危',descStr)
self.chuiweiText:setText(chuiweiStr)

local isPlotDis=UIDiscipleModel:isPlotDisciple(self.disciple_guid)
self.ZuoHua:setActive(not isPlotDis)
end


function UIDiscipleRoleInfoChuiWeiWin:onZuoHuaBtn()
if not UIDiscipleModel:checkCanKickOutDzAndTips(self.disciple_guid,true,2)then
return
end
UIManager:showWindow('UIDiscipleKickoutWin',{guid=self.disciple_guid,openType=2,useCancel=true})
end

function UIDiscipleRoleInfoChuiWeiWin:onJiuzhiBtn()




















UIManager:showWindow('UIDiscipleChuiweiWin',{guid=self.disciple_guid})
end