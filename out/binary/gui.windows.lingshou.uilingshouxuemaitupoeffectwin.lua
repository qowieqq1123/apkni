







def_class("UILingShouXueMaiTuPoEffectWin",UIWindowBase)









function UILingShouXueMaiTuPoEffectWin:bindComponents()

self.rewadProgress=UIObject.get(self,0)
self.rewardGrid=UIObject.get(self,1)



end


function UILingShouXueMaiTuPoEffectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rewadProgress);self.rewadProgress=nil;
_UIObject_release(self.rewardGrid);self.rewardGrid=nil;
end



















function UILingShouXueMaiTuPoEffectWin:onLoaded(...)
self:bindComponents()
end


function UILingShouXueMaiTuPoEffectWin:__delete()
self:unbindComponents()
end




function UILingShouXueMaiTuPoEffectWin:onShow(argtable,afterOnloaded)
local lsData=argtable.lsData

local xmLevelGroupID=lsData.cfg.xuemai[1]

local xmLevelCfgs=cfgHelper.get(cfg_lingshouxuemailevelconfig_get,xmLevelGroupID)

local list={}
local progresNum=0

local xuemaiSpeAttr=cfgHelper.get(cfg_lingshoubasicconfig_get,1,'xuemaiSpeAttr')

local rval={}
for index,cfg in ipairs(xmLevelCfgs)do
for index=0,#cfg.attrs do
local attrlookup=attrListHelper.tramsformToLookup(cfg.attrs[index])
for _,type in ipairs(xuemaiSpeAttr)do
local bval=(rval[type]or 0)
if attrlookup[type]>bval then
local isUnlock=lsData.xuemai_val>cfg.level or(lsData.xuemai_val==cfg.level and lsData.xuemai_dianshu>=index)
table.insert(list,{cfg.level,type,attrlookup[type]-bval,isUnlock})
if isUnlock then
progresNum=progresNum+1
end
rval[type]=attrlookup[type]or 0
end
end
end
end

local len=#list
self.rewardGrid:setChildLayoutGroupCreateItems(len)
local grids=self.rewardGrid:getChildLayoutGroupGridList()
local enoughNum=0
self.max=len
for i=1,len do
local widget=grids[i-1]
local data=list[i]
local unlock=data[4]
local desc=FMT.fmt('[{0}]',lingshouModel:switchLevelToStageName_XueMai(data[1]))
desc=FMT.fmt("{0} {1}",desc,helper.getAttributeStr(data[2],data[3],2,"{0}+{1}"))
if not unlock then
desc=FMT.cfmt(FONT_COLOR.eGrayColor,desc)
else
enoughNum=enoughNum+1
desc=FMT.cfmt(FONT_COLOR.eGreenColor,desc)
end
widget:SetChildText(0,desc)
widget:SetChildActive(1,unlock)
widget:SetChildActive(2,not unlock)
end

local height=progresNum*86
self.rewadProgress:setChildSizeDelta(12,height)
end


function UILingShouXueMaiTuPoEffectWin:onHide()

end



