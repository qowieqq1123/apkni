







local qualityColorFormat={
[eQualityColor.eWhite]='<color=#fff5eb>{0}</color>',
[eQualityColor.eGreen]='<color=#229f00>{0}</color>',
[eQualityColor.eBlue]='<color=#066abd>{0}</color>',
[eQualityColor.ePurple]='<color=#8833e7>{0}</color>',
[eQualityColor.eOrange]='<color=#ba5f00>{0}</color>',
[eQualityColor.eRed]='<color=#c83232>{0}</color>',
[eQualityColor.ePink]='<color=#c63f92>{0}</color>',
}
function helper.getQColorFormat(color)
return qualityColorFormat[color]
end
function helper.getQColorString(color,s)
return FMT.fmt(helper.getQColorFormat(color),s)
end