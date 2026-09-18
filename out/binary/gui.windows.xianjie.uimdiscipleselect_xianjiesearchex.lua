







def_class("UIMDiscipleSelect_xianjieSearchEx",UIWindowBase)









function UIMDiscipleSelect_xianjieSearchEx:bindComponents()

self.condition1=UIText.get(self,0)
self.condition2=UIText.get(self,1)
self.tipsTxt=UIText.get(self,2)



end


function UIMDiscipleSelect_xianjieSearchEx:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.condition1);self.condition1=nil;
_UIObject_release(self.condition2);self.condition2=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
end

















function UIMDiscipleSelect_xianjieSearchEx:onLoaded(...)
self:bindComponents()
end


function UIMDiscipleSelect_xianjieSearchEx:__delete()
self:unbindComponents()
end


function UIMDiscipleSelect_xianjieSearchEx:onHide()

end




function UIMDiscipleSelect_xianjieSearchEx:onShow(argtable,afterOnloaded)
local cloudid=argtable.cloudid

local cond=cfgHelper.get2(cfg_fairylandcloudconfig_get,cloudid,'disciple')
local str1,str2,cnd
local fmt_str='弟子{0}需{1}以上'

cnd=cond[1]
if cnd then
local typo=cnd[2]
local v=cnd[3]
str1=FMT.fmt(fmt_str,eSpecialAttrName:getName(typo),eSpecialAttrFunc:getValueStr(typo,nil,v))
end
local show1=str1~=nil
self.condition1:setActive(show1)
if show1 then
self.condition1:setText(str1)
end

cnd=cond[2]
if cnd then
local typo=cnd[2]
local v=cnd[3]
str2=FMT.fmt(fmt_str,eSpecialAttrName:getName(typo),eSpecialAttrFunc:getValueStr(typo,guid,v))
end
local show2=str2~=nil
self.condition2:setActive(show2)
if show2 then
self.condition2:setText(str2)
end

local cloudEntData=xianjieModel:getCloudEntityData(cloudid)
local costTime=cloudEntData:getEventCostTime()
local time_str=timeHelper.format_time_stamp3(costTime)
local desc_str=FMT.fmt('探索耗时：{0}\n（不含往返时间）',time_str)
self.tipsTxt:setText(desc_str)
end