def_class('cameraScreenEffect',{})

cameraScreenEffect.setEffectFunc=
{
[0]=function(self,args)

self:setWiggle(true,args[1],args[2],args[3])
end,
}

function cameraScreenEffect:__init(obj)
if api_Available_CameraScreenEffect()then
self.csObj=obj:GetComponent("CameraScreenEffect")
if self.csObj==nil then
logErr("CameraScreenEffect is nil")
end
end
end


function cameraScreenEffect:disableAllEffect()
if self.csObj~=nil then
self.csObj:DisableAllEffect()
end
end






function cameraScreenEffect:setWiggle(enable,speed,fre,am)
if self.csObj~=nil then
self.csObj:SetWiggle(enable,1,speed,fre,am)
end
end


function cameraScreenEffect:setNegative(enable,amount,fadeTime)
if self.csObj~=nil then
if api_Available_SetNegative()then
self.csObj:SetNegative(enable,amount,fadeTime)
else
self.csObj:EnableIndex(enable,fBTScreenEffectTypo.Nagetive)
end
end
end



function cameraScreenEffect:enableIndexEffect(enable,index)
if self.csObj~=nil then
self.csObj:EnableIndex(enable,index)
end
end