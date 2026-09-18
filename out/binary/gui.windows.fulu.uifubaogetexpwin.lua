







def_class("UIFuBaoGetExpWin",UIWindowBase)









function UIFuBaoGetExpWin:bindComponents()

self.getProExpText=UIText.get(self,0)



end


function UIFuBaoGetExpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.getProExpText);self.getProExpText=nil;
end



















function UIFuBaoGetExpWin:onLoaded(...)
self:bindComponents()
end


function UIFuBaoGetExpWin:__delete()
self:unbindComponents()
end




function UIFuBaoGetExpWin:onShow(argtable,afterOnloaded)
local ubdId=argtable[1]
local fubaoid=argtable[2]
local cnt=argtable[3]
local bdData=zongmenModel:getBuildingData(ubdId)
local config=cfgHelper.get1(cfg_fubaofangconfig_get,fubaoid)
local proskill_exp=config.proskill_exp
local addProExp=proskill_exp[1]
local proType=addProExp[1]
local addValue=addProExp[2]

local proCfg=cfgHelper.get1(cfg_discipleproskillconfig_get,proType)

local allAddVal=addValue*cnt
local dzId=bdData.dizi_id
if dzId then
local addRate=UIDiscipleModel:getDiscipleProskillRate(dzId,proType)
allAddVal=math.floor(allAddVal*(1+addRate/100))
end
local name=UIDiscipleModel:getDiscipleName(dzId)
local isTempName=name==nil or name==''
local expStr=isTempName and''or FMT.fmt('<color=#ca631d>{2}</color>{0}经验增加{1}点',proCfg.name,allAddVal,name)
self.getProExpText:setText(expStr)
end


function UIFuBaoGetExpWin:onHide()

end



