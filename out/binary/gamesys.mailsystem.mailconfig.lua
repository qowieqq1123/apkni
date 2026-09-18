






mailConfig={}


eMailRecvOperType=
{
eInit=0,
eAdd=1,
}


eMailSendOperType=
{
eRead=0,
ePrize=1,
eDelete=2,
}


MAIL_RICH_TEXT_BTN_TYPE=
{
eJump=1,
}


MAIL_RICH_TEXT_BTN_STYLE_IMAGE=
{
[1]={
abName='ui/sharedtextures/uiglobalspriteatlas_1.ab',
btnImg="button_tyanniu_1",
}
}




mailConfig.btnRegex="<#btn;(.*);(.*);(.*);(.*);/>"
mailConfig.btnRegexFormat="<#btn;{0};{1};{2};{3};/>"

function mailConfig.getRichTextBtnStyleParam(style)
if MAIL_RICH_TEXT_BTN_STYLE_IMAGE[style]then
return MAIL_RICH_TEXT_BTN_STYLE_IMAGE[style]
end

return nil
end