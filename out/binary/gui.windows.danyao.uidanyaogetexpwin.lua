







def_class("UIDanYaoGetExpWin",UIWindowBase)









function UIDanYaoGetExpWin:bindComponents()

self.getProExpText=UIText.get(self,0)



end


function UIDanYaoGetExpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.getProExpText);self.getProExpText=nil;
end



















function UIDanYaoGetExpWin:onLoaded(...)
self:bindComponents()
end


function UIDanYaoGetExpWin:__delete()
self:unbindComponents()
end




function UIDanYaoGetExpWin:onShow(argtable,afterOnloaded)
local dfId=argtable[1]
local bdData=argtable[2]

local config=cfgHelper.get1(cfg_danfangconfig_get,dfId)
local proExp=config.proskill_exp
local addProExp=proExp[1]
local proType=addProExp[1]

local proCfg=cfgHelper.get1(cfg_discipleproskillconfig_get,proType)


local dzId=bdData.dizi_id




local allAddVal=UIDanYaoController:getRecordAddExp()
if allAddVal>0 then
local name=UIDiscipleModel:getDiscipleName(dzId)
local isTempName=name==nil or name==''
local expStr=isTempName and''or FMT.fmt('<color=#ca631d>{2}</color>{0}经验增加{1}点',proCfg.name,allAddVal,name)
self.getProExpText:setText(expStr)
else
self.getProExpText:setText('')
end
end


function UIDanYaoGetExpWin:onHide()

end



