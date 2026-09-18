



MYZSSettlementStateEnum={
eDoing=1,
eWait=2,
eStop=3,
eFinish=4,
}

MYZSStageType={
eMerchant=1,
eTreasure=2,
eMonster=3,
eWait=4,
eFinish=5,

transStageType=function(_self,id)
if id==nil then
logErr("trans stage id to type is nil")
return
end

if id<=100 then
return _self.eMerchant
elseif id<=200 then
return _self.eTreasure
else
return _self.eMonster
end
end,
}

MYZSMerchantShopType={
eRecovery=1,
eRevival=2,
eWeapon=3,
}

MYZSInteractionType={
eBuyItem=1,
eSelectBW=2,
}