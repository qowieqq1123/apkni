
objectHelper={}


function objectHelper.isNil(uobj)
return uobj==nil or uobj:Equals(nil)
end


function objectHelper.packFunc(obj,method)
if method==nil then
error(langScriptAuto(23))
return nil
end
return function(...)
return method(obj,...)
end
end


function objectHelper.addListerner(btn,clickCall,data,boolScale)
local function btnCall()
if clickCall then
clickCall(data)
end

AudioManager.playBtnClick()
end
btn.onClick:AddListener(btnCall)
if not boolScale then
return
else
local touch=ComponentHelper.AddComponent(btn.gameObject,CS.TouchEvent)
touch.doAction=true
end
end



