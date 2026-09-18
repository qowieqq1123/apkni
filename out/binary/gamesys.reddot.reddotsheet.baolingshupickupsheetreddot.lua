






baolingshuPickUpSheetReddot=reddotSheetBase.new({classname='baolingshuPickUpSheetReddot'})

baolingshuPickUpSheetReddot.reddot_type=REDDIT_TYPE.eBLSPickUp

baolingshuPickUpSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sBLSPickUpTarget]=
{
catch={
[CATCH_TYPE.eBLSPickUp]=
{
cnd=function(xxx)
return xxx
end,
},
[CATCH_TYPE.eMoney]=
{
cnd=function(moneytype,value)
return moneytype==xxx and value>1
end,
},
},
func=function(catchType,...)
return baoLingShuModel:checkBLSPickUpTargetReddot()
end,
},
[REDDIT_SUB_TYPE.sBLSPickUpLiBao]=
{
catch={
CATCH_TYPE.eBLSPickUp,
},
func=function(catchType,...)
return baoLingShuModel:checkBLSPickUpLiBaoReddot()
end,
},
[REDDIT_SUB_TYPE.sBLSPickUpShop]=
{
catch={
CATCH_TYPE.eBLSPickUp,
CATCH_TYPE.eMoney,
},
func=function(catchType,...)
return baoLingShuModel:checkBLSPickUpShopReddot()
end,
},
}