local qiyuanshudata=nil
function funcShopModel:clearData_qiyuanshu()
qiyuanshudata=nil
end

function funcShopModel:initData_qiyuanshu()
qiyuanshudata={}
end
function funcShopModel:SetqiyuanshuShop(buyListLen,buyList)
qiyuanshudata={}
if buyListLen>0 then
for k,v in ipairs(buyList)do
local cfg=cfg_qiyuanshopconfig_get(v.buyId)
if cfg.group then

if qiyuanshudata[cfg.group]then
qiyuanshudata[cfg.group]=qiyuanshudata[cfg.group]+v.buyNum
else
qiyuanshudata[cfg.group]=v.buyNum
end

end

end
end
end

function funcShopModel:ChangeqiyuanshuShop(buyId,buyNum)
local cfg=cfg_qiyuanshopconfig_get(buyId)
if cfg.group then
if qiyuanshudata[cfg.group]then
qiyuanshudata[cfg.group]=qiyuanshudata[cfg.group]+buyNum
else
qiyuanshudata[cfg.group]=buyNum
end
end
end

function funcShopModel:GetqiyuanshuShop()
return qiyuanshudata
end


function funcShopModel:qiyuanshu_findNum(buyId)
local cfg=cfg_qiyuanshopconfig_get(buyId)
if cfg.group then
if qiyuanshudata[cfg.group]then
return qiyuanshudata[cfg.group]
else
return 0
end
end
end