







def_class("UIDragonPreview",UIWindowBase)









function UIDragonPreview:bindComponents()

self.root=UIObject.get(self,0)
self.discipleModelRoot=UIObject.get(self,1)
self.out_side_model=UIObject.get(self,2)
self.out_side={
["model"]=self.out_side_model,
}



end


function UIDragonPreview:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.out_side_model);self.out_side_model=nil;
self.out_side=nil;
end



















function UIDragonPreview:onLoaded(...)
self:bindComponents()
end


function UIDragonPreview:__delete()
self:unbindComponents()
end




function UIDragonPreview:onShow(argtable,afterOnloaded)

end


function UIDragonPreview:onHide()

end

function UIDragonPreview:in_side(skeletonID,hair,face,bodyID,accessory)

end

function UIDragonPreview:showModel(skeletonID,hair,face,bodyID,accessory)
local in_side_cmps={}
local out_side_cmps={}
local out_side_body
if bodyID~=nil then
local cmpBody=cfg_disciplebodyimageconfig_get(bodyID)
if cmpBody~=nil then
if cmpBody.skeletonID~=nil then
skeletonID=cmpBody.skeletonID
end
if cmpBody.in_side~=nil then
for _,cmpID in ipairs(cmpBody.in_side)do
in_side_cmps[#in_side_cmps+1]=cmpID
end
end

if cmpBody.out_side~=nil then
out_side_body=cmpBody.out_side
end
else
logErr(FMT.fmt("不存在身体:{0}",bodyID))
end
end

if hair~=nil then
local hairCfg=cfg_disciplehairimageconfig_get(hair)
if hairCfg~=nil then
if hairCfg.in_side~=nil then
for _,cmpID in ipairs(hairCfg.in_side)do
in_side_cmps[#in_side_cmps+1]=cmpID
end
end

if hairCfg.out_side~=nil then
for k,cmp in pairs(hairCfg.out_side)do
table.insert(out_side_cmps,cmp)
end

end
else
logErr(FMT.fmt("不存在头发:{0}",hair))
end
end

if face~=nil then
local faceCfg=cfg_disciplefaceimageconfig_get(face)
if faceCfg~=nil then
if faceCfg.in_side~=nil then
for _,cmpID in ipairs(faceCfg.in_side)do
in_side_cmps[#in_side_cmps+1]=cmpID
end
end
else
logErr(FMT.fmt("不存在脸谱:{0}",face))
end
end

if accessory~=nil then
local accessoryCfg=cfg_disciplefaceaccessoryimageconfig_get(accessory)
if accessoryCfg~=nil then
if accessoryCfg.in_side~=nil then
for _,cmpID in ipairs(accessoryCfg.in_side)do
in_side_cmps[#in_side_cmps+1]=cmpID
end
end
else
logErr(FMT.fmt("不存在脸谱配饰:{0}",accessory))
end
end

local bodyCfg=cfg_dbbodyconfig_get(skeletonID)
if bodyCfg~=nil then
local scale=1
if bodyCfg.scales~=nil then
scale=bodyCfg.scales[1]or scale
end
self.discipleModelRoot:setChildUIModelShowTarget(skeletonID,scale,in_side_cmps,0,false,false,-1)
end
if out_side_body~=nil then
local OutbodyCfg=cfg_dbbodyconfig_get(out_side_body)
if OutbodyCfg~=nil then
self.out_side_model:setChildUIModelShowTarget(out_side_body,2,out_side_cmps,0,false,false,-1)
end
else
logErr(FMT.fmt("不存在对应外观小人:{0}",out_side_body))
end
end




